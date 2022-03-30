#-*- coding:utf-8 -*- 
import maya.cmds as cmds
import inspect
if int(cmds.about(version=True)) >= 2017:
	import PySide2.QtCore as QtCore
	import PySide2.QtWidgets as QtGui
	import PySide2.QtGui as QGui
	from shiboken2 import wrapInstance
else:
	import PySide.QtCore as QtCore
	import PySide.QtGui as QtGui
	import PySide.QtGui as QGui
	from shiboken import wrapInstance

from collections import OrderedDict

import math

import maya.OpenMayaUI as omui
import maya.mel as mel
import os
import os.path
import re
import shutil
import Helper

import AS_MotionConstrain as ASC
reload(ASC)

# pi = 3.14159265359

# listLockNode = ASC.listLockNode

# listLockNode = ['RootX_M',
# 				'FKHead_M',
# 				'FKScapula_R',
# 				'FKScapula_L',
# 				'FKShoulder_R',
# 				'FKShoulder_L',
# 				'IKArm_R',
# 				'IKArm_L',
# 				'PoleArm_R',
# 				'PoleArm_L',
# 				'FKHip_R',
# 				'FKHip_L',
# 				'IKLeg_R',
# 				'IKLeg_L',
# 				'PoleLeg_R',
# 				'PoleLeg_L',
# 				'counter_P_ctrl']

# def radByAngle(angle):
# 	return angle / 180.0 * pi

# def createCircleCross(name, radius, seg = 36, upAxis='z', offset=[0,0,0], color=[0,1,0]):
# 	listPt = []
# 	for i in range(seg + 1):
# 		rScl = 1.0
# 		if (360.0/seg*i)%90 == 0:
# 			rScl = 1.5
# 		pt = [math.cos(radByAngle(360.0/seg*i))*radius*rScl, math.sin(radByAngle(360.0/seg*i))*radius*rScl, 0]
# 		listPt.append(pt)

# 	listP = []
	
# 	if upAxis == 'x':
# 		for i in range(len(listPt)):
# 			lst = listPt[i]
# 			tmp = lst[2]
# 			lst[2] = lst[1]
# 			lst[1] = lst[0]
# 			lst[0] = tmp
# 			listP.append(lst)
# 	elif upAxis == 'y':
# 		for i in range(len(listPt)):
# 			lst = listPt[i]
# 			tmp = lst[2]
# 			lst[2] = lst[0]
# 			lst[0] = lst[1]
# 			lst[1] = tmp
# 			listP.append(lst)
# 	else: #upAxis == 'z'
# 		for i in range(len(listPt)):
# 			lst = listPt[i]
# 			listP.append(lst)

# 	listK = []
# 	for i in range(len(listP)):
# 		listK.append(i)
		
# 	obj = cmds.curve(name=name, p=listP, k=listK, d=1)
	
# 	cmds.setAttr((obj + ".overrideEnabled"), 1)
# 	cmds.setAttr((obj + ".overrideRGBColors"), 1)
# 	cmds.setAttr((obj + ".overrideColorR"), color[0])
# 	cmds.setAttr((obj + ".overrideColorG"), color[1])
# 	cmds.setAttr((obj + ".overrideColorB"), color[2])
# 	return obj

# def createWireCylinder(name, radius, height, upAxis='z', offset=[0,0,0], color=[0,1,0]):
# 	listPt = []
	
# 	for i in range(25):
# 		pt = [math.cos(radByAngle(360.0/24*i))*radius, math.sin(radByAngle(360.0/24*i))*radius, 0]
# 		listPt.append(pt)
# 	for i in range(25):
# 		pt = [math.cos(radByAngle(360.0/24*i))*radius, math.sin(radByAngle(360.0/24*i))*radius, height]
# 		listPt.append(pt)
		
