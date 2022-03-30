# -*- coding: utf-8 -*-
# 針對Advanced Skeleton Motion Data import 作業
# Last Modified 2015/07/29
# Author Chih Lun Kang


import maya.cmds as cmds
import maya.mel as mel
import sys,os,re
import maya.OpenMaya as om
import maya.OpenMayaAnim as omAnim
import maya.OpenMayaMPx as OpenMayaMPx
import MatrixSwitchAxis as maxs
from collections import OrderedDict
import time
try:import clr 
except:pass

if(clr):
	clr.AddReference("System")
	clr.AddReference("System.Windows.Forms")
	import System
	import System.Windows.Forms

# mocap 到 FK 
mcToFKNmPar = [
["Hip_MoCap_L","FKHip_L"],
["Knee_MoCap_L","FKKnee_L"],
["Ankle_MoCap_L","FKAnkle_L"],
["Toes_MoCap_L","FKToes_L"],

["Hip_MoCap_R","FKHip_R"],
["Knee_MoCap_R","FKKnee_R"],
["Ankle_MoCap_R","FKAnkle_R"],
["Toes_MoCap_R","FKToes_R"],

["Spine1_MoCap_M","FKSpine1_M"],
["Spine2_MoCap_M","FKSpine2_M"],
["Spine3_MoCap_M","FKSpine3_M"],
#["Spine4_MoCap_M","FKSpine4_M"],
["Chest_MoCap_M","FKChest_M"],
["Neck_MoCap_M","FKNeck_M"],
["Head_MoCap_M","FKHead_M"],

["Scapula_MoCap_L","FKScapula_L"],
["Shoulder_MoCap_L","FKShoulder_L"],
["Elbow_MoCap_L","FKElbow_L"],
["Wrist_MoCap_L","FKWrist_L"],

["Scapula_MoCap_R","FKScapula_R"],
["Shoulder_MoCap_R","FKShoulder_R"],
["Elbow_MoCap_R","FKElbow_R"],
["Wrist_MoCap_R","FKWrist_R"],
]

# mocap 到 IK ，"_x" 是我另外增加的 Locator
mcToIKNmPar = [
["Ankle_MoCap_L","IKLeg_L"],
["L_LegMocapPole_x","PoleLeg_L"],
["Ankle_MoCap_R","IKLeg_R"],
["R_LegMocapPole_x","PoleLeg_R"],
["Wrist_MoCap_L","IKArm_L"],
["L_ElbowMocapPole_x","PoleArm_L"],
["Wrist_MoCap_R","IKArm_R"],
["R_ElbowMocapPole_x","PoleArm_R"],
["Chest_MoCap_M","IKSpine2_M"]
]

# 定位用的PoleV名稱
poleVectNameArr =[
#["IKXKnee_L","PoleLeg_L","Knee_MoCap_L","L_LegMocapPole_x","Hip_MoCap_L","Ankle_MoCap_L"],
["IKXElbow_L","PoleArm_L","Elbow_MoCap_L","L_ElbowMocapPole_x","Shoulder_MoCap_L","Wrist_MoCap_L"],
#["IKXKnee_R","PoleLeg_R","Knee_MoCap_R","R_LegMocapPole_x","Hip_MoCap_R","Ankle_MoCap_R"],
["IKXElbow_R","PoleArm_R","Elbow_MoCap_R","R_ElbowMocapPole_x","Shoulder_MoCap_R","Wrist_MoCap_R"]
]

mcToSkNameArr=[
["Root_M","Root_MoCap_M"],
["Spine1_M","Spine1_MoCap_M"],
["Spine2_M","Spine2_MoCap_M"],
["Spine3_M","Spine3_MoCap_M"],
#["Spine3_M","Spine4_MoCap_M"],
["Scapula_L","Scapula_MoCap_L"],
["Scapula_R","Scapula_MoCap_R"],
["Elbow_L","Elbow_MoCap_L"],
["Elbow_R","Elbow_MoCap_R"],
#["Hip_L","Hip_MoCap_L"],
#["Hip_R","Hip_MoCap_R"],
#["Knee_L","Knee_MoCap_L"],
#["Knee_R","Knee_MoCap_R"],
#["Ankle_L","Ankle_MoCap_L"],
#["Ankle_R","Ankle_MoCap_R"],
["Shoulder_L","Shoulder_MoCap_L"],
["Shoulder_R","Shoulder_MoCap_R"],
["Wrist_L","Wrist_MoCap_L"],
["Wrist_R","Wrist_MoCap_R"],
["Neck_M","Neck_MoCap_M"],
["Head_M","Head_MoCap_M"],
]


## 所有手指 名稱對應表，因為手指沒有要求對方做 Chararterize 
## 直接用parent constraint
allFingersArr =[
["ThumbFinger1_L","FKThumbFinger1_L"],
["ThumbFinger2_L","FKThumbFinger2_L"],
["ThumbFinger3_L","FKThumbFinger3_L"],

["IndexFinger1_L","FKIndexFinger1_L"],
["IndexFinger2_L","FKIndexFinger2_L"],
["IndexFinger3_L","FKIndexFinger3_L"],

["MiddleFinger1_L","FKMiddleFinger1_L"],
["MiddleFinger2_L","FKMiddleFinger2_L"],
["MiddleFinger3_L","FKMiddleFinger3_L"],

["RingFinger1_L","FKRingFinger1_L"],
["RingFinger2_L","FKRingFinger2_L"],
["RingFinger3_L","FKRingFinger3_L"],

["Cup_L","FKCup_L"],

["PinkyFinger1_L","FKPinkyFinger1_L"],
["PinkyFinger2_L","FKPinkyFinger2_L"],
["PinkyFinger3_L","FKPinkyFinger3_L"],

["ThumbFinger1_R","FKThumbFinger1_R"],
["ThumbFinger2_R","FKThumbFinger2_R"],
["ThumbFinger3_R","FKThumbFinger3_R"],

["IndexFinger1_R","FKIndexFinger1_R"],
["IndexFinger2_R","FKIndexFinger2_R"],
["IndexFinger3_R","FKIndexFinger3_R"],

["MiddleFinger1_R","FKMiddleFinger1_R"],
["MiddleFinger2_R","FKMiddleFinger2_R"],
["MiddleFinger3_R","FKMiddleFinger3_R"],

["RingFinger1_R","FKRingFinger1_R"],
["RingFinger2_R","FKRingFinger2_R"],
["RingFinger3_R","FKRingFinger3_R"],

["Cup_R","FKCup_R"],

["PinkyFinger1_R","FKPinkyFinger1_R"],
["PinkyFinger2_R","FKPinkyFinger2_R"],
["PinkyFinger3_R","FKPinkyFinger3_R"]
]

def getAllObjects():
	allDag = []
	 
	allList = cmds.ls(dag=True)
	#refList = cmds.ls(dag=True, readOnly=True)
	rmv_a = cmds.ls(typ="camera")
	rmv_b = ["persp", "top", "front", "side"]
	objList = list(set(allList) - set(rmv_a) - set(rmv_b)) #- set(refList)

	# Collection all "dag obj" Name
	for obj in objList:
		allDag.append(obj)
			
	return allDag

def getShapes(objList,objWithShpList,_type="mesh",bGetHidden=False):# 預設隱藏物件不予處理
	resultList = []
	for obj in objList:
		if cmds.nodeType(obj) == "transform":
			bProcess=True
			root = (cmds.ls(obj,l=True)[0]).split('|')[1]
			if(not bGetHidden):
				# 階層中只要有任意一個parent .visibility 是關閉就是隱藏
				hieArr = (cmds.ls(obj,l=True)[0]).split('|')
				for oo in hieArr:
					if(cmds.objExists(oo)):
						if(not cmds.getAttr(oo+".visibility")):
							bProcess=False
			if(bProcess):
				buffers = cmds.listRelatives(obj, fullPath=True, shapes=True)
				if buffers != None and cmds.nodeType(buffers[0]) == _type:
					objWithShpList.append(obj)
					resultList.append(buffers[0])

	return resultList

def getSceneSkelMeshs():
	sceneSkelMesh = []
	allObj = []
	objList = getShapes(getAllObjects(),allObj,_type="mesh",bGetHidden=True)
	for k in range(0,len(allObj)): #k=2
		# 檢查是否已有上skin
		geo = allObj[k]
		objEntry = objList[k]
		buffers = cmds.listHistory(objEntry)
		for buffer in buffers:
			if cmds.nodeType(buffer) == "skinCluster": # 是skelMesh
				sceneSkelMesh.append(geo)
	return sceneSkelMesh


def CreateAsMoCapSk(charname=""): # charname = rgnsp
	cmds.select( charname+":Root_M" )
	bindsk = cmds.duplicate(rr=False)
	bindRoot = bindsk[0]
	cmds.parent(bindRoot,w=True)

	for jnt in bindsk: # jnt = bindsk[1]
		if('_'in jnt):
			nspl = jnt.split('_')
			nwName = nspl[0]+'_MoCap_'+nspl[1]
			cmds.rename(jnt,nwName)
		else:
			nwName = jnt +'_MoCap_'
			cmds.rename(jnt,nwName)


