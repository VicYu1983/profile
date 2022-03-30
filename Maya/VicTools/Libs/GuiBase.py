# -*- coding: utf-8 -*-
import os
import maya.cmds as cmds

if int(cmds.about(version=True)) >= 2017:
    import PySide2.QtGui
    from PySide2.QtGui import *
    import shiboken2 as shiboken
    from PySide2.QtWidgets import *
else:
    import PySide.QtGui
    from PySide.QtGui import *
    import shiboken

import maya.mel as mel
import maya.OpenMayaUI as mui

class BasicUI():
    def __init__(self, uiName, debug=False):
        self.__debug = debug
        self._showWindow(uiName)

    def __getMayaWindow(self):
        pointer = mui.MQtUtil.mainWindow()
        return shiboken.wrapInstance(long(pointer), QWidget)

    def _showWindow(self, uiName):
        if cmds.window(uiName, exists=True):
            cmds.deleteUI(uiName, wnd=True)

        self.__window = QMainWindow(self.__getMayaWindow())
        self.__window.setObjectName(uiName)
        self.__window.setWindowTitle(uiName)

        self.__mainWidget = QWidget()
        self.__window.setCentralWidget(self.__mainWidget)

        self.__window.show()

    def generateUIByConfig(self, widgetData, layoutData, context):
        vbox = QVBoxLayout(self.getMainWidget())
        return createLayoutByConfig(widgetData, layoutData, context, vbox)

    def getMainWidget(self):
        return self.__mainWidget

    def isDebug(self):
        return self.__debug

# pyqt的json解析器，以下是用法範例:
# uidata = {"layout":[{"name":"default","class":"QVBoxLayout"},{"name":"gb1","class":"QGroupBox","construct":["Motion Capture"]},{"name":"gb2","class":"QGroupBox","construct":["JFTools"]},{"name":"gb3","class":"QGroupBox","construct":["AdvSkeleton"]},{"name":"vb1","class":"QVBoxLayout"},{"name":"hb1","class":"QHBoxLayout"},{"name":"hb2","class":"QHBoxLayout"}],"widget":[{"name":"lbl_namespace","class":"QLabel","construct":["NameSpace:"],"params":{"setMinimumSize":[400,0]}},{"name":"lbl_saveLocation","class":"QLabel","construct":["Save Location:"],"params":{"setMinimumSize":[400,0]}},{"name":"le_namespace","class":"QLineEdit"},{"name":"le_saveLocation","class":"QLineEdit"}],"hierarchy":{"default":["gb3","gb1","gb2"],"gb1":["vb1"],"vb1":["hb1","hb2"],"hb1":["lbl_namespace","le_namespace"],"hb2":["lbl_saveLocation","le_saveLocation"]}}
# uiObj = GuiBase.parseUIData(uidata)
# vbox = QVBoxLayout(self.getMainWidget())
# vbox.addLayout(uiObj["default"])
def parseUIData(uidata):
    exportObj = {}

    layouts = uidata["layout"]
    for layout in layouts:
        name = layout["name"]
        clz = layout["class"]
        obj = None
        if "construct" in layout:
            obj = eval("PySide.QtGui." + clz)(*layout["construct"])
        else:
            obj = eval("PySide.QtGui." + clz)()
        exportObj[name] = obj

    widgets = uidata["widget"]
    for widget in widgets:
        name = widget["name"]
        clz = widget["class"]
        if "construct" in widget:
            obj = eval("PySide.QtGui." + clz)(*widget["construct"])
        else:
            obj = eval("PySide.QtGui." + clz)()
        exportObj[name] = obj

        if "params" in widget:
            params = widget["params"]
            for param in params:
                # call method by string
                getattr(obj, param)(*params[param])

    hierarchy = uidata["hierarchy"]
    for key in hierarchy:
        parentNode = exportObj[key]
        childs = hierarchy[key]
        for child in childs:
            childNode = exportObj[child]
            parentIsLayout = isinstance(parentNode, PySide.QtGui.QLayout)
            parentIsWidget = isinstance(parentNode, PySide.QtGui.QWidget)
            childIsLayout = isinstance(childNode, PySide.QtGui.QLayout)
            childIsWidget = isinstance(childNode, PySide.QtGui.QWidget)
            if parentIsLayout and childIsWidget:
                parentNode.addWidget(childNode)
            elif parentIsLayout and childIsLayout:
                parentNode.addLayout(childNode)
            elif parentIsWidget and childIsLayout:
                parentNode.setLayout(childNode)
            elif parentIsWidget and childIsWidget:
                raise Exception( "widget can not be child of widget!" )
            else:
                raise Exception( "can not be here!" )

    return exportObj

def addButtonToLayout(layout, map):
    btns = []
    for [name, method, tooltip] in map:
        hbox = QHBoxLayout()
        layout.addLayout(hbox)

        btn_current = QPushButton(name)
        btn_current.clicked.connect(method)
        hbox.addWidget(btn_current)
        btns.append(btn_current)

        def _onTipClick(_tooltip):
            return lambda: showMessage(_tooltip if _tooltip != "" else u"請補上")

        btn_tooltip = QPushButton("?")
        btn_tooltip.setMaximumSize(10,btn_tooltip.height())
        btn_tooltip.clicked.connect(_onTipClick(tooltip))
        hbox.addWidget(btn_tooltip)
    return btns

def addSpinboxToLayout(layout, map):
    spins = []
    for [name, type, tooltip] in map:
        hbox = QHBoxLayout()
        layout.addLayout(hbox)

        label = QLabel(name)
        hbox.addWidget(label)

        spin = QDoubleSpinBox() if type == "f" else QSpinBox()
        hbox.addWidget(spin)
        spins.append(spin)

        def _onTipClick(_tooltip):
            return lambda: showMessage(_tooltip if _tooltip != "" else u"請補上")

        btn_tooltip = QPushButton("?")
        btn_tooltip.setMaximumSize(10,btn_tooltip.height())
        btn_tooltip.clicked.connect(_onTipClick(tooltip))
        hbox.addWidget(btn_tooltip)
    return spins

