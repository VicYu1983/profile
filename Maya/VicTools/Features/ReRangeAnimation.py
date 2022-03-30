# -*- coding: utf-8 -*-
import maya, mutils, json
import maya.cmds as cmds
import maya.mel as mel
import maya.api.OpenMaya as om
import pymel.core as pm
import pymel.core.datatypes as dt
import Helper
reload(Helper)

import GuiBase
from PySide2.QtGui import *
from PySide2.QtWidgets import *

import AllCommand

widgetData = {
    "comboRole":{"class":"QComboBox"},

    "btnAdd":{"class":"QPushButton", "content":u"新增", "tip":u"新增一個任務", "events":{"clicked":"addItem"}},
    "btnRemove":{"class":"QPushButton", "content":u"刪除", "tip":u"刪除選定任務：點選要刪除的任務之後再點擊此按鈕", "events":{"clicked":"removeItem"}},
    "btnClear":{"class":"QPushButton", "content":u"清除列表", "tip":u"清空所有任務", "events":{"clicked":"clearItems"}},
    "btnGrabRole":{"class":"QPushButton", "content":u"抓取角色", "tip":u"點選角色欄位后，再點選這個按鈕即可抓取", "events":{"clicked":"grabRoleName"}},
    "btnGrabPose":{"class":"QPushButton", "content":u"抓取動作", "tip":u"點選動作欄位，在studio library點選pose，再點選這個按鈕即可抓取", "events":{"clicked":"grabPoseName"}},

    "tableList":{"class":"QTableWidget", "params":{"setMinimumSize":[800,200]}},
    "btnSaveBatchInfo":{"class":"QPushButton", "content":u"儲存設定(動畫輸出工具)", "tip":u"把設定存給動畫輸出工具輸出用", "events":{"clicked":"saveInfo"}},
    "btnSave":{"class":"QPushButton", "content":u"儲存設定檔", "tip":u"存成外部的文字檔", "events":{"clicked":"saveJson"}},
    "btnLoad":{"class":"QPushButton", "content":u"讀取設定檔", "tip":u"讀取外部的文字檔", "events":{"clicked":"loadJson"}},
    "btnExecute":{"class":"QPushButton", "content":u"運行", "tip":u"開始執行任務", "events":{"clicked":"execute"}},
}

layoutData = {
    "Edit":[
        ["comboRole", "btnGrabRole", "btnGrabPose"]
    ],
    "List":[
        ["btnAdd", "btnRemove", "btnClear"],
        ["tableList"],
        ["btnLoad", "btnSave", "btnSaveBatchInfo"],
        ["btnExecute"]
    ]
}

from studiolibrary import librarywindow

def getUsingPoseFromTo(startGap, endGap, endFrom, endTo ):
    usingFrom = 0
    usingTo = 0
    usingPoseFrom = 0
    usingPoseTo = 0
    if startGap > 0:
        usingFrom = endFrom + startGap
        usingPoseFrom = endFrom
    else:
        usingFrom = endFrom
        usingPoseFrom = endFrom + startGap

    if endGap > 0:
        usingTo = endTo - endGap
        usingPoseTo = endTo
    else:
        usingTo = endTo
        usingPoseTo = endTo - endGap
    return [usingFrom, usingTo, usingPoseFrom, usingPoseTo]