def gotoFBXBindPose(toolroot=""):
	mel.eval('HIKCharacterControlsTool;')
	melcmdstr = 'if (!`pluginInfo -q -l "mayaHIK"`)\n'
	melcmdstr += '{ \n'
	melcmdstr += 'loadPlugin "mayaHIK";'
	melcmdstr += '} \n'
	melcmdstr += 'if (!`pluginInfo -q -l "mayaCharacterization"`) \n'
	melcmdstr += '{ \n'
	melcmdstr += 'loadPlugin "mayaCharacterization"; \n'
	melcmdstr += '} \n'
	melcmdstr += 'if (!`pluginInfo -q -l "OneClick"`) \n'
	melcmdstr += '{ \n'
	melcmdstr += 'loadPlugin "OneClick"; \n'
	melcmdstr += '} \n'
	melcmdstr += 'hikCreateCharacterControlsDockableWindow;'
	mel.eval(melcmdstr)
	
	_string = 'source "'+toolroot+'HIKUpdCurrentSourceFromUI.mel"'
	mel.eval(_string)
	charname = "Character"
	charArr = cmds.ls(type="HIKCharacterNode")
	if ( len(charArr)):
		charname = charArr[0]
	mel.eval('hikUpdCurrentCharacterFromUI("'+charname+'");')
	mel.eval('hikUpdCurrentSourceFromUI("Stance");')
	mel.eval('hikUpdateContextualUI();')
	
	return charname

def getFBXCharName():
	charname = ""
	alljnts = cmds.ls(typ = "joint")
	fbxroot = None
	for jnt in alljnts:
		if("root" in jnt):
			bRef = cmds.referenceQuery(jnt,isNodeReferenced=True)
			if(not bRef):
				fbxroot = jnt
	if(":" in fbxroot):
		charname = fbxroot.split(':')[0]
	return charname

def snapMocapSkToFBXLocation(charname=""): # charname = rgnsp
	#mcToSkNameArr=[
	#	["Root_M","Root_MoCap_M"],
	#	["Spine1_M","Spine1_MoCap_M"],
	# Get Namespcace of imported fbx
	
	_fbxCharName = getFBXCharName()
	for k in range(0,len(mcToSkNameArr)): # k = 13
		tgtName = _fbxCharName +":"+mcToSkNameArr[k][0]
		if(len(_fbxCharName ) == 0):
			tgtName = mcToSkNameArr[k][0]
		if(not cmds.objExists(tgtName)):continue
		tr = cmds.xform(tgtName , q=True , t=True,ws=True)
		cmds.xform(mcToSkNameArr[k][1],t=tr,ws=True)
	
	for k in range(0,len(allFingersArr)): # k = 1
		fbxCtrlName = _fbxCharName+":"+allFingersArr[k][0]
		if(len(_fbxCharName) <1):
			fbxCtrlName = allFingersArr[k][0]
		if(not cmds.objExists(fbxCtrlName)):continue
		tr = cmds.xform(fbxCtrlName , q=True , t=True,ws=True)
		cmds.xform(charname+":"+allFingersArr[k][1],t=tr,ws=True)
		
		_ro = cmds.xform(fbxCtrlName , q=True , ro=True,ws=True)
		cmds.xform(charname+":"+allFingersArr[k][1],ro=_ro ,ws=True)

def gotoFBXMotionPose(charDef):
	mel.eval('hikEnableCharacter( "'+charDef+'", 2 );')
	# 更新動作讓mocap回到初始張
	tmin = int(cmds.playbackOptions(q=True,minTime=True))
	cmds.currentTime(tmin+1)
	cmds.currentTime(tmin)


def createHIKMapping(charDef,toolroot=""): # charDef = charDefNameFbx 
	mel.eval('hikCreateDefinition()')
	mel.eval( 'setCharacterObject("Root_MoCap_M","Character1",1,0);')
	mel.eval( 'setCharacterObject("Spine1_MoCap_M","Character1",8,0);')
	mel.eval( 'setCharacterObject("Spine2_MoCap_M","Character1",23,0);')
	mel.eval( 'setCharacterObject("Spine3_MoCap_M","Character1",24,0);')
	#mel.eval( 'setCharacterObject("Spine4_MoCap_M","Character1",25,0);')
	mel.eval( 'setCharacterObject("Chest_MoCap_M","Character1",25,0);')
	mel.eval( 'setCharacterObject("Scapula_MoCap_L","Character1",18,0);')
	mel.eval( 'setCharacterObject("Scapula_MoCap_R","Character1",19,0);')
	mel.eval( 'setCharacterObject("Elbow_MoCap_L","Character1",10,0);')
	mel.eval( 'setCharacterObject("Elbow_MoCap_R","Character1",13,0);')

	#if(cmds.objExists("Hip_MoCap_L")): # CHANGED
	mel.eval( 'setCharacterObject("FinTail1_MoCap_L","Character1",2,0);')
	#if(cmds.objExists("Hip_MoCap_R")): # CHANGED
	mel.eval( 'setCharacterObject("FinTail1_MoCap_R","Character1",5,0);')
	#if(cmds.objExists("Knee_MoCap_L")): # CHANGED
	mel.eval( 'setCharacterObject("FinTail2_MoCap_L","Character1",3,0);')
	#if(cmds.objExists("Knee_MoCap_R")): # CHANGED
	mel.eval( 'setCharacterObject("FinTail2_MoCap_R","Character1",6,0);')
	#if(cmds.objExists("Ankle_MoCap_L")): # CHANGED
	mel.eval( 'setCharacterObject("FinTail3_MoCap_L","Character1",4,0);')
	#if(cmds.objExists("Ankle_MoCap_R")):# CHANGED
	mel.eval( 'setCharacterObject("FinTail3_MoCap_R","Character1",7,0);')

	mel.eval( 'setCharacterObject("Shoulder_MoCap_L","Character1",9,0);')
	mel.eval( 'setCharacterObject("Shoulder_MoCap_R","Character1",12,0);')
	mel.eval( 'setCharacterObject("Wrist_MoCap_L","Character1",11,0);')
	mel.eval( 'setCharacterObject("Wrist_MoCap_R","Character1",14,0);')
	mel.eval( 'setCharacterObject("Neck_MoCap_M","Character1",20,0);')
	mel.eval( 'setCharacterObject("Head_MoCap_M","Character1",15,0);')
	
	_string = 'source "'+toolroot+'HIKUpdCurrentSourceFromUI.mel"'
	mel.eval(_string)
	mel.eval('hikUpdCurrentCharacterFromUI("Character1");')
	mel.eval('hikUpdCurrentSourceFromUI("'+charDef+'");')
	mel.eval('hikUpdateContextualUI();')



# 生成定位用的PoleV ，黏到Mocap 骨架上對位用
def createPoleMocapLoc(charname,plArr): # plArr =poleVectNameArr charname=rgnsp
	for pl in plArr: # pl = plArr[1]
		v1Name = charname+":"+pl[0]
		v2Name = charname+":"+pl[1]
		if(not cmds.objExists(v1Name)):continue
		if(not cmds.objExists(v2Name)):continue
		
		_v1 = cmds.xform(v1Name,q=True,ws=True,t=True)
		_v1om = om.MVector(_v1[0] ,_v1[1],_v1[2])
		_v2 = cmds.xform(v2Name,q=True,ws=True,t=True)
		_v2om = om.MVector(_v2[0] ,_v2[1],_v2[2])
		ikdir = _v2om-_v1om
		
		_v3 = cmds.xform(pl[2],q=True,ws=True,t=True)
		_v3om = om.MVector(_v3[0] ,_v3[1],_v3[2])
		newLoc = _v3om + ikdir 
		newLocNd = cmds.spaceLocator()
		cmds.rename(newLocNd,pl[3])
		cmds.xform(pl[3],ws=True,t=(newLoc.x,newLoc.y,newLoc.z))


