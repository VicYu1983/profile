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

# debug
try:
    cmds.delete("Camera")
except: pass

#jsonstr = '{"UeFolderName": "QTE_M6_CS_101_B", "scriptInfo": {"scriptVersion": "Ver_0_1"}, "ueAssetPath": "equencerBug", "fbxExportPath": "E:/Vic/Works2/31_mayaToSequencerBug/Export/M6_CS_101_B", "DirectorKeys": [{"camera": "shot1Camera", "Key": 0.0}], "groups": [{"groupType": "camera", "fovFrames": [], "name": "shot1Camera", "initAspectRatio": 1.7800000000000002, "initFovAngle": 56.51475145611375, "initTrans": {"rotaionZ": 79.9913727857672, "rotaionX": 90.38970905550906, "rotaionY": -9.541664044390547e-15, "translationZ": 4202.179681340765, "translationY": 198.0469288196934, "translationX": 26162.13468033344, "scaleX": 1.0, "scaleY": 1.0, "scaleZ": 1.0}, "movementKeyFrames": []}, {"groupType": "skelMesh", "name": "WL1", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 3685.400146484375, "translationY": 400.2471008300781, "translationX": 22125.59375, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": true, "time": 0.0}, {"bVisible": false, "time": 9.333333333333334}], "animSeq": "M6_CS_101_B_WL1", "animKeys": [{"animSeqName": "M6_CS_101_B_WL1_shot1", "time": 0.0}], "assetName": "BRIG_nmo_WangLiang00a"}, {"groupType": "skelMesh", "name": "XY1", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 3685.400146484375, "translationY": 400.2471008300781, "translationX": 22125.59375, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": true, "time": 0.0}, {"bVisible": false, "time": 9.333333333333334}], "animSeq": "M6_CS_101_B_XY1", "animKeys": [{"animSeqName": "M6_CS_101_B_XY1_shot1", "time": 0.0}], "assetName": "BRIG_XingYuan0000"}], "duration": 9.333333333333334}'

# 這個是沒有動畫的
#jsonstr = '{"UeFolderName": "QTE_M6_CS_306a_vic2", "scriptInfo": {"scriptVersion": "Ver_0_1"}, "ueAssetPath": "M6/M6_CS_306", "fbxExportPath": "D:/FOD2_Project/Art_WorkData/Animation/03_Cinematic/M6/M6_CS_306/Export/M6_CS_306a_vic2", "DirectorKeys": [{"camera": "shot1viccam", "Key": 0.0}, {"camera": "shot2viccam", "Key": 11.416666666666666}], "groups": [{"groupType": "camera", "fovFrames": [], "name": "shot1viccam", "initAspectRatio": 1.7800000000000002, "initFovAngle": 41.24833052020859, "initTrans": {"rotaionZ": 152.19689361572267, "rotaionX": 89.99999282304219, "rotaionY": 23.64878273010254, "translationZ": 59.3255906265334, "translationY": -1852.4814280628673, "translationX": 828.8108642432103, "scaleX": 1.0, "scaleY": 0.9999999999999999, "scaleZ": 0.9999999999999999}, "movementKeyFrames": []}, {"groupType": "camera", "fovFrames": [], "name": "shot2viccam", "initAspectRatio": 1.7800000000000002, "initFovAngle": 41.24833052020859, "initTrans": {"rotaionZ": 152.19689361572267, "rotaionX": 89.99999282304219, "rotaionY": 23.64878273010254, "translationZ": 59.3255906265334, "translationY": -1852.4814280628673, "translationX": 828.8108642432103, "scaleX": 1.0, "scaleY": 0.9999999999999999, "scaleZ": 0.9999999999999999}, "movementKeyFrames": []}, {"groupType": "skelMesh", "name": "BRIG_bos_ShuYao04a_a", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 0, "translationY": 0, "translationX": 0, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 0.0}], "animSeq": "M6_CS_306a_vic2_BRIG_bos_ShuYao04a_a", "animKeys": [], "assetName": "BRIG_bos_ShuYao04a"}, {"groupType": "skelMesh", "name": "BRIG_bos_ShuYao04a1", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 0, "translationY": 0, "translationX": 0, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 0.0}], "animSeq": "M6_CS_306a_vic2_BRIG_bos_ShuYao04a1", "animKeys": [], "assetName": "BRIG_bos_ShuYao04a"}, {"groupType": "skelMesh", "name": "BRIG_bos_ShuYao04c_a", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 0, "translationY": 0, "translationX": 0, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 20.733333333333334}], "animSeq": "M6_CS_306a_vic2_BRIG_bos_ShuYao04c_a", "animKeys": [], "assetName": "BRIG_bos_ShuYao04c"}, {"groupType": "skelMesh", "name": "QD1", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 0, "translationY": 0, "translationX": 0, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 0.0}], "animSeq": "M6_CS_306a_vic2_QD1", "animKeys": [], "assetName": "BRIG_hhm_QiaoDou00a"}, {"groupType": "skelMesh", "name": "ShuNew1", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 0, "translationY": 0, "translationX": 0, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 0.0}], "animSeq": "M6_CS_306a_vic2_ShuNew1", "animKeys": [], "assetName": "BRIG_bos_ShuYao00a"}, {"groupType": "skelMesh", "name": "XY1", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 0, "translationY": 0, "translationX": 0, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 0.0}], "animSeq": "M6_CS_306a_vic2_XY1", "animKeys": [], "assetName": "BRIG_XingYuan0000"}, {"groupType": "skelMesh", "name": "BRIG_bos_ShuYao04a", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 0, "translationY": 0, "translationX": 0, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 6.8}, {"bVisible": true, "time": 6.816666666666666}, {"bVisible": true, "time": 9.1}, {"bVisible": false, "time": 9.116666666666667}], "animSeq": "M6_CS_306a_vic2_BRIG_bos_ShuYao04a", "animKeys": [], "assetName": "BRIG_bos_ShuYao04a"}, {"groupType": "skelMesh", "name": "BRIG_bos_ShuYao04a2", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 0, "translationY": 0, "translationX": 0, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 6.8}, {"bVisible": true, "time": 6.816666666666666}, {"bVisible": true, "time": 9.1}, {"bVisible": false, "time": 9.116666666666667}], "animSeq": "M6_CS_306a_vic2_BRIG_bos_ShuYao04a2", "animKeys": [], "assetName": "BRIG_bos_ShuYao04a"}, {"groupType": "skelMesh", "name": "BRIG_bos_ShuYao04b", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 0, "translationY": 0, "translationX": 0, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 9.083333333333334}, {"bVisible": true, "time": 9.1}, {"bVisible": true, "time": 16.083333333333332}, {"bVisible": false, "time": 16.1}], "animSeq": "M6_CS_306a_vic2_BRIG_bos_ShuYao04b", "animKeys": [], "assetName": "BRIG_bos_ShuYao04b"}, {"groupType": "skelMesh", "name": "BRIG_bos_ShuYao04b2", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 0, "translationY": 0, "translationX": 0, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 0.0}], "animSeq": "M6_CS_306a_vic2_BRIG_bos_ShuYao04b2", "animKeys": [], "assetName": "BRIG_bos_ShuYao04b"}, {"groupType": "skelMesh", "name": "BRIG_bos_ShuYao04c", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 0, "translationY": 0, "translationX": 0, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 16.083333333333332}, {"bVisible": true, "time": 16.1}, {"bVisible": true, "time": 18.466666666666665}, {"bVisible": false, "time": 18.483333333333334}], "animSeq": "M6_CS_306a_vic2_BRIG_bos_ShuYao04c", "animKeys": [], "assetName": "BRIG_bos_ShuYao04c"}, {"groupType": "skelMesh", "name": "BRIG_bos_ShuYao04c2", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 0, "translationY": 0, "translationX": 0, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 16.083333333333332}, {"bVisible": true, "time": 16.1}, {"bVisible": true, "time": 18.466666666666665}, {"bVisible": false, "time": 18.483333333333334}], "animSeq": "M6_CS_306a_vic2_BRIG_bos_ShuYao04c2", "animKeys": [], "assetName": "BRIG_bos_ShuYao04c"}, {"groupType": "skelMesh", "name": "BRIG_bos_ShuYao04c3", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 0, "translationY": 0, "translationX": 0, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 16.083333333333332}, {"bVisible": true, "time": 16.1}, {"bVisible": true, "time": 20.733333333333334}, {"bVisible": false, "time": 20.75}], "animSeq": "M6_CS_306a_vic2_BRIG_bos_ShuYao04c3", "animKeys": [], "assetName": "BRIG_bos_ShuYao04c"}, {"groupType": "skelMesh", "name": "BRIG_bos_ShuYao04c4", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 0, "translationY": 0, "translationX": 0, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 16.083333333333332}, {"bVisible": true, "time": 16.1}, {"bVisible": true, "time": 18.466666666666665}, {"bVisible": false, "time": 18.483333333333334}], "animSeq": "M6_CS_306a_vic2_BRIG_bos_ShuYao04c4", "animKeys": [], "assetName": "BRIG_bos_ShuYao04c"}], "duration": 11.416666666666666}'