def execute():

    def setKeyOnPoseCtrls(posePath):
        mutils.SelectionSet.fromPath(posePath + "/pose.json").select()
        ctrls = cmds.ls(sl=1)
        for ctrl in ctrls:
            for attr in ("rotate", "translate", "FKIKBlend"):
                try:
                    cmds.setKeyframe( ctrl+"." + attr )
                except: pass

    def loadPoseAndSetKey(role, frame, poseFrame, posePath, nn ):
        cmds.currentTime(frame)
            
        # ====================
        # 這裏要取得定位pose的蛋形和腰部控制器的相對矩陣
        # 再用這個相對矩陣算出要銜接的動畫的前端和尾端的腰部的位置
        # ====================

        rootXM = role + ":RootX_M"

        # 取出目前要銜接的動作的蛋形矩陣
        rootCtrl = role + ":Root_M"
        frameRootCtrl_mat = cmds.xform(rootCtrl, ws=1, m=1,q=1)
        frameRootCtrl_mat_om = Helper.getOpenMayaMatrix(frameRootCtrl_mat)

        # 跳到設定定位動作的frame
        cmds.currentTime(poseFrame)
        print( "key pose key on ", poseFrame)
        
        # 讀取定位動作
        pose = mutils.Pose.fromPath(posePath + "/pose.json")
        pose.load()

        # 這個時候有了定位動作后，開始算蛋形和腰部控制器的相對矩陣
        rootXM_mat = cmds.xform(rootXM, ws=1, m=1,q=1)
        rootCtrl_mat = cmds.xform(rootCtrl, ws=1, m=1,q=1)

        # 轉成可以矩陣運算的openMaya的形式
        rootXM_mat_om = Helper.getOpenMayaMatrix(rootXM_mat)
        rootCtrl_mat_om = Helper.getOpenMayaMatrix(rootCtrl_mat)

        # 算出蛋形到腰部的相對轉換矩陣
        diffFromCtrlToXM_mat_om = rootXM_mat_om * rootCtrl_mat_om.inverse()

        # 把轉換矩陣乘上要銜接的動作的蛋形矩陣，得出定位pose應該要在的腰部位置
        frameMat_om = diffFromCtrlToXM_mat_om * frameRootCtrl_mat_om
        frameMat = Helper.getMelMatrix(frameMat_om)

        # 把所有的ik控制器綁定在腰部控制器，跟著位移過去
        constrains = []
        ikNodes = Helper.getAllIKNode(role)
        for ikNode in ikNodes:
            if rootXM != ikNode:
                try:
                    constrains.append(cmds.parentConstraint(rootXM, ikNode, mo=True)[0])
                except:
                    print(ikNode + " is invalid node")

        # 把要match的pose的腰部調整到對應的位置
        cmds.xform(rootXM, ws=1, m=frameMat)

        setKeyOnPoseCtrls(posePath)
        cmds.delete(constrains)

    def safeKey(role, frame, poseFrame, posePath):
        print( "key safe key on ", frame)
        cmds.currentTime(frame)
        setKeyOnPoseCtrls(posePath)

    cacheFrame = 50000

    """ 把key先移到很後面的地方做保留 """
    for row in range(tableList.rowCount()):
        role = tableList.item(row, 0).text()
        startPose = tableList.item(row, 1).text()
        startFrom = int(tableList.item(row, 3).text())
        startTo = int(tableList.item(row, 4).text())
        
        ctrls = cmds.ls(role + ":*")
        cmds.scaleKey( ctrls, time=(startFrom,startTo), newStartTime=startFrom+cacheFrame, newEndTime=startTo+cacheFrame )

    """ 刪掉保留的key之外的所有key """
    for row in range(tableList.rowCount()):
        role = tableList.item(row, 0).text()
        ctrls = cmds.ls(role + ":*")
        cmds.cutKey( ctrls, time=(0,cacheFrame))

    
    infos = []
    for row in range(tableList.rowCount()):
        role = tableList.item(row, 0).text()
        startPose = tableList.item(row, 1).text()
        startGap = int(tableList.item(row, 2).text())
        startFrom = int(tableList.item(row, 3).text())
        startTo = int(tableList.item(row, 4).text())
        endPose = tableList.item(row, 5).text()
        endGap = int(tableList.item(row, 6).text())
        endFrom = int(tableList.item(row, 7).text())
        endTo = int(tableList.item(row, 8).text())
        
        """ 如果gap值為負。就改成外插blending動畫 """
        infos.append([role, startFrom, startTo, startPose, endPose] + getUsingPoseFromTo(startGap, endGap, endFrom, endTo))
    
    """ 再把保留的key移回來，并且先打上安全key，以免在調整時被影響動作"""
    for (role, startFrom, startTo, startPose, endPose, usingFrom, usingTo, usingPoseFrom, usingPoseTo) in infos:

        ctrls = cmds.ls(role + ":*")
        cmds.scaleKey( ctrls, time=(startFrom+cacheFrame,startTo+cacheFrame), newStartTime=usingFrom, newEndTime=usingTo )

        safeKey(role, usingFrom, usingPoseFrom, startPose)
        safeKey(role, usingTo, usingPoseTo, endPose)

    """ 有了安全key之後，再來插入pose并且打上key """
    for (role, startFrom, startTo, startPose, endPose, usingFrom, usingTo, usingPoseFrom, usingPoseTo) in infos:
        loadPoseAndSetKey(role, usingFrom, usingPoseFrom, startPose, "before")
        loadPoseAndSetKey(role, usingTo, usingPoseTo, endPose, "after") 

    Helper.fixEulerCurve()

