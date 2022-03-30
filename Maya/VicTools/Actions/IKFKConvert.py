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
import Helper
reload(Helper)

import JointToController
reload( JointToController )

# pi = 3.14159265359

# def radByAngle(angle):
# 	return angle / 180.0 * pi

# def getPose(nodeList):
# 	objCount = len(nodeList)

# 	PoseData = OrderedDict()
# 	PoseData['count'] = objCount

# 	objList = []
# 	for o in nodeList:
# 		clrName = o[5:]
# 		objList.append(clrName)

# 	PoseData['name'] = objList

# 	mtxArray = []

# 	for o in nodeList:
# 		cWMtx = list(cmds.xform(o,q=True,ws=True,m=True))
# 		mtxArray.append(cWMtx)

# 	transformData = OrderedDict()
# 	transformData["wrdMatrix"] = mtxArray

# 	PoseData['Pose'] = transformData

# 	return PoseData

# def importPose(transData, nameSpaceFrefix=''):

# 	objCount = transData['count']
# 	objList = transData['name']
# 	PoseData = transData['Pose']

# 	for i in range(objCount):
# 		if (cmds.objExists(nameSpaceFrefix + objList[i])):
# 			cmds.xform(nameSpaceFrefix + objList[i], ws=True, m=(PoseData['wrdMatrix'][i]))


# def getAnima(nodeList, startTime, endTime):
# 	objCount = len(nodeList)
# 	currentTime = int(cmds.currentTime(q=True))
# 	framesCount = endTime - startTime + 1

# 	AnimData = OrderedDict()
# 	AnimData['count'] = objCount

# 	objList = []
# 	for o in nodeList:
# 		clrName = o[5:]
# 		objList.append(clrName)
			
# 	AnimData['name'] = objList

# 	AnimData['timelength'] = framesCount

# 	frameAniData = OrderedDict()
# 	for f in range(framesCount):
# 		cmds.currentTime(f + startTime)
# 		mtxArray = []
		
# 		for o in nodeList:
# 			cWMtx = list(cmds.xform(o,q=True,ws=True,m=True))
# 			mtxArray.append(cWMtx)	
		
# 		transformData = OrderedDict()
# 		transformData["wrdMatrix"] = mtxArray
# 		frameAniData[f] = transformData
	
# 	AnimData["Animation"] = frameAniData

# 	cmds.currentTime(currentTime)
# 	return AnimData

# def importAnima(anmData, startFrame, isIK = True, nameSpaceFrefix=''):
# 	oriAutoKeyState = cmds.autoKeyframe(q=True,state=True)
# 	cmds.autoKeyframe(state=False)

# 	objCount = anmData['count']
# 	objList = anmData['name']
# 	framesCount = anmData['timelength']
# 	AnimData = anmData['Animation']
# 	endTime = int(cmds.playbackOptions(q=True, max=True))
# 	# startFrame = int(cmds.currentTime(q=True))
# 	for f in range(framesCount):
# 		tKey = f#str(f)
# 		cmds.currentTime(f + startFrame)
# 		for i in range(objCount):
# 			if (cmds.objExists(nameSpaceFrefix + objList[i])):
# 				cmds.xform(nameSpaceFrefix + objList[i], ws=True, m=(AnimData[tKey]['wrdMatrix'][i]))
# 				if isIK: cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".translate")
# 				cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".rotate")

# 	# for i in range(0,objCount):
# 	# 	if (cmds.objExists(nameSpaceFrefix + objList[i])):
# 	# 		cmds.filterCurve(nameSpaceFrefix+objList[i]+".rotateX",nameSpaceFrefix+objList[i]+".rotateY",nameSpaceFrefix+objList[i]+".rotateZ")

# 	cmds.autoKeyframe(state=oriAutoKeyState)

# def getMainNameSpace():
# 	ns = cmds.namespaceInfo(lon=True)
# 	# ns = ns[0:-2][0] + ':'
# 	if len(ns) > 2:
# 		return ns[0:-2][0] + ':'
# 	else:
# 		return ''

def maya_main_window():
	main_window_ptr = omui.MQtUtil.mainWindow()
	return wrapInstance(long(main_window_ptr), QtGui.QWidget)

