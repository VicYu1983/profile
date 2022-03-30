#-*- coding:utf-8 -*- 
import maya.cmds as cmds
import inspect
import pymel.core as pm

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

from collections import OrderedDict

import math

import maya.OpenMayaUI as omui
import maya.mel as mel
import os
import os.path
from os import listdir
from os.path import isfile, join
import re
import shutil
import AS_MotionConstrain as ASC
reload(ASC)
import AS_MotionConstrain_quad as ASCQ
import utilities as utils
import Helper

def getMainNameSpace():
	ns = cmds.namespaceInfo(lon=True)
	# ns = ns[0:-2][0] + ':'
	if len(ns) > 2:
		return ns[0:-2][0] + ':'
	else:
		return ''

# 依據node 找skin node 找mesh
def getRefSkinMesh(nd): # nd = "man_rig_v06:Root_M"
	ch_1lst = cmds.listConnections(nd,d=True)
	sknLst=[]
	meshLst=[]
	for chi in ch_1lst:
		if(cmds.nodeType(chi) == "skinCluster"):
			if( not (chi in sknLst)):
				sknLst.append(chi)
	for sk in sknLst: #sk=sknLst[0]
		rlst = cmds.listConnections(sk,d=True)
		for rh in rlst :#sh = shlst[0]
			shps = cmds.listRelatives(rh,s=True)
			if(shps!=None):
				if(not (rh in meshLst)):
					meshLst.append(rh)
	return meshLst

def getRefSkinSkeleton(nd): # nd = "man_rig_v06:Root_M"
	ch_1lst = cmds.listConnections(nd,d=True)
	sknLst=[]
	jntLst=[]
	for chi in ch_1lst:
		if(cmds.nodeType(chi) == "skinCluster"):
			if( not (chi in sknLst)):
				sknLst.append(chi)
	for sk in sknLst: #sk=sknLst[0]
		rlst = cmds.listConnections(sk,d=True)
		for rh in rlst :#rh = rlst[0]
			if(cmds.nodeType(rh)=="joint"):
				if( not (rh in jntLst)):
					jntLst.append(rh)
	return jntLst

def maya_main_window():
	main_window_ptr = omui.MQtUtil.mainWindow()
	return wrapInstance(long(main_window_ptr), QWidget)

