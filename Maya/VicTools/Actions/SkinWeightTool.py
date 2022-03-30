#-*- coding:utf-8 -*-
import traceback


from collections import OrderedDict

import json
import math
import maya.cmds as cmds
import maya.OpenMayaUI as omui
import pymel.core.datatypes as dt
import maya.mel as mel
import os
import re

if int(cmds.about(version=True)) >= 2017:
	from PySide2 import QtCore
	from PySide2.QtGui import *
	from PySide2.QtWidgets import *
	from shiboken2 import wrapInstance
else:
	from PySide import QtCore
	from PySide.QtGui import *
	from shiboken import wrapInstance

# dt = pymel.core.datatypes

def getTriangleHeight(pA, pB, pC):
	vA = pB - pA
	vV = pC - pA
	AxV = vA^vV

	return AxV.length() / vA.length()

def getDistanceToPlane(objRef,vNrm,objA):
	pRef = dt.Vector(cmds.xform(objRef,q=True,ws=True,t=True))
	pA = dt.Vector(cmds.xform(objA,q=True,ws=True,t=True))
	vA = pA - pRef

	return vA*vNrm#abs(vA*vNrm)

def getTransform(shape):
	outTrans = None
	if 'transform' != cmds.nodeType(shape):
		parent = cmds.listRelatives(shape, p=True)
		if parent:
			outTrans = parent[0]
	else:
		outTrans = shape
		
	return outTrans

def getVertexIdx(namePath):
	strInfo = re.split('[\:[\]]', namePath)
	infoCount = len(strInfo)
	if infoCount == 3:
		return [int(strInfo[1])]
	elif infoCount == 4:
		outVal = []
		stNum = int(strInfo[1])
		edNum = int(strInfo[2])
		for i in range(stNum, edNum+1):
			outVal.append(i)
		return outVal
	return []

def checkMeshVertex(namePath):
	oType = cmds.objectType(namePath)
	if oType == 'mesh':
		vtxList = getVertexIdx(namePath)
		if len(vtxList) > 0 : return True
		else : return False
	else: return False


def checkSkinMesh(obj):
	oType = cmds.objectType(obj)
	if oType == 'mesh': return True
	elif oType == 'transform':
		shapes = cmds.listRelatives(obj,s=True)
		if shapes:
			if cmds.objectType(shapes[0])=='mesh': return True
			else: return False
		else : return False
	else : return False

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

def maya_main_window():
	main_window_ptr = omui.MQtUtil.mainWindow()
	return wrapInstance(long(main_window_ptr), QWidget)

