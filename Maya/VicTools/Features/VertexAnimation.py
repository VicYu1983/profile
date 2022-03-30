# -*- coding: utf-8 -*-
import maya.cmds as cmds
import pymel.core as pm
import pymel.core.datatypes as dt
import maya.cmds as cmds
import json, subprocess, os
import GuiBase, Helper
import maya.OpenMaya as om

# 用openmaya的api是走c++路綫，速度很快。本來是用pymel的api來做，但是速度太慢了
def quickWayToGetVertexPositionAndNormal():
    
    # Get selected object
    mSelList = om.MSelectionList()
    om.MGlobal.getActiveSelectionList(mSelList)
    sel = om.MItSelectionList(mSelList)
    path = om.MDagPath()
    sel.getDagPath(path)

    # Attach to MFnMesh
    MFnMesh = om.MFnMesh(path)

    # Create empty point array to store new points
    newPointArray = om.MPointArray()
    newNormalArray = om.MVectorArray()

    for i in range( MFnMesh.numVertices() ):
        # Create a point, and mirror it
        newPoint = om.MPoint()
        MFnMesh.getPoint(i, newPoint)
        newPointArray.append(newPoint)
            
        newPoint = om.MVector()    

        # 這邊帶入的2是指local坐標系
        MFnMesh.getVertexNormal(i, newPoint,2)
        newNormalArray.append(newPoint)
    return newPointArray, newNormalArray

def export(exportModel = False, isCloth = False, exportAnimation = False, textureWidth = 1000):
    
    if not exportModel and not exportAnimation: return

    selects = cmds.ls(sl=1)
    if len(selects) == 0: return

    meshName = selects[0]

    imin, imax, omin, omax = Helper.getTimelineInfo()
    start = omin
    end = omax

    pm.select(meshName)
    obj = pm.ls(sl=1)

    maya_file_path = cmds.file(q=True,sn=True)
    if maya_file_path == "":
        GuiBase.showMessage(u'請先存檔')
        return

    if exportModel:

        # 回到動畫第一幀把模型拷貝出來
        cmds.currentTime(start, update=1)
        copy = pm.duplicate()

        # 重新命名
        new_name = cmds.rename(copy, meshName + "_export")
        cmds.select(new_name)

        # 布料模擬的物件在複製出來之後，會有兩個shape在，其中一個是原來沒有被模擬的原始mesh
        # 這個要砍掉，只留下模擬過後的mesh，否則後續的步驟會出錯
        if isCloth: 
            cmds.delete(new_name + 'Shape')

            # 有時也有可能多一個outputCloth，這個時候只能留最後一個
            outputCloth = cmds.ls( new_name + '|outputCloth*')
            if(len(outputCloth) > 1):
                cmds.delete(outputCloth[:-1])

        # 目標uv名稱，跟3dsmax版本的一樣
        target_uv_set = 'UVChannel_2'

        # 强制把同名的uv層刪除,創一個新的
        try:
            cmds.polyUVSet(delete=1, uvSet=target_uv_set)
        except: pass
        cmds.polyUVSet(create=1, uvSet=target_uv_set)
        
        # 設定目標uv到第二個
        pm.polyUVSet(cuv=1, uvs=target_uv_set)

        # 取出頂點數目
        vtx_count = len(copy[0].vtx)

        # 有時候模型沒有拆uv，這個時候，用程式編輯uv的話就不會有反應。解決方法就是先把uv映射出來
        # uv的點的數目和vertex的點數目不太一樣，在映射的時候，把點的數量增多。這裏是*2.確保所有的點都有被映射到
        cmds.polyProjection(new_name + ".f[0:" + str(vtx_count*2) + "]", uvs=target_uv_set, type='Spherical')
        
        # 開始設定uv
        for i in range(vtx_count):
            pm.polyEditUV(copy[0].vtx[i], u=i,v=.5, r=0, uvSetName=target_uv_set)

        # 輸出fbx
        save_file = maya_file_path.replace(".ma", "_mesh.fbx")
        pm.mel.FBXExport(f=save_file, s=1)

        # 刪除
        cmds.delete(new_name)

    # 收集動畫資料
    if exportAnimation:

        # 再次選擇動畫模型
        pm.select(meshName)

        # 儲存初始資料
        init_pos_list = []
        cmds.currentTime(0, update=1)

        init_pos_list, nor_ary = quickWayToGetVertexPositionAndNormal()
        
        # 儲存動畫資料
        diff_pos_array = []
        nor_array = []
        for i in range(start, end):
            print("bake frame", i )

            cmds.currentTime(i+1, update=True)
            diff_pos_list = []
            nor_list = []
            
            pos_list, nor_ary = quickWayToGetVertexPositionAndNormal()

            for i in range(pos_list.length()):
                current_pos = pos_list[i]
                init_pos = init_pos_list[i]
                
                diff_pos_list.append([
                    (current_pos.x-init_pos.x),
                    -(current_pos.y-init_pos.y),
                    (current_pos.z-init_pos.z),
                ])
                
                
                '''
                faces = vtx.connectedFaces()
                normal = dt.Vector()
                
                for face in faces:
                    normal = face.getNormal('world').normal()
                    break
                '''

                # 取得法綫資料
                normal = nor_ary[i]
                # ue4的y是跟maya比是反的
                normal.y *= -1

                # # 把法綫轉成貼圖資訊
                normal = normal + om.MVector(1,1,1)
                normal *= .5
                normal *= 255.0
                
                nor_list.append([
                    normal.x, normal.y, normal.z
                ])
            diff_pos_array.append( diff_pos_list )
            nor_array.append( nor_list )
        
        output = {
            "pos":diff_pos_array, "nor":nor_array
        }
        
        # 輸出json資料給外部python繪圖用
        json_str = json.dumps(output)
        
        # 同時支援ma檔及mb檔案
        save_file = maya_file_path.replace(".ma", "_temp.txt")
        save_file = save_file.replace(".mb", "_temp.txt")

        text_file = open(save_file, "w")
        text_file.write(json_str)
        text_file.close() 

        # 輸出json完成后，開始執行繪圖程式
        batch_file = "/".join(__file__.split("/")[:-1] + ["VertexAnimationTexture", "DrawTextureEntry.bat"])
        draw_file = "/".join(batch_file.split("/")[:-1] + ["DrawTexture.py"])
        subprocess.call([batch_file, draw_file, str(textureWidth), save_file])

        # 刪掉json
        os.remove(save_file)

    # 打開輸出資料夾
    open_folder_path = "/".join(maya_file_path.split("/")[:-1])
    os.startfile(open_folder_path)

    GuiBase.showMessage(u'輸出完畢,路徑為' + open_folder_path)

