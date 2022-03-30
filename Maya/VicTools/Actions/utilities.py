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
"FKCup_L"
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
	print('QWER')
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

	listNameSpace = cmds.namespaceInfo(lon=True, recurse=True)
	listNS = []
	if cmds.objExists('ControlSet'):
		listNS.append('')

	for _ns in listNameSpace:
		if cmds.objExists(_ns+':ControlSet'):
			listNS.append(_ns+':')

	print('Shit')



# �u�X��������
def getAsJoyfunToolDesc1():
	try:
		__builtin__.g_asJoyfunToolDesc1.Close()
	except:
		pass
	_size = [500,500]
	__builtin__.g_asJoyfunToolDesc1 = WinForms.GUI(cls='Form',size=_size ,text="����")
	_Form = __builtin__.g_asJoyfunToolDesc1
	_bc=System.Drawing.Color.DimGray
	panelVeh = WinForms.GUI(cls='Panel',size=_size ,pos=[0,0],bc=_bc,p=_Form)
	text_d1 = "Studio Library : �ʵe�� Pose �u��"
	lbbNam1 = WinForms.GUI(cls='Label',size=[400,40],pos=[20,20],bc=_bc,text=text_d1,p=panelVeh)
	text_d2 = "Dora Skin Weight Tool : �s�X�v���u��"
	lbbNam2 = WinForms.GUI(cls='Label',size=[400,40],pos=[20,60],bc=_bc,text=text_d2,p=panelVeh)
	text_d3 = "Batch Ref Path Change : �妸����reference ���|�u��"
	lbbNam3 = WinForms.GUI(cls='Label',size=[400,40],pos=[20,100],bc=_bc,text=text_d3,p=panelVeh)
	text_d4 = "�Ϊk�G�Ĥ@���u�X��ܮث��w��@�ӷ�maya�ɡA�ĤG���u�X��ܮث��w�h�ӭn�Q������ maya�ɡA����|�妸����æs��"
	lbbNam4 = WinForms.GUI(cls='Label',size=[400,40],pos=[20,140],bc=_bc,text=text_d4,p=panelVeh)
	text_d5 = "Set Char To Origin �G �N���e�����ʧ@�^�k��@�ɮy�Э��I"
	lbbNam5 = WinForms.GUI(cls='Label',size=[400,40],pos=[20,180],bc=_bc,text=text_d5,p=panelVeh)
	text_d6 = "Move in Place �G �N���e����ʧ@�v�b main control �W"
	lbbNam6 = WinForms.GUI(cls='Label',size=[400,40],pos=[20,220],bc=_bc,text=text_d6 ,p=panelVeh)
	text_d7 = "FK=>IK�G FK �����pose(��i) ����� IK ����A�|�]key"
	lbbNam7 = WinForms.GUI(cls='Label',size=[400,40],pos=[20,260],bc=_bc,text=text_d7 ,p=panelVeh)
	text_d8 = "IK=>FK�G IK �����pose(��i) ����� FK ����A�|�]key"
	lbbNam8 = WinForms.GUI(cls='Label',size=[400,40],pos=[20,300],bc=_bc,text=text_d8 ,p=panelVeh)
	text_d9 = "Motion:FK=>IK�G �ɶ��Ϭq�� FK ������ʧ@ ����� IK ������ʧ@"
	lbbNam9 = WinForms.GUI(cls='Label',size=[400,40],pos=[20,340],bc=_bc,text=text_d9 ,p=panelVeh)
	text_d10 = "Motion:IK=>FK�G �ɶ��Ϭq�� IK ������ʧ@ ����� FK ������ʧ@"
	lbbNam10 = WinForms.GUI(cls='Label',size=[400,40],pos=[20,380],bc=_bc,text=text_d10 ,p=panelVeh)
	_Form.Show()
	try:__builtin__.g_asJoyfunToolDesc1.TopMost=True
	except:pass
	return 