def removeItem():
    if currentCell: 
        tableList.removeRow(currentCell[0])

        global currentCell
        currentCell = None

def clearItems():
    while(tableList.rowCount() > 0):
        tableList.removeRow(0)

def loadJson():

    def doAction(path):
        try:
            f = open(path[0], "r")
            jsonstr = f.read()
            f.close()
            inputData = json.loads(jsonstr)
        except:
            GuiBase.showMessage(u"選取檔案錯誤")
            return
        
        clearItems()

        list = inputData["list"]
        for item in list:
            currRow = tableList.rowCount()
            tableList.setRowCount(currRow+1)
            tableList.setItem(currRow, 0, QTableWidgetItem(item["name"]))
            tableList.setItem(currRow, 1, QTableWidgetItem(item["startpose"]))
            tableList.setItem(currRow, 2, QTableWidgetItem(item["startgap"]))
            tableList.setItem(currRow, 3, QTableWidgetItem(item["startfrom"]))
            tableList.setItem(currRow, 4, QTableWidgetItem(item["startto"]))
            tableList.setItem(currRow, 5, QTableWidgetItem(item["endpose"]))
            tableList.setItem(currRow, 6, QTableWidgetItem(item["endgap"]))
            tableList.setItem(currRow, 7, QTableWidgetItem(item["endfrom"]))
            tableList.setItem(currRow, 8, QTableWidgetItem(item["endto"]))
            tableList.resizeColumnsToContents()  
            
    GuiBase.openFileDialog(doAction, QFileDialog.AnyFile, "*.txt")

def saveJson():
    outputData = {"list":[]}
    for i in range(tableList.rowCount()):
        outputData["list"].append({
            "name":tableList.item(i, 0).text(),
            "startpose":tableList.item(i, 1).text(),
            "startgap":tableList.item(i, 2).text(),
            "startfrom":tableList.item(i, 3).text(),
            "startto":tableList.item(i, 4).text(),
            "endpose":tableList.item(i, 5).text(),
            "endgap":tableList.item(i, 6).text(),
            "endfrom":tableList.item(i, 7).text(),
            "endto":tableList.item(i, 8).text()
        })

    def doAction(path):
        path = path[0]
        if '.txt' not in path: path += '.txt'
        f = open(path, "w")
        f.write(json.dumps(outputData, indent=4))
        f.close()

    GuiBase.openFileDialog(doAction, QFileDialog.AnyFile, "*.txt")

