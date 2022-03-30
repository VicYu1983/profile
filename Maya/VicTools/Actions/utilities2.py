# -*- coding: utf-8 -*-
# ��L�\�� in Advanced Skeleton
# Last Modified 2015/08/31
# Author Chih Lun Kang

import maya.cmds as cmds
import maya.mel as mel
import sys,os
import __builtin__
import maya.OpenMaya as om
import maya.OpenMayaAnim as omAnim
import maya.OpenMayaMPx as OpenMayaMPx
import MatrixSwitchAxis as maxs

if int(cmds.about(version=True)) >= 2017:
	from PySide2 import QtGui
else:
	from PySide import QtGui

# try:import clr 
# except:pass

# if(clr):
# 	clr.AddReference("System")
# 	clr.AddReference("System.Windows.Forms")
# 	import System
# 	import System.Windows.Forms
# 	from DotNet import WinForms
# 	reload(WinForms)

controlNameBiped=[
"HipSwinger_M",
"IKSpine1_M",
"IKSpine2_M",
"IKLeg_R",
"RollToesEnd_R",
"RollHeel_R",
"RollToes_R",
"PoleLeg_R",
"IKArm_R",
"PoleArm_R",
"IKLeg_L",
"RollHeel_L",
"RollToesEnd_L",
"RollToes_L",
"PoleLeg_L",
"IKArm_L",
"PoleArm_L",
"FKIKLeg_R",
"FKIKLeg_L",
"FKIKArm_R",
"FKIKSpine_M",
"FKIKArm_L",
"AimEye_M",
"AimEye_L",
"AimEye_R",
"RootX_M",
"Fingers_R",
"Fingers_L",
"root_ctrl",
"Main",
"FKToes_R",
"FKToes1_R",
"FKToes2_R",
"FKHip_R",
"FKHip_L",
"FKKnee_L",
"FKKnee_R",
"FKAnkle_R",
"FKAnkle_L",
"FKMiddleFinger1_R",
"FKMiddleFinger2_R",
"FKThumbFinger1_R",
"FKThumbFinger2_R",
"FKMiddleFinger3_R",
"FKThumbFinger3_R",
"FKIndexFinger1_R",
"FKIndexFinger2_R",
"FKIndexFinger3_R",
"FKPinkyFinger1_R",
"FKCup_R",
"FKPinkyFinger2_R",
"FKRingFinger1_R",
"FKRingFinger2_R",
"FKPinkyFinger3_R",
"FKShoulder_R",
"FKElbow_R",
"FKRingFinger3_R",
"FKWrist_R",
"FKScapula_R",
"FKNeck_M",
"FKHead_M",
"FKJaw_M",
"FKRoot_M",
"FKEye_R",
"FKEye_L",
"FKScapula_L",
"FKSpine2_M",
"FKChest_M",
"FKSpine3_M",
"FKSpine1_M",
"FKToes_L",
"FKToes1_L",
"FKToes2_L",
"FKMiddleFinger3_L",
"FKThumbFinger1_L",
"FKMiddleFinger1_L",
"FKMiddleFinger2_L",
"FKThumbFinger2_L",
"FKPinkyFinger3_L",
"FKPinkyFinger2_L",
"FKRingFinger2_L",
"FKRingFinger3_L",
"FKRingFinger1_L",
"FKShoulder_L",
"FKElbow_L",
"FKWrist_L",
"FKThumbFinger3_L",
"FKIndexFinger1_L",
"FKIndexFinger3_L",
"FKIndexFinger2_L",
"FKPinkyFinger1_L",
"FKCup_L",

# 這邊是二代獸首妖多出來的部位。之後要做個整理。最好是可以從命名規則下直接用規則尋找，而不是寫死在這裏
u'FKHip_R', u'Main', u'FKKnee_R', u'FKAnkle_R', u'FKToes1_R', u'FKToes2_R', u'FKHip_L', u'FKKnee_L', u'FKAnkle_L', u'FKToes1_L', u'FKToes2_L', u'FKMiddleFinger1_R', u'FKMiddleFinger2_R', u'FKMiddleFinger3_R', u'FKThumbFinger1_R', u'FKThumbFinger2_R', u'FKThumbFinger3_R', u'FKIndexFinger1_R', u'FKIndexFinger2_R', u'FKIndexFinger3_R', u'FKCup_R', u'FKRingFinger1_R', u'FKRingFinger2_R', u'FKRingFinger3_R', u'FKPinkyFinger1_R', u'FKPinkyFinger2_R', u'FKPinkyFinger3_R', u'FKShoulder_R', u'FKElbow_R', u'FKWrist_R', u'FKScapula_R', u'FKNeck_M', u'FKNeck1_M', u'FKNeck2_M', u'FKHead_M', u'FKJaw_M', u'FKEar_R', u'FKEar1_R', u'FKEar_L', u'FKEar1_L', u'FKEye_R', u'FKEye_L', u'FKScapula_L', u'FKRoot_M', u'FKSpine1_M', u'FKSpine2_M', u'FKChest_M', u'FKMiddleFinger1_L', u'FKMiddleFinger2_L', u'FKMiddleFinger3_L', u'FKThumbFinger1_L', u'FKThumbFinger2_L', u'FKThumbFinger3_L', u'FKIndexFinger1_L', u'FKIndexFinger2_L', u'FKIndexFinger3_L', u'FKCup_L', u'FKRingFinger1_L', u'FKRingFinger2_L', u'FKRingFinger3_L', u'FKPinkyFinger1_L', u'FKPinkyFinger2_L', u'FKPinkyFinger3_L', u'FKShoulder_L', u'FKElbow_L', u'FKWrist_L', u'HipSwinger_M', u'IKLeg_R', u'RollHeel_R', u'RollToesEnd_R', u'IKToes2_R', u'RollToes2_R', u'RollToes1_R', u'PoleLeg_R', u'IKArm_R', u'PoleArm_R', u'IKcvSpine1_M', u'IKcvSpine2_M', u'IKSpine2_M', u'IKSpine3_M', u'IKSpine1_M', u'IKLeg_L', u'RollHeel_L', u'RollToesEnd_L', u'IKToes2_L', u'RollToes2_L', u'RollToes1_L', u'PoleLeg_L', u'IKArm_L', u'PoleArm_L', u'FKIKLeg_R', u'FKIKArm_R', u'FKIKSpine_M', u'FKIKLeg_L', u'FKIKArm_L', u'AimEye_M', u'AimEye_R', u'AimEye_L', u'RootX_M', u'Fingers_R', u'Fingers_L', u'root_ctrl'

# 這是二代花妖的部分
u'FitSkeleton', u'Main', u'FKToes_R', u'FKHip_R', u'FKKnee_R', u'FKAnkle_R', u'FKHip_L', u'FKKnee_L', u'FKAnkle_L', u'FKThumbFinger1_R', u'FKThumbFinger2_R', u'FKThumbFinger3_R', u'FKThumbFinger4_R', u'FKThumbFinger5_R', u'FKIndexFinger1_R', u'FKIndexFinger2_R', u'FKIndexFinger3_R', u'FKIndexFinger4_R', u'FKIndexFinger5_R', u'FKMiddleFinger1_R', u'FKMiddleFinger2_R', u'FKMiddleFinger3_R', u'FKMiddleFinger4_R', u'FKMiddleFinger5_R', u'FKRingFinger1_R', u'FKRingFinger2_R', u'FKRingFinger3_R', u'FKRingFinger4_R', u'FKRingFinger5_R', u'FKPinkyFinger1_R', u'FKPinkyFinger2_R', u'FKPinkyFinger3_R', u'FKPinkyFinger4_R', u'FKPinkyFinger5_R', u'FKPinky2Finger1_R', u'FKPinky2Finger2_R', u'FKPinky2Finger3_R', u'FKPinky2Finger4_R', u'FKPinky2Finger5_R', u'FKShoulder_R', u'FKElbow_R', u'FKWrist_R', u'FKScapula_R', u'FKNeck_M', u'FKHead_M', u'FKScapula_L', u'FKRoot_M', u'FKSpine1_M', u'FKChest_M', u'FKToes_L', u'FKShoulder_L', u'FKElbow_L', u'FKWrist_L', u'HipSwinger_M', u'IKSpine1_M', u'IKSpine2_M', u'IKLeg_R', u'RollHeel_R', u'RollToesEnd_R', u'RollToes_R', u'PoleLeg_R', u'IKArm_R', u'PoleArm_R', u'IKLeg_L', u'RollHeel_L', u'RollToesEnd_L', u'RollToes_L', u'PoleLeg_L', u'IKArm_L', u'PoleArm_L', u'IKSpineCurve_M', u'FKIKLeg_R', u'FKIKArm_R', u'FKIKSpine_M', u'FKIKLeg_L', u'FKIKArm_L', u'BendElbowCurve_R', u'BendElbow1_R', u'BendElbow2_R', u'BendShoulderCurve_R', u'BendShoulder1_R', u'BendShoulder2_R', u'BendElbowCurve_L', u'BendElbow1_L', u'BendElbow2_L', u'BendShoulderCurve_L', u'BendShoulder1_L', u'BendShoulder2_L', u'RootX_M', u'Fingers_R', u'root_ctrl',

# 二代魍魎
u'FKMiddleFinger1_R', u'Main', u'FKMiddleFinger2_R', u'FKMiddleFinger3_R', u'R_MidNail_crl', u'FKThumbFinger1_R', u'FKThumbFinger2_R', u'FKThumbFinger3_R', u'R_ThumbNail_crl', u'FKIndexFinger1_R', u'FKIndexFinger2_R', u'FKIndexFinger3_R', u'R_IndexNail_crl', u'FKCup_R', u'FKPinkyFinger1_R', u'FKPinkyFinger2_R', u'FKPinkyFinger3_R', u'R_PinkyNail_crl', u'FKShoulder_R', u'FKElbow_R', u'FKWrist_R', u'FKScapula_R', u'FKNeck1_M', u'FKNeck_M', u'FKHead_M', u'FKJaw_M', u'FKEar1_R', u'FKEar2_R', u'FKtongue1_M', u'FKtongue2_M', u'FKtongue3_M', u'FKEar1_L', u'FKEar2_L', u'FKEye_R', u'FKEye_L', u'FKScapula_L', u'FKMiddleToe1_R', u'FKMiddleToe2_R', u'FKPinkyToe1_R', u'FKPinkyToe2_R', u'FKIndexToe1_R', u'FKIndexToe2_R', u'FKThumbToe1_R', u'FKThumbToe2_R', u'FKThumbToe3_R', u'FKTail0_M', u'FKTail1_M', u'FKTail2_M', u'FKTail3_M', u'FKTail4_M', u'FKTail5_M', u'FKTail6_M', u'FKTail7_M', u'FKTail9_M', u'FKTail8_M', u'FKRoot_M', u'FKSpine1_M', u'FKSpine2_M', u'FKChest_M', u'FKMiddleFinger1_L', u'FKMiddleFinger2_L', u'FKMiddleFinger3_L', u'L_MidNail_crl', u'FKThumbFinger1_L', u'FKThumbFinger2_L', u'FKThumbFinger3_L', u'L_ThumbNail_cr', u'FKIndexFinger1_L', u'FKIndexFinger2_L', u'FKIndexFinger3_L', u'L_IndexNail_crl', u'FKCup_L', u'FKPinkyFinger1_L', u'FKPinkyFinger2_L', u'FKPinkyFinger3_L', u'L_PinkyNail_crl', u'FKShoulder_L', u'FKElbow_L', u'FKWrist_L', u'FKMiddleToe1_L', u'FKMiddleToe2_L', u'FKPinkyToe1_L', u'FKPinkyToe2_L', u'FKIndexToe1_L', u'FKIndexToe2_L', u'FKThumbToe1_L', u'FKThumbToe2_L', u'FKThumbToe3_L', u'HipSwinger_M', u'IKLeg_R', u'RollHeel_R', u'RollLongToe4_R', u'RollToes2_R', u'RollToes1_R', u'PoleLeg_R', u'IKLeg_L', u'RollHeel_L', u'RollLongToe4_L', u'RollToes2_L', u'RollToes1_L', u'PoleLeg_L', u'FKIKArm_R', u'FKIKLeg_R', u'FKIKSplineTail_M', u'FKIKSpine_M', u'FKIKArm_L', u'FKIKLeg_L', u'AimEye_M', u'AimEye_R', u'AimEye_L', u'RootX_M', u'Fingers_R', u'Fingers_L', u'root_ctrl', u'Horn_CRL_R', u'Horn_CRL2_R', u'Horn_CRL_L', u'Horn_CRL2_L'

]

