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

import json
import math

import maya.OpenMayaUI as omui
import maya.mel as mel
import os
import os.path
import re
import tempfile
import shutil

fGracityAcc = 980.0

dictTimeRate = {
	'game':15,
	'film':24,
	'pal':25,
	'ntsc':30,
	'show':48,
	'palf':50,
	'ntscf':60,
	'millisec':100,
	'sec':1,
	'min':0.017,
	'hour':0.00028,
	'2fps':2,
	'3fps':3,
	'4fps':4,
	'5fps':5,
	'6fps':6,
	'8fps':8,
	'10fps':10,
	'12fps':12,
	'16fps':16,
	'20fps':20,
	'40fps':40,
	'75fps':75,
	'80fps':80,
	'100fps':100,
	'120fps':120,
	'125fps':125,
	'150fps':150,
	'200fps':200,
	'240fps':240,
	'250fps':250,
	'300fps':300,
	'375fps':375,
	'400fps':400,
	'500fps':500,
	'600fps':600,
	'750fps':750,
	'1200fps':1200,
	'1500fps':1500,
	'2000fps':2000,
	'3000fps':3000,
	'6000fps':6000
}

def maya_main_window():
	main_window_ptr = omui.MQtUtil.mainWindow()
	return wrapInstance(long(main_window_ptr), QtGui.QWidget)

class JFAnmRootTool(QtGui.QDialog):
	width = 320
	height = 160

	fGravityScl = 2.25
	fJumpHeight = 240

	fStartVec = 0
	fJumpTime = 0

	spnGravityScale = QtGui.QDoubleSpinBox()
	spnJumpMaxHeight = QtGui.QDoubleSpinBox()
	
	_bDesUpAxis = False
	_vUpAxis = 'z'

	cbUseCusUpAxis = QtGui.QCheckBox('指定朝上軸向'.decode("utf-8"))
	cbbUpAxis = QtGui.QComboBox()

	lbRootInfo = QtGui.QLabel()

	def __init__(self, parent=maya_main_window()):
		self.closeExistingWindow()
		super(JFAnmRootTool, self).__init__(parent)
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
		self.setWindowTitle('Root 小工具'.decode("utf-8"))
		self.setWindowFlags(QtCore.Qt.Tool)
		self.setMinimumSize(self.width,self.height)
		self.setMaximumSize(self.width,self.height)

		self.create_controls()
		self.create_layout()
		self.create_connections()
		self.updateJumpInfo()
		self.show()

	def create_controls(self):
		self.btnApplyHeightAnim = QtGui.QPushButton('套入跳躍拋物線資訊'.decode("utf-8"),self)
		pass

	def create_layout(self):
		self.setStyleSheet("*{font: 12px Microsoft JHengHei, sans-serif;}")

		lbGravityScl = QtGui.QLabel('重力倍率 :'.decode("utf-8"), self)
		lbGravityScl.move(20, 14)

		lbJumpHeight = QtGui.QLabel('跳躍高度 :'.decode("utf-8"), self)
		lbJumpHeight.move(20, 42)

		self.spnGravityScale.setParent(self)
		self.spnGravityScale.setGeometry(90, 10, 80, 24)
		self.spnGravityScale.setValue(2.25)

		self.spnJumpMaxHeight.setParent(self)
		self.spnJumpMaxHeight.setGeometry(90, 38, 80, 24)
		self.spnJumpMaxHeight.setRange(0.0,99999.0)
		self.spnJumpMaxHeight.setValue(240)

		lbFloatingTime = QtGui.QLabel('跳躍滯空時間 ->'.decode("utf-8"), self)
		lbFloatingTime.move(20, 70)

		self.cbUseCusUpAxis.setParent(self)
		self.cbUseCusUpAxis.move(190, 14)
		self.cbUseCusUpAxis.setChecked(False)

		self.cbbUpAxis.setParent(self)
		self.cbbUpAxis.addItem('y')
		self.cbbUpAxis.addItem('z')
		self.cbbUpAxis.setGeometry(205, 40, 75, 24)
		self.cbbUpAxis.setEnabled(False)

		self.lbRootInfo.setParent(self)
		self.lbRootInfo.move(120, 70)
		self.lbRootInfo.setText('--')


		self.btnApplyHeightAnim.setGeometry(40, 100, 240, 40)
		pass
	
	def create_connections(self):
		self.spnGravityScale.valueChanged.connect(self.doChangeGravityScl)
		self.spnJumpMaxHeight.valueChanged.connect(self.doChangeJumpHeight)

		self.btnApplyHeightAnim.clicked.connect(self.applyHightAnim)
		self.cbUseCusUpAxis.stateChanged.connect(self.doCusUpAxisChanged)

		pass

	def closeEvent(self, event):
		self.deleteLater()

	#-------------------------
	#
	#-------------------------
	@classmethod
	def doChangeGravityScl(self, val):
		self.fGravityScl = val
		self.updateJumpInfo()
		pass

	@classmethod
	def doChangeJumpHeight(self, val):
		self.fJumpHeight = val
		self.updateJumpInfo()
		pass

	@classmethod
	def updateJumpInfo(self):
		fGravity = self.fGravityScl * fGracityAcc
		self.fStartVec = math.sqrt( 2.0 * fGravity * self.fJumpHeight )
		self.fJumpTime = math.sqrt( ( 2.0 * self.fJumpHeight) / fGravity ) * 2.0
		
		FPS = dictTimeRate[cmds.currentUnit(q=True, t=True)]
		frames = int (self.fJumpTime * FPS + 0.5)

		txtRootInfo = ('%.3f' % self.fJumpTime) + '秒 ('.decode("utf-8") + str(frames) + ' frames in ' + str(FPS) + 'fps)'
		self.lbRootInfo.setText(txtRootInfo)

		pass

	@classmethod
	def doCusUpAxisChanged(self, val):
		self._bDesUpAxis = val
		self.cbbUpAxis.setEnabled(val)
		pass

	@classmethod
	def applyHightAnim(self):
		sList = cmds.ls(sl=True)
		

		if len(sList) == 1:
			obj = sList[0]

			currentTime = int(cmds.currentTime(q=True))
			FPS = dictTimeRate[cmds.currentUnit(q=True, t=True)]
			frames = int (self.fJumpTime * FPS + 0.5)
			fGravity = self.fGravityScl * fGracityAcc
			UpAxis = cmds.upAxis(q=True,ax=True)
			

			
			if self._bDesUpAxis:
				if self.cbbUpAxis.currentIndex() == 0:
					actAttr = '.translateY'
				else:
					actAttr = '.translateZ'
			else:
				if UpAxis == 'y':
					actAttr = '.translateY'
				else:
					actAttr = '.translateZ'

			cmds.cutKey(obj + actAttr)
			
			cmds.setKeyframe(obj + actAttr, time=currentTime, value=0.0)

			for i in range(1,frames):
				t = float(i) / FPS
				posH = self.fStartVec * t - 0.5 * fGravity * t * t
				cmds.setKeyframe(obj + actAttr, time=(currentTime + i), value=posH)

			cmds.setKeyframe(obj + actAttr, time=(currentTime + frames), value=0.0)
			pass

		pass
#===================================================================
if __name__ == "__main__":
	jfAnmRoot_ui = JFAnmRootTool()