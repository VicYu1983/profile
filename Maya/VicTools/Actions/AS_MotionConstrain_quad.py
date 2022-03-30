# -*- coding: utf-8 -*-
# �w��Advanced Skeleton Motion Data import �@�~
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

# try:import clr 
# except:pass

# if(clr):
# 	clr.AddReference("System")
# 	clr.AddReference("System.Windows.Forms")
# 	import System
# 	import System.Windows.Forms

# mocap �� FK 
mcToFKNmPar = [
["backHip_MoCap_L","FKbackHip_L"],
["backKnee_MoCap_L","FKbackKnee_L"],
["backAnkle_MoCap_L","FKbackAnkle_L"],
#["Toes_MoCap_L","FKToes_L"],

["backHip_MoCap_R","FKbackHip_R"],
["backKnee_MoCap_R","FKbackKnee_R"],
["backAnkle_MoCap_R","FKbackAnkle_R"],
#["Toes_MoCap_R","FKToes_R"],

["Spine1_MoCap_M","FKSpine1_M"],
["Spine2_MoCap_M","FKSpine2_M"],
#["Spine3_MoCap_M","FKSpine3_M"],
#["Spine4_MoCap_M","FKSpine4_M"],
["Chest_MoCap_M","FKChest_M"],
["Head_MoCap_M","FKHead_M"],

["frontRump_MoCap_L","FKfrontRump_L"],
["frontHip_MoCap_L","FKfrontHip_L"],
["frontKnee_MoCap_L","FKfrontKnee_L"],
["frontAnkle_MoCap_L","FKfrontAnkle_L"],

["frontRump_MoCap_R","FKfrontRump_R"],
["frontHip_MoCap_R","FKfrontHip_R"],
["frontKnee_MoCap_R","FKfrontKnee_R"],
["frontAnkle_MoCap_R","FKfrontAnkle_R"],
]

# mocap �� IK �A"_x" �O�ڥt�~�W�[�� Locator
mcToIKNmPar = [
["backAnkle_MoCap_L","IKLegBack_L"],
["L_LegBackMocapPole_x","PoleLegBack_L"],
["backAnkle_MoCap_R","IKLegBack_R"],
["R_LegBackMocapPole_x","PoleLegBack_R"],
["frontAnkle_MoCap_L","IKLegFront_L"],
["L_frontKneeMocapPole_x","PoleLegFront_L"],
["frontAnkle_MoCap_R","IKLegFront_R"],
["R_frontKneeMocapPole_x","PoleLegFront_R"],
["Chest_MoCap_M","IKSpine2_M"]
]

# �w��Ϊ�PoleV�W��
poleVectNameArr =[
["IKXbackKnee_L","PoleLegBack_L","backKnee_MoCap_L","L_LegBackMocapPole_x","backHip_MoCap_L","backAnkle_MoCap_L"],
["IKXfrontKnee_L","PoleLegFront_L","frontKnee_MoCap_L","L_frontKneeMocapPole_x","frontHip_MoCap_L","frontAnkle_MoCap_L"],
["IKXbackKnee_R","PoleLegBack_R","backKnee_MoCap_R","R_LegBackMocapPole_x","backHip_MoCap_R","backAnkle_MoCap_R"],
["IKXfrontKnee_R","PoleLegFront_R","frontKnee_MoCap_R","R_frontKneeMocapPole_x","frontHip_MoCap_R","frontAnkle_MoCap_R"]
]

