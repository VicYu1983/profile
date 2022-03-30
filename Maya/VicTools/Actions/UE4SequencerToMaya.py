# -*- coding:utf-8 -*-
import math, GuiBase, json, os
import maya.cmds as cmds
import maya.mel as mel
import pymel.core as pm
from PySide2.QtGui import *
from PySide2.QtWidgets import *
import JointToController
import Helper

reload(JointToController)
reload(Helper)

def getAnchorNodes():
	anchors = []
	refs = cmds.ls(type='reference')
	for ref in refs:
		if "_UNKNOWN_REF_NODE_" in ref: continue
		if "sharedReferenceNode" in ref: continue
		ns = cmds.referenceQuery(ref, namespace = 1)
		alls = cmds.ls(ns + ":*")
		for node in alls:
			parent = cmds.listRelatives(node, p = True)
			detectName = node.split(":")[1]
			if not parent and "Anchor" in detectName:
				anchors.append(node)
	return anchors

def getAnchorLocation(anchors):
	detector = {}
	for anchor in anchors:
		tx = cmds.getAttr(anchor + ".translateX")
		ty = cmds.getAttr(anchor + ".translateY")    
		tz = cmds.getAttr(anchor + ".translateZ")    
		if "Anchor_Ori" in anchor:
			detector["ori"] = (tx, ty, tz)
		else:
			detector["offset"] = (tx, ty, tz)

	anchorPos = None
	if detector["ori"][0] == 0 and detector["ori"][1] == 0 and detector["ori"][2] == 0:
		anchorPos = ( detector["offset"][0], detector["offset"][1], detector["offset"][2])
	else:
		anchorPos = ( -detector["ori"][0], -detector["ori"][1], -detector["ori"][2])
	return anchorPos

def execute(includeCamera = True):

	global fbxPath, jsonPath
	fbxPath = jsonPath = None

	def fbxCallback(path):
		global fbxPath
		fbxPath = path[0]
	GuiBase.openFileDialog(fbxCallback, QFileDialog.AnyFile, "*.fbx")

	def txtCallback(path):
		global jsonPath
		jsonPath = path[0]
	GuiBase.openFileDialog(txtCallback, QFileDialog.AnyFile, "*.txt")

	if fbxPath and jsonPath:

		
		topNodes = cmds.ls(assemblies=1)[:]
		cameraList = [node for node in topNodes if Helper.isCamera(node)]
		cameraMap = []
		if includeCamera:
			# 因爲會重建所有的shot，所以刪除所有的shot
			cmds.delete(cmds.ls(type='shot'))

			# 因爲會重建所有的camera，所以刪除所有的camera
			cmds.delete(cameraList)
		else:

			# 勾選不導入camera時，流程中還是會導入fbx（因爲所有東西都在fbx中），如果不改名的話，會被匯入的camera覆蓋到動畫
			for camera in cameraList: 
				try:
					cmds.rename(camera, camera + "_tempName")
					cameraMap.append((camera, camera + "_tempName"))
				except: pass

		topNodes = cmds.ls(assemblies=1)[:]
		mel.eval('FBXImport -file "' + fbxPath + '";')

		newTopNodes = cmds.ls(assemblies=1)[:]
		diffset = list(set(newTopNodes) - set(topNodes))

		f = open(jsonPath, "r")
		buildByFBX(f.read(), includeCamera)

		if includeCamera:

			# 因爲動作組希望所有的鏡頭合并為一個，所以加了以下的方法。如果不要合并，就關掉一下這行
			Helper.mergeAllShots(onlyCamera=True)

			# 確保多出來的東西除了merge出來的camera之外，全部刪掉
			for node in diffset: 
				if not Helper.isCamera(node): 
					Helper.deleteNode(node)
		else:

			# 確保多出來的東西全部刪掉
			Helper.deleteNodes(diffset)

			# 把改過名字的攝像機改回來
			for (cam, cam_temp) in cameraMap: 
				cmds.rename( cam_temp, cam )
		
		GuiBase.showMessage(u"完成，請記得儲存!")

def createMappingFile():
	filedir = filepath = os.path.expanduser("~") + '/SequencerToMaya'
	if not os.path.exists(filedir):
		os.makedirs(filedir)
	filepath = os.path.expanduser("~") + '/SequencerToMaya/rigMapping.txt'
	return filepath

