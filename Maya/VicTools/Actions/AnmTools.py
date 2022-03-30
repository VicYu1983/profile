# -*- coding: utf-8 -*-
import traceback
from collections import OrderedDict

import json
import math
import maya.cmds as cmds

if int(cmds.about(version=True)) >= 2017:
	import PySide2.QtCore as QtCore
	from PySide2.QtGui import *
	from PySide2.QtWidgets import *
	from shiboken2 import wrapInstance
else:
	import PySide.QtCore
	from PySide import QtCore
	from PySide.QtGui import *
	from shiboken import wrapInstance

import maya.OpenMayaUI as omui
import maya.mel as mel
import os
import Helper
reload(Helper)

log = Helper.getLogger('AnmTools')

# import ConfigParser
anmFileType = '.jfa'
poseFileType = '.jfp'


def maya_main_window():
	main_window_ptr = omui.MQtUtil.mainWindow()
	return wrapInstance(long(main_window_ptr), QWidget)
	
def distance(A, B):
	sqX = (A[0] - B[0])*(A[0] - B[0])
	sqY = (A[1] - B[1])*(A[1] - B[1])
	sqZ = (A[2] - B[2])*(A[2] - B[2])
	return math.sqrt(sqX + sqY + sqZ)

def dot(v1, v2):
	return sum(x*y for x,y in zip(v1,v2))

def getFilePathInfo(fullPath):
	DiskPath, fullFileName = os.path.split(fullPath)
	FileName, FileType = os.path.splitext(fullFileName)
	
	if DiskPath[-1] != '/':
		DiskPath += '/'

	return [DiskPath,FileName,FileType]

