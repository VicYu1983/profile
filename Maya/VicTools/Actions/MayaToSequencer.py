# -*- coding: utf-8 -*-
import maya.cmds as cmds
import maya.mel as mel
import json, os
import JointToController
reload(JointToController)
import Helper, GuiBase
import pymel.core as pm
import math

from PySide2.QtGui import *
from PySide2.QtWidgets import *

def OnBtnSelectAllShot():
    pass

def OnChangeExportAnim():
    pass

def OnChangeExportCameraAnim():
    pass

def OnBtnSelectAllCurrentShot():
    pass

def OnBtnUnSelectAllCurrentShot():
    pass

def OnBtnSelectAllShot():
    pass

def OnBtnUnSelectAllShot():
    pass

def OnBtnExport():
    pass 

def OnBtnAutoAplitAnimation():
    pass

def OnBtnResetAnimation():
    pass

def OnBtnSaveUiInfo():
    pass

def OnBtnChangeExportPath():
    pass

def OnBtnResetExportPath():
    pass

widgetData = {
    "comboAnchor":{"class":"QComboBox"},
	"comboShot":{"class":"QComboBox"},
	"lblAnchor":{"class":"QLabel", "content":u"錨點"},
	"lblShot":{"class":"QLabel", "content":u"鏡頭"},
	"lblActorInList":{"class":"QLabel", "content":u"當前鏡頭演員"},
	"lblActorAllShotInList":{"class":"QLabel", "content":u"所有鏡頭演員"},
	"chkCurr":{"class":"QCheckBox", "content":u"導出當前", "tip":u"只導出當前的鏡頭"},
	"chkVisibleKey":{"class":"QCheckBox", "content":u"包含visible key", "tip":u"包含物件上設定的visible key，不保證可以完全正確"},
	"chkExpAnim":{"class":"QCheckBox", "content":u"包含動畫", "tip":u"導出角色的fbx", "events":{"stateChanged":"OnChangeExportAnim"}},
	"chkExpCameraAnim":{"class":"QCheckBox", "content":u"包含camera動畫", "tip":u"導出camera的fbx", "events":{"stateChanged":"OnChangeExportCameraAnim"}},
	# "chkExpOnlyData":{"class":"QCheckBox", "content":u"僅導出文件", "tip":u"如果確定動畫都導完了，只是改鏡頭，那就可以勾這個選項。節省時間"},
    "btnSelectAll":{"class":"QPushButton", "content":u"當前全選", "tip":u"選擇當前鏡頭的全部角色", "events":{"clicked":"OnBtnSelectAllCurrentShot"}},
	"btnUnSelectAll":{"class":"QPushButton", "content":u"當前全反選", "tip":u"取消當前鏡頭的全部角色", "events":{"clicked":"OnBtnUnSelectAllCurrentShot"}},
	"btnSelectAllOnAllShots":{"class":"QPushButton", "content":u"全選", "tip":u"選擇當前鏡頭的全部角色", "events":{"clicked":"OnBtnSelectAllShot"}},
	"btnUnSelectAllOnAllShots":{"class":"QPushButton", "content":u"全反選", "tip":u"取消當前鏡頭的全部角色", "events":{"clicked":"OnBtnUnSelectAllShot"}},
	"btnExport":{"class":"QPushButton", "content":u"導出", "tip":u"開始導出", "events":{"clicked":"OnBtnExport"}},
	# "btnImportCamera":{"class":"QPushButton", "content":u"ue4導囘maya(camera)", "tip":u"ue4導回maya的功能，此功能目前只改變camera及角色的位置及旋轉", "events":{"clicked":"OnBtnImportCamera"}},
	# "btnImport":{"class":"QPushButton", "content":u"ue4導囘maya", "tip":u"ue4導回maya的功能，此功能目前只改變camera及角色的位置及旋轉", "events":{"clicked":"OnBtnImport"}},
	"btnSaveUI":{"class":"QPushButton", "content":u"儲存界面資料", "tip":u"儲存設定", "events":{"clicked":"OnBtnSaveUiInfo"}},
	# "btnExportShotCamera":{"class":"QPushButton", "content":u"導出場次鏡頭", "tip":u"導出鏡頭", "events":{"clicked":"OnBtnExportShotCamera"}},
	"btnChangePath":{"class":"QPushButton", "content":u"變更導出路徑", "tip":u"變更導出路徑", "events":{"clicked":"OnBtnChangeExportPath"}},
	"btnResetPath":{"class":"QPushButton", "content":u"重置導出路徑", "tip":u"重置導出路徑", "events":{"clicked":"OnBtnResetExportPath"}},
	"btnAutoSplitAnimation":{"class":"QPushButton", "content":u"自動切分角色動作分段", "tip":u"", "events":{"clicked":"OnBtnAutoAplitAnimation"}},
	"btnResetAnimation":{"class":"QPushButton", "content":u"調整為整段輸出", "tip":u"", "events":{"clicked":"OnBtnResetAnimation"}},
    "actorTableList":{"class":"QTableWidget", "params":{"setMinimumSize":[300,250]}},
	"lblExportPath":{"class":"QLabel", "content":""},
}

layoutData = {
	"":[
		["lblAnchor","comboAnchor"],
		["lblShot","comboShot"],
        # ["lblActorInList", "btnSelectAll", "btnUnSelectAll"],
		["lblActorAllShotInList", "btnSelectAllOnAllShots", "btnUnSelectAllOnAllShots"],
        ["actorTableList"],
		["chkExpCameraAnim", "chkExpAnim", "chkVisibleKey", "btnExport"],
		# ["chkCurr", "chkExpAnim", "chkExpOnlyData", "btnExport"],
    ],
	u"設定":[
		#["btnSaveUI", "btnExportShotCamera"],
		['btnAutoSplitAnimation', 'btnResetAnimation'],
		["btnSaveUI", "btnChangePath", "btnResetPath"],
		
		["lblExportPath"]
	],
}

ui = GuiBase.BasicUI(u'Maya To Sequencer', False)
widgets = ui.generateUIByConfig(widgetData, layoutData, globals() )

comboAnchor = widgets["comboAnchor"]
comboShot = widgets["comboShot"]
chkExpAnim = widgets["chkExpAnim"]
chkExpCameraAnim = widgets["chkExpCameraAnim"]
chkVisibleKey = widgets["chkVisibleKey"]
# chkCurr = widgets["chkCurr"]
# chkExpOnlyData = widgets["chkExpOnlyData"]

lblExportPath = widgets["lblExportPath"]
lblExportPath.setText('exporter.GetFbxExportPath()')

actorTableList = widgets["actorTableList"]
actorTableList.header = [u'角色',u'開始幀',u'結束幀']
actorTableList.setColumnCount(len(actorTableList.header))
actorTableList.setHorizontalHeaderLabels(actorTableList.header)
actorTableList.resizeColumnsToContents()

""" 新增資料的時候，如果有預設值，再新增該項目的時候，會被排序機制影響導致該項目之後的項目設值不正確。爲了不產生新的bug，就不設置預設值了 """
actorTableList.setSortingEnabled(0)
actorTableList.setAlternatingRowColors(True)



# anchors = anchorMgr.GetAnchorNames()
# for anchor in anchors: comboAnchor.addItem(anchor)

# shots = exporter.shotMgr.GetShotNames()
# for shot in shots: comboShot.addItem(shot)

# comboAnchor.currentIndexChanged.connect(OnSelectedChanged)
# comboShot.currentIndexChanged.connect(OnChangeShot)
# actorTableList.itemChanged.connect(OnChangeShotActorMap)

# OnSelectedChanged(0)
# RestoreUIInfo()