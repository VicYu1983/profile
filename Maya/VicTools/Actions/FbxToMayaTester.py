from os import listdir
from os.path import isfile, join, exists
import random, json, os
import maya.cmds as cmds
import maya.mel as mel
import maya.api.OpenMaya as om
from datetime import datetime, date

infos = [
    (.94, "D:/FOD2_Project/Art_WorkData/Character/00_Hero/99_Source/XingYuan/BRIG_XingYuan0000.ma", "D:/FOD2_Project/Art_WorkData/Animation/00_Hero/XingYuan/Combat/Export"),
    # (.99, "D:/FOD2_Project/Art_WorkData/Character/01_Main/99_Source/nmo_WangLiang/BRIG_nmo_WangLiang00a.ma", "D:/FOD2_Project/Art_WorkData/Animation/01_Main/WangLiang/Combat/Export"),
    # (.98, "D:/FOD2_Project/Art_WorkData/Character/01_Main/99_Source/nmo_ShouYao/BRIG_nmo_ShouYao00.ma", "D:/FOD2_Project/Art_WorkData/Animation/01_Main/ShouYao/Combat/Export"),
    # (.99, "D:/FOD2_Project/Art_WorkData/Character/01_Main/99_Source/nmo_YinBing/BRIG_nmo_YinBing00a.ma", "D:/FOD2_Project/Art_WorkData/Animation/01_Main/YinBing/Combat/Export"),
    # (.94, "D:/FOD2_Project/Art_WorkData/Character/01_Main/99_Source/hhm_QiaoDou/BRIG_hhm_QiaoDou00a.ma", "D:/FOD2_Project/Art_WorkData/Animation/01_Main/QiaoDou/Drama/Export"),
    # (.99, "D:/FOD2_Project/Art_WorkData/Character/01_Main/99_Source/hmo_GuiCha/BRIG_hmo_GuiCha01a.ma", "D:/FOD2_Project/Art_WorkData/Animation/01_Main/GuiCha/GuiCha01/Combat/Export"),
    # (.85, "D:/FOD2_Project/Art_WorkData/Character/01_Main/99_Source/hmo_HuaYao/BRIG_hmo_HuaYao00a.ma", "D:/FOD2_Project/Art_WorkData/Animation/01_Main/HuaYao/Combat/Export"),
    # (.99, "D:/FOD2_Project/Art_WorkData/Character/01_Main/99_Source/nhm_ZuiHun/BRIG_nhm_ZuiHun00a.ma", "D:/FOD2_Project/Art_WorkData/Animation/01_Main/ZuiHun/Combat/Export"),
    # (.99, "D:/FOD2_Project/Art_WorkData/Character/02_Second/99_Source/m1_FuMo00/BRIG_m1_FuMo00.ma", "D:/FOD2_Project/Art_WorkData/Animation/02_Second/FumoM1/Drama/export"),
]

check_count = 1

ignoreList = (
    "root",
    "counter_P", 
    "kni_hand_ctrl_Arm2_L_JT", 
    "kni_hand_ctrl_Arm2_R_JT", 
    "kni_hand_ctrl_L_JT", 
    "kni_hand_ctrl_R_JT",
    "weapon_R_jnt_P2",
    "weapon_R_jnt_Ankle",
    "weapon_L_jnt_P2",
    "weapon_L_jnt_Ankle",
    "weapon_B_jnt_P2",
)

def writeJsonFile(path, content):
    f = open(path, "w")
    f.write(json.dumps(content, indent=4))
    f.close()

def importFBX( path ):
    mel.eval("FBXImportFillTimeline -v true;")
    mel.eval("FBXImportGenerateLog -v false;")
    mel.eval('FBXImportSkeletonDefinitionsAs -v "humanik";')
    mel.eval('FBXImportSkins -v false;')
    mel.eval('FBXImport -f "' + path + '";')

def execute():

    import AS_MotionConstrain
    reload(AS_MotionConstrain)

    save_folder = "E:/Vic/Works2/86_toolTester/errors/" + date.today().strftime("%y_%m_%d") + "_" + datetime.now().strftime("%H_%M_%S")
    if not os.path.exists(save_folder):
        os.makedirs(save_folder)

    output_infos = []

    for match_score, rig, animation_path in infos:
        fbx_files = [f for f in listdir(animation_path) if ".fbx" in f]
        check_ids = set()

        for i in range(check_count):
            check_ids.add( random.randint(0, len(fbx_files)-1))   

        output_info = {
            "rig":rig,
            "animations":[]
        }
        
        for check_id in check_ids:
            file_name = fbx_files[check_id]
            file_path = animation_path + "/" + file_name
            if exists(file_path):

                anima_info = {
                    "file_path":file_path,
                    "warning":[]
                }

                cmds.currentUnit(t="ntscf")

                cmds.file(force=1, new=1)
                importFBX(file_path)
                
                # fbx to maya
                jnts, char_name = AS_MotionConstrain.processWithAnimation(rig, False, 0)
                jnts = [jnt for jnt in jnts if cmds.objExists(char_name + ":" + jnt) and jnt not in ignoreList]

                minStr = int(cmds.playbackOptions(q=True,minTime=True))
                maxStr = int(cmds.playbackOptions(q=True,maxTime=True))

                # minStr = 705
                # maxStr = 715

                need_save = False
                total_match_value = 0
                total_distance_value = 0
                frames = range(minStr, maxStr)

                for i in frames:

                    cmds.currentTime(i)
                    match_value = 0
                    distance_value = 0

                    for jnt in jnts:

                        char_jnt = char_name + ":" + jnt
                        char_jnt_xform = cmds.xform(char_jnt, ws=1, m=1, q=1)

                        jnt_xform = cmds.xform(jnt, ws=1, m=1, q=1)

                        char_jnt_x_dir = om.MVector(char_jnt_xform[0], char_jnt_xform[1], char_jnt_xform[2])
                        jnt_x_dir = om.MVector(jnt_xform[0], jnt_xform[1], jnt_xform[2])

                        over_value = abs(char_jnt_x_dir * jnt_x_dir)
                        match_value += over_value

                        char_jnt_pos = om.MVector(char_jnt_xform[12], char_jnt_xform[13], char_jnt_xform[14])
                        jnt_pos = om.MVector(jnt_xform[12], jnt_xform[13], jnt_xform[14])
                        distance_from_jnt = (char_jnt_pos - jnt_pos).length()
                        distance_value += distance_from_jnt

                        # if distance_from_jnt > 2:
                        #     print((jnt, over_value, distance_from_jnt))

                    match_value /= len(jnts)
                    total_match_value += match_value

                    distance_value /= len(jnts)
                    total_distance_value += distance_value

                    if match_value < match_score: 
                        need_save = True
                        anima_info["warning"].append((i, match_value, distance_value))
                
                total_match_value /= len(frames)
                total_distance_value /= len(frames)

                anima_info["match"] = total_match_value
                anima_info["distance"] = total_distance_value
                anima_info["total_frame"] = len(frames)
                output_info["animations"].append(anima_info)

                if need_save:
                    save_name = file_name.replace("fbx", "ma")
                    save_path = save_folder + "/" + save_name
                    cmds.file(rename=save_path)
                    cmds.file(save=True,type='mayaAscii',force = True)

        output_infos.append(output_info)

        rig_name = rig.split("/")[-1].replace(".ma", "")
        writeJsonFile(save_folder + "/" + rig_name + "_report.txt", output_info)

    writeJsonFile(save_folder + "/total_report.txt", output_infos)
    print("finish check!")

