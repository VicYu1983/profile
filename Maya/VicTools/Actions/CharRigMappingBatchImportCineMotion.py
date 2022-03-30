# -*- coding: utf-8 -*-
#  Batch import character rig for cinematic fbx
# Last Modified 2017/07/01
# Author Chih Lun Kang
import maya.cmds as cmds
import maya.mel as mel
import math, json, os
try:import clr 
except:pass
if(clr):
	clr.AddReference("System")
	clr.AddReference("System.Windows.Forms")
	import System
	import System.Windows.Forms
cmds.loadPlugin("matrixNodes")
import AS_MotionConstrain as ASC
import Helper

import JointToController
reload(JointToController)

# 這行在正式的環境下無法呼叫，自己debug時把這些code貼到maya的 python editor裏，就可以呼叫了
# reload(AS_MotionConstrain)

# 取得logger method
log = Helper.getLogger('AdvSkeleton')

def findRootMNode(chName):
	thisRefNodes = cmds.referenceQuery(chName+"RN",nodes=True)
	rootmNode = None
	# find root_M 
	for refN in thisRefNodes: # refN = thisRefNodes[5]
		ndtyp = None
		try:ndtyp = cmds.nodeType(refN)
		except:pass
		if(not ndtyp):continue
		if( ndtyp != 'joint'):continue
		srnt = refN[-6:]
		if(not("Root_M" in srnt)):continue
		proot = None
		try:
			proot = cmds.listRelatives(refN,p=True)[0]
			if(not cmds.listRelatives(proot,p=True)):
				rootmNode = refN
				break
		except:pass
		
	return rootmNode

def findTgtNdHier(fbxRoot='',tgtName=''):# fbxRoot=ch;tgtName="ThumbFinger1_R"
	if(cmds.objExists(fbxRoot)):
		ad = cmds.listRelatives(fbxRoot,ad=True)
		for child in ad: # child = ad[-1]
			if(':' in child):
				lastName = child[child.rindex(':')+1:]
				if(tgtName in lastName):
					return child
	return ''

def getSkinMapping(readpath):
	
	CharNameToRigPathDict = dict({})
	# read mapping text file into dictioary
	f = open(readpath,'r')  
	lines = f.readlines()
	for line in lines:
		line = line.replace('\r','')
		line = line.replace('\n','')
		line_spl = line.split(',')
		_key = line_spl[0]
		itm = line_spl[1]
		if(not _key in CharNameToRigPathDict):
			CharNameToRigPathDict[_key] = itm
	f.close()

	## Find characterized root node
	SceneCharRoots = dict({})

	charname = "Character"
	charArr = cmds.ls(type="HIKCharacterNode")
	for ch in charArr: #ch = charArr[0] ch='cc'
		cn = 'string $node[] = GetHIKNode("'+ ch +'", 0);'
		rootD = None
		try:rootD = mel.eval(cn)[0]
		except:pass
		if(rootD):
			tmpR = cmds.listConnections(rootD , d=False, s=True )
			if(tmpR):
				tmpCh = tmpR[0]
				if(not tmpCh in SceneCharRoots):
					SceneCharRoots[tmpCh]=ch
					
	return CharNameToRigPathDict, SceneCharRoots

def saveSkinMap(readpath, CharNameToRigPathDict):
	dictText = ""
	for key in CharNameToRigPathDict:
		dictText += key+','+CharNameToRigPathDict[key]+'\r\n'
	with open(readpath, "w") as myfile:
		myfile.write(dictText)					

# 把儲存需要的東西carry起來，回傳一個方法
# saveMethod = None