# 計算新的手肘位置，並setkey
# New Elbow location setup with built-in nodes
def setElbowNewPoleLocation(startNd,midNd,endNd,elbowNd): 
	if(not cmds.objExists(startNd)):return
	if(not cmds.objExists(midNd)):return
	if(not cmds.objExists(endNd)):return
	if(not cmds.objExists(elbowNd)):return
	cmds.loadPlugin("matrixNodes")
	calcNodeCol = []
	# ########################### #
	# 	Decompose to Vector 	  #
	# ########################### #
	decompStart = cmds.createNode('decomposeMatrix')
	cmds.connectAttr( startNd+'.worldMatrix',decompStart+'.inputMatrix')
	decompMid = cmds.createNode('decomposeMatrix')
	cmds.connectAttr( midNd+'.worldMatrix',decompMid+'.inputMatrix')
	decompEnd = cmds.createNode('decomposeMatrix')
	cmds.connectAttr( endNd+'.worldMatrix',decompEnd+'.inputMatrix')
	
	calcNodeCol.append(decompStart)
	calcNodeCol.append(decompMid)
	calcNodeCol.append(decompEnd)

	# ########################### #
	# 	vector start to end 	  #
	# ########################### #
	plusMinus_StartEnd = cmds.createNode('plusMinusAverage')
	# set operation to minus
	cmds.setAttr(plusMinus_StartEnd+'.op',2) 
	mel.eval('catchQuiet(`getAttr -type '+plusMinus_StartEnd+'.input3D[0]`);')
	mel.eval('catchQuiet(`getAttr -type '+plusMinus_StartEnd+'.input3D[1]`);')
	# First term -> end
	cmds.connectAttr(decompEnd+'.outputTranslateX',plusMinus_StartEnd+".input3D[0].input3Dx")
	cmds.connectAttr(decompEnd+'.outputTranslateY',plusMinus_StartEnd+".input3D[0].input3Dy")
	cmds.connectAttr(decompEnd+'.outputTranslateZ',plusMinus_StartEnd+".input3D[0].input3Dz")
	# Second term -> start
	cmds.connectAttr(decompStart+'.outputTranslateX',plusMinus_StartEnd+".input3D[1].input3Dx")
	cmds.connectAttr(decompStart+'.outputTranslateY',plusMinus_StartEnd+".input3D[1].input3Dy")
	cmds.connectAttr(decompStart+'.outputTranslateZ',plusMinus_StartEnd+".input3D[1].input3Dz")
	
	calcNodeCol.append(plusMinus_StartEnd)

	# ########################### #
	# 	vector start to mid 	  #
	# ########################### #
	plusMinus_StartMid = cmds.createNode('plusMinusAverage')
	# set operation to minus
	cmds.setAttr(plusMinus_StartMid +'.op',2) 
	mel.eval('catchQuiet(`getAttr -type '+plusMinus_StartMid +'.input3D[0]`);')
	mel.eval('catchQuiet(`getAttr -type '+plusMinus_StartMid +'.input3D[1]`);')
	# First term -> end
	cmds.connectAttr(decompMid+'.outputTranslateX',plusMinus_StartMid +".input3D[0].input3Dx")
	cmds.connectAttr(decompMid+'.outputTranslateY',plusMinus_StartMid +".input3D[0].input3Dy")
	cmds.connectAttr(decompMid+'.outputTranslateZ',plusMinus_StartMid +".input3D[0].input3Dz")
	# Second term -> start
	cmds.connectAttr(decompStart+'.outputTranslateX',plusMinus_StartMid +".input3D[1].input3Dx")
	cmds.connectAttr(decompStart+'.outputTranslateY',plusMinus_StartMid +".input3D[1].input3Dy")
	cmds.connectAttr(decompStart+'.outputTranslateZ',plusMinus_StartMid +".input3D[1].input3Dz")
	
	calcNodeCol.append(plusMinus_StartMid)

	# ########################### #
	# 			dot P			  #
	# ########################### #
	dotPvectorProduct = cmds.createNode('vectorProduct') #cmds.listAttr(dotPvectorProduct) cmds.getAttr(dotPvectorProduct+'.outputX')
	# cmds.listAttr(plusMinus_StartMid)
	cmds.connectAttr(plusMinus_StartMid +'.output3Dx',dotPvectorProduct +".input1X")
	cmds.connectAttr(plusMinus_StartMid +'.output3Dy',dotPvectorProduct +".input1Y")
	cmds.connectAttr(plusMinus_StartMid +'.output3Dz',dotPvectorProduct +".input1Z")

	cmds.connectAttr(plusMinus_StartEnd +'.output3Dx',dotPvectorProduct +".input2X")
	cmds.connectAttr(plusMinus_StartEnd +'.output3Dy',dotPvectorProduct +".input2Y")
	cmds.connectAttr(plusMinus_StartEnd +'.output3Dz',dotPvectorProduct +".input2Z")

	calcNodeCol.append(dotPvectorProduct)
	
	# ########################### #
	# 			proj			  #
	# ########################### #
	dis_StartEnd = cmds.createNode('distanceBetween')#cmds.listAttr(dis_StartEnd)
	cmds.connectAttr(decompEnd+'.outputTranslateX',dis_StartEnd +".point1X")
	cmds.connectAttr(decompEnd+'.outputTranslateY',dis_StartEnd +".point1Y")
	cmds.connectAttr(decompEnd+'.outputTranslateZ',dis_StartEnd +".point1Z")
	cmds.connectAttr(decompStart+'.outputTranslateX',dis_StartEnd +".point2X")
	cmds.connectAttr(decompStart+'.outputTranslateY',dis_StartEnd +".point2Y")
	cmds.connectAttr(decompStart+'.outputTranslateZ',dis_StartEnd +".point2Z")

	divide_proj = cmds.createNode('multiplyDivide')#cmds.listAttr(divide_proj)
	cmds.setAttr( divide_proj + '.operation', 2) # set to divide
	cmds.connectAttr(dotPvectorProduct+'.outputX',divide_proj +".input1X")
	cmds.connectAttr(dis_StartEnd+'.distance',divide_proj +".input2X")
	
	calcNodeCol.append(dis_StartEnd)
	calcNodeCol.append(divide_proj)

	# ########################### #
	# 			startEndN		  #
	# ########################### #
	normalizeStartEndN = cmds.createNode('vectorProduct') #cmds.listAttr(normalizeStartEndN)
	cmds.setAttr(normalizeStartEndN+'.operation',0)
	cmds.setAttr(normalizeStartEndN+'.normalizeOutput',1)
	cmds.connectAttr(plusMinus_StartEnd +'.output3Dx',normalizeStartEndN +".input1X")
	cmds.connectAttr(plusMinus_StartEnd +'.output3Dy',normalizeStartEndN +".input1Y")
	cmds.connectAttr(plusMinus_StartEnd +'.output3Dz',normalizeStartEndN +".input1Z")
	#cmds.getAttr(normalizeStartEndN+'.outputX')

	calcNodeCol.append(normalizeStartEndN)

	# ########################### #
	# 			projV			  #
	# ########################### #
	Mult_projV = cmds.createNode('multiplyDivide')
	cmds.connectAttr(normalizeStartEndN+'.outputX',Mult_projV +".input1X")
	cmds.connectAttr(normalizeStartEndN+'.outputY',Mult_projV +".input1Y")
	cmds.connectAttr(normalizeStartEndN+'.outputZ',Mult_projV +".input1Z")

	cmds.connectAttr(divide_proj+'.outputX',Mult_projV +".input2X") 
	cmds.connectAttr(divide_proj+'.outputX',Mult_projV +".input2Y")
	cmds.connectAttr(divide_proj+'.outputX',Mult_projV +".input2Z")

	calcNodeCol.append(Mult_projV)
	
	# ########################### #
	# 			arrowV			  #
	# ########################### #
	plusMinus_arrowV = cmds.createNode('plusMinusAverage')
	cmds.setAttr(plusMinus_arrowV +'.op',2) 
	mel.eval('catchQuiet(`getAttr -type '+plusMinus_arrowV +'.input3D[0]`);')
	mel.eval('catchQuiet(`getAttr -type '+plusMinus_arrowV +'.input3D[1]`);')
	# First term -> end
	cmds.connectAttr(plusMinus_StartMid +'.output3Dx',plusMinus_arrowV +".input3D[0].input3Dx")
	cmds.connectAttr(plusMinus_StartMid +'.output3Dy',plusMinus_arrowV +".input3D[0].input3Dy")
	cmds.connectAttr(plusMinus_StartMid +'.output3Dz',plusMinus_arrowV +".input3D[0].input3Dz")
	# Second term -> Mult_projV
	cmds.connectAttr(Mult_projV+'.outputX',plusMinus_arrowV +".input3D[1].input3Dx")
	cmds.connectAttr(Mult_projV+'.outputY',plusMinus_arrowV +".input3D[1].input3Dy")
	cmds.connectAttr(Mult_projV+'.outputZ',plusMinus_arrowV +".input3D[1].input3Dz")

	calcNodeCol.append(plusMinus_arrowV)
	
	Mult_ArrowV = cmds.createNode('multiplyDivide')
	cmds.connectAttr(plusMinus_arrowV+'.output3Dx',Mult_ArrowV +".input1X")
	cmds.connectAttr(plusMinus_arrowV+'.output3Dy',Mult_ArrowV +".input1Y")
	cmds.connectAttr(plusMinus_arrowV+'.output3Dz',Mult_ArrowV +".input1Z")
	cmds.setAttr(Mult_ArrowV+".input2X",0.5)
	cmds.setAttr(Mult_ArrowV+".input2Y",0.5)
	cmds.setAttr(Mult_ArrowV+".input2Z",0.5)

	calcNodeCol.append(Mult_ArrowV)
	
	# ########################### #
	# 			FinalV			  #
	# ########################### #
	plusMinus_finalV = cmds.createNode('plusMinusAverage')
	cmds.setAttr(plusMinus_finalV +'.op',1) 
	mel.eval('catchQuiet(`getAttr -type '+plusMinus_finalV +'.input3D[0]`);')
	mel.eval('catchQuiet(`getAttr -type '+plusMinus_finalV +'.input3D[1]`);')
	
	cmds.connectAttr(Mult_ArrowV +'.outputX',plusMinus_finalV +".input3D[0].input3Dx")
	cmds.connectAttr(Mult_ArrowV +'.outputY',plusMinus_finalV +".input3D[0].input3Dy")
	cmds.connectAttr(Mult_ArrowV +'.outputZ',plusMinus_finalV +".input3D[0].input3Dz")

	cmds.connectAttr(decompMid+'.outputTranslateX',plusMinus_finalV +".input3D[1].input3Dx")
	cmds.connectAttr(decompMid+'.outputTranslateY',plusMinus_finalV +".input3D[1].input3Dy")
	cmds.connectAttr(decompMid+'.outputTranslateZ',plusMinus_finalV +".input3D[1].input3Dz")
	
	calcNodeCol.append(plusMinus_finalV)
	
	## connect the result
	cmds.connectAttr(plusMinus_finalV+".output3Dx",elbowNd+'.translateX')
	cmds.connectAttr(plusMinus_finalV+".output3Dy",elbowNd+'.translateY')
	cmds.connectAttr(plusMinus_finalV+".output3Dz",elbowNd+'.translateZ')
	
	return calcNodeCol