'''
example: 
-*- coding: utf-8 -*-
import JFAdvSkeletonAllCommand
reload(JFAdvSkeletonAllCommand)

widgetData = {
    "btnStudioLibrary":{"class":"QPushButton", "content":"StudioLibrary", "tip":u"StudioLibrary\n目前只允許2016版本的maya使用", "events":{"clicked":"openStudioLibrary"}},
    "btnChooseFolder":{"class":"QPushButton", "content":"Choose Folder", "tip":u"把所選資料下的所有fbx重新導出成有namespace的版本\n注意！是整個資料下的所有fbx\nnamespace會以該fbx所在的資料夾名稱爲主", "events":{"clicked":"doBatchAddNamespace"}},
    "lblBatchAddName":{"class":"QLabel", "content":"Batch Add Namespace:"}
}

layoutData = {
    "Plugins":[
        ["btnStudioLibrary"]
    ],
    "Motion Capture":[
        ["lblBatchAddName", "btnChooseFolder"]
    ]
}

ui = JFAdvSkeletonAllCommand.JFAdvSkeleton('JFAdvSkeleton', False)
ui.generateUIByConfig(widgetData, layoutData, JFAdvSkeletonAllCommand)
'''
def createLayoutByConfig(widgetData, layoutData, context, layout):
    objexport = {}
    for group in sorted(layoutData.keys()):
        layouts = layoutData[group]
        grpbox = QGroupBox(group)
        vbox = QVBoxLayout()
        grpbox.setLayout(vbox)
        layout.addWidget(grpbox)
        for layoutV in layouts:
            hbox = QHBoxLayout()
            vbox.addLayout(hbox)
            for layoutH in layoutV:
                if layoutH in widgetData:
                    wdata = widgetData[layoutH]

                    if "tip" in wdata:
                        subbox = QHBoxLayout()
                        hbox.addLayout(subbox)
                    else:
                        subbox = hbox

                    clz = wdata["class"]
                    if "content" in wdata:
                        content = wdata["content"]
                        widget = globals()[clz](content)
                    else:
                        widget = globals()[clz]()
                    objexport[layoutH] = widget
                    if "params" in wdata:
                        params = wdata["params"]
                        for param in params.keys():
                            getattr(widget, param)(*params[param])
                    if "events" in wdata:
                        events = wdata["events"]
                        for event in events.keys():
                            eventObj = getattr(widget, event)
                            commandName = events[event]
                            try:
                                # context is module or class
                                eventObj.connect(getattr(context, commandName))
                            except:
                                # context is globals() or locals()
                                eventObj.connect(context[commandName])
                    subbox.addWidget(widget)

                    if "tip" in wdata:
                        tip = wdata["tip"]
                        def _onTipClick(_tooltip):
                            return lambda: showMessage(_tooltip if _tooltip != "" else u"請補上")

                        btn_tooltip = QPushButton("?")
                        btn_tooltip.setMaximumSize(10,btn_tooltip.height())
                        btn_tooltip.clicked.connect(_onTipClick(tip))
                        subbox.addWidget(btn_tooltip)
                else:
                    print( "data lose " + layoutH)
    return objexport
                            
def openFileDialog(action, mode, filter = ""):
    dlg = QFileDialog()
    dlg.setFileMode(mode)
    if filter != "":    dlg.setNameFilter(filter)
    if dlg.exec_():
        action(dlg.selectedFiles())

def InstallToShelf(name, melPath, icon="bevel.png"):
    g_ShelfTopLevel = mel.eval("$Temp = $gShelfTopLevel")
    if cmds.tabLayout(g_ShelfTopLevel, q=True, ex=True):
        _tab = cmds.tabLayout(g_ShelfTopLevel, q=True, st=True)
        shelfButtons = cmds.shelfLayout(_tab, q=True, ca=True)

        try:
            if(shelfButtons):
                for btn in shelfButtons:
                    if(cmds.control(btn, ex=True)):
                        sfbtn = cmds.shelfButton(btn, q=True, annotation=True)
                        if(sfbtn == name):
                            cmds.deleteUI(btn)
        except:
            print("some invalid shelf button...")
        melCommand = 'source "' + melPath + '";'
        cmds.shelfButton(parent=g_ShelfTopLevel + '|' + _tab,
                         image=icon,
                         iol=name,
                         label=name,
                         sourceType='mel',
                         annotation=name,
                         command=melCommand
                         )
    else:
        error('Must have active shelf to create shelf button')

# example:
# path_string = '","'.join([tool_path, lib_path, features_path])
# GuiBase.InstallToShelfPy('["%s"]' % path_string, 'JFAnim', 'Anim2')
def InstallToShelfPy(paths, module, name="", icon="bevel.png"):
    #srcPath = os.path.normpath(srcPath)
    command = '''
import os
import sys
    
for path in {paths}:
    if path not in sys.path: sys.path.append(path)
    
import {module}
reload ({module})
'''.format(paths=paths, module= module)

    shelf = mel.eval('$gShelfTopLevel=$gShelfTopLevel')
    parent = cmds.tabLayout(shelf, query=True, selectTab=True)
    cmds.shelfButton(
        command=command,
        annotation=name,
        sourceType='Python',
        parent=parent,
        image=icon,
        iol=name,
        label=name
    )

def showMessage(msg):
    msgBox = QMessageBox()
    msgBox.setText(msg)
    msgBox.exec_()