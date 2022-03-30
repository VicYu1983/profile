# -*- coding:utf-8 -*-
import maya.cmds as cmds
import maya.mel as mel
from PySide2.QtWidgets import QFileDialog

def execute():
    selected = cmds.ls(sl=1)
    for node in selected:
        try:
            cmds.parent(node, w=1)
        except:pass
        
    all_objs = cmds.ls(type='transform')
    none_selected = [node for node in all_objs if node not in selected and 'Anchor' not in node]

    cmds.delete(none_selected)

    # 確保目前選擇的東西都在場景上
    selected = [node for node in selected if (len(cmds.ls(node)) > 0) and ('Anchor' not in node)]
    cmds.group(selected, name='Landscape_01')

    cmds.polyCube(name='Anchor_Ori')

    # save maya file
    filename = QFileDialog.getSaveFileName(None, "Save file", "", ".ma")
    save_path = filename[0] + filename[1]

    if len(save_path) > 0:
        ns = filename[1].replace('.ma', '')
        
        cmds.file( rename=save_path )
        cmds.file( save=True, type='mayaAscii' )
        
        # offset anchor
        anchors = cmds.ls('*Anchor_*', type='transform')
        landscape = cmds.ls('*Landscape_*')
        
        all = anchors + landscape
        for node in all:
            offset_value = cmds.xform(node, ws=1, q=1, t=1)
            if offset_value[0] != 0 or offset_value[1] != 0 or offset_value[2] != 0:
                break
            
        for node in all:
            cmds.xform( node, r=1, t=(-offset_value[0], -offset_value[1], -offset_value[2]))
            
        # export landscape
        cmds.select(cl=1)
        cmds.select(landscape[0])
        
        fbx_path = save_path.replace('.ma', '.fbx')
        mel.eval('file -force -options "v=0;" -typ "FBX export" -pr -es "' + fbx_path + '";')




    