# 這個暫時跑不過
# jsonstr = '{"UeFolderName": "QTE_MB_CS_103_new", "scriptInfo": {"scriptVersion": "Ver_0_1"}, "ueAssetPath": "Works2/31_mayaToSequencerBug", "fbxExportPath": "E:/Vic/Works2/31_mayaToSequencerBug/Export/MB_CS_103_new", "DirectorKeys": [{"camera": "shot1Camera", "Key": 0.0}, {"camera": "shot2Camera", "Key": 5.983333333333333}, {"camera": "shot3Camera", "Key": 14.35}], "groups": [{"groupType": "camera", "fovFrames": [], "name": "shot1Camera", "initAspectRatio": 1.7794117647058822, "initFovAngle": 59.90647011244938, "initTrans": {"rotaionZ": 164.1497039794922, "rotaionX": 90.00202941894531, "rotaionY": 0.6278363466262817, "translationZ": 1167.7544479370117, "translationY": -3485.153778076172, "translationX": 13965.8310546875, "scaleX": 1.0, "scaleY": 1.0, "scaleZ": 0.9999999999999999}, "movementKeyFrames": []}, {"groupType": "camera", "fovFrames": [], "name": "shot2Camera", "initAspectRatio": 1.7794117647058822, "initFovAngle": 59.90647011244938, "initTrans": {"rotaionZ": 164.1497039794922, "rotaionX": 90.00202941894531, "rotaionY": 0.6278363466262817, "translationZ": 1167.7544479370117, "translationY": -3485.153778076172, "translationX": 13965.8310546875, "scaleX": 1.0, "scaleY": 1.0, "scaleZ": 0.9999999999999999}, "movementKeyFrames": []}, {"groupType": "camera", "fovFrames": [], "name": "shot3Camera", "initAspectRatio": 1.7794117647058822, "initFovAngle": 59.90647011244938, "initTrans": {"rotaionZ": 164.1497039794922, "rotaionX": 90.00202941894531, "rotaionY": 0.6278363466262817, "translationZ": 1167.7544479370117, "translationY": -3485.153778076172, "translationX": 13965.8310546875, "scaleX": 1.0, "scaleY": 1.0, "scaleZ": 0.9999999999999999}, "movementKeyFrames": []}, {"groupType": "skelMesh", "name": "BRIG_Bas_001", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 1054.515625, "translationY": -3250.237548828125, "translationX": 12920.7099609375, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 0.0}, {"bVisible": true, "time": 14.35}, {"bVisible": false, "time": 35.75}], "animSeq": "MB_CS_103_new_BRIG_Bas_001", "animKeys": [{"animSeqName": "MB_CS_103_new_BRIG_Bas_001_shot3", "time": 14.283333333333333}], "assetName": "BRIG_Bas_001"}, {"groupType": "skelMesh", "name": "BRIG_Bas_002", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 1054.515625, "translationY": -3250.237548828125, "translationX": 12920.7099609375, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 0.0}, {"bVisible": true, "time": 5.983333333333333}, {"bVisible": false, "time": 35.75}], "animSeq": "MB_CS_103_new_BRIG_Bas_002", "animKeys": [{"animSeqName": "MB_CS_103_new_BRIG_Bas_002_shot2", "time": 5.916666666666667}, {"animSeqName": "MB_CS_103_new_BRIG_Bas_002_shot3", "time": 14.35}], "assetName": "BRIG_Bas_001"}, {"groupType": "skelMesh", "name": "BRIG_Bas_003", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 1054.515625, "translationY": -3250.237548828125, "translationX": 12920.7099609375, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 0.0}, {"bVisible": true, "time": 14.35}, {"bVisible": false, "time": 35.75}], "animSeq": "MB_CS_103_new_BRIG_Bas_003", "animKeys": [{"animSeqName": "MB_CS_103_new_BRIG_Bas_003_shot3", "time": 14.283333333333333}], "assetName": "BRIG_Bas_001"}, {"groupType": "skelMesh", "name": "BRIG_nmo_WangLiang00a_Skeleton", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 1054.515625, "translationY": -3250.237548828125, "translationX": 12920.7099609375, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 0.0}, {"bVisible": true, "time": 14.35}, {"bVisible": false, "time": 35.75}], "animSeq": "MB_CS_103_new_BRIG_nmo_WangLiang00a_Skeleton", "animKeys": [{"animSeqName": "MB_CS_103_new_BRIG_nmo_WangLiang00a_Skeleton_shot3", "time": 14.283333333333333}], "assetName": "BRIG_nmo_WangLiang00a"}, {"groupType": "skelMesh", "name": "Fumo1", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 1054.515625, "translationY": -3250.237548828125, "translationX": 12920.7099609375, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 0.0}, {"bVisible": true, "time": 14.35}, {"bVisible": false, "time": 35.75}], "animSeq": "MB_CS_103_new_Fumo1", "animKeys": [{"animSeqName": "MB_CS_103_new_Fumo1_shot3", "time": 14.283333333333333}], "assetName": "BRIG_m1_FuMo00"}, {"groupType": "skelMesh", "name": "QiaoDou1", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 1054.515625, "translationY": -3250.237548828125, "translationX": 12920.7099609375, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 0.0}, {"bVisible": true, "time": 14.35}, {"bVisible": false, "time": 35.75}], "animSeq": "MB_CS_103_new_QiaoDou1", "animKeys": [{"animSeqName": "MB_CS_103_new_QiaoDou1_shot3", "time": 14.283333333333333}], "assetName": "BRIG_hhm_QiaoDou00a"}, {"groupType": "skelMesh", "name": "TEMPORARY_REFERENCE_NAMESPACE_Fumo", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 1054.515625, "translationY": -3250.237548828125, "translationX": 12920.7099609375, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 0.0}, {"bVisible": true, "time": 14.35}, {"bVisible": false, "time": 35.75}], "animSeq": "MB_CS_103_new_TEMPORARY_REFERENCE_NAMESPACE_Fumo", "animKeys": [{"animSeqName": "MB_CS_103_new_TEMPORARY_REFERENCE_NAMESPACE_Fumo_shot3", "time": 14.283333333333333}], "assetName": "BRIG_m1_FuMo00"}, {"groupType": "skelMesh", "name": "WL1", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 1054.515625, "translationY": -3250.237548828125, "translationX": 12920.7099609375, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 0.0}, {"bVisible": true, "time": 14.35}, {"bVisible": false, "time": 35.75}], "animSeq": "MB_CS_103_new_WL1", "animKeys": [{"animSeqName": "MB_CS_103_new_WL1_shot3", "time": 14.283333333333333}], "assetName": "BRIG_nmo_WangLiang00a"}, {"groupType": "skelMesh", "name": "WL2", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 1054.515625, "translationY": -3250.237548828125, "translationX": 12920.7099609375, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 0.0}, {"bVisible": true, "time": 14.35}, {"bVisible": false, "time": 35.75}], "animSeq": "MB_CS_103_new_WL2", "animKeys": [{"animSeqName": "MB_CS_103_new_WL2_shot3", "time": 14.283333333333333}], "assetName": "BRIG_nmo_WangLiang00a"}, {"groupType": "skelMesh", "name": "WL3", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 1054.515625, "translationY": -3250.237548828125, "translationX": 12920.7099609375, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 0.0}, {"bVisible": true, "time": 14.35}, {"bVisible": false, "time": 35.75}], "animSeq": "MB_CS_103_new_WL3", "animKeys": [{"animSeqName": "MB_CS_103_new_WL3_shot3", "time": 14.283333333333333}], "assetName": "BRIG_nmo_WangLiang00a"}, {"groupType": "skelMesh", "name": "XingYuan1", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 1054.515625, "translationY": -3250.237548828125, "translationX": 12920.7099609375, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": false, "time": 0.0}, {"bVisible": true, "time": 5.983333333333333}, {"bVisible": false, "time": 35.75}], "animSeq": "MB_CS_103_new_XingYuan1", "animKeys": [{"animSeqName": "MB_CS_103_new_XingYuan1_shot2", "time": 5.916666666666667}, {"animSeqName": "MB_CS_103_new_XingYuan1_shot3", "time": 14.35}], "assetName": "BRIG_XingYuan0000"}], "duration": 35.75}'