controlNameQuad=[
"Main",
"FKbackToes_R",
"FKTail0_M",
"FKbackRump_R",
"FKbackRump_L",
"FKfrontToes_R",
"clawThumb01_R_ctrl",
"clawThumb02_R_ctrl",
"clawIndex01_R_ctrl",
"clawIndex02_R_ctrl",
"clawMiddle01_R_ctrl",
"clawMiddle02_R_ctrl",
"clawRing01_R_ctrl",
"clawRing02_R_ctrl",
"clawPinky01_R_ctrl",
"clawPinky02_R_ctrl",
"FKNeck_M",
"FKNeck1_M",
"FKHead_M",
"FKJaw_M",
"FKEye_R",
"FKEar_R",
"FKEye_L",
"FKEar_L",
"mouthFat_L_ctrl",
"mouthFat_R_ctrl",
"EyeSkin_RU_ctrl",
"EyeSkin_RD_ctrl",
"EyeSkin_LU_ctrl",
"EyeSkin_LD_ctrl",
"FKfrontRump_R",
"FKfrontRump_L",
"FKRoot_M",
"FKSpine1_M",
"FKSpine2_M",
"FKChest_M",
"FKbackToes_L",
"FKfrontToes_L",
"clawPinky01_L_ctrl",
"clawPinky02_L_ctrl",
"clawRing01_L_ctrl",
"clawRing02_L_ctrl",
"clawMiddle01_L_ctrl",
"clawMiddle02_L_ctrl",
"clawIndex01_L_ctrl",
"clawIndex02_L_ctrl",
"clawThumb01_L_ctrl",
"clawThumb02_L_ctrl",
"HipSwinger_M",
"IKLegBack_R",
"RollHeelBack_R",
"RollLongToe31_R",
"RollbackToes_R",
"PoleLegBack_R",
"IKLegFront_R",
"RollHeelFront_R",
"RollLongToe3_R",
"RollfrontToes_R",
"PoleLegFront_R",
"IKLegBack_L",
"RollHeelBack_L",
"RollLongToe31_L",
"RollbackToes_L",
"PoleLegBack_L",
"IKLegFront_L",
"RollHeelFront_L",
"RollLongToe3_L",
"RollfrontToes_L",
"PoleLegFront_L",
"FKIKLegBack_R",
"FKIKLegFront_R",
"FKIKSpine_M",
"FKIKLegBack_L",
"FKIKLegFront_L",
"RootX_M",
"root_ctrl",
"FKfrontAnkle_R",
"FKfrontAnkle_L",
"FKfrontKnee_R",
"FKfrontKnee_L",
"FKfrontHip_L",
"FKfrontHip_R",
"FKfrontRump_R",
"FKfrontRump_L",
"FKbackAnkle_R",
"FKbackAnkle_L",
"FKbackKnee_R",
"FKbackKnee_L",
"FKbackHip_R",
"FKbackHip_L",
"FKbackRump_R",
"FKbackRump_L",
"IKSpine1_M",
"IKSpine2_M"
]

