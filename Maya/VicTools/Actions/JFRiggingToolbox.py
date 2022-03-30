# -*- coding: utf-8 -*-
# Last Modified 2015/12/10
# Author Chih Lun Kang

import maya.cmds as cmds
import maya.mel as mm
import clr
clr.AddReference("System")
clr.AddReference("System.Drawing")
clr.AddReference("System.Windows.Forms")

import System
import System.Drawing
import System.Windows.Forms
import __builtin__
import sys,os
from DotNet import WinForms
reload(WinForms)

class JFRiggingToolBoxClass():
	def __init__(self):
		self.onRefreshUI()
	def onRefreshUI(self):
		#Form
		try:
			__builtin__.g_NMARigTool.Close()
		except:
			pass
		_size=[250,400]
		__builtin__.g_NMARigTool = WinForms.GUI(cls='Form',size=_size,
				text="JFRigging Toolbox")
		self.Form = __builtin__.g_NMARigTool
		self.Form.Show()
		self.Form.TopMost = True

		#Panel
		self.panel1 = WinForms.GUI(cls='Panel',size=_size,pos=[0,0] ,p=self.Form)
		#self.btn_Dora = WinForms.GUI(cls='Button',size=[100,40],pos=[10,10],text="Dora Skin Weight",n="btn_dora",p=self.panel1)
		#self.btn_batchRfPth = WinForms.GUI(cls='Button',size=[100,40],pos=[120,10],text="Batch Ref Path Change",n="btn_batchRfPth",p=self.panel1)
		self.btn_charToOrigin = WinForms.GUI(cls='Button',size=[100,40],pos=[10,60],text="Set Char To Origin",n="btn_charToOrigin",p=self.panel1)
		self.btn_MoveInPlace = WinForms.GUI(cls='Button',size=[100,40],pos=[120,60],text="Move in Place",n="btn_MoveInPlace",p=self.panel1)
		self.btn_FKtoIK = WinForms.GUI(cls='Button',size=[100,40],pos=[10,110],text="FK=>IK",n="btn_FKtoIK",p=self.panel1)
		self.btn_IKtoFK = WinForms.GUI(cls='Button',size=[100,40],pos=[120,110],text="IK=>FK",n="btn_IKtoFK",p=self.panel1)
		self.btn_FKtoIK_motion = WinForms.GUI(cls='Button',size=[100,40],pos=[10,160],text="Motion:FK=>IK",n="btn_FKtoIK_m",p=self.panel1)
		self.btn_IKtoFK_motion = WinForms.GUI(cls='Button',size=[100,40],pos=[120,160],text="Motion:IK=>FK",n="btn_IKtoFK_m",p=self.panel1)
		#Event Handlers
		#self.btn_Dora.Click += self.callBtnEventByName
		#self.btn_batchRfPth.Click += self.callBtnEventByName
		
		
	def callBtnEventByName(self, sender , eventArgs):
		pass
JFRiggingToolBoxClass()