def saveInfo():
    outputData = []
    for row in range(tableList.rowCount()):
        startGap = int(tableList.item(row, 2).text())
        endGap = int(tableList.item(row, 6).text())
        endFrom = int(tableList.item(row, 7).text())
        endTo = int(tableList.item(row, 8).text())
        (usingFrom, usingTo, usingPoseFrom, usingPoseTo) = getUsingPoseFromTo(startGap, endGap, endFrom, endTo)
        outputData.append({
            "export":"1",
            "name":tableList.item(row, 0).text(),
            "fileName":"",
            "start":str(usingPoseFrom),
            "end":str(usingPoseTo),
            "root_type":"0",
            "blend":"0",
            "cloth":"0",
        })
    try:
        cmds.addAttr('persp', ln='AnimationExportSetting', dt='string' )
    except:pass
    cmds.setAttr('persp.AnimationExportSetting', json.dumps(outputData), type='string')
    
    AllCommand.btn_animationExporter_click()

    # 舊的方法
    # count = tableList.rowCount()

    # newstr = ''
    # newstr += str(count) + ',0,0,'
        
    # for row in range(count):
    #     newstr += tableList.item(row, 0).text().replace(":", "_") + ','
    
    # for row in range(count):
    #     startGap = int(tableList.item(row, 2).text())
    #     endGap = int(tableList.item(row, 6).text())
    #     endFrom = int(tableList.item(row, 7).text())
    #     endTo = int(tableList.item(row, 8).text())
    #     (usingFrom, usingTo, usingPoseFrom, usingPoseTo) = getUsingPoseFromTo(startGap, endGap, endFrom, endTo)
    #     newstr += str(usingPoseFrom) + ','
        
    # for row in range(count):
    #     startGap = int(tableList.item(row, 2).text())
    #     endGap = int(tableList.item(row, 6).text())
    #     endFrom = int(tableList.item(row, 7).text())
    #     endTo = int(tableList.item(row, 8).text())
    #     (usingFrom, usingTo, usingPoseFrom, usingPoseTo) = getUsingPoseFromTo(startGap, endGap, endFrom, endTo)
    #     newstr += str(usingPoseTo) + ','	 
    
    # for row in range(count):
    #     ns = tableList.item(row, 0).text()
    #     for ref in pm.listReferences():
    #         if ns == cmds.referenceQuery(ref.refNode.__str__(), namespace = 1):
    #             newstr += ref.refNode.__str__() + ','
        
    # for row in range(count):
    #     zero = '0'
    #     newstr += zero + ','	 
        
    # for row in range(count):
    #     turn = '0'
    #     newstr += turn + ','	

    # for row in range(count):
    #     rotateRootCtrl = '0'
    #     newstr += rotateRootCtrl + ','	 
        
    # for row in range(count):
    #     out = '1'
    #     newstr += out + ','	
    
    # def getMainNameSpace():
    #     ns = cmds.namespaceInfo(lon=True)
    #     if len(ns) > 2:
    #         return ns[0:-2][0] + ':'
    #     else:
    #         return ''
            
    # ns = getMainNameSpace()
    # mainCtrl = ns + 'Main'
    # if not cmds.objExists(mainCtrl):
    #     locator = cmds.spaceLocator()
    #     cmds.rename( locator, mainCtrl )
    # if mel.eval('attributeExists "FightSettingInfo" ' + mainCtrl) == 0:
    #     cmds.addAttr(mainCtrl,ln='FightSettingInfo',dt='stringArray')
    # melstr = 'setAttr %s.FightSettingInfo -type stringArray 1 "%s";' % (mainCtrl, newstr)
    # mel.eval( melstr )