# 每個frame推移更新動畫求出新的手肘位置
def setPoleLocKeys(polIKNodes,refFbxNodes): # polIKNodes=toCalcNode,refFbxNodes=refFbxNodes
	coNodes = []
	for p in range(len(polIKNodes)): # p = 1
		nds = setElbowNewPoleLocation(refFbxNodes[p][0],refFbxNodes[p][1],refFbxNodes[p][2],polIKNodes[p])
		coNodes += nds
	return coNodes


# 初始化控制器綁定到mocap sk 上
def snapIKFKCtrlToMo(charName=""): # charName = rgnsp
	# Pole 生成並設定新位置
	createPoleMocapLoc(charName,poleVectNameArr)
	
	constNameArr=[]
	_HipFKCtrlo = cmds.parentConstraint("Root_MoCap_M",charName+":RootX_M",mo=True)
	#_HipFKCtrlp = cmds.pointConstraint("Root_MoCap_M",charName+":RootX_M")
	#_HipFKCtrlo = cmds.orientConstraint("Root_MoCap_M",charName+":RootX_M",mo=True)
	
	## FK Constraint
	for k in range(0,len(mcToFKNmPar)): # k = 1
		if(not cmds.objExists(charName+":"+mcToFKNmPar[k][1])):continue
		if(not cmds.objExists(mcToFKNmPar[k][0])):continue
		_Ctrl = cmds.parentConstraint(mcToFKNmPar[k][0], charName+":"+mcToFKNmPar[k][1],mo=True)#,st="none"
		#_Ctrl = cmds.orientConstraint(mcToFKNmPar[k][0], charName+":"+mcToFKNmPar[k][1])
		constNameArr.append(_Ctrl)
	# 加入等下要刪除的清單內
	#constNameArr.append(_HipFKCtrlp)
	constNameArr.append(_HipFKCtrlo)
	

	## IK Constraint
	for k in range(0,len(mcToIKNmPar)): #k=1
		if(not cmds.objExists(mcToIKNmPar[k][0])):continue
		if(not cmds.objExists(charName+":"+mcToIKNmPar[k][1])):continue
		_pCtrl = cmds.pointConstraint(mcToIKNmPar[k][0],charName+":"+mcToIKNmPar[k][1])
		constNameArr.append(_pCtrl)
		_oCtrl = None
		try:
			_oCtrl = cmds.orientConstraint(mcToIKNmPar[k][0],charName+":"+mcToIKNmPar[k][1],mo=True)
		except:pass
		if(_oCtrl):
			constNameArr.append(_oCtrl)
	return constNameArr


def doFingerConstraint(constNameArr,charname): # charname = "PL_1001a_rig"
	_fbxCharName = getFBXCharName()
	for k in range(0,len(allFingersArr)): # k = 1
		fbxCtrlName = _fbxCharName+":"+allFingersArr[k][0]
		if(len(_fbxCharName) <1):
			fbxCtrlName = allFingersArr[k][0]
		_Ctrl = cmds.parentConstraint(fbxCtrlName,charname+":"+allFingersArr[k][1],mo=True) #,st="none"
		constNameArr.append(_Ctrl)



## Back Mocap 動作到兩組(FK/IK)控制器上
def bakeCtrlAnim(constNameArr,charName=""): # constNameArr = consNameAr,charName = rgnsp
	# Back 工作
	setPoleLocKeys(charName,poleVectNameArr)
	# FK 要Back的 Node 
	NdToBake = [charName+":RootX_M"]
	for nds in mcToFKNmPar: # nds=mcToFKNmPar[1]
		if(cmds.objExists(charName+":"+nds[1])):
			NdToBake.append(charName+":"+nds[1])
	for nds in mcToIKNmPar:
		if(cmds.objExists(charName+":"+nds[1])):
			NdToBake.append(charName+":"+nds[1])
	# 手指 bake
	for nds in allFingersArr:
		if(cmds.objExists(charName+":"+nds[1])):
			NdToBake.append(charName+":"+nds[1])
	
	minStr = str(int(cmds.playbackOptions(q=True,minTime=True)))
	maxStr = str(int(cmds.playbackOptions(q=True,maxTime=True)))

	cmds.bakeResults( NdToBake, t=(minStr,maxStr), sampleBy=1,simulation=True,
					 )
	'''disableImplicitControl=True,preserveOutsideKeys=True,
					 sparseAnimCurveBake=False,
					 bakeOnOverrideLayer=False,
					 controlPoints=False,shape=True'''
	#minimizeRotation=True
	#removeBakedAttributeFromLayer=False,
	#removeBakedAnimFromLayer=True,
	# Back 完成後刪除不需要的東西
	try:cmds.delete("Root_M")
	except:pass
	try:cmds.delete( getFBXCharName() + ":Ref")
	except:pass
	try:cmds.delete("Root_MoCap_M")
	except:pass
	try:
		cmds.delete("L_LegMocapPole_x")
		cmds.delete("L_ElbowMocapPole_x")
		cmds.delete("R_LegMocapPole_x")
		cmds.delete("R_ElbowMocapPole_x")
		cmds.delete("root")
		cmds.delete(constNameArr)
	except:pass
	charArr = cmds.ls(type="HIKCharacterNode")
	if (len(charArr)):
		cmds.delete(charArr)
	
	# Apply All Scene Euler Filter
	rotcurves = cmds.ls(type="animCurveTA")
	for r in range (0,len(rotcurves)/3): #r=1
		cmds.filterCurve( rotcurves[3*r] , rotcurves[3*r+1] , rotcurves[3*r+2] )
	
	try:
		# 頭部的 global channel 不要有key
		hdctrlsnm = ["FKHead_M"]
		hdCtrl = findControls(hdctrlsnm)[0]
		cmds.cutKey(hdCtrl,cl=True,at="Global")
		cmds.setAttr(hdCtrl+".Global",0)
	except:pass
	


poleVectNameArr =[
#["PoleLeg_L","Hip_L","Knee_L","Ankle_L"],
#$["PoleLeg_R","Hip_R","Knee_R","Ankle_R"],
["PoleArm_L","Shoulder_L","Elbow_L","Wrist_L"],
["PoleArm_R","Shoulder_R","Elbow_R","Wrist_R"]
]

def findTgtNdHier(fbxRoot,tgtName):# fbxRoot = 'root' ; tgtName = pl[1]
	ad = cmds.listRelatives(fbxRoot,ad=True)
	for child in ad: # child = ad[-1]
		if(tgtName == child):
			return child

def getPoleMocapLoc(fbxRoot,refNameSpace,plArr): # fbxRoot='root' , refNameSpace=rgnsp , plArr=poleVectNameArr
	toBakeNode = []
	toCalcNode = []
	referenceNode = []
	for pl in plArr: # pl = plArr[0]
		v1Name = findTgtNdHier(fbxRoot,pl[1])
		v2Name = findTgtNdHier(fbxRoot,pl[2])
		v3Name = findTgtNdHier(fbxRoot,pl[3])
		v4Name = refNameSpace+":"+pl[0]
		if(not cmds.objExists(v1Name)):continue
		if(not cmds.objExists(v2Name)):continue
		if(not cmds.objExists(v3Name)):continue
		if(not cmds.objExists(v4Name)):continue
		vname = [v1Name,v2Name,v3Name]
		
		# to do 
		# Create new locator with no parent
		newLocNd = cmds.spaceLocator()
		nw = refNameSpace+':'+pl[0]+'_ws'
		cmds.rename(newLocNd,nw)
		# set v4Name parent to new locator
		_pCtrl = cmds.pointConstraint(nw,v4Name)
		toCalcNode.append(nw)
		toBakeNode.append(v4Name)
		referenceNode.append(vname)
	
	return toCalcNode,toBakeNode,referenceNode

def bakeCtrlAnim_extraBone(NodeToBake):
	minStr = str(int(cmds.playbackOptions(q=True,minTime=True)))
	maxStr = str(int(cmds.playbackOptions(q=True,maxTime=True)))
	cmds.bakeResults( NodeToBake, t=(minStr,maxStr), sampleBy=1,simulation=True)

