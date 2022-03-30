# -*- coding:utf-8 -*-
from pydoc import Helper
import maya.cmds as cmds
import maya.mel as mel
import pymel.core as pm
import maya.OpenMaya as om

import GuiBase
from PySide2.QtGui import *
from PySide2.QtWidgets import *

def doExport():
    spnCount = widgets["spnCount"]
    makeNewMesh(spnCount.value())

notestr = u'''===========================
使用方法：
一：依序點選骨架和要複製的模型
二：設定數量
三：點擊執行。完成
===========================
'''

widgetData = {
    "lblcount":{"class":"QLabel", "content":u"數量"},
    "spnCount":{"class":"QSpinBox", "params":{"setMinimum":[1],"setMaximum":[120],"setValue":[5] }},
    "btnExport":{"class":"QPushButton", "content":u"輸出", "tip":u"", "events":{"clicked":"doExport"}},
    "lblNote":{"class":"QLabel", "content":notestr},
}

layoutData = {
    "Edit":[
        ["lblcount", "spnCount"],
        ["btnExport"],
        ["lblNote"]
    ]
}

ui = GuiBase.BasicUI(u'毛髮模型輸出工具', False)
widgets = ui.generateUIByConfig(widgetData, layoutData, globals() )

# def scaleMesh(node, distance):
    
#     cmds.select(node)
    
#     # Get selected object
#     mSelList = om.MSelectionList()
#     om.MGlobal.getActiveSelectionList(mSelList)
#     sel = om.MItSelectionList(mSelList)
#     path = om.MDagPath()
#     sel.getDagPath(path)

#     # Attach to MFnMesh
#     MFnMesh = om.MFnMesh(path)

#     for i in range( MFnMesh.numVertices() ):
#         # Create a point, and mirror it
#         vertex = om.MPoint()
#         MFnMesh.getPoint(i, vertex, 2)
        
#         normal = om.MVector()    
#         # 2 is mean local 
#         MFnMesh.getVertexNormal(i, normal,2)
        
#         vertex += normal * distance
#         MFnMesh.setPoint(i, vertex)



def makeNewMesh(copy_count = 1):

    # select two object, [joint_root, mesh]
    targets = cmds.ls(sl=1)

    if(len(targets) != 2): return 

    joint = targets[0]
    target = targets[1]

    skin = mel.eval('findRelatedSkinCluster '+target)

    # copy first, ignore effect to origin one
    new_result = cmds.duplicate(target)[0]
    # get vertex count
    vert_count = cmds.polyEvaluate( v=True )
    '''
    cmds.select( [joint, new_result] )
    new_skin = mel.eval('createSkinCluster "-mi 5 -dr 4"' )[0]
    cmds.copySkinWeights( ss=skin, ds=new_skin, noMirror=True )
    '''
    # collect all nodes need to be deleteted
    delete_nodes = [new_result]



    for i in range(copy_count):
        
        # copy
        new_copy = cmds.duplicate(target)[0]
        
        '''
        cmds.select( [joint, new_copy] )
        new_skin = mel.eval('createSkinCluster "-mi 5 -dr 4"' )[0]
        cmds.copySkinWeights( ss=skin, ds=new_skin, noMirror=True )
        '''

        cmds.select( new_copy )
        #scaleMesh( new_copy, 1 + (i + 1) * scale_offset )
        
        target_uv_set = 'UVChannel_2'
        try:
            cmds.polyUVSet(delete=1, uvSet=target_uv_set)
        except: pass
        cmds.polyUVSet(create=1, uvSet=target_uv_set)
        pm.polyUVSet(cuv=1, uvs=target_uv_set)
        
        cmds.polyProjection(new_copy + ".f[0:" + str(vert_count*2) + "]", uvs=target_uv_set, type='Spherical')
        
        # offset uv
        for vid in range(vert_count):
            #pm.polyEditUV('%s.vtx[%i]' % (new_copy, vid), u=((i + 1) * uv_offset[0]),v=((i + 1) * uv_offset[1]), r=1, uvs=target_uv_set)
            pm.polyEditUV('%s.vtx[%i]' % (new_copy, vid), u=((i+1)/float(copy_count)),v=0, r=0, uvs=target_uv_set)
            
        
        # collect all nodes need to be deleteted    
        delete_nodes.append(new_copy) 


        # merge mesh
        cmds.select([new_copy, new_result])
        new_result = cmds.polyUnite(n=new_result)[0]

    # delete all history
    cmds.delete(new_result, constructionHistory = True)

    # skin
    cmds.select([joint, new_result])
    new_skin = cmds.skinCluster()[0]
    cmds.copySkinWeights( ss=skin, ds=new_skin, noMirror=True )

    # delete useless nodes
    cmds.delete(delete_nodes)

    GuiBase.showMessage(u'成功複製出模型%s' % new_result)