def buildByFBX( jsonstr, includeCamera = True ):

	jsonobj = json.loads(jsonstr)
	allRoles = jsonobj['allRoles']

	global rigFile
	rigFile = {}

	# 讀取map檔案
	mapFile = createMappingFile()
	if os.path.exists( mapFile ):
		f = open(mapFile, "r")
		try:
			rigFile = json.loads(f.read())
		except: pass
	
	# 沒有在map檔案裏的角色就要指定rig檔
	for role in allRoles:
		name = role['name']
		name = name.replace(" ", "_")
		if name in rigFile: continue
		clazz = role['className']
		isSkeleton = ('Autobot' in clazz) or ('SkeletalMeshActor' in clazz)
		if isSkeleton:
			def saveRigFile(path):
				global rigFile
				rigFile[name] = path[0], clazz
			GuiBase.openFileDialog(saveRigFile, QFileDialog.AnyFile, "%s(*.ma)" % name)

	# 儲存map檔
	f = open(mapFile, "w")
	f.write(json.dumps(rigFile, indent=4))
	f.close()
	
	# 創建director
	if includeCamera:
		directors = jsonobj['directors']
		for director in directors:
			name = director['name']
			name = name.replace(" ", "_")
			start = director['start']
			end = director['end']-1
			cmds.shot(name, sn=name, cc=name, st=start, sst=start, et=end, set=end, trk=1)

	# 根據anchor調整成在場景中間表演的坐標
	anchors = getAnchorNodes()
	locator = None
	if len(anchors) > 0:
		locator = cmds.spaceLocator()[0]
		(anchorX, anchorY, anchorZ) = getAnchorLocation(anchors)

		for role in allRoles:
			node = role['name']
			clazz = role['className']
			if clazz == "CineCameraActor" or clazz == "StaticMeshActor":
				try:
					cmds.keyframe(node, at="translateX", edit=1,relative=1,valueChange=-anchorX)
					cmds.keyframe(node, at="translateY", edit=1,relative=1,valueChange=-anchorY)
					cmds.keyframe(node, at="translateZ", edit=1,relative=1,valueChange=-anchorZ)
				except: pass

		for node in rigFile:
			try:
				cmds.parent( node, locator)
			except: continue

		cmds.setAttr(locator + ".translateX", -anchorX)
		cmds.setAttr(locator + ".translateY", -anchorY)
		cmds.setAttr(locator + ".translateZ", -anchorZ) 

	# 在bake前先整理一下檔案，把坐標因爲在ue4的bp做過轉換的轉回來，并且把不要的物件刪除
	for node in rigFile:
		if len(cmds.ls(node)) != 1: continue

		Helper.deleteNode( node + "|RightHand ")
		Helper.deleteNode( node + "|Legend ")
		Helper.deleteNode( node + "|Face ")
		Helper.deleteNode( node + "|Cap ")

		path, clazz = rigFile[node]
		if clazz != "SkeletalMeshActor" and not cmds.objExists( node + "|Mesh|root"):
			role_locator = cmds.spaceLocator()[0]
			cmds.parent( role_locator, node )
			cmds.setAttr( role_locator + ".translateX", 0 )
			cmds.setAttr( role_locator + ".translateY", 0 )
			cmds.setAttr( role_locator + ".translateZ", 0 )
			cmds.setAttr( role_locator + ".rotateZ", 0 )
			cmds.parent( node + "|root", role_locator )
			cmds.setAttr( role_locator + ".rotateZ", 90 ) 

	
	# 開始bake
	cmds.evaluationManager( mode="off" )

	for node in rigFile:
		if len(cmds.ls(node)) != 1: continue

		path, clazz = rigFile[node]
		ns = node

		# 這邊要改名的原因是因爲之后要用到這個名字
		node = cmds.rename(node, ns + "_temp")

		# 把動作的骨架調整成我們要的格式（要有namespace的格式）
		fbx_ns = ns + "_fbx"
		cmds.namespace( add=fbx_ns )
		
		childs = cmds.listRelatives(node, ad=1)
		childs_pm = pm.listRelatives(node, ad=1)
		for child, child_pm in zip(childs, childs_pm ):
			cmds.rename( child_pm.name(), "%s:%s" % (fbx_ns, child))

		if path:
			cmds.file( path, r=1, ns=ns)
			(backMethod, extraMethod) = JointToController.genMapAndMatchFKIK(fbx_ns, ns)

			start = 0
			end = int(cmds.playbackOptions(q=True, aet=True))

			for i in range(start, end, 1): backMethod(i)
			
			try: extraMethod()
			except: pass

			cmds.delete(node)
		Helper.forceDeleteNamespace(fbx_ns)

	if locator: cmds.delete( locator )

	cmds.evaluationManager( mode="parallel" )

	Helper.fixEulerCurve()

	