def saveMaya(ffbx, showMsg = True):
	path_ary = ffbx.split('\\')
	_filename = path_ary[-1].replace('.fbx', '')
	tgtDir = '/'.join(path_ary[0:-2]) + '/Maya'
	Helper.checkAndMakeDir(tgtDir)

	tgtFilePth = tgtDir +"\\"+_filename +".ma" 
	
	log( 'Saveing File To: ' + tgtFilePth)
	try:
		cmds.file(rename=tgtFilePth)
		cmds.file(save=True,type='mayaAscii',force = True)
		log( 'Save File Success!')
		if showMsg:
			System.Windows.Forms.MessageBox.Show(u"儲存成功！")
	except:
		log( 'Save Error, Do Not Know Why, Save By Yourself!' )
		if showMsg:
			System.Windows.Forms.MessageBox.Show(u"儲存失敗，請於運行完畢后手動儲存！")

	# def saveMethod():
	# 	log( 'Saveing File To: ' + tgtFilePth)
	# 	try:
	# 		cmds.file(rename=tgtFilePth)
	# 		cmds.file(save=True,type='mayaAscii',force = True)
	# 		log( 'Save File Success!')
	# 		if showMsg:
	# 			System.Windows.Forms.MessageBox.Show(u"儲存成功！")
	# 	except:
	# 		log( 'Save Error, Do Not Know Why, Save By Yourself!' )
	# 		if showMsg:
	# 			System.Windows.Forms.MessageBox.Show(u"儲存失敗，請於運行完畢后手動儲存！")

	# return saveMethod
	# 			
def convertToMaya(fbx_path, SceneCharRoots, CharNameToRigPathDict, globalFollow, minFrm, maxFrm):
	checkList = []

	bakeMethods = []
	extraMethods = []
	
	# # 最上層的所有節點
	# topNodes = cmds.ls(assemblies=1)[:]
	# nonCameras = [node for node in topNodes if not Helper.isCamera(node)]

	for ch in SceneCharRoots: #ch='DaYi:DaYi:DaYi';ch='ZhaoYang:MingShi:MingShi'
		fbxNameSpace = ch[:ch.rindex(':')]
		
		needCheck = True if len(checkList) == 0 else False
		for checkstr in checkList:
			if fbxNameSpace.find( checkstr ) != -1:
				needCheck = True
				
		if not needCheck:
			continue
		
		log('Start Role: ' + fbxNameSpace )

		rigFilePath = None
		if(fbxNameSpace in CharNameToRigPathDict):
			rigFilePath = CharNameToRigPathDict[fbxNameSpace]

			# 在修正成不需要parent constraints的模式之後，就不需要換成unlock的版本
			# rigFilePath = Helper.getMocapPath(rigFilePath)
		log('Target Load File:' + rigFilePath)
		
		if(not rigFilePath):
			log( 'No File Exist:' + rigFilePath + ', Ignore' )
			continue
		if(not os.path.isfile(rigFilePath)):
			log( 'No File Exist:' + rigFilePath + ', Ignore' )
			continue
		
		# simple test
		tgtFbxNode = ''
		try:tgtFbxNode = findTgtNdHier(ch,"ThumbFinger1_R")
		except:pass
		if(not cmds.objExists(tgtFbxNode)):
			log (tgtFbxNode+' Is Not Valid !! ')
			continue
		
		log('Load Role Rig: ' + rigFilePath)
		# reference rig data
		cmds.file(rigFilePath,r=True,options="v=0",namespace=fbxNameSpace,ignoreVersion=True )
		
		ref_root_m = findRootMNode(fbxNameSpace)
		refNameSpace = ref_root_m[:ref_root_m.rindex(':')]
		
		log('Starting Skin...')
		log('Char Name:' + refNameSpace )
		log('Mocap Name:' + fbxNameSpace )
		log('Ui Name:' +  SceneCharRoots[ch] )

		ASC.setGlobalFollow( refNameSpace, globalFollow )
		(backMethod, extraMethod) = JointToController.genMapAndMatchFKIK(fbxNameSpace, refNameSpace)
		bakeMethods.append( backMethod )
		extraMethods.append( extraMethod )

	for i in range(minFrm, maxFrm, 1):
		for bake in bakeMethods: bake(i)
	for extraMethod in extraMethods: extraMethod()
	
	Helper.fixEulerCurve()
	# Helper.deleteNodes(nonCameras)

	# 刪除特定不需要的物件
	cmds.select(cl=1)
	all_nodes = cmds.ls(type='transform')

	# 所有的camera留著
	all_cams = cmds.ls('Camera*', type='transform')

	# 所有的camera的interest物件不要
	all_cams = list(set(all_cams) - set(cmds.ls('*Interest')))

	# 所有的角色的Reference物件不要
	all_ctrl_ref = cmds.ls('*:Reference')

	# 保存所有的特效代替物件
	# 規則一:最上層物件
	# 規則二:物件的visibility有key的話, 就代表要留著
	# 規則三:沒有visibility的key的話, 但是visibility為true, 就代表要留著
	need_remain = []
	no_namespace_nodes = cmds.ls('*', type='transform')
	for node in no_namespace_nodes:

		# 排除camera的Interest物件
		if 'Interest' in node: continue

		# 規則二的檢查
		visible_keys = cmds.keyframe(node, at='visibility', q=1)

		# 規則三的檢查
		visible = cmds.getAttr(node + '.visibility')

		# 符合條件的搜集起來
		if visible_keys or visible: need_remain.append( node )
		
	# 刪除所有不要的物件
	need_delete = list(set(all_nodes) - set(all_cams) - set(need_remain))
	cmds.delete( need_delete )

	# 產生一個合并好的camera給動作組用
	Helper.mergeAllShots2()

	# 存檔
	saveMaya(fbx_path)