class BatchAnmExpTools(QDialog):
	# width = 500
	# height = 200

	srcPath_edit = QLineEdit('')
	expPath_edit = QLineEdit('D:/FOD2/Art_WorkData_M3/Animation/00_Hero/')
	# cbUseCina

	AnmSegTree = QTreeView()
	AnmSegMod = QStandardItemModel()

	actSegRow = -1

	def __init__(self, parent=maya_main_window()):
		self.closeExistingWindow()
		super(BatchAnmExpTools, self).__init__(parent)
		self.create()

	def __del__(self):
		pass
		
	def closeExistingWindow(self):
		try:
			for qt in maya_main_window().findChildren(QDialog):
				if qt.__class__.__name__ == self.__class__.__name__:
					qt.close()
					qt.deleteLater()
		except:
			pass

	def create(self):
		self.setWindowTitle('批次Anm FBX輸出工具'.decode("utf-8"))
		self.setWindowFlags(QtCore.Qt.Tool)
		self.setMinimumSize(400,200)

		self.create_controls()
		self.create_layout()
		self.readConfig()
		self.create_connections()
		self.show()

	def readConfig(self):
		srcPath = ''
		expPath = 'D:/FOD2/Art_WorkData_M3/Animation/00_Hero/'

		try:
			if not cmds.optionVar( exists='jfAnmMayaFilePath' ):
				cmds.optionVar(sv = ('jfAnmMayaFilePath', srcPath))
			else:
				srcPath = cmds.optionVar(q='jfAnmMayaFilePath')
			
			if not cmds.optionVar( exists='asMotionExLoc' ):
				cmds.optionVar(sv = ('asMotionExLoc', expPath))
			else:
				expPath = cmds.optionVar(q='asMotionExLoc')
		except:
			pass

		self.srcPath_edit.setText(srcPath)
		self.expPath_edit.setText(expPath)
		pass

	def create_controls(self):
		# self.model0.setHorizontalHeaderLabels(['部位元件'.decode("utf-8"),'指定模型'.decode("utf-8")])
		# AnmSegMod = QStandardItemModel()
		# AnmSegMod.setHorizontalHeaderLabels(['部位元件'.decode("utf-8"),'指定模型'.decode("utf-8")])
		# _si = QStandardItem('test')
		# _si1 = QStandardItem('test1')
		# AnmSegMod.appendRow(_si)
		# AnmSegMod.appendRow(_si1)

		self.btnBatchExp = QPushButton('批次 Anim FBX 輸出'.decode('utf-8'))

		self.AnmSegMod.setHorizontalHeaderLabels(['start','end','name'])
		self.AnmSegTree.setModel(self.AnmSegMod)
		self.AnmSegTree.setUniformRowHeights(True)
		
		# btnTest = QPushButton('上吧皮卡丘'.decode("utf-8"), self)
		# btnTest.move(10, 120)
		# btnTest.clicked.connect(self.doTest)
		pass

	def create_fightingRefList(self, createInfo):

		def clearLayout(layout):
			if layout is not None:
				while layout.count():
					child = layout.takeAt(0)
					if child.widget() is not None:
						child.widget().deleteLater()
					elif child.layout() is not None:
						clearLayout(child.layout())
						
		def createOneRoleSetting( id, ref ):
			oriMax = cmds.playbackOptions(q=True, max=True)
			oriMin = cmds.playbackOptions(q=True, min=True)

			hbox = QHBoxLayout()

			ipt_file = QLineEdit()
			ipt_file.setMinimumSize( 150, 0 )
			ipt_file.setPlaceholderText(u'檔案名稱')
			def onIptFileChange(text):
				print("onIptFileChange", id, text)
				createInfo[2][id][0] = text
			ipt_file.textEdited.connect(onIptFileChange)
			hbox.addWidget(ipt_file)

			spr_start = QSpinBox()
			spr_start.setMaximum( 100000 )
			def onSprStartChange(text):
				createInfo[2][id][1] = text
			spr_start.valueChanged.connect(onSprStartChange)
			spr_start.setValue(oriMin)
			hbox.addWidget(spr_start)

			spr_end = QSpinBox()
			spr_end.setMaximum( 100000 )
			def onSprEndChange(text):
				createInfo[2][id][2] = text
			spr_end.valueChanged.connect(onSprEndChange)
			spr_end.setValue(oriMax)
			hbox.addWidget(spr_end)

			ipt_role = QLineEdit()
			ipt_role.setText(ref)
			ipt_role.setReadOnly(True)
			hbox.addWidget( ipt_role )

			chk_zero = QCheckBox(u"原點")
			def onChkZeroChange(value):
				createInfo[2][id][4] = "1" if value else "0"
			chk_zero.stateChanged.connect(onChkZeroChange)
			hbox.addWidget(chk_zero)

			chk_turn = QCheckBox(u"對手")
			def onChkTurnChange(value):
				createInfo[2][id][5] = "1" if value else "0"
			chk_turn.stateChanged.connect(onChkTurnChange)
			hbox.addWidget(chk_turn)

			chk_rotateRootCtrl = QCheckBox(u'旋轉蛋')
			def onChkRotateRootCtrl(value):
				createInfo[2][id][6] = "1" if value else "0"
			chk_rotateRootCtrl.stateChanged.connect(onChkRotateRootCtrl)
			hbox.addWidget(chk_rotateRootCtrl)

			chk_out = QCheckBox(u"輸出")
			def onChkOutChange(value):
				createInfo[2][id][7] = "1" if value else "0"
			chk_out.stateChanged.connect(onChkOutChange)
			hbox.addWidget(chk_out)

			btn_copy = QPushButton(u'複製')
			btn_copy.setMaximumWidth( 50 )
			def onBtnCopyClick():
				insertData = [value for value in createInfo[2][id]]
				createInfo[2].insert(id, insertData)
				self.create_fightingRefList(createInfo)
			btn_copy.clicked.connect(onBtnCopyClick)
			hbox.addWidget( btn_copy )

			btn_remove = QPushButton(u'刪除')
			btn_remove.setMaximumWidth( 50 )
			def onBtnRemoveClick():
				createInfo[2].remove(createInfo[2][id])
				self.create_fightingRefList(createInfo)

			btn_remove.clicked.connect(onBtnRemoveClick)
			hbox.addWidget( btn_remove )

			btn_pick = QPushButton(u'選取')
			btn_pick.setMaximumWidth( 50 )
			hbox.addWidget( btn_pick )

			def onBtnPickClick():
				try:
					ns = cmds.referenceQuery(ref, namespace = 1)
					cmds.select("%s:root" % ns)
				except:
					print(ref + " has no reference!")
			btn_pick.clicked.connect(onBtnPickClick)

			return hbox, ipt_file, spr_start, spr_end, ipt_role, chk_zero, chk_turn, chk_rotateRootCtrl, chk_out

		clearLayout(self.refListBox)
		
		cloth = createInfo[0]
		rebake = createInfo[1]

		self.chk_cloth.setChecked(True if cloth == '1' else False)
		self.chk_rebake.setChecked(True if rebake == '1' else False)

		self.ipt_files = []
		self.ipt_roles = []
		self.spr_starts = []
		self.spr_ends = []
		self.chk_zeros = []
		self.chk_turns = []
		self.chk_rotateRootCtrls = []
		self.chk_outs = []
		self.refList = []

		for i, [filename, start, end, ref, zero, turn, rotateRootCtrl, out] in enumerate(createInfo[2]):
			hbox, ipt_file, spr_start, spr_end, ipt_role, chk_zero, chk_turn, chk_rotateRootCtrl, chk_out = createOneRoleSetting(i, ref)

			ipt_file.setText(filename)
			spr_start.setValue(int(start))
			spr_end.setValue(int(end))

			chk_zero.setChecked( True if zero == "1" else False )
			chk_turn.setChecked( True if turn == "1" else False )
			chk_rotateRootCtrl.setChecked( True if rotateRootCtrl == "1" else False )
			chk_out.setChecked( True if out == "1" else False )

			self.ipt_files.append(ipt_file)
			self.ipt_roles.append(ipt_role)
			self.spr_starts.append(spr_start)
			self.spr_ends.append(spr_end)
			self.chk_zeros.append(chk_zero)
			self.chk_turns.append(chk_turn)
			self.chk_rotateRootCtrls.append(chk_rotateRootCtrl)
			self.chk_outs.append(chk_out)
			self.refListBox.addLayout(hbox)

			self.refList.append( ref )	

	def create_layout(self):
		self.setStyleSheet("*{font: 12px Microsoft JHengHei, sans-serif;}")

		def setTableSize(width, height):
			self.setMinimumWidth(width)
			self.setMaximumWidth(width)
			self.setMinimumHeight(height)
			self.setMaximumHeight(height)

			tabWidget.setMinimumWidth(width)
			tabWidget.setMaximumWidth(width)
			tabWidget.setMinimumHeight(height)
			tabWidget.setMaximumHeight(height)

		def onWidgetChange(idx):
			if idx == 0:
				setTableSize(500, 200)

			elif idx == 1:
				setTableSize(320, 200)
				self.loadAnmSeg()
			elif idx == 2:
				setTableSize(800, 500)
				self.loadFightAndCreateUI()

		tabWidget = QTabWidget(self)
		
		#tabWidget.setGeometry(0,0,500,200)
		tabWidget.currentChanged.connect(onWidgetChange)

		# 批次輸出FBX用面板 ===============================
		BatchExp_tab = QWidget()
		tabWidget.addTab(BatchExp_tab, '批次輸出FBX'.decode('utf-8'))

		self.srcPath_edit.setParent(BatchExp_tab)
		self.srcPath_edit.setGeometry(10,24,476, 20)

		self.expPath_edit.setParent(BatchExp_tab)
		self.expPath_edit.setGeometry(10,76,476, 20)

		self.btnBrowserSrc = QPushButton('Browse', BatchExp_tab)
		self.btnBrowserSrc.setGeometry(424, 4, 60, 16)

		self.btnBrowserExp = QPushButton('Browse', BatchExp_tab)
		self.btnBrowserExp.setGeometry(424, 56, 60, 16)

		lbBrowseSrc = QLabel('動作來源路徑 :'.decode('utf-8'), BatchExp_tab)
		lbBrowseSrc.move(10, 6)

		lbBrowseExp = QLabel('輸出Anim FBX路徑 :'.decode('utf-8'), BatchExp_tab)
		lbBrowseExp.move(10, 58)

		self.btnBatchExp.setParent(BatchExp_tab)
		self.btnBatchExp.setGeometry(150, 110, 200, 45)

		# 動作分割用面板 ===============================
		AnmSplit_tab = QWidget()
		tabWidget.addTab(AnmSplit_tab, '動作分割'.decode('utf-8'))

		self.AnmSegTree.setColumnWidth(0, 60)
		self.AnmSegTree.setColumnWidth(1, 50)

		self.AnmSegTree.setParent(AnmSplit_tab)
		self.AnmSegTree.setGeometry(10, 10, 296, 100)
		self.AnmSegTree.setStyleSheet("QTreeView:focus{border: 1px solid #000;}QTreeView{border: 1px solid #000;}")

		self.btnAddSeg = QPushButton('+', AnmSplit_tab)
		self.btnAddSeg.setGeometry(10, 116, 20, 20)

		self.btnReduceSeg = QPushButton('-', AnmSplit_tab)
		self.btnReduceSeg.setGeometry(10, 140, 20, 20)

		self.btnClearSeg = QPushButton('Clear\nAll', AnmSplit_tab)
		self.btnClearSeg.setGeometry(34, 116, 44, 44)

		self.btnLoadSeg = QPushButton('讀取'.decode('utf-8'), AnmSplit_tab)
		self.btnLoadSeg.setGeometry(172, 116, 60, 44)

		self.btnWriteSeg = QPushButton('寫入'.decode('utf-8'), AnmSplit_tab)
		self.btnWriteSeg.setGeometry(236, 116, 70, 44)

		self.btnExpAnmFbx = QPushButton('輸出分割\nFBX'.decode('utf-8'), AnmSplit_tab)
		self.btnExpAnmFbx.setGeometry(82, 116, 86, 44)

		# 對招用面板 ===============================
		FightSplitTab = QWidget()
		tabWidget.addTab(FightSplitTab, '對招'.decode('utf-8'))
		vbox = QVBoxLayout(FightSplitTab)

		lbInfo = QLabel(u'這個面板的列表數量是自動從reference列表抓取來的。可以點選【選取】按鈕來確定角色是誰\n對招時的主角只要勾選【原點】\n對招時的npc只要勾選【對手】\n記得要把【輸出】勾選，才會輸出\n【布料】是指要不要開啓布料模擬\n【再bake】是指程式會先bake一次，再執行輸出，避免有時正常輸出時模型扭曲的現象')
		lbInfo.setAlignment(QtCore.Qt.AlignCenter)
		vbox.addWidget(lbInfo)

		self.refListBox = QVBoxLayout()
		vbox.addLayout(self.refListBox)		

		hbox = QHBoxLayout()
		vbox.addLayout( hbox )

		self.chk_cloth = QCheckBox(u'布料')
		hbox.addWidget( self.chk_cloth )

		self.chk_rebake = QCheckBox(u'再bake')
		hbox.addWidget( self.chk_rebake )

		self.btn_clearFightSetting = QPushButton(u'回復預設值')
		hbox.addWidget( self.btn_clearFightSetting )

		self.btn_expFightSetting = QPushButton(u'輸出對招FBX')
		hbox.addWidget( self.btn_expFightSetting )

		self.btn_loadFightSetting = QPushButton(u'讀入')
		hbox.addWidget( self.btn_loadFightSetting )

		self.btn_saveFightSetting = QPushButton(u'儲存')
		hbox.addWidget( self.btn_saveFightSetting )

	def create_connections(self):
		self.srcPath_edit.textChanged.connect(self.doSrcPathTextChanged)
		self.btnBrowserSrc.clicked.connect(self.doBrowseSrcPathPressed)
		self.btnBrowserExp.clicked.connect(self.doBrowseExpPathPressed)
		self.btnBatchExp.clicked.connect(self.doBatchExpPressed)

		self.AnmSegTree.pressed.connect(self.doSelectAnmSeg)
		self.btnAddSeg.clicked.connect(self.addAnmSeg)
		self.btnReduceSeg.clicked.connect(self.reduceAnmSeg)
		self.btnClearSeg.clicked.connect(self.clearAnmSeg)
		self.btnLoadSeg.clicked.connect(self.loadAnmSeg)
		self.btnWriteSeg.clicked.connect(self.writeAnmSeg)
		self.btnExpAnmFbx.clicked.connect(self.doBtnExpAnmFbxPressed)
		self.AnmSegMod.itemChanged.connect(self.doTest)

		self.btn_clearFightSetting.clicked.connect( self.onBtnClearFightClick)
		self.btn_expFightSetting.clicked.connect( self.onBtnExpFightClick )
		self.btn_loadFightSetting.clicked.connect( self.loadFightAndCreateUI )
		self.btn_saveFightSetting.clicked.connect( self.writeFightInfo )
	
	def deleteOneRole(self, name):
		cmds.delete('%s:Group' % (name))

	def onBtnExpFightClick(self):
		confirm = Helper.showConfirmDialog(u'會解除特定對象的所有綁定，確定執行？\n 注意!此動作無法復原!')
		if confirm:
			success = self.doExpFightClick()
			if success:
				cmds.confirmDialog(title='完成'.decode('UTF-8'), message='輸出已完成.請注意,場景已被調整過,不要儲存!!!'.decode('UTF-8'), button='確認'.decode('UTF-8'))
			return success
		else:
			return False

	def doExpFightClick(self, outPath = ''):

		needExport = False
		for i in range(len(self.refList)):
			fileName = self.ipt_files[i].text()
			start = self.spr_starts[i].value()
			end = self.spr_ends[i].value()

			if start != 0 or end != 0:
				needExport = True
			
		if not needExport:
			cmds.confirmDialog(title=u'提示', message=u'沒有要輸出的角色', button=u'確認')
			return 

		saveFolder = self.getSaveFolder() if outPath == '' else outPath
		if saveFolder:
			cmds.currentTime(0)
			for i, ref in enumerate(self.refList):
				fileName = self.ipt_files[i].text()
				start = self.spr_starts[i].value()
				end = self.spr_ends[i].value()
				zero = self.chk_zeros[i].isChecked()
				isEnemy = self.chk_turns[i].isChecked()
				isRotateRootCtrl = self.chk_rotateRootCtrls[i].isChecked()
				isOut = self.chk_outs[i].isChecked()

				if not isOut:
					continue
				if start == 0 and end == 0:
					continue
				
				for ref2 in pm.listReferences():
					melstr = 'file -unloadReference "%s"' % (ref2.refNode.__str__())
					mel.eval(melstr)
				melstr = 'file -loadReferenceDepth "asPrefs" -loadReference "%s"' % (ref)
				mel.eval(melstr)

				ns = cmds.referenceQuery(ref, namespace = 1)

				clearRoleProxy = None
				if isEnemy:
					clearRoleProxy = ASC.setCharToZero(ns, start, end, True, isRotateRootCtrl )
				else:
					if zero:
						clearRoleProxy = ASC.setCharToZero(ns, start, end)

				self.exportFBXToFolder(saveFolder, start, end, fileName)
				if clearRoleProxy: clearRoleProxy()
			
			return True
		return False

	def onBtnClearFightClick(self):

		oriMax = cmds.playbackOptions(q=True, max=True)
		oriMin = cmds.playbackOptions(q=True, min=True)
		for i, ref in enumerate(self.refList):
			try:
				ns = cmds.referenceQuery(ref, namespace = 1)
			except:
				ns = 'please turn on reference'
			self.ipt_files[i].setText(ns.split(":")[-1])
			self.spr_starts[i].setValue(oriMin)
			self.spr_ends[i].setValue(oriMax)
			self.chk_zeros[i].setChecked(False)
			self.chk_turns[i].setChecked(False)
			self.chk_rotateRootCtrls[i].setChecked(False)
			self.chk_outs[i].setChecked(False)
		self.chk_cloth.setChecked(False)
		self.chk_rebake.setChecked(False)
		
	def closeEvent(self, event):
		self.deleteLater()

	#-------------------------
	# Event
	#-------------------------

	def loadFightAndCreateUI(self):
		createInfo = self.loadFightSetting()
		if not createInfo:
			oriMax = cmds.playbackOptions(q=True, max=True)
			oriMin = cmds.playbackOptions(q=True, min=True)

			newInfos = []
			refList = pm.listReferences()
			for ref in refList:
				try:
					ns = cmds.referenceQuery(ref.refNode.__str__(), namespace = 1)
				except RuntimeError:
					# 沒有在場景内，不加入
					continue

				newInfos.append([ns.split(":")[-1], oriMin, oriMax, ref.refNode.__str__(), 0, 0, 0, 0])
			createInfo = (0,0, newInfos)
		self.create_fightingRefList(createInfo)

	def loadFightSetting(self): 
		if not self.checkAnmSegInfo():
			return False

		ns = getMainNameSpace()
		mainCtrl = ns + 'Main'

		fightInfo = cmds.getAttr(mainCtrl+'.FightSettingInfo')
		if fightInfo:
			createInfo = []
			parseInfo = fightInfo[0].split(',')
			roleCount = int(parseInfo[0])
			cloth = parseInfo[1]
			rebake = parseInfo[2]
			try:
				for i in range(roleCount):
					fileName = parseInfo[i+3]
					start = int(parseInfo[i+roleCount+3])
					end = int(parseInfo[i+roleCount*2+3])
					role = parseInfo[i+roleCount*3+3]
					zero = parseInfo[i+roleCount*4+3]
					turn = parseInfo[i+roleCount*5+3]
					rotateRootCtrl = parseInfo[i+roleCount*6+3]
					out = parseInfo[i+roleCount*7+3]
					createInfo.append([fileName, start, end, role, zero, turn, rotateRootCtrl, out])
			except:
				print("invalid format, reset!")
				return None
			return (cloth, rebake, createInfo)
		return None
	def doSelectAnmSeg(self, val):
		self.actSegRow = val.row()
		pass

	def doTest(self, item):
		if item.column() == 0 or item.column() == 1:
			oriText = str(item.text())
			if (str.isdigit(oriText)):
				item.setText(str(int(oriText)))
			else:
				item.setText('0')
	
	def doSrcPathTextChanged(self, str):
		_str = str.replace('\\', '/')
		cmds.optionVar(sv = ('jfAnmMayaFilePath', _str))
		# self.srcPath_edit.setText(_str)

	def doExpPathTextChanged(self, str):
		_str = str.replace('\\', '/')
		cmds.optionVar(sv = ('asMotionExLoc', _str))
		pass

	def doBrowseSrcPathPressed(self):
		pathSrc = self.srcPath_edit.text()
		
		if os.path.isdir(pathSrc):
			actFolder = QFileDialog.getExistingDirectory(caption='選擇輸出目錄'.decode("utf-8"),dir=pathSrc)
		else:
			actFolder = QFileDialog.getExistingDirectory(caption='選擇輸出目錄'.decode("utf-8"))
		
		if not actFolder : return

		actFolder = actFolder.replace('\\', '/')
		if actFolder[-1] != '/' : actFolder += '/'

		self.srcPath_edit.setText(actFolder)
		pass

	def doBrowseExpPathPressed(self):
		pathExp = self.expPath_edit.text()
		
		if os.path.isdir(pathExp):
			actFolder = QFileDialog.getExistingDirectory(caption='選擇輸出目錄'.decode("utf-8"),dir=pathExp)
		else:
			actFolder = QFileDialog.getExistingDirectory(caption='選擇輸出目錄'.decode("utf-8"))
		
		if not actFolder : return

		actFolder = actFolder.replace('\\', '/')
		if actFolder[-1] != '/' : actFolder += '/'
		
		self.expPath_edit.setText(actFolder)
		pass

	def doBatchExpPressed(self):
		if not os.path.isdir(self.srcPath_edit.text()): return
		if not os.path.isdir(self.expPath_edit.text()): return
		
		_srcPath = self.srcPath_edit.text()
		_srcPath = _srcPath.replace('\\', '/')
		if _srcPath[-1] != '/' : _srcPath += '/'

		_expPath = self.expPath_edit.text()
		_expPath = _expPath.replace('\\', '/')
		if _expPath[-1] != '/' : _expPath += '/'

		allMayaFile = [ (join(_srcPath,f)) for f in listdir(_srcPath ) if ( (isfile(join(_srcPath,f))) and ((f[-3:]==".ma")or(f[-3:]==".mb")) ) ]
		
		for mFile in allMayaFile:
			cmds.file(mFile,open=True,force=True)

			# 先看看是不是對招檔案，是的話，輸出對招
			hasExportFight = self.loadFightSetting()
			if hasExportFight:
				self.doExpFightClick(_expPath)
			else:
			# 不是對招的話，就是原來的流程
				self.loadAnmSeg()
				self.expFbxSplitAnm(_expPath)

		cmds.confirmDialog(title='完成'.decode("utf-8"), message='輸出已完成'.decode("utf-8"), button='確認'.decode("utf-8"))

	def addAnmSeg(self):
		# self.checkAnmSegInfo()

		_si = QStandardItem()

		actIdx = self.AnmSegTree.currentIndex().row()
		if actIdx==-1:
			self.AnmSegMod.appendRow(_si)
		else:
			self.AnmSegMod.insertRow(actIdx+1,_si)
			pass
		pass

	def reduceAnmSeg(self):
		# self.checkAnmSegInfo()
		
		self.AnmSegMod.removeRow(self.AnmSegTree.currentIndex().row())
		pass

	def clearAnmSeg(self):
		# self.checkAnmSegInfo()

		for i in range(self.AnmSegMod.rowCount(), 0, -1):
			idx = i - 1
			self.AnmSegMod.removeRow(idx)
		pass

	def loadAnmSeg(self):
		if not self.checkAnmSegInfo():
			return

		self.clearAnmSeg()

		ns = getMainNameSpace()
		mainCtrl = ns + 'Main'

		segInfo = cmds.getAttr(mainCtrl+'.AnmSegInfo')
		if segInfo:
			for seg in segInfo:
				_start,_end,_name = seg.split(',')

				_itemStart = QStandardItem(_start)
				_itemEnd = QStandardItem(_end)
				_itemName = QStandardItem(_name)

				self.AnmSegMod.appendRow([_itemStart,_itemEnd,_itemName])

	def writeFightInfo(self):
		if not self.checkAnmSegInfo():
			return

		ns = getMainNameSpace()
		mainCtrl = ns + 'Main'

		savestr = "%i,%i,%i" % (len(self.ipt_files), 1 if self.chk_cloth.isChecked() else 0, 1 if self.chk_rebake.isChecked() else 0)
		for ipt_file in self.ipt_files:
			savestr = "%s,%s" % (savestr, ipt_file.text())

		for spr_start in self.spr_starts:
			savestr = "%s,%i" % (savestr, spr_start.value())

		for spr_end in self.spr_ends:
			savestr = "%s,%i" % (savestr, spr_end.value())

		for ipt_role in self.ipt_roles:
			savestr = "%s,%s" % (savestr, ipt_role.text())

		for chk_zero in self.chk_zeros:
			savestr = "%s,%i" % (savestr, 1 if chk_zero.isChecked() else 0)

		for chk_turn in self.chk_turns:
			savestr = "%s,%i" % (savestr, 1 if chk_turn.isChecked() else 0)
		
		for chk_rotateRootCtrl in self.chk_rotateRootCtrls:
			savestr = "%s,%i" % (savestr, 1 if chk_rotateRootCtrl.isChecked() else 0)

		for chk_out in self.chk_outs:
			savestr = "%s,%i" % (savestr, 1 if chk_out.isChecked() else 0)

		melstr = 'setAttr %s.FightSettingInfo -type stringArray 1 "%s";' % (mainCtrl, savestr)
		mel.eval( melstr )

		cmds.confirmDialog(title='完成'.decode("utf-8"), message='對招資訊已寫入'.decode("utf-8"), button='確認'.decode("utf-8"))

	def writeAnmSeg(self):
		if not self.checkAnmSegInfo():
			return

		ns = getMainNameSpace()
		mainCtrl = ns + 'Main'

		usfCount = 0
		infoTxt = ''
		for i in range(self.AnmSegMod.rowCount()):
			# _row = self.AnmSegMod.
			_start = str(self.AnmSegMod.item(i,0).text())
			_end   = str(self.AnmSegMod.item(i,1).text())
			_name  = str(self.AnmSegMod.item(i,2).text())

			if str.isdigit(_start) and str.isdigit(_end):
				usfCount += 1
				infoTxt += ' "' + _start + ',' + _end + ',' + _name + '"'

		if usfCount > 0: #表示填的資料算是合法的
			melStr_Base = 'setAttr ' + mainCtrl + '.AnmSegInfo -type stringArray ' + str(usfCount) + infoTxt + ';'
			mel.eval(melStr_Base)
			cmds.confirmDialog(title='完成'.decode("utf-8"), message='動作分割資訊已寫入'.decode("utf-8"), button='確認'.decode("utf-8"))
		elif self.AnmSegMod.rowCount() == 0:
			melStr_Base = 'setAttr ' + mainCtrl + '.AnmSegInfo -type stringArray ' + str(0) + '""' + ';'
			mel.eval(melStr_Base)
			cmds.confirmDialog(title='完成'.decode("utf-8"), message='空動作分割資訊已寫入'.decode("utf-8"), button='確認'.decode("utf-8"))
		else:
			cmds.confirmDialog(title='錯誤'.decode("utf-8"), message='你的動作分割資訊start & end都不是數字'.decode("utf-8"), button='確認'.decode("utf-8"))

	def exportFBXToFolder(self, actFolder, start = 0, end = 0, fileName = ''):
		oriAet = cmds.playbackOptions(q=True, aet=True)
		oriMax = cmds.playbackOptions(q=True, max=True)
		oriAst = cmds.playbackOptions(q=True, ast=True)
		oriMin = cmds.playbackOptions(q=True, min=True)

		actFolder = actFolder.replace('\\', '/')
		if actFolder[-1] != '/' : actFolder += '/'

		cmds.optionVar(sv=('asMotionExLoc', actFolder))

		# 如果fileName有值，代表是輸出單一指定角色，所以要吃設定值
		if fileName == '':
			self.expFbxSplitAnm(actFolder)
		else:
			self.expSingleFbxAnm(actFolder, start, end, fileName)

		cmds.playbackOptions(aet=oriAet)
		cmds.playbackOptions(max=oriMax)
		cmds.playbackOptions(ast=oriAst)
		cmds.playbackOptions(min=oriMin)

	def getSaveFolder(self):
		dfmotionExLoc = None
		try:dfmotionExLoc = cmds.optionVar( q='asMotionExLoc')
		except:pass
		if(dfmotionExLoc==0):
			dfmotionExLoc = 'D:/FOD2/Art_WorkData_M3/Animation/00_Hero/'
			cmds.optionVar(sv=('asMotionExLoc', dfmotionExLoc) )
		
		if os.path.isdir(dfmotionExLoc):
			actFolder = QFileDialog.getExistingDirectory(caption='選擇輸出目錄'.decode("utf-8"),dir=dfmotionExLoc)
		else:
			actFolder = QFileDialog.getExistingDirectory(caption='選擇輸出目錄'.decode("utf-8"))
		return actFolder

	def doBtnExpAnmFbxPressed(self):
		actFolder = self.getSaveFolder()
		if actFolder:
			self.exportFBXToFolder( actFolder )
			cmds.confirmDialog(title='完成'.decode("utf-8"), message='輸出已完成'.decode("utf-8"), button='確認'.decode("utf-8"))

	#----------------------
	# Functions
	#----------------------
	def checkAnmSegInfo(self):
		ns = getMainNameSpace()
		mainCtrl = ns + 'Main'
		
		if not cmds.objExists(mainCtrl):
			locator = cmds.spaceLocator()
			cmds.rename( locator, mainCtrl )

		if cmds.objExists(mainCtrl):
			if mel.eval('attributeExists "AnmSegInfo" ' + mainCtrl) == 0:
				cmds.addAttr(mainCtrl,ln='AnmSegInfo',dt='stringArray')
			if mel.eval('attributeExists "FightSettingInfo" ' + mainCtrl) == 0:
				cmds.addAttr(mainCtrl,ln='FightSettingInfo',dt='stringArray')
			return True

	def expFbxSplitAnm(self, outPath):
		segAnmList = []
		for i in range(self.AnmSegMod.rowCount()):
			_start = str(self.AnmSegMod.item(i,0).text())
			_end   = str(self.AnmSegMod.item(i,1).text())
			_name  = str(self.AnmSegMod.item(i,2).text())

			if str.isdigit(_start) and str.isdigit(_end) and len(_name) > 0:
				segAnmList.append([int(_start), int(_end), outPath+_name+'.fbx'])
		
		if len(segAnmList) > 0:
			self.expAnmFbx(segAnmList)
		else:
			_start = int(cmds.playbackOptions(q=True, min=True))
			_end = int(cmds.playbackOptions(q=True, max=True))

			fullFilePath = cmds.file(q=True,sn=True)
			_name = fullFilePath.split('/')[-1].split('.')[0]
			self.expSingleFbxAnm(outPath, _start, _end, _name)

	def expSingleFbxAnm(self, outPath, start, end, fileName):
		fullFilePath = cmds.file(q=True,sn=True)
		self.expAnmFbx([[start,end, outPath + fileName+'.fbx']])

	def GetClothCtrlNode(self) :
		ctrlNodes = []
		allNodes = cmds.ls(dag = True, type = 'transform', l = True)
		if (allNodes == None) :
			return ctrlNodes
		for node in  allNodes:
			if (node[(len(node) - 11) : len(node)] == 'ncloth_ctrl') : 
				ctrlNodes.append(node)
		return ctrlNodes

	def ClearClothKey(self, clothctrlNodes):
		for node in clothctrlNodes :
			cmds.cutKey(node, clear=1)

	def SetSimclothParamByShot(self, clothctrlNodes, startTime, endTime):
		for node in clothctrlNodes :
			allAttrs = cmds.listAttr(node, ud = True)
			if (allAttrs == None):
				continue
			try:
				for attr in allAttrs:
					if (attr == 'StartFrame'):
						cmds.setAttr(node + '.' + attr, startTime)
					else:
						attrTyp = cmds.getAttr(node + '.' + attr, typ = True)
						if (attrTyp == 'enum') :
							cmds.setAttr(node + '.' + attr, 1)
			except:
				print ('warn: set cloth param error ' + node)
		return
					
	def expAnmFbx(self, anmInfoList):

		allRefs = cmds.ls(rn=True)
		rootNds = []
		root_M_Nds = []

		for rfd in allRefs:
			if( (":root" in rfd) and 
				(len( rfd.split(':')[-1])==4 )and 
				(not "WP_" in rfd[:3])
			  ):
				_parent = cmds.listRelatives(rfd,p=True)
				if( _parent == None):	
					rootNds.append(rfd)
			if((":Root_M" in rfd) and (len( rfd.split(':')[-1])==6 )):
				root_M_Nds.append(rfd)

		if((len(rootNds)==0)or(len(root_M_Nds)==0)):
			System.Windows.Forms.MessageBox.Show("no ref node in scene !")
			return

		for anmInfo in anmInfoList:
			_startFrame, _endFrame, _filePath = anmInfo

			cmds.playbackOptions(aet=_endFrame)
			cmds.playbackOptions(max=_endFrame)
			cmds.playbackOptions(ast=_startFrame)
			cmds.playbackOptions(min=_startFrame)

			cmds.select(cl=True)
			cmds.select(rootNds[0])

			# 布料模擬
			if self.chk_cloth.isChecked():
				clothctrl = self.GetClothCtrlNode()
				self.ClearClothKey( clothctrl )
				self.SetSimclothParamByShot(clothctrl, _startFrame, _endFrame)
            
			# 先把骨頭bake，再輸出，可以解決有時候模型會扭曲的現象
			rebake = self.chk_rebake.isChecked()
			if rebake:
				cmds.bakeResults( rootNds[0],
						simulation=True,
						t=(_startFrame,_endFrame),
						hierarchy="below",
						sampleBy=1,
						disableImplicitControl=True,
						preserveOutsideKeys=True,
						sparseAnimCurveBake=False,
						removeBakedAttributeFromLayer=False,
						removeBakedAnimFromLayer=False,
						bakeOnOverrideLayer=False,
						minimizeRotation=True,
						controlPoints=False,
						shape=True)

			# 如果需要導出morph的key的資料的話，就打開以下三行
			# listToSelect = Helper.getSkelMesh( rootNds[0] )
			# cmds.select(cl=True)
			# cmds.select(listToSelect)

			# Geometry
			mel.eval("FBXExportSmoothingGroups -v true")
			mel.eval("FBXExportHardEdges -v false")
			mel.eval("FBXExportTangents -v false")
			mel.eval("FBXExportSmoothMesh -v true")
			mel.eval("FBXExportInstances -v false")

			# Animation
			mel.eval("FBXExportBakeComplexAnimation -v %s" % ("false" if rebake else "true") )
			mel.eval("FBXExportAnimationOnly -v false")
			mel.eval("FBXExportBakeComplexStart -v "+ str(_startFrame))
			mel.eval("FBXExportBakeComplexEnd -v "+ str(_endFrame))
			mel.eval("FBXExportBakeComplexStep -v 1")
			#mel.eval("FBXExportBakeResampleAll -v true")
			mel.eval("FBXExportUseSceneName -v false")
			mel.eval("FBXExportQuaternion -v euler")
			mel.eval("FBXExportShapes -v true")
			mel.eval("FBXExportSkins -v true")
			# Constraints
			mel.eval("FBXExportConstraints -v false")
			# Cameras
			mel.eval("FBXExportCameras -v false")
			# Lights
			mel.eval("FBXExportLights -v false")
			# Embed Media
			mel.eval("FBXExportEmbeddedTextures -v false")
			# Connections
			mel.eval("FBXExportInputConnections -v true")
			
			mel.eval("FBXExportFileVersion -v \"FBX201400\"")
			# Axis Conversion
			mel.eval("FBXExportUpAxis z")
			# Export!
			mel.eval('FBXExport -f "'+ _filePath +'" -s')


#===================================================================

def createUI():
	TO_ui = BatchAnmExpTools()
