# -*- coding: utf-8 -*-
import maya.cmds as cmds
import maya.mel as mel
import sys,os,re
import os.path
import maya.OpenMaya as om
import maya.OpenMayaAnim as omAnim
import maya.OpenMayaMPx as OpenMayaMPx
import __builtin__


try:import clr 
except:pass

if(clr):
	clr.AddReference("System")
	clr.AddReference("System.Windows.Forms")
	import System
	import System.Windows.Forms
	from DotNet import WinForms
	reload(WinForms)



class WeapHardAttachWin():
	def __init__(self):
		self._size=[150,500]
		self.onRefreshUI()
		try:__builtin__.g_WeapHardAttachWinInstance.TopMost=True
		except:pass
		self.charNamespace = ""
		self.weapNamespace = ""
		self.wepSocketNameA = ["weapon_L_jnt","weapon_R_jnt",
							"weapon_M_jnt_P2","weaponSec_L_jnt_P2",
							"weaponSec_R_jnt_P2"]
		self.cureSnapMode = -1
		
	def onRefreshUI(self):
		if(not clr):return
		try:__builtin__.g_WeapHardAttachWinInstance.Close()
		except:pass
		__builtin__.g_WeapHardAttachWinInstance= WinForms.GUI(cls='Form',size=self._size,text="Weapon Orient")
		self.Form = __builtin__.g_WeapHardAttachWinInstance
		self.Form.Show()
		
		_bc=System.Drawing.SystemColors.ControlLight
		self.Panel1 = WinForms.GUI(cls='Panel',size=self._size,pos=[0,0],bc=_bc,p=self.Form)
		
		self.BtnSetChar = WinForms.GUI(cls='Button',size=[102,31],pos=[10,10],text=" Pick Character ",bc=_bc,p=self.Panel1)
		self.BtnToLeftHand = WinForms.GUI(cls='Button',size=[102,30],pos=[10,90],text=" L Hand ",bc=_bc,p=self.Panel1)
		self.BtnToRightHand = WinForms.GUI(cls='Button',size=[102,30],pos=[10,120],text=" R Hand ",bc=_bc,p=self.Panel1)
		self.BtnToBack = WinForms.GUI(cls='Button',size=[102,30],pos=[10,150],text=" Back ",bc=_bc,p=self.Panel1)
		self.BtnToWastL = WinForms.GUI(cls='Button',size=[102,30],pos=[10,180],text=" L Waist ",bc=_bc,p=self.Panel1)
		self.BtnToWastR = WinForms.GUI(cls='Button',size=[102,30],pos=[10,210],text=" R Waist ",bc=_bc,p=self.Panel1)

		self.BtnFix = WinForms.GUI(cls='Button',size=[102,30],pos=[10,290],text=" Fix ",bc=_bc,p=self.Panel1)
		self.BtnBack = WinForms.GUI(cls='Button',size=[102,30],pos=[10,320],text=" Zero ",bc=_bc,p=self.Panel1)

		self.BtnQuickSetTM = WinForms.GUI(cls='Button',size=[102,30],pos=[10,400],text=" Quick Rot ",bc=_bc,p=self.Panel1)
		
		self.togglePartsBtnEnable(False)
		
		self.BtnSetChar.Click += self.setCharacter
		self.BtnToLeftHand.Click += self.SetHardAttach_LHand
		self.BtnToRightHand.Click += self.SetHardAttach_RHand
		self.BtnToBack.Click += self.SetHardAttach_Back
		self.BtnToWastL.Click += self.SetHardAttach_WaistL
		self.BtnToWastR.Click += self.SetHardAttach_WaistR
		self.BtnFix.Click += self.FixRotation
		self.BtnBack.Click += self.goBackToOrig
		self.BtnQuickSetTM.Click += self.quickSetAllPartTm
		
	def setCharacter(self,s,e):
		sel = cmds.ls(sl=True)
		if(len(sel)):
			if(":" in sel[0]):
				self.charNamespace = sel[0].split(":")[0]
		if(len(self.charNamespace)):
			self.togglePartsBtnEnable(True)
			self.BtnSetChar.Text = self.charNamespace
		
	def togglePartsBtnEnable(self,bEnabled):
		self.BtnToLeftHand.Enabled = bEnabled
		self.BtnToRightHand.Enabled = bEnabled
		self.BtnToBack.Enabled = bEnabled
		self.BtnToWastL.Enabled = bEnabled
		self.BtnToWastR.Enabled = bEnabled
		self.BtnFix.Enabled = bEnabled
		
	def SetHardAttach_LHand(self,s,e):
		self.SetHardAttach(self.wepSocketNameA[0],self.charNamespace,self.weapNamespace)
		self.cureSnapMode = 0
		
	def SetHardAttach_RHand(self,s,e):
		self.SetHardAttach(self.wepSocketNameA[1],self.charNamespace,self.weapNamespace)
		self.cureSnapMode = 1
		
	def SetHardAttach_Back(self,s,e):
		self.SetHardAttach(self.wepSocketNameA[2],self.charNamespace,self.weapNamespace)
		self.cureSnapMode = 2
		
	def SetHardAttach_WaistL(self,s,e):
		self.SetHardAttach(self.wepSocketNameA[3],self.charNamespace,self.weapNamespace)
		self.cureSnapMode = 3
		
	def SetHardAttach_WaistR(self,s,e):
		self.SetHardAttach(self.wepSocketNameA[4],self.charNamespace,self.weapNamespace)
		self.cureSnapMode = 4
	
	def SetHardAttach(self,WepBoneName,charNamespace,WepNamespace=""):
		self.goBackToOrig(None,None)
		WepBoneName_Tgt = WepBoneName
		CharBoneName_Tgt = WepBoneName
		WepRootBoneName_Tgt = "root"
		
		if(len(WepNamespace)):
			WepBoneName_Tgt = WepNamespace+":"+WepBoneName
			WepRootBoneName_Tgt = WepNamespace+":root"
		
		if(len(charNamespace)):
			CharBoneName_Tgt = charNamespace +":"+WepBoneName
		else:return
			
		WepRoot_xtm = cmds.xform(WepRootBoneName_Tgt, query=True, ws=True, matrix=True)
		WepRoot_tm = om.MMatrix()
		om.MScriptUtil.createMatrixFromList(WepRoot_xtm, WepRoot_tm)

		WepLHand_xtm = cmds.xform(WepBoneName_Tgt, query=True, ws=True, matrix=True)
		WepLHand_tm= om.MMatrix()
		om.MScriptUtil.createMatrixFromList(WepLHand_xtm , WepLHand_tm)

		localTMWepRoot = WepRoot_tm* WepLHand_tm.inverse()

		BodyLHand_xtm = cmds.xform(CharBoneName_Tgt, query=True, ws=True, matrix=True)
		BodyLHand_tm = om.MMatrix()
		om.MScriptUtil.createMatrixFromList(BodyLHand_xtm , BodyLHand_tm )

		tgtWepTm = localTMWepRoot * BodyLHand_tm
		tgtWepTmX =	[tgtWepTm(0,0),tgtWepTm(0,1),tgtWepTm(0,2),tgtWepTm(0,3),
					tgtWepTm(1,0),tgtWepTm(1,1),tgtWepTm(1,2),tgtWepTm(1,3),
					tgtWepTm(2,0),tgtWepTm(2,1),tgtWepTm(2,2),tgtWepTm(2,3),
					tgtWepTm(3,0),tgtWepTm(3,1),tgtWepTm(3,2),tgtWepTm(3,3)]

		cmds.xform(WepRootBoneName_Tgt, ws=True, matrix=tgtWepTmX)

		### Create rotation sphere after xform is done
		
		_grpName = cmds.sphere( r=10 ,name="wepTmpGrp")
		xTr = cmds.xform(CharBoneName_Tgt,q=True,ws=True, matrix=True)
		cmds.xform(_grpName,ws=True,matrix=xTr)
		cmds.parent(WepRootBoneName_Tgt, _grpName)
		
	### Fix Rotation 
	def FixRotation(self,s,e):
		xTr = cmds.xform(self.charNamespace +":"+self.wepSocketNameA[self.cureSnapMode],q=True,ws=True, matrix=True)
		cmds.xform(self.wepSocketNameA[self.cureSnapMode], ws=True, matrix=xTr)
		
	
	### Go back to orig pose
	def goBackToOrig(self,s,e):
		try:
			cmds.parent("root", world=True)
			cmds.delete("wepTmpGrp")
			cmds.xform("root",ws=True,t=[0,0,0])
			cmds.xform("root",ws=True,ro=[0,0,0])
			self.cureSnapMode = -1
		except:pass
		
	def quickSetAllPartTm(self,s,e):
		
		wepSocketMatrixArr = [[-0.9273895519106391, 0.0, -0.37409707163647293, 0.0, 0.0, 1.0, 0.0, 0.0, 0.374097071636473, 0.0, -0.9273895519106392, 0.0, 2.5787016966205556e-10, 31.438972482432696, 1.0402345651527867e-10, 1.0],
			[-0.9273895519106387, 0.0, -0.37409707163647377, 0.0, 0.0, 1.0000000000000002, 0.0, 0.0, 0.3740970716364739, 0.0, -0.927389551910639, 0.0, -2.964242185043986e-10, 31.438972482432696, 7.347580321948044e-10, 1.0],
			[0.7590641736227448, 0.5745129405730488, 0.30619676914776195, 0.0, 0.4607683137061363, -0.8063756408879426, 0.37074369430505943, 0.0, 0.45990666597345914, -0.14033248696103204, -0.8768082183103147, 0.0, 0.0, 61.6753530552341, -12.404031277233841, 1.0],
			[0.12991466039267638, 0.9377632371826441, -0.3220594541443905, 0.0, 0.6151664912346914, -0.33097107695869243, -0.7155615517052334, 0.0, -0.7776196815134337, -0.10515824839512289, -0.6198785152894196, 0.0, 5.658025189205771, 31.43897248243323, 2.624909795267868, 1.0],
			[-0.2056214086104322, -0.8353968838826831, 0.5097370721461846, 0.0, 0.017032000107654485, -0.5238431116533263, -0.8516444712118392, 0.0, 0.9784833914243994, -0.16643449393819576, 0.12194183832525307, 0.0, -5.658, 31.438972482432888, -2.625, 1.0]]
		for w in range(0, len(self.wepSocketNameA)):
			xTr = wepSocketMatrixArr[w]
			try:
				cmds.xform(self.wepSocketNameA[w], ws=True, matrix=xTr)
			except:pass
			

#WeapHardAttachWin()


'''
wepSocketNameA = ["weapon_L_jnt_P2","weapon_R_jnt_P2",
							"weapon_M_jnt_P2","weaponSec_L_jnt_P2",
							"weaponSec_R_jnt_P2"] 
for w in range(0, len(wepSocketNameA)):
	xTr = cmds.xform(wepSocketNameA[w],q=True,ws=True, matrix=True)
	print xTr 
'''