mcToSkNameArr=[
["Root_M","Root_MoCap_M"],
["Spine1_M","Spine1_MoCap_M"],
["Spine2_M","Spine2_MoCap_M"],
#["Spine3_M","Spine3_MoCap_M"],
#["Spine3_M","Spine4_MoCap_M"],
["frontRump_L","frontRump_MoCap_L"],
["frontRump_R","frontRump_MoCap_R"],
["frontKnee_L","frontKnee_MoCap_L"],
["frontKnee_R","frontKnee_MoCap_R"],
["backHip_L","backHip_MoCap_L"],
["backHip_R","backHip_MoCap_R"],
["backKnee_L","backKnee_MoCap_L"],
["backKnee_R","backKnee_MoCap_R"],
["backAnkle_L","backAnkle_MoCap_L"],
["backAnkle_R","backAnkle_MoCap_R"],
["frontHip_L","frontHip_MoCap_L"],
["frontHip_R","frontHip_MoCap_R"],
["frontAnkle_L","frontAnkle_MoCap_L"],
["frontAnkle_R","frontAnkle_MoCap_R"],
["Neck_M","Neck_MoCap_M"],
["Head_M","Head_MoCap_M"]
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

def getShapes(objList,objWithShpList,_type="mesh",bGetHidden=False):# �w�]���ê��󤣤��B�z
	resultList = []
	for obj in objList:
		if cmds.nodeType(obj) == "transform":
			bProcess=True
			root = (cmds.ls(obj,l=True)[0]).split('|')[1]
			if(not bGetHidden):
				# ���h���u�n�����N�@��parent .visibility �O�����N�O����
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
		# �ˬd�O�_�w���Wskin
		geo = allObj[k]
		objEntry = objList[k]
		buffers = cmds.listHistory(objEntry)
		for buffer in buffers:
			if cmds.nodeType(buffer) == "skinCluster": # �OskelMesh
				sceneSkelMesh.append(geo)
	return sceneSkelMesh


def CreateAsMoCapSk(charname=""): # charname = rgnsp
	cmds.select( charname+":Root_M" )
	bindsk = cmds.duplicate(rr=False)
	bindRoot = bindsk[0]
	cmds.parent(bindRoot,w=True)

	for jnt in bindsk: # jnt = bindsk[1]
		nspl = jnt.split('_')
		nwName = nspl[0]+'_MoCap_'+nspl[1]
		cmds.rename(jnt,nwName)
	return bindsk


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

def gotoFBXMotionPose(charDef):
	mel.eval('hikEnableCharacter( "'+charDef+'", 2 );')
	# ��s�ʧ@��mocap�^���l�i
	tmin = int(cmds.playbackOptions(q=True,minTime=True))
	cmds.currentTime(tmin+1)
	cmds.currentTime(tmin)


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
	constrArr = []

	_fbxCharName = getFBXCharName()
	for k in range(0,len(mcToSkNameArr)): # k = 0
		tgtName = _fbxCharName +":"+mcToSkNameArr[k][0]
		if(len(_fbxCharName ) == 0):
			tgtName = mcToSkNameArr[k][0]
		if(not cmds.objExists(tgtName)):continue
		tr = cmds.xform(tgtName , q=True , t=True,ws=True)
		cmds.xform(mcToSkNameArr[k][1],t=tr,ws=True)
		
		_consRo = cmds.orientConstraint(tgtName,mcToSkNameArr[k][1],mo=False)#
		constrArr.append(_consRo)

	return constrArr

def createHIKMapping(charDef,toolroot=""): # charDef = "mocap_Jnt" 
	
	mel.eval('hikCreateDefinition()')
	mel.eval( 'setCharacterObject("Root_MoCap_M","Character1",1,0);')
	mel.eval( 'setCharacterObject("Spine1_MoCap_M","Character1",8,0);')
	mel.eval( 'setCharacterObject("Spine2_MoCap_M","Character1",23,0);')
	#mel.eval( 'setCharacterObject("Spine3_MoCap_M","Character1",24,0);')
	#mel.eval( 'setCharacterObject("Spine4_MoCap_M","Character1",25,0);')
	mel.eval( 'setCharacterObject("Chest_MoCap_M","Character1",24,0);')
	mel.eval( 'setCharacterObject("frontRump_MoCap_L","Character1",18,0);')
	mel.eval( 'setCharacterObject("frontRump_MoCap_R","Character1",19,0);')
	mel.eval( 'setCharacterObject("frontKnee_MoCap_L","Character1",10,0);')
	mel.eval( 'setCharacterObject("frontKnee_MoCap_R","Character1",13,0);')
	mel.eval( 'setCharacterObject("backHip_MoCap_L","Character1",2,0);')
	mel.eval( 'setCharacterObject("backHip_MoCap_R","Character1",5,0);')
	mel.eval( 'setCharacterObject("backKnee_MoCap_L","Character1",3,0);')
	mel.eval( 'setCharacterObject("backKnee_MoCap_R","Character1",6,0);')
	mel.eval( 'setCharacterObject("backAnkle_MoCap_L","Character1",4,0);')
	mel.eval( 'setCharacterObject("backAnkle_MoCap_R","Character1",7,0);')
	mel.eval( 'setCharacterObject("frontHip_MoCap_L","Character1",9,0);')
	mel.eval( 'setCharacterObject("frontHip_MoCap_R","Character1",12,0);')
	mel.eval( 'setCharacterObject("frontAnkle_MoCap_L","Character1",11,0);')
	mel.eval( 'setCharacterObject("frontAnkle_MoCap_R","Character1",14,0);')
	mel.eval( 'setCharacterObject("Neck_MoCap_M","Character1",20,0);')
	mel.eval( 'setCharacterObject("Head_MoCap_M","Character1",15,0);')

	_string = 'source "'+toolroot+'HIKUpdCurrentSourceFromUI.mel"'
	mel.eval(_string)
	mel.eval('hikUpdCurrentCharacterFromUI("Character1");')
	mel.eval('hikUpdCurrentSourceFromUI("'+charDef+'");')
	mel.eval('hikUpdateContextualUI();')



# �ͦ��w��Ϊ�PoleV �A�H��Mocap ���[�W����
def createPoleMocapLoc(charname,plArr): # plArr =poleVectNameArr charname="rig_200_0011"
	for pl in plArr: # pl = plArr[0]
		_v1 = cmds.xform(charname+":"+pl[0],q=True,ws=True,t=True)
		_v1om = om.MVector(_v1[0] ,_v1[1],_v1[2])
		_v2 = cmds.xform(charname+":"+pl[1],q=True,ws=True,t=True)
		_v2om = om.MVector(_v2[0] ,_v2[1],_v2[2])
		ikdir = _v2om-_v1om
		
		_v3 = cmds.xform(pl[2],q=True,ws=True,t=True)
		_v3om = om.MVector(_v3[0] ,_v3[1],_v3[2])
		newLoc = _v3om + ikdir 
		newLocNd = cmds.spaceLocator()
		cmds.rename(newLocNd,pl[3])
		cmds.xform(pl[3],ws=True,t=(newLoc.x,newLoc.y,newLoc.z))


# �p��s����y��m�A��setkey
def setfrontKneeNewPoleLocation(startNd,midNd,endNd,frontKneeNd):
	start = cmds.xform(startNd ,q= 1 ,ws = 1,t =1 )
	mid = cmds.xform(midNd,q= 1 ,ws = 1,t =1 )
	end = cmds.xform(endNd,q= 1 ,ws = 1,t =1 )
	startV = om.MVector(start[0] ,start[1],start[2])
	midV = om.MVector(mid[0] ,mid[1],mid[2])
	endV = om.MVector(end[0] ,end[1],end[2])
	startEnd = endV - startV
	startMid = midV - startV
	dotP = startMid * startEnd
	proj = float(dotP) / float(startEnd.length())
	startEndN = startEnd.normal()
	projV = startEndN * proj
	arrowV = startMid - projV
	arrowV*= 0.5 
	finalV = arrowV + midV
	cmds.xform(frontKneeNd , ws =1 , t= (finalV.x , finalV.y ,finalV.z))
	cmds.setKeyframe( frontKneeNd+".translate" )

# �C��frame������s�ʵe�D�X�s����y��m
def setPoleLocKeys(charName,pNameArr): # pNameArr =poleVectNameArr charname="man_rig_v05"
	tmin = int(cmds.playbackOptions(q=True,minTime=True))
	tmax = int(cmds.playbackOptions(q=True,maxTime=True))
	for k in range(tmin,tmax+1):
		cmds.currentTime(k)
		for pd in pNameArr: # pd = pNameArr[0]
			setfrontKneeNewPoleLocation(pd[4],pd[2],pd[5],pd[3])
				
	cmds.currentTime(tmin)


# ��l�Ʊ���j�w��mocap sk �W
def snapIKFKCtrlToMo(charName=""): # charName = "man_rig_v05"
	# Pole �ͦ��ó]�w�s��m
	createPoleMocapLoc(charName,poleVectNameArr)
	
	
	constNameArr=[]
	_backHipFKCtrlo = cmds.parentConstraint("Root_MoCap_M",charName+":RootX_M",mo=True)
	#_backHipFKCtrlp = cmds.pointConstraint("Root_MoCap_M",charName+":RootX_M")
	#_backHipFKCtrlo = cmds.orientConstraint("Root_MoCap_M",charName+":RootX_M",mo=True)
	
	## FK Constraint
	for k in range(0,len(mcToFKNmPar)): # k = 1
		_Ctrl = cmds.parentConstraint(mcToFKNmPar[k][0], charName+":"+mcToFKNmPar[k][1],mo=True)#,st="none"
		#_Ctrl = cmds.orientConstraint(mcToFKNmPar[k][0], charName+":"+mcToFKNmPar[k][1])
		constNameArr.append(_Ctrl)
	# �[�J���U�n�R�����M�椺
	#constNameArr.append(_backHipFKCtrlp)
	constNameArr.append(_backHipFKCtrlo)
	

	## IK Constraint
	for k in range(0,len(mcToIKNmPar)): #k=1
		_pCtrl = cmds.pointConstraint(mcToIKNmPar[k][0],charName+":"+mcToIKNmPar[k][1])
		constNameArr.append(_pCtrl)
		_oCtrl = None
		try:
			_oCtrl = cmds.orientConstraint(mcToIKNmPar[k][0],charName+":"+mcToIKNmPar[k][1],mo=True)
		except:pass
		if(_oCtrl):
			constNameArr.append(_oCtrl)
	return constNameArr
	
## Back Mocap �ʧ@����(FK/IK)����W
def bakeCtrlAnim(constNameArr,charName=""): # constNameArr = consNameAr,charName = rgnsp
	# Back �u�@
	setPoleLocKeys(charName,poleVectNameArr)
	# FK �nBack�� Node 
	NdToBake = [charName+":RootX_M"]
	for nds in mcToFKNmPar: # nds=mcToFKNmPar[1]
		NdToBake.append(charName+":"+nds[1])
	for nds in mcToIKNmPar:
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
	# Back ������R�����ݭn���F��
	try:
		cmds.delete("Root_M")
		cmds.delete("Root_MoCap_M")
		cmds.delete("L_LegBackMocapPole_x")
		cmds.delete("L_frontKneeMocapPole_x")
		cmds.delete("R_LegBackMocapPole_x")
		cmds.delete("R_frontKneeMocapPole_x")
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
		


# 
def HIKMotionProcess(toolroot,charPath,savePath): #toolroot = "E:/00Trunk/PY/JoyFunToolSetMaya/00tools/AdvancedSkeleton/scripts/" , # charPath = 
	# �}��FileBrowseDlg �A��M�nimport��fbx file
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
			# charname�}�Y�A�Ocinematic data 
			if('-' in fileN): 
				# �j�M charDir �����Ҧ�char name ����import
				pass


			#�@��C���� data�A�O�����e rig file���@����reference��H
			else: 
				if(len(rigFilePth)==0):
					System.Windows.Forms.MessageBox.Show("�Цܤֶ}�Ҥ@��Rig file �A�}�l��bake motion")
					break
				rgnsp = rigFilePth.split('/')[-1].split('.')[0]
				
				
				#�ɦW�h�� gamebar_
				_filename = (ff.split('\\')[-1]).split('.')[0]
				if("gamebar_" in _filename ):
					_filename = _filename[8:]
				
				# �s���ؼ���
				tgtDir = os.path.dirname(ff)
				tgtFilePth = tgtDir +"\\"+_filename +".ma" 
				if((len(savePath)) and (savePath != None)):
					savePath = savePath.replace('/','\\')
					tgtFilePth = savePath +"\\"+_filename +".ma" 
				
				
				# �s�تťճ���
				cmds.file(f=True,new=True)
				
				# ����FPS30
				cmds.currentUnit(t="ntsc")
				
				# reference rig data
				cmds.file(rigFilePth,r=True,options="v=0",namespace=rgnsp,ignoreVersion=True )
				
				# create mocap sk
				bdsk = CreateAsMoCapSk(rgnsp)
				
				# ����j�w��mocap sk �W
				consNameAr = snapIKFKCtrlToMo(rgnsp)
				
				# �}�limport fbx �ʧ@
				_string = 'source "'+toolroot+'FBXImportModule.mel"'
				mel.eval( _string )
				sv = 'string $res = doImportFbx("'+ff.replace('\\','/')+'");'
				resStr = mel.eval(sv)
				if(resStr != "Success"):break
				
				# ����Fbx��BindPose
				charDefNameFbx = gotoFBXBindPose(toolroot)
				
			
				try:
					#�ץ��s�방�[��m���D(�갩���)
					appendArr = snapMocapSkToFBXLocation(rgnsp)
					consNameAr += appendArr
					# ����j�w
					#doFingerConstraint(consNameAr,rgnsp)
				except:pass
				
				# ����Fbx��MotionPose ��l�i
				gotoFBXMotionPose(charDefNameFbx)
				
				# �ʧ@Baking �çR���h�l���
				bakeCtrlAnim(consNameAr,rgnsp)
				
				# �t�s�s�� 
				cmds.file(rename=tgtFilePth)
				cmds.file(save=True,type='mayaAscii')
				
	# �j�McharPath
	return
	


# ��Main control 
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

def findControls(ctrlNameArr,charName=""):
	ret = []
	rfNds = cmds.ls(rn=True)
	
	for nm in ctrlNameArr:
		nfd = charName+":"+nm
		for rnd in rfNds: # rnd = rfNds[5]
			#bufs = cmds.listRelatives(rnd, fullPath=True, shapes=True)
			#if(bufs):
			if( nfd in rnd ): #( cmds.nodeType(bufs[0]) == "nurbsCurve" ) and 
				ret.append(rnd)
				break
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

# root �����k0
def setRootToZero():
	
	# get root dif
	dif = om.MVector()
	_rootJnt,_main = findMainAndRootJnt()
	
	if(_main):
		root_x = mel.eval( 'getAttr "%s.rotateX"' % _main )
		root_y = mel.eval( 'getAttr "%s.rotateY"' % _main )
		root_z = mel.eval( 'getAttr "%s.rotateZ"' % _main )
		
		mel.eval( 'setAttr "%s.rotateX" %i' % (_main, 0))
		mel.eval( 'setAttr "%s.rotateY" %i' % (_main, 0))
		mel.eval( 'setAttr "%s.rotateZ" %i' % (_main, 0))
		
		ctrlNameArr = [
		'RootX_M',
		'IKLegFront_L',
		'IKLegFront_R',
		'PoleLegFront_L',
		'PoleLegFront_R',
		'IKLegBack_L',
		'IKLegBack_R',
		] # ���\����
		ctrlsToMov = findControls(ctrlNameArr) 
		if(len(ctrlsToMov)):
			
			_xmPos = cmds.xform(ctrlsToMov[0],q=True,ws=True,t=True)
			_xmPosOm = om.MVector(_xmPos[0] ,_xmPos[1],_xmPos[2])
			_mainPos= cmds.xform(_main,q=True,ws=True,t=True)
			_mainPosOm = om.MVector(_mainPos[0],_mainPos[1],_mainPos[2])
			dif = _mainPosOm-_xmPosOm
			
			dify = 0
			# ��������e�� skelemesh
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
		
		mel.eval( 'setAttr "%s.rotateX" %i' % (_main, root_x) )
		mel.eval( 'setAttr "%s.rotateY" %i' % (_main, root_y) )
		mel.eval( 'setAttr "%s.rotateZ" %i' % (_main, root_z) )




# ��Main control �ù��qtime range �k0
def setRootToZeroTimeRanged():
	ctrlNameArr = ['RootX_M','Main']
	ctrlsToMov = findControls(ctrlNameArr) 
	if(len(ctrlsToMov)):
		cmds.select(ctrlsToMov[0])
		cmds.copyKey(ctrlsToMov[0],at="tx")
		cmds.pasteKey(ctrlsToMov[1],connect=True,at="tx")
		cmds.copyKey(ctrlsToMov[0],at="tz")
		cmds.pasteKey(ctrlsToMov[1],connect=True,at="tz")
		
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
	               'FKfrontHip_L',
	               'FKfrontHip_R',
	               'FKfrontKnee_L',
	               'FKfrontKnee_R',
	               'FKfrontAnkle_L',
	               'FKfrontAnkle_R',
	               'FKSpine1_M',
	               'FKSpine2_M',
	               'FKSpine3_M',
	               #'FKSpine4_M',
	               'FKbackHip_L',
	               'FKbackHip_R',
	               'FKbackKnee_L',
	               'FKbackKnee_R',
	               'FKbackAnkle_L',
	               'FKbackAnkle_R',
	              ]
	
	ctrlNameArrIK = [
	               'IKXfrontHip_L',
	               'IKXfrontHip_R',
	               'IKXfrontKnee_L',
	               'IKXfrontKnee_R',
	               'IKLegFront_L',
	               'IKLegFront_R',
	               'IKXSpine1_M',
	               'IKXSpine2_M',
	               'IKXSpine3_M',
	               #'IKXSpine4_M',
	               'IKXbackHip_L',
	               'IKXbackHip_R',
	               'IKXbackKnee_L',
	               'IKXbackKnee_R',
	               'IKLegBack_L',
	               'IKLegBack_R'
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
				if(':FKfrontAnkle_L' in ctrlsFK[c]):
					maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.lLegFrontLclTm)
				elif (':FKfrontAnkle_R' in ctrlsFK[c]):
					maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.rLegFrontLclTm)
				elif (':FKbackAnkle_L' in ctrlsFK[c]):
					maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.lLegBackLclTm)
				elif (':FKbackAnkle_R' in ctrlsFK[c]):
					maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.rLegBackLclTm)
				else:
					cmds.xform(ctrlsFK[c],ro=rod ,ws=True)
				
				cmds.setKeyframe( ctrlsFK[c]+".rotate" )
			# �o�{�u���@���|�����t�A��]����
			# �@�������A���A�����ĤG����?
			for c in range(0,len(ctrlsIK)) : # c = 4
				rod = cmds.xform(ctrlsIK[c],q=True,ro=True,ws=True)
				if(':FKfrontAnkle_L' in ctrlsFK[c]):
					maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.lLegFrontLclTm)
				elif (':FKfrontAnkle_R' in ctrlsFK[c]):
					maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.rLegFrontLclTm)
				elif (':FKbackAnkle_L' in ctrlsFK[c]):
					maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.lLegBackLclTm)
				elif (':FKbackAnkle_R' in ctrlsFK[c]):
					maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.rLegBackLclTm)
				else:
					cmds.xform(ctrlsFK[c],ro=rod ,ws=True)
				
				cmds.setKeyframe( ctrlsFK[c]+".rotate" )
				
		cmds.currentTime(tmin)
	else:
		for c in range(0,len(ctrlsIK)) : # c = 4
			rod = cmds.xform(ctrlsIK[c],q=True,ro=True,ws=True)
			if(':FKfrontAnkle_L' in ctrlsFK[c]):
				maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.lLegFrontLclTm)
			elif (':FKfrontAnkle_R' in ctrlsFK[c]):
				maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.rLegFrontLclTm)
			elif (':FKbackAnkle_L' in ctrlsFK[c]):
				maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.lLegBackLclTm)
			elif (':FKbackAnkle_R' in ctrlsFK[c]):
				maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.rLegBackLclTm)
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
				   'FKfrontAnkle_L',
				   'FKfrontAnkle_R',
				   'FKRoot_M',
				   'FKChest_M',
				   'FKbackAnkle_L',
				   'FKbackAnkle_R',
				  ]
	
	ctrlNameArrIK = [
				   'IKLegFront_L',
				   'IKLegFront_R',
				   'IKSpine2_M',
				   'IKSpine1_M',
				   'IKLegBack_L',
				   'IKLegBack_R'
				  ]
	
	LegFrontLPoleCtrlName = ["FKfrontHip_L","FKfrontKnee_L","FKfrontAnkle_L" ,"PoleLegFront_L"]
	LegFrontRPoleCtrlName = ["FKfrontHip_R","FKfrontKnee_R","FKfrontAnkle_R" ,"PoleLegFront_R"]
	LegBackLPoleCtrlName = ["FKbackHip_L","FKbackKnee_L","FKbackAnkle_L" ,"PoleLegBack_L"]
	LegBackRPoleCtrlName = ["FKbackHip_R","FKbackKnee_R","FKbackAnkle_R" ,"PoleLegBack_R"]

	ctrlsFK = findControls(ctrlNameArrFK,charName) 
	ctrlsIK = findControls(ctrlNameArrIK,charName) 

	LegFrontLPoleCtrl = findControls(LegFrontLPoleCtrlName,charName )
	LegFrontRPoleCtrl = findControls(LegFrontRPoleCtrlName,charName )
	LegBackLPoleCtrl = findControls(LegBackLPoleCtrlName,charName )
	LegBackRPoleCtrl = findControls(LegBackRPoleCtrlName,charName )

	
	if((not len(ctrlsFK) ) or (len(ctrlsIK) != len(ctrlsFK) ) ):return
	
	if(bAnim):
		tmin = int(cmds.playbackOptions(q=True,minTime=True))
		tmax = int(cmds.playbackOptions(q=True,maxTime=True))
		for k in range(tmin,tmax+1):
			cmds.currentTime(k)
			for c in range(0,len(ctrlsIK)) : # c = 4
				if(':IKLegFront_L' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.lLegFrontLclTm_IK)
				elif(':IKLegFront_R' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.rLegFrontLclTm_IK)
				elif(':IKLegBack_L' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.lLegBackLclTm_IK)
				elif(':IKLegBack_R' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.rLegBackLclTm_IK)
				elif(':IKXSpine1_M' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.spine0LclTm_IK)
				elif(':IKXSpine2_M' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.spine1LclTm_IK)
				
				cmds.setKeyframe( ctrlsIK[c]+".rotate" )
				cmds.setKeyframe( ctrlsIK[c]+".translate" )
			# ��s��y��m
			setfrontKneeNewPoleLocation(LegFrontLPoleCtrl[0],LegFrontLPoleCtrl[1],LegFrontLPoleCtrl[2],LegFrontLPoleCtrl[3])
			setfrontKneeNewPoleLocation(LegFrontRPoleCtrl[0],LegFrontRPoleCtrl[1],LegFrontRPoleCtrl[2],LegFrontRPoleCtrl[3])
			setfrontKneeNewPoleLocation(LegBackLPoleCtrl[0],LegBackLPoleCtrl[1],LegBackLPoleCtrl[2],LegBackLPoleCtrl[3])
			setfrontKneeNewPoleLocation(LegBackRPoleCtrl[0],LegBackRPoleCtrl[1],LegBackRPoleCtrl[2],LegBackRPoleCtrl[3])
			
			# �o�{�u���@���|�����t�A��]����
			# �@�������A���A�����ĤG����?
			for c in range(0,len(ctrlsIK)) : # c = 4
				if(':IKLegFront_L' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.lLegFrontLclTm_IK)
				elif(':IKLegFront_R' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.rLegFrontLclTm_IK)
				elif(':IKLegBack_L' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.lLegBackLclTm_IK)
				elif(':IKLegBack_R' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.rLegBackLclTm_IK)
				elif(':IKXSpine1_M' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.spine0LclTm_IK)
				elif(':IKXSpine2_M' in ctrlsIK[c]):
					maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.spine1LclTm_IK)
				
				cmds.setKeyframe( ctrlsIK[c]+".rotate" )
				cmds.setKeyframe( ctrlsIK[c]+".translate" )
			
			# ��s��y��m
			setfrontKneeNewPoleLocation(LegFrontLPoleCtrl[0],LegFrontLPoleCtrl[1],LegFrontLPoleCtrl[2],LegFrontLPoleCtrl[3])
			setfrontKneeNewPoleLocation(LegFrontRPoleCtrl[0],LegFrontRPoleCtrl[1],LegFrontRPoleCtrl[2],LegFrontRPoleCtrl[3])
			setfrontKneeNewPoleLocation(LegBackLPoleCtrl[0],LegBackLPoleCtrl[1],LegBackLPoleCtrl[2],LegBackLPoleCtrl[3])
			setfrontKneeNewPoleLocation(LegBackRPoleCtrl[0],LegBackRPoleCtrl[1],LegBackRPoleCtrl[2],LegBackRPoleCtrl[3])
			
		cmds.currentTime(tmin)
	else:
		for c in range(0,len(ctrlsIK)) : # c = 4
			if(':IKLegFront_L' in ctrlsIK[c]):
				maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.lLegFrontLclTm_IK)
			elif(':IKLegFront_R' in ctrlsIK[c]):
				maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.rLegFrontLclTm_IK)
			elif(':IKLegBack_L' in ctrlsIK[c]):
				maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.lLegBackLclTm_IK)
			elif(':IKLegBack_R' in ctrlsIK[c]):
				maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.rLegBackLclTm_IK)
			elif(':IKXSpine1_M' in ctrlsIK[c]):
				maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.spine0LclTm_IK)
			elif(':IKXSpine2_M' in ctrlsIK[c]):
				maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],maxs.spine1LclTm_IK)
			
			cmds.setKeyframe( ctrlsIK[c]+".rotate" )
			cmds.setKeyframe( ctrlsIK[c]+".translate" )
		# ��s��y��m
		setfrontKneeNewPoleLocation(LegFrontLPoleCtrl[0],LegFrontLPoleCtrl[1],LegFrontLPoleCtrl[2],LegFrontLPoleCtrl[3])
		setfrontKneeNewPoleLocation(LegFrontRPoleCtrl[0],LegFrontRPoleCtrl[1],LegFrontRPoleCtrl[2],LegFrontRPoleCtrl[3])
		setfrontKneeNewPoleLocation(LegBackLPoleCtrl[0],LegBackLPoleCtrl[1],LegBackLPoleCtrl[2],LegBackLPoleCtrl[3])
		setfrontKneeNewPoleLocation(LegBackRPoleCtrl[0],LegBackRPoleCtrl[1],LegBackRPoleCtrl[2],LegBackRPoleCtrl[3])