# 看不到動畫？？
#jsonstr = '{"UeFolderName":"QTE_MB_CS_103_new","scriptInfo":{"scriptVersion":"Ver_0_1"},"ueAssetPath":"Works2/31_mayaToSequencerBug","fbxExportPath":"E:/Vic/Works2/31_mayaToSequencerBug/Export/MB_CS_103_new","DirectorKeys":[{"camera":"shot1Camera","Key":0},{"camera":"shot2Camera","Key":5.983333333333333},{"camera":"shot3Camera","Key":14.35}],"groups":[{"groupType":"camera","fovFrames":[],"name":"shot1Camera","initAspectRatio":1.7794117647058822,"initFovAngle":59.90647011244938,"initTrans":{"rotaionZ":164.1497039794922,"rotaionX":90.00202941894531,"rotaionY":0.6278363466262817,"translationZ":1167.7544479370117,"translationY":-3485.153778076172,"translationX":13965.8310546875,"scaleX":1,"scaleY":1,"scaleZ":0.9999999999999999},"movementKeyFrames":[]},{"groupType":"camera","name":"shot2Camera","initTrans":{"rotaionZ":164.1497039794922,"rotaionX":90.00202941894531,"rotaionY":0.6278363466262817,"translationZ":1167.7544479370117,"translationY":-3485.153778076172,"translationX":13965.8310546875,"scaleX":1,"scaleY":1,"scaleZ":0.9999999999999999},"fovFrames":[],"initAspectRatio":1.7794117647058822,"initFovAngle":59.90647011244938,"movementKeyFrames":[]},{"groupType":"camera","name":"shot3Camera","initTrans":{"rotaionZ":164.1497039794922,"rotaionX":90.00202941894531,"rotaionY":0.6278363466262817,"translationZ":1167.7544479370117,"translationY":-3485.153778076172,"translationX":13965.8310546875,"scaleX":1,"scaleY":1,"scaleZ":0.9999999999999999},"fovFrames":[],"initAspectRatio":1.7794117647058822,"initFovAngle":59.90647011244938,"movementKeyFrames":[]},{"groupType":"skelMesh","name":"QiaoDou1","exportType":"skelMeshActor","initTrans":{"rotaionZ":0,"rotaionX":0,"rotaionY":0,"translationZ":1054.515625,"translationY":-3250.237548828125,"translationX":12920.7099609375,"scaleX":1,"scaleY":1,"scaleZ":1},"visibleKeys":[{"bVisible":false,"time":0},{"bVisible":true,"time":14.35},{"bVisible":false,"time":35.75}],"animSeq":"MB_CS_103_new_QiaoDou1","animKeys":[{"animSeqName":"MB_CS_103_new_QiaoDou1_shot3","time":14.283333333333333}],"assetName":"BRIG_hhm_QiaoDou00a"},{"groupType":"skelMesh","name":"XingYuan1","exportType":"skelMeshActor","initTrans":{"rotaionZ":0,"rotaionX":0,"rotaionY":0,"translationZ":1054.515625,"translationY":-3250.237548828125,"translationX":12920.7099609375,"scaleX":1,"scaleY":1,"scaleZ":1},"visibleKeys":[{"bVisible":false,"time":0},{"bVisible":true,"time":5.983333333333333},{"bVisible":false,"time":35.75}],"animSeq":"MB_CS_103_new_XingYuan1","animKeys":[{"animSeqName":"MB_CS_103_new_XingYuan1_shot2","time":5.916666666666667},{"animSeqName":"MB_CS_103_new_XingYuan1_shot3","time":14.35}],"assetName":"BRIG_XingYuan0000"}],"duration":35.75}'