def linearCurve(camera):
	for attr in ('_translateX', '_translateY', '_translateZ', '_rotateX', '_rotateY', '_rotateZ', 'Shape_focalLength'):
		try:
			cmds.selectKey(	camera+attr, add=1, k=1)
		except: pass
	cmds.keyTangent(itt='linear', ott='linear')

# toolroot: D:/FOD2/ToolSource/Art/JoyFunToolSetMaya/00tools/AdvancedSkeleton/scripts/
def CinMocap_Process_Start(toolroot, readpath, fbx_path,globalFollow=10, onlyExport = False):
	
	#readpath = 'D:/Vic/Maya/anim_fbx/CharNameMapping.txt'
	
	log('Load Role Mapping File')
	CharNameToRigPathDict, SceneCharRoots = getSkinMapping(readpath)
	
	log( 'Current CharNameToRigPathDict:' )
	log( CharNameToRigPathDict )
	
	log( 'Current SceneCharRoots:' )
	log( SceneCharRoots )
		
	log('Check Role Exists, If Not, Open Setting Browser')
	for ch in SceneCharRoots: # ch='DaYi:DaYi:DaYi';ch='ZhaoYang:MingShi:MingShi'

		# fbx namespace
		fbxNameSpace = ch[:ch.rindex(':')]
		
		rigFilePath = None
		if(fbxNameSpace in CharNameToRigPathDict):
			rigFilePath = CharNameToRigPathDict[fbxNameSpace]
		
		## CAN'T FIND RIG FILE, open dialog to choose (no cancel button)
		if(not rigFilePath):
			openFileDialog1 = System.Windows.Forms.OpenFileDialog()
			openFileDialog1.Filter = "ma files (*.ma)|*.ma|All files (*.*)|*.*";
			openFileDialog1.FilterIndex = 1
			openFileDialog1.RestoreDirectory = True
			openFileDialog1.Multiselect = False
			openFileDialog1.Title = "Where is << "+ ch +"  >> Rig File?"
			
			while (not rigFilePath):
				if(openFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK):
					rigFilePath = openFileDialog1.FileName
		if(not rigFilePath):continue
		if(not os.path.isfile(rigFilePath)):continue
		
		## APPEND THE NAME MAPPING TO DICTIONARY
		CharNameToRigPathDict[fbxNameSpace] = rigFilePath
	
	log('Save Role Mapping File')
	saveSkinMap(readpath, CharNameToRigPathDict)	

	# 有時fbx進來的時候, 初始幀並不在0, 這邊强制設爲0
	timeInfo = Helper.getTimelineInfo()
	maxFrm = timeInfo[3]
	Helper.setTimelineInfo(0, maxFrm)
	minFrm = 0

	# 把motion builder的空白字元轉成_
	need_fixs = cmds.ls('*FBXASC032*', type='transform')
	for node in need_fixs:
		new_name = node.replace(node, node.replace('FBXASC032', '_'))
		cmds.rename( node, new_name )

	# 取得要修正的所有camera
	camera_targets = cmds.ls('*Interest*', type='transform')
	cameras = [target.replace('_Interest', '') for target in camera_targets]

	# 把所有camera的所有key都改成綫性模式
	for camera in cameras:
		linearCurve(camera)

	# 計算所有camera的focus distance
	set_cameras_focus_and_rotate(cameras, camera_targets, minFrm, maxFrm)

	# 檢查有沒有InfoForMaya物件, 有的話就讀取物件資料並新增shot到sequencer
	# 沒有的話, 就自動判斷切割
	infoForMaya = cmds.ls('InfoForMaya')
	if len( infoForMaya ) > 0: 
		read_info_add_shot()
	else:
		split_shots(cameras[0], minFrm, maxFrm)

	cmds.currentTime(minFrm)
	if onlyExport:
		onlyExportForUE4(fbx_path, CharNameToRigPathDict, minFrm, maxFrm, (globalFollow == 10))
	else: 
		convertToMaya(fbx_path, SceneCharRoots, CharNameToRigPathDict, globalFollow, minFrm, maxFrm)