global chkMesh, chkAnimation, chkCloth, spnWidth
def doExport():
    export(chkMesh.checkState(), chkCloth.checkState(), chkAnimation.checkState(), spnWidth.value())

def execute():

    widgetData = {
        "btnExport":{"class":"QPushButton", "content":u"輸出頂點動畫", "tip":u"先點選要輸出的模型\n再點選此按鈕", "events":{"clicked":"doExport"}},
        "chkCloth":{"class":"QCheckBox", "content": u"布料模擬物件", "params":{"setChecked":[False]}},
        "chkMesh":{"class":"QCheckBox", "content": u"輸出模型", "params":{"setChecked":[True]}},
        "chkAnimation":{"class":"QCheckBox", "content": u"輸出動畫", "params":{"setChecked":[True]}},
        "spnWidth":{"class":"QSpinBox", "tip":"通常是2的次方，如512、1024、2048", "params":{"setMinimum":[128],"setMaximum":[8192],"setValue":[1024] }},
        "lblWidth":{"class":"QLabel", "content":u"貼圖寬度"},
    }

    layoutData = {
        "":[
            ["btnExport"],
            ['chkCloth'],
            ["chkMesh", "chkAnimation"],
            ["lblWidth","spnWidth"]
        ]
    }

    ui = GuiBase.BasicUI(u'頂點動畫工具', False)
    widgets = ui.generateUIByConfig(widgetData, layoutData, globals() )

    global chkMesh, chkAnimation, chkCloth, spnWidth
    chkMesh = widgets["chkMesh"]
    chkAnimation = widgets["chkAnimation"]
    chkCloth = widgets['chkCloth']
    spnWidth = widgets["spnWidth"]