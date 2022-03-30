# -*- coding:utf-8 -*-
import maya.cmds as cmds

def selectAllController():
    def _selectAll( selList ):
        for layer in cmds.ls(type="displayLayer"):
            if "Controller" in layer:
                cmds.select(layer)
                selList += cmds.listHistory(layer,f=1)
                selList.remove( layer )
                cmds.select(layer,d=1)

    selList = []
    if len(cmds.ls(sl=1)) == 0:
        _selectAll(selList)
    else:
        layer = cmds.listConnections(t="displayLayer")
        if layer == None:
            _selectAll(selList)

            msgBox = QtGui.QMessageBox()
            msgBox.setText(u"找不到物件的圖層，選取全部")
            msgBox.exec_()
        else:
            cmds.select(layer)
            selList += cmds.listHistory(layer,f=1)
            selList.remove( layer[0] )
            cmds.select(layer,d=1)

    # 過濾掉FKIK切換的節點
    # selList = [ctrl for ctrl in selList if "FKIK" not in ctrl]
    cmds.select(selList)