# 	ptTmp = [listPt[26][0], listPt[26][1], listPt[26][2]]
# 	listPt.append(ptTmp)
# 	ptTmp = [listPt[27][0], listPt[27][1], listPt[27][2]]
# 	listPt.append(ptTmp)
# 	ptTmp = [listPt[28][0], listPt[28][1], listPt[28][2]]
# 	listPt.append(ptTmp)
# 	ptTmp = [listPt[29][0], listPt[29][1], listPt[29][2]]
# 	listPt.append(ptTmp)
# 	ptTmp = [listPt[30][0], listPt[30][1], listPt[30][2]]
# 	listPt.append(ptTmp)
# 	ptTmp = [listPt[31][0], listPt[31][1], listPt[31][2]]
# 	listPt.append(ptTmp)
	
# 	ptTmp = [listPt[ 6][0], listPt[ 6][1], listPt[ 6][2]]
# 	listPt.append(ptTmp)
# 	ptTmp = [listPt[ 7][0], listPt[ 7][1], listPt[ 7][2]]
# 	listPt.append(ptTmp)
# 	ptTmp = [listPt[ 8][0], listPt[ 8][1], listPt[ 8][2]]
# 	listPt.append(ptTmp)
# 	ptTmp = [listPt[ 9][0], listPt[ 9][1], listPt[ 9][2]]
# 	listPt.append(ptTmp)
# 	ptTmp = [listPt[10][0], listPt[10][1], listPt[10][2]]
# 	listPt.append(ptTmp)
# 	ptTmp = [listPt[11][0], listPt[11][1], listPt[11][2]]
# 	listPt.append(ptTmp)
# 	ptTmp = [listPt[12][0], listPt[12][1], listPt[12][2]]
# 	listPt.append(ptTmp)
	
# 	ptTmp = [listPt[37][0], listPt[37][1], listPt[37][2]]
# 	listPt.append(ptTmp)
# 	ptTmp = [listPt[38][0], listPt[38][1], listPt[38][2]]
# 	listPt.append(ptTmp)
# 	ptTmp = [listPt[39][0], listPt[39][1], listPt[39][2]]
# 	listPt.append(ptTmp)
# 	ptTmp = [listPt[40][0], listPt[40][1], listPt[40][2]]
# 	listPt.append(ptTmp)
# 	ptTmp = [listPt[41][0], listPt[41][1], listPt[41][2]]
# 	listPt.append(ptTmp)
# 	ptTmp = [listPt[42][0], listPt[42][1], listPt[42][2]]
# 	listPt.append(ptTmp)
# 	ptTmp = [listPt[43][0], listPt[43][1], listPt[43][2]]
# 	listPt.append(ptTmp)
	
# 	ptTmp = [listPt[18][0], listPt[18][1], listPt[18][2]]
# 	listPt.append(ptTmp)
	
# 	listP = []
	
# 	if upAxis == 'x':
# 		for i in range(len(listPt)):
# 			lst = listPt[i]
# 			tmp = lst[2]
# 			lst[2] = lst[1]
# 			lst[1] = lst[0]
# 			lst[0] = tmp
# 			listP.append(lst)
# 	elif upAxis == 'y':
# 		for i in range(len(listPt)):
# 			lst = listPt[i]
# 			tmp = lst[2]
# 			lst[2] = lst[0]
# 			lst[0] = lst[1]
# 			lst[1] = tmp
# 			listP.append(lst)
# 	else: #upAxis == 'z'
# 		for i in range(len(listPt)):
# 			lst = listPt[i]
# 			listP.append(lst)
			
# 	listK = []
# 	for i in range(len(listP)):
# 		listK.append(i)
		
# 	obj = cmds.curve(name=name, p=listP, k=listK, d=1)
	
# 	cmds.setAttr((obj + ".overrideEnabled"), 1)
# 	cmds.setAttr((obj + ".overrideRGBColors"), 1)
# 	cmds.setAttr((obj + ".overrideColorR"), color[0])
# 	cmds.setAttr((obj + ".overrideColorG"), color[1])
# 	cmds.setAttr((obj + ".overrideColorB"), color[2])
# 	return obj