def createMappingFile():
	filedir = filepath = os.path.expanduser("~") + '/AdvancedSkeleton'
	Helper.checkAndMakeDir(filedir)

	filepath = os.path.expanduser("~") + '/AdvancedSkeleton/rigMapping.txt'
	if not os.path.isfile( filepath ):
		open( filepath, 'w+' )

	return filepath

## Import FBX 
# Start from the whole new scene
# ffbx = "D:\\JF_RPG\\Art_WorkSpace\\Animation\\990_Cinematic\\01_Lao_Mountain\\scene_0_14_1\MB\\scene_0_14_1.fbx"
# ffbx = "D:\\JF_RPG\\Art_WorkSpace\\Animation\\990_Cinematic\\05_Tao_Tang_City\\scene_1_37_0\MB\\scene_1_37_0.fbx"
def CineMotionProcess(toolroot='D:/FOD2/ToolSource/Art/JoyFunToolSetMaya/00tools/AdvancedSkeleton/scripts/', mappingFile = '',globalFollow=10, onlyExport = False):

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
		
		# 先强制在各自使用者自己文件資料夾下創建mapping表
		mappingFile = createMappingFile()

		log( 'Tool Root:' + toolroot )
		log( 'Mapping File:' + mappingFile )
		
		allF = openFileDialog1.FileNames
		# showMsgPerFile = (len(allF) == 1)
		for ffbx in allF: # ffbx = allF[0] ; len(allF)
			cmds.file(f=True,new=True)

			# ntscf是60, ntsc是30!
			cmds.currentUnit(t="ntscf")

			_string = 'source "'+toolroot+'FBXImportModule.mel"'
			mel.eval( _string )
			sv = 'string $res = doImportFbx("'+ffbx.replace('\\','/')+'");'
			try:
				resStr = mel.eval(sv)
			except:pass
			
			# global saveMethod
			# saveMethod = getSaveMethod(ffbx, showMsgPerFile)

			# main process
			cmds.evaluationManager( mode="off" )
			CinMocap_Process_Start(toolroot, mappingFile, ffbx,globalFollow, onlyExport)
			cmds.evaluationManager( mode="parallel" )

			# 在修正成不需要parent constraints的模式之後，就不需要換成unlock的版本
			# Helper.replaceMocapReferenceToNormal()

			# if not onlyExport:
			# 	saveMethod()

		# if not showMsgPerFile:
		# 	System.Windows.Forms.MessageBox.Show(u"批次處理完成")
