#jsonstr = '{"UeFolderName":"QTE_MB_CS_103_new","scriptInfo":{"scriptVersion":"Ver_0_1"},"ueAssetPath":"Works2/31_mayaToSequencerBug","fbxExportPath":"E:/Vic/Works2/31_mayaToSequencerBug/Export/MB_CS_103_new","DirectorKeys":[{"camera":"shot1Camera","Key":0},{"camera":"shot2Camera","Key":5.983333333333333},{"camera":"shot3Camera","Key":14.35}],"groups":[{"groupType":"camera","fovFrames":[],"name":"shot1Camera","initAspectRatio":1.7794117647058822,"initFovAngle":59.90647011244938,"initTrans":{"rotaionZ":164.1497039794922,"rotaionX":90.00202941894531,"rotaionY":0.6278363466262817,"translationZ":1167.7544479370117,"translationY":-3485.153778076172,"translationX":13965.8310546875,"scaleX":1,"scaleY":1,"scaleZ":0.9999999999999999},"movementKeyFrames":[]},{"groupType":"camera","name":"shot2Camera","initTrans":{"rotaionZ":164.1497039794922,"rotaionX":90.00202941894531,"rotaionY":0.6278363466262817,"translationZ":1167.7544479370117,"translationY":-3485.153778076172,"translationX":13965.8310546875,"scaleX":1,"scaleY":1,"scaleZ":0.9999999999999999},"fovFrames":[],"initAspectRatio":1.7794117647058822,"initFovAngle":59.90647011244938,"movementKeyFrames":[]},{"groupType":"camera","name":"shot3Camera","initTrans":{"rotaionZ":164.1497039794922,"rotaionX":90.00202941894531,"rotaionY":0.6278363466262817,"translationZ":1167.7544479370117,"translationY":-3485.153778076172,"translationX":13965.8310546875,"scaleX":1,"scaleY":1,"scaleZ":0.9999999999999999},"fovFrames":[],"initAspectRatio":1.7794117647058822,"initFovAngle":59.90647011244938,"movementKeyFrames":[]},{"groupType":"skelMesh","name":"QiaoDou1","exportType":"skelMeshActor","initTrans":{"rotaionZ":0,"rotaionX":0,"rotaionY":0,"translationZ":1054.515625,"translationY":-3250.237548828125,"translationX":12920.7099609375,"scaleX":1,"scaleY":1,"scaleZ":1},"visibleKeys":[{"bVisible":false,"time":0},{"bVisible":true,"time":14.35},{"bVisible":false,"time":35.75}],"animSeq":"MB_CS_103_new_QiaoDou1","animKeys":[{"animSeqName":"MB_CS_103_new_QiaoDou1_shot3","time":14.283333333333333}],"assetName":"BRIG_hhm_QiaoDou00a"}],"duration":35.75}'
#jsonstr = '{"UeFolderName":"QTE_M6_CS_101_B2_vic","scriptInfo":{"scriptVersion":"Ver_0_1"},"ueAssetPath":"Works2/31_mayaToSequencerBug","fbxExportPath":"E:/Vic/Works2/31_mayaToSequencerBug/Export/M6_CS_101_B2_vic","DirectorKeys":[{"camera":"shot1Camera","Key":0},{"camera":"shot2Camera","Key":0.5166666666666666},{"camera":"shot3Camera","Key":1.0166666666666666}],"groups":[{"groupType":"camera","fovFrames":[],"name":"shot1Camera","initAspectRatio":1.7800000000000002,"initFovAngle":56.51475145611375,"initTrans":{"rotaionZ":79.9913727857672,"rotaionX":90.38970905550903,"rotaionY":0,"translationZ":931.2964172363281,"translationY":-3522.9860229492188,"translationX":24096.123413085938,"scaleX":1,"scaleY":1,"scaleZ":1},"movementKeyFrames":[]},{"groupType":"camera","fovFrames":[],"name":"shot2Camera","initAspectRatio":1.7800000000000002,"initFovAngle":56.51475145611375,"initTrans":{"rotaionZ":79.9913727857672,"rotaionX":90.38970905550903,"rotaionY":0,"translationZ":931.2964172363281,"translationY":-3522.9860229492188,"translationX":24096.123413085938,"scaleX":1,"scaleY":1,"scaleZ":1},"movementKeyFrames":[]},{"groupType":"camera","fovFrames":[],"name":"shot3Camera","initAspectRatio":1.7800000000000002,"initFovAngle":56.51475145611375,"initTrans":{"rotaionZ":79.9913727857672,"rotaionX":90.38970905550903,"rotaionY":0,"translationZ":931.2964172363281,"translationY":-3522.9860229492188,"translationX":24096.123413085938,"scaleX":1,"scaleY":1,"scaleZ":1},"movementKeyFrames":[]},{"groupType":"skelMesh","name":"WL1","exportType":"skelMeshActor","initTrans":{"rotaionZ":0,"rotaionX":0,"rotaionY":0,"translationZ":400.2471008300781,"translationY":-3685.400146484375,"translationX":22125.59375,"scaleX":1,"scaleY":1,"scaleZ":1},"visibleKeys":[{"bVisible":true,"time":0},{"bVisible":false,"time":1.5}],"animSeq":"M6_CS_101_B2_vic_WL1","animKeys":[{"animSeqName":"M6_CS_101_B2_vic_WL1_shot1","time":0},{"animSeqName":"M6_CS_101_B2_vic_WL1_shot2","time":0.5166666666666666},{"animSeqName":"M6_CS_101_B2_vic_WL1_shot3","time":1.0166666666666666}],"assetName":"BRIG_nmo_WangLiang00a"},{"groupType":"skelMesh","name":"XY1","exportType":"skelMeshActor","initTrans":{"rotaionZ":0,"rotaionX":0,"rotaionY":0,"translationZ":400.2471008300781,"translationY":-3685.400146484375,"translationX":22125.59375,"scaleX":1,"scaleY":1,"scaleZ":1},"visibleKeys":[{"bVisible":true,"time":0},{"bVisible":false,"time":1.5}],"animSeq":"M6_CS_101_B2_vic_XY1","animKeys":[{"animSeqName":"M6_CS_101_B2_vic_XY1_shot1","time":0},{"animSeqName":"M6_CS_101_B2_vic_XY1_shot2","time":0.5166666666666666},{"animSeqName":"M6_CS_101_B2_vic_XY1_shot3","time":1.0166666666666666}],"assetName":"BRIG_XingYuan0000"}],"duration":1.6666666666666667}'
#jsonstr = '{"UeFolderName":"QTE_M6_CS_101_B2_vic","scriptInfo":{"scriptVersion":"Ver_0_1"},"ueAssetPath":"Works2/31_mayaToSequencerBug","fbxExportPath":"E:/Vic/Works2/31_mayaToSequencerBug/Export/M6_CS_101_B2_vic","DirectorKeys":[{"camera":"shot1Camera","Key":0},{"camera":"shot2Camera","Key":0.5166666666666666},{"camera":"shot3Camera","Key":1.0166666666666666}],"groups":[{"groupType":"camera","fovFrames":[],"name":"shot1Camera","initAspectRatio":1.7800000000000002,"initFovAngle":56.51475145611375,"initTrans":{"rotaionZ":79.9913727857672,"rotaionX":90.38970905550903,"rotaionY":0,"translationZ":931.2964172363281,"translationY":-3522.9860229492188,"translationX":24096.123413085938,"scaleX":1,"scaleY":1,"scaleZ":1},"movementKeyFrames":[]},{"groupType":"camera","name":"shot2Camera","initTrans":{"rotaionZ":79.9913727857672,"rotaionX":90.38970905550903,"rotaionY":0,"translationZ":931.2964172363281,"translationY":-3522.9860229492188,"translationX":24096.123413085938,"scaleX":1,"scaleY":1,"scaleZ":1},"fovFrames":[],"initAspectRatio":1.7800000000000002,"initFovAngle":56.51475145611375,"movementKeyFrames":[]},{"groupType":"camera","name":"shot3Camera","initTrans":{"rotaionZ":79.9913727857672,"rotaionX":90.38970905550903,"rotaionY":0,"translationZ":931.2964172363281,"translationY":-3522.9860229492188,"translationX":24096.123413085938,"scaleX":1,"scaleY":1,"scaleZ":1},"fovFrames":[],"initAspectRatio":1.7800000000000002,"initFovAngle":56.51475145611375,"movementKeyFrames":[]},{"groupType":"skelMesh","name":"XY1","exportType":"skelMeshActor","initTrans":{"rotaionZ":0,"rotaionX":0,"rotaionY":0,"translationZ":400.2471008300781,"translationY":-3685.400146484375,"translationX":22125.59375,"scaleX":1,"scaleY":1,"scaleZ":1},"visibleKeys":[{"bVisible":true,"time":0},{"bVisible":false,"time":1.5}],"animSeq":"M6_CS_101_B2_vic_XY1","animKeys":[{"animSeqName":"M6_CS_101_B2_vic_XY1_shot1","time":0},{"animSeqName":"M6_CS_101_B2_vic_XY1_shot2","time":0.5166666666666666},{"animSeqName":"M6_CS_101_B2_vic_XY1_shot3","time":1.0166666666666666}],"assetName":"BRIG_XingYuan0000"}],"duration":1.6666666666666667}'
jsonstr = '{"UeFolderName": "QTE_testScene_splite", "scriptInfo": {"scriptVersion": "Ver_0_1"}, "ueAssetPath": "Works2/59_sequencerToMaya", "fbxExportPath": "E:/Vic/Works2/59_sequencerToMaya/Export/testScene_splite", "DirectorKeys": [{"camera": "shot1camera1", "Key": 0.041666666666666664}, {"camera": "shot1Endcamera1", "Key": 0.26666666666666666}], "groups": [{"groupType": "camera", "fovFrames": [], "name": "shot1camera1", "initAspectRatio": 1.4999999999999998, "initFovAngle": 54.80321002812307, "initTrans": {"rotaionZ": 3.199998761801405, "rotaionX": 80.4000204905668, "rotaionY": -5.963540027744096e-16, "translationZ": 5155.93603515625, "translationY": -17542.7265625, "translationX": 21933.123046875, "scaleX": 10.0, "scaleY": 10.0, "scaleZ": 10.0}, "movementKeyFrames": []}, {"groupType": "camera", "fovFrames": [], "name": "shot1Endcamera1", "initAspectRatio": 1.4999999999999998, "initFovAngle": 54.80321002812307, "initTrans": {"rotaionZ": 3.199998761801405, "rotaionX": 80.4000204905668, "rotaionY": -5.963540027744096e-16, "translationZ": 5155.93603515625, "translationY": -17542.7265625, "translationX": 21933.123046875, "scaleX": 10.0, "scaleY": 10.0, "scaleZ": 10.0}, "movementKeyFrames": []}, {"groupType": "skelMesh", "name": "BRIG_Bas_001", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 5065.93603515625, "translationY": -17142.7265625, "translationX": 22013.123046875, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": true, "time": 0.041666666666666664}, {"bVisible": false, "time": 0.5}], "animSeq": "testScene_splite_BRIG_Bas_001", "animKeys": [{"animSeqName": "testScene_splite_BRIG_Bas_001_shot1", "time": 0.041666666666666664}, {"animSeqName": "testScene_splite_BRIG_Bas_001_shot1End", "time": 0.26666666666666666}], "assetName": "BRIG_Bas_001"}, {"groupType": "skelMesh", "name": "BRIG_XingYuan0000", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 5065.93603515625, "translationY": -17142.7265625, "translationX": 22013.123046875, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": true, "time": 0.041666666666666664}, {"bVisible": false, "time": 0.5}], "animSeq": "testScene_splite_BRIG_XingYuan0000", "animKeys": [{"animSeqName": "testScene_splite_BRIG_XingYuan0000_shot1", "time": 0.041666666666666664}, {"animSeqName": "testScene_splite_BRIG_XingYuan0000_shot1End", "time": 0.26666666666666666}], "assetName": "BRIG_XingYuan0000"}, {"groupType": "skelMesh", "name": "BRIG_bos_FuTeng00a", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 5065.93603515625, "translationY": -17142.7265625, "translationX": 22013.123046875, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": true, "time": 0.041666666666666664}, {"bVisible": false, "time": 0.5}], "animSeq": "testScene_splite_BRIG_bos_FuTeng00a", "animKeys": [{"animSeqName": "testScene_splite_BRIG_bos_FuTeng00a_shot1", "time": 0.041666666666666664}, {"animSeqName": "testScene_splite_BRIG_bos_FuTeng00a_shot1End", "time": 0.26666666666666666}], "assetName": "BRIG_bos_FuTeng00a"}, {"groupType": "skelMesh", "name": "BRIG_nmo_WangLiang00a", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 5065.93603515625, "translationY": -17142.7265625, "translationX": 22013.123046875, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": true, "time": 0.041666666666666664}, {"bVisible": false, "time": 0.5}], "animSeq": "testScene_splite_BRIG_nmo_WangLiang00a", "animKeys": [{"animSeqName": "testScene_splite_BRIG_nmo_WangLiang00a_shot1", "time": 0.041666666666666664}, {"animSeqName": "testScene_splite_BRIG_nmo_WangLiang00a_shot1End", "time": 0.26666666666666666}], "assetName": "BRIG_nmo_WangLiang00a"}, {"groupType": "skelMesh", "name": "BRIG_wea_Allpowerful_00", "exportType": "skelMeshActor", "initTrans": {"rotaionZ": 0, "rotaionX": 0, "rotaionY": 0, "translationZ": 5065.93603515625, "translationY": -17142.7265625, "translationX": 22013.123046875, "scaleX": 1, "scaleY": 1, "scaleZ": 1}, "visibleKeys": [{"bVisible": true, "time": 0.041666666666666664}, {"bVisible": false, "time": 0.5}], "animSeq": "testScene_splite_BRIG_wea_Allpowerful_00", "animKeys": [{"animSeqName": "testScene_splite_BRIG_wea_Allpowerful_00_shot1", "time": 0.041666666666666664}, {"animSeqName": "testScene_splite_BRIG_wea_Allpowerful_00_shot1End", "time": 0.26666666666666666}], "assetName": "BRIG_wea_Allpowerful_00"}], "duration": 0.5166666666666666}'
jsonstr = '{"UeFolderName":"QTE_testScene_splite","scriptInfo":{"scriptVersion":"Ver_0_1"},"ueAssetPath":"Works2/59_sequencerToMaya","fbxExportPath":"E:/Vic/Works2/59_sequencerToMaya/Export/testScene_splite_testback","DirectorKeys":[{"camera":"shot1camera1","Key":0.041666666666666664},{"camera":"shot1Endcamera1","Key":0.26666666666666666}],"groups":[{"groupType":"camera","fovFrames":[],"name":"shot1camera1","initAspectRatio":1.4999999999999998,"initFovAngle":54.80321002812307,"initTrans":{"rotaionZ":3.199998761801405,"rotaionX":80.4000204905668,"rotaionY":-5.963540027744096e-16,"translationZ":5155.93603515625,"translationY":-17542.7265625,"translationX":21933.123046875,"scaleX":10,"scaleY":10,"scaleZ":10},"movementKeyFrames":[]},{"groupType":"camera","fovFrames":[],"name":"shot1Endcamera1","initAspectRatio":1.4999999999999998,"initFovAngle":54.80321002812307,"initTrans":{"rotaionZ":3.199998761801405,"rotaionX":80.4000204905668,"rotaionY":-5.963540027744096e-16,"translationZ":5155.93603515625,"translationY":-17542.7265625,"translationX":21933.123046875,"scaleX":10,"scaleY":10,"scaleZ":10},"movementKeyFrames":[]},{"groupType":"skelMesh","name":"BRIG_Bas_001","exportType":"skelMeshActor","initTrans":{"rotaionZ":0,"rotaionX":0,"rotaionY":0,"translationZ":5065.93603515625,"translationY":-17142.7265625,"translationX":22013.123046875,"scaleX":1,"scaleY":1,"scaleZ":1},"visibleKeys":[{"bVisible":true,"time":0.041666666666666664},{"bVisible":false,"time":0.5}],"animSeq":"testScene_splite_BRIG_Bas_001","animKeys":[{"animSeqName":"testScene_splite_BRIG_Bas_001_shot1","time":0.041666666666666664},{"animSeqName":"testScene_splite_BRIG_Bas_001_shot1End","time":0.26666666666666666}],"assetName":"BRIG_Bas_001"},{"groupType":"skelMesh","name":"BRIG_XingYuan0000","exportType":"skelMeshActor","initTrans":{"rotaionZ":0,"rotaionX":0,"rotaionY":0,"translationZ":5065.93603515625,"translationY":-17142.7265625,"translationX":22013.123046875,"scaleX":1,"scaleY":1,"scaleZ":1},"visibleKeys":[{"bVisible":true,"time":0.041666666666666664},{"bVisible":false,"time":0.5}],"animSeq":"testScene_splite_BRIG_XingYuan0000","animKeys":[{"animSeqName":"testScene_splite_BRIG_XingYuan0000_shot1","time":0.041666666666666664},{"animSeqName":"testScene_splite_BRIG_XingYuan0000_shot1End","time":0.26666666666666666}],"assetName":"BRIG_XingYuan0000"},{"groupType":"skelMesh","name":"BRIG_bos_FuTeng00a","exportType":"skelMeshActor","initTrans":{"rotaionZ":0,"rotaionX":0,"rotaionY":0,"translationZ":5065.93603515625,"translationY":-17142.7265625,"translationX":22013.123046875,"scaleX":1,"scaleY":1,"scaleZ":1},"visibleKeys":[{"bVisible":true,"time":0.041666666666666664},{"bVisible":false,"time":0.5}],"animSeq":"testScene_splite_BRIG_bos_FuTeng00a","animKeys":[{"animSeqName":"testScene_splite_BRIG_bos_FuTeng00a_shot1","time":0.041666666666666664},{"animSeqName":"testScene_splite_BRIG_bos_FuTeng00a_shot1End","time":0.26666666666666666}],"assetName":"BRIG_bos_FuTeng00a"},{"groupType":"skelMesh","name":"BRIG_nmo_WangLiang00a","exportType":"skelMeshActor","initTrans":{"rotaionZ":0,"rotaionX":0,"rotaionY":0,"translationZ":5065.93603515625,"translationY":-17142.7265625,"translationX":22013.123046875,"scaleX":1,"scaleY":1,"scaleZ":1},"visibleKeys":[{"bVisible":true,"time":0.041666666666666664},{"bVisible":false,"time":0.5}],"animSeq":"testScene_splite_BRIG_nmo_WangLiang00a","animKeys":[{"animSeqName":"testScene_splite_BRIG_nmo_WangLiang00a_shot1","time":0.041666666666666664},{"animSeqName":"testScene_splite_BRIG_nmo_WangLiang00a_shot1End","time":0.26666666666666666}],"assetName":"BRIG_nmo_WangLiang00a"},{"groupType":"skelMesh","name":"BRIG_wea_Allpowerful_00","exportType":"skelMeshActor","initTrans":{"rotaionZ":0,"rotaionX":0,"rotaionY":0,"translationZ":5065.93603515625,"translationY":-17142.7265625,"translationX":22013.123046875,"scaleX":1,"scaleY":1,"scaleZ":1},"visibleKeys":[{"bVisible":true,"time":0.041666666666666664},{"bVisible":false,"time":0.5}],"animSeq":"testScene_splite_BRIG_wea_Allpowerful_00","animKeys":[{"animSeqName":"testScene_splite_BRIG_wea_Allpowerful_00_shot1","time":0.041666666666666664},{"animSeqName":"testScene_splite_BRIG_wea_Allpowerful_00_shot1End","time":0.26666666666666666}],"assetName":"BRIG_wea_Allpowerful_00"}],"duration":0.5166666666666666}'
jsonobj = json.loads(jsonstr)