# �ͦ������I����A�H�� root �W
def generateCapsule():
	if(cmds.objExists("capsule_geo")):return
	
	bQuadroped = False # �O�_���|��
	shdLPos = None
	shdRPos = None
	if(cmds.objExists("frontHip_L")):
		shdLPos = cmds.xform("frontHip_L",q=True,ws=True,t=True)
	elif(cmds.objExists("JawEnd_M")):
		shdLPos = cmds.xform("JawEnd_M",q=True,ws=True,t=True)
		bQuadroped = True
		
	if(cmds.objExists("frontHip_R")):
		shdRPos = cmds.xform("frontHip_R",q=True,ws=True,t=True)
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
	
# �ͦ�4��layer "Controller" "Capsule" "Mesh" "Joint"
# ��z�򥻪���
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

def addObjsToLayer(layerName,objSets): #layerName = "Controller" nd = "PoleLegFront_R"
	for nd in objSets :
		cmds.connectAttr(layerName+".drawInfo",nd+".drawOverride")


def asAfterBuildJoyFunModified():
	generateCapsule()
	assortBasicLayers()
	
	allCtrlObj = []
	getShapes(getAllObjects(),allCtrlObj ,_type="nurbsCurve",bGetHidden=True)
	
	capsuLegBackrpName = ['capsule_geo']
	meshGrpName = getSceneSkelMeshs()
	jntGrpName = ['root']
	
	try:
		addObjsToLayer("Controller",allCtrlObj)
		addObjsToLayer("Capsule",capsuLegBackrpName)
		addObjsToLayer("Mesh",meshGrpName)
		addObjsToLayer("Joint",jntGrpName)
	
		# ��4�ӷФH��node �b���@�֬�F
		cmds.delete("mentalrayGlobals")
		cmds.delete("mentalrayItemsList")
		cmds.delete("miDefaultFramebuffer")
		cmds.delete("miDefaultOptions")
	except:pass


# ��襤�� cluster �ন Joint Chain & �[�J���
def turnClustersToJntChain(bOrderByNum=False,baseJntName="joint"):
	__obj = []
	sel = cmds.ls(sl=True)
	selShps = getShapes(sel,__obj ,_type='clusterHandle')
	jntArray = [] # �̫᧹����joint array
	cmds.select(cl=True)
	for i in range(0,len(sel)): # i = 0
		jntName = baseJntName+"_"+str(i)
		if(i<10):
			jntName = baseJntName+"_0"+str(i)
		thisNd = sel[i]
		thisNdShp = selShps[i]
		
		curPos = [0,0,0]
		try: # cluster �n�쪺�Oorigin
			orig = cmds.getAttr(thisNdShp +".origin")[0]
			_Pos = cmds.xform(thisNd, q=True,t=True,ws=True)
			curPos = [(orig[0]+_Pos[0]),(orig[1]+_Pos[1]),(orig[2]+_Pos[2])]
		except:pass
		jnt = cmds.joint(n=jntName,p=curPos)
		jntArray.append(jntName)