class IKFKConvert(QtGui.QDialog):
	width = 320
	height = 240

	spnStartFrame = QtGui.QSpinBox()
	spnEndFrame   = QtGui.QSpinBox()

	cbbNameSpace = QtGui.QComboBox()
	btnRefreshNameSpace = QtGui.QPushButton('↻'.decode("utf-8"))

	ns = ''
	nConvertTimeType = 1
	bRightArm = False
	bLeftArm = False
	bRightLeg = False
	bLeftLeg = False
	bSpine = False

	spineEditable = False

	def __init__(self, parent=maya_main_window()):
		self.closeExistingWindow()
		super(IKFKConvert, self).__init__(parent)
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
		self.setWindowTitle('IK / FK 轉換'.decode("utf-8"))
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

		self.btnConver2IK = QtGui.QPushButton('>  IK')
		self.btnConver2FK = QtGui.QPushButton('>  FK')

		self.choiceButtonGroup = QtGui.QButtonGroup()
		self.cbRightArm = QtGui.QCheckBox('')
		self.cbLeftArm = QtGui.QCheckBox('')
		self.cbRightLeg = QtGui.QCheckBox('')
		self.cbLeftLeg = QtGui.QCheckBox('')

		# 因爲獸首妖和魍魎的腿部fk左右controller相反了，又不可能推倒重來，這邊先暫時加個勾勾，決定程式要不要自動反過來
		# self.cbFlipKnee = QtGui.QCheckBox('')

		if self.spineEditable:
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
		self.cbRightArm.setParent(self)
		self.cbRightArm.move(self.width/2 - 46,
							 self.btnConver2IK.pos().y()+self.btnConver2IK.height()+16)
		self.cbLeftArm.setParent(self)
		self.cbLeftArm.move(self.width/2 + 32,
							 self.cbRightArm.pos().y())
		self.cbRightLeg.setParent(self)
		self.cbRightLeg.move(self.cbRightArm.pos().x(),
							 self.cbRightArm.pos().y() + 50)
		self.cbLeftLeg.setParent(self)
		self.cbLeftLeg.move(self.cbLeftArm.pos().x(),
							self.cbRightLeg.pos().y())
		
		if self.spineEditable:
			self.cbSpine.setParent(self)
			self.cbSpine.move(self.width/2 - 6,
							(self.cbRightArm.pos().y()+self.cbRightLeg.pos().y())/2 - 10)
		lbRightArm = QtGui.QLabel('Right Arm  >', self)
		lbRightArm.move(self.cbRightArm.pos().x()-80,
						self.cbRightArm.pos().y()-2)
		lbRightLeg = QtGui.QLabel('Right Leg  >', self)
		lbRightLeg.move(self.cbRightLeg.pos().x()-78,
						self.cbRightLeg.pos().y()-2)

		lbLeftArm = QtGui.QLabel('< Left Arm', self)
		lbLeftArm.move(self.cbLeftArm.pos().x()+22,
						self.cbLeftArm.pos().y()-2)
		lbLeftLeg = QtGui.QLabel('< Left Leg', self)
		lbLeftLeg.move(self.cbLeftLeg.pos().x()+22,
						self.cbLeftLeg.pos().y()-2)

		if self.spineEditable:
			lbSpine = QtGui.QLabel('Spine', self)
			lbSpine.move(self.width/2 - 16, self.cbSpine.pos().y()+16)

		# self.cbFlipKnee.setParent(self)
		# self.cbFlipKnee.move(self.width- 25, self.height-20)
		
		# lbFlipknee = QtGui.QLabel(u'修正獸首妖', self)
		# lbFlipknee.move(self.cbFlipKnee.pos().x()-65,
		# 				self.cbFlipKnee.pos().y()-2)

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
		self.rbTimeRange.setChecked(False)
		self.rbSingleFrame.setChecked(True)
		#-------------------------
		self.cbbNameSpace.setParent(self)
		self.cbbNameSpace.setGeometry(8,self.cbRightLeg.pos().y() + 36,self.width-46, 22)

		self.btnRefreshNameSpace.setParent(self)
		self.btnRefreshNameSpace.setGeometry(self.width-33, self.cbbNameSpace.pos().y(), 22, 21)
		pass

	def create_connections(self):
		self.btnConver2IK.clicked.connect(self.onConvert2IKPressed)
		self.btnConver2FK.clicked.connect(self.onConvert2FKPressed)

		self.choiceButtonGroup.buttonClicked.connect(self.choiceChanged)

		if self.spineEditable:
			self.cbSpine.clicked.connect((lambda e=0:self.onCheckPartChanged(e)))
		self.cbRightArm.clicked.connect((lambda e=1:self.onCheckPartChanged(e)))
		self.cbLeftArm.clicked.connect((lambda e=2:self.onCheckPartChanged(e)))
		self.cbRightLeg.clicked.connect((lambda e=3:self.onCheckPartChanged(e)))
		self.cbLeftLeg.clicked.connect((lambda e=4:self.onCheckPartChanged(e)))

		self.btnRefreshNameSpace.clicked.connect(self.doRefreshNameSpace)
		self.cbbNameSpace.currentIndexChanged.connect(self.doCbbNameSpaceChangeSelect)
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

	def checkAndFixHumanRoleToe(self, ns, start, end):
		(leftFrames, rightFrames) = Helper.checkIsNeedFixHumanRole(ns, start, end)
		if self.bLeftLeg and len(leftFrames) > 0: 
			for fixFrame in leftFrames:
				Helper.fixHumanRoleToe(ns, True, False, fixFrame, end, True)
		if self.bRightLeg and len(rightFrames) > 0:
			for fixFrame in rightFrames:
				Helper.fixHumanRoleToe(ns, False, True, fixFrame, end, True)

	def beforeIKFK(self):
		isAnimation = (self.nConvertTimeType == 0)
		ns = self.ns
		if ns[-1] == ":": ns = ns[0:-1]
		currentFrame = int(cmds.currentTime(q=1))
		if isAnimation:
			startFrame = self.spnStartFrame.value()
			endFrame = self.spnEndFrame.value()
			self.checkAndFixHumanRoleToe(ns, startFrame, endFrame+1)
		else:
			self.checkAndFixHumanRoleToe(ns, currentFrame, currentFrame+1)

	def onConvert2IKPressed(self):		
		
		isAnimation = (self.nConvertTimeType == 0)
		ns = self.ns
		if ns[-1] == ":": ns = ns[0:-1]

		currentFrame = int(cmds.currentTime(q=1))

		self.beforeIKFK()
		# 這裏不需要呼叫extra，extra是給fbx to maya用的
		bake, extra =  JointToController.genMapAndConvertIK(ns, self.bLeftArm, self.bRightArm, self.bLeftLeg, self.bRightLeg, isAnimation)
		if isAnimation:
			# 切回dg模式，不然在bake的時候容易crash
			cmds.evaluationManager( mode="off" )

			startFrame = self.spnStartFrame.value()
			endFrame = self.spnEndFrame.value()

			self.checkAndSetBlendAnimation(self.ns, startFrame, endFrame, 10)

			for i in range(startFrame, endFrame+1):
				bake(i)

			# 設置ikfk模式前要先切換囘平行模式，不然視圖不會更新
			cmds.evaluationManager( mode="parallel" )
		else:

			bake(currentFrame)
			self.checkAndSetBlend(self.ns, 10)
		
		Helper.fixEulerCurve()
		
		# def doHumanFootR(ns, proxys, rmap):
		# 	foot = proxys[0]
		# 	toe = proxys[1]
		# 	cmds.xform(foot, ws=1,m=rmap["Ankle_R"])
		# 	cmds.parentConstraint(ns+'Ankle_R', foot, mo=True)
		# 	cmds.parentConstraint(ns+'Toes_R', toe, mo=False)
		
		# def doHumanFootL(ns, proxys, rmap):
		# 	foot = proxys[0]
		# 	toe = proxys[1]
		# 	cmds.xform(foot, ws=1,m=rmap["Ankle_L"])
		# 	cmds.parentConstraint(ns+'Ankle_L', foot, mo=True)
		# 	cmds.parentConstraint(ns+'Toes_L', toe, mo=False)

		# def doHumanGetFootRFK():
		# 	return ["FKAnkle_R", None, "FKToes_R"]

		# def doHumanGetFootLFK():
		# 	return ["FKAnkle_L", None, "FKToes_L"]

		# def doShandianFootR(ns, proxys, rmap):
		# 	foot = proxys[0]
		# 	cmds.xform(foot, ws=1,m=rmap["Toes2_R"])
		# 	cmds.parentConstraint(ns+'Toes2_R', foot, mo=True)
		
		# def doShandianFootL(ns, proxys, rmap):
		# 	foot = proxys[0]
		# 	cmds.xform(foot, ws=1,m=rmap["Toes2_L"])
		# 	cmds.parentConstraint(ns+'Toes2_L', foot, mo=True)

		# def doShandianGetFootRFK():
		# 	return ["FKToes2_R", None, None]

		# def doShandianGetFootLFK():
		# 	return ["FKToes2_L", None, None]

		# rigType = Helper.checkRigType(self.ns)
		# rotateMatMap = self.calculateRotateMat(rigType)
		# isAnimation = (self.nConvertTimeType == 0)
		# self.ConvertToIK_SingleFrame( rotateMatMap, {
		# 	"doFootR":doHumanFootR if rigType == "human" else doShandianFootR,
		# 	"doFootL":doHumanFootL if rigType == "human" else doShandianFootL,
		# 	"getFootRFK":doHumanGetFootRFK if rigType == "human" else doShandianGetFootRFK,
		# 	"getFootLFK":doHumanGetFootLFK if rigType == "human" else doShandianGetFootLFK
		# }, isAnimation )

	def onConvert2FKPressed(self):

		self.beforeIKFK()

		ns = self.ns
		if ns[-1] == ":": ns = ns[0:-1]
		bake =  JointToController.setFKfromJoint(ns, self.bLeftArm, self.bRightArm, self.bLeftLeg, self.bRightLeg)

		isAnimation = (self.nConvertTimeType == 0)
		if isAnimation:
			# 切回dg模式，不然在bake的時候容易crash
			cmds.evaluationManager( mode="off" )

			startFrame = self.spnStartFrame.value()
			endFrame = self.spnEndFrame.value()

			self.checkAndSetBlendAnimation(self.ns, startFrame, endFrame, 0)

			for i in range(startFrame, endFrame+1):
				bake(i)
			
			# 設置ikfk模式前要先切換囘平行模式，不然視圖不會更新
			cmds.evaluationManager( mode="parallel" )
		else:

			bake(cmds.currentTime(q=1), False)
			self.checkAndSetBlend(self.ns, 0)

		Helper.fixEulerCurve()
		# def doHumanFootR(ns, proxys):
		# 	foot = proxys[0]
		# 	toe = proxys[1]
		# 	cmds.parentConstraint(ns+'Ankle_R', foot, mo=False)
		# 	cmds.parentConstraint(ns+'Toes_R', toe, mo=False)

		# 	hip = proxys[4]
		# 	knee = proxys[5]
		# 	cmds.pointConstraint(ns+'Hip_R', hip, mo=False)
		# 	cmds.aimConstraint(ns+'Knee_R', hip, aim=[1,0,0], u=[0,0,1], wut="objectrotation", wuo=(ns+'Knee_R'), wu=[0,0,1])
		# 	cmds.parentConstraint(ns+'Knee_R', knee, mo=False)
		
		# def doHumanFootL(ns, proxys):
		# 	foot = proxys[0]
		# 	toe = proxys[1]
		# 	cmds.parentConstraint(ns+'Ankle_L', foot, mo=False)
		# 	cmds.parentConstraint(ns+'Toes_L', toe, mo=False)

		# 	hip = proxys[4]
		# 	knee = proxys[5]
		# 	cmds.pointConstraint(ns+'Hip_L', hip, mo=False)
		# 	cmds.aimConstraint(ns+'Knee_L', hip, aim=[-1,0,0], u=[0,0,1], wut="objectrotation", wuo=(ns+'Knee_L'), wu=[0,0,1])
		# 	cmds.parentConstraint(ns+'Knee_L', knee, mo=False)

		# def doHumanGetFootRFK():
		# 	return ["FKHip_R","FKKnee_R","FKAnkle_R","FKToes_R", None, None]

		# def doHumanGetFootLFK():
		# 	return ["FKHip_L","FKKnee_L","FKAnkle_L","FKToes_L", None, None]

		# def doShandianFootR(ns, proxys):
		# 	foot = proxys[0]
		# 	toe1 = proxys[2]
		# 	toe2 = proxys[3]
		# 	cmds.parentConstraint(ns+'Ankle_R', foot, mo=False)
		# 	cmds.parentConstraint(ns+'Toes1_R', toe1, mo=False)
		# 	cmds.parentConstraint(ns+'Toes2_R', toe2, mo=False)

		# 	hip = proxys[4]
		# 	knee = proxys[5]
		# 	cmds.pointConstraint(ns+'Hip_R', hip, mo=False)

		# 	# 這邊之後最好改成全部都跟人類一樣，就不用分支了
		# 	if self.cbFlipKnee.isChecked():
		# 		# 獸首妖
		# 		cmds.aimConstraint(ns+'Knee_R', hip, aim=[1,0,0], u=[0,0,-1], wut="objectrotation", wuo=(ns+'Knee_R'), wu=[0,0,1])
		# 	else:
		# 		# 魍魎、人類
		# 		cmds.aimConstraint(ns+'Knee_R', hip, aim=[1,0,0], u=[0,0,1], wut="objectrotation", wuo=(ns+'Knee_R'), wu=[0,0,1])
		# 	cmds.parentConstraint(ns+'Knee_R', knee, mo=False)
		
		# def doShandianFootL(ns, proxys):
		# 	foot = proxys[0]
		# 	toe1 = proxys[2]
		# 	toe2 = proxys[3]
		# 	cmds.parentConstraint(ns+'Ankle_L', foot, mo=False)
		# 	cmds.parentConstraint(ns+'Toes1_L', toe1, mo=False)
		# 	cmds.parentConstraint(ns+'Toes2_L', toe2, mo=False)

		# 	hip = proxys[4]
		# 	knee = proxys[5]
		# 	cmds.pointConstraint(ns+'Hip_L', hip, mo=False)

		# 	# 這邊之後最好改成全部都跟人類一樣，就不用分支了
		# 	if self.cbFlipKnee.isChecked():
		# 		# 獸首妖
		# 		cmds.aimConstraint(ns+'Knee_L', hip, aim=[-1,0,0], u=[0,0,-1], wut="objectrotation", wuo=(ns+'Knee_L'), wu=[0,0,1])
		# 	else:
		# 		# 魍魎、人類
		# 		cmds.aimConstraint(ns+'Knee_L', hip, aim=[-1,0,0], u=[0,0,1], wut="objectrotation", wuo=(ns+'Knee_L'), wu=[0,0,1])

		# 	cmds.parentConstraint(ns+'Knee_L', knee, mo=False)

		# def doShandianGetFootRFK():
		# 	return ["FKHip_R","FKKnee_R","FKAnkle_R", None,"FKToes1_R","FKToes2_R"]

		# def doShandianGetFootLFK():
		# 	return ["FKHip_L","FKKnee_L","FKAnkle_L", None,"FKToes1_L","FKToes2_L"]

		# rigType = Helper.checkRigType(self.ns)
		# isAnimation = (self.nConvertTimeType == 0)
		# self.ConvertToFK_SingleFrame({
		# 	"doFootR":doHumanFootR if rigType == "human" else doShandianFootR,
		# 	"doFootL":doHumanFootL if rigType == "human" else doShandianFootL,
		# 	"getFootRFK":doHumanGetFootRFK if rigType == "human" else doShandianGetFootRFK,
		# 	"getFootLFK":doHumanGetFootLFK if rigType == "human" else doShandianGetFootLFK
		# }, isAnimation)

	##################
	## Functions
	##################
	# def calculateRotateMat(self, rigType):
	# 	ns = self.ns

	# 	if rigType == 'shandian':
	# 		# 暫時的用法。閃電腿的設定
	# 		map = {
	# 			"Wrist_L":["FKWrist_L","IKArm_L"],
	# 			"Wrist_R":["FKWrist_R","IKArm_R"],
	# 			"Toes2_L":["FKToes2_L","IKLeg_L"],
	# 			"Toes2_R":["FKToes2_R","IKLeg_R"],

	# 			# 脊椎的部分先關掉
	# 			# "Root_M":["FKRoot_M","IKSpine1_M"],
	# 			# "Chest_M":["FKChest_M","IKSpine3_M"]
	# 		}

	# 		map["Toes2_L"].append(self.bLeftLeg)
	# 		map["Toes2_R"].append(self.bRightLeg)
	# 	else:
	# 		# 暫時的用法。人類的設定
	# 		map = {
	# 			"Wrist_L":["FKWrist_L","IKArm_L"],
	# 			"Wrist_R":["FKWrist_R","IKArm_R"],
	# 			"Ankle_L":["FKAnkle_L","IKLeg_L"],
	# 			"Ankle_R":["FKAnkle_R","IKLeg_R"],
	# 		}

	# 		map["Ankle_L"].append(self.bLeftLeg)
	# 		map["Ankle_R"].append(self.bRightLeg)

	# 	map["Wrist_L"].append(self.bLeftArm)
	# 	map["Wrist_R"].append(self.bRightArm)

	# 	returnMap = {}
	# 	for key in map:
	# 		value = map[key]
	# 		active = value[2]
	# 		if active:
	# 			joint = key
	# 			fkctrl = ns + ":" + value[0]
	# 			ikctrl = ns + ":" + value[1]

	# 			# 取出原來的ik矩陣。在做完運算時，把他歸位
	# 			ikmat = cmds.xform(ikctrl, ws=1,q=1,m=1)

	# 			# 把ik控制器對位到fk控制器
	# 			Helper.attach( fkctrl, ikctrl )

	# 			# 取出ik到fk的旋轉矩陣
	# 			diff = Helper.rotateIKCrtlCurrectToFKCrtl(ns, joint)

	# 			# 把ik做旋轉到正確的角度，并且取出正確角度的矩陣。之後讓proxy來使用。注意取出來的位置是在fk的位置。
	# 			orimat = cmds.xform(ikctrl, ws=1,q=1,m=1)
	# 			totalmat = Helper.getOpenMayaMatrix( diff ) * Helper.getOpenMayaMatrix( orimat )

	# 			# 把ik歸位
	# 			cmds.xform(ikctrl, ws=1,m=ikmat)

	# 			# 記錄矩陣
	# 			returnMap[joint] = Helper.getMelMatrix(totalmat)
	# 	return returnMap
		
	def checkAndSetBlend(self, ns, value):
		print( "checkAndSetBlend", ns+"FKIKSpine_M.FKIKBlend", value )
		if self.bSpine:
			cmds.setAttr(ns+"FKIKSpine_M.FKIKBlend", value)

		if self.bRightArm:
			cmds.setAttr(ns+"FKIKArm_R.FKIKBlend", value)

			# guicha01a
			Helper.setAttr(ns+"FKIKArm2_R.FKIKBlend", value)

		if self.bLeftArm:
			cmds.setAttr(ns+"FKIKArm_L.FKIKBlend", value)

			# guicha01a
			Helper.setAttr(ns+"FKIKArm2_L.FKIKBlend", value)

		if self.bRightLeg:
			cmds.setAttr(ns+"FKIKLeg_R.FKIKBlend", value)

		if self.bLeftLeg:
			cmds.setAttr(ns+"FKIKLeg_L.FKIKBlend", value)

	def checkAndSetBlendAnimation(self, ns, startFrame, endFrame, value):
		if self.bSpine:
			vStart = cmds.getAttr(ns+"FKIKSpine_M.FKIKBlend", time=(startFrame - 1))
			vEnd   = cmds.getAttr(ns+"FKIKSpine_M.FKIKBlend", time=(endFrame + 1))
			cmds.setKeyframe(ns+"FKIKSpine_M.FKIKBlend", time=(startFrame - 1), value=vStart, itt='slow', ott='step')
			cmds.setKeyframe(ns+"FKIKSpine_M.FKIKBlend", time=(endFrame + 1), value=vEnd, itt='slow', ott='step')
			cmds.cutKey(ns+"FKIKSpine_M", cl=True, t=(startFrame,endFrame), at=['FKIKBlend'])
			cmds.setKeyframe(ns+"FKIKSpine_M.FKIKBlend", time=startFrame, value=value,itt='slow', ott='step')
			cmds.setKeyframe(ns+"FKIKSpine_M.FKIKBlend", time=endFrame, value=value,itt='slow', ott='step')

		if self.bRightArm:
			vStart = cmds.getAttr(ns+"FKIKArm_R.FKIKBlend", time=(startFrame - 1))
			vEnd   = cmds.getAttr(ns+"FKIKArm_R.FKIKBlend", time=(endFrame + 1))
			cmds.setKeyframe(ns+"FKIKArm_R.FKIKBlend", time=(startFrame - 1), value=vStart, itt='slow', ott='step')
			cmds.setKeyframe(ns+"FKIKArm_R.FKIKBlend", time=(endFrame + 1), value=vEnd, itt='slow', ott='step')
			cmds.cutKey(ns+"FKIKArm_R", cl=True, t=(startFrame,endFrame), at=['FKIKBlend'])
			cmds.setKeyframe(ns+"FKIKArm_R.FKIKBlend", time=startFrame, value=value,itt='slow', ott='step')
			cmds.setKeyframe(ns+"FKIKArm_R.FKIKBlend", time=endFrame, value=value,itt='slow', ott='step')

			# guicha01a
			Helper.setKeyframe(ns+"FKIKArm2_R.FKIKBlend", time=(startFrame - 1), value=vStart, itt='slow', ott='step')
			Helper.setKeyframe(ns+"FKIKArm2_R.FKIKBlend", time=(endFrame + 1), value=vEnd, itt='slow', ott='step')
			Helper.cutKey(ns+"FKIKArm2_R", cl=True, t=(startFrame,endFrame), at=['FKIKBlend'])
			Helper.setKeyframe(ns+"FKIKArm2_R.FKIKBlend", time=startFrame, value=value,itt='slow', ott='step')
			Helper.setKeyframe(ns+"FKIKArm2_R.FKIKBlend", time=endFrame, value=value,itt='slow', ott='step')

		if self.bLeftArm:
			vStart = cmds.getAttr(ns+"FKIKArm_L.FKIKBlend", time=(startFrame - 1))
			vEnd   = cmds.getAttr(ns+"FKIKArm_L.FKIKBlend", time=(endFrame + 1))
			cmds.setKeyframe(ns+"FKIKArm_L.FKIKBlend", time=(startFrame - 1), value=vStart, itt='slow', ott='step')
			cmds.setKeyframe(ns+"FKIKArm_L.FKIKBlend", time=(endFrame + 1), value=vEnd, itt='slow', ott='step')
			cmds.cutKey(ns+"FKIKArm_L", cl=True, t=(startFrame,endFrame), at=['FKIKBlend'])
			cmds.setKeyframe(ns+"FKIKArm_L.FKIKBlend", time=startFrame, value=value,itt='slow', ott='step')
			cmds.setKeyframe(ns+"FKIKArm_L.FKIKBlend", time=endFrame, value=value,itt='slow', ott='step')

			# guicha01a
			Helper.setKeyframe(ns+"FKIKArm2_L.FKIKBlend", time=(startFrame - 1), value=vStart, itt='slow', ott='step')
			Helper.setKeyframe(ns+"FKIKArm2_L.FKIKBlend", time=(endFrame + 1), value=vEnd, itt='slow', ott='step')
			Helper.cutKey(ns+"FKIKArm2_L", cl=True, t=(startFrame,endFrame), at=['FKIKBlend'])
			Helper.setKeyframe(ns+"FKIKArm2_L.FKIKBlend", time=startFrame, value=value,itt='slow', ott='step')
			Helper.setKeyframe(ns+"FKIKArm2_L.FKIKBlend", time=endFrame, value=value,itt='slow', ott='step')

		if self.bRightLeg:
			vStart = cmds.getAttr(ns+"FKIKLeg_R.FKIKBlend", time=(startFrame - 1))
			vEnd   = cmds.getAttr(ns+"FKIKLeg_R.FKIKBlend", time=(endFrame + 1))
			cmds.setKeyframe(ns+"FKIKLeg_R.FKIKBlend", time=(startFrame - 1), value=vStart, itt='slow', ott='step')
			cmds.setKeyframe(ns+"FKIKLeg_R.FKIKBlend", time=(endFrame + 1), value=vEnd, itt='slow', ott='step')
			cmds.cutKey(ns+"FKIKLeg_R", cl=True, t=(startFrame,endFrame), at=['FKIKBlend'])
			cmds.setKeyframe(ns+"FKIKLeg_R.FKIKBlend", time=startFrame, value=value,itt='slow', ott='step')
			cmds.setKeyframe(ns+"FKIKLeg_R.FKIKBlend", time=endFrame, value=value,itt='slow', ott='step')

		if self.bLeftLeg:
			vStart = cmds.getAttr(ns+"FKIKLeg_L.FKIKBlend", time=(startFrame - 1))
			vEnd   = cmds.getAttr(ns+"FKIKLeg_L.FKIKBlend", time=(endFrame + 1))
			cmds.setKeyframe(ns+"FKIKLeg_L.FKIKBlend", time=(startFrame - 1), value=vStart, itt='slow', ott='step')
			cmds.setKeyframe(ns+"FKIKLeg_L.FKIKBlend", time=(endFrame + 1), value=vEnd, itt='slow', ott='step')
			cmds.cutKey(ns+"FKIKLeg_L", cl=True, t=(startFrame,endFrame), at=['FKIKBlend'])
			cmds.setKeyframe(ns+"FKIKLeg_L.FKIKBlend", time=startFrame, value=value,itt='slow', ott='step')
			cmds.setKeyframe(ns+"FKIKLeg_L.FKIKBlend", time=endFrame, value=value,itt='slow', ott='step')

	# def ConvertToIK_SingleFrame(self, rotateMatMap, strategy, animation = False ):
	# 	ns = self.ns

	# 	#################################
	# 	#### 建立Proxy抓取骨架最終資訊 ####
	# 	#################################
	# 	proxyRoot = cmds.createNode('transform',name='proxyRoot')

	# 	# 記錄ikfk的初始狀態,因爲做計算的時候,會轉換狀態.計算完后,要再切回來
	# 	fkiksets = Helper.getIKFKBlend(ns)

	# 	# 因爲rotateMatMap是以fk位置爲主來計算的。所以在綁定proxy的時候，要先切換到fk模式再做綁定
	# 	Helper.openFKController(ns)
		
	# 	#################################
	# 	####        記錄IK動作        ####
	# 	#################################
	# 	listBakeNode = []
	# 	listFKNode = []
	# 	if self.bSpine:
	# 		# 身體脊椎
	# 		proxyIKSpine1_M = cmds.createNode('transform',name='proxyIKSpine1_M')
	# 		proxyIKSpine2_M = cmds.createNode('transform',name='proxyIKSpine2_M')
	# 		proxyIKSpine1_M = cmds.parent(proxyIKSpine1_M, proxyRoot)[0]
	# 		proxyIKSpine2_M = cmds.parent(proxyIKSpine2_M, proxyRoot)[0]

	# 		# 脊椎的部分使用和其他ik的處理方法一樣，不過出現的結果是不對的。先關起來。
	# 		# cmds.xform(proxyIKSpine1_M, ws=1,m=rotateMatMap["Root_M"])
	# 		# cmds.parentConstraint(ns+'Root_M', proxyIKSpine1_M, mo=True)
	# 		# cmds.xform(proxyIKSpine2_M, ws=1,m=rotateMatMap["Chest_M"])
	# 		# cmds.parentConstraint(ns+'Chest_M', proxyIKSpine2_M, mo=True)

	# 		mtxIKSpine1Loc_M = dt.Matrix([0.0, 0.0, 1.0, 0.0, -0.10111849241851392, -0.994874389302995, 0.0, 0.0, 0.994874389302995, -0.10111849241851392, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0])
	# 		mtxRootBone_M = dt.Matrix(cmds.xform(ns+'Root_M',q=True,ws=True,m=True))
	# 		wMtx = mtxIKSpine1Loc_M * mtxRootBone_M
	# 		cmds.xform(proxyIKSpine1_M, ws=True, m=[wMtx.a00,wMtx.a01,wMtx.a02,wMtx.a03,
	# 												wMtx.a10,wMtx.a11,wMtx.a12,wMtx.a13,
	# 												wMtx.a20,wMtx.a21,wMtx.a22,wMtx.a23,
	# 												wMtx.a30,wMtx.a31,wMtx.a32,wMtx.a33])
	# 		cmds.parentConstraint(ns+'Root_M', proxyIKSpine1_M, mo=True)

	# 		mtxIKSpine2Loc_M = dt.Matrix([0.0, 0.0, 1.0, 0.0, 0.11336786172542011, -0.9935530825918697, 0.0, 0.0, 0.9935530825918697, 0.11336786172542009, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0])
	# 		mtxChestBone_M = dt.Matrix(cmds.xform(ns+'Chest_M',q=True,ws=True,m=True))
	# 		wMtx = mtxIKSpine2Loc_M * mtxChestBone_M
	# 		cmds.xform(proxyIKSpine2_M, ws=True, m=[wMtx.a00,wMtx.a01,wMtx.a02,wMtx.a03,
	# 												wMtx.a10,wMtx.a11,wMtx.a12,wMtx.a13,
	# 												wMtx.a20,wMtx.a21,wMtx.a22,wMtx.a23,
	# 												wMtx.a30,wMtx.a31,wMtx.a32,wMtx.a33])
	# 		cmds.parentConstraint(ns+'Chest_M', proxyIKSpine2_M, mo=True)
			
	# 		listBakeNode += [proxyIKSpine1_M, proxyIKSpine2_M]
	# 		listFKNode += [None, None]

	# 	if self.bRightArm:
	# 		# 右臂
	# 		proxyFKShoulder_R = cmds.createNode('transform',name='proxyFKShoulder_R')
	# 		proxyElbowPush_R = cmds.createNode('transform',name='proxyElbowPush_R')
	# 		proxyPoleUp_R = cmds.createNode('transform',name='proxyPoleArm_R')
	# 		proxyHand_R = cmds.createNode('transform',name='proxyIKArm_R')
	# 		proxyFKShoulder_R = cmds.parent(proxyFKShoulder_R, proxyRoot)[0]
	# 		proxyElbowPush_R = cmds.parent(proxyElbowPush_R, proxyRoot)[0]
	# 		proxyHand_R = cmds.parent(proxyHand_R, proxyRoot)[0]
			
	# 		cmds.pointConstraint(ns+'Shoulder_R', ns+'Wrist_R', proxyFKShoulder_R)

	# 		# 記得這是照成手肘偏離的原因，先留著要查看時可以看
	# 		# mtxElbow = dt.Matrix(cmds.xform(ns+'Elbow_R',q=True,ws=True,m=True))
	# 		# ElbowPos = dt.Vector(mtxElbow.data[3][0:3]) + dt.Vector(mtxElbow.data[1][0:3])*-2
	# 		# cmds.xform(proxyElbowPush_R, ws=True, t=ElbowPos)
	# 		# cmds.parentConstraint(ns+'Elbow_R', proxyElbowPush_R, mo=True)
	# 		cmds.parentConstraint(ns+'Elbow_R', proxyElbowPush_R)

	# 		cmds.aimConstraint(ns+'Shoulder_R', proxyFKShoulder_R, aim=[1,0,0], u=[0,1,0], wut="object", wuo=proxyElbowPush_R)
	# 		cmds.parent(proxyPoleUp_R, proxyFKShoulder_R)
	# 		cmds.xform(proxyPoleUp_R, ws=False, t=[0, 50, 0])

	# 		cmds.xform(proxyHand_R, ws=1,m=rotateMatMap["Wrist_R"])
	# 		cmds.parentConstraint(ns+'Wrist_R', proxyHand_R, mo=True)
			
	# 		listBakeNode += [proxyHand_R, proxyPoleUp_R]
	# 		listFKNode += ["FKWrist_R", None]

	# 	if self.bLeftArm:
	# 		# 左臂
	# 		proxyFKShoulder_L = cmds.createNode('transform',name='proxyFKShoulder_L')
	# 		proxyElbowPush_L = cmds.createNode('transform',name='proxyElbowPush_L')
	# 		proxyPoleUp_L = cmds.createNode('transform',name='proxyPoleArm_L')
	# 		proxyHand_L = cmds.createNode('transform',name='proxyIKArm_L')
	# 		proxyFKShoulder_L = cmds.parent(proxyFKShoulder_L, proxyRoot)[0]
	# 		proxyElbowPush_L = cmds.parent(proxyElbowPush_L, proxyRoot)[0]
	# 		proxyHand_L = cmds.parent(proxyHand_L, proxyRoot)[0]
			
	# 		cmds.pointConstraint(ns+'Shoulder_L', ns+'Wrist_L', proxyFKShoulder_L)

	# 		# 記得這是照成手肘偏離的原因，先留著要查看時可以看
	# 		# mtxElbow = dt.Matrix(cmds.xform(ns+'Elbow_L',q=True,ws=True,m=True))
	# 		# ElbowPos = dt.Vector(mtxElbow.data[3][0:3]) + dt.Vector(mtxElbow.data[1][0:3])*2
	# 		# cmds.xform(proxyElbowPush_L, ws=True, t=ElbowPos)
	# 		# cmds.parentConstraint(ns+'Elbow_L', proxyElbowPush_L, mo=True)
	# 		cmds.parentConstraint(ns+'Elbow_L', proxyElbowPush_L)

	# 		cmds.aimConstraint(ns+'Shoulder_L', proxyFKShoulder_L, aim=[1,0,0], u=[0,1,0], wut="object", wuo=proxyElbowPush_L)
	# 		cmds.parent(proxyPoleUp_L, proxyFKShoulder_L)
	# 		cmds.xform(proxyPoleUp_L, ws=False, t=[0, 50, 0])

	# 		cmds.xform(proxyHand_L, ws=1,m=rotateMatMap["Wrist_L"])
	# 		cmds.parentConstraint(ns+'Wrist_L', proxyHand_L, mo=True)
			
	# 		listBakeNode += [proxyHand_L, proxyPoleUp_L]
	# 		listFKNode += ["FKWrist_L", None]

	# 	if self.bRightLeg:
	# 		# 右腿
	# 		proxyLegCenter_R = cmds.createNode('transform',name='proxyLegCenter_R')
	# 		proxyKneePush_R = cmds.createNode('transform',name='proxyKneePush_R')
	# 		proxyLegPoleUp_R = cmds.createNode('transform',name='proxyLegPoleUp_R')
	# 		proxyFoot_R = cmds.createNode('transform',name='proxyIKLeg_R')
	# 		proxyToes_R = cmds.createNode('transform',name='proxyFKToes_R')
	# 		proxyLegCenter_R = cmds.parent(proxyLegCenter_R, proxyRoot)[0]
	# 		proxyKneePush_R = cmds.parent(proxyKneePush_R, proxyRoot)[0]
	# 		proxyFoot_R = cmds.parent(proxyFoot_R, proxyRoot)[0]
	# 		proxyToes_R = cmds.parent(proxyToes_R, proxyRoot)[0]
			
	# 		cmds.pointConstraint(ns+'Hip_R', ns+'Ankle_R', proxyLegCenter_R)
	# 		mtxKnee_R = dt.Matrix(cmds.xform(ns+'Knee_R',q=True,ws=True,m=True))
	# 		KneePos_R = dt.Vector(mtxKnee_R.data[3][0:3]) + dt.Vector(mtxKnee_R.data[1][0:3])*2
	# 		cmds.xform(proxyKneePush_R, ws=True, t=KneePos_R)
	# 		cmds.parentConstraint(ns+'Knee_R', proxyKneePush_R, mo=True)

	# 		cmds.aimConstraint(ns+'Hip_R', proxyLegCenter_R, aim=[1,0,0], u=[0,1,0], wut="object", wuo=proxyKneePush_R)
	# 		cmds.parent(proxyLegPoleUp_R, proxyLegCenter_R)
	# 		cmds.xform(proxyLegPoleUp_R, ws=False, t=[0, 90, 0])

	# 		strategy["doFootR"](ns, [proxyFoot_R, proxyToes_R], rotateMatMap)
			
	# 		listBakeNode += [proxyFoot_R, proxyLegPoleUp_R,  proxyToes_R]
	# 		listFKNode += strategy["getFootRFK"]()

	# 	if self.bLeftLeg:
	# 		# 左腿
	# 		proxyLegCenter_L = cmds.createNode('transform',name='proxyLegCenter_L')
	# 		proxyKneePush_L = cmds.createNode('transform',name='proxyKneePush_L')
	# 		proxyLegPoleUp_L = cmds.createNode('transform',name='proxyLegPoleUp_L')
	# 		proxyFoot_L = cmds.createNode('transform',name='proxyIKLeg_L')
	# 		proxyToes_L = cmds.createNode('transform',name='proxyFKToes_L')
	# 		proxyLegCenter_L = cmds.parent(proxyLegCenter_L, proxyRoot)[0]
	# 		proxyKneePush_L = cmds.parent(proxyKneePush_L, proxyRoot)[0]
	# 		proxyFoot_L = cmds.parent(proxyFoot_L, proxyRoot)[0]
	# 		proxyToes_L = cmds.parent(proxyToes_L, proxyRoot)[0]
			
	# 		cmds.pointConstraint(ns+'Hip_L', ns+'Ankle_L', proxyLegCenter_L)
	# 		mtxKnee_L = dt.Matrix(cmds.xform(ns+'Knee_L',q=True,ws=True,m=True))
	# 		KneePos_L = dt.Vector(mtxKnee_L.data[3][0:3]) + dt.Vector(mtxKnee_L.data[1][0:3])*-2
	# 		cmds.xform(proxyKneePush_L, ws=True, t=KneePos_L)
	# 		cmds.parentConstraint(ns+'Knee_L', proxyKneePush_L, mo=True)

	# 		cmds.aimConstraint(ns+'Hip_L', proxyLegCenter_L, aim=[1,0,0], u=[0,1,0], wut="object", wuo=proxyKneePush_L)
	# 		cmds.parent(proxyLegPoleUp_L, proxyLegCenter_L)
	# 		cmds.xform(proxyLegPoleUp_L, ws=False, t=[0, 90, 0])

	# 		strategy["doFootL"](ns, [proxyFoot_L, proxyToes_L], rotateMatMap)
			
	# 		listBakeNode += [proxyFoot_L, proxyLegPoleUp_L,  proxyToes_L]
	# 		listFKNode += strategy["getFootLFK"]()

	# 	def bakeToRealCtrl(listBakeNode, listFKNode, rigType):
	# 		for proxyNode, fkNode in zip(listBakeNode, listFKNode):
	# 			realctrl = ns + ":" + proxyNode[5:]
	# 			if cmds.objExists(realctrl):
	# 				Helper.attach(proxyNode, realctrl)
	# 				cmds.setKeyframe(realctrl + ".translate")
	# 				cmds.setKeyframe(realctrl + ".rotate")

	# 				# 如果是閃電腿的類型，要轉脚踝的controller
	# 				if rigType == "shandian":
	# 					if self.bLeftLeg:
	# 						Helper.fixRollToeJoint( ns, "Toes2_L", "Toes1_L", "RollToes2_L" )
	# 						Helper.fixRollToeJoint( ns, "Toes1_L", "Ankle_L", "RollToes1_L" )
	# 						cmds.setKeyframe(ns+":RollToes1_L" + ".translate")
	# 						cmds.setKeyframe(ns+":RollToes1_L" + ".rotate")
							
	# 					if self.bRightLeg:
	# 						Helper.fixRollToeJoint( ns, "Toes2_R", "Toes1_R", "RollToes2_R" )
	# 						Helper.fixRollToeJoint( ns, "Toes1_R", "Ankle_R", "RollToes1_R" )
	# 						cmds.setKeyframe(ns+":RollToes2_L" + ".translate")
	# 						cmds.setKeyframe(ns+":RollToes2_L" + ".rotate")
		
	# 	rigType = Helper.checkRigType(self.ns)
	# 	if animation:
	# 		startFrame = self.spnStartFrame.value()
	# 		endFrame = self.spnEndFrame.value()

	# 		for f in range(startFrame, endFrame+1):
	# 			cmds.currentTime(f)
	# 			bakeToRealCtrl(listBakeNode, listFKNode, rigType)
	# 		cmds.currentTime(self.spnStartFrame.value())

	# 		# 先切換囘執行功能前的ikfk模式(因爲做計算時會去改變他)
	# 		Helper.setIKFKBlend(ns, fkiksets)

	# 		# 再根據使用者的設定調整ikfk模式
	# 		self.checkAndSetBlendAnimation(ns, startFrame, endFrame, 10)
	# 	else:
	# 		bakeToRealCtrl(listBakeNode, listFKNode, rigType)
			
	# 		# 先切換囘執行功能前的ikfk模式(因爲做計算時會去改變他)
	# 		Helper.setIKFKBlend(ns, fkiksets)

	# 		# 再根據使用者的設定調整ikfk模式
	# 		self.checkAndSetBlend(ns, 10)
	# 		pass
	# 	cmds.delete(proxyRoot)

	# def ConvertToFK_SingleFrame(self, strategy, animation=False):
	# 	ns = self.ns

	# 	#################################
	# 	#### 建立Proxy抓取骨架最終資訊 ####
	# 	#################################
	# 	proxyRoot = cmds.createNode('transform',name='proxyRoot')

	# 	#################################
	# 	####        記錄FK動作        ####
	# 	#################################
	# 	listBakeNode = []
	# 	listFKNode = []
	# 	if self.bSpine:
	# 		# 身體脊椎
	# 		proxyFKRoot_M = cmds.createNode('transform',name='proxyFKRoot_M')
	# 		proxyFKSpine1_M = cmds.createNode('transform',name='proxyFKSpine1_M')
	# 		proxyFKChest_M = cmds.createNode('transform',name='proxyFKChest_M')
	# 		proxyFKRoot_M = cmds.parent(proxyFKRoot_M, proxyRoot)[0]
	# 		proxyFKSpine1_M = cmds.parent(proxyFKSpine1_M, proxyRoot)[0]
	# 		proxyFKChest_M = cmds.parent(proxyFKChest_M, proxyRoot)[0]

	# 		cmds.parentConstraint(ns+'Root_M', proxyFKRoot_M, mo=False)
	# 		cmds.parentConstraint(ns+'Spine1_M', proxyFKSpine1_M, mo=False)
	# 		cmds.parentConstraint(ns+'Chest_M', proxyFKChest_M, mo=False)

	# 		listBakeNode += [proxyFKRoot_M, proxyFKSpine1_M, proxyFKChest_M]
	# 		listFKNode += [None, None, None]
	# 	if self.bRightArm:
	# 		# 右臂
	# 		proxyFKShoulder_R = cmds.createNode('transform',name='proxyFKShoulder_R')
	# 		proxyFKElbow_R = cmds.createNode('transform',name='proxyFKElbow_R')
	# 		proxyFKWrist_R = cmds.createNode('transform',name='proxyFKWrist_R')
	# 		proxyFKShoulder_R = cmds.parent(proxyFKShoulder_R, proxyRoot)[0]
	# 		proxyFKElbow_R = cmds.parent(proxyFKElbow_R, proxyRoot)[0]
	# 		proxyFKWrist_R = cmds.parent(proxyFKWrist_R, proxyRoot)[0]

	# 		cmds.pointConstraint(ns+'Shoulder_R', proxyFKShoulder_R, mo=False)
	# 		cmds.aimConstraint(ns+'Elbow_R', proxyFKShoulder_R, aim=[1,0,0], u=[0,0,1], wut="objectrotation", wuo=(ns+'Elbow_R'), wu=[0,0,1])

	# 		cmds.parentConstraint(ns+'Elbow_R', proxyFKElbow_R, mo=False)
	# 		cmds.parentConstraint(ns+'Wrist_R', proxyFKWrist_R, mo=False)
			
	# 		listBakeNode += [proxyFKShoulder_R, proxyFKElbow_R, proxyFKWrist_R]
	# 		listFKNode += ["FKShoulder_R","FKElbow_R","FKWrist_R"]
	# 	if self.bLeftArm:
	# 		# 左臂
	# 		proxyFKShoulder_L = cmds.createNode('transform',name='proxyFKShoulder_L')
	# 		proxyFKElbow_L = cmds.createNode('transform',name='proxyFKElbow_L')
	# 		proxyFKWrist_L = cmds.createNode('transform',name='proxyFKWrist_L')
	# 		proxyFKShoulder_L = cmds.parent(proxyFKShoulder_L, proxyRoot)[0]
	# 		proxyFKElbow_L = cmds.parent(proxyFKElbow_L, proxyRoot)[0]
	# 		proxyFKWrist_L = cmds.parent(proxyFKWrist_L, proxyRoot)[0]

	# 		cmds.pointConstraint(ns+'Shoulder_L', proxyFKShoulder_L, mo=False)
	# 		cmds.aimConstraint(ns+'Elbow_L', proxyFKShoulder_L, aim=[-1,0,0], u=[0,0,1], wut="objectrotation", wuo=(ns+'Elbow_L'), wu=[0,0,1])

	# 		cmds.parentConstraint(ns+'Elbow_L', proxyFKElbow_L, mo=False)
	# 		cmds.parentConstraint(ns+'Wrist_L', proxyFKWrist_L, mo=False)
			
	# 		listBakeNode += [proxyFKShoulder_L, proxyFKElbow_L, proxyFKWrist_L]
	# 		listFKNode += ["FKShoulder_L","FKElbow_L","FKWrist_L"]

	# 	if self.bRightLeg:
	# 		# 右腿
	# 		proxyFKHip_R = cmds.createNode('transform',name='proxyFKHip_R')
	# 		proxyFKKnee_R = cmds.createNode('transform',name='proxyFKKnee_R')
	# 		proxyFKAnkle_R = cmds.createNode('transform',name='proxyFKAnkle_R')
	# 		proxyFKToes_R = cmds.createNode('transform',name='proxyFKToes_R')
	# 		proxyFKToes1_R = cmds.createNode('transform',name='proxyFKToes1_R')
	# 		proxyFKToes2_R = cmds.createNode('transform',name='proxyFKToes2_R')
	# 		proxyFKHip_R = cmds.parent(proxyFKHip_R, proxyRoot)[0]
	# 		proxyFKKnee_R = cmds.parent(proxyFKKnee_R, proxyRoot)[0]
	# 		proxyFKAnkle_R = cmds.parent(proxyFKAnkle_R, proxyRoot)[0]
	# 		proxyFKToes_R = cmds.parent(proxyFKToes_R, proxyRoot)[0]
	# 		proxyFKToes1_R = cmds.parent(proxyFKToes1_R, proxyRoot)[0]
	# 		proxyFKToes2_R = cmds.parent(proxyFKToes2_R, proxyRoot)[0]

	# 		strategy["doFootR"](ns, [proxyFKAnkle_R, proxyFKToes_R, proxyFKToes1_R, proxyFKToes2_R, proxyFKHip_R, proxyFKKnee_R])
			
	# 		listBakeNode += [proxyFKHip_R,proxyFKKnee_R,proxyFKAnkle_R,proxyFKToes_R, proxyFKToes1_R, proxyFKToes2_R]
	# 		listFKNode += strategy["getFootRFK"]()

	# 	if self.bLeftLeg:
	# 		# 左腿
	# 		proxyFKHip_L = cmds.createNode('transform',name='proxyFKHip_L')
	# 		proxyFKKnee_L = cmds.createNode('transform',name='proxyFKKnee_L')
	# 		proxyFKAnkle_L = cmds.createNode('transform',name='proxyFKAnkle_L')
	# 		proxyFKToes_L = cmds.createNode('transform',name='proxyFKToes_L')
	# 		proxyFKToes1_L = cmds.createNode('transform',name='proxyFKToes1_L')
	# 		proxyFKToes2_L = cmds.createNode('transform',name='proxyFKToes2_L')
	# 		proxyFKHip_L = cmds.parent(proxyFKHip_L, proxyRoot)[0]
	# 		proxyFKKnee_L = cmds.parent(proxyFKKnee_L, proxyRoot)[0]
	# 		proxyFKAnkle_L = cmds.parent(proxyFKAnkle_L, proxyRoot)[0]
	# 		proxyFKToes_L = cmds.parent(proxyFKToes_L, proxyRoot)[0]
	# 		proxyFKToes1_L = cmds.parent(proxyFKToes1_L, proxyRoot)[0]
	# 		proxyFKToes2_L = cmds.parent(proxyFKToes2_L, proxyRoot)[0]

	# 		strategy["doFootL"](ns, [proxyFKAnkle_L, proxyFKToes_L, proxyFKToes1_L, proxyFKToes2_L, proxyFKHip_L, proxyFKKnee_L])
			
	# 		listBakeNode += [proxyFKHip_L,proxyFKKnee_L,proxyFKAnkle_L,proxyFKToes_L, proxyFKToes1_L, proxyFKToes2_L]
	# 		listFKNode += strategy["getFootLFK"]()

	# 	def bakeToRealCtrl(listBakeNode, listFKNode):
	# 		for proxyNode, fkNode in zip(listBakeNode, listFKNode):
	# 			if fkNode:
	# 				realctrl = ns + ":" + fkNode
	# 				if cmds.objExists(realctrl):
	# 					Helper.attach(proxyNode, realctrl)
	# 					# cmds.setKeyframe(realctrl + ".translate")
	# 					cmds.setKeyframe(realctrl + ".rotate")

	# 	if animation:
	# 		startFrame = self.spnStartFrame.value()
	# 		endFrame = self.spnEndFrame.value()

	# 		for f in range(startFrame, endFrame+1):
	# 			cmds.currentTime(f)
	# 			bakeToRealCtrl(listBakeNode, listFKNode)
	# 		cmds.currentTime(self.spnStartFrame.value())

	# 		self.checkAndSetBlendAnimation(ns, startFrame, endFrame, 0)
	# 	else:
	# 		bakeToRealCtrl(listBakeNode, listFKNode)

	# 		self.checkAndSetBlend(ns, 0)

	# 	cmds.delete(proxyRoot)

	# def ConvertToIK_TimeRange(self, startFrame, endFrame):
	# 	ns = self.ns
	# 	timePrefix = startFrame
	# 	framesCount = endFrame - startFrame + 1

	# 	cmds.currentTime(startFrame)

	# 	#################################
	# 	#### 建立Proxy抓取骨架最終資訊 ####
	# 	#################################
	# 	proxyRoot = cmds.createNode('transform',name='proxyRoot')

	# 	# 右臂
	# 	proxyFKShoulder_R = cmds.createNode('transform',name='proxyFKShoulder_R')
	# 	proxyElbowPush_R = cmds.createNode('transform',name='proxyElbowPush_R')
	# 	proxyPoleUp_R = cmds.createNode('transform',name='proxyPoleArm_R')
	# 	proxyHand_R = cmds.createNode('transform',name='proxyIKArm_R')
	# 	proxyFKShoulder_R = cmds.parent(proxyFKShoulder_R, proxyRoot)[0]
	# 	proxyElbowPush_R = cmds.parent(proxyElbowPush_R, proxyRoot)[0]
	# 	proxyHand_R = cmds.parent(proxyHand_R, proxyRoot)[0]
		
	# 	cmds.pointConstraint(ns+'Shoulder_R', ns+'Wrist_R', proxyFKShoulder_R)
	# 	# mtxElbow = dt.Matrix(cmds.xform(ns+'Elbow_R',q=True,ws=True,m=True))
	# 	# ElbowPos = dt.Vector(mtxElbow.data[3][0:3]) + dt.Vector(mtxElbow.data[1][0:3])*-2
	# 	# cmds.xform(proxyElbowPush_R, ws=True, t=ElbowPos)
	# 	# cmds.parentConstraint(ns+'Elbow_R', proxyElbowPush_R, mo=True)
	# 	cmds.parentConstraint(ns+'Elbow_R', proxyElbowPush_R)

	# 	cmds.aimConstraint(ns+'Shoulder_R', proxyFKShoulder_R, aim=[1,0,0], u=[0,1,0], wut="object", wuo=proxyElbowPush_R)
	# 	cmds.parent(proxyPoleUp_R, proxyFKShoulder_R)
	# 	cmds.xform(proxyPoleUp_R, ws=False, t=[0, 50, 0])

	# 	mtxIKArmLoc_R = dt.Matrix([ 0.0, 0.0,-1.0, 0.0, 0.0,-1.0, 0.0, 0.0,-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0])
	# 	mtxHandBone_R = dt.Matrix(cmds.xform(ns+'Wrist_R',q=True,ws=True,m=True))
	# 	wMtx = mtxIKArmLoc_R * mtxHandBone_R
	# 	cmds.xform(proxyHand_R, ws=True, m=[wMtx.a00,wMtx.a01,wMtx.a02,wMtx.a03,
	# 										wMtx.a10,wMtx.a11,wMtx.a12,wMtx.a13,
	# 										wMtx.a20,wMtx.a21,wMtx.a22,wMtx.a23,
	# 										wMtx.a30,wMtx.a31,wMtx.a32,wMtx.a33])
	# 	cmds.parentConstraint(ns+'Wrist_R', proxyHand_R, mo=True)

	# 	# 左臂
	# 	proxyFKShoulder_L = cmds.createNode('transform',name='proxyFKShoulder_L')
	# 	proxyElbowPush_L = cmds.createNode('transform',name='proxyElbowPush_L')
	# 	proxyPoleUp_L = cmds.createNode('transform',name='proxyPoleArm_L')
	# 	proxyHand_L = cmds.createNode('transform',name='proxyIKArm_L')
	# 	proxyFKShoulder_L = cmds.parent(proxyFKShoulder_L, proxyRoot)[0]
	# 	proxyElbowPush_L = cmds.parent(proxyElbowPush_L, proxyRoot)[0]
	# 	proxyHand_L = cmds.parent(proxyHand_L, proxyRoot)[0]
		
	# 	cmds.pointConstraint(ns+'Shoulder_L', ns+'Wrist_L', proxyFKShoulder_L)
	# 	# mtxElbow = dt.Matrix(cmds.xform(ns+'Elbow_L',q=True,ws=True,m=True))
	# 	# ElbowPos = dt.Vector(mtxElbow.data[3][0:3]) + dt.Vector(mtxElbow.data[1][0:3])*2
	# 	# cmds.xform(proxyElbowPush_L, ws=True, t=ElbowPos)
	# 	# cmds.parentConstraint(ns+'Elbow_L', proxyElbowPush_L, mo=True)
	# 	cmds.parentConstraint(ns+'Elbow_L', proxyElbowPush_L)

	# 	cmds.aimConstraint(ns+'Shoulder_L', proxyFKShoulder_L, aim=[1,0,0], u=[0,1,0], wut="object", wuo=proxyElbowPush_L)
	# 	cmds.parent(proxyPoleUp_L, proxyFKShoulder_L)
	# 	cmds.xform(proxyPoleUp_L, ws=False, t=[0, 50, 0])

	# 	mtxIKArmLoc_L = dt.Matrix([ 0.0, 0.0,-1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0])
	# 	mtxHandBone_L = dt.Matrix(cmds.xform(ns+'Wrist_L',q=True,ws=True,m=True))
	# 	wMtx = mtxIKArmLoc_L * mtxHandBone_L
	# 	cmds.xform(proxyHand_L, ws=True, m=[wMtx.a00,wMtx.a01,wMtx.a02,wMtx.a03,
	# 										wMtx.a10,wMtx.a11,wMtx.a12,wMtx.a13,
	# 										wMtx.a20,wMtx.a21,wMtx.a22,wMtx.a23,
	# 										wMtx.a30,wMtx.a31,wMtx.a32,wMtx.a33])
	# 	cmds.parentConstraint(ns+'Wrist_L', proxyHand_L, mo=True)

	# 	# 右腿
	# 	proxyLegCenter_R = cmds.createNode('transform',name='proxyLegCenter_R')
	# 	proxyKneePush_R = cmds.createNode('transform',name='proxyKneePush_R')
	# 	proxyLegPoleUp_R = cmds.createNode('transform',name='proxyLegPoleUp_R')
	# 	proxyFoot_R = cmds.createNode('transform',name='proxyIKLeg_R')
	# 	proxyToes_R = cmds.createNode('transform',name='proxyFKToes_R')
	# 	proxyLegCenter_R = cmds.parent(proxyLegCenter_R, proxyRoot)[0]
	# 	proxyKneePush_R = cmds.parent(proxyKneePush_R, proxyRoot)[0]
	# 	proxyFoot_R = cmds.parent(proxyFoot_R, proxyRoot)[0]
	# 	proxyToes_R = cmds.parent(proxyToes_R, proxyRoot)[0]
		
	# 	cmds.pointConstraint(ns+'Hip_R', ns+'Ankle_R', proxyLegCenter_R)
	# 	mtxKnee_R = dt.Matrix(cmds.xform(ns+'Knee_R',q=True,ws=True,m=True))
	# 	KneePos_R = dt.Vector(mtxKnee_R.data[3][0:3]) + dt.Vector(mtxKnee_R.data[1][0:3])*2
	# 	cmds.xform(proxyKneePush_R, ws=True, t=KneePos_R)
	# 	cmds.parentConstraint(ns+'Knee_R', proxyKneePush_R, mo=True)

	# 	cmds.aimConstraint(ns+'Hip_R', proxyLegCenter_R, aim=[1,0,0], u=[0,1,0], wut="object", wuo=proxyKneePush_R)
	# 	cmds.parent(proxyLegPoleUp_R, proxyLegCenter_R)
	# 	cmds.xform(proxyLegPoleUp_R, ws=False, t=[0, 90, 0])

	# 	mtxIKFootLoc_R = dt.Matrix([-0.021264729326675225, 0.0, -0.9997738800782221, 0.0, 0.0, -1.0, 0.0, 0.0, -0.9997738800782221, 0.0, 0.021264729326675225, 0.0, 0.0, 0.0, 0.0, 1.0])
	# 	mtxFootBone_R = dt.Matrix(cmds.xform(ns+'Ankle_R',q=True,ws=True,m=True))
	# 	wMtx = mtxIKFootLoc_R * mtxFootBone_R
	# 	cmds.xform(proxyFoot_R, ws=True, m=[wMtx.a00,wMtx.a01,wMtx.a02,wMtx.a03,
	# 										wMtx.a10,wMtx.a11,wMtx.a12,wMtx.a13,
	# 										wMtx.a20,wMtx.a21,wMtx.a22,wMtx.a23,
	# 										wMtx.a30,wMtx.a31,wMtx.a32,wMtx.a33])
	# 	cmds.parentConstraint(ns+'Ankle_R', proxyFoot_R, mo=True)
	# 	cmds.parentConstraint(ns+'Toes2_R', proxyToes_R, mo=False)
	# 	# cmds.parentConstraint(ns+'Toes_R', proxyToes_R, mo=False)

	# 	# 左腿
	# 	proxyLegCenter_L = cmds.createNode('transform',name='proxyLegCenter_L')
	# 	proxyKneePush_L = cmds.createNode('transform',name='proxyKneePush_L')
	# 	proxyLegPoleUp_L = cmds.createNode('transform',name='proxyLegPoleUp_L')
	# 	proxyFoot_L = cmds.createNode('transform',name='proxyIKLeg_L')
	# 	proxyToes_L = cmds.createNode('transform',name='proxyFKToes_L')
	# 	proxyLegCenter_L = cmds.parent(proxyLegCenter_L, proxyRoot)[0]
	# 	proxyKneePush_L = cmds.parent(proxyKneePush_L, proxyRoot)[0]
	# 	proxyFoot_L = cmds.parent(proxyFoot_L, proxyRoot)[0]
	# 	proxyToes_L = cmds.parent(proxyToes_L, proxyRoot)[0]
		
	# 	cmds.pointConstraint(ns+'Hip_L', ns+'Ankle_L', proxyLegCenter_L)
	# 	mtxKnee_L = dt.Matrix(cmds.xform(ns+'Knee_L',q=True,ws=True,m=True))
	# 	KneePos_L = dt.Vector(mtxKnee_L.data[3][0:3]) + dt.Vector(mtxKnee_L.data[1][0:3])*-2
	# 	cmds.xform(proxyKneePush_L, ws=True, t=KneePos_L)
	# 	cmds.parentConstraint(ns+'Knee_L', proxyKneePush_L, mo=True)

	# 	cmds.aimConstraint(ns+'Hip_L', proxyLegCenter_L, aim=[1,0,0], u=[0,1,0], wut="object", wuo=proxyKneePush_L)
	# 	cmds.parent(proxyLegPoleUp_L, proxyLegCenter_L)
	# 	cmds.xform(proxyLegPoleUp_L, ws=False, t=[0, 90, 0])

	# 	mtxIKFootLoc_L = dt.Matrix([-0.021264729326677, 0.0, -0.9997738800782221, 0.0, 0.0, 1.0, 0.0, 0.0, 0.9997738800782223, 0.0, -0.021264729326677004, 0.0, 0.0, 0.0, 0.0, 1.0])
	# 	mtxFootBone_L = dt.Matrix(cmds.xform(ns+'Ankle_L',q=True,ws=True,m=True))
	# 	wMtx = mtxIKFootLoc_L * mtxFootBone_L
	# 	cmds.xform(proxyFoot_L, ws=True, m=[wMtx.a00,wMtx.a01,wMtx.a02,wMtx.a03,
	# 										wMtx.a10,wMtx.a11,wMtx.a12,wMtx.a13,
	# 										wMtx.a20,wMtx.a21,wMtx.a22,wMtx.a23,
	# 										wMtx.a30,wMtx.a31,wMtx.a32,wMtx.a33])
	# 	cmds.parentConstraint(ns+'Ankle_L', proxyFoot_L, mo=True)
	# 	cmds.parentConstraint(ns+'Toes2_L', proxyToes_L, mo=False)
	# 	# cmds.parentConstraint(ns+'Toes_L', proxyToes_L, mo=False)

	# 	# 身體脊椎
	# 	proxyIKSpine1_M = cmds.createNode('transform',name='proxyIKSpine1_M')
	# 	proxyIKSpine2_M = cmds.createNode('transform',name='proxyIKSpine2_M')
	# 	proxyIKSpine1_M = cmds.parent(proxyIKSpine1_M, proxyRoot)[0]
	# 	proxyIKSpine2_M = cmds.parent(proxyIKSpine2_M, proxyRoot)[0]

	# 	mtxIKSpine1Loc_M = dt.Matrix([0.0, 0.0, 1.0, 0.0, -0.10111849241851392, -0.994874389302995, 0.0, 0.0, 0.994874389302995, -0.10111849241851392, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0])
	# 	mtxRootBone_M = dt.Matrix(cmds.xform(ns+'Root_M',q=True,ws=True,m=True))
	# 	wMtx = mtxIKSpine1Loc_M * mtxRootBone_M
	# 	cmds.xform(proxyIKSpine1_M, ws=True, m=[wMtx.a00,wMtx.a01,wMtx.a02,wMtx.a03,
	# 											wMtx.a10,wMtx.a11,wMtx.a12,wMtx.a13,
	# 											wMtx.a20,wMtx.a21,wMtx.a22,wMtx.a23,
	# 											wMtx.a30,wMtx.a31,wMtx.a32,wMtx.a33])
	# 	cmds.parentConstraint(ns+'Root_M', proxyIKSpine1_M, mo=True)

	# 	mtxIKSpine2Loc_M = dt.Matrix([0.0, 0.0, 1.0, 0.0, 0.11336786172542011, -0.9935530825918697, 0.0, 0.0, 0.9935530825918697, 0.11336786172542009, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0])
	# 	mtxChestBone_M = dt.Matrix(cmds.xform(ns+'Chest_M',q=True,ws=True,m=True))
	# 	wMtx = mtxIKSpine2Loc_M * mtxChestBone_M
	# 	cmds.xform(proxyIKSpine2_M, ws=True, m=[wMtx.a00,wMtx.a01,wMtx.a02,wMtx.a03,
	# 											wMtx.a10,wMtx.a11,wMtx.a12,wMtx.a13,
	# 											wMtx.a20,wMtx.a21,wMtx.a22,wMtx.a23,
	# 											wMtx.a30,wMtx.a31,wMtx.a32,wMtx.a33])
	# 	cmds.parentConstraint(ns+'Chest_M', proxyIKSpine2_M, mo=True)
		
	# 	#################################
	# 	####        記錄IK動作        ####
	# 	#################################
	# 	listBakeNode = []
	# 	if self.bSpine:
	# 		listBakeNode += [proxyIKSpine1_M, proxyIKSpine2_M]

	# 	if self.bRightArm:
	# 		listBakeNode += [proxyHand_R, proxyPoleUp_R]

	# 	if self.bLeftArm:
	# 		listBakeNode += [proxyHand_L, proxyPoleUp_L]

	# 	if self.bRightLeg:
	# 		listBakeNode += [proxyFoot_R, proxyLegPoleUp_R,  proxyToes_R]

	# 	if self.bLeftLeg:
	# 		listBakeNode += [proxyFoot_L, proxyLegPoleUp_L,  proxyToes_L]

		
	# 	anmData = getAnima(listBakeNode, startFrame, endFrame)

	# 	if self.bSpine:
	# 		vStart = cmds.getAttr(ns+"FKIKSpine_M.FKIKBlend", time=(startFrame - 1))
	# 		vEnd   = cmds.getAttr(ns+"FKIKSpine_M.FKIKBlend", time=(endFrame + 1))
	# 		cmds.setKeyframe(ns+"FKIKSpine_M.FKIKBlend", time=(startFrame - 1), value=vStart, itt='slow', ott='step')
	# 		cmds.setKeyframe(ns+"FKIKSpine_M.FKIKBlend", time=(endFrame + 1), value=vEnd, itt='slow', ott='step')
	# 		cmds.cutKey(ns+"FKIKSpine_M", cl=True, t=(startFrame,endFrame), at=['FKIKBlend'])
	# 		cmds.setKeyframe(ns+"FKIKSpine_M.FKIKBlend", time=startFrame, value=10,itt='slow', ott='step')
	# 		cmds.setKeyframe(ns+"FKIKSpine_M.FKIKBlend", time=endFrame, value=10,itt='slow', ott='step')
	# 		# cmds.setKeyframe('pSphere1.tx', time=18, value=1,itt='slow', ott='step')

	# 	if self.bRightArm:
	# 		vStart = cmds.getAttr(ns+"FKIKArm_R.FKIKBlend", time=(startFrame - 1))
	# 		vEnd   = cmds.getAttr(ns+"FKIKArm_R.FKIKBlend", time=(endFrame + 1))
	# 		cmds.setKeyframe(ns+"FKIKArm_R.FKIKBlend", time=(startFrame - 1), value=vStart, itt='slow', ott='step')
	# 		cmds.setKeyframe(ns+"FKIKArm_R.FKIKBlend", time=(endFrame + 1), value=vEnd, itt='slow', ott='step')
	# 		cmds.cutKey(ns+"FKIKArm_R", cl=True, t=(startFrame,endFrame), at=['FKIKBlend'])
	# 		cmds.setKeyframe(ns+"FKIKArm_R.FKIKBlend", time=startFrame, value=10,itt='slow', ott='step')
	# 		cmds.setKeyframe(ns+"FKIKArm_R.FKIKBlend", time=endFrame, value=10,itt='slow', ott='step')

	# 	if self.bLeftArm:
	# 		vStart = cmds.getAttr(ns+"FKIKArm_L.FKIKBlend", time=(startFrame - 1))
	# 		vEnd   = cmds.getAttr(ns+"FKIKArm_L.FKIKBlend", time=(endFrame + 1))
	# 		cmds.setKeyframe(ns+"FKIKArm_L.FKIKBlend", time=(startFrame - 1), value=vStart, itt='slow', ott='step')
	# 		cmds.setKeyframe(ns+"FKIKArm_L.FKIKBlend", time=(endFrame + 1), value=vEnd, itt='slow', ott='step')
	# 		cmds.cutKey(ns+"FKIKArm_L", cl=True, t=(startFrame,endFrame), at=['FKIKBlend'])
	# 		cmds.setKeyframe(ns+"FKIKArm_L.FKIKBlend", time=startFrame, value=10,itt='slow', ott='step')
	# 		cmds.setKeyframe(ns+"FKIKArm_L.FKIKBlend", time=endFrame, value=10,itt='slow', ott='step')

	# 	if self.bRightLeg:
	# 		vStart = cmds.getAttr(ns+"FKIKLeg_R.FKIKBlend", time=(startFrame - 1))
	# 		vEnd   = cmds.getAttr(ns+"FKIKLeg_R.FKIKBlend", time=(endFrame + 1))
	# 		cmds.setKeyframe(ns+"FKIKLeg_R.FKIKBlend", time=(startFrame - 1), value=vStart, itt='slow', ott='step')
	# 		cmds.setKeyframe(ns+"FKIKLeg_R.FKIKBlend", time=(endFrame + 1), value=vEnd, itt='slow', ott='step')
	# 		cmds.cutKey(ns+"FKIKLeg_R", cl=True, t=(startFrame,endFrame), at=['FKIKBlend'])
	# 		cmds.setKeyframe(ns+"FKIKLeg_R.FKIKBlend", time=startFrame, value=10,itt='slow', ott='step')
	# 		cmds.setKeyframe(ns+"FKIKLeg_R.FKIKBlend", time=endFrame, value=10,itt='slow', ott='step')

	# 		cmds.setKeyframe(ns+"RollHeel_R", at=['translate', 'rotate'], time=(startFrame - 1))
	# 		cmds.setKeyframe(ns+"RollHeel_R", at=['translate', 'rotate'], time=(endFrame + 1))
	# 		# cmds.setKeyframe(ns+"RollToes_R", at=['translate', 'rotate'], time=(startFrame - 1))
	# 		# cmds.setKeyframe(ns+"RollToes_R", at=['translate', 'rotate'], time=(endFrame + 1))
	# 		# cmds.setKeyframe(ns+"RollToesEnd_R", at=['translate', 'rotate'], time=(startFrame - 1))
	# 		# cmds.setKeyframe(ns+"RollToesEnd_R", at=['translate', 'rotate'], time=(endFrame + 1))
	# 		cmds.cutKey(ns+"RollHeel_R", cl=True, t=(startFrame,endFrame), at=['translate', 'rotate'])
	# 		# cmds.cutKey(ns+"RollToes_R", cl=True, t=(startFrame,endFrame), at=['translate', 'rotate'])
	# 		# cmds.cutKey(ns+"RollToesEnd_R", cl=True, t=(startFrame,endFrame), at=['translate', 'rotate'])
	# 		cmds.setKeyframe(ns+"RollHeel_R", at=['tx','ty','tz','rx','rt','rz'], time=startFrame, value=0)
	# 		cmds.setKeyframe(ns+"RollHeel_R", at=['tx','ty','tz','rx','rt','rz'], time=endFrame, value=0)
	# 		# cmds.setKeyframe(ns+"RollToes_R", at=['tx','ty','tz','rx','rt','rz'], time=startFrame, value=0)
	# 		# cmds.setKeyframe(ns+"RollToes_R", at=['tx','ty','tz','rx','rt','rz'], time=endFrame, value=0)
	# 		# cmds.setKeyframe(ns+"RollToesEnd_R", at=['tx','ty','tz','rx','rt','rz'], time=startFrame, value=0)
	# 		# cmds.setKeyframe(ns+"RollToesEnd_R", at=['tx','ty','tz','rx','rt','rz'], time=endFrame, value=0)

	# 	if self.bLeftLeg:
	# 		vStart = cmds.getAttr(ns+"FKIKLeg_L.FKIKBlend", time=(startFrame - 1))
	# 		vEnd   = cmds.getAttr(ns+"FKIKLeg_L.FKIKBlend", time=(endFrame + 1))
	# 		cmds.setKeyframe(ns+"FKIKLeg_L.FKIKBlend", time=(startFrame - 1), value=vStart, itt='slow', ott='step')
	# 		cmds.setKeyframe(ns+"FKIKLeg_L.FKIKBlend", time=(endFrame + 1), value=vEnd, itt='slow', ott='step')
	# 		cmds.cutKey(ns+"FKIKLeg_L", cl=True, t=(startFrame,endFrame), at=['FKIKBlend'])
	# 		cmds.setKeyframe(ns+"FKIKLeg_L.FKIKBlend", time=startFrame, value=10,itt='slow', ott='step')
	# 		cmds.setKeyframe(ns+"FKIKLeg_L.FKIKBlend", time=endFrame, value=10,itt='slow', ott='step')

	# 		cmds.setKeyframe(ns+"RollHeel_L", at=['translate', 'rotate'], time=(startFrame - 1))
	# 		cmds.setKeyframe(ns+"RollHeel_L", at=['translate', 'rotate'], time=(endFrame + 1))
	# 		# cmds.setKeyframe(ns+"RollToes_L", at=['translate', 'rotate'], time=(startFrame - 1))
	# 		# cmds.setKeyframe(ns+"RollToes_L", at=['translate', 'rotate'], time=(endFrame + 1))
	# 		# cmds.setKeyframe(ns+"RollToesEnd_L", at=['translate', 'rotate'], time=(startFrame - 1))
	# 		# cmds.setKeyframe(ns+"RollToesEnd_L", at=['translate', 'rotate'], time=(endFrame + 1))
	# 		cmds.cutKey(ns+"RollHeel_L", cl=True, t=(startFrame,endFrame), at=['translate', 'rotate'])
	# 		# cmds.cutKey(ns+"RollToes_L", cl=True, t=(startFrame,endFrame), at=['translate', 'rotate'])
	# 		# cmds.cutKey(ns+"RollToesEnd_L", cl=True, t=(startFrame,endFrame), at=['translate', 'rotate'])
	# 		cmds.setKeyframe(ns+"RollHeel_L", at=['tx','ty','tz','rx','rt','rz'], time=startFrame, value=0)
	# 		cmds.setKeyframe(ns+"RollHeel_L", at=['tx','ty','tz','rx','rt','rz'], time=endFrame, value=0)
	# 		# cmds.setKeyframe(ns+"RollToes_L", at=['tx','ty','tz','rx','rt','rz'], time=startFrame, value=0)
	# 		# cmds.setKeyframe(ns+"RollToes_L", at=['tx','ty','tz','rx','rt','rz'], time=endFrame, value=0)
	# 		# cmds.setKeyframe(ns+"RollToesEnd_L", at=['tx','ty','tz','rx','rt','rz'], time=startFrame, value=0)
	# 		# cmds.setKeyframe(ns+"RollToesEnd_L", at=['tx','ty','tz','rx','rt','rz'], time=endFrame, value=0)

	# 	importAnima(anmData, startFrame, True, ns)
	# 	#-------------------------
	# 	cmds.delete(proxyRoot)

	# def ConvertToFK_TimeRange(self, startFrame, endFrame):
	# 	ns = self.ns
	# 	timePrefix = startFrame
	# 	framesCount = endFrame - startFrame + 1

	# 	cmds.currentTime(startFrame)

	# 	#################################
	# 	#### 建立Proxy抓取骨架最終資訊 ####
	# 	#################################
	# 	proxyRoot = cmds.createNode('transform',name='proxyRoot')

	# 	# 右臂
	# 	proxyFKShoulder_R = cmds.createNode('transform',name='proxyFKShoulder_R')
	# 	proxyFKElbow_R = cmds.createNode('transform',name='proxyFKElbow_R')
	# 	proxyFKWrist_R = cmds.createNode('transform',name='proxyFKWrist_R')
	# 	proxyFKShoulder_R = cmds.parent(proxyFKShoulder_R, proxyRoot)[0]
	# 	proxyFKElbow_R = cmds.parent(proxyFKElbow_R, proxyRoot)[0]
	# 	proxyFKWrist_R = cmds.parent(proxyFKWrist_R, proxyRoot)[0]

	# 	cmds.pointConstraint(ns+'Shoulder_R', proxyFKShoulder_R, mo=False)
	# 	cmds.aimConstraint(ns+'Elbow_R', proxyFKShoulder_R, aim=[1,0,0], u=[0,0,1], wut="objectrotation", wuo=(ns+'Elbow_R'), wu=[0,0,1])

	# 	cmds.parentConstraint(ns+'Elbow_R', proxyFKElbow_R, mo=False)
	# 	cmds.parentConstraint(ns+'Wrist_R', proxyFKWrist_R, mo=False)

	# 	# 左臂
	# 	proxyFKShoulder_L = cmds.createNode('transform',name='proxyFKShoulder_L')
	# 	proxyFKElbow_L = cmds.createNode('transform',name='proxyFKElbow_L')
	# 	proxyFKWrist_L = cmds.createNode('transform',name='proxyFKWrist_L')
	# 	proxyFKShoulder_L = cmds.parent(proxyFKShoulder_L, proxyRoot)[0]
	# 	proxyFKElbow_L = cmds.parent(proxyFKElbow_L, proxyRoot)[0]
	# 	proxyFKWrist_L = cmds.parent(proxyFKWrist_L, proxyRoot)[0]

	# 	cmds.pointConstraint(ns+'Shoulder_L', proxyFKShoulder_L, mo=False)
	# 	cmds.aimConstraint(ns+'Elbow_L', proxyFKShoulder_L, aim=[-1,0,0], u=[0,0,1], wut="objectrotation", wuo=(ns+'Elbow_L'), wu=[0,0,1])

	# 	cmds.parentConstraint(ns+'Elbow_L', proxyFKElbow_L, mo=False)
	# 	cmds.parentConstraint(ns+'Wrist_L', proxyFKWrist_L, mo=False)

	# 	# 右腿
	# 	proxyFKHip_R = cmds.createNode('transform',name='proxyFKHip_R')
	# 	proxyFKKnee_R = cmds.createNode('transform',name='proxyFKKnee_R')
	# 	proxyFKAnkle_R = cmds.createNode('transform',name='proxyFKAnkle_R')
	# 	proxyFKToes_R = cmds.createNode('transform',name='proxyFKToes_R')
	# 	proxyFKHip_R = cmds.parent(proxyFKHip_R, proxyRoot)[0]
	# 	proxyFKKnee_R = cmds.parent(proxyFKKnee_R, proxyRoot)[0]
	# 	proxyFKAnkle_R = cmds.parent(proxyFKAnkle_R, proxyRoot)[0]
	# 	proxyFKToes_R = cmds.parent(proxyFKToes_R, proxyRoot)[0]

	# 	cmds.pointConstraint(ns+'Hip_R', proxyFKHip_R, mo=False)
	# 	cmds.aimConstraint(ns+'Knee_R', proxyFKHip_R, aim=[1,0,0], u=[0,0,1], wut="objectrotation", wuo=(ns+'Knee_R'), wu=[0,0,1])

	# 	cmds.parentConstraint(ns+'Knee_R', proxyFKKnee_R, mo=False)
	# 	cmds.parentConstraint(ns+'Ankle_R', proxyFKAnkle_R, mo=False)
	# 	# cmds.parentConstraint(ns+'Toes_R', proxyFKToes_R, mo=False)

	# 	# 左腿
	# 	proxyFKHip_L = cmds.createNode('transform',name='proxyFKHip_L')
	# 	proxyFKKnee_L = cmds.createNode('transform',name='proxyFKKnee_L')
	# 	proxyFKAnkle_L = cmds.createNode('transform',name='proxyFKAnkle_L')
	# 	proxyFKToes_L = cmds.createNode('transform',name='proxyFKToes_L')
	# 	proxyFKHip_L = cmds.parent(proxyFKHip_L, proxyRoot)[0]
	# 	proxyFKKnee_L = cmds.parent(proxyFKKnee_L, proxyRoot)[0]
	# 	proxyFKAnkle_L = cmds.parent(proxyFKAnkle_L, proxyRoot)[0]
	# 	proxyFKToes_L = cmds.parent(proxyFKToes_L, proxyRoot)[0]

	# 	cmds.pointConstraint(ns+'Hip_L', proxyFKHip_L, mo=False)
	# 	cmds.aimConstraint(ns+'Knee_L', proxyFKHip_L, aim=[-1,0,0], u=[0,0,1], wut="objectrotation", wuo=(ns+'Knee_L'), wu=[0,0,1])

	# 	cmds.parentConstraint(ns+'Knee_L', proxyFKKnee_L, mo=False)
	# 	cmds.parentConstraint(ns+'Ankle_L', proxyFKAnkle_L, mo=False)
	# 	# cmds.parentConstraint(ns+'Toes_L', proxyFKToes_L, mo=False)

	# 	# 身體脊椎
	# 	proxyFKRoot_M = cmds.createNode('transform',name='proxyFKRoot_M')
	# 	proxyFKSpine1_M = cmds.createNode('transform',name='proxyFKSpine1_M')
	# 	proxyFKChest_M = cmds.createNode('transform',name='proxyFKChest_M')
	# 	proxyFKRoot_M = cmds.parent(proxyFKRoot_M, proxyRoot)[0]
	# 	proxyFKSpine1_M = cmds.parent(proxyFKSpine1_M, proxyRoot)[0]
	# 	proxyFKChest_M = cmds.parent(proxyFKChest_M, proxyRoot)[0]

	# 	cmds.parentConstraint(ns+'Root_M', proxyFKRoot_M, mo=False)
	# 	cmds.parentConstraint(ns+'Spine1_M', proxyFKSpine1_M, mo=False)
	# 	cmds.parentConstraint(ns+'Chest_M', proxyFKChest_M, mo=False)

	# 	#################################
	# 	####        記錄FK動作        ####
	# 	#################################
	# 	listBakeNode = []
	# 	#if self.bSpine:
	# 	#	listBakeNode += [proxyFKRoot_M, proxyFKSpine1_M, proxyFKSpine2_M, proxyFKChest_M]

	# 	if self.bRightArm:
	# 		listBakeNode += [proxyFKShoulder_R, proxyFKElbow_R, proxyFKWrist_R]

	# 	if self.bLeftArm:
	# 		listBakeNode += [proxyFKShoulder_L, proxyFKElbow_L, proxyFKWrist_L]

	# 	if self.bRightLeg:
	# 		listBakeNode += [proxyFKHip_R,proxyFKKnee_R,proxyFKAnkle_R,proxyFKToes_R]

	# 	if self.bLeftLeg:
	# 		listBakeNode += [proxyFKHip_L,proxyFKKnee_L,proxyFKAnkle_L,proxyFKToes_L]

	# 	anmData = getAnima(listBakeNode, startFrame, endFrame)

	# 	if self.bSpine:
	# 		vStart = cmds.getAttr(ns+"FKIKSpine_M.FKIKBlend", time=(startFrame - 1))
	# 		vEnd   = cmds.getAttr(ns+"FKIKSpine_M.FKIKBlend", time=(endFrame + 1))
	# 		cmds.setKeyframe(ns+"FKIKSpine_M.FKIKBlend", time=(startFrame - 1), value=vStart, itt='slow', ott='step')
	# 		cmds.setKeyframe(ns+"FKIKSpine_M.FKIKBlend", time=(endFrame + 1), value=vEnd, itt='slow', ott='step')
	# 		cmds.cutKey(ns+"FKIKSpine_M", cl=True, t=(startFrame,endFrame), at=['FKIKBlend'])
	# 		cmds.setKeyframe(ns+"FKIKSpine_M.FKIKBlend", time=startFrame, value=0,itt='slow', ott='step')
	# 		cmds.setKeyframe(ns+"FKIKSpine_M.FKIKBlend", time=endFrame, value=0,itt='slow', ott='step')

	# 	if self.bRightArm:
	# 		vStart = cmds.getAttr(ns+"FKIKArm_R.FKIKBlend", time=(startFrame - 1))
	# 		vEnd   = cmds.getAttr(ns+"FKIKArm_R.FKIKBlend", time=(endFrame + 1))
	# 		cmds.setKeyframe(ns+"FKIKArm_R.FKIKBlend", time=(startFrame - 1), value=vStart, itt='slow', ott='step')
	# 		cmds.setKeyframe(ns+"FKIKArm_R.FKIKBlend", time=(endFrame + 1), value=vEnd, itt='slow', ott='step')
	# 		cmds.cutKey(ns+"FKIKArm_R", cl=True, t=(startFrame,endFrame), at=['FKIKBlend'])
	# 		cmds.setKeyframe(ns+"FKIKArm_R.FKIKBlend", time=startFrame, value=0,itt='slow', ott='step')
	# 		cmds.setKeyframe(ns+"FKIKArm_R.FKIKBlend", time=endFrame, value=0,itt='slow', ott='step')

	# 	if self.bLeftArm:
	# 		vStart = cmds.getAttr(ns+"FKIKArm_L.FKIKBlend", time=(startFrame - 1))
	# 		vEnd   = cmds.getAttr(ns+"FKIKArm_L.FKIKBlend", time=(endFrame + 1))
	# 		cmds.setKeyframe(ns+"FKIKArm_L.FKIKBlend", time=(startFrame - 1), value=vStart, itt='slow', ott='step')
	# 		cmds.setKeyframe(ns+"FKIKArm_L.FKIKBlend", time=(endFrame + 1), value=vEnd, itt='slow', ott='step')
	# 		cmds.cutKey(ns+"FKIKArm_L", cl=True, t=(startFrame,endFrame), at=['FKIKBlend'])
	# 		cmds.setKeyframe(ns+"FKIKArm_L.FKIKBlend", time=startFrame, value=0,itt='slow', ott='step')
	# 		cmds.setKeyframe(ns+"FKIKArm_L.FKIKBlend", time=endFrame, value=0,itt='slow', ott='step')

	# 	if self.bRightLeg:
	# 		vStart = cmds.getAttr(ns+"FKIKLeg_R.FKIKBlend", time=(startFrame - 1))
	# 		vEnd   = cmds.getAttr(ns+"FKIKLeg_R.FKIKBlend", time=(endFrame + 1))
	# 		cmds.setKeyframe(ns+"FKIKLeg_R.FKIKBlend", time=(startFrame - 1), value=vStart, itt='slow', ott='step')
	# 		cmds.setKeyframe(ns+"FKIKLeg_R.FKIKBlend", time=(endFrame + 1), value=vEnd, itt='slow', ott='step')
	# 		cmds.cutKey(ns+"FKIKLeg_R", cl=True, t=(startFrame,endFrame), at=['FKIKBlend'])
	# 		cmds.setKeyframe(ns+"FKIKLeg_R.FKIKBlend", time=startFrame, value=0,itt='slow', ott='step')
	# 		cmds.setKeyframe(ns+"FKIKLeg_R.FKIKBlend", time=endFrame, value=0,itt='slow', ott='step')

	# 	if self.bLeftLeg:
	# 		vStart = cmds.getAttr(ns+"FKIKLeg_L.FKIKBlend", time=(startFrame - 1))
	# 		vEnd   = cmds.getAttr(ns+"FKIKLeg_L.FKIKBlend", time=(endFrame + 1))
	# 		cmds.setKeyframe(ns+"FKIKLeg_L.FKIKBlend", time=(startFrame - 1), value=vStart, itt='slow', ott='step')
	# 		cmds.setKeyframe(ns+"FKIKLeg_L.FKIKBlend", time=(endFrame + 1), value=vEnd, itt='slow', ott='step')
	# 		cmds.cutKey(ns+"FKIKLeg_L", cl=True, t=(startFrame,endFrame), at=['FKIKBlend'])
	# 		cmds.setKeyframe(ns+"FKIKLeg_L.FKIKBlend", time=startFrame, value=0,itt='slow', ott='step')
	# 		cmds.setKeyframe(ns+"FKIKLeg_L.FKIKBlend", time=endFrame, value=0,itt='slow', ott='step')

	# 	importAnima(anmData, startFrame, False, ns)
	# 	#-------------------------
	# 	cmds.delete(proxyRoot)
	# 	pass
#===================================================================

def createUI():
	IKFK_ui = IKFKConvert()