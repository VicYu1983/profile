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
import pymel.core.datatypes as dt
import maya.mel as mel
import os
import os.path
import re
import shutil

pi = 3.14159265359

def radByAngle(angle):
	return angle / 180.0 * pi

def getPose(nodeList):
	objCount = len(nodeList)

	PoseData = OrderedDict()
	PoseData['count'] = objCount

	objList = []
	for o in nodeList:
		clrName = o[5:]
		objList.append(clrName)

	PoseData['name'] = objList

	mtxArray = []

	for o in nodeList:
		cWMtx = list(cmds.xform(o,q=True,ws=True,m=True))
		mtxArray.append(cWMtx)


	transformData = OrderedDict()
	transformData["wrdMatrix"] = mtxArray

	PoseData['Pose'] = transformData

	return PoseData

def importPose(transData, nameSpaceFrefix=''):

	objCount = transData['count']
	objList = transData['name']
	PoseData = transData['Pose']

	for i in range(objCount):
		if (cmds.objExists(nameSpaceFrefix + objList[i])):
			cmds.xform(nameSpaceFrefix + objList[i], ws=True, m=(PoseData['wrdMatrix'][i]))


def getAnima(nodeList, startTime, endTime):
	objCount = len(nodeList)
	currentTime = int(cmds.currentTime(q=True))
	framesCount = endTime - startTime + 1

	AnimData = OrderedDict()
	AnimData['count'] = objCount

	objList = []
	for o in nodeList:
		clrName = o[5:]
		objList.append(clrName)
			
	AnimData['name'] = objList

	AnimData['timelength'] = framesCount

	frameAniData = OrderedDict()
	for f in range(framesCount):
		cmds.currentTime(f + startTime)
		mtxArray = []
		
		for o in nodeList:
			cWMtx = list(cmds.xform(o,q=True,ws=True,m=True))

			mtxArray.append(cWMtx)
		
		transformData = OrderedDict()
		transformData["wrdMatrix"] = mtxArray
		frameAniData[f] = transformData
	
	AnimData["Animation"] = frameAniData
	cmds.currentTime(currentTime)
	return AnimData

def importAnima(anmData, startFrame, nameSpaceFrefix=''):
	oriAutoKeyState = cmds.autoKeyframe(q=True,state=True)
	cmds.autoKeyframe(state=False)

	objCount = anmData['count']
	objList = anmData['name']
	framesCount = anmData['timelength']
	AnimData = anmData['Animation']
	endTime = int(cmds.playbackOptions(q=True, max=True))
	# startFrame = int(cmds.currentTime(q=True))
	for f in range(framesCount):
		tKey = f#str(f)
		cmds.currentTime(f + startFrame)
		for i in range(objCount):
			if (cmds.objExists(nameSpaceFrefix + objList[i])):
				cmds.xform(nameSpaceFrefix + objList[i], ws=True, m=(AnimData[tKey]['wrdMatrix'][i]))
				cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".translate")
				cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".rotate")

	for i in range(0,objCount):
		if (cmds.objExists(nameSpaceFrefix + objList[i])):
			cmds.filterCurve(nameSpaceFrefix+objList[i]+".rotateX",nameSpaceFrefix+objList[i]+".rotateY",nameSpaceFrefix+objList[i]+".rotateZ")

	cmds.autoKeyframe(state=oriAutoKeyState)

def getMainNameSpace():
	ns = cmds.namespaceInfo(lon=True)
	# ns = ns[0:-2][0] + ':'
	if len(ns) > 2:
		return ns[0:-2][0] + ':'
	else:
		return ''

def maya_main_window():
	main_window_ptr = omui.MQtUtil.mainWindow()
	return wrapInstance(long(main_window_ptr), QtGui.QWidget)