class AnmTools(QDialog):
	exportPath_edit = QLineEdit("D:/Anm" + anmFileType)
	exportPosePath_edit = QLineEdit("D:/Pose" + anmFileType)
	# mirrorLocThreshold_spb = QDoubleSpinBox()
	
	def __init__(self, parent=maya_main_window()):
		self.closeExistingWindow()
		super(AnmTools, self).__init__(parent)
		self.create()
	
	def closeExistingWindow(self):
		try:
			for qt in maya_main_window().findChildren(QDialog):
				if qt.__class__.__name__ == self.__class__.__name__:
					qt.close()
					qt.deleteLater()
		except:
			pass

	def create(self):
		self.setWindowTitle("Animation Tools")
		self.setWindowFlags(QtCore.Qt.Tool)
		self.setMinimumSize(400,300)

		self.create_controls()
		self.create_layout()
		self.readConfig()
		self.create_connections()
		self.show()

	def readConfig(self):
		## Default Value ##
		# mirrorThreshold = None
		jfaPath = 'D:/Anm' + anmFileType
		jfpPath = 'D:/Pose' + poseFileType

		# if not cmds.optionVar( exists='JF_KAnm_MirrorThreshold' ):
		# 	cmds.optionVar(fv = ('JF_KAnm_MirrorThreshold', 0.05))
		# 	mirrorThreshold = 0.05
		# else:
		# 	mirrorThreshold = cmds.optionVar(q='JF_KAnm_MirrorThreshold' )

		if not cmds.optionVar( exists='JF_KAnm_JfaPath' ):
			cmds.optionVar(sv = ('JF_KAnm_JfaPath', jfaPath))
		else:
			jfaPath = cmds.optionVar(q='JF_KAnm_JfaPath')
		
		if not cmds.optionVar( exists='JF_KAnm_JfpPath' ):
			cmds.optionVar(sv = ('JF_KAnm_JfpPath', jfpPath))
		else:
			jfpPath = cmds.optionVar(q='JF_KAnm_JfpPath')
		
		# self.mirrorLocThreshold_spb.setValue(mirrorThreshold)
		self.exportPath_edit.setText(jfaPath)
		self.exportPosePath_edit.setText(jfpPath)


	def create_controls(self):
		# self.exportPath_edit = QLineEdit("C:/Anm.jfa")
		self.addMirrorInfo_btn = QPushButton("Add Mirror Info")
		# self.addMirrorInfo_btn.setMinimumHeight(86)
		# self.mirrorLocThreshold_spb = QDoubleSpinBox()
		# self.mirrorLocThreshold_spb.setRange(0.00,10.00)
		# self.mirrorLocThreshold_spb.setValue(0.05)
		# self.mirrorLocThreshold_spb.setSingleStep(0.01)
		# self.autoSetMInfo_btn = QPushButton("Auto Setting")
		self.removeMirrorInfo_btn = QPushButton("Remove Mirror Info")
		self.expBrowse_btn = QPushButton("Browse")
		self.expAnm_btn = QPushButton("Export")
		self.expAnmMirror_btn = QPushButton("Mirror Export")
		self.impAnm_btn = QPushButton("Import")
		####
		# self.exportPosePath_edit = QLineEdit("D:/Pose.Jfp")
		self.expPoseBrowse_btn = QPushButton("Browse")
		self.expPose_btn = QPushButton("Export")
		self.expPoseMirror_btn = QPushButton("Mirror Export")
		self.impPose_btn = QPushButton("Import")

	def create_layout(self):
		#--------------------------
		groupBox0 = QGroupBox("Mirror Info")

		mInfo_main_layout = QHBoxLayout()
		mInfo_main_layout.setContentsMargins(6,6,6,6)

		mInfo_layout001 = QHBoxLayout()
		# mInfo_layout001.addWidget(QLabel("mirror threshold:"))
		# mInfo_layout001.addWidget(self.mirrorLocThreshold_spb)

		mInfo_layout01 = QVBoxLayout()
		mInfo_layout01.addLayout(mInfo_layout001)
		# mInfo_layout01.addWidget(self.autoSetMInfo_btn)
		mInfo_layout01.addWidget(self.removeMirrorInfo_btn)

		mInfo_main_layout.addWidget(self.addMirrorInfo_btn)
		mInfo_main_layout.addLayout(mInfo_layout01)

		groupBox0.setLayout(mInfo_main_layout)
		#--------------------------
		groupBox1 = QGroupBox("Animation")

		main_layout = QVBoxLayout()
		main_layout.setContentsMargins(6, 6, 6, 6)
		
		layout1 = QVBoxLayout()
		layout1.setContentsMargins(6, 6, 6, 6)

		layout01 = QHBoxLayout()
		layout01.setContentsMargins(2, 2, 2, 2)
		layout01.addWidget(self.exportPath_edit)
		layout01.addWidget(self.expBrowse_btn)

		layout001 = QVBoxLayout()
		layout001.setContentsMargins(2, 2, 2, 2)
		layout001.addWidget(self.expAnm_btn)
		layout001.addWidget(self.expAnmMirror_btn)

		layout02 = QHBoxLayout()
		layout02.setContentsMargins(2, 6, 6, 6)

		layout02.addLayout(layout001)
		layout02.addWidget(self.impAnm_btn)
		
		layout1.addLayout(layout01)
		layout1.addLayout(layout02)

		groupBox1.setLayout(layout1)
		#------------------------------------
		groupBox2 = QGroupBox("Pose")

		playout1 = QVBoxLayout()
		playout1.setContentsMargins(6, 6, 6, 6)

		playout01 = QHBoxLayout()
		playout01.setContentsMargins(2, 2, 2, 2)
		playout01.addWidget(self.exportPosePath_edit)
		playout01.addWidget(self.expPoseBrowse_btn)

		playout001 = QVBoxLayout()
		playout001.setContentsMargins(2, 2, 2, 2)
		playout001.addWidget(self.expPose_btn)
		playout001.addWidget(self.expPoseMirror_btn)

		playout02 = QHBoxLayout()
		playout02.setContentsMargins(2, 6, 6, 6)

		playout02.addLayout(playout001)
		playout02.addWidget(self.impPose_btn)
		
		playout1.addLayout(playout01)
		playout1.addLayout(playout02)

		groupBox2.setLayout(playout1)
		#------------------------------------
		main_layout.addWidget(groupBox0)
		main_layout.addWidget(groupBox1)
		main_layout.addWidget(groupBox2)

		main_layout.addStretch()
		self.setLayout(main_layout)
				
	def create_connections(self):
		#---------------
		# self.mirrorLocThreshold_spb.valueChanged.connect(AnmTools.onExportMirrorThresholdChanged)
		self.exportPath_edit.textChanged.connect(AnmTools.onExportAnmPathChanged)
		self.exportPosePath_edit.textChanged.connect(AnmTools.onExportPosePathChanged)

		self.addMirrorInfo_btn.clicked.connect(AnmTools.onAddMirrorInfoPressed)
		# self.autoSetMInfo_btn.clicked.connect(AnmTools.setMirrorInfo)
		self.removeMirrorInfo_btn.clicked.connect(AnmTools.onRemoveMirrorInfoPressed)
		self.expBrowse_btn.clicked.connect(AnmTools.onExpBrowserPressed)
		self.expAnm_btn.clicked.connect(AnmTools.onExpAnimaPressed)
		self.expAnmMirror_btn.clicked.connect(AnmTools.onExpAnimaMirrorPressed)
		self.impAnm_btn.clicked.connect(AnmTools.onImpAnimaPressed)
		#-----------------
		self.expPoseBrowse_btn.clicked.connect(AnmTools.onPoseBrowserPressed)
		self.expPose_btn.clicked.connect(AnmTools.onExpPosePressed)
		self.expPoseMirror_btn.clicked.connect(AnmTools.onExpPoseMirrorPressed)
		self.impPose_btn.clicked.connect(AnmTools.onImpPosePressed)

	#--------------------------------------------------------------------------
	# SLOTS
	#--------------------------------------------------------------------------
	@classmethod
	def onExportMirrorThresholdChanged(self):
		#print(self.exportPath_edit.text())
		cmds.optionVar(fv = ('JF_KAnm_MirrorThreshold', self.mirrorLocThreshold_spb.value()))
		pass

	@classmethod
	def onExportAnmPathChanged(self):
		#print(self.exportPath_edit.text())
		cmds.optionVar(sv = ('JF_KAnm_JfaPath', self.exportPath_edit.text()))
		pass

	@classmethod
	def onExportPosePathChanged(self):
		#print(self.exportPath_edit.text())
		cmds.optionVar(sv = ('JF_KAnm_JfpPath', self.exportPosePath_edit.text()))
		pass

	@classmethod
	def onAddMirrorInfoPressed(self):
		selObjects = cmds.ls(sl=True)
		# for o in selObjects:
		# 	if mel.eval('attributeExists "MirrorNode" ' + o) == 0:
		# 		mel.eval('addAttr -ln "MirrorNode" -dt "string" ' + o)

		# 	if mel.eval('attributeExists "InvPosX" ' + o) == 0:
		# 		mel.eval('addAttr -ln "InvPosX" -at "bool" ' + o)

		# 	if mel.eval('attributeExists "InvPosY" ' + o) == 0:
		# 		mel.eval('addAttr -ln "InvPosY" -at "bool" ' + o)

		# 	if mel.eval('attributeExists "InvPosZ" ' + o) == 0:
		# 		mel.eval('addAttr -ln "InvPosZ" -at "bool" ' + o)

		# 	if mel.eval('attributeExists "InvRotX" ' + o) == 0:
		# 		mel.eval('addAttr -ln "InvRotX" -at "bool" ' + o)

		# 	if mel.eval('attributeExists "InvRotY" ' + o) == 0:
		# 		mel.eval('addAttr -ln "InvRotY" -at "bool" ' + o)

		# 	if mel.eval('attributeExists "InvRotZ" ' + o) == 0:
		# 		mel.eval('addAttr -ln "InvRotZ" -at "bool" ' + o)
		self.assignMirrorInfo(selObjects)
		self.setMirrorInfo(selObjects)

	@classmethod
	def onExpBrowserPressed(self):
		#fPath = mel.eval('fileDialog2 -fileFilter ("Animation File (*.jfa)")')
		fPath = cmds.fileDialog2(fileFilter = "Animation File (*"+ anmFileType +")")
		if fPath[0]:
			self.exportPath_edit.setText(fPath[0])

	@classmethod
	def onExpAnimaPressed(self):
		fileInfo = getFilePathInfo(self.exportPath_edit.text())
		if len(fileInfo[0]) == 0:
			fileInfo[0] = "D:/"
		if len(fileInfo[1]) == 0:
			fileInfo[1] = "Anm"
		if fileInfo[2] != anmFileType:
			fileInfo[2] = anmFileType
		newFilePath = fileInfo[0] + fileInfo[1] + fileInfo[2]
		newFilePath = newFilePath.encode('utf-8')
		self.exportPath_edit.setText(newFilePath)

		# self.exportAnima(newFilePath, False)
		self.exportJFAnm(newFilePath, False)

	@classmethod
	def onExpAnimaMirrorPressed(self):
		fileInfo = getFilePathInfo(self.exportPath_edit.text())
		if len(fileInfo[0]) == 0:
			fileInfo[0] = "D:/"
		if len(fileInfo[1]) == 0:
			fileInfo[1] = "Anm"
		if fileInfo[2] != anmFileType:
			fileInfo[2] = anmFileType
		newFilePath = fileInfo[0] + fileInfo[1] + fileInfo[2]
		newFilePath = newFilePath.encode('utf-8')
		self.exportPath_edit.setText(newFilePath)
		
		# self.exportAnima(newFilePath, True)
		self.exportJFAnm(newFilePath, True)

	@classmethod
	def onImpAnimaPressed(self):
		log("start import animation...")

		fileInfo = getFilePathInfo(self.exportPath_edit.text())
		if len(fileInfo[0]) == 0:
			fileInfo[0] = "D:/"
		if len(fileInfo[1]) == 0:
			fileInfo[1] = "Anm"
		if fileInfo[2] != anmFileType:
			fileInfo[2] = anmFileType
		newFilePath = fileInfo[0] + fileInfo[1] + fileInfo[2]
		newFilePath = newFilePath.encode('utf-8')
		self.exportPath_edit.setText(newFilePath)
		
		# self.importAnima(newFilePath)
		self.importJFAnm(newFilePath)

	@classmethod
	def onRemoveMirrorInfoPressed(self):
		selObjects = cmds.ls(sl=True)
		self.removeMirrorInfo(selObjects)

	@classmethod
	def onPoseBrowserPressed(self):
		fPath = cmds.fileDialog2(fileFilter = "Pose File (*"+poseFileType+")")
		if fPath[0]:
			self.exportPosePath_edit.setText(fPath[0])

	@classmethod
	def onExpPosePressed(self):
		fileInfo = getFilePathInfo(self.exportPosePath_edit.text())
		if len(fileInfo[0]) == 0:
			fileInfo[0] = "D:/"
		if len(fileInfo[1]) == 0:
			fileInfo[1] = "Pose"
		if fileInfo[2] != poseFileType:
			fileInfo[2] = poseFileType
		newFilePath = fileInfo[0] + fileInfo[1] + fileInfo[2]
		newFilePath = newFilePath.encode('utf-8')
		self.exportPosePath_edit.setText(newFilePath)
		# self.exportPose(newFilePath, False)
		self.exportJFPose(newFilePath, False)

	@classmethod
	def onExpPoseMirrorPressed(self):
		fileInfo = getFilePathInfo(self.exportPosePath_edit.text())
		if len(fileInfo[0]) == 0:
			fileInfo[0] = "D:/"
		if len(fileInfo[1]) == 0:
			fileInfo[1] = "Pose"
		if fileInfo[2] != poseFileType:
			fileInfo[2] = poseFileType
		newFilePath = fileInfo[0] + fileInfo[1] + fileInfo[2]
		newFilePath = newFilePath.encode('utf-8')
		self.exportPosePath_edit.setText(newFilePath)
		# self.exportPose(newFilePath, True)
		self.exportJFPose(newFilePath, True)
		
	@classmethod
	def onImpPosePressed(self):
		fileInfo = getFilePathInfo(self.exportPosePath_edit.text())
		if len(fileInfo[0]) == 0:
			fileInfo[0] = "D:/"
		if len(fileInfo[1]) == 0:
			fileInfo[1] = "Pose"
		if fileInfo[2] != poseFileType:
			fileInfo[2] = poseFileType
		newFilePath = fileInfo[0] + fileInfo[1] + fileInfo[2]
		newFilePath = newFilePath.encode('utf-8')
		self.exportPosePath_edit.setText(newFilePath)
		# self.importPose(newFilePath)
		self.importJFPose(newFilePath)

	# ----------------------------------------------
	# functions
	# -----------------------------------------------
	@classmethod
	def exportJFAnm(self, filePath, isMirror):

		selObjects = cmds.ls(sl=True)
		objCount = len(selObjects)
		startTime = int(cmds.playbackOptions(q=True, min=True))
		endTime = int(cmds.playbackOptions(q=True, max=True))
		currentTime = int(cmds.currentTime(q=True))
		timePrefix = startTime
		framesCount = endTime - startTime + 1

		AnimData = OrderedDict()
		AnimData['fileType'] = 'JFA'
		AnimData['count'] = objCount

		objList = []
		for o in selObjects:
			if isMirror and (mel.eval('attributeExists "MirrorNode" ' + o) == 1):
				objList.append(cmds.getAttr(o+".MirrorNode"))
			else:
				clrName = o.split(':')[-1]
				objList.append(clrName)
		AnimData['name'] = objList

		AnimData['timelength'] = framesCount

		frameAniData = OrderedDict()
		for f in range(0,framesCount,1):
			cmds.currentTime(f + timePrefix)
			
			frameData = OrderedDict()

			for o in selObjects:
				if isMirror and not self.checkMirrorInfo(o): continue

				attrData = OrderedDict()

				listKeyAttr = cmds.listAttr(o, k=True)
				if listKeyAttr == None: continue

				for a in listKeyAttr:
					if a == 'translateX':
						if isMirror and cmds.getAttr(o+".InvPosX"):
							attrData[a] = cmds.getAttr(o+'.'+a) * -1
						else:
							attrData[a] = cmds.getAttr(o+'.'+a)
					elif a == 'translateY':
						if isMirror and cmds.getAttr(o+".InvPosY"):
							attrData[a] = cmds.getAttr(o+'.'+a) * -1
						else:
							attrData[a] = cmds.getAttr(o+'.'+a)
					elif a == 'translateZ':
						if isMirror and cmds.getAttr(o+".InvPosZ"):
							attrData[a] = cmds.getAttr(o+'.'+a) * -1
						else:
							attrData[a] = cmds.getAttr(o+'.'+a)

					elif a == 'rotateX':
						if isMirror and cmds.getAttr(o+".InvRotX"):
							attrData[a] = cmds.getAttr(o+'.'+a) * -1
						else:
							attrData[a] = cmds.getAttr(o+'.'+a)
					elif a == 'rotateY':
						if isMirror and cmds.getAttr(o+".InvRotY"):
							attrData[a] = cmds.getAttr(o+'.'+a) * -1
						else:
							attrData[a] = cmds.getAttr(o+'.'+a)
					elif a == 'rotateZ':
						if isMirror and cmds.getAttr(o+".InvRotZ"):
							attrData[a] = cmds.getAttr(o+'.'+a) * -1
						else:
							attrData[a] = cmds.getAttr(o+'.'+a)

					else:
						attrData[a] = cmds.getAttr(o+'.'+a)

				if isMirror and (mel.eval('attributeExists "MirrorNode" ' + o) == 1):
					clrName = cmds.getAttr(o+".MirrorNode")
				else:
					clrName = o.split(':')[-1]

				frameData[clrName] = attrData
			frameAniData[f] = frameData
		
		AnimData["Animation"] = frameAniData
		json_str = json.dumps(AnimData, sort_keys=False)

		#### Write to xaf file ###
		text_file = open(filePath, "w")
		text_file.write(json_str)
		text_file.close()

		cmds.currentTime(currentTime)

	@classmethod
	def importJFAnm(self, filePath):
		text_file = open(filePath, "r")
		
		nameSpaceFrefix = ""
		selObjs = cmds.ls(sl=True)
		if(len(selObjs) > 0):
			sOName = selObjs[0].split(':')[-1]
			nameSpaceFrefix = selObjs[0][0:-(len(sOName))]

		fString = text_file.read()
		jfaData = json.loads(fString)

		if jfaData['fileType'] == 'JFA':
			objCount = jfaData['count']
			objList = jfaData['name']
			framesCount = jfaData['timelength']
			AnimData = jfaData['Animation']
			endTime = int(cmds.playbackOptions(q=True, max=True))
			startFrame = int(cmds.currentTime(q=True))
			
			for f in range(0,framesCount):
				log("copy frame at " + str(f))
				tKey = str(f)
				for o in AnimData[tKey]:
					objNode = nameSpaceFrefix + o
					if (cmds.objExists(objNode)):
						attrList = AnimData[tKey][o]
						for a in attrList:
							if cmds.attributeQuery(a, node=nameSpaceFrefix + o, exists=1 ):
								if not cmds.getAttr(objNode+'.'+a, l=True):
									result = cmds.setKeyframe(objNode+'.'+a, time=(startFrame+f), value=AnimData[tKey][o][a])
									if result == 0:
										print(objNode+'.'+a +" no key to set keyframe, maybe animation layer is lock or no key to bake")

			for i in range(0,objCount):
				if (cmds.objExists(nameSpaceFrefix + objList[i])):
					cmds.filterCurve(nameSpaceFrefix+objList[i]+".rotateX",nameSpaceFrefix+objList[i]+".rotateY",nameSpaceFrefix+objList[i]+".rotateZ")
			
			newEndFrame = startFrame + framesCount
			if newEndFrame > endTime:
				cmds.playbackOptions(max = newEndFrame - 1)

			text_file.close()
		else:
			pass

	@classmethod
	def exportAnima(self, filePath, isMirror):
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
			if isMirror and (mel.eval('attributeExists "MirrorNode" ' + o) == 1):
				objList.append(cmds.getAttr(o+".MirrorNode"))
			else:
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
				if isMirror:
					MRO = cmds.getAttr(o+".MirrorRotOffset")[0]
					if (cmds.getAttr(o+".InvPosX")):
						cLPos[0] *= -1
					if (cmds.getAttr(o+".InvPosY")):
						cLPos[1] *= -1
					if (cmds.getAttr(o+".InvPosZ")):
						cLPos[2] *= -1
					if (cmds.getAttr(o+".InvRotX")):
						cLRot[0] *= -1
					if (cmds.getAttr(o+".InvRotY")):
						cLRot[1] *= -1
					if (cmds.getAttr(o+".InvRotZ")):
						cLRot[2] *= -1
						
					cLRot[0] = cLRot[0] + MRO[0]
					cLRot[1] = cLRot[1] + MRO[1]
					cLRot[2] = cLRot[2] + MRO[2]

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

		cmds.currentTime(startTime)

	@classmethod
	def importAnima(self, filePath):
		text_file = open(filePath, "r")
		
		nameSpaceFrefix = ""
		selObjs = cmds.ls(sl=True)
		if(len(selObjs) > 0):
			sOName = selObjs[0].split(':')[-1]
			nameSpaceFrefix = selObjs[0][0:-(len(sOName))]

		fString = text_file.read()
		jfaData = json.loads(fString)

		objCount = jfaData['count']
		objList = jfaData['name']
		framesCount = jfaData['timelength']
		AnimData = jfaData['Animation']
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

	@classmethod
	def assignMirrorInfo(self, objList):
		for obj in objList:
			# 重新設置新的attribute
			Helper.deleteAttr(obj, "MirrorNode")
			Helper.deleteAttr(obj, "InvPosX")
			Helper.deleteAttr(obj, "InvPosY")
			Helper.deleteAttr(obj, "InvPosZ")
			Helper.deleteAttr(obj, "InvRotX")
			Helper.deleteAttr(obj, "InvRotY")
			Helper.deleteAttr(obj, "InvRotZ")
			Helper.deleteAttr(obj, "MirrorRotOffset")
			Helper.deleteAttr(obj, "MirrorRotOffsetX")
			Helper.deleteAttr(obj, "MirrorRotOffsetY")
			Helper.deleteAttr(obj, "MirrorRotOffsetZ")

			if mel.eval('attributeExists "MirrorNode" ' + obj) == 0:
				# mel.eval('addAttr -ln "InvRotX" -at "bool" ' + o)
				cmds.addAttr(obj, ln="MirrorNode", dt="string")
				cmds.addAttr(obj, ln="InvPosX", at="bool", k=False)
				cmds.addAttr(obj, ln="InvPosY", at="bool", k=False)
				cmds.addAttr(obj, ln="InvPosZ", at="bool", k=False)
				cmds.addAttr(obj, ln="InvRotX", at="bool", k=False)
				cmds.addAttr(obj, ln="InvRotY", at="bool", k=False)
				cmds.addAttr(obj, ln="InvRotZ", at="bool", k=False)
				# cmds.addAttr(obj, ln="MirrorRotOffset", at="double3", k=False)
				cmds.addAttr(obj, ln="MirrorRotOffset", at="double3", k=False)
				cmds.addAttr(obj, ln="MirrorRotOffsetX", at="double", p="MirrorRotOffset", k=False)
				cmds.addAttr(obj, ln="MirrorRotOffsetY", at="double", p="MirrorRotOffset", k=False)
				cmds.addAttr(obj, ln="MirrorRotOffsetZ", at="double", p="MirrorRotOffset", k=False)

	@classmethod
	def removeMirrorInfo(self, objList):
		for obj in objList:
			if mel.eval('attributeExists "MirrorNode" ' + obj) == 1:
				cmds.deleteAttr(obj+".MirrorNode")

			if mel.eval('attributeExists "InvPosX" ' + obj) == 1:
				cmds.deleteAttr(obj+".InvPosX")

			if mel.eval('attributeExists "InvPosY" ' + obj) == 1:
				cmds.deleteAttr(obj+".InvPosY")

			if mel.eval('attributeExists "InvPosZ" ' + obj) == 1:
				cmds.deleteAttr(obj+".InvPosZ")

			if mel.eval('attributeExists "InvRotX" ' + obj) == 1:
				cmds.deleteAttr(obj+".InvRotX")

			if mel.eval('attributeExists "InvRotY" ' + obj) == 1:
				cmds.deleteAttr(obj+".InvRotY")

			if mel.eval('attributeExists "InvRotZ" ' + obj) == 1:
				cmds.deleteAttr(obj+".InvRotZ")

			if mel.eval('attributeExists "MirrorRotOffset" ' + obj) == 1:
				cmds.deleteAttr(obj+".MirrorRotOffset")

	@classmethod
	def setMirrorInfo(self, objList):
		for obj in objList:
			
			try:
				cmds.xform(obj, q=True, ws=True, t=True)
			except:
				Helper.showMessage(u"選取到不該選取的物件，例如Controller圖層:" + obj)
				continue

			objName = obj.split(':')[-1]
			strPrefix = obj[0:-(len(objName))]
			###### Try Find R/L name ######
			lastStr = objName[-1]
			mirStr = ""
			if lastStr=="M":
				cmds.setAttr(obj + ".MirrorNode", objName, type="string")
				continue
			elif lastStr=="R" or lastStr=="L" :
				if lastStr=="R":
					mirStr = "L"
				else:
					mirStr = "R"

				mirName = objName[:-1] + mirStr

				if (cmds.objExists(strPrefix+mirName)):
					cmds.setAttr(obj + ".MirrorNode", mirName, type="string")
					continue


			######  find mirror side node  ######
			checkBuff = False
			tarLoc = cmds.xform(obj, q=True, ws=True, t=True)

			mirLoc = [tarLoc[0], tarLoc[1], tarLoc[2]]
			mirLoc[0] *= -1
			
			MirrorObj = objName

			for other in objList:
				if obj == other:
					continue
				
				cLoc = cmds.xform(other, q=True, ws=True, t=True)
				mOffsetDis = distance(mirLoc, cLoc)
				if mOffsetDis <= 0.05:
					dcDis = distance(tarLoc, cLoc)
					if dcDis > 0.05:
						MirrorObj = other.split(':')[-1]
						cmds.setAttr(obj + ".MirrorNode", MirrorObj, type="string")
						checkBuff = True
						break
			if checkBuff == False:
				cmds.setAttr(obj + ".MirrorNode", MirrorObj, type="string")
			
		####  Check flip axis  ####
		for obj in objList:
			objName = obj.split(':')[-1]
			strPrefix = obj[0:-(len(objName))]
			mirObj = strPrefix + cmds.getAttr(obj+".MirrorNode")

			trans01 = cmds.xform(obj, q=True, ws=True, m=True)
			trans02 = cmds.xform(mirObj, q=True, ws=True, m=True)

			# Vx1 = [trans01[0],trans01[1],trans01[2]]
			# Vy1 = [trans01[4],trans01[5],trans01[6]]
			# Vz1 = [trans01[8],trans01[9],trans01[10]]

			mVx1 = [-trans01[0],trans01[1],trans01[2]]
			mVy1 = [-trans01[4],trans01[5],trans01[6]]
			mVz1 = [-trans01[8],trans01[9],trans01[10]]

			Vx2 = [trans02[0],trans02[1],trans02[2]]
			Vy2 = [trans02[4],trans02[5],trans02[6]]
			Vz2 = [trans02[8],trans02[9],trans02[10]]

			sX = dot(mVx1, Vx2)
			sY = dot(mVy1, Vy2)
			sZ = dot(mVz1, Vz2)
			
			invRot = [1,1,1]
			
			if sX > 0:
				cmds.setAttr(obj+".InvPosX", 1)
				cmds.setAttr(obj+".InvRotX", 1)
				invRot[0] = -1
			else:
				cmds.setAttr(obj+".InvPosX", 1)
				cmds.setAttr(obj+".InvRotX", 0)
				invRot[0] = 1

			if sY > 0:
				cmds.setAttr(obj+".InvPosY", 0)
				cmds.setAttr(obj+".InvRotY", 1)
				invRot[1] = -1
			else:
				cmds.setAttr(obj+".InvPosY", 0)
				cmds.setAttr(obj+".InvRotY", 0)
				invRot[1] = 1
				
			if sZ > 0:
				cmds.setAttr(obj+".InvPosZ", 0)
				cmds.setAttr(obj+".InvRotZ", 1)
				invRot[2] = -1
			else:
				cmds.setAttr(obj+".InvPosZ", 0)
				cmds.setAttr(obj+".InvRotZ", 0)
				invRot[2] = 1

			objRot = cmds.getAttr(obj+".rotate")[0]
			curMirrorRot = cmds.getAttr(mirObj+".rotate")[0]
			RotOffset = [curMirrorRot[0]-objRot[0]*invRot[0],
						 curMirrorRot[1]-objRot[1]*invRot[1],
						 curMirrorRot[2]-objRot[2]*invRot[2]]
			cmds.setAttr(obj + ".MirrorRotOffset", RotOffset[0],RotOffset[1],RotOffset[2], type="double3")
	@classmethod
	def checkMirrorInfo(self, o):
		# 檢查鏡射屬性
		for attr in ["InvPosX", "InvPosY", "InvPosZ", "InvRotX", "InvRotY", "InvRotZ", "MirrorNode"]:
			try:
				cmds.getAttr(o+"." +attr)
			except:
				print( o + " has no mirror info, ignore it" )
				# Helper.showMessage( o + u"沒有鏡射屬性哦，請rig人員幫忙查看")
				return False
		return True
	@classmethod
	def exportJFPose(self, filePath, isMirror):

		selObjects = cmds.ls(sl=True)
		objCount = len(selObjects)
		currentTime = int(cmds.currentTime(q=True))

		PoseData = OrderedDict()
		PoseData['fileType'] = 'JFP'
		PoseData['count'] = objCount

		poseAttrData  = OrderedDict()

		for o in selObjects:
			if isMirror and not self.checkMirrorInfo(o): continue

			attrData = OrderedDict()
			listKeyAttr = cmds.listAttr(o, k=True)
			if listKeyAttr == None: continue

			for a in listKeyAttr:
				if a == 'translateX':
					if isMirror and cmds.getAttr(o+".InvPosX"):
						attrData[a] = cmds.getAttr(o+'.'+a) * -1
					else:
						attrData[a] = cmds.getAttr(o+'.'+a)
				elif a == 'translateY':
					if isMirror and cmds.getAttr(o+".InvPosY"):
						attrData[a] = cmds.getAttr(o+'.'+a) * -1
					else:
						attrData[a] = cmds.getAttr(o+'.'+a)
				elif a == 'translateZ':
					if isMirror and cmds.getAttr(o+".InvPosZ"):
						attrData[a] = cmds.getAttr(o+'.'+a) * -1
					else:
						attrData[a] = cmds.getAttr(o+'.'+a)

				elif a == 'rotateX':
					if isMirror and cmds.getAttr(o+".InvRotX"):
						attrData[a] = cmds.getAttr(o+'.'+a) * -1
					else:
						attrData[a] = cmds.getAttr(o+'.'+a)
				elif a == 'rotateY':
					if isMirror and cmds.getAttr(o+".InvRotY"):
						attrData[a] = cmds.getAttr(o+'.'+a) * -1
					else:
						attrData[a] = cmds.getAttr(o+'.'+a)
				elif a == 'rotateZ':
					if isMirror and cmds.getAttr(o+".InvRotZ"):
						attrData[a] = cmds.getAttr(o+'.'+a) * -1
					else:
						attrData[a] = cmds.getAttr(o+'.'+a)

				else:
					attrData[a] = cmds.getAttr(o+'.'+a)

			if isMirror and (mel.eval('attributeExists "MirrorNode" ' + o) == 1):
				clrName = cmds.getAttr(o+".MirrorNode")
			else:
				clrName = o.split(':')[-1]
			
			poseAttrData[clrName] = attrData

		PoseData['Pose'] = poseAttrData

		json_str = json.dumps(PoseData, sort_keys=False)
		
		#### Write to xaf file ###
		text_file = open(filePath, "w")
		text_file.write(json_str)
		text_file.close()

	@classmethod
	def exportPose(self, filePath, isMirror):
		selObjects = cmds.ls(sl=True)
		objCount = len(selObjects)
		currentTime = int(cmds.currentTime(q=True))

		PoseData = OrderedDict()
		PoseData['count'] = objCount

		objList = []
		for o in selObjects:
			if isMirror and (mel.eval('attributeExists "MirrorNode" ' + o) == 1):
				objList.append(cmds.getAttr(o+".MirrorNode"))
			else:
				clrName = o.split(':')[-1]
				objList.append(clrName)
		PoseData['name'] = objList

		

		posArray = []
		RotArray = []
		sclArray = []

		for o in selObjects:
			cLPos = list(cmds.getAttr(o+".translate")[0])
			cLRot = list(cmds.getAttr(o+".rotate")[0])
			cLScl = list(cmds.getAttr(o+".scale")[0])
			if isMirror:
				MRO = cmds.getAttr(o+".MirrorRotOffset")[0]
				if (cmds.getAttr(o+".InvPosX")):
					cLPos[0] *= -1
				if (cmds.getAttr(o+".InvPosY")):
					cLPos[1] *= -1
				if (cmds.getAttr(o+".InvPosZ")):
					cLPos[2] *= -1
				if (cmds.getAttr(o+".InvRotX")):
					cLRot[0] *= -1
				if (cmds.getAttr(o+".InvRotY")):
					cLRot[1] *= -1
				if (cmds.getAttr(o+".InvRotZ")):
					cLRot[2] *= -1
					
				cLRot[0] = cLRot[0] + MRO[0]
				cLRot[1] = cLRot[1] + MRO[1]
				cLRot[2] = cLRot[2] + MRO[2]

			posArray.append(cLPos)
			RotArray.append(cLRot)
			sclArray.append(cLScl)

		transformData = OrderedDict()
		transformData["Position"] = posArray
		transformData["Rotation"] = RotArray
		transformData["Scale"] = sclArray

		PoseData['Pose'] = transformData

		json_str = json.dumps(PoseData, sort_keys=False)
		
		
		
		#### Write to xaf file ###
		text_file = open(filePath, "w")
		text_file.write(json_str)
		text_file.close()

	@classmethod
	def importJFPose(self, filePath):
		text_file = open(filePath, "r")
		
		nameSpaceFrefix = ""
		selObjs = cmds.ls(sl=True)
		if(len(selObjs) > 0):
			sOName = selObjs[0].split(':')[-1]
			nameSpaceFrefix = selObjs[0][0:-(len(sOName))]

		fString = text_file.read()
		JfpData = json.loads(fString)

		if JfpData['fileType'] == 'JFP':
			objCount = JfpData['count']
			# objList = JfpData['name']
			PoseData = JfpData['Pose']

			for o in PoseData:
				if (cmds.objExists(nameSpaceFrefix + o)):
					attrList = PoseData[o]
					for a in attrList:
						try:
							if not cmds.getAttr(nameSpaceFrefix+o+'.'+a, l=True):
								cmds.setAttr(nameSpaceFrefix+o+'.'+a, PoseData[o][a])
						except:
							print("it's been locked... can not modify.", nameSpaceFrefix+o+'.'+a)

	@classmethod
	def importPose(self, filePath):
		text_file = open(filePath, "r")
		
		nameSpaceFrefix = ""
		selObjs = cmds.ls(sl=True)
		if(len(selObjs) > 0):
			sOName = selObjs[0].split(':')[-1]
			nameSpaceFrefix = selObjs[0][0:-(len(sOName))]

		fString = text_file.read()
		JfpData = json.loads(fString)

		objCount = JfpData['count']
		objList = JfpData['name']
		PoseData = JfpData['Pose']

		for i in range(0,objCount):
			if (cmds.objExists(nameSpaceFrefix + objList[i])):
				### Position ###
				if not cmds.getAttr(nameSpaceFrefix + objList[i] + ".translateX", l=True):
					#cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".translateX", time=(startFrame+f), value=AnimData[tKey]['Position'][i][0])
					cmds.setAttr(nameSpaceFrefix + objList[i] + ".translateX", PoseData['Position'][i][0])
				if not cmds.getAttr(nameSpaceFrefix + objList[i] + ".translateY", l=True):
					#cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".translateY", time=(startFrame+f), value=AnimData[tKey]['Position'][i][1])
					cmds.setAttr(nameSpaceFrefix + objList[i] + ".translateY", PoseData['Position'][i][1])
				if not cmds.getAttr(nameSpaceFrefix + objList[i] + ".translateZ", l=True):
					#cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".translateZ", time=(startFrame+f), value=AnimData[tKey]['Position'][i][2])
					cmds.setAttr(nameSpaceFrefix + objList[i] + ".translateZ", PoseData['Position'][i][2])

				### Rotation ###
				if not cmds.getAttr(nameSpaceFrefix + objList[i] + ".rotateX", l=True):
					#cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".rotateX", time=(startFrame+f), value=AnimData[tKey]['Rotation'][i][0])
					cmds.setAttr(nameSpaceFrefix + objList[i] + ".rotateX", PoseData['Rotation'][i][0])
				if not cmds.getAttr(nameSpaceFrefix + objList[i] + ".rotateY", l=True):
					#cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".rotateY", time=(startFrame+f), value=AnimData[tKey]['Rotation'][i][1])
					cmds.setAttr(nameSpaceFrefix + objList[i] + ".rotateY", PoseData['Rotation'][i][1])
				if not cmds.getAttr(nameSpaceFrefix + objList[i] + ".rotateZ", l=True):
					#cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".rotateZ", time=(startFrame+f), value=AnimData[tKey]['Rotation'][i][2])
					cmds.setAttr(nameSpaceFrefix + objList[i] + ".rotateZ", PoseData['Rotation'][i][2])

				### Scale ###
				if not cmds.getAttr(nameSpaceFrefix + objList[i] + ".scaleX", l=True):
					#cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".scaleX", time=(startFrame+f), value=AnimData[tKey]['Scale'][i][0])
					cmds.setAttr(nameSpaceFrefix + objList[i] + ".scaleX", PoseData['Scale'][i][0])
				if not cmds.getAttr(nameSpaceFrefix + objList[i] + ".scaleY", l=True):
					#cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".scaleY", time=(startFrame+f), value=AnimData[tKey]['Scale'][i][1])
					cmds.setAttr(nameSpaceFrefix + objList[i] + ".scaleY", PoseData['Scale'][i][1])
				if not cmds.getAttr(nameSpaceFrefix + objList[i] + ".scaleZ", l=True):
					#cmds.setKeyframe(nameSpaceFrefix + objList[i] + ".scaleZ", time=(startFrame+f), value=AnimData[tKey]['Scale'][i][2])
					cmds.setAttr(nameSpaceFrefix + objList[i] + ".scaleZ", PoseData['Scale'][i][2])


#-------------------------------------------------#
'''
if __name__ == "__main__":
	try:
		test_ui.deleteLater()
	except:
		pass
	
	# Create minimal UI object
	test_ui = AnmTools()
	
	# Delete the UI if errors occur to avoid causing winEvent
	# and event errors (in Maya 2014)
	try:
		test_ui.create()
		test_ui.show()
	except:
		test_ui.deleteLater()
	traceback.print_exc()
'''
def createUI():
	Anim_ui = AnmTools()