# fps 60
# cmds.currentUnit( time="ntscf" )

fbxExportPath = jsonobj["fbxExportPath"]
directorKeys = jsonobj["DirectorKeys"]
groups = jsonobj["groups"]
# cam = cmds.camera()[0]
cam = None
# camKeys = None
artPath = "D:\\FOD2_Project\\Art_WorkData\\Character\\"

def getCharaterPath( name ):
    filePath = None
    for dirPath, dirNames, fileNames in os.walk(artPath):
        for f in fileNames:
            if f == "%s_mocap.ma" % name:
                return os.path.join(dirPath, f)
    return None

# def getShotStart(name):
#     for shot in directorKeys:
#         if shot["camera"] == name: return int(shot["Key"]*60)
#     return 0
    
# def getShotEnd(name):
#     if len(directorKeys) == 1: return camKeys[-1]
#     for i, shot in enumerate(directorKeys):
#         if shot["camera"] == name and i < len(directorKeys) - 1:
#             return int(directorKeys[i+1]["Key"]*60)-1
#     return camKeys[-1]
    
# def importAndDetect(path, type=""):
#     oriSet = set(cmds.ls(type=type))
#     mel.eval( 'FBXImportMode -v merge')
#     mel.eval( 'FBXImport -f "' + path + '"')
#     newSet = set(cmds.ls(type=type))
#     detect = list(newSet - oriSet)
#     return detect
    