def exportAnima(filePath):
	selObjects = cmds.ls(sl=True)
	objCount = len(selObjects)
	startTime = int(cmds.playbackOptions(q=True, min=True))
	endTime = int(cmds.playbackOptions(q=True, max=True))
	currentTime = int(cmds.currentTime(q=True))
	timePrefix = startTime
	framesCount = endTime - startTime + 1

	AnimData = OrderedDict()
	AnimData['count'] = objCount

	objList = []
	for o in selObjects:
		clrName = o.split(':')[-1]
		objList.append(clrName)
			
	AnimData['name'] = objList

	AnimData['timelength'] = framesCount

	frameAniData = OrderedDict()
	for f in range(0,framesCount,1):
		cmds.currentTime(f + timePrefix)
		posArray = []
		RotArray = []
		sclArray = []
		
		for o in selObjects:
			cLPos = list(cmds.getAttr(o+".translate")[0])
			cLRot = list(cmds.getAttr(o+".rotate")[0])
			cLScl = list(cmds.getAttr(o+".scale")[0])
			

			posArray.append(cLPos)
			RotArray.append(cLRot)
			sclArray.append(cLScl)
		
		transformData = OrderedDict()
		transformData["Position"] = posArray
		transformData["Rotation"] = RotArray
		transformData["Scale"] = sclArray

		frameAniData[f] = transformData
	
	AnimData["Animation"] = frameAniData

	json_str = json.dumps(AnimData, sort_keys=False)

	#### Write to xaf file ###
	text_file = open(filePath, "w")
	text_file.write(json_str)
	text_file.close()

	cmds.currentTime(currentTime)

def importAnima(filePath, nameSpaceFrefix=''):
	text_file = open(filePath, "r")
	
	# nameSpaceFrefix = ""
	# selObjs = cmds.ls(sl=True)
	# if(len(selObjs) > 0):
	# 	sOName = selObjs[0].split(':')[-1]
	# 	nameSpaceFrefix = selObjs[0][0:-(len(sOName))]

	# nameSpaceFrefix = cmds.namespaceInfo(lon=True)
	# nameSpaceFrefix = nameSpaceFrefix[0:-2][0] + ':'

	fString = text_file.read()
	kafData = json.loads(fString)

	objCount = kafData['count']
	objList = kafData['name']
	framesCount = kafData['timelength']
	AnimData = kafData['Animation']
	endTime = int(cmds.playbackOptions(q=True, max=True))
	startFrame = int(cmds.currentTime(q=True))
	for f in range(0,framesCount):
		tKey = str(f)
		for i in range(0,objCount):
			if (cmds.objExists(nameSpaceFrefix + objList[i])):
				
				### Position ###
				if not cmds.getAttr(nameSpaceFrefix + objList[i] + ".translateX", l=True):
					cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".translateX", time=(startFrame+f), value=AnimData[tKey]['Position'][i][0])
				if not cmds.getAttr(nameSpaceFrefix + objList[i] + ".translateY", l=True):
					cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".translateY", time=(startFrame+f), value=AnimData[tKey]['Position'][i][1])
				if not cmds.getAttr(nameSpaceFrefix + objList[i] + ".translateZ", l=True):
					cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".translateZ", time=(startFrame+f), value=AnimData[tKey]['Position'][i][2])

				### Rotation ###
				if not cmds.getAttr(nameSpaceFrefix + objList[i] + ".rotateX", l=True):
					cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".rotateX", time=(startFrame+f), value=AnimData[tKey]['Rotation'][i][0])
				if not cmds.getAttr(nameSpaceFrefix + objList[i] + ".rotateY", l=True):
					cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".rotateY", time=(startFrame+f), value=AnimData[tKey]['Rotation'][i][1])
				if not cmds.getAttr(nameSpaceFrefix + objList[i] + ".rotateZ", l=True):
					cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".rotateZ", time=(startFrame+f), value=AnimData[tKey]['Rotation'][i][2])

				### Scale ###
				if not cmds.getAttr(nameSpaceFrefix + objList[i] + ".scaleX", l=True):
					cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".scaleX", time=(startFrame+f), value=AnimData[tKey]['Scale'][i][0])
				if not cmds.getAttr(nameSpaceFrefix + objList[i] + ".scaleY", l=True):
					cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".scaleY", time=(startFrame+f), value=AnimData[tKey]['Scale'][i][1])
				if not cmds.getAttr(nameSpaceFrefix + objList[i] + ".scaleZ", l=True):
					cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".scaleZ", time=(startFrame+f), value=AnimData[tKey]['Scale'][i][2])
	
	for i in range(0,objCount):
		if (cmds.objExists(nameSpaceFrefix + objList[i])):
			cmds.filterCurve(nameSpaceFrefix+objList[i]+".rotateX",nameSpaceFrefix+objList[i]+".rotateY",nameSpaceFrefix+objList[i]+".rotateZ")
	
	newEndFrame = startFrame + framesCount
	if newEndFrame > endTime:
		cmds.playbackOptions(max = newEndFrame - 1)

	text_file.close()