class SkinWeightTool(QDialog):
	width = 200
	height = 425

	maxBoneCount = 8
	weightThreshold = 0.001

	def __init__(self, parent=maya_main_window()):
		self.closeExistingWindow()
		super(SkinWeightTool, self).__init__(parent)
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
		self.setWindowTitle("Skin Weight Tool")
		self.setWindowFlags(QtCore.Qt.Tool)
		self.setMinimumSize(self.width,self.height)
		self.setMaximumSize(self.width,self.height)

		self.create_controls()
		self.create_layout()
		self.readConfig()
		self.create_connections()
		self.show()

	def readConfig(self):
		pass

	def create_controls(self):

		self.spMaxBoneCount = QSpinBox()
		self.spMaxBoneCount.setRange(1,8)
		self.spMaxBoneCount.setValue(8)

		self.btnMaxBoneRematch = QPushButton('Rematch')

		self.spZeroThreshold = QDoubleSpinBox()
		self.spZeroThreshold.setRange(0.0001,0.5000)
		self.spZeroThreshold.setDecimals(4)
		self.spZeroThreshold.setValue(0.0100)
		self.spZeroThreshold.setSingleStep(0.0001)

		self.btnZeroLimitRematch = QPushButton('Remove Zero Weight')
		self.btnRemoveBoneWeight = QPushButton('Remove Bone Weight')
		self.btnWeightTransfer = QPushButton('Tansfer Weight')

		self.btnAutoSequenceWeight = QPushButton('Auto Weight')

		self.spASWDiatanceRatio = QDoubleSpinBox()
		self.spASWDiatanceRatio.setRange(0.5,2.0)
		self.spASWDiatanceRatio.setDecimals(2)
		self.spASWDiatanceRatio.setValue(1.2)
		self.spASWDiatanceRatio.setSingleStep(0.01)

	def create_layout(self):
		# self.setStyleSheet("*{font: 10px Microsoft JHengHei, sans-serif;}")
		#----------------
		lbMaxBoneCount = QLabel('Max Bones:', self)
		lbMaxBoneCount.move(10,14)

		self.spMaxBoneCount.setParent(self)
		self.spMaxBoneCount.setGeometry(75, 10, 40, 20)

		self.btnMaxBoneRematch.setParent(self)
		self.btnMaxBoneRematch.setGeometry(125, 10, self.width - 135, 20)
		#------------------
		lbZeroThreshold = QLabel('Zero Threshold:', self)
		lbZeroThreshold.move(10, 45)

		self.spZeroThreshold.setParent(self)
		self.spZeroThreshold.setGeometry(100, 41, 91, 20)

		self.btnZeroLimitRematch.setParent(self)
		self.btnZeroLimitRematch.setGeometry(10, 63, self.width - 20, 20)
		#-------------------
		self.btnRemoveBoneWeight.setParent(self)
		self.btnRemoveBoneWeight.setGeometry(10, 100, self.width - 20, 40)

		strRBW = '先選擇要作用的Vertex(可複選), \n最後選擇要移除權重的Joint'
		lbRemoveBoneWeight = QLabel(strRBW.decode("utf-8"), self)
		lbRemoveBoneWeight.move(10, 142)
		lbRemoveBoneWeight.setStyleSheet("*{font: 12px Microsoft JHengHei, sans-serif;color:#777;}")
		#------------------------
		bpTransferBoneWeight = QGroupBox('骨架權重轉移'.decode("utf-8"), self)
		bpTransferBoneWeight.setStyleSheet("*{font: 12px Microsoft JHengHei, sans-serif;color:#111;}")
		bpTransferBoneWeight.setGeometry(10, 180, self.width - 20, 115)

		self.btnWeightTransfer.setParent(bpTransferBoneWeight)
		self.btnWeightTransfer.setGeometry(10,20,bpTransferBoneWeight.width()-20, 40)
		self.btnWeightTransfer.setStyleSheet("*{font: 12px Microsoft JHengHei, sans-serif;color:#eee;}")

		strTBW = '先選擇Skin Mesh\n再選擇移出權重的Joint(可複選)\n最後選擇移入權重的Joint'
		lbWeightTransfer = QLabel(strTBW.decode("utf-8"), bpTransferBoneWeight)
		lbWeightTransfer.move(6, 62)
		lbWeightTransfer.setStyleSheet("*{font: 12px Microsoft JHengHei, sans-serif;color:#777;}")
		#-------------------------
		bgASW = QGroupBox('Twist骨架自動權重'.decode("utf-8"), self)
		bgASW.setStyleSheet("*{font: 12px Microsoft JHengHei, sans-serif;color:#111;}")
		bgASW.setGeometry(10, 300, self.width - 20, 115)

		self.btnAutoSequenceWeight.setParent(bgASW)
		self.btnAutoSequenceWeight.setGeometry(10,20,bgASW.width()-20, 30)
		self.btnAutoSequenceWeight.setStyleSheet("*{font: 12px Microsoft JHengHei, sans-serif;color:#eee;}")

		lbASWDistanceRatio = QLabel('範圍倍率 :'.decode('utf-8'), bgASW)
		lbASWDistanceRatio.move(12,58)
		lbASWDistanceRatio.setStyleSheet("*{font: 12px Microsoft JHengHei, sans-serif;color:#ddd;}")

		self.spASWDiatanceRatio.setParent(bgASW)
		self.spASWDiatanceRatio.setGeometry(80,55, bgASW.width()-90, 20)
		self.spASWDiatanceRatio.setStyleSheet("*{font: 12px Microsoft JHengHei, sans-serif;color:#eee;}")

		strASWDR = '先選擇要作用的Vertex\n再依序選擇Bone Joint'
		lbASW = QLabel(strASWDR.decode("utf-8"), bgASW)
		lbASW.move(10, 77)
		lbASW.setStyleSheet("*{font: 12px Microsoft JHengHei, sans-serif;color:#777;}")
		pass
				
	def create_connections(self):
		self.btnMaxBoneRematch.clicked.connect(self.doBtnMaxBoneRemath)
		self.btnZeroLimitRematch.clicked.connect(self.doBtnZeroRemove)
		self.btnRemoveBoneWeight.clicked.connect(self.doBtnBoneWeightRemove)
		self.btnWeightTransfer.clicked.connect(self.doBtnTransferWeight)
		self.btnAutoSequenceWeight.clicked.connect(self.doBtnAutoSeqWeight)
		pass
	#--------------------------------------------------------------------------
	# Evant
	#--------------------------------------------------------------------------
	def doBtnMaxBoneRemath(self):
		self.rematchMaxBonesWeight()
		
	def doBtnZeroRemove(self):
		self.removeZeroWeight()

	def doBtnBoneWeightRemove(self):
		self.removeBoneWeight()

	def doBtnTransferWeight(self):
		self.transferWeight()

	def doBtnAutoSeqWeight(self):
		self.autoSequenceWeight()
	#--------------------------------------------------------------------------
	# Methold
	#--------------------------------------------------------------------------
	def rematchMaxBonesWeight(self):
		selList = cmds.ls(sl=True)
		if len(selList) > 0:
			if checkSkinMesh(selList[0]):
				mesh = getTransform(selList[0])
				# print(mesh)
				histList = cmds.listHistory(mesh, pdo=True)
				SkinCluster = cmds.ls(histList,type='skinCluster')
				if len(SkinCluster) > 0:
					vtxCount = cmds.polyEvaluate(mesh, v=True)
					skinBoneList = cmds.skinPercent(SkinCluster[0], mesh + '.vtx[0]', query=True, transform=None)
					cmds.setAttr(SkinCluster[0]+'.normalizeWeights', 0)

					gMainProgressBar = mel.eval('$tmp = $gMainProgressBar')
					cmds.progressBar(gMainProgressBar,edit=True, beginProgress=True, isInterruptable=True, status='Max Bones Rematch', maxValue=vtxCount)

					for i in range(vtxCount):
						vetexFullPath = mesh + '.vtx[' + str(i) + ']'

						weightList = cmds.skinPercent( SkinCluster[0], vetexFullPath, query=True, value=True )
						jntWeight = []
						
						for j in range(len(weightList)):
							if weightList[j] > 0:
								jntWeight.append([skinBoneList[j], weightList[j]])

						# 超過骨架最大數量
						if len(jntWeight) > self.spMaxBoneCount.value():
							
							# 排序權重，由大到小
							for a in range(len(jntWeight)-1):
								for b in range(len(jntWeight)-1):
									if jntWeight[b][1] < jntWeight[b+1][1]:
										tmp = jntWeight[b]
										jntWeight[b] = jntWeight[b+1]
										jntWeight[b+1] = tmp
							
							totalWeight = 0.0
							for k in range(self.spMaxBoneCount.value()):
								totalWeight += jntWeight[k][1]

							for k in range(len(jntWeight)):
								if k < self.spMaxBoneCount.value():
									jntWeight[k][1] = jntWeight[k][1] / totalWeight
								else:
									jntWeight[k][1] = 0.0

							cmds.select(d=True)
							cmds.select(vetexFullPath)
							cmds.skinPercent(SkinCluster[0], tv=jntWeight)

						# 進度+1
						cmds.progressBar(gMainProgressBar,edit=True, step=1)

					cmds.setAttr(SkinCluster[0]+'.normalizeWeights', 1)
					cmds.progressBar(gMainProgressBar,edit=True, endProgress=True)

					cmds.select(d=True)
					cmds.select(mesh)

					strMessage = '所有使用超過' + str(self.spMaxBoneCount.value()) + '根骨架的權重已重新分配'
					cmds.confirmDialog(title='完成'.decode("utf-8"), message=strMessage.decode("utf-8"), button='確認'.decode("utf-8"))
				else:
					cmds.confirmDialog(title='錯誤'.decode("utf-8"), message='你選擇的物件沒有Skin'.decode("utf-8"), button='確認'.decode("utf-8"))
		
	def removeZeroWeight(self):
		selList = cmds.ls(sl=True)
		if len(selList) > 0:
			if checkSkinMesh(selList[0]):
				mesh = getTransform(selList[0])
				histList = cmds.listHistory(mesh, pdo=True)
				SkinCluster = cmds.ls(histList,type='skinCluster')
				if len(SkinCluster) > 0:
					SkinCluster = SkinCluster[0]

					vtxCount = cmds.polyEvaluate(mesh, v=True)
					skinBoneList = cmds.skinPercent(SkinCluster, mesh + '.vtx[0]', query=True, transform=None)
					cmds.setAttr(SkinCluster+'.normalizeWeights', 0)

					gMainProgressBar = mel.eval('$tmp = $gMainProgressBar')
					cmds.progressBar(gMainProgressBar,edit=True, beginProgress=True, isInterruptable=True, status='Max Bones Rematch', maxValue=vtxCount)

					for i in range(vtxCount):
						vetexFullPath = mesh + '.vtx[' + str(i) + ']'

						weightList = cmds.skinPercent( SkinCluster, vetexFullPath, query=True, value=True )
						jntWeight = []

						totalWeight = 0.0
						bNeedRemoveZero = False
						for j in range(len(weightList)):
							if weightList[j] > 0:
								if weightList[j] > self.spZeroThreshold.value() : totalWeight += weightList[j]
								else : bNeedRemoveZero = True
								jntWeight.append([skinBoneList[j], weightList[j]])

						# 如果有小於閥值
						if bNeedRemoveZero:

							# 排序權重，由大到小
							for a in range(len(jntWeight)-1):
								for b in range(len(jntWeight)-1):
									if jntWeight[b][1] < jntWeight[b+1][1]:
										tmp = jntWeight[b]
										jntWeight[b] = jntWeight[b+1]
										jntWeight[b+1] = tmp

							for k in range(len(jntWeight)):
								if jntWeight[k][1] > self.spZeroThreshold.value():
									jntWeight[k][1] = jntWeight[k][1] / totalWeight
								else:
									jntWeight[k][1] = 0.0

							cmds.select(d=True)
							cmds.select(vetexFullPath)
							cmds.skinPercent(SkinCluster, tv=jntWeight)

						# 進度+1
						cmds.progressBar(gMainProgressBar,edit=True, step=1)
					
					cmds.setAttr(SkinCluster+'.normalizeWeights', 1)
					cmds.progressBar(gMainProgressBar,edit=True, endProgress=True)

					cmds.select(d=True)
					cmds.select(selList)

					strMessage = '所有低於' + str(self.spZeroThreshold.value()) + '的骨架已移除'
					cmds.confirmDialog(title='完成'.decode("utf-8"), message=strMessage.decode("utf-8"), button='確認'.decode("utf-8"))
				else:
					cmds.confirmDialog(title='錯誤'.decode("utf-8"), message='你選擇的物件沒有Skin'.decode("utf-8"), button='確認'.decode("utf-8"))

	def removeBoneWeight(self):
		selList = cmds.ls(sl=True)
		if len(selList) > 1:
			if checkMeshVertex(selList[0]) and (cmds.objectType(selList[-1]) == 'joint'):
				mesh = getTransform(selList[0])
				histList = cmds.listHistory(mesh, pdo=True)
				SkinCluster = cmds.ls(histList,type='skinCluster')

				if len(SkinCluster) > 0:
					SkinCluster = SkinCluster[0]

					gMainProgressBar = mel.eval('$tmp = $gMainProgressBar')
					cmds.progressBar(gMainProgressBar,edit=True, beginProgress=True, isInterruptable=True, status='Max Bones Rematch', maxValue=(len(selList)-1))

					vIdxList = []
					for vDef in selList[:-1]:
						vIdxList.extend(getVertexIdx(vDef))

					for idx in vIdxList:
						vtx = mesh + '.vtx[' + str(idx) + ']'
						
						skinBoneList = cmds.skinPercent(SkinCluster, vtx, query=True, transform=None)
						cmds.setAttr(SkinCluster+'.normalizeWeights', 0)

						weightList = cmds.skinPercent( SkinCluster, vtx, query=True, value=True )
						jntWeight = []
						totalWeight = 0.0
						bMatchBone = False
						if type(weightList) == list:
							for j in range(len(weightList)):
								if weightList[j] > 0:
									if skinBoneList[j] != selList[-1]: totalWeight += weightList[j]
									else : bMatchBone = True
									jntWeight.append([skinBoneList[j], weightList[j]])

							# 如果有用到準備移除的Bone時
							if bMatchBone:
								for k in range(len(jntWeight)):
									if jntWeight[k][0] != selList[-1]:
										jntWeight[k][1] = jntWeight[k][1] / totalWeight
									else:
										jntWeight[k][1] = 0.0

								cmds.select(d=True)
								cmds.select(vtx)
								cmds.skinPercent(SkinCluster, tv=jntWeight)

						cmds.setAttr(SkinCluster+'.normalizeWeights', 1)
					# 進度+1
					cmds.progressBar(gMainProgressBar,edit=True, step=1)

				
				cmds.progressBar(gMainProgressBar,edit=True, endProgress=True)

				cmds.select(d=True)
				cmds.select(selList[:-1])
				strMessage = '所有'+ str(selList[-1]) + '\n對你選擇的點影響的權重已移除'
				cmds.confirmDialog(title='完成'.decode("utf-8"), message=strMessage.decode("utf-8"), button='確認'.decode("utf-8"))

			else:
				cmds.confirmDialog(title='錯誤'.decode("utf-8"), message='你必須選擇有用Skin的點，並在最後選取要移除的bone joint'.decode("utf-8"), button='確認'.decode("utf-8"))

	def transferWeight(self):
		selection = cmds.ls(sl=True)
		selectCount = len(selection)
		if selectCount > 2:
			srcBones = []
			mesh = getTransform(selection[0])
			dectBone = selection[-1]
			for i in range(selectCount - 2):
				boneObj = selection[i+1]
				srcBones.append(boneObj)
				
			histList = cmds.listHistory(mesh, pdo=True)
			SkinCluster = cmds.ls(histList,type='skinCluster')[0]
			
			skinBoneList = cmds.skinPercent(SkinCluster, mesh + '.vtx[0]', query=True, transform=None)
			bCount = len(srcBones)
			tempList = []
			for i in range(bCount):
				bCheck = False
				# bIdx = bCount - 1 - i
				for checkB in skinBoneList:
					if srcBones[i] == checkB:
						tempList.append(srcBones[i])
			
			srcBones = tempList
			allBones = srcBones[:]
			# alwlBones.append(dectBone)
			
			cmds.select(d=True) #取消選取
			cmds.skinCluster(SkinCluster,siv=allBones,e=True) #選擇所有被選取的bone影響的點
			actVetices = cmds.ls(sl=True) #取得選到的點的path
			
			VerticesIdx = []
			#把所有點的index放到VerticesIdx裡
			for v in actVetices:
				VerticesIdx.extend(getVertexIdx(v))
			
			gMainProgressBar = mel.eval('$tmp = $gMainProgressBar')
			cmds.progressBar(gMainProgressBar,edit=True, beginProgress=True, isInterruptable=True, status='Max Bones Rematch', maxValue=(len(VerticesIdx)))

			for idx in VerticesIdx:
				# qqq = cmds.skinPercent('skinCluster2','PL_1002aB2.vtx[4371:4373]', t='Fix_Shoulder_L_Components', v=True,q=True)
				vetexFullPath = mesh + '.vtx[' + str(idx) + ']'
				
				totalWeight_ori = 0
				jntWeight = []
				for b in srcBones:
					w = cmds.skinPercent(SkinCluster,vetexFullPath, t=b, v=True,q=True)
					totalWeight_ori += w
					jntWeight.append([b,0.0])
					
				oriW = cmds.skinPercent(SkinCluster,vetexFullPath, t=dectBone, v=True,q=True)
				jntWeight.append([dectBone, totalWeight_ori + oriW])
				
				cmds.select(d=True)
				cmds.select(vetexFullPath)
				cmds.skinPercent(SkinCluster, tv=jntWeight)
				
				# 進度+1
				cmds.progressBar(gMainProgressBar,edit=True, step=1)
			
			cmds.progressBar(gMainProgressBar,edit=True, endProgress=True)
			cmds.select(d=True) #取消選取
			cmds.select(actVetices)

	def autoSequenceWeight(self):
		selList = cmds.ls(sl=True)
		selectCount = len(selList)
		if selectCount > 2:
			if checkMeshVertex(selList[0]) and (cmds.objectType(selList[-1]) == 'joint'):
				dr = self.spASWDiatanceRatio.value()
				mesh = getTransform(selList[0])
				actBoneList = []

				i = len(selList) - 1
				while True:
					if cmds.objectType(selList[i]) == 'joint':
						actBoneList.insert(0,selList[i])
						i -= 1
					else : break

				actVtxList = selList[:i+1]
				# print(actVtxList)
				# print(actBoneList)
				histList = cmds.listHistory(mesh, pdo=True)
				SkinCluster = cmds.ls(histList,type='skinCluster')

				if len(SkinCluster) > 0:
					SkinCluster = SkinCluster[0]
					cmds.setAttr(SkinCluster+'.normalizeWeights', 0)
					listBoneInfo = []
					avgLength = -1
					for i in range(len(actBoneList)):
						if i < (len(actBoneList) - 2):
							p1 = dt.Vector(cmds.xform(actBoneList[i], q=True, ws=True, t=True))
							p2 = dt.Vector(cmds.xform(actBoneList[i+1], q=True, ws=True, t=True))
							vec = p2 - p1
							length = vec.length()
							if avgLength > 0:
								avgLength += (length - avgLength)*0.5
							else:
								avgLength = length

							if i == 0:
								nrm = vec.normal()
							else:
								p0 = dt.Vector(cmds.xform(actBoneList[i-1], q=True, ws=True, t=True))
								vec0 = p1 - p0
								nrm = (vec.normal() + vec0.normal()).normal()
						else:
							p0 = dt.Vector(cmds.xform(actBoneList[i-1], q=True, ws=True, t=True))
							p1 = dt.Vector(cmds.xform(actBoneList[i], q=True, ws=True, t=True))
							vec0 = p1 - p0
							length = 0
							nrm = vec0.normal()

						listBoneInfo.append([actBoneList[i], length, nrm])

					maxLength = avgLength * self.spASWDiatanceRatio.value()
					
					vIdxList = []
					for vDef in actVtxList:
						vIdxList.extend(getVertexIdx(vDef))

					gMainProgressBar = mel.eval('$tmp = $gMainProgressBar')
					cmds.progressBar(gMainProgressBar,edit=True, beginProgress=True, isInterruptable=True, status='Max Bones Rematch', maxValue=(len(vIdxList)))

					for idx in vIdxList:
						vtx = mesh + '.vtx[' + str(idx) + ']'
						# vPos = cmds.xform(vtx,q=True,ws=True,t=True)

						rightSideList = []
						leftSideList = []
						
						for bf in listBoneInfo:
							xPos = getDistanceToPlane(bf[0],bf[2],vtx)
							# print(xPos)
							if xPos >= 0:
								rightSideList.insert(0, [bf[0], bf[1], xPos])
							else:
								leftSideList.append([bf[0], bf[1], xPos])

						boneRatioList = []
						# stackLengthLeft = 0
						for b in rightSideList:
							idx = rightSideList.index(b)
							if idx == 0:
								boneRatioList.append([b[0], 1])
							else:
								# stackLengthLeft += b[1]
								dis = abs(b[2]) - b[1]
								res = (maxLength - abs(dis))/maxLength
								res = 1.0 if res > 1.0 else res
								res = 0.0 if res < 0.0 else res
								res*=res
								boneRatioList.append([b[0], res])
								

						stackLengthRight = 0
						for b in leftSideList:

							dis = abs(b[2])
							# print(b[0]+' distance is '+str(dis))

							res = (maxLength - abs(dis))/maxLength
							res = 1.0 if res > 1.0 else res
							res = 0.0 if res < 0.0 else res
							res*=res
							boneRatioList.append([b[0], res])
							# stackLengthRight += b[1]

						# print(rightSideList)
						# print(leftSideList)
						# print(boneRatioList)
						sumBR = 0
						for br in boneRatioList:
							sumBR += br[1]

						weightList = []
						for br in boneRatioList:
							weightList.append([br[0], br[1]/sumBR])

						skinBoneList = cmds.skinPercent(SkinCluster, vtx, query=True, transform=None)

						oriWeightList = cmds.skinPercent( SkinCluster, vtx, query=True, value=True )
						for j in range(len(oriWeightList)):
							if oriWeightList[j] > 0:
								if not (skinBoneList[j] in actBoneList):
									weightList.append([skinBoneList[j], 0.0])

						cmds.select(d=True)
						cmds.select(vtx)
						cmds.skinPercent(SkinCluster, tv=weightList)

						# # 進度+1
						cmds.progressBar(gMainProgressBar,edit=True, step=1)


					cmds.setAttr(SkinCluster+'.normalizeWeights', 1)
					cmds.progressBar(gMainProgressBar,edit=True, endProgress=True)
					cmds.select(d=True) #取消選取
					cmds.select(actVtxList)

			else:
				cmds.confirmDialog(title='錯誤'.decode("utf-8"), message='你必須選擇有用Skin的點，並在最後依序選取要作用的bone joint'.decode("utf-8"), button='確認'.decode("utf-8"))

		pass
#-------------------------------------------------#
'''
if __name__ == "__main__":
	try:
		test_ui.deleteLater()
	except:
		pass
	
	# Create minimal UI object
	test_ui = SkinWeightTool()
	
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
	SWTool_ui = SkinWeightTool()