# 
def HIKMotionProcess(toolroot,charPath,savePath,rigNameSpace): #toolroot = "E:/00Trunk/PY/JoyFunToolSetMaya/00tools/AdvancedSkeleton/scripts/" , # charPath = 
	# 開啟FileBrowseDlg ，找尋要import的fbx file
	#print "CALLED -- "+ charPath
	openFileDialog1 = System.Windows.Forms.OpenFileDialog()
	openFileDialog1.Filter = "fbx files (*.fbx)|*.fbx|All files (*.*)|*.*";
	openFileDialog1.FilterIndex = 1
	dfmotionLoc = None
	try:dfmotionLoc = cmds.optionVar( q='asMotionLoc')
	except:pass
	if(dfmotionLoc==0):
		dfmotionLoc = "C:\\"
		cmds.optionVar(sv=('asMotionLoc', dfmotionLoc) )

	openFileDialog1.InitialDirectory = dfmotionLoc
	openFileDialog1.Multiselect = True

	if (openFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK):
		allF = openFileDialog1.FileNames
		cmds.optionVar(sv=('asMotionLoc', os.path.dirname(allF[0])) )
		rigFilePth = cmds.file(q=True,sn=True)
		for ff in allF: #ff = allF[0] len(allF)
			fileN = ff.split('\\')[-1].split('.')[0]
			if(len(rigFilePth)==0):
				System.Windows.Forms.MessageBox.Show("請至少開啟一個Rig file 再開始做bake motion")
				break
			rgnsp = rigFilePth.split('/')[-1].split('.')[0]
			if((rigNameSpace!=None) and(len(rigNameSpace))):
				rgnsp = rigNameSpace 
				
			#檔名去掉 gamebar_
			_filename = (ff.split('\\')[-1]).split('.')[0]
			if("gamebar_" in _filename ):
				_filename = _filename[8:]
			
			# 存的目標檔
			tgtDir = os.path.dirname(ff)
			tgtFilePth = tgtDir +"\\"+_filename +".ma" 
			if((len(savePath)) and (savePath != None)):
				savePath = savePath.replace('/','\\')
				nsp = ""
				if((rigNameSpace!=None) and(len(rigNameSpace))):
					nsp = rigNameSpace
				tgtFilePth = savePath +"\\"+ nsp +"_" + _filename +".ma" 
				
			
			# 新建空白場景
			cmds.file(f=True,new=True)
			
			# 場景FPS30
			cmds.currentUnit(t="ntsc")
			
			# reference rig data
			cmds.file(rigFilePth,r=True,options="v=0",namespace=rgnsp,ignoreVersion=True )
			
			# 開始import fbx 動作
			_string = 'source "'+toolroot+'FBXImportModule.mel"'
			mel.eval( _string )
			sv = 'string $res = doImportFbx("'+ff.replace('\\','/')+'");'
			resStr = mel.eval(sv)
			if(resStr != "Success"):break
			
			# 跳到Fbx的BindPose
			charDefNameFbx = gotoFBXBindPose(toolroot)
			
			# only for mermaid ...
			mermaidExtraBoneMapping = [
			['RootX_M','Root_M'],
			['FKSpine1_M','Spine1_M'],
			['FKSpine2_M','Spine2_M'],
			['FKSpine3_M','Spine3_M'],
			['FKChest_M','Chest_M'],
			
			['FKShoulder_L','Shoulder_L'],
			['FKElbow_L','Elbow_L'],
			['FKWrist_L','Wrist_L'],

			['FKShoulder_R','Shoulder_R'],
			['FKElbow_R','Elbow_R'],
			['FKWrist_R','Wrist_R'],

			['FKNeck_M','Neck_M'],
			['FKHead_M','Head_M'],
			['FKTail_A_01_ctl','Tail2_M'],
			
			['IKSpine1_M','Root_M'],
			['IKSpine2_M','Chest_M'],
			['IKArm_L','Wrist_L'],
			['IKArm_R','Wrist_R'],
			
			['Tail_B_00_ctrl','Tail2_M'],
			['Tail_B_01_ctrl','Tail4_M'],
			['Tail_B_02_ctrl','Tail6_M'],
			['Tail_B_03_ctrl','Tail8_M'],
			['Tail_B_04_ctrl','Tail10_M'],
			['Tail_B_05_ctrl','Tail12_M'],
			['Tail_B_06_ctrl','Tail14_M'],
			['Tail_B_07_ctrl','Tail16_M'],
			['Tail_B_08_ctrl','Tail18_M'],
			['Tail_B_09_ctl','Tail20_M']
			]
			extraNodeToBake=[]
			for pair in mermaidExtraBoneMapping: # pair = mermaidExtraBoneMapping[2]
				tgtFbxNode = pair[1]
				rigCtrlName = rgnsp+":"+pair[0]
				if(not cmds.objExists(rigCtrlName)):continue
				if(not cmds.objExists(tgtFbxNode)):continue
				
				try:cmds.pointConstraint(tgtFbxNode,rigCtrlName,mo=True)
				except:pass
				try:cmds.orientConstraint(tgtFbxNode,rigCtrlName,mo=True)
				except:pass
				
				extraNodeToBake.append(rigCtrlName)

			poleArr =['PoleArm_R','PoleArm_L']
			# Pole 生成並設定新位置
			toCalcNode,polIKNodes,refFbxNodes = getPoleMocapLoc('root', rgnsp , poleVectNameArr)
			poleCtrlNodes = setPoleLocKeys(toCalcNode,refFbxNodes)
			extraNodeToBake += polIKNodes

			# 跳到Fbx的MotionPose 初始張
			gotoFBXMotionPose(charDefNameFbx)
			
			tmin = int(cmds.playbackOptions(q=True,minTime=True))
			cmds.currentTime(tmin+40)
			cmds.currentTime(tmin)
			
			# only for mermaid
			bakeCtrlAnim_extraBone(extraNodeToBake)
			
			# 另存新檔 
			cmds.file(rename=tgtFilePth) # tgtFilePth = "D:\JF_RPG\Art_WorkSpace\Animation\idle_2_crouch_jnt.ma"
			cmds.file(save=True,type='mayaAscii',force = True)
			
	# 搜尋charPath
	return
	


# 找Main control 
def findMainAndRootJnt():
	rfNds = cmds.ls(rn=True)
	_main = None
	_rootJnt = None
	for rnd in rfNds: # rnd = rfNds[5]
		bufs = cmds.listRelatives(rnd, fullPath=True, shapes=True)
		if(bufs):
			if( ( cmds.nodeType(bufs[0]) == "nurbsCurve" ) and (":Main" in rnd) ):
				_main = rnd
				break
	for rnd in rfNds: # rnd = rfNds[5]
		if((cmds.nodeType(rnd) == "joint") and (":root" in rnd)):
			_rootJnt = rnd
			break
	return _rootJnt,_main

def findControls(ctrlNameArr,charName="",withShape=False):#ctrlNameArr = ['root_control'] withShape=True
	ret = []
	rfNds = cmds.ls(rn=True)
	if(not withShape):
		for nm in ctrlNameArr:
			nfd = charName+":"+nm
			for rnd in rfNds: 
				if( nfd in rnd ): 
					ret.append(rnd)
					break
	else:
		for nm in ctrlNameArr: #nm = ctrlNameArr[0]
			nfd = charName+":"+nm
			cnt = 0
			for rnd in rfNds: # rnd = rfNds[121]
				bufs = cmds.listRelatives(rnd,shapes=True)
				if (not bufs):continue
				if(( cmds.nodeType(bufs[0]) == "nurbsCurve" ) and (nfd in rnd )): 
					ret.append(rnd)
					break
				cnt += 1
	
	return ret

def getAsCharHeight(): 
	if(cmds.objExists("Root_M")):
		return (cmds.xform("Root_M",q=True,ws=True,t=True)[1])*2
	return 0

def getRootDifToZero(_main,_rootJnt):
	dif = om.MVector(0,0,0)
	if((_rootJnt) and (_main) ):
		rootjntTr = cmds.xform(_rootJnt ,q= 1 ,ws = 1,t =1 )
		_mainTr = cmds.xform(_main,q= 1 ,ws = 1,t =1 )
		
		rootjntTrV = om.MVector(rootjntTr[0] ,rootjntTr[1],rootjntTr[2])
		_mainTrV = om.MVector(_mainTr[0] ,_mainTr[1],_mainTr[2])
		
		dif = _mainTrV - rootjntTrV
	return dif

# root 直接歸0
def setRootToZero():
	
	# get root dif
	dif = om.MVector()
	_rootJnt,_main = findMainAndRootJnt()
	if(_main):
		ctrlNameArr = [
		'RootX_M',
		'IKArm_L',
		'IKArm_R',
		'PoleArm_L',
		'PoleArm_R',
		'IKLeg_L',
		'IKLeg_R'
		] # 膝蓋不用
		ctrlsToMov = findControls(ctrlNameArr) 
		if(len(ctrlsToMov)):
			
			_xmPos = cmds.xform(ctrlsToMov[0],q=True,ws=True,t=True)
			_xmPosOm = om.MVector(_xmPos[0] ,_xmPos[1],_xmPos[2])
			_mainPos= cmds.xform(_main,q=True,ws=True,t=True)
			_mainPosOm = om.MVector(_mainPos[0],_mainPos[1],_mainPos[2])
			dif = _mainPosOm-_xmPosOm
			
			dify = 0
			# 找場景當前的 skelemesh
			minY = 99999999
			scSkMeshs = getSceneSkelMeshs()
			for skm in scSkMeshs: #skm = scSkMeshs[0]
				skbb = cmds.xform(skm,bb=True,q=True,ws=True)
				bby_1 = abs(skbb[1])
				bby_2 = abs(skbb[4])
				if(bby_1 < minY):
					minY = bby_1
					dify = -skbb[1]
				if(bby_2 < minY):
					minY = bby_2
					dify = -skbb[4]
				
				
			for ct in ctrlsToMov: #ct =ctrlsToMov[0]
				_tx = cmds.getAttr(ct + '.translateX')
				_ty = cmds.getAttr(ct + '.translateY')
				_tz = cmds.getAttr(ct + '.translateZ')
				cmds.selectKey(ct + '.translateX',k=True)
				cmds.keyframe( animation = "keys",relative=True,valueChange = dif.x)
				cmds.selectKey(ct + '.translateY',k=True)
				cmds.keyframe( animation = "keys",relative=True,valueChange = dify)
				cmds.selectKey(ct + '.translateZ',k=True)
				cmds.keyframe( animation = "keys",relative=True,valueChange = dif.z)
		
		cmds.xform(_main,ws=True,t=(0,0,0))
		
		# Ex. set root control to zero
		rootCtrl = findControls(['root_ctrl'],'',True)
		try:
			cmds.xform(rootCtrl[0] ,ws=True,t=(0,0,0))
			cmds.xform(rootCtrl[0] ,ws=True,t=(0,0,0))
			cmds.xform(rootCtrl[0] ,ws=True,t=(0,0,0))
		except:pass