def split_shots(camera, start, end):
	def checkSplitTime(attribute, checkgap):
		keys = cmds.keyframe(q=1, attribute=attribute, absolute=1, timeChange=1)
		values = cmds.keyframe(q=1, attribute=attribute, absolute=1, valueChange=1)
		
		times = []
		if keys and values:
			infos = zip(keys, values)
			for i in range(1, len(infos)):
				prev_key, prev_value = infos[i-1]
				current_key, current_value = infos[i]
				
				if abs(current_value - prev_value) > checkgap:
					times.append(current_key)
		return times
	
	def create_shot(name, camera, start, end):
		cmds.shot(name, sn=name, cc=camera, st=start, sst=start, et=end, set=end, trk=1)

	def query_split_times(fov_check_gap, pos_check_gap, rot_check_gap):
		focal_check = checkSplitTime('focalLength', fov_check_gap)
		translateX_check = checkSplitTime('translateX', pos_check_gap)
		translateY_check = checkSplitTime('translateY', pos_check_gap)
		translateZ_check = checkSplitTime('translateZ', pos_check_gap)
		rotateX_check = checkSplitTime('rotateX', rot_check_gap)
		rotateY_check = checkSplitTime('rotateY', rot_check_gap)
		rotateZ_check = checkSplitTime('rotateZ', rot_check_gap)
		
		split_times = sorted(list(set(focal_check).union(set(translateX_check)).union(set(translateY_check)).union(set(translateZ_check)).union(set(rotateX_check)).union(set(rotateY_check)).union(set(rotateZ_check))))
		return split_times
		
	cmds.select(camera)

	pos_check_gap = 300
	rot_check_gap = 50
	fov_check_gap = 4

	split_times = query_split_times(fov_check_gap, pos_check_gap, rot_check_gap)
	#print(len(split_times))

	# fix hole of keys
	# 這段應該可以先不需要了, 因爲先前需要這段的時候是因爲fps沒有先調爲60就執行匯入fbx的關係, 導致key被減少
	# 現在修正好了, 所以這段理論上是不需要了, 先關閉觀察一下
	# for i in range(0, len(split_times)):
	# 	time = split_times[i]
	# 	prev_time = time-1
	# 	for attr in ('focalLength', 'translateX', 'translateY', 'translateZ', 'rotateX', 'rotateY', 'rotateZ'):
	# 		current_value = cmds.keyframe(attribute=attr, q=1, absolute=1, valueChange=1, time=(time, time))
	# 		if not current_value:
	# 			future_values = cmds.keyframe(attribute=attr, q=1, absolute=1, valueChange=1, time=(time+1, time+5))
	# 			if future_values and len(future_values) > 0:
	# 				future_value = future_values[0]
	# 				cmds.setKeyframe( camera, at=attr, time=(time,time), value=future_value)
	# 		else:
	# 			cmds.cutKey(attribute=attr, time=(prev_time, prev_time))
	# 			history_values = cmds.keyframe(attribute=attr, q=1, absolute=1, valueChange=1, time=(time-5, time-1))
	# 			if history_values and len(history_values) > 0:
	# 				prev_value = history_values[-1]
	# 				cmds.setKeyframe( camera, at=attr, time=(prev_time,prev_time), value=prev_value)

	split_times = query_split_times(fov_check_gap, pos_check_gap, rot_check_gap)

	for i in range(0, len(split_times)):
		if i == 0:
			shot_start = start
			shot_end = split_times[0]-1
		else:
			shot_start = split_times[i-1]
			shot_end = split_times[i]-1
		
		create_shot('shot_' + str(i), camera, shot_start, shot_end)
		if i == len(split_times)-1:
			shot_start = split_times[i]
			shot_end = end
			create_shot('shot_' + str(i+1), camera, shot_start, shot_end)
			
# def set_camera_focus(cam, min_frame, max_frame):
# 	for i in range(min_frame, max_frame):
# 		cmds.currentTime(i)
# 		cmds.setKeyframe(cam, at='focusDistance', time=(i, i), value=get_focus_distance(cam))

def set_cameras_focus_and_rotate(cams, targets, min_frame, max_frame):

	rots = []
	for i in range(min_frame, max_frame):
		cmds.currentTime(i)
		for cam, target in zip(cams, targets):
			cmds.setKeyframe(cam, at='focusDistance', time=(i, i), value=get_focus_distance(cam, target))

		# 並不能直接在這裏bake rotate, 因爲在有constraint的情況下, 只有下了一幀的key, 所有的constraint都會失效
		# 導致bake到的值都不對了, 所以先記錄起來, 再一起做bake
		rots.append(cmds.xform( cam, ws=1, q=1, ro=1))

	for i in range(min_frame, max_frame):
		cmds.setKeyframe( cam, at='rotateX', time=(i, i), value=rots[i][0])
		cmds.setKeyframe( cam, at='rotateY', time=(i, i), value=rots[i][1])
		cmds.setKeyframe( cam, at='rotateZ', time=(i, i), value=rots[i][2])

def read_info_add_shot():
	infoForMaya = cmds.ls('InfoForMaya')
	if len( infoForMaya ) > 0: 
		infoForMaya = infoForMaya[0]
			
		info_str = cmds.getAttr(infoForMaya + '.info_str' )
		infos = json.loads( info_str )
		
		for info in infos:
			camera_name = info['camera']
			shot_name = info['name']
			start_time, end_time = info['time']
			end_time = end_time-1
			
			camera_name = camera_name.replace(' ', '_' )   
			cmds.shot( shot_name, shotName=shot_name, currentCamera=camera_name, startTime=start_time, endTime=end_time, sequenceStartTime=start_time, sequenceEndTime=end_time )
			
		cmds.delete(infoForMaya)

