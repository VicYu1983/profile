# -*- coding:utf-8 -*-
import GuiBase, DataGridTool, Helper
reload(DataGridTool)

import AS_MotionConstrain as ASC
reload(ASC)

import maya.cmds as cmds
import maya.mel as mel
import pymel.core as pm

if int(cmds.about(version=True)) >= 2017:
    import PySide2.QtGui
    from PySide2.QtGui import *
    import shiboken2 as shiboken
    from PySide2.QtWidgets import *
else:
    import PySide.QtGui
    from PySide.QtGui import *
    import shiboken



def execute():

    export_name = '_export.txt'
    
    def onDataGridPressed(args):
        controller.setSelectId(args.row())

    def autoData():
        refList = pm.listReferences()
        for ref in refList:
            try:
                ns = cmds.referenceQuery(ref.refNode.__str__(), namespace = 1)
                cmds.select('%s:Main' % ns)
                addData()
            except:pass

    def addData():
        selected = cmds.ls(sl=1)
        if len(selected) > 0:
            controller.addData()

    def removeData():
        controller.removeData()

    def clearData():
        controller.clearData()

    def saveData():
        file_name = cmds.file(sn=1,q=1)
        if len(file_name) == 0: return 
        controller.saveData(file_name.replace('.ma', export_name))

    def seeSection():
        row = controller.getSelectedId()
        if row != None:
            data = controller.getModel().getDataAt(row)
            Helper.setTimelineInfo(data['start'], data['end'])

    def seeRole():
        row = controller.getSelectedId()
        if row != None:
            data = controller.getModel().getDataAt(row)
            cmds.select(cl=1)
            cmds.select( '%s:Main' %data['name'] )

    def exportData():
        file_name = cmds.file(sn=1,q=1)
        if len(file_name) == 0: return 

        datas = controller.getDatas()
        for data in datas:
            export = (data['export'] == '1')
            if export:
                save_name = data['fileName']
                if len(save_name) > 0:
                    target_role = data['name']
                    start = int(data['start'])
                    end = int(data['end'])
                    root_type = data['root_type']
                    blend = (data['blend'] == '1')
                    cloth = (data['cloth'] == '1')
                    
                    Helper.setTimelineInfo(start, end)
                    cmds.currentTime(start)

                    new_root = None

                    # old method
                    clearRoleProxy = None

                    if root_type == '0':
                        pass
                    elif root_type == '1':
                        clearRoleProxy = ASC.setCharToZero(target_role, start, end)

                        # 以下為新方法，不過先用舊的好了
                        # egg = '%s:root_ctrl' % target_role
                        # egg_pos = cmds.xform(egg, q=1, t=1, ws=1)

                        # root = '%s:Main' % target_role
                        # root_pos = cmds.xform(root, q=1, t=1, ws=1)

                        # new_root = cmds.spaceLocator()
                        # cmds.xform( new_root, ws=1, t=root_pos)

                        # cmds.parentConstraint( new_root, root )

                        # new_pos = (root_pos[0]-egg_pos[0],root_pos[1]-egg_pos[1],root_pos[2]-egg_pos[2])
                        # cmds.xform(new_root, ws=1, t=new_pos)

                    elif root_type == '2':
                        clearRoleProxy = ASC.setCharToZero(target_role, start, end, True, True )

                    elif root_type == '3':
                        egg = '%s:root_ctrl' % target_role
                        egg_mat = cmds.xform(egg, q=1, m=1, ws=1)
                        egg_mat_om = Helper.getOpenMayaMatrix(egg_mat)

                        root = '%s:Main' % target_role
                        root_mat = cmds.xform(root, q=1, m=1, ws=1)
                        root_mat_om = Helper.getOpenMayaMatrix(root_mat)

                        new_root = cmds.spaceLocator()
                        cmds.xform( new_root, ws=1, m=root_mat)

                        cmds.parentConstraint( new_root, root )

                        new_mat_om = root_mat_om * egg_mat_om.inverse()
                        new_mat = Helper.getMelMatrix(new_mat_om)

                        cmds.xform(new_root, ws=1, m=new_mat)
                    else:
                        print('not have this type: %s' % root_type)

                    folder_path = '/'.join(file_name.split('/')[:-1])
                    save_path = '%s/%s.fbx' % (folder_path, save_name)

                    # save_path = file_name.replace('.ma', '_%s_%s.fbx' % (target_role, save_name))

                    print('save_path', save_path)
                    Helper.JFExportFBX(target_role, start, end, save_path, blend, cloth)

                    if new_root: cmds.delete(new_root)
                    if clearRoleProxy: clearRoleProxy()
        GuiBase.showMessage(u'完成')

    notestr = u'''==================================
輸出 : [0]不輸出 [1]輸出
角色 : 項目的角色名稱。需要先點選場景中的人物，再點擊這個按鈕
檔名 : 輸出的檔案名稱。
開始 : 開始的frame
結束 : 結束的frame
類型 : [0]什麽都不處理 [1]把角色回到原點 [2]把角色回到原點后，做180的旋轉 [3]根據開始的frame的狀態，自動旋轉到正面
變形 : [0]純輸出骨架 [1]包含有blend shape的mesh會一起導出
布料 : [0]不使用布料模擬 [1]使用布料模擬
==================================
    '''

    widgetData = {
        'lblnote':{'class':'QLabel', 'content':notestr},
        'dataGrid':{'class':'QTreeView', 'events':{'pressed':'onDataGridPressed'}},
        "btnAutoSetting":{"class":"QPushButton", "content":"自動新增", "tip":u"自動新增場景中的角色", "params":{"setMinimumSize":[80,0]}, "events":{"clicked":"autoData"}},
        "btnAddData":{"class":"QPushButton", "content":"新增項目", "tip":u"項目的角色名稱。需要先點選場景中的人物，再點擊這個按鈕", "params":{"setMinimumSize":[80,0]}, "events":{"clicked":"addData"}},
        "btnRemoveData":{"class":"QPushButton", "content":"清除項目", "tip":u"清除一個輸出項目", "params":{"setMinimumSize":[80,0]}, "events":{"clicked":"removeData"}},
        "btnClearData":{"class":"QPushButton", "content":"清空項目", "tip":u"清空所有輸出項目", "params":{"setMinimumSize":[80,0]}, "events":{"clicked":"clearData"}},
        "btnExport":{"class":"QPushButton", "content":"輸出", "tip":u"開始輸出所有項目。輸出位置為本maya檔案的位置", "params":{"setMinimumSize":[80,0]}, "events":{"clicked":"exportData"}},
        "btnSave":{"class":"QPushButton", "content":"儲存設定", "tip":u"儲存設定。資料會儲存在persp.AnimationExportSetting", "params":{"setMinimumSize":[80,0]}, "events":{"clicked":"saveData"}},
        "btnFocus":{"class":"QPushButton", "content":"檢視段落", "tip":u"把timeline設定為選定項目的設定", "params":{"setMinimumSize":[80,0]}, "events":{"clicked":"seeSection"}},
        "btnFocusRole":{"class":"QPushButton", "content":"檢視角色", "tip":u"選擇所選項目的角色", "params":{"setMinimumSize":[80,0]}, "events":{"clicked":"seeRole"}},
    }    

    layoutData = {
        '1.主要界面':[
            ['lblnote'],
            ['dataGrid'],
            ['btnAutoSetting', 'btnAddData', 'btnRemoveData','btnClearData', 'btnSave'],
            ['btnFocusRole', 'btnFocus', 'btnExport']
        ]
    }

    ui = GuiBase.BasicUI('AnimationExporter', False)
    widgets = ui.generateUIByConfig(widgetData, layoutData, locals())

    def getRoleName():
        selected = cmds.ls(sl=1)[0]
        name = ':'.join(selected.split(':')[:-1])
        return name

    def getStart():
        (min_inner, max_inner, min_outer, max_outer) = Helper.getTimelineInfo()
        return str(min_inner)

    def getEnd():
        (min_inner, max_inner, min_outer, max_outer) = Helper.getTimelineInfo()
        return str(max_inner)

    config = (
        ('輸出', '角色', '檔名','開始','結束','類型', '變形(blend shape)', '布料模擬'),
        ('export', 'name', 'fileName', 'start', 'end', 'root_type', 'blend', 'cloth'),
        ('1', getRoleName, '', getStart, getEnd, '0', '0', '0'),
    )

    dataGrid = widgets['dataGrid']
    controller = DataGridTool.DatagridController(dataGrid, config)
    
    file_name = cmds.file(sn=1,q=1)
    if len(file_name) > 0: 
        controller.loadData(file_name.replace('.ma', export_name))