# 找Main control 並對整段time range 歸0
def setRootToZeroTimeRanged():
	ctrlNameArr = ['RootX_M','Main']
	ctrlsToMov = findControls(ctrlNameArr) 
	if(len(ctrlsToMov)):
		cmds.select(ctrlsToMov[0])
		cmds.copyKey(ctrlsToMov[0],at="tx")
		cmds.pasteKey(ctrlsToMov[1],connect=True,at="tx")
		cmds.copyKey(ctrlsToMov[0],at="tz")
		cmds.pasteKey(ctrlsToMov[1],connect=True,at="tz")
		#cmds.scaleKey(ctrlsToMov[1],valueScale=-1,valuePivot=0)
		cmds.scaleKey(ctrlsToMov[1],valueScale=-1,valuePivot=0,at=["tx","ty","tz","rx","ry","rz"])
		
		
	''''
	_rootJnt,_main = findMainAndRootJnt()
	if((_rootJnt) and (_main) ):
		tmin = int(cmds.playbackOptions(q=True,minTime=True))
		tmax = int(cmds.playbackOptions(q=True,maxTime=True))
		for k in range(tmin,tmax+1):#k=tmin
			cmds.currentTime(k)
			dif = getRootDifToZero(_main,_rootJnt)
			if(dif.length()>0):
				cmds.xform(_main , ws=True, t=(dif.x,dif.y,dif.z))
				cmds.setKeyframe( _main+".translate" )
		cmds.currentTime(tmin)
	return
	'''
def setFKToIKAnim(bAnim=False):
	selection = cmds.ls(sl=True)
	charName=""
	if(len(selection)):
		sel = selection[0]
		if(cmds.referenceQuery(sel,isNodeReferenced=True) == True):
			charName = sel.split(':')[0]
	
	ctrlNameArrFK = [
	               'FKShoulder_L',
	               'FKShoulder_R',
	               'FKElbow_L',
	               'FKElbow_R',
	               'FKWrist_L',
	               'FKWrist_R',
	               'FKSpine1_M',
	               'FKSpine2_M',
	               'FKSpine3_M',
	               #'FKSpine4_M',
	               'FKHip_L',
	               'FKHip_R',
	               'FKKnee_L',
	               'FKKnee_R',
	               'FKAnkle_L',
	               'FKAnkle_R',
	              ]
	
	ctrlNameArrIK = [
	               'IKXShoulder_L',
	               'IKXShoulder_R',
	               'IKXElbow_L',
	               'IKXElbow_R',
	               'IKArm_L',
	               'IKArm_R',
	               'IKXSpine1_M',
	               'IKXSpine2_M',
	               'IKXSpine3_M',
	               #'IKXSpine4_M',
	               'IKXHip_L',
	               'IKXHip_R',
	               'IKXKnee_L',
	               'IKXKnee_R',
	               'IKLeg_L',
	               'IKLeg_R'
	              ]
	ctrlsFK = findControls(ctrlNameArrFK,charName) 
	ctrlsIK = findControls(ctrlNameArrIK,charName) 
	
	if((not len(ctrlsFK) ) or (len(ctrlsIK) != len(ctrlsFK) ) ):return
	
	if(bAnim):
		tmin = int(cmds.playbackOptions(q=True,minTime=True))
		tmax = int(cmds.playbackOptions(q=True,maxTime=True))
		for k in range(tmin,tmax+1):
			cmds.currentTime(k)
			for c in range(0,len(ctrlsIK)) : # c = 4
				rod = cmds.xform(ctrlsIK[c],q=True,ro=True,ws=True)
				if(':FKWrist_L' in ctrlsFK[c]):
					maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.lArmLclTm)
				elif (':FKWrist_R' in ctrlsFK[c]):
					maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.rArmLclTm)
				elif (':FKAnkle_L' in ctrlsFK[c]):
					maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.lLegLclTm)
				elif (':FKAnkle_R' in ctrlsFK[c]):
					maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.rLegLclTm)
				else:
					cmds.xform(ctrlsFK[c],ro=rod ,ws=True)
				
				cmds.setKeyframe( ctrlsFK[c]+".rotate" )
			# 發現只做一次會有偏差，原因不明
			# 一次不夠，那你有做第二次嗎?
			for c in range(0,len(ctrlsIK)) : # c = 4
				rod = cmds.xform(ctrlsIK[c],q=True,ro=True,ws=True)
				if(':FKWrist_L' in ctrlsFK[c]):
					maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.lArmLclTm)
				elif (':FKWrist_R' in ctrlsFK[c]):
					maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.rArmLclTm)
				elif (':FKAnkle_L' in ctrlsFK[c]):
					maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.lLegLclTm)
				elif (':FKAnkle_R' in ctrlsFK[c]):
					maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.rLegLclTm)
				else:
					cmds.xform(ctrlsFK[c],ro=rod ,ws=True)
				
				cmds.setKeyframe( ctrlsFK[c]+".rotate" )
				
		cmds.currentTime(tmin)
	else:
		for c in range(0,len(ctrlsIK)) : # c = 4
			rod = cmds.xform(ctrlsIK[c],q=True,ro=True,ws=True)
			if(':FKWrist_L' in ctrlsFK[c]):
				maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.lArmLclTm)
			elif (':FKWrist_R' in ctrlsFK[c]):
				maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.rArmLclTm)
			elif (':FKAnkle_L' in ctrlsFK[c]):
				maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.lLegLclTm)
			elif (':FKAnkle_R' in ctrlsFK[c]):
				maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.rLegLclTm)
			else:
				cmds.xform(ctrlsFK[c],ro=rod ,ws=True)
			cmds.setKeyframe( ctrlsFK[c]+".rotate" )


def setIKToFKAnim(bAnim=False):
	selection = cmds.ls(sl=True)
	charName=""
	if(len(selection)):
		sel = selection[0]
		if(cmds.referenceQuery(sel,isNodeReferenced=True) == True):
			charName = sel.split(':')[0]

	ctrlNameArrFK = [
	               'FKWrist_L',
	               'FKWrist_R',
	               'FKRoot_M',
	               'FKChest_M',
	               'FKAnkle_L',
	               'FKAnkle_R',
	              ]
	
	ctrlNameArrIK = [
	               'IKArm_L',
	               'IKArm_R',
	               'IKSpine2_M',
	               'IKSpine1_M',
	               'IKLeg_L',
	               'IKLeg_R'
	              ]
	
	armLPoleCtrlName = ["FKShoulder_L","FKElbow_L","FKWrist_L" ,"PoleArm_L"]
	armRPoleCtrlName = ["FKShoulder_R","FKElbow_R","FKWrist_R" ,"PoleArm_R"]
	legLPoleCtrlName = ["FKHip_L","FKKnee_L","FKAnkle_L" ,"PoleLeg_L"]
	legRPoleCtrlName = ["FKHip_R","FKKnee_R","FKAnkle_R" ,"PoleLeg_R"]
	
	ctrlsFK = findControls(ctrlNameArrFK,charName) 
	ctrlsIK = findControls(ctrlNameArrIK,charName) 
	
	armLPoleCtrl = findControls(armLPoleCtrlName,charName )
	armRPoleCtrl = findControls(armRPoleCtrlName,charName )
	legLPoleCtrl = findControls(legLPoleCtrlName,charName )
	legRPoleCtrl = findControls(legRPoleCtrlName,charName )
	
	
	if((not len(ctrlsFK) ) or (len(ctrlsIK) != len(ctrlsFK) ) ):return
	
	if(bAnim):
		tmin = int(cmds.playbackOptions(q=True,minTime=True))
		tmax = int(cmds.playbackOptions(q=True,maxTime=True))
		for k in range(tmin,tmax+1):
			cmds.currentTime(k)
			for c in range(0,len(ctrlsIK)) : # c = 4
				if(':IKArm_L' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.lArmLclTm_IK)
				elif(':IKArm_R' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.rArmLclTm_IK)
				elif(':IKLeg_L' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.lLegLclTm_IK)
				elif(':IKLeg_R' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.rLegLclTm_IK)
				elif(':IKXSpine1_M' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.spine0LclTm_IK)
				elif(':IKXSpine2_M' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.spine1LclTm_IK)
				
				cmds.setKeyframe( ctrlsIK[c]+".rotate" )
				cmds.setKeyframe( ctrlsIK[c]+".translate" )
			# 更新手肘位置
			setElbowNewPoleLocation(armLPoleCtrl[0],armLPoleCtrl[1],armLPoleCtrl[2],armLPoleCtrl[3])
			setElbowNewPoleLocation(armRPoleCtrl[0],armRPoleCtrl[1],armRPoleCtrl[2],armRPoleCtrl[3])
			setElbowNewPoleLocation(legLPoleCtrl[0],legLPoleCtrl[1],legLPoleCtrl[2],legLPoleCtrl[3])
			setElbowNewPoleLocation(legRPoleCtrl[0],legRPoleCtrl[1],legRPoleCtrl[2],legRPoleCtrl[3])
			
			# 發現只做一次會有偏差，原因不明
			# 一次不夠，那你有做第二次嗎?
			for c in range(0,len(ctrlsIK)) : # c = 4
				if(':IKArm_L' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.lArmLclTm_IK)
				elif(':IKArm_R' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.rArmLclTm_IK)
				elif(':IKLeg_L' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.lLegLclTm_IK)
				elif(':IKLeg_R' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.rLegLclTm_IK)
				elif(':IKXSpine1_M' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.spine0LclTm_IK)
				elif(':IKXSpine2_M' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.spine1LclTm_IK)
				
				cmds.setKeyframe( ctrlsIK[c]+".rotate" )
				cmds.setKeyframe( ctrlsIK[c]+".translate" )
			
			# 更新手肘位置
			setElbowNewPoleLocation(armLPoleCtrl[0],armLPoleCtrl[1],armLPoleCtrl[2],armLPoleCtrl[3])
			setElbowNewPoleLocation(armRPoleCtrl[0],armRPoleCtrl[1],armRPoleCtrl[2],armRPoleCtrl[3])
			setElbowNewPoleLocation(legLPoleCtrl[0],legLPoleCtrl[1],legLPoleCtrl[2],legLPoleCtrl[3])
			setElbowNewPoleLocation(legRPoleCtrl[0],legRPoleCtrl[1],legRPoleCtrl[2],legRPoleCtrl[3])
			
		cmds.currentTime(tmin)
	else:
		for c in range(0,len(ctrlsIK)) : # c = 4
			if(':IKArm_L' in ctrlsIK[c]):
				maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.lArmLclTm_IK)
			elif(':IKArm_R' in ctrlsIK[c]):
				maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.rArmLclTm_IK)
			elif(':IKLeg_L' in ctrlsIK[c]):
				maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.lLegLclTm_IK)
			elif(':IKLeg_R' in ctrlsIK[c]):
				maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.rLegLclTm_IK)
			elif(':IKXSpine1_M' in ctrlsIK[c]):
				maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.spine0LclTm_IK)
			elif(':IKXSpine2_M' in ctrlsIK[c]):
				maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.spine1LclTm_IK)
			
			cmds.setKeyframe( ctrlsIK[c]+".rotate" )
			cmds.setKeyframe( ctrlsIK[c]+".translate" )
		# 更新手肘位置
		setElbowNewPoleLocation(armLPoleCtrl[0],armLPoleCtrl[1],armLPoleCtrl[2],armLPoleCtrl[3])
		setElbowNewPoleLocation(armRPoleCtrl[0],armRPoleCtrl[1],armRPoleCtrl[2],armRPoleCtrl[3])
		setElbowNewPoleLocation(legLPoleCtrl[0],legLPoleCtrl[1],legLPoleCtrl[2],legLPoleCtrl[3])
		setElbowNewPoleLocation(legRPoleCtrl[0],legRPoleCtrl[1],legRPoleCtrl[2],legRPoleCtrl[3])