def checkIsQuad():
	froRumpNm = "FKfrontRump_L"
	bQuad = False
	if (cmds.objExists(froRumpNm)):
		bQuad=True
	if(not bQuad):
		ret = []
		rfNds = cmds.ls(rn=True)
		nfd = ":"+froRumpNm
		for rnd in rfNds: 
			if( nfd in rnd ):
				ret.append(rnd)
				break
		if(len(ret)):
			bQuad=True
	return bQuad


def selAllCtrlQuad():
	selectNameSpace = ""
	sel = cmds.ls(sl=True)
	for op in sel:
		if (":"in op):
			selectNameSpace = op.split(':')[0]
			
	for Nd in controlNameQuad:
		if (cmds.objExists(Nd)):
			cmds.select( Nd, add=True )
	
	rfNds = cmds.ls(rn=True)
	for Nd in controlNameQuad: # Nd = controlNameQuad[0]
		for rnd in rfNds: # rnd = rfNds[0]
			if( ":" in rnd ):
				nameSpace = rnd.split(':')[0]
				if(len(selectNameSpace)):
					nameSpace = selectNameSpace
				askName = nameSpace + ":" + Nd
				if(askName == rnd):
					cmds.select( rnd, add=True )

def selAllCtrlBiped():
	# selectNameSpace = ""
	# sel = cmds.ls(sl=True)
	# for op in sel:
	# 	if (":"in op):
	# 		selectNameSpace = op.split(':')[0]
		
	
	# for Nd in controlNameBiped:
	# 	if (cmds.objExists(Nd)):
	# 		cmds.select( Nd, add=True )
	
	# rfNds = cmds.ls(rn=True)
	# for Nd in controlNameBiped: # Nd = controlNameBiped[0]
	# 	for rnd in rfNds: # rnd = rfNds[0]
	# 		if( ":" in rnd ):
	# 			nameSpace = rnd.split(':')[0]
	# 			if(len(selectNameSpace)):
	# 				nameSpace = selectNameSpace
	# 			askName = nameSpace + ":" + Nd
	# 			#print askName
	# 			if(askName == rnd):
	# 				cmds.select( rnd, add=True )

	

	def _selectAll( selList ):
		for layer in cmds.ls(type="displayLayer"):
			if "Controller" in layer:
				cmds.select(layer)
				selList += cmds.listHistory(layer,f=1)
				selList.remove( layer )
				cmds.select(layer,d=1)

	selList = []
	if len(cmds.ls(sl=1)) == 0:
		_selectAll(selList)
	else:
		layer = cmds.listConnections(t="displayLayer")
		if layer == None:
			_selectAll(selList)

			msgBox = QtGui.QMessageBox()
			msgBox.setText(u"找不到物件的圖層，選取全部")
			msgBox.exec_()
		else:
			cmds.select(layer)
			selList += cmds.listHistory(layer,f=1)
			selList.remove( layer[0] )
			cmds.select(layer,d=1)

	# 過濾掉FKIK切換的節點
	# selList = [ctrl for ctrl in selList if "FKIK" not in ctrl]
	cmds.select(selList)