def maya_main_window():
	main_window_ptr = omui.MQtUtil.mainWindow()
	return wrapInstance(long(main_window_ptr), QtGui.QWidget)

class TransferOffsetTools(QtGui.QDialog):
	width = 320
	height = 160

	bActive = False

	proxyRoot = None
	proxyCtrl = None

	cbbNameSpace = QtGui.QComboBox()
	btnRefreshNameSpace = QtGui.QPushButton('↻'.decode("utf-8"))

	ns = ''

	def __init__(self, parent=maya_main_window()):
		self.closeExistingWindow()
		super(TransferOffsetTools, self).__init__(parent)
		self.create()

	def __del__(self):
		pass
		
	def closeExistingWindow(self):
		try:
			for qt in maya_main_window().findChildren(QtGui.QDialog):
				if qt.__class__.__name__ == self.__class__.__name__:
					qt.close()
					qt.deleteLater()
		except:
			pass

	def create(self):
		self.setWindowTitle('偏移工具'.decode("utf-8"))
		self.setWindowFlags(QtCore.Qt.Tool)
		self.setMinimumSize(self.width,self.height)
		self.setMaximumSize(self.width,self.height)

		self.create_controls()
		self.create_layout()
		self.create_connections()
		self.doRefreshNameSpace()
		self.show()

	def create_controls(self):

		self.paletteActiveOn  = QGui.QPalette(QGui.QColor(255,0,0))
		self.paletteActiveOff = QGui.QPalette(QGui.QColor(50,50,50))

		self.btnTranferOffsetAct = QtGui.QPushButton("Active")
		self.btnConvertAnimClip = QtGui.QPushButton("Convert Animation Clip")
		self.btnCancel = QtGui.QPushButton("Cancel")
		self.chkRotateRootCtrl = QtGui.QCheckBox(u"旋轉蛋")
		
	def create_layout(self):
		self.setStyleSheet("*{font: 12px Microsoft JHengHei, sans-serif;}")

		sheetActiveBtn =  "QPushButton{ background:#555;}"
		sheetActiveBtn += "QPushButton:pressed{ border: 3px solid #F52; background:#222; color:#F88;}"
		sheetActiveBtn += "QPushButton:checked{ border: 2px solid #F88; background:#F00; color:#FFF;}"

		self.cbbNameSpace.setParent(self)
		self.cbbNameSpace.setGeometry(8,8,self.width-46, 22)

		self.btnRefreshNameSpace.setParent(self)
		self.btnRefreshNameSpace.setGeometry(self.width-33, 8, 22, 21)

		self.btnTranferOffsetAct.setParent(self)
		self.btnTranferOffsetAct.setGeometry(10,36,self.width-20, 60)
		self.btnTranferOffsetAct.setPalette(self.paletteActiveOff)
		self.btnTranferOffsetAct.setStyleSheet(sheetActiveBtn)
		self.btnTranferOffsetAct.setCheckable(True)

		self.btnConvertAnimClip.setParent(self)
		self.btnConvertAnimClip.setGeometry(80,101,self.width-160, 54)

		self.btnCancel.setParent(self)
		self.btnCancel.setGeometry(self.width-50, 125, 40, 30)

		self.chkRotateRootCtrl.setParent(self)
		self.chkRotateRootCtrl.setGeometry(10, 125, 80, 40)

	def create_connections(self):
		self.btnRefreshNameSpace.clicked.connect(self.doRefreshNameSpace)
		self.cbbNameSpace.currentIndexChanged.connect(self.doCbbNameSpaceChangeSelect)
		self.btnTranferOffsetAct.clicked.connect(self.doActivePressed)
		self.btnConvertAnimClip.clicked.connect(self.doConvertAnimClip)
		self.btnCancel.clicked.connect(self.doCencelPressed)

	def closeEvent(self, event):
		if self.bActive:
			self.TransferOffsetEnd()
		self.deleteLater()

	#-------------------------
	#
	#-------------------------
	def doRefreshNameSpace(self):
		self.cbbNameSpace.clear()
		listNameSpace = cmds.namespaceInfo(lon=True, recurse=True)

		if cmds.objExists('Group'):
			self.cbbNameSpace.insertItem(-1,'--')
			
		for _ns in listNameSpace:
			if cmds.objExists(_ns+':root'):
				self.cbbNameSpace.insertItem(-1,_ns+':')

	def doCbbNameSpaceChangeSelect(self, idx):
		if self.cbbNameSpace.itemText(idx)=='--':
			self.ns = ''
		else:
			self.ns = self.cbbNameSpace.itemText(idx)

	def doActivePressed(self):
		self.bActive = self.btnTranferOffsetAct.isChecked()
		if self.bActive:
			confirm = Helper.showConfirmDialog(u'會解除特定對象的所有綁定，確定執行？')
			if confirm:
				self.btnTranferOffsetAct.setText("Active On")
				self.btnRefreshNameSpace.setEnabled(False)
				self.cbbNameSpace.setEnabled(False)
				self.TransferOffsetAct()
			else:
				self.btnTranferOffsetAct.setChecked(False)
				return
		else:
			self.btnRefreshNameSpace.setEnabled(True)
			self.cbbNameSpace.setEnabled(True)
			self.TransferOffsetEnd()
			self.btnTranferOffsetAct.setText("Active")

	def TransferOffsetAct(self):

		oriAutoKeyState = cmds.autoKeyframe(q=True,state=True)
		cmds.autoKeyframe(state=False)

		rigType = Helper.checkRigType(self.ns)

		#------------------
		if rigType == Helper.HUMAN:
			cmds.select(self.ns+'ControlSet')
			try:
				cmds.select(self.ns+'Main', tgl=True)
			except:
				Helper.showMessage(u"%s有同名的物件存在哦，請刪除多餘的物件再執行" % (self.ns+'Main'))

				self.btnRefreshNameSpace.setEnabled(True)
				self.cbbNameSpace.setEnabled(True)
				self.bActive = False
				self.btnTranferOffsetAct.setChecked(False)
				return
			freezeList = cmds.ls(sl=True)

			for o in freezeList:
				oShapes = cmds.listRelatives(o, f=True,pa=True, shapes=True)
				if oShapes:
					for s in oShapes:
						cmds.setAttr(s+'.overrideEnabled', 1)
						cmds.setAttr(s+'.overrideDisplayType', 2)
		#--------------------

		startTime = int(cmds.playbackOptions(q=True, min=True))
		endTime = int(cmds.playbackOptions(q=True, max=True))
		currentTime = int(cmds.currentTime(q=True))

		proxyRoot, proxyCtrl = ASC.createProxyForOffset(self.ns, startTime, endTime, self.chkRotateRootCtrl.isChecked())
		self.proxyRoot = proxyRoot
		self.proxyCtrl = proxyCtrl
		
		cmds.currentTime(currentTime)
		cmds.select(proxyCtrl)
		cmds.autoKeyframe(state=oriAutoKeyState)

	def TransferOffsetEnd(self):
		# ns = cmds.namespaceInfo(lon=True)
		# ns = ns[0:-2][0] + ':'
		#------------------

		rigType = Helper.checkRigType(self.ns)
		if rigType == Helper.HUMAN:
			cmds.select(self.ns+'ControlSet')
			cmds.select(self.ns+'Main', tgl=True)
			freezeList = cmds.ls(sl=True)

			for o in freezeList:
				oShapes = cmds.listRelatives(o, f=True,pa=True, shapes=True)
				if oShapes:
					for s in oShapes:
						cmds.setAttr(s+'.overrideDisplayType', 0)
						# cmds.setAttr(s+'.overrideEnabled', 0)
				
		#--------------------
		# for o in listLockNode:
		# 	cmds.setKeyframe(self.ns+o+".translate")
		# 	cmds.setKeyframe(self.ns+o+".rotate")
		# 	pass
		#-----------------------------------
		if self.proxyCtrl: cmds.delete( self.proxyCtrl )
		if self.proxyRoot: cmds.delete( self.proxyRoot )
		cmds.select(d=True)
		pass

	def doConvertAnimClip(self):
		if self.bActive:
			self.bActive = False
			self.btnTranferOffsetAct.setChecked(False)

			# ns = cmds.namespaceInfo(lon=True)
			# ns = ns[0:-2][0] + ':'
			#------------------
			rigType = Helper.checkRigType(self.ns)
			if rigType == Helper.HUMAN:
				cmds.select(self.ns+'ControlSet')
				cmds.select(self.ns+'Main', tgl=True)
				freezeList = cmds.ls(sl=True)

				for o in freezeList:
					oShapes = cmds.listRelatives(o, f=True,pa=True, shapes=True)
					if oShapes:
						for s in oShapes:
							cmds.setAttr(s+'.overrideDisplayType', 0)
					
			#--------------------
			startTime = int(cmds.playbackOptions(q=True, min=True))
			endTime = int(cmds.playbackOptions(q=True, max=True))
			currentTime = int(cmds.currentTime(q=True))
			timePrefix = startTime
			framesCount = endTime - startTime + 1

			listLockNode = Helper.getRigLockNodes(rigType)

			for f in range(framesCount):
				tFrame = startTime+f
				cmds.currentTime(tFrame)

				cmds.setKeyframe(self.ns+"root_ctrl.translate")

				if self.chkRotateRootCtrl.isChecked():
					cmds.setKeyframe(self.ns+"root_ctrl.rz")

				for o in listLockNode:
					if cmds.objExists(self.ns+o):
						cmds.setKeyframe(self.ns+o+".translate")
						cmds.setKeyframe(self.ns+o+".rotate")

			#-----------------------------------
			self.cbbNameSpace.setEnabled(True)
			self.btnRefreshNameSpace.setEnabled(True)
			if self.proxyCtrl: cmds.delete( self.proxyCtrl )
			if self.proxyRoot: cmds.delete( self.proxyRoot )
			cmds.select(d=True)

	def doCencelPressed(self):
		if self.bActive:
			self.bActive = False
			self.btnTranferOffsetAct.setChecked(False)

			# ns = cmds.namespaceInfo(lon=True)
			# ns = ns[0:-2][0] + ':'
			#------------------
			cmds.select(self.ns+'ControlSet')
			cmds.select(self.ns+'Main', tgl=True)
			freezeList = cmds.ls(sl=True)

			for o in freezeList:
				oShapes = cmds.listRelatives(o, f=True,pa=True, shapes=True)
				if oShapes:
					for s in oShapes:
						cmds.setAttr(s+'.overrideDisplayType', 0)
						# cmds.setAttr(s+'.overrideEnabled', 0)

			#-----------------------------------
			self.cbbNameSpace.setEnabled(True)
			self.btnRefreshNameSpace.setEnabled(True)
			if self.proxyCtrl: cmds.delete( self.proxyCtrl )
			if self.proxyRoot: cmds.delete( self.proxyRoot )
			cmds.select(d=True)

#===================================================================

def createUI():
	TO_ui = TransferOffsetTools()