# def loadFBXforCamera(grp):
    
#     name = grp["name"]
    
#     # 暫時用不到
#     '''
#     initTrans = grp["initTrans"]
#     fovFrames = grp["fovFrames"]
#     initAspectRatio = grp["initAspectRatio"]
#     initFovAngle = grp["initFovAngle"]
#     movementKeyFrames = grp["movementKeyFrames"]
#     '''


#     # 這個版本是把import的第一個camera當成唯一的camera。把其他的camera的key都複製過來
#     # 用這個做法的原因是ue4導出的camera設定和maya本身的不一樣，這樣做可以確保使用的唯一camera的設定是對的
#     fbxPath = "%s/%s.fbx" % (fbxExportPath, name)
#     newcam = importAndDetect(fbxPath, "camera")
#     newcam = cmds.listRelatives( newcam, allParents=True )[0]
#     global camKeys
#     camKeys = cmds.keyframe( newcam, q=1 )
#     camKeys.sort()

#     start = getShotStart(name)
#     end = getShotEnd(name)

#     global cam
#     if not cam:
#         cam = newcam
#     else:
#         cmds.cutKey(newcam, t=(start, end))
#         cmds.pasteKey(cam)
#         cmds.delete(newcam)

#     cmds.shot(name, cc=cam, st=start, sst=start, et=end, set=end, trk=1)