class GlobalLocalConvert(QtGui.QDialog):
	width = 320
	height = 150

	spnStartFrame = QtGui.QSpinBox()
	spnEndFrame   = QtGui.QSpinBox()

	cbbNameSpace = QtGui.QComboBox()
	btnRefreshNameSpace = QtGui.QPushButton('↻'.decode("utf-8"))

	ns = ''
	nConvertTimeType = 0
	bRightArm = False
	bLeftArm = False
	bRightLeg = False
	bLeftLeg = False
	bSpine = False

	def __init__(self, parent=maya_main_window()):
		self.closeExistingWindow()
		super(GlobalLocalConvert, self).__init__(parent)
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
		self.setWindowTitle('Global / Local 轉換'.decode("utf-8"))
		self.setWindowFlags(QtCore.Qt.Tool)
		self.setMinimumSize(self.width,self.height)
		self.setMaximumSize(self.width,self.height)

		self.create_controls()
		self.create_layout()
		self.create_connections()
		self.doRefreshNameSpace()
		self.show()

	def create_controls(self):
		self.spnStartFrame.setRange(0,99999)
		self.spnStartFrame.setValue(int(cmds.playbackOptions(q=True, min=True)))

		self.spnEndFrame.setRange(0,99999)
		self.spnEndFrame.setValue(int(cmds.playbackOptions(q=True, max=True)))

		self.btnConver2IK = QtGui.QPushButton('>  Global')
		self.btnConver2FK = QtGui.QPushButton('>  Local')

		self.choiceButtonGroup = QtGui.QButtonGroup()
		self.cbRightArm = QtGui.QCheckBox('')
		self.cbLeftArm = QtGui.QCheckBox('')
		self.cbRightLeg = QtGui.QCheckBox('')
		self.cbLeftLeg = QtGui.QCheckBox('')
		self.cbSpine =  QtGui.QCheckBox('')

		pass

	def create_layout(self):
		self.setStyleSheet("*{font: 12px Microsoft JHengHei, sans-serif;}")

		grpTimeRange = QtGui.QGroupBox('時間範圍'.decode("utf-8"), self)
		grpTimeRange.setGeometry(8,8,self.width - 16,50)

		self.spnStartFrame.setParent(grpTimeRange)
		self.spnStartFrame.setGeometry(grpTimeRange.width()/2 - 90,18,80,24)

		self.spnEndFrame.setParent(grpTimeRange)
		self.spnEndFrame.setGeometry(grpTimeRange.width() - 90,18,80,24)
		
		lbStartFrame = QtGui.QLabel('開始：'.decode("utf-8"), grpTimeRange)
		lbEndFrame = QtGui.QLabel('結束：'.decode("utf-8"), grpTimeRange)
		lbStartFrame.move(self.spnStartFrame.pos().x() - 40, self.spnStartFrame.pos().y() + 4)
		lbEndFrame.move(self.spnEndFrame.pos().x() - 40, self.spnEndFrame.pos().y() + 4)
		#---------------------------------------------------------
		self.btnConver2IK.setParent(self)
		self.btnConver2IK.setGeometry(20, 
									  grpTimeRange.pos().y()+grpTimeRange.height()+10,
									  80,40)
		self.btnConver2FK.setParent(self)
		self.btnConver2FK.setGeometry(self.btnConver2IK.pos().x()+self.btnConver2IK.width()+10, 
									  self.btnConver2IK.pos().y(),
									  80,40)

		#--------------------------------------------------
		# self.cbRightArm.setParent(self)
		# self.cbRightArm.move(self.width/2 - 46,
		# 					 self.btnConver2IK.pos().y()+self.btnConver2IK.height()+32)
		# self.cbLeftArm.setParent(self)
		# self.cbLeftArm.move(self.width/2 + 32,
		# 					 self.cbRightArm.pos().y())
		# self.cbRightLeg.setParent(self)
		# self.cbRightLeg.move(self.cbRightArm.pos().x(),
		# 					 self.height - 30)
		# self.cbLeftLeg.setParent(self)
		# self.cbLeftLeg.move(self.cbLeftArm.pos().x(),
		# 					self.cbRightLeg.pos().y())
		# self.cbSpine.setParent(self)
		# self.cbSpine.move(self.width/2 - 6,
		# 				  self.btnConver2IK.pos().y()+self.btnConver2IK.height()+12)
		# lbRightArm = QtGui.QLabel('Right Arm FK >', self)
		# lbRightArm.move(self.cbRightArm.pos().x()-92,
		# 				self.cbRightArm.pos().y()-2)
		# lbRightLeg = QtGui.QLabel('Right Leg FK >', self)
		# lbRightLeg.move(self.cbRightLeg.pos().x()-90,
		# 				self.cbRightLeg.pos().y()-2)

		# lbLeftArm = QtGui.QLabel('< Left Arm FK', self)
		# lbLeftArm.move(self.cbLeftArm.pos().x()+22,
		# 				self.cbLeftArm.pos().y()-2)
		# lbLeftLeg = QtGui.QLabel('< Left Leg FK', self)
		# lbLeftLeg.move(self.cbLeftLeg.pos().x()+22,
		# 				self.cbLeftLeg.pos().y()-2)

		# lbSpine = QtGui.QLabel('Head', self)
		# lbSpine.move(self.width/2 - 16, self.cbSpine.pos().y()+16)
		#------------------------
		self.choiceButtonGroup.setParent(self)
		self.choiceButtonGroup.setExclusive(True)
		# self.choiceButtonGroup.move(self.btnConver2FK.pos().x() + self.btnConver2FK.width() + 16,
		# 								   self.btnConver2FK.pos().y())

		self.rbTimeRange = QtGui.QRadioButton('時間範圍'.decode("utf-8"),self)
		self.rbSingleFrame = QtGui.QRadioButton('單幀'.decode("utf-8"),self)

		self.choiceButtonGroup.addButton(self.rbTimeRange)
		self.choiceButtonGroup.addButton(self.rbSingleFrame)
		self.choiceButtonGroup.setId(self.rbTimeRange, 0)
		self.choiceButtonGroup.setId(self.rbSingleFrame, 1)
		self.rbTimeRange.move(self.btnConver2FK.pos().x() + self.btnConver2FK.width() + 16,
							  self.btnConver2FK.pos().y())

		self.rbSingleFrame.move(self.rbTimeRange.pos().x(),
								self.rbTimeRange.pos().y() + 18)
		self.rbTimeRange.setChecked(True)
		#-------------------------
		self.cbbNameSpace.setParent(self)
		self.cbbNameSpace.setGeometry(8,self.btnConver2IK.pos().y() + 52,self.width-46, 22)

		self.btnRefreshNameSpace.setParent(self)
		self.btnRefreshNameSpace.setGeometry(self.width-33, self.cbbNameSpace.pos().y(), 22, 21)
		pass

	def create_connections(self):
		self.btnRefreshNameSpace.clicked.connect(self.doRefreshNameSpace)
		self.cbbNameSpace.currentIndexChanged.connect(self.doCbbNameSpaceChangeSelect)

		self.btnConver2IK.clicked.connect(self.onConvert2IKPressed)
		self.btnConver2FK.clicked.connect(self.onConvert2FKPressed)

		self.choiceButtonGroup.buttonClicked.connect(self.choiceChanged)

		self.cbSpine.clicked.connect((lambda e=0:self.onCheckPartChanged(e)))
		self.cbRightArm.clicked.connect((lambda e=1:self.onCheckPartChanged(e)))
		self.cbLeftArm.clicked.connect((lambda e=2:self.onCheckPartChanged(e)))
		self.cbRightLeg.clicked.connect((lambda e=3:self.onCheckPartChanged(e)))
		self.cbLeftLeg.clicked.connect((lambda e=4:self.onCheckPartChanged(e)))
		pass

	def closeEvent(self, event):
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
			if cmds.objExists(_ns+':Group'):
				self.cbbNameSpace.insertItem(-1,_ns+':')
		

	def doCbbNameSpaceChangeSelect(self, idx):
		if self.cbbNameSpace.itemText(idx)=='--':
			self.ns = ''
		else:
			self.ns = self.cbbNameSpace.itemText(idx)

	def choiceChanged(self):
		self.nConvertTimeType = self.choiceButtonGroup.checkedId()

	def onCheckPartChanged(self, partID):
		if   partID == 0:
			self.bSpine    = self.cbSpine.isChecked()
		elif partID == 1:
			self.bRightArm = self.cbRightArm.isChecked()
		elif partID == 2:
			self.bLeftArm  = self.cbLeftArm.isChecked()
		elif partID == 3:
			self.bRightLeg = self.cbRightLeg.isChecked()
		elif partID == 4:
			self.bLeftLeg  = self.cbLeftLeg.isChecked()

	def onConvert2IKPressed(self):
		if self.nConvertTimeType == 0:
			self.ConvertToGlobal_TimeRange(self.spnStartFrame.value(), self.spnEndFrame.value())
			cmds.currentTime(self.spnStartFrame.value())
		elif self.nConvertTimeType == 1:
			self.ConvertToGlobal_SingleFrame()

	def onConvert2FKPressed(self):
		if self.nConvertTimeType == 0:
			self.ConvertToLocal_TimeRange(self.spnStartFrame.value(), self.spnEndFrame.value())
			cmds.currentTime(self.spnStartFrame.value())
		elif self.nConvertTimeType == 1:
			self.ConvertToLocal_SingleFrame()


	##################
	## Functions
	##################
	def ConvertToGlobal_SingleFrame(self):
		ns = self.ns #getMainNameSpace()

		#################################
		#### 建立Proxy抓取骨架最終資訊 ####
		#################################
		listBakeNode = []
		listGCtrlType = {}
		selList = cmds.ls(sl=True)
		proxyRoot = cmds.createNode('transform',name='proxyRoot')
		for o in selList:
			clrName = o.split(':')[-1]
			if mel.eval('attributeExists "follow" ' + o + ';') == 1:
				ctrlType = 'FL'
			elif mel.eval('attributeExists "Global" ' + o + ';') == 1:
				ctrlType = 'GL'
			else:
				continue

			proxyObj = cmds.createNode('transform',name='proxy'+clrName)
			listBakeNode.append(proxyObj)
			cmds.parent(proxyObj, proxyRoot)
			listGCtrlType[clrName] = ctrlType

			cmds.parentConstraint(o, proxyObj, mo=False)


		#################################
		####        記錄動作        ####
		#################################
		if len(listBakeNode) > 0:
			poseData = getPose(listBakeNode)

			for o in listGCtrlType:
				actNode = ns + o
				if listGCtrlType[o] == 'GL':
					cmds.setAttr(actNode+'.Global', 10)
				elif listGCtrlType[o] == 'FL':
					cmds.setAttr(actNode+'.follow', 0)


			importPose(poseData, ns)
			#-------------------------
		cmds.delete(proxyRoot)
		cmds.select(selList)

	def ConvertToLocal_SingleFrame(self):
		ns = self.ns #getMainNameSpace()

		#################################
		#### 建立Proxy抓取骨架最終資訊 ####
		#################################
		listBakeNode = []
		listGCtrlType = {}
		selList = cmds.ls(sl=True)

		proxyRoot = cmds.createNode('transform',name='proxyRoot')
		for o in selList:
			clrName = o.split(':')[-1]
			if mel.eval('attributeExists "follow" ' + o + ';') == 1:
				ctrlType = 'FL'
			elif mel.eval('attributeExists "Global" ' + o + ';') == 1:
				ctrlType = 'GL'
			else:
				continue

			proxyObj = cmds.createNode('transform',name='proxy'+clrName)
			listBakeNode.append(proxyObj)
			cmds.parent(proxyObj, proxyRoot)
			listGCtrlType[clrName] = ctrlType

			cmds.parentConstraint(o, proxyObj, mo=False)
		#################################
		####        記錄FK動作        ####
		#################################
		if len(listBakeNode) > 0:
			poseData = getPose(listBakeNode)

			for o in listGCtrlType:
				actNode = ns + o
				if listGCtrlType[o] == 'GL':
					cmds.setAttr(actNode+'.Global', 0)
				elif listGCtrlType[o] == 'FL':
					cmds.setAttr(actNode+'.follow', 10)

			importPose(poseData, ns)
			#-------------------------
		cmds.delete(proxyRoot)
		cmds.select(selList)

	def setKeyframeAtBeginEnd(self, start, end):
		selList = cmds.ls(sl=True)

		for frame in (start-1, end+1):
			cmds.currentTime(frame)
			for clrName in selList:
				if mel.eval('attributeExists "follow" ' + clrName + ';') == 1:
					ctrlType = 'FL'
				elif mel.eval('attributeExists "Global" ' + clrName + ';') == 1:
					ctrlType = 'GL'
				else:
					continue
				cmds.setKeyframe(clrName, at='translate')
				cmds.setKeyframe(clrName, at='rotate')

	def ConvertToGlobal_TimeRange(self, startFrame, endFrame):
		ns = self.ns #getMainNameSpace()
		timePrefix = startFrame
		framesCount = endFrame - startFrame + 1

		# 現在調整範圍的前後都先setkey，確保調整的東西不會影響
		self.setKeyframeAtBeginEnd(startFrame, endFrame)

		cmds.currentTime(startFrame)

		#################################
		#### 建立Proxy抓取骨架最終資訊 ####
		#################################
		listBakeNode = []
		listGCtrlType = {}
		selList = cmds.ls(sl=True)
		proxyRoot = cmds.createNode('transform',name='proxyRoot')
		for o in selList:
			clrName = o.split(':')[-1]
			if mel.eval('attributeExists "follow" ' + o + ';') == 1:
				ctrlType = 'FL'
			elif mel.eval('attributeExists "Global" ' + o + ';') == 1:
				ctrlType = 'GL'
			else:
				continue

			proxyObj = cmds.createNode('transform',name='proxy'+clrName)
			listBakeNode.append(proxyObj)
			cmds.parent(proxyObj, proxyRoot)
			listGCtrlType[clrName] = ctrlType

			cmds.parentConstraint(o, proxyObj, mo=False)
		
		
		#################################
		####        記錄動作        ####
		#################################
		if len(listBakeNode) > 0:
			anmData = getAnima(listBakeNode, startFrame, endFrame)

			for o in listGCtrlType:
				actNode = ns + o
				if listGCtrlType[o] == 'GL':
					# cmds.setAttr(actNode+'.Global', 10)
					actAttr = 'Global'
					actValue = 10
				elif listGCtrlType[o] == 'FL':
					actAttr = 'follow'
					actValue = 0
					# cmds.setAttr(actNode+'.follow', 0

				vStart = cmds.getAttr(actNode+'.'+actAttr, time=(startFrame - 1))
				vEnd   = cmds.getAttr(actNode+'.'+actAttr, time=(endFrame + 1))
				cmds.setKeyframe(actNode+'.'+actAttr, time=(startFrame - 1), value=vStart, itt='slow', ott='step')
				cmds.setKeyframe(actNode+'.'+actAttr, time=(endFrame + 1), value=vEnd, itt='slow', ott='step')
				cmds.cutKey(actNode, cl=True, t=(startFrame,endFrame), at=[actAttr])
				cmds.setKeyframe(actNode+'.'+actAttr, time=startFrame, value=actValue,itt='slow', ott='step')
				cmds.setKeyframe(actNode+'.'+actAttr, time=endFrame, value=actValue,itt='slow', ott='step')



			importAnima(anmData, startFrame, ns)
		#-------------------------
		cmds.delete(proxyRoot)
		cmds.select(selList)

	def ConvertToLocal_TimeRange(self, startFrame, endFrame):
		ns = self.ns #getMainNameSpace()
		timePrefix = startFrame
		framesCount = endFrame - startFrame + 1

		# 現在調整範圍的前後都先setkey，確保調整的東西不會影響
		self.setKeyframeAtBeginEnd(startFrame, endFrame)

		cmds.currentTime(startFrame)

		#################################
		#### 建立Proxy抓取骨架最終資訊 ####
		#################################
		listBakeNode = []
		listGCtrlType = {}
		selList = cmds.ls(sl=True)
		proxyRoot = cmds.createNode('transform',name='proxyRoot')
		for o in selList:
			clrName = o.split(':')[-1]
			if mel.eval('attributeExists "follow" ' + o + ';') == 1:
				ctrlType = 'FL'
			elif mel.eval('attributeExists "Global" ' + o + ';') == 1:
				ctrlType = 'GL'
			else:
				continue

			proxyObj = cmds.createNode('transform',name='proxy'+clrName)
			listBakeNode.append(proxyObj)
			cmds.parent(proxyObj, proxyRoot)
			listGCtrlType[clrName] = ctrlType

			cmds.parentConstraint(o, proxyObj, mo=False)
		
		
		#################################
		####        記錄動作        ####
		#################################
		if len(listBakeNode) > 0:
			anmData = getAnima(listBakeNode, startFrame, endFrame)

			for o in listGCtrlType:
				actNode = ns + o
				if listGCtrlType[o] == 'GL':
					# cmds.setAttr(actNode+'.Global', 10)
					actAttr = 'Global'
					actValue = 0
				elif listGCtrlType[o] == 'FL':
					actAttr = 'follow'
					actValue = 10
					# cmds.setAttr(actNode+'.follow', 0

				vStart = cmds.getAttr(actNode+'.'+actAttr, time=(startFrame - 1))
				vEnd   = cmds.getAttr(actNode+'.'+actAttr, time=(endFrame + 1))
				cmds.setKeyframe(actNode+'.'+actAttr, time=(startFrame - 1), value=vStart, itt='slow', ott='step')
				cmds.setKeyframe(actNode+'.'+actAttr, time=(endFrame + 1), value=vEnd, itt='slow', ott='step')
				cmds.cutKey(actNode, cl=True, t=(startFrame,endFrame), at=[actAttr])
				cmds.setKeyframe(actNode+'.'+actAttr, time=startFrame, value=actValue,itt='slow', ott='step')
				cmds.setKeyframe(actNode+'.'+actAttr, time=endFrame, value=actValue,itt='slow', ott='step')



			importAnima(anmData, startFrame, ns)
		#-------------------------
		cmds.delete(proxyRoot)
		cmds.select(selList)
#===================================================================

def createUI():
	IKFK_ui = GlobalLocalConvert()