def addItem():
    ns = comboRole.currentText()
    currRow = tableList.rowCount()
    tableList.setRowCount(currRow+1)
    tableList.setItem(currRow, 0, QTableWidgetItem(ns))
    tableList.setItem(currRow, 1, QTableWidgetItem(""))
    tableList.setItem(currRow, 2, QTableWidgetItem("5"))
    tableList.setItem(currRow, 3, QTableWidgetItem("0"))
    tableList.setItem(currRow, 4, QTableWidgetItem("0"))
    tableList.setItem(currRow, 5, QTableWidgetItem(""))
    tableList.setItem(currRow, 6, QTableWidgetItem("5"))
    tableList.setItem(currRow, 7, QTableWidgetItem("0"))
    tableList.setItem(currRow, 8, QTableWidgetItem("0"))
    tableList.resizeColumnsToContents()    

    """ debug """
    # currRow = tableList.rowCount()
    # tableList.setRowCount(currRow+1)
    # tableList.setItem(currRow, 0, QTableWidgetItem(ns))
    # tableList.setItem(currRow, 1, QTableWidgetItem("E:/Vic/tmp/victest/initpose.pose"))
    # tableList.setItem(currRow, 2, QTableWidgetItem("5"))
    # tableList.setItem(currRow, 3, QTableWidgetItem("0"))
    # tableList.setItem(currRow, 4, QTableWidgetItem("30"))
    # tableList.setItem(currRow, 5, QTableWidgetItem("E:/Vic/tmp/victest/after2.pose"))
    # tableList.setItem(currRow, 6, QTableWidgetItem("5"))
    # tableList.setItem(currRow, 7, QTableWidgetItem("20"))
    # tableList.setItem(currRow, 8, QTableWidgetItem("40"))
    # tableList.resizeColumnsToContents()    

    # currRow = tableList.rowCount()
    # tableList.setRowCount(currRow+1)
    # tableList.setItem(currRow, 0, QTableWidgetItem(ns))
    # tableList.setItem(currRow, 1, QTableWidgetItem("E:/Vic/tmp/victest/after2.pose"))
    # tableList.setItem(currRow, 2, QTableWidgetItem("5"))
    # tableList.setItem(currRow, 3, QTableWidgetItem("60"))
    # tableList.setItem(currRow, 4, QTableWidgetItem("90"))
    # tableList.setItem(currRow, 5, QTableWidgetItem("E:/Vic/tmp/victest/initpose.pose"))
    # tableList.setItem(currRow, 6, QTableWidgetItem("5"))
    # tableList.setItem(currRow, 7, QTableWidgetItem("70"))
    # tableList.setItem(currRow, 8, QTableWidgetItem("100"))  

def setDataOnTable(row, col, value):         
    if not tableList.item(row, col):
        tableList.setItem(row, col, QTableWidgetItem(""))
    tableList.item(row, col).setText(value)
    tableList.resizeColumnsToContents()

def grabRoleName():
    ns = comboRole.currentText()
    if currentCell:
        setDataOnTable(currentCell[0], currentCell[1], ns)

def grabPoseName():
    poseItem = getPoseFromStudioLibrary()
    if currentCell and len(poseItem) > 0:
        setDataOnTable(currentCell[0], currentCell[1], poseItem[0].path())

def getRefs():
    ns = []
    refs = pm.listReferences()
    for ref in refs:
        ns.append(pm.referenceQuery(ref.refNode, namespace=1))
    return ns

def getPoseFromStudioLibrary():
    itemWidget = librarywindow.LibraryWindow.instance().itemsWidget()
    selectPoseItem = itemWidget.selectedItems()
    return selectPoseItem


ui = GuiBase.BasicUI(u'動畫重排', False)
widgets = ui.generateUIByConfig(widgetData, layoutData, globals() )
comboRole = widgets["comboRole"]

currentCell = None

def oncellclick(row, col):
    global currentCell
    currentCell = [row, col]

tableList = widgets["tableList"]

tableList.cellPressed.connect(oncellclick)
tableList.header = [u'角色', u'起始動作',u'起始間隔',u'開始幀',u'結束幀', u'結束動作',u'結束間隔',u'開始幀',u'結束幀']
tableList.setColumnCount(len(tableList.header))
tableList.setHorizontalHeaderLabels(tableList.header)
tableList.resizeColumnsToContents()

""" 新增資料的時候，如果有預設值，再新增該項目的時候，會被排序機制影響導致該項目之後的項目設值不正確。爲了不產生新的bug，就不設置預設值了 """
tableList.setSortingEnabled(0)
tableList.setAlternatingRowColors(True)

refs = getRefs()
for ref in refs:
    print(ref)
    comboRole.addItem(ref)

quests = {
    "list":[]
}

        