#     # 這個版本是先創建一個唯一camera，再把所有的camera的key複製過來
#     # fbxPath = "%s/%s.fbx" % (fbxExportPath, name)
#     # newcam = importAndDetect(fbxPath, "camera")
#     # newcam = cmds.listRelatives( newcam, allParents=True )[0]
#     # global camKeys
#     # camKeys = cmds.keyframe( newcam, q=1 )
#     # camKeys.sort()
#     # cmds.currentUnit( time="ntscf" )
    
#     # global cam
#     # start = getShotStart(name)
#     # end = getShotEnd(name)
#     # cmds.cutKey(newcam, t=(start, end))
#     # cmds.pasteKey(cam)
#     # cmds.shot(name, cc=newcam, st=start, sst=start, et=end, set=end, trk=1)
#     # cmds.delete(newcam)






#     # 因爲導出的時候，所有camera記錄到的資訊都一樣，所以第一個camera的fbx就有全部camera的資料了
#     # global cam, camKeys
#     # if not cam: 
#     #     fbxPath = "%s/%s.fbx" % (fbxExportPath, name)
#     #     cam = importAndDetect(fbxPath, "camera")
#     #     cam = cmds.listRelatives( cam, allParents=True )[0]
#     #     camKeys = cmds.keyframe( cam, q=1 )
#     #     camKeys.sort()
#     #     cmds.currentUnit( time="ntscf" )
    