# �u�X��������
# def getAsJoyfunToolDesc1():
# 	try:
# 		__builtin__.g_asJoyfunToolDesc1.Close()
# 	except:
# 		pass
# 	_size = [500,500]
# 	__builtin__.g_asJoyfunToolDesc1 = WinForms.GUI(cls='Form',size=_size ,text="����")
# 	_Form = __builtin__.g_asJoyfunToolDesc1
# 	_bc=System.Drawing.Color.DimGray
# 	panelVeh = WinForms.GUI(cls='Panel',size=_size ,pos=[0,0],bc=_bc,p=_Form)
# 	text_d1 = "Studio Library : �ʵe�� Pose �u��"
# 	lbbNam1 = WinForms.GUI(cls='Label',size=[400,40],pos=[20,20],bc=_bc,text=text_d1,p=panelVeh)
# 	text_d2 = "Dora Skin Weight Tool : �s�X�v���u��"
# 	lbbNam2 = WinForms.GUI(cls='Label',size=[400,40],pos=[20,60],bc=_bc,text=text_d2,p=panelVeh)
# 	text_d3 = "Batch Ref Path Change : �妸����reference ���|�u��"
# 	lbbNam3 = WinForms.GUI(cls='Label',size=[400,40],pos=[20,100],bc=_bc,text=text_d3,p=panelVeh)
# 	text_d4 = "�Ϊk�G�Ĥ@���u�X��ܮث��w��@�ӷ�maya�ɡA�ĤG���u�X��ܮث��w�h�ӭn�Q������ maya�ɡA����|�妸����æs��"
# 	lbbNam4 = WinForms.GUI(cls='Label',size=[400,40],pos=[20,140],bc=_bc,text=text_d4,p=panelVeh)
# 	text_d5 = "Set Char To Origin �G �N���e�����ʧ@�^�k��@�ɮy�Э��I"
# 	lbbNam5 = WinForms.GUI(cls='Label',size=[400,40],pos=[20,180],bc=_bc,text=text_d5,p=panelVeh)
# 	text_d6 = "Move in Place �G �N���e����ʧ@�v�b main control �W"
# 	lbbNam6 = WinForms.GUI(cls='Label',size=[400,40],pos=[20,220],bc=_bc,text=text_d6 ,p=panelVeh)
# 	text_d7 = "FK=>IK�G FK �����pose(��i) ����� IK ����A�|�]key"
# 	lbbNam7 = WinForms.GUI(cls='Label',size=[400,40],pos=[20,260],bc=_bc,text=text_d7 ,p=panelVeh)
# 	text_d8 = "IK=>FK�G IK �����pose(��i) ����� FK ����A�|�]key"
# 	lbbNam8 = WinForms.GUI(cls='Label',size=[400,40],pos=[20,300],bc=_bc,text=text_d8 ,p=panelVeh)
# 	text_d9 = "Motion:FK=>IK�G �ɶ��Ϭq�� FK ������ʧ@ ����� IK ������ʧ@"
# 	lbbNam9 = WinForms.GUI(cls='Label',size=[400,40],pos=[20,340],bc=_bc,text=text_d9 ,p=panelVeh)
# 	text_d10 = "Motion:IK=>FK�G �ɶ��Ϭq�� IK ������ʧ@ ����� FK ������ʧ@"
# 	lbbNam10 = WinForms.GUI(cls='Label',size=[400,40],pos=[20,380],bc=_bc,text=text_d10 ,p=panelVeh)
# 	_Form.Show()
# 	try:__builtin__.g_asJoyfunToolDesc1.TopMost=True
# 	except:pass
# 	return 