# 生成虛擬碰撞體，黏到 root 上
def generateCapsule():
	if(cmds.objExists("capsule_geo")):return
	
	bQuadroped = False # 是否為四足
	shdLPos = None
	shdRPos = None
	if(cmds.objExists("Shoulder_L")):
		shdLPos = cmds.xform("Shoulder_L",q=True,ws=True,t=True)
	elif(cmds.objExists("JawEnd_M")):
		shdLPos = cmds.xform("JawEnd_M",q=True,ws=True,t=True)
		bQuadroped = True
		
	if(cmds.objExists("Shoulder_R")):
		shdRPos = cmds.xform("Shoulder_R",q=True,ws=True,t=True)
	elif(cmds.objExists("Root_M")):
		shdRPos = cmds.xform("Root_M",q=True,ws=True,t=True)
	
	if( (not shdLPos) or (not shdRPos) ):return
	shdLPos_om = om.MVector(shdLPos[0],shdLPos[1],shdLPos[2])
	shdRPos_om = om.MVector(shdRPos[0],shdRPos[1],shdRPos[2])
	if(bQuadroped):
		_radius = ( shdLPos_om - shdRPos_om ).length()*0.6
	else:
		_radius = ( shdLPos_om - shdRPos_om ).length()*1.2

	sp = cmds.polySphere(r=_radius,sx=20,sy=20,cuv=2,ch=1)[0]
	cmds.rename(sp,"capsule_geo")
	cmds.select("capsule_geo.f[180:359]", "capsule_geo.f[380:399]")
	cmds.move( 0, (getAsCharHeight()-_radius*2), 0 ,r=True)
	cmds.select(cl=True)
	cmds.select("capsule_geo")
	cmds.move( 0, _radius, 0 ,r=True)
	centerPos = cmds.xform("capsule_geo",q=True,ws=True,sp=True)
	BBox = cmds.xform("capsule_geo",q=True,ws=True,bb=True)
	cmds.xform("capsule_geo",piv=(centerPos[0],BBox[1],centerPos[2]),ws=True)
	bl = cmds.shadingNode("blinn",asShader=True)
	cmds.select("capsule_geo")
	cmds.hyperShade(assign=bl)
	cmds.setAttr( bl+".transparencyR",0.906)
	cmds.setAttr( bl+".transparencyG",0.906)
	cmds.setAttr( bl+".transparencyB",0.906)
	cmds.select(cl=True)
	cmds.parentConstraint("root_ctrl","capsule_geo",mo=True)
	
# 生成4個layer "Controller" "Capsule" "Mesh" "Joint"
# 整理基本物件
def assortBasicLayers():
	if(not cmds.objExists("Joint")):
		cmds.createDisplayLayer(name="Joint")
	if(not cmds.objExists("Mesh")):
		cmds.createDisplayLayer(name="Mesh")
	if(not cmds.objExists("Capsule")):
		cmds.createDisplayLayer(name="Capsule")
	if(not cmds.objExists("Controller")):
		cmds.createDisplayLayer(name="Controller")
	try:
		cmds.setAttr("Joint.visibility",False)
		cmds.setAttr("Joint.displayType",2)
		cmds.setAttr("Capsule.displayType",2)
		cmds.setAttr("Mesh.displayType",2)
	except:pass

def addObjsToLayer(layerName,objSets): #layerName = "Controller" nd = "PoleArm_R"
	for nd in objSets :
		cmds.connectAttr(layerName+".drawInfo",nd+".drawOverride")


def asAfterBuildJoyFunModified():
	generateCapsule()
	assortBasicLayers()
	
	allCtrlObj = []
	getShapes(getAllObjects(),allCtrlObj ,_type="nurbsCurve",bGetHidden=True)
	
	capsuleGrpName = ['capsule_geo']
	meshGrpName = getSceneSkelMeshs()
	jntGrpName = ['root']
	
	try:
		addObjsToLayer("Controller",allCtrlObj)
		addObjsToLayer("Capsule",capsuleGrpName)
		addObjsToLayer("Mesh",meshGrpName)
		addObjsToLayer("Joint",jntGrpName)
	
		# 有4個煩人的node 在此一併砍了
		cmds.delete("mentalrayGlobals")
		cmds.delete("mentalrayItemsList")
		cmds.delete("miDefaultFramebuffer")
		cmds.delete("miDefaultOptions")
	except:pass


# 把選中的 cluster 轉成 Joint Chain & 加入控制器
def turnClustersToJntChain(bOrderByNum=False,baseJntName="joint"):
	__obj = []
	sel = cmds.ls(sl=True)
	selShps = getShapes(sel,__obj ,_type='clusterHandle')
	jntArray = [] # 最後完成的joint array
	cmds.select(cl=True)
	for i in range(0,len(sel)): # i = 0
		jntName = baseJntName+"_"+str(i)
		if(i<10):
			jntName = baseJntName+"_0"+str(i)
		thisNd = sel[i]
		thisNdShp = selShps[i]
		
		curPos = [0,0,0]
		try: # cluster 要抓的是origin
			orig = cmds.getAttr(thisNdShp +".origin")[0]
			_Pos = cmds.xform(thisNd, q=True,t=True,ws=True)
			curPos = [(orig[0]+_Pos[0]),(orig[1]+_Pos[1]),(orig[2]+_Pos[2])]
		except:pass
		jnt = cmds.joint(n=jntName,p=curPos)
		jntArray.append(jntName)



## UE4 Import Motion Related
#om.MItDependencyGraph.kUpstream
#om.MFn.kAnimCurve
#om.MFn.kNurbsCurve
#getAllDGNodes(tgtConstr,om.MItDependencyGraph.kUpstream,om.MFn.kTransform)

#import maya.OpenMaya as om
def getAllDGNodes(inNode,direction,nodeMfnType):
	nodes = []
	# Create a MSelectionList with our selected items:
	selList = om.MSelectionList()
	selList.add(inNode)
	mObject = om.MObject()  # The current object
	selList.getDependNode( 0, mObject )

	# Create a dependency graph iterator for our current object:
	mItDependencyGraph = om.MItDependencyGraph(mObject,direction,om.MItDependencyGraph.kPlugLevel)
	while not mItDependencyGraph.isDone():
		currentItem = mItDependencyGraph.currentItem()
		dependNodeFunc = om.MFnDependencyNode(currentItem)
		# See if the current item is an animCurve:
		if currentItem.hasFn(nodeMfnType):
			name = dependNodeFunc.name()
			nodes.append(name)
		mItDependencyGraph.next()

	# See what we found:
	#for n in sorted(nodes):
	#	print n

	return nodes

# 初始化控制器綁定到 UE4 sk 上
def snapIKFKCtrlToMo_UE4(charName="",jntCollection=[]): # charName = rignsp jntCollection = fbxJntCollection_withKeys
	# Pole 生成並設定新位置
	# createPoleMocapLoc_UE4(charName,poleVectNameArr)
	
	constNameArr=[]
	rootctrlo = cmds.pointConstraint("root",charName+":root_ctrl",mo=True)
	constNameArr.append(rootctrlo)
	
	_HipFKCtrlo = cmds.parentConstraint("Root_M",charName+":RootX_M",mo=True)
	constNameArr.append(_HipFKCtrlo)
	## FK Constraint
	for k in range(0,len(mcToFKNmPar)): # k = 1
		TgtN = mcToFKNmPar[k][0]
		TgtN = TgtN.replace("_MoCap_","_")
		_Ctrl = cmds.parentConstraint(TgtN , charName+":"+mcToFKNmPar[k][1],mo=True)
		constNameArr.append(_Ctrl)
		
	# 手指
	doFingerConstraint(constNameArr,charName)
	
	'''
	additionalCtrl = []
	for jnt in jntCollection: # jnt = jntCollection[0]
		coorspJntChar = charName+":"+jnt
		if(cmds.objExists(coorspJntChar)):
			allSource = cmds.listConnections(coorspJntChar+".rx",s=True)
			if(len(allSource) > 0):
				tgtConstr = allSource[0]
			
			else: # No constraint ,bind the joint itself
				_Ctrl = cmds.parentConstraint(jnt , coorspJntChar,mo=True)
				constNameArr.append(_Ctrl)
				additionalCtrl.append(coorspJntChar)
				
	'''
	return constNameArr



## Back Mocap 動作到兩組(FK/IK)控制器上
def bakeCtrlAnim_UE4(constNameArr,charName=""): # charName = rgnsp
	# Back 工作
	#setPoleLocKeys(charName,poleVectNameArr)
	# FK 要Back的 Node 
	NdToBake = [charName+":RootX_M"]
	for nds in mcToFKNmPar: # nds=mcToFKNmPar[1]
		NdToBake.append(charName+":"+nds[1])
	#for nds in mcToIKNmPar:
	#	NdToBake.append(charName+":"+nds[1])
	# 手指 bake
	for nds in allFingersArr:
		NdToBake.append(charName+":"+nds[1])
	
	minStr = str(int(cmds.playbackOptions(q=True,minTime=True)))
	maxStr = str(int(cmds.playbackOptions(q=True,maxTime=True)))

	cmds.bakeResults( NdToBake, t=(minStr,maxStr), sampleBy=1,simulation=True,
					 )
	'''disableImplicitControl=True,preserveOutsideKeys=True,
					 sparseAnimCurveBake=False,
					 bakeOnOverrideLayer=False,
					 controlPoints=False,shape=True'''
	#minimizeRotation=True
	#removeBakedAttributeFromLayer=False,
	#removeBakedAnimFromLayer=True,
	# Back 完成後刪除不需要的東西
	try:cmds.delete("Root_M")
	except:pass
	try:cmds.delete( getFBXCharName() + ":Ref")
	except:pass
	try:cmds.delete("Root_MoCap_M")
	except:pass
	try:
		cmds.delete("L_LegMocapPole_x")
		cmds.delete("L_ElbowMocapPole_x")
		cmds.delete("R_LegMocapPole_x")
		cmds.delete("R_ElbowMocapPole_x")
		cmds.delete("root")
		cmds.delete(constNameArr)
	except:pass
	charArr = cmds.ls(type="HIKCharacterNode")
	if (len(charArr)):
		cmds.delete(charArr)
	
	# Apply All Scene Euler Filter
	rotcurves = cmds.ls(type="animCurveTA")
	for r in range (0,len(rotcurves)/3): #r=1
		cmds.filterCurve( rotcurves[3*r] , rotcurves[3*r+1] , rotcurves[3*r+2] )
	
	try:
		# 頭部的 global channel 不要有key
		hdctrlsnm = ["FKHead_M"]
		hdCtrl = findControls(hdctrlsnm)[0]
		cmds.cutKey(hdCtrl,cl=True,at="Global")
		cmds.setAttr(hdCtrl+".Global",0)
	except:pass
	


def UE4MotionProcess(toolroot): #toolroot = "D:/00Trunk/PY/JoyFunToolSetMaya/00tools/AdvancedSkeleton/scripts/" 
	# 開啟FileBrowseDlg ，找尋要import的fbx file
	openFileDialog1 = System.Windows.Forms.OpenFileDialog()
	openFileDialog1.Filter = "fbx files (*.fbx)|*.fbx|All files (*.*)|*.*";
	openFileDialog1.FilterIndex = 1
	dfmotionLoc = None
	try:dfmotionLoc = cmds.optionVar( q='asMotionLoc')
	except:pass
	if(dfmotionLoc==0):
		dfmotionLoc = "C:\\"
		cmds.optionVar(sv=('asMotionLoc', dfmotionLoc) )

	openFileDialog1.InitialDirectory = dfmotionLoc
	openFileDialog1.Multiselect = True

	if (openFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK):
		allF = openFileDialog1.FileNames
		cmds.optionVar(sv=('asMotionLoc', os.path.dirname(allF[0])) )
		rigFilePth = cmds.file(q=True,sn=True)
		for ff in allF: #ff = allF[0] len(allF)
			fileN = ff.split('\\')[-1].split('.')[0]
			if(len(rigFilePth)==0):
				System.Windows.Forms.MessageBox.Show("請至少開啟一個Rig file 再開始做bake motion")
				break
			rgnsp = rigFilePth.split('/')[-1].split('.')[0]
			charName = rgnsp
			#檔名
			_filename = (ff.split('\\')[-1]).split('.')[0]

			# 存的目標檔
			tgtDir = os.path.dirname(ff)
			tgtFilePth = tgtDir +"\\"+_filename +".ma" 

			# 新建空白場景
			cmds.file(f=True,new=True)

			# 場景FPS30
			cmds.currentUnit(t="ntsc")

			# 開始import fbx 動作
			_string = 'source "'+toolroot+'/FBXImportModule.mel"'
			mel.eval( _string )
			sv = 'string $res = doImportFbx("'+ff.replace('\\','/')+'");'
			resStr = mel.eval(sv)
			if(resStr != "Success"):break

			fbxJntCollection = cmds.ls(type="joint")
			fbxJntCollection_withKeys = []
			# reference rig data
			cmds.file(rigFilePth,r=True,options="v=0",namespace=rgnsp,ignoreVersion=True )


			# fbx 初始pose請參考rig pose(這裡假設一定是同一套rig，例外不處理喔)
			for i in range(0,4): # 只做一次會對位失敗，常常這樣...
				for jnt in fbxJntCollection: #jnt = fbxJntCollection[478]
					if(jnt == "root"):continue
					chrBoneName = charName +":"+ jnt
					tgtTm = cmds.xform(chrBoneName,q=True,ws=True,m=True)
					
					ktx = cmds.keyframe(jnt,q=True,tc=True,at="tx")
					kty = cmds.keyframe(jnt,q=True,tc=True,at="ty")
					ktz = cmds.keyframe(jnt,q=True,tc=True,at="tz")
					krx = cmds.keyframe(jnt,q=True,tc=True,at="rx")
					kry = cmds.keyframe(jnt,q=True,tc=True,at="ry")
					krz = cmds.keyframe(jnt,q=True,tc=True,at="rz")
					
					numKeys_Tx = 0
					numKeys_Ty = 0
					numKeys_Tz = 0
					numKeys_Rx = 0
					numKeys_Ry = 0
					numKeys_Rz = 0

					if(ktx):
						numKeys_Tx = len(cmds.keyframe(jnt,q=True,tc=True,at="tx"))
					if(kty):
						numKeys_Ty = len(cmds.keyframe(jnt,q=True,tc=True,at="ty"))
					if(ktz):
						numKeys_Tz = len(cmds.keyframe(jnt,q=True,tc=True,at="tz"))
					if(krx):
						numKeys_Rx = len(cmds.keyframe(jnt,q=True,tc=True,at="rx"))
					if(kry):
						numKeys_Ry = len(cmds.keyframe(jnt,q=True,tc=True,at="ry"))
					if(krz):
						numKeys_Rz = len(cmds.keyframe(jnt,q=True,tc=True,at="rz"))

					numT = (numKeys_Tx+numKeys_Ty+numKeys_Tz)
					numR = (numKeys_Rx+numKeys_Ry+numKeys_Rz)
					
					if((numT > 0) and (numR >0)):
						cmds.xform(jnt,ws=True,m=tgtTm)
						if(not jnt in fbxJntCollection_withKeys):
							fbxJntCollection_withKeys.append(jnt)

				
			# 控制器綁定到 fbx sk 上
			consNameAr = snapIKFKCtrlToMo_UE4(rgnsp,fbxJntCollection_withKeys)
			cmds.currentTime(0)
			
			# ALL FK 啟動
			cmds.setAttr(rgnsp+":FKIKArm_L.FKIKBlend",0)
			cmds.setAttr(rgnsp+":FKIKArm_R.FKIKBlend",0)
			cmds.setAttr(rgnsp+":FKIKLeg_L.FKIKBlend",0)
			cmds.setAttr(rgnsp+":FKIKLeg_R.FKIKBlend",0)
			
			# 動作Baking 並刪除多餘資料
			bakeCtrlAnim_UE4(consNameAr,charName)
			
			# FK 動作 to IK 動作
			setIKToFKAnim(True)
			
			# 另存新檔 
			cmds.file(rename=tgtFilePth) # tgtFilePth = "D:\JF_RPG\Art_WorkSpace\Animation\idle_2_crouch_jnt.ma"
			cmds.file(save=True,type='mayaAscii',force = True)