def get_focus_distance(cam, target):
	cam_pos = cmds.xform(cam, q=1, ws=1, t=1)
	cam_target_pos = cmds.xform(target, q=1, ws=1, t=1)

	diff = (cam_pos[0]-cam_target_pos[0], cam_pos[1]-cam_target_pos[1], cam_pos[2]-cam_target_pos[2])
	diff_length = math.sqrt(diff[0]*diff[0] + diff[1]*diff[1] + diff[2]*diff[2])
	return diff_length


def onlyExportForUE4(fbx_name, rig_map, minFrm, maxFrm, world=True):

	path_ary = fbx_name.split('\\')

	# debug
	# path_ary = [u'D:', u'FOD2_Project', u'Art_WorkData', u'Animation', u'03_Cinematic', u'M8', u'C02_CS_D0204', u'MB', u'C02_CS_D0204_B.fbx']
	
	UeFolderName = path_ary[-1].replace('.fbx', '')
	ueAssetPath = '/'.join(path_ary[-4:-2])
	fbxExportPath = '/'.join(path_ary[0:-2]) + '/Export'
	if UeFolderName[-2:] in ('_A', '_B', '_C'):
		fbxExportPath += '/' + UeFolderName

	Helper.checkAndMakeDir(fbxExportPath)

	def add_camera_extra( camera, start, end ):
		try:
			cmds.getAttr(camera + '.AnchorPos')
		except:
			cmds.addAttr(camera, longName='AnchorPos', attributeType='float3' )
			cmds.addAttr(camera, longName='AnchorX', attributeType='float', parent='AnchorPos' )
			cmds.addAttr(camera, longName='AnchorY', attributeType='float', parent='AnchorPos' )
			cmds.addAttr(camera, longName='AnchorZ', attributeType='float', parent='AnchorPos' )
			
		try:
			cmds.getAttr(camera + '.ShotStartFrame')
		except:
			cmds.addAttr(camera, longName='ShotStartFrame', attributeType='float')
			
		try:
			cmds.getAttr(camera + '.ShotEndFrame')
		except:
			cmds.addAttr(camera, longName='ShotEndFrame', attributeType='float')
		
		offset_pos = get_offset_init()
		cmds.setAttr( camera + '.AnchorX', offset_pos[0] )
		cmds.setAttr( camera + '.AnchorY', offset_pos[1] )
		cmds.setAttr( camera + '.AnchorZ', offset_pos[2] )
		cmds.setAttr( camera + '.ShotStartFrame', start )
		cmds.setAttr( camera + '.ShotEndFrame', end )
		
	def export_fbx( skel, splits ):
		cmds.select(clear=1)
		cmds.select(skel)

		ns = ':'.join(skel.split(':')[0:-1])
		group_name = ns.replace(':', '_')

		# 這個部分是為了和maya to sequencer的功能所導出的資料相同,所以做了一些手脚
		group_name = '_' + group_name
		try:
			index = int(group_name[-1])
			group_name = group_name[:-1] + str(index+1)
		except:
			group_name += '1'

		out_name = UeFolderName + '_' +  group_name    

		offset_pos = get_offset_init()
		start_time = minFrm / 60.0
		end_time = maxFrm / 60.0

		animKeys = []
		for split in splits:
			section_start = split[0]
			section_end = split[1]
			section_start_time = section_start / 60.0
			section_name = out_name + '_' + str(section_start) + '_' + str(section_end)

			Helper.setTimelineInfo(section_start, section_end)
		
			# export role fbx
			# 這樣的api輸入并不能導出特定的時間範圍
			# mel.eval('file -force -options "fbx" -typ "FBX export" -pr -es "' + fbxExportPath + '/' + section_name + '.fbx";')    

			# 改成這樣
			mel.eval('FBXExport -f "'+ fbxExportPath + '/' + section_name +'.fbx" -s')

			rig_name = rig_map[ns] #'BRIG_XingYuan0000'
			rig_name = rig_name.split('\\')[-1].replace('.ma', '')

			for replace in (('BRIG_nhm_ZuiHun00a', 'BRIG_nhm_ZuiHun'), ('BRIG_m1_FuMo00','BRIG_m1'), ('BRIG_hmo_ShuangShou01a', 'BRIG_hmo_ShuangShou00a')):
				rig_name = rig_name.replace(replace[0], replace[1])

			animKeys.append({'animSeqName': section_name, 'time': section_start_time})

		info = {
			'groupType': 'skelMesh', 
			'name': group_name, 
			'exportType': 'skelMeshActor', 
			'initTrans': {
				'rotaionX': 0, 
				'rotaionY': 0, 
				'rotaionZ': 0, 
				'translationX': offset_pos[0], 
				'translationY': -offset_pos[1], 
				'translationZ': offset_pos[2], 
				'scaleX': 1, 
				'scaleY': 1, 
				'scaleZ': 1
			}, 
			'visibleKeys': [
				{
					'bVisible': True, 
					'time': start_time
				}, 
				{
					'bVisible': False, 
					'time': end_time
				}
			], 
			'animSeq': out_name, 
			'animKeys': animKeys, 
			'assetName': rig_name
		}
		return info

	def get_all_skels():
		all_roots = cmds.ls('*:root') + cmds.ls('*:*:root') + cmds.ls('*:*:*:root')
		all_roots = [node for node in all_roots if 'Envref' not in node]
		return all_roots
		
	def fix_rotate_on( skel ):
		p = cmds.listRelatives(skel, p=1)
		if p:
			p = p[0]
			cmds.parent(skel, w=1)
		else:
			pass

		joint_rot = cmds.getAttr(skel +'.jointOrient')[0]
		cmds.setAttr(skel +'.rotateX', joint_rot[0])
		cmds.setAttr(skel +'.rotateY', joint_rot[1])
		cmds.setAttr(skel +'.rotateZ', joint_rot[2])
		cmds.setAttr(skel +'.jointOrientX', 0)
		cmds.setAttr(skel +'.jointOrientY', 0)
		cmds.setAttr(skel +'.jointOrientZ', 0)
		
			
	def export_all_skel():
		all_skels = get_all_skels()

		(min_inner, max_inner, min_outer, max_outer) = Helper.getTimelineInfo()

		# 要自動分段就開這段
		# ('split_result', [[u'ChangLi:CL:', [[800, 1522]]], [u'XingYuan:XY:', [[800, 1522]]]])
		# split_result = Helper.autoSplitAnimation('Camera', int(min_outer), int(max_outer), map(lambda skel: skel.replace(':root', ':'), all_skels))

		# 不要自動分段就是這段
		split_result = []
		for skel in all_skels:
			split_result.append([skel.replace(':root', ':'), [[min_inner, max_inner]]])

		skel_infos = []
		for skel, split in zip(all_skels, split_result):
			fix_rotate_on(skel)
			skel_infos.append(export_fbx( skel, split[1] ))
			
		return skel_infos
			
			
			
	def get_anchor():
		top_nodes = cmds.ls(assemblies=1)[:]
		anchor = [node for node in top_nodes if ('Envref' in node and 'Landscape' in node) ]
		if len(anchor) > 0:
			return anchor[0]
		return None

	def export_camera(file_path):
		
		mel.eval('FBXPushSettings;')
		mel.eval('FBXExportSmoothingGroups -v true;')
		mel.eval('FBXExportHardEdges -v false;')
		mel.eval('FBXExportTangents -v false;')
		mel.eval('FBXExportSmoothMesh -v true;')
		mel.eval('FBXExportInstances -v false;')
		mel.eval('FBXExportReferencedAssetsContent -v false;')
		mel.eval('FBXExportBakeComplexAnimation -v false;')
		mel.eval('FBXExportAnimationOnly -v false;')
		mel.eval('FBXExportBakeComplexStep -v 1;')
		mel.eval('FBXExportUseSceneName -v false;')
		mel.eval('FBXExportQuaternion -v euler;')
		mel.eval('FBXExportShapes -v true;')
		mel.eval('FBXExportConstraints -v false;')
		mel.eval('FBXExportCameras -v true;')
		mel.eval('FBXExportLights -v false;')
		mel.eval('FBXExportEmbeddedTextures -v false;')
		mel.eval('FBXExportInputConnections -v true;')
		mel.eval('FBXExportInAscii -v true;')
		mel.eval('FBXExportFileVersion -v "FBX201400";')
		mel.eval('FBXExportUpAxis z;')
		mel.eval('FBXExport -f "'+ file_path + '" -s;')
		mel.eval('FBXPopSettings;')

	def export_all_camera():
		shots = cmds.ls(type='shot')

		# 按照shot的start time來排序鏡頭, 這裏不排序的話, 導入ue時會crash
		shots = sorted(shots, key = lambda shot: cmds.shot(shot, startTime=1, q=1) )

		shot_infos = []
		camera_infos = []
		first_camera = None
		for shot in shots:
			cam = cmds.shot(shot, q=1, cc=1)
			if not first_camera: first_camera = cam

			# 不知道爲什麽如果camera有constraint的時候, 他被cmds.shot的api加入sequencer的時候, 在shot裏的名稱就會是cameraShape
			# 這個時候如果直接取出來用的話, 就要把shape拿掉
			cam = cam.replace('Shape', '')

			start_time = cmds.shot(shot, q=1, st=1)
			end_time = cmds.shot(shot, q=1, et=1)+1   
			
			shot_infos.append({
				'camera': shot,
				'Key':start_time / 60
			})
			
			aperture = cmds.getAttr(cam + '.cameraAperture')[0]
			focal_length = cmds.getAttr(cam + '.focalLength')
			init_fov_angle = 2*math.atan(aperture[0] * 12.7/focal_length)*180/3.1415926
			init_aspect_ratio = aperture[0]/aperture[1]
			
			camera_init = get_camera_init(first_camera)
			camera_rot_x = cmds.getAttr(cam + '.rotateX')
			camera_rot_y = cmds.getAttr(cam + '.rotateY')
			camera_rot_z = cmds.getAttr(cam + '.rotateZ')
			camera_infos.append({
				'groupType':'camera',
				'fovFrames':[],
				'name': shot,
				'initAspectRatio':init_aspect_ratio,
				'initFovAngle':init_fov_angle,
				'initTrans':{
					'translationX':camera_init[0],
					'translationY':camera_init[1],
					'translationZ':camera_init[2],
					'rotaionX':camera_rot_x,
					'rotaionY':camera_rot_y,
					'rotaionZ':camera_rot_z,
					'scaleX':1.0,
					'scaleY':1.0,
					'scaleZ':1.0
				},
				'movementKeyFrames':[]
			})
			
			if cam:
				cmds.playbackOptions(min = start_time)
				cmds.playbackOptions(max = end_time)
				cmds.playbackOptions(ast = start_time)
				cmds.playbackOptions(aet = end_time)
				
				temp_camera = Helper.makeGlobalNode(cam, start_time, end_time, ['focalLength', 'focusDistance'])

				cmds.cutKey( temp_camera, time=(start_time-1000000,start_time))
				cmds.cutKey( temp_camera, time=(end_time,end_time+100000))

				add_camera_extra( temp_camera, start_time, end_time )

				cmds.select(cl=1)
				cmds.select(temp_camera)

				export_camera(fbxExportPath + '/' + shot + '.fbx')

				# 刪掉複製出來的camera
				cmds.delete(temp_camera)
				print('copy camera, set attr, export', shot, start_time, end_time )   

		return shot_infos, camera_infos
		
	def get_offset_init():
		if world:
			anchor = get_anchor()
			anchor_pos = cmds.xform(anchor, q=1, ws=1, t=1)
			offset_pos = (-anchor_pos[0], -anchor_pos[1], -anchor_pos[2])
			return offset_pos
		else:
			return (0,0,0)
		
	def get_camera_init(first_camera):
		offset_pos = get_offset_init()
		
		camera = first_camera
		camera_pos = cmds.xform(camera, q=1, ws=1, t=1)
		camera_pos[0] += offset_pos[0]
		camera_pos[1] += -offset_pos[1]
		camera_pos[2] += offset_pos[2]
		return camera_pos
		
	output_json = {
		'UeFolderName':UeFolderName,
		'scriptInfo':{
			'scriptVersion':'Ver_0_1'
		},
		'ueAssetPath':ueAssetPath,
		'fbxExportPath':fbxExportPath,
		'DirectorKeys':[],
		'groups':[],
		'duration':maxFrm / 60.0
	}

	cmds.currentTime(minFrm)
	skel_infos = export_all_skel()
	shot_infos, camera_infos = export_all_camera()
	output_json['DirectorKeys'] += shot_infos
	output_json['groups'] += camera_infos
	output_json['groups'] += skel_infos

	filePath = fbxExportPath + '/' + UeFolderName + '.matinee'
	json.dump(output_json, open(filePath, 'w'), indent=4)