#     # start = getShotStart(name)
#     # end = getShotEnd(name)
#     # cmds.shot(name, cc=cam, st=start, sst=start, et=end, set=end, trk=1)
        
# def loadFBXforSkeleton( grp ):
#     name = grp["name"]
#     initTrans = grp["initTrans"]
#     exportType = grp["exportType"]
#     visibleKeys = grp["visibleKeys"]
#     animSeq = grp["animSeq"]
#     animKeys = grp["animKeys"]
#     assetName = grp["assetName"]

#     # load rig file
#     path = getCharaterPath( assetName)
#     if path:
#         path = path.replace(".ma", "_mocap.ma")
#         cmds.file( path, r=1, ns=name)
#         print( "assetName", path )
 
#     for i, seq in enumerate(animKeys):
        
#         fbxName = seq["animSeqName"]
#         fbxPath = "%s/%s.fbx" % (fbxExportPath, fbxName)
#         jnts = importAndDetect(fbxPath, "joint")
#         print("jnts", jnts)
        
#         #skeleton = Helper.getNodeRoot(skeleton[0])
#         mel.eval( 'FBXImportMode -v merge')
#         mel.eval( 'FBXImport -f "' + fbxPath + '"')
#         #print("fbxPath", fbxPath)
#         #print("skeleton", jntRoot)

#         jntRoot = Helper.getNodeRoot(jnts[0])
#         jntNs = ":".join(jntRoot.split(":")[:-1])
#         # print("jntNs", jntNs)

#         # cmds.delete(jntRoot)


#         (backMethod, extraMethod) = JointToController.genMapAndMatchFKIK(jntNs, name)

#         shotName = directorKeys[i]["camera"]
#         start = int(getShotStart(shotName))
#         end = int(getShotEnd(shotName))
#         print("start", start)
#         print("end", end)
#         for i in range(start, end): backMethod(i)
#         try: extraMethod()
#         except: pass

#         # if i < len(animKeys) - 1:
#         cmds.delete(jntRoot)
    
# # for grp in groups:
# #     type = grp["groupType"]
# #     if type == "camera":
# #         loadFBXforCamera( grp )
# #     elif type == "skelMesh":
# #         loadFBXforSkeleton( grp )
# #     else:
# #         print("need to be handle, " + type )
       
# # startTime = camKeys[0]
# # endTime = camKeys[-1]    

# # cmds.playbackOptions(min = startTime)
# # cmds.playbackOptions(max = endTime)
# # cmds.playbackOptions(ast = startTime)
# # cmds.playbackOptions(aet = endTime)

# def createUE4Camera():
#     cam = cmds.camera()[0]
#     cmds.setAttr(cam + ".rotateAxisY", -90)
#     return cam

topNodes = cmds.ls(assemblies=1)[:]

rigFile = {}
for node in topNodes:
    if node == 'persp' or node == 'top' or node == 'side' or node == 'front':
       continue
    isCamera = cmds.nodeType( cmds.listRelatives(node, s=1) ) == 'camera'
    if isCamera:
        keys = cmds.keyframe(node, at="translate", q=1)
        keys.sort()

        start = math.ceil(keys[0]) + 1
        end = math.ceil(keys[-1])

        # cmds.copyKey(node, t=(start, end))
        # cmds.pasteKey(cam)
        # cmds.delete(node)

        # print(start, end)

        cmds.shot(node, cc=node, st=start, sst=start, et=end, set=end, trk=1)
    else:
        def saveRigFile(path):
            global rigFile
            rigFile[node] = path
        GuiBase.openFileDialog(saveRigFile, QFileDialog.AnyFile, "%s(*.ma)" % node)


# cam = cmds.camera()[0]
# cmds.setAttr(cam + ".rotateAxisY", -90)

# for node in topNodes:
#     if node == 'persp' or node == 'top' or node == 'side' or node == 'front':
#        continue
#     isCamera = cmds.nodeType( cmds.listRelatives(node, s=1) ) == 'camera'
#     if isCamera:
#         keys = cmds.keyframe(node, at="translate", q=1)
#         keys.sort()

#         start = math.ceil(keys[0]) + 1
#         end = math.ceil(keys[-1])

#         # cmds.copyKey(node, t=(start, end))
#         # cmds.pasteKey(cam)
#         # cmds.delete(node)

#         print(start, end)

#         cmds.shot(node, cc=node, st=start, sst=start, et=end, set=end, trk=1)
#         continue
    
for node in rigFile:
    
    Helper.deleteNode( node + "|RightHand ")
    Helper.deleteNode( node + "|Legend ")
    Helper.deleteNode( node + "|Face ")
    Helper.deleteNode( node + "|Cap ")

    if "XingYuan" not in node:
        locator = cmds.spaceLocator()[0]
        cmds.parent( locator, node )
        cmds.setAttr( locator + ".rotateZ", 0 )
        cmds.parent( node + "|root", locator )
        cmds.setAttr( locator + ".rotateZ", 90 )

    ns = node
    
    # 這邊要改名的原因是因爲之后要用到這個名字
    node = cmds.rename(node, ns + "_temp")

    # 把動作的骨架調整成我們要的格式（要有namespace的格式）
    fbx_ns = ns + "_fbx"
    cmds.namespace( add=fbx_ns )
    
    childs = cmds.listRelatives(node, ad=1)
    childs_pm = pm.listRelatives(node, ad=1)
    for child, child_pm in zip(childs, childs_pm ):
        cmds.rename( child_pm.name(), "%s:%s" % (fbx_ns, child))

    path = rigFile[ns]
    if path:
        cmds.file( path, r=1, ns=ns)
        (backMethod, extraMethod) = JointToController.genMapAndMatchFKIK(fbx_ns, ns)

        start = int(cmds.playbackOptions(q=True, ast=True))
        end = int(cmds.playbackOptions(q=True, aet=True))

        # start = 0
        # end = 100

        cmds.evaluationManager( mode="off" )

        for i in range(start, end): backMethod(i)

        cmds.evaluationManager( mode="parallel" )

        try: extraMethod()
        except: pass

        cmds.delete(node)
    
    
