# -*- coding: utf-8 -*-
# 針對Advanced Skeleton Motion Data import 作業
# Last Modified 2015/07/29
# Author Chih Lun Kang


import maya.cmds as cmds
import maya.mel as mel
import pymel.core as pm
import sys,os,re, math
import maya.OpenMaya as om
import maya.OpenMayaAnim as omAnim
import maya.OpenMayaMPx as OpenMayaMPx
import MatrixSwitchAxis as maxs
from collections import OrderedDict
import time
import Helper
import utilities2
try:import clr 
except:pass
if(clr):
    clr.AddReference("System")
    clr.AddReference("System.Windows.Forms")
    import System
    import System.Windows.Forms

reload(Helper)
reload(utilities2)

import JointToController
reload(JointToController)

# 取得logger method
log = Helper.getLogger('AdvSkeleton')

# # human
# listLockNode = ['RootX_M',
#                 'FKHead_M',
#                 'FKScapula_R',
#                 'FKScapula_L',
#                 'FKShoulder_R',
#                 'FKShoulder_L',
#                 'IKArm_R',
#                 'IKArm_L',
#                 'PoleArm_R',
#                 'PoleArm_L',
#                 'FKHip_R',
#                 'FKHip_L',
#                 'IKLeg_R',
#                 'IKLeg_L',
#                 'PoleLeg_R',
#                 'PoleLeg_L',
#                 'counter_P_ctrl']

# listLockNodes = {
#     "human": listLockNode,
#     "dengshi01":['RootX_M', 'counter_P_ctrl']
# }
                
# mocap 到 FK 
# mcToFKNmPar = [
# ["Hip_MoCap_L","FKHip_L"],
# ["Knee_MoCap_L","FKKnee_L"],
# ["Ankle_MoCap_L","FKAnkle_L"],
# ["Toes_MoCap_L","FKToes_L"],

# ["Toes1_MoCap_L","FKToes1_L"],
# ["Toes2_MoCap_L","FKToes2_L"],

# ["Hip_MoCap_R","FKHip_R"],
# ["Knee_MoCap_R","FKKnee_R"],
# ["Ankle_MoCap_R","FKAnkle_R"],
# ["Toes_MoCap_R","FKToes_R"],

# ["Toes1_MoCap_R","FKToes1_R"],
# ["Toes2_MoCap_R","FKToes2_R"],

# ["Spine1_MoCap_M","FKSpine1_M"],
# ["Spine2_MoCap_M","FKSpine2_M"],
# ["Spine3_MoCap_M","FKSpine3_M"],

# # shuyao only
# ["cut_joint","cut_curve"],
# ["root", "LEGspik_Crl_04"],
# ["MinbVine_jot_00_L", "_BRIG_MainVine_07_MinbVine_ctl_00_L"],
# ["MinbVine_jot_00_R", "_BRIG_MainVine_07_MinbVine_ctl_00_R"],

# #["Spine4_MoCap_M","FKSpine4_M"],
# ["Chest_MoCap_M","FKChest_M"],
# ["Neck_MoCap_M","FKNeck_M"],
# ["Head_MoCap_M","FKHead_M"],

# ["Scapula_MoCap_L","FKScapula_L"],
# ["Shoulder_MoCap_L","FKShoulder_L"],
# ["Elbow_MoCap_L","FKElbow_L"],
# ["Wrist_MoCap_L","FKWrist_L"],

# ["Scapula_MoCap_R","FKScapula_R"],
# ["Shoulder_MoCap_R","FKShoulder_R"],
# ["Elbow_MoCap_R","FKElbow_R"],
# ["Wrist_MoCap_R","FKWrist_R"],
# ]

# mocap 到 IK ，"_x" 是我另外增加的 Locator
# mcToIKNmPar = [
# ["Toes2_MoCap_L","IKLeg_L"],
# ["L_LegMocapPole_x","PoleLeg_L"],
# ["Toes2_MoCap_R","IKLeg_R"],
# ["R_LegMocapPole_x","PoleLeg_R"],
# ["Wrist_MoCap_L","IKArm_L"],
# ["L_ElbowMocapPole_x","PoleArm_L"],
# ["Wrist_MoCap_R","IKArm_R"],
# ["R_ElbowMocapPole_x","PoleArm_R"],
# ["Chest_MoCap_M","IKSpine2_M"]
# ]

# 定位用的PoleV名稱
# poleVectNameArr =[
# ["IKXKnee_L","PoleLeg_L","Knee_MoCap_L","L_LegMocapPole_x","Hip_MoCap_L","Ankle_MoCap_L"],
# # ["IKXElbow_L","PoleArm_L","Elbow_MoCap_L","L_ElbowMocapPole_x","Shoulder_MoCap_L","Wrist_MoCap_L"],
# ["IKXKnee_R","PoleLeg_R","Knee_MoCap_R","R_LegMocapPole_x","Hip_MoCap_R","Ankle_MoCap_R"]
# # ["IKXElbow_R","PoleArm_R","Elbow_MoCap_R","R_ElbowMocapPole_x","Shoulder_MoCap_R","Wrist_MoCap_R"]
# ]

# mcToSkNameArr=[
# ["Root_M","Root_MoCap_M"],
# ["Spine1_M","Spine1_MoCap_M"],
# ["Spine2_M","Spine2_MoCap_M"],
# ["Spine3_M","Spine3_MoCap_M"],
# ["Chest_M","Chest_MoCap_M"],
# #["Spine3_M","Spine4_MoCap_M"],
# ["Scapula_L","Scapula_MoCap_L"],
# ["Scapula_R","Scapula_MoCap_R"],
# ["Elbow_L","Elbow_MoCap_L"],
# ["Elbow_R","Elbow_MoCap_R"],
# ["Hip_L","Hip_MoCap_L"],
# ["Hip_R","Hip_MoCap_R"],
# ["Knee_L","Knee_MoCap_L"],
# ["Knee_R","Knee_MoCap_R"],
# ["Ankle_L","Ankle_MoCap_L"],
# ["Ankle_R","Ankle_MoCap_R"],
# ["Shoulder_L","Shoulder_MoCap_L"],
# ["Shoulder_R","Shoulder_MoCap_R"],
# ["Wrist_L","Wrist_MoCap_L"],
# ["Wrist_R","Wrist_MoCap_R"],
# ["Neck_M","Neck_MoCap_M"],
# ["Head_M","Head_MoCap_M"],
# ]


## 所有手指 名稱對應表，因為手指沒有要求對方做 Chararterize 
## 直接用parent constraint
# allFingersArr =[
# ["ThumbFinger1_L","FKThumbFinger1_L"],
# ["ThumbFinger2_L","FKThumbFinger2_L"],
# ["ThumbFinger3_L","FKThumbFinger3_L"],

# ["IndexFinger1_L","FKIndexFinger1_L"],
# ["IndexFinger2_L","FKIndexFinger2_L"],
# ["IndexFinger3_L","FKIndexFinger3_L"],

# ["MiddleFinger1_L","FKMiddleFinger1_L"],
# ["MiddleFinger2_L","FKMiddleFinger2_L"],
# ["MiddleFinger3_L","FKMiddleFinger3_L"],

# ["RingFinger1_L","FKRingFinger1_L"],
# ["RingFinger2_L","FKRingFinger2_L"],
# ["RingFinger3_L","FKRingFinger3_L"],

# ["Cup_L","FKCup_L"],

# ["PinkyFinger1_L","FKPinkyFinger1_L"],
# ["PinkyFinger2_L","FKPinkyFinger2_L"],
# ["PinkyFinger3_L","FKPinkyFinger3_L"],

# ["ThumbFinger1_R","FKThumbFinger1_R"],
# ["ThumbFinger2_R","FKThumbFinger2_R"],
# ["ThumbFinger3_R","FKThumbFinger3_R"],

# ["IndexFinger1_R","FKIndexFinger1_R"],
# ["IndexFinger2_R","FKIndexFinger2_R"],
# ["IndexFinger3_R","FKIndexFinger3_R"],

# ["MiddleFinger1_R","FKMiddleFinger1_R"],
# ["MiddleFinger2_R","FKMiddleFinger2_R"],
# ["MiddleFinger3_R","FKMiddleFinger3_R"],

# ["RingFinger1_R","FKRingFinger1_R"],
# ["RingFinger2_R","FKRingFinger2_R"],
# ["RingFinger3_R","FKRingFinger3_R"],

# ["Cup_R","FKCup_R"],

# ["PinkyFinger1_R","FKPinkyFinger1_R"],
# ["PinkyFinger2_R","FKPinkyFinger2_R"],
# ["PinkyFinger3_R","FKPinkyFinger3_R"]
# ]

# def changeConfigFromRigType(charName):
#     rigType = Helper.checkRigType(charName)
#     if rigType == "shandian":
#         mcToIKNmPar[0][0] = "Toes2_MoCap_L"
#         mcToIKNmPar[2][0] = "Toes2_MoCap_R"
#     elif rigType == "human":
#         mcToIKNmPar[0][0] = "Ankle_MoCap_L"
#         mcToIKNmPar[2][0] = "Ankle_MoCap_R"

# def getTopDagList():
#     listDag = cmds.ls(dag=True,l=True)
#     topDag = []
#     for dag in listDag:
#         if cmds.listRelatives(dag, p=True) == None:
#             topDag.append(dag)
#     return topDag

def getAllObjects():
    allDag = []
     
    allList = cmds.ls(dag=True)
    #refList = cmds.ls(dag=True, readOnly=True)
    rmv_a = cmds.ls(typ="camera")
    rmv_b = ["persp", "top", "front", "side"]
    objList = list(set(allList) - set(rmv_a) - set(rmv_b)) #- set(refList)

    # Collection all "dag obj" Name
    for obj in objList:
        allDag.append(obj)
            
    return allDag

def getShapes(objList,objWithShpList,_type="mesh",bGetHidden=False):# 預設隱藏物件不予處理
    resultList = []
    for obj in objList:
        if cmds.nodeType(obj) == "transform":
            bProcess=True
            root = (cmds.ls(obj,l=True)[0]).split('|')[1]
            if(not bGetHidden):
                # 階層中只要有任意一個parent .visibility 是關閉就是隱藏
                hieArr = (cmds.ls(obj,l=True)[0]).split('|')
                for oo in hieArr:
                    if(cmds.objExists(oo)):
                        if(not cmds.getAttr(oo+".visibility")):
                            bProcess=False
            if(bProcess):
                buffers = cmds.listRelatives(obj, fullPath=True, shapes=True)
                if buffers != None and cmds.nodeType(buffers[0]) == _type:
                    objWithShpList.append(obj)
                    resultList.append(buffers[0])

    return resultList

def addAllCtrlsToControllerLayer():
    if(cmds.objExists("Controller")):
        allCtrlObj = []
        getShapes(getAllObjects(),allCtrlObj ,_type="nurbsCurve",bGetHidden=True)
        cmds.select(allCtrlObj)
        mel.eval('editDisplayLayerMembers -noRecurse "defaultLayer" `ls -selection`;')
        addObjsToLayer("Controller",allCtrlObj)

def getSceneSkelMeshs():
    sceneSkelMesh = []
    allObj = []
    objList = getShapes(getAllObjects(),allObj,_type="mesh",bGetHidden=True)
    for k in range(0,len(allObj)): #k=2
        # 檢查是否已有上skin
        geo = allObj[k]
        objEntry = objList[k]
        buffers = cmds.listHistory(objEntry)
        for buffer in buffers:
            if cmds.nodeType(buffer) == "skinCluster": # 是skelMesh
                sceneSkelMesh.append(geo)
    return sceneSkelMesh


# def CreateAsMoCapSk(charname="", mocapname=""): # charname = rgnsp
#     cmds.select( charname+":Root_M" )
#     bindsk = cmds.duplicate(rr=False)
#     bindRoot = bindsk[0]

#     cmds.parent(bindRoot,w=True)

#     for jnt in bindsk: # jnt = bindsk[1]
#         if('_'in jnt):
#             nspl = jnt.split('_')
#             nwName = mocapname + ':' + nspl[0]+'_MoCap_'+nspl[1]
#             cmds.rename(jnt,nwName)
#         else:
#             nwName = mocapname + ':' + jnt +'_MoCap_'
#             cmds.rename(jnt,nwName)

#         """ 不知道爲什麽2018的 adv skeleton 創建出來的骨架，在這裏call api複製的時候，旋轉及位置都複製不出來（在場景上手動卻可以），所以這邊要再賦值一次確保資料正確 """
#         tx = Helper.getAttr(charname + ":" + jnt + ".translateX")
#         ty = Helper.getAttr(charname + ":" + jnt + ".translateY")
#         tz = Helper.getAttr(charname + ":" + jnt + ".translateZ")        
#         rx = Helper.getAttr(charname + ":" + jnt + ".rotateX")
#         ry = Helper.getAttr(charname + ":" + jnt + ".rotateY")
#         rz = Helper.getAttr(charname + ":" + jnt + ".rotateZ") 
#         if tx != None: Helper.setAttr(nwName + ".translateX", tx)
#         if ty != None: Helper.setAttr(nwName + ".translateY", ty)
#         if tz != None: Helper.setAttr(nwName + ".translateZ", tz)
#         if rx != None: Helper.setAttr(nwName + ".rotateX", rx)
#         if ry != None: Helper.setAttr(nwName + ".rotateY", ry)
#         if rz != None: Helper.setAttr(nwName + ".rotateZ", rz)

# def gotoFBXBindPose(charname, toolroot=""):
#     mel.eval('HIKCharacterControlsTool;')
#     melcmdstr = 'if (!`pluginInfo -q -l "mayaHIK"`)\n'
#     melcmdstr += '{ \n'
#     melcmdstr += 'loadPlugin "mayaHIK";'
#     melcmdstr += '} \n'
#     melcmdstr += 'if (!`pluginInfo -q -l "mayaCharacterization"`) \n'
#     melcmdstr += '{ \n'
#     melcmdstr += 'loadPlugin "mayaCharacterization"; \n'
#     melcmdstr += '} \n'
#     melcmdstr += 'if (!`pluginInfo -q -l "OneClick"`) \n'
#     melcmdstr += '{ \n'
#     melcmdstr += 'loadPlugin "OneClick"; \n'
#     melcmdstr += '} \n'
#     melcmdstr += 'hikCreateCharacterControlsDockableWindow;'
#     mel.eval(melcmdstr)
    
#     _string = 'source "'+toolroot+'HIKUpdCurrentSourceFromUI.mel"'
#     mel.eval(_string)
    
#     if charname == '':
#         charname = "Character"
#         charArr = cmds.ls(type="HIKCharacterNode")
#         if ( len(charArr)):
#             charname = charArr[0]

#     log( 'Create Control Rig, Name:' + charname )
#     mel.eval('hikUpdCurrentCharacterFromUI("'+charname+'");')
#     mel.eval('hikUpdCurrentSourceFromUI("Control Rig");')
#     mel.eval('hikUpdCurrentSourceFromUI("Stance");')
#     mel.eval('hikUpdCurrentSourceFromUI("None");')
#     mel.eval('hikUpdateContextualUI();')

#     return charname

# def getFBXCharName():
#     charname = ""
#     alljnts = cmds.ls(typ = "joint")
#     fbxroot = None
#     for jnt in alljnts:
#         if("root" in jnt):
#             bRef = cmds.referenceQuery(jnt,isNodeReferenced=True)
#             if(not bRef):
#                 fbxroot = jnt
#     if(":" in fbxroot):
#         charname = fbxroot.split(':')[0]
#     return charname

# def snapMocapSkToFBXLocation(mocapname=""): # charname = rgnsp
#     #mcToSkNameArr=[
#     #    ["Root_M","Root_MoCap_M"],
#     #    ["Spine1_M","Spine1_MoCap_M"],
#     # Get Namespcace of imported fbx
#     constrArr = []
    
#     _fbxCharName = getFBXCharName() if mocapname == "" else mocapname
#     for k in range(0,len(mcToSkNameArr)): # k = 13
#         tgtName = _fbxCharName +":"+mcToSkNameArr[k][0]
#         mocapName = mocapname + ':' + mcToSkNameArr[k][1]
        
#         if(len(_fbxCharName ) == 0):
#             tgtName = mcToSkNameArr[k][0]
#         if(not cmds.objExists(tgtName)):continue
#         if(not cmds.objExists(mocapName)):continue

#         # print( "%s parent to %s" % (tgtName,mocapName) )
        
#         if(k==0):
#             _consRo = cmds.parentConstraint(tgtName,mocapName,mo=False)
#             constrArr.append(_consRo)
#         else:
#             # 不知道爲什麽本來的maintain offset是true。沒有offset的是比較正確的
#             # _consRo = cmds.orientConstraint(tgtName,mocapName,mo=True)
#             _consRo = cmds.orientConstraint(tgtName,mocapName,mo=False)#
#             constrArr.append(_consRo)
    
#     # for k in range(0,len(allFingersArr)): # k = 1
#     #     fbxCtrlName = _fbxCharName+":"+allFingersArr[k][0]
#     #     if(len(_fbxCharName) <1):
#     #         fbxCtrlName = allFingersArr[k][0]
#     #     if(not cmds.objExists(fbxCtrlName)):continue
#     #     tr = cmds.xform(fbxCtrlName , q=True , t=True,ws=True)
#     #     cmds.xform(charname+":"+allFingersArr[k][1],t=tr,ws=True)
#     #     _ro = cmds.xform(fbxCtrlName , q=True , ro=True,ws=True)
#     #     cmds.xform(charname+":"+allFingersArr[k][1],ro=_ro ,ws=True)
        
#     return constrArr

# def gotoFBXMotionPose(charDef):
#     # 目前不知道爲什麽需要呼叫adv skeleton 的api。先關掉它
#     # mel.eval('hikEnableCharacter( "'+charDef+'", 2 );')

#     # 更新動作讓mocap回到初始張
#     tmin = int(cmds.playbackOptions(q=True,minTime=True))
#     cmds.currentTime(tmin+1)
#     cmds.currentTime(tmin)


# def createHIKMapping(charDef,toolroot=""): # charDef = charDefNameFbx 
#     mel.eval('hikCreateDefinition()')
#     mel.eval( 'setCharacterObject("Root_MoCap_M","Character1",1,0);')
#     mel.eval( 'setCharacterObject("Spine1_MoCap_M","Character1",8,0);')
#     mel.eval( 'setCharacterObject("Spine2_MoCap_M","Character1",23,0);')
#     mel.eval( 'setCharacterObject("Spine3_MoCap_M","Character1",24,0);')
#     #mel.eval( 'setCharacterObject("Spine4_MoCap_M","Character1",25,0);')
#     mel.eval( 'setCharacterObject("Chest_MoCap_M","Character1",25,0);')
#     mel.eval( 'setCharacterObject("Scapula_MoCap_L","Character1",18,0);')
#     mel.eval( 'setCharacterObject("Scapula_MoCap_R","Character1",19,0);')
#     mel.eval( 'setCharacterObject("Elbow_MoCap_L","Character1",10,0);')
#     mel.eval( 'setCharacterObject("Elbow_MoCap_R","Character1",13,0);')
#     if(cmds.objExists("Hip_MoCap_L")):
#         mel.eval( 'setCharacterObject("Hip_MoCap_L","Character1",2,0);')
#     if(cmds.objExists("Hip_MoCap_R")):
#         mel.eval( 'setCharacterObject("Hip_MoCap_R","Character1",5,0);')
#     if(cmds.objExists("Knee_MoCap_L")):
#         mel.eval( 'setCharacterObject("Knee_MoCap_L","Character1",3,0);')
#     if(cmds.objExists("Knee_MoCap_R")):
#         mel.eval( 'setCharacterObject("Knee_MoCap_R","Character1",6,0);')
#     if(cmds.objExists("Ankle_MoCap_L")):
#         mel.eval( 'setCharacterObject("Ankle_MoCap_L","Character1",4,0);')
#     if(cmds.objExists("Ankle_MoCap_R")):
#         mel.eval( 'setCharacterObject("Ankle_MoCap_R","Character1",7,0);')
#     mel.eval( 'setCharacterObject("Shoulder_MoCap_L","Character1",9,0);')
#     mel.eval( 'setCharacterObject("Shoulder_MoCap_R","Character1",12,0);')
#     mel.eval( 'setCharacterObject("Wrist_MoCap_L","Character1",11,0);')
#     mel.eval( 'setCharacterObject("Wrist_MoCap_R","Character1",14,0);')
#     mel.eval( 'setCharacterObject("Neck_MoCap_M","Character1",20,0);')
#     mel.eval( 'setCharacterObject("Head_MoCap_M","Character1",15,0);')

#     mel.eval( 'setCharacterObject("ThumbFinger1_MoCap_L","Character1",50,0);')
#     mel.eval( 'setCharacterObject("ThumbFinger2_MoCap_L","Character1",51,0);')
#     mel.eval( 'setCharacterObject("ThumbFinger3_MoCap_L","Character1",52,0);')

#     mel.eval( 'setCharacterObject("IndexFinger1_MoCap_L","Character1",54,0);')
#     mel.eval( 'setCharacterObject("IndexFinger2_MoCap_L","Character1",55,0);')
#     mel.eval( 'setCharacterObject("IndexFinger3_MoCap_L","Character1",56,0);')

#     mel.eval( 'setCharacterObject("MiddleFinger1_MoCap_L","Character1",58,0);')
#     mel.eval( 'setCharacterObject("MiddleFinger2_MoCap_L","Character1",59,0);')
#     mel.eval( 'setCharacterObject("MiddleFinger3_MoCap_L","Character1",60,0);')

#     mel.eval( 'setCharacterObject("RingFinger1_MoCap_L","Character1",62,0);')
#     mel.eval( 'setCharacterObject("RingFinger2_MoCap_L","Character1",63,0);')
#     mel.eval( 'setCharacterObject("RingFinger3_MoCap_L","Character1",64,0);')

#     mel.eval( 'setCharacterObject("PinkyFinger1_MoCap_L","Character1",66,0);')
#     mel.eval( 'setCharacterObject("PinkyFinger2_MoCap_L","Character1",67,0);')
#     mel.eval( 'setCharacterObject("PinkyFinger3_MoCap_L","Character1",68,0);')


#     mel.eval( 'setCharacterObject("ThumbFinger1_MoCap_R","Character1",74,0);')
#     mel.eval( 'setCharacterObject("ThumbFinger2_MoCap_R","Character1",75,0);')
#     mel.eval( 'setCharacterObject("ThumbFinger3_MoCap_R","Character1",76,0);')

#     mel.eval( 'setCharacterObject("IndexFinger1_MoCap_R","Character1",78,0);')
#     mel.eval( 'setCharacterObject("IndexFinger2_MoCap_R","Character1",79,0);')
#     mel.eval( 'setCharacterObject("IndexFinger3_MoCap_R","Character1",80,0);')

#     mel.eval( 'setCharacterObject("MiddleFinger1_MoCap_R","Character1",82,0);')
#     mel.eval( 'setCharacterObject("MiddleFinger2_MoCap_R","Character1",83,0);')
#     mel.eval( 'setCharacterObject("MiddleFinger3_MoCap_R","Character1",84,0);')

#     mel.eval( 'setCharacterObject("RingFinger1_MoCap_R","Character1",86,0);')
#     mel.eval( 'setCharacterObject("RingFinger2_MoCap_R","Character1",87,0);')
#     mel.eval( 'setCharacterObject("RingFinger3_MoCap_R","Character1",88,0);')

#     mel.eval( 'setCharacterObject("PinkyFinger1_MoCap_R","Character1",90,0);')
#     mel.eval( 'setCharacterObject("PinkyFinger2_MoCap_R","Character1",91,0);')
#     mel.eval( 'setCharacterObject("PinkyFinger3_MoCap_R","Character1",92,0);')

#     _string = 'source "'+toolroot+'HIKUpdCurrentSourceFromUI.mel"'
#     mel.eval(_string)
#     mel.eval('hikUpdCurrentCharacterFromUI("Character1");')
#     mel.eval('hikUpdCurrentSourceFromUI("'+charDef+'");')
#     mel.eval('hikUpdateContextualUI();')



# 生成定位用的PoleV ，黏到Mocap 骨架上對位用
# def createPoleMocapLoc(charname, mocapname,plArr): # plArr =poleVectNameArr charname=rgnsp
#     '''
#     poleVectNameArr =[
#     ["IKXKnee_L","PoleLeg_L","Knee_MoCap_L","L_LegMocapPole_x","Hip_MoCap_L","Ankle_MoCap_L"],
#     # ["IKXElbow_L","PoleArm_L","Elbow_MoCap_L","L_ElbowMocapPole_x","Shoulder_MoCap_L","Wrist_MoCap_L"],
#     ["IKXKnee_R","PoleLeg_R","Knee_MoCap_R","R_LegMocapPole_x","Hip_MoCap_R","Ankle_MoCap_R"]
#     # ["IKXElbow_R","PoleArm_R","Elbow_MoCap_R","R_ElbowMocapPole_x","Shoulder_MoCap_R","Wrist_MoCap_R"]
#     ]
#     '''
#     for pl in plArr: # pl = plArr[1]
#         v1Name = charname+":"+pl[0]
#         v2Name = charname+":"+pl[1]
#         if(not cmds.objExists(v1Name)):continue
#         if(not cmds.objExists(v2Name)):continue
        
#         _v1 = cmds.xform(v1Name,q=True,ws=True,t=True)
#         _v1om = om.MVector(_v1[0] ,_v1[1],_v1[2])
#         _v2 = cmds.xform(v2Name,q=True,ws=True,t=True)
#         _v2om = om.MVector(_v2[0] ,_v2[1],_v2[2])
#         ikdir = _v2om-_v1om
        
#         _v3 = cmds.xform(mocapname+':'+pl[2],q=True,ws=True,t=True)
#         _v3om = om.MVector(_v3[0] ,_v3[1],_v3[2])
#         newLoc = _v3om + ikdir 
#         newLocNd = cmds.spaceLocator()
#         cmds.rename(newLocNd,mocapname+':'+pl[3])
#         cmds.xform(mocapname+':'+pl[3],ws=True,t=(newLoc.x,newLoc.y,newLoc.z))

# def keyframed_setElbowNewPoleLocation(startNd,midNd,endNd,elbowNd, poleRelative):
#     '''
#     armLPoleCtrlName = ["FKShoulder_L","FKElbow_L","FKWrist_L" ,"PoleArm_L"]
#     armRPoleCtrlName = ["FKShoulder_R","FKElbow_R","FKWrist_R" ,"PoleArm_R"]
#     legLPoleCtrlName = ["FKHip_L","FKKnee_L","FKAnkle_L" ,"PoleLeg_L"]
#     legRPoleCtrlName = ["FKHip_R","FKKnee_R","FKAnkle_R" ,"PoleLeg_R"]
#     '''

#     midmat = cmds.xform(midNd, ws=1,q=1,m=1)
#     newmat = poleRelative * Helper.getOpenMayaMatrix(midmat)

#     cmds.xform(elbowNd , ws =1 , m=Helper.getMelMatrix(newmat))
#     cmds.setKeyframe( elbowNd+".translate" )

#     # start = cmds.xform(startNd ,q= 1 ,ws = 1,t =1 )
#     # mid = cmds.xform(midNd,q= 1 ,ws = 1,t =1 )
#     # end = cmds.xform(endNd,q= 1 ,ws = 1,t =1 )
#     # startV = om.MVector(start[0] ,start[1],start[2])
#     # midV = om.MVector(mid[0] ,mid[1],mid[2])
#     # endV = om.MVector(end[0] ,end[1],end[2])
#     # startEnd = endV - startV
#     # startMid = midV - startV
#     # dotP = startMid * startEnd
#     # proj = float(dotP) / float(startEnd.length())
#     # startEndN = startEnd.normal()
#     # projV = startEndN * proj
#     # arrowV = startMid - projV
#     # arrowV *= 0.5 
#     # if arrowV.length() < 20:
#     #     arrowV = arrowV.normal() * 20
#     # finalV = arrowV + midV
#     # cmds.xform(elbowNd , ws =1 , t= (finalV.x , finalV.y ,finalV.z))
#     # cmds.setKeyframe( elbowNd+".translate" )

# New Elbow location setup with built-in nodes
# def setElbowNewPoleLocation(startNd,midNd,endNd,elbowNd): 
#     if(not cmds.objExists(startNd)):return
#     if(not cmds.objExists(midNd)):return
#     if(not cmds.objExists(endNd)):return
#     if(not cmds.objExists(elbowNd)):return

#     calcNodeCol = []
#     # ########################### #
#     #     Decompose to Vector       #
#     # ########################### #
#     decompStart = cmds.createNode('decomposeMatrix')
#     cmds.connectAttr( startNd+'.worldMatrix',decompStart+'.inputMatrix')
#     decompMid = cmds.createNode('decomposeMatrix')
#     cmds.connectAttr( midNd+'.worldMatrix',decompMid+'.inputMatrix')
#     decompEnd = cmds.createNode('decomposeMatrix')
#     cmds.connectAttr( endNd+'.worldMatrix',decompEnd+'.inputMatrix')
    
#     calcNodeCol.append(decompStart)
#     calcNodeCol.append(decompMid)
#     calcNodeCol.append(decompEnd)

#     # ########################### #
#     #     vector start to end       #
#     # ########################### #
#     plusMinus_StartEnd = cmds.createNode('plusMinusAverage')
#     # set operation to minus
#     cmds.setAttr(plusMinus_StartEnd+'.op',2) 
#     mel.eval('catchQuiet(`getAttr -type '+plusMinus_StartEnd+'.input3D[0]`);')
#     mel.eval('catchQuiet(`getAttr -type '+plusMinus_StartEnd+'.input3D[1]`);')
#     # First term -> end
#     cmds.connectAttr(decompEnd+'.outputTranslateX',plusMinus_StartEnd+".input3D[0].input3Dx")
#     cmds.connectAttr(decompEnd+'.outputTranslateY',plusMinus_StartEnd+".input3D[0].input3Dy")
#     cmds.connectAttr(decompEnd+'.outputTranslateZ',plusMinus_StartEnd+".input3D[0].input3Dz")
#     # Second term -> start
#     cmds.connectAttr(decompStart+'.outputTranslateX',plusMinus_StartEnd+".input3D[1].input3Dx")
#     cmds.connectAttr(decompStart+'.outputTranslateY',plusMinus_StartEnd+".input3D[1].input3Dy")
#     cmds.connectAttr(decompStart+'.outputTranslateZ',plusMinus_StartEnd+".input3D[1].input3Dz")
    
#     calcNodeCol.append(plusMinus_StartEnd)

#     # ########################### #
#     #     vector start to mid       #
#     # ########################### #
#     plusMinus_StartMid = cmds.createNode('plusMinusAverage')
#     # set operation to minus
#     cmds.setAttr(plusMinus_StartMid +'.op',2) 
#     mel.eval('catchQuiet(`getAttr -type '+plusMinus_StartMid +'.input3D[0]`);')
#     mel.eval('catchQuiet(`getAttr -type '+plusMinus_StartMid +'.input3D[1]`);')
#     # First term -> end
#     cmds.connectAttr(decompMid+'.outputTranslateX',plusMinus_StartMid +".input3D[0].input3Dx")
#     cmds.connectAttr(decompMid+'.outputTranslateY',plusMinus_StartMid +".input3D[0].input3Dy")
#     cmds.connectAttr(decompMid+'.outputTranslateZ',plusMinus_StartMid +".input3D[0].input3Dz")
#     # Second term -> start
#     cmds.connectAttr(decompStart+'.outputTranslateX',plusMinus_StartMid +".input3D[1].input3Dx")
#     cmds.connectAttr(decompStart+'.outputTranslateY',plusMinus_StartMid +".input3D[1].input3Dy")
#     cmds.connectAttr(decompStart+'.outputTranslateZ',plusMinus_StartMid +".input3D[1].input3Dz")
    
#     calcNodeCol.append(plusMinus_StartMid)

#     # ########################### #
#     #             dot P              #
#     # ########################### #
#     dotPvectorProduct = cmds.createNode('vectorProduct') #cmds.listAttr(dotPvectorProduct) cmds.getAttr(dotPvectorProduct+'.outputX')
#     # cmds.listAttr(plusMinus_StartMid)
#     cmds.connectAttr(plusMinus_StartMid +'.output3Dx',dotPvectorProduct +".input1X")
#     cmds.connectAttr(plusMinus_StartMid +'.output3Dy',dotPvectorProduct +".input1Y")
#     cmds.connectAttr(plusMinus_StartMid +'.output3Dz',dotPvectorProduct +".input1Z")

#     cmds.connectAttr(plusMinus_StartEnd +'.output3Dx',dotPvectorProduct +".input2X")
#     cmds.connectAttr(plusMinus_StartEnd +'.output3Dy',dotPvectorProduct +".input2Y")
#     cmds.connectAttr(plusMinus_StartEnd +'.output3Dz',dotPvectorProduct +".input2Z")

#     calcNodeCol.append(dotPvectorProduct)
    
#     # ########################### #
#     #             proj              #
#     # ########################### #
#     dis_StartEnd = cmds.createNode('distanceBetween')#cmds.listAttr(dis_StartEnd)
#     cmds.connectAttr(decompEnd+'.outputTranslateX',dis_StartEnd +".point1X")
#     cmds.connectAttr(decompEnd+'.outputTranslateY',dis_StartEnd +".point1Y")
#     cmds.connectAttr(decompEnd+'.outputTranslateZ',dis_StartEnd +".point1Z")
#     cmds.connectAttr(decompStart+'.outputTranslateX',dis_StartEnd +".point2X")
#     cmds.connectAttr(decompStart+'.outputTranslateY',dis_StartEnd +".point2Y")
#     cmds.connectAttr(decompStart+'.outputTranslateZ',dis_StartEnd +".point2Z")

#     divide_proj = cmds.createNode('multiplyDivide')#cmds.listAttr(divide_proj)
#     cmds.setAttr( divide_proj + '.operation', 2) # set to divide
#     cmds.connectAttr(dotPvectorProduct+'.outputX',divide_proj +".input1X")
#     cmds.connectAttr(dis_StartEnd+'.distance',divide_proj +".input2X")
    
#     calcNodeCol.append(dis_StartEnd)
#     calcNodeCol.append(divide_proj)

#     # ########################### #
#     #             startEndN          #
#     # ########################### #
#     normalizeStartEndN = cmds.createNode('vectorProduct') #cmds.listAttr(normalizeStartEndN)
#     cmds.setAttr(normalizeStartEndN+'.operation',0)
#     cmds.setAttr(normalizeStartEndN+'.normalizeOutput',1)
#     cmds.connectAttr(plusMinus_StartEnd +'.output3Dx',normalizeStartEndN +".input1X")
#     cmds.connectAttr(plusMinus_StartEnd +'.output3Dy',normalizeStartEndN +".input1Y")
#     cmds.connectAttr(plusMinus_StartEnd +'.output3Dz',normalizeStartEndN +".input1Z")
#     #cmds.getAttr(normalizeStartEndN+'.outputX')

#     calcNodeCol.append(normalizeStartEndN)

#     # ########################### #
#     #             projV              #
#     # ########################### #
#     Mult_projV = cmds.createNode('multiplyDivide')
#     cmds.connectAttr(normalizeStartEndN+'.outputX',Mult_projV +".input1X")
#     cmds.connectAttr(normalizeStartEndN+'.outputY',Mult_projV +".input1Y")
#     cmds.connectAttr(normalizeStartEndN+'.outputZ',Mult_projV +".input1Z")

#     cmds.connectAttr(divide_proj+'.outputX',Mult_projV +".input2X") 
#     cmds.connectAttr(divide_proj+'.outputX',Mult_projV +".input2Y")
#     cmds.connectAttr(divide_proj+'.outputX',Mult_projV +".input2Z")

#     calcNodeCol.append(Mult_projV)
    
#     # ########################### #
#     #             arrowV              #
#     # ########################### #
#     plusMinus_arrowV = cmds.createNode('plusMinusAverage')
#     cmds.setAttr(plusMinus_arrowV +'.op',2) 
#     mel.eval('catchQuiet(`getAttr -type '+plusMinus_arrowV +'.input3D[0]`);')
#     mel.eval('catchQuiet(`getAttr -type '+plusMinus_arrowV +'.input3D[1]`);')
#     # First term -> end
#     cmds.connectAttr(plusMinus_StartMid +'.output3Dx',plusMinus_arrowV +".input3D[0].input3Dx")
#     cmds.connectAttr(plusMinus_StartMid +'.output3Dy',plusMinus_arrowV +".input3D[0].input3Dy")
#     cmds.connectAttr(plusMinus_StartMid +'.output3Dz',plusMinus_arrowV +".input3D[0].input3Dz")
#     # Second term -> Mult_projV
#     cmds.connectAttr(Mult_projV+'.outputX',plusMinus_arrowV +".input3D[1].input3Dx")
#     cmds.connectAttr(Mult_projV+'.outputY',plusMinus_arrowV +".input3D[1].input3Dy")
#     cmds.connectAttr(Mult_projV+'.outputZ',plusMinus_arrowV +".input3D[1].input3Dz")

#     calcNodeCol.append(plusMinus_arrowV)

#     # Normalize arrowV
#     normalizeArrowV =  cmds.createNode('vectorProduct')
#     cmds.setAttr(normalizeArrowV+'.operation',0)
#     cmds.setAttr(normalizeArrowV+'.normalizeOutput',1)
#     cmds.connectAttr(plusMinus_arrowV +'.output3Dx',normalizeArrowV +".input1X")
#     cmds.connectAttr(plusMinus_arrowV +'.output3Dy',normalizeArrowV +".input1Y")
#     cmds.connectAttr(plusMinus_arrowV +'.output3Dz',normalizeArrowV +".input1Z")

#     calcNodeCol.append(normalizeArrowV)
    
#     # Multiple ArrowV
#     Mult_ArrowV = cmds.createNode('multiplyDivide')
#     cmds.connectAttr(normalizeArrowV+'.outputX',Mult_ArrowV +".input1X")
#     cmds.connectAttr(normalizeArrowV+'.outputY',Mult_ArrowV +".input1Y")
#     cmds.connectAttr(normalizeArrowV+'.outputZ',Mult_ArrowV +".input1Z")
#     cmds.setAttr(Mult_ArrowV+".input2X",30.0)
#     cmds.setAttr(Mult_ArrowV+".input2Y",30.0)
#     cmds.setAttr(Mult_ArrowV+".input2Z",30.0)

#     calcNodeCol.append(Mult_ArrowV)
    
#     # ########################### #
#     #             FinalV              #
#     # ########################### #
#     plusMinus_finalV = cmds.createNode('plusMinusAverage')
#     cmds.setAttr(plusMinus_finalV +'.op',1) 
#     mel.eval('catchQuiet(`getAttr -type '+plusMinus_finalV +'.input3D[0]`);')
#     mel.eval('catchQuiet(`getAttr -type '+plusMinus_finalV +'.input3D[1]`);')
    
#     cmds.connectAttr(Mult_ArrowV +'.outputX',plusMinus_finalV +".input3D[0].input3Dx")
#     cmds.connectAttr(Mult_ArrowV +'.outputY',plusMinus_finalV +".input3D[0].input3Dy")
#     cmds.connectAttr(Mult_ArrowV +'.outputZ',plusMinus_finalV +".input3D[0].input3Dz")

#     cmds.connectAttr(decompMid+'.outputTranslateX',plusMinus_finalV +".input3D[1].input3Dx")
#     cmds.connectAttr(decompMid+'.outputTranslateY',plusMinus_finalV +".input3D[1].input3Dy")
#     cmds.connectAttr(decompMid+'.outputTranslateZ',plusMinus_finalV +".input3D[1].input3Dz")
    
#     calcNodeCol.append(plusMinus_finalV)
    
#     ## connect the result
#     cmds.connectAttr(plusMinus_finalV+".output3Dx",elbowNd+'.translateX')
#     cmds.connectAttr(plusMinus_finalV+".output3Dy",elbowNd+'.translateY')
#     cmds.connectAttr(plusMinus_finalV+".output3Dz",elbowNd+'.translateZ')
    
#     return calcNodeCol

# def setElbowNewPoleLocation_old(startNd,midNd,endNd,elbowNd): 
#     if(not cmds.objExists(startNd)):return
#     if(not cmds.objExists(midNd)):return
#     if(not cmds.objExists(endNd)):return
#     if(not cmds.objExists(elbowNd)):return

#     calcNodeCol = []
#     # ########################### #
#     #     Decompose to Vector       #
#     # ########################### #
#     decompStart = cmds.createNode('decomposeMatrix')
#     cmds.connectAttr( startNd+'.worldMatrix',decompStart+'.inputMatrix')
#     decompMid = cmds.createNode('decomposeMatrix')
#     cmds.connectAttr( midNd+'.worldMatrix',decompMid+'.inputMatrix')
#     decompEnd = cmds.createNode('decomposeMatrix')
#     cmds.connectAttr( endNd+'.worldMatrix',decompEnd+'.inputMatrix')
    
#     calcNodeCol.append(decompStart)
#     calcNodeCol.append(decompMid)
#     calcNodeCol.append(decompEnd)

#     # ########################### #
#     #     vector start to end       #
#     # ########################### #
#     plusMinus_StartEnd = cmds.createNode('plusMinusAverage')
#     # set operation to minus
#     cmds.setAttr(plusMinus_StartEnd+'.op',2) 
#     mel.eval('catchQuiet(`getAttr -type '+plusMinus_StartEnd+'.input3D[0]`);')
#     mel.eval('catchQuiet(`getAttr -type '+plusMinus_StartEnd+'.input3D[1]`);')
#     # First term -> end
#     cmds.connectAttr(decompEnd+'.outputTranslateX',plusMinus_StartEnd+".input3D[0].input3Dx")
#     cmds.connectAttr(decompEnd+'.outputTranslateY',plusMinus_StartEnd+".input3D[0].input3Dy")
#     cmds.connectAttr(decompEnd+'.outputTranslateZ',plusMinus_StartEnd+".input3D[0].input3Dz")
#     # Second term -> start
#     cmds.connectAttr(decompStart+'.outputTranslateX',plusMinus_StartEnd+".input3D[1].input3Dx")
#     cmds.connectAttr(decompStart+'.outputTranslateY',plusMinus_StartEnd+".input3D[1].input3Dy")
#     cmds.connectAttr(decompStart+'.outputTranslateZ',plusMinus_StartEnd+".input3D[1].input3Dz")
    
#     calcNodeCol.append(plusMinus_StartEnd)

#     # ########################### #
#     #     vector start to mid       #
#     # ########################### #
#     plusMinus_StartMid = cmds.createNode('plusMinusAverage')
#     # set operation to minus
#     cmds.setAttr(plusMinus_StartMid +'.op',2) 
#     mel.eval('catchQuiet(`getAttr -type '+plusMinus_StartMid +'.input3D[0]`);')
#     mel.eval('catchQuiet(`getAttr -type '+plusMinus_StartMid +'.input3D[1]`);')
#     # First term -> end
#     cmds.connectAttr(decompMid+'.outputTranslateX',plusMinus_StartMid +".input3D[0].input3Dx")
#     cmds.connectAttr(decompMid+'.outputTranslateY',plusMinus_StartMid +".input3D[0].input3Dy")
#     cmds.connectAttr(decompMid+'.outputTranslateZ',plusMinus_StartMid +".input3D[0].input3Dz")
#     # Second term -> start
#     cmds.connectAttr(decompStart+'.outputTranslateX',plusMinus_StartMid +".input3D[1].input3Dx")
#     cmds.connectAttr(decompStart+'.outputTranslateY',plusMinus_StartMid +".input3D[1].input3Dy")
#     cmds.connectAttr(decompStart+'.outputTranslateZ',plusMinus_StartMid +".input3D[1].input3Dz")
    
#     calcNodeCol.append(plusMinus_StartMid)

#     # ########################### #
#     #             dot P              #
#     # ########################### #
#     dotPvectorProduct = cmds.createNode('vectorProduct') #cmds.listAttr(dotPvectorProduct) cmds.getAttr(dotPvectorProduct+'.outputX')
#     # cmds.listAttr(plusMinus_StartMid)
#     cmds.connectAttr(plusMinus_StartMid +'.output3Dx',dotPvectorProduct +".input1X")
#     cmds.connectAttr(plusMinus_StartMid +'.output3Dy',dotPvectorProduct +".input1Y")
#     cmds.connectAttr(plusMinus_StartMid +'.output3Dz',dotPvectorProduct +".input1Z")

#     cmds.connectAttr(plusMinus_StartEnd +'.output3Dx',dotPvectorProduct +".input2X")
#     cmds.connectAttr(plusMinus_StartEnd +'.output3Dy',dotPvectorProduct +".input2Y")
#     cmds.connectAttr(plusMinus_StartEnd +'.output3Dz',dotPvectorProduct +".input2Z")

#     calcNodeCol.append(dotPvectorProduct)
    
#     # ########################### #
#     #             proj              #
#     # ########################### #
#     dis_StartEnd = cmds.createNode('distanceBetween')#cmds.listAttr(dis_StartEnd)
#     cmds.connectAttr(decompEnd+'.outputTranslateX',dis_StartEnd +".point1X")
#     cmds.connectAttr(decompEnd+'.outputTranslateY',dis_StartEnd +".point1Y")
#     cmds.connectAttr(decompEnd+'.outputTranslateZ',dis_StartEnd +".point1Z")
#     cmds.connectAttr(decompStart+'.outputTranslateX',dis_StartEnd +".point2X")
#     cmds.connectAttr(decompStart+'.outputTranslateY',dis_StartEnd +".point2Y")
#     cmds.connectAttr(decompStart+'.outputTranslateZ',dis_StartEnd +".point2Z")

#     divide_proj = cmds.createNode('multiplyDivide')#cmds.listAttr(divide_proj)
#     cmds.setAttr( divide_proj + '.operation', 2) # set to divide
#     cmds.connectAttr(dotPvectorProduct+'.outputX',divide_proj +".input1X")
#     cmds.connectAttr(dis_StartEnd+'.distance',divide_proj +".input2X")
    
#     calcNodeCol.append(dis_StartEnd)
#     calcNodeCol.append(divide_proj)

#     # ########################### #
#     #             startEndN          #
#     # ########################### #
#     normalizeStartEndN = cmds.createNode('vectorProduct') #cmds.listAttr(normalizeStartEndN)
#     cmds.setAttr(normalizeStartEndN+'.operation',0)
#     cmds.setAttr(normalizeStartEndN+'.normalizeOutput',1)
#     cmds.connectAttr(plusMinus_StartEnd +'.output3Dx',normalizeStartEndN +".input1X")
#     cmds.connectAttr(plusMinus_StartEnd +'.output3Dy',normalizeStartEndN +".input1Y")
#     cmds.connectAttr(plusMinus_StartEnd +'.output3Dz',normalizeStartEndN +".input1Z")
#     #cmds.getAttr(normalizeStartEndN+'.outputX')

#     calcNodeCol.append(normalizeStartEndN)

#     # ########################### #
#     #             projV              #
#     # ########################### #
#     Mult_projV = cmds.createNode('multiplyDivide')
#     cmds.connectAttr(normalizeStartEndN+'.outputX',Mult_projV +".input1X")
#     cmds.connectAttr(normalizeStartEndN+'.outputY',Mult_projV +".input1Y")
#     cmds.connectAttr(normalizeStartEndN+'.outputZ',Mult_projV +".input1Z")

#     cmds.connectAttr(divide_proj+'.outputX',Mult_projV +".input2X") 
#     cmds.connectAttr(divide_proj+'.outputX',Mult_projV +".input2Y")
#     cmds.connectAttr(divide_proj+'.outputX',Mult_projV +".input2Z")

#     calcNodeCol.append(Mult_projV)
    
#     # ########################### #
#     #             arrowV              #
#     # ########################### #
#     plusMinus_arrowV = cmds.createNode('plusMinusAverage')
#     cmds.setAttr(plusMinus_arrowV +'.op',2) 
#     mel.eval('catchQuiet(`getAttr -type '+plusMinus_arrowV +'.input3D[0]`);')
#     mel.eval('catchQuiet(`getAttr -type '+plusMinus_arrowV +'.input3D[1]`);')
#     # First term -> end
#     cmds.connectAttr(plusMinus_StartMid +'.output3Dx',plusMinus_arrowV +".input3D[0].input3Dx")
#     cmds.connectAttr(plusMinus_StartMid +'.output3Dy',plusMinus_arrowV +".input3D[0].input3Dy")
#     cmds.connectAttr(plusMinus_StartMid +'.output3Dz',plusMinus_arrowV +".input3D[0].input3Dz")
#     # Second term -> Mult_projV
#     cmds.connectAttr(Mult_projV+'.outputX',plusMinus_arrowV +".input3D[1].input3Dx")
#     cmds.connectAttr(Mult_projV+'.outputY',plusMinus_arrowV +".input3D[1].input3Dy")
#     cmds.connectAttr(Mult_projV+'.outputZ',plusMinus_arrowV +".input3D[1].input3Dz")

#     calcNodeCol.append(plusMinus_arrowV)
    
#     Mult_ArrowV = cmds.createNode('multiplyDivide')
#     cmds.connectAttr(plusMinus_arrowV+'.output3Dx',Mult_ArrowV +".input1X")
#     cmds.connectAttr(plusMinus_arrowV+'.output3Dy',Mult_ArrowV +".input1Y")
#     cmds.connectAttr(plusMinus_arrowV+'.output3Dz',Mult_ArrowV +".input1Z")
#     cmds.setAttr(Mult_ArrowV+".input2X",0.5)
#     cmds.setAttr(Mult_ArrowV+".input2Y",0.5)
#     cmds.setAttr(Mult_ArrowV+".input2Z",0.5)

#     calcNodeCol.append(Mult_ArrowV)
    
#     # ########################### #
#     #             FinalV              #
#     # ########################### #
#     plusMinus_finalV = cmds.createNode('plusMinusAverage')
#     cmds.setAttr(plusMinus_finalV +'.op',1) 
#     mel.eval('catchQuiet(`getAttr -type '+plusMinus_finalV +'.input3D[0]`);')
#     mel.eval('catchQuiet(`getAttr -type '+plusMinus_finalV +'.input3D[1]`);')
    
#     cmds.connectAttr(Mult_ArrowV +'.outputX',plusMinus_finalV +".input3D[0].input3Dx")
#     cmds.connectAttr(Mult_ArrowV +'.outputY',plusMinus_finalV +".input3D[0].input3Dy")
#     cmds.connectAttr(Mult_ArrowV +'.outputZ',plusMinus_finalV +".input3D[0].input3Dz")

#     cmds.connectAttr(decompMid+'.outputTranslateX',plusMinus_finalV +".input3D[1].input3Dx")
#     cmds.connectAttr(decompMid+'.outputTranslateY',plusMinus_finalV +".input3D[1].input3Dy")
#     cmds.connectAttr(decompMid+'.outputTranslateZ',plusMinus_finalV +".input3D[1].input3Dz")
    
#     calcNodeCol.append(plusMinus_finalV)
    
#     ## connect the result
#     cmds.connectAttr(plusMinus_finalV+".output3Dx",elbowNd+'.translateX')
#     cmds.connectAttr(plusMinus_finalV+".output3Dy",elbowNd+'.translateY')
#     cmds.connectAttr(plusMinus_finalV+".output3Dz",elbowNd+'.translateZ')
    
#     return calcNodeCol

# 手肘位置新版，使用node連結
# def setPoleLocKeys(mocapName,pNameArr): # pNameArr =poleVectNameArr charname="man_rig_v05"
    
#     coNodes = []
#     for pd in pNameArr: # pd = pNameArr[0]
#         nds = setElbowNewPoleLocation(mocapName + ':' + pd[4],mocapName + ':' + pd[2],mocapName + ':' + pd[5],mocapName + ':' + pd[3])
#         if nds is not None:
#             coNodes += nds
#     return coNodes


# # 初始化控制器綁定到mocap sk 上
# def snapIKFKCtrlToMo(charName="", mocapname=""): # charName = rgnsp
#     # Pole 生成並設定新位置
#     # 這段好像沒有作用了。關掉
#     # createPoleMocapLoc(charName, mocapname,poleVectNameArr)
    
#     constNameArr=[]
    
#     hipName = mocapname + ":Root_MoCap_M" if mocapname != "" else "Root_MoCap_M"
#     hipCharName = charName +":RootX_M"
#     _HipFKCtrlp = cmds.pointConstraint(hipName,hipCharName)
#     _HipFKCtrlo = cmds.orientConstraint(hipName,hipCharName,mo=True)
#     constNameArr.append(_HipFKCtrlp)
#     constNameArr.append(_HipFKCtrlo)

#     ## FK Constraint
#     for k in range(0,len(mcToFKNmPar)): # k = 1
    
#         checkName0 = (mocapname + ':' + mcToFKNmPar[k][0]) if mocapname != "" else mcToFKNmPar[k][0]
#         checkName1 = charName + ':' + mcToFKNmPar[k][1]
        
#         if(not cmds.objExists(checkName1)):continue
#         if(not cmds.objExists(checkName0)):continue

#         if mcToFKNmPar[k][1]=='FKElbow_L' or mcToFKNmPar[k][1]=='FKElbow_R':
#             constNode = checkName1
#             _refLoc = cmds.spaceLocator()[0]
#             constNameArr.append(_refLoc)
            
#             cmds.xform(_refLoc, ws=True, m=cmds.xform(constNode,q=True,ws=True,m=True))
#             cmds.parent(_refLoc, checkName0)
#             _mulMtx = cmds.shadingNode("multMatrix",au=True)
#             constNameArr.append(_mulMtx)
#             cmds.connectAttr(_refLoc+'.worldMatrix[0]', _mulMtx+'.matrixIn[0]', f=True)
#             cmds.connectAttr(constNode+'.parentInverseMatrix[0]', _mulMtx+'.matrixIn[1]', f=True)

#             _decomMtx = cmds.shadingNode("decomposeMatrix",au=True)
#             constNameArr.append(_decomMtx)
#             cmds.connectAttr(_mulMtx+'.matrixSum', _decomMtx+'.inputMatrix', f=True)
#             cmds.connectAttr(_decomMtx+'.outputRotateZ', constNode+'.rotateZ', f=True)
#         elif mcToFKNmPar[k][1]=='FKWrist_L' or mcToFKNmPar[k][1]=='FKWrist_R':
#             _Ctrl = cmds.orientConstraint(checkName0, checkName1,mo=True)
#             constNameArr.append(_Ctrl)
#         else:
#             _Ctrl = cmds.parentConstraint(checkName0, checkName1,mo=True)
#             constNameArr.append(_Ctrl)

#     # 加入等下要刪除的清單內
#     #constNameArr.append(_HipFKCtrlp)

#     changeConfigFromRigType(charName)
    
#     '''
#     mcToIKNmPar = [
#     ["Toes2_MoCap_L","IKLeg_L"],
#     ["L_LegMocapPole_x","PoleLeg_L"],
#     ["Toes2_MoCap_R","IKLeg_R"],
#     ["R_LegMocapPole_x","PoleLeg_R"],
#     ["Wrist_MoCap_L","IKArm_L"],
#     ["L_ElbowMocapPole_x","PoleArm_L"],
#     ["Wrist_MoCap_R","IKArm_R"],
#     ["R_ElbowMocapPole_x","PoleArm_R"],
#     ["Chest_MoCap_M","IKSpine2_M"]
#     ]
#     '''

#     # IK Constraint
#     for k in range(0,len(mcToIKNmPar)): #k=1
#         checkName0 = (mocapname + ":" + mcToIKNmPar[k][0]) if mocapname != "" else mcToIKNmPar[k][0]
#         checkName1 = charName + ":" + mcToIKNmPar[k][1]
        
#         if(not cmds.objExists(checkName0)):continue
#         if(not cmds.objExists(checkName1)):continue
        
#         _pCtrl = cmds.pointConstraint(checkName0,checkName1)
#         constNameArr.append(_pCtrl)
#         _oCtrl = None
#         try:
#             _oCtrl = cmds.orientConstraint(checkName0,checkName1,mo=True)
#         except:pass
#         if(_oCtrl):
#             constNameArr.append(_oCtrl)
#     return constNameArr


# def doFingerConstraint(constNameArr,charname): # charname = "PL_1001a_rig"
#     _fbxCharName = getFBXCharName()
#     for k in range(0,len(allFingersArr)): # k = 1
#         fbxCtrlName = _fbxCharName+":"+allFingersArr[k][0]
#         if(len(_fbxCharName) <1):
#             fbxCtrlName = allFingersArr[k][0]
#         # 手指頭數目是不定的，如果沒有手指就略過
#         try:
#             _Ctrl = cmds.parentConstraint(fbxCtrlName,charname+":"+allFingersArr[k][1],mo=True) #,st="none"
#             constNameArr.append(_Ctrl[0].replace("_parentConstraint1", ""))
#         except:
#             print("no finger:", allFingersArr[k][1])

# def getAnima(nodeList, startTime, endTime):
#     objCount = len(nodeList)
#     currentTime = int(cmds.currentTime(q=True))
#     framesCount = endTime - startTime + 1

#     AnimData = OrderedDict()
#     AnimData['count'] = objCount

#     # objList = []
#     # for o in nodeList:
#     #     clrName = o[5:]
#     #     objList.append(clrName)
            
#     AnimData['name'] = nodeList

#     AnimData['timelength'] = framesCount

#     frameAniData = OrderedDict()
#     for f in range(framesCount):
#         log('Get Animation On: ' + str(f))
#         cmds.currentTime(f + startTime)
#         posArray = []
#         RotArray = []
#         sclArray = []
        
#         for o in nodeList:
#             cLPos = list(cmds.getAttr(o+".translate")[0])
#             cLRot = list(cmds.getAttr(o+".rotate")[0])
#             cLScl = list(cmds.getAttr(o+".scale")[0])

#             posArray.append(cLPos)
#             RotArray.append(cLRot)
#             sclArray.append(cLScl)
        
#         transformData = OrderedDict()
#         transformData["Position"] = posArray
#         transformData["Rotation"] = RotArray
#         transformData["Scale"] = sclArray
        
#         frameAniData[f] = transformData
    
#     AnimData["Animation"] = frameAniData
#     cmds.currentTime(currentTime)
#     return AnimData

# def importAnima(anmData, startFrame):
#     oriAutoKeyState = cmds.autoKeyframe(q=True,state=True)
#     cmds.autoKeyframe(state=False)

#     objCount = anmData['count']
#     objList = anmData['name']
#     framesCount = anmData['timelength']
#     AnimData = anmData['Animation']
#     endTime = int(cmds.playbackOptions(q=True, max=True))
#     # startFrame = int(cmds.currentTime(q=True))
#     for f in range(framesCount):
#         tKey = f#str(f)
#         log('Bake Keys On: ' + str(tKey))
#         for i in range(objCount):
#             if (cmds.objExists(objList[i])):
#                 ### Position ###
#                 if not cmds.getAttr(objList[i] + ".translateX", l=True):
#                     cmds.setKeyframe(objList[i] + ".translateX", time=(startFrame+f), value=AnimData[tKey]['Position'][i][0])
#                 if not cmds.getAttr(objList[i] + ".translateY", l=True):
#                     cmds.setKeyframe(objList[i] + ".translateY", time=(startFrame+f), value=AnimData[tKey]['Position'][i][1])
#                 if not cmds.getAttr(objList[i] + ".translateZ", l=True):
#                     cmds.setKeyframe(objList[i] + ".translateZ", time=(startFrame+f), value=AnimData[tKey]['Position'][i][2])

#                 ### Rotation ###
#                 if not cmds.getAttr(objList[i] + ".rotateX", l=True):
#                     cmds.setKeyframe(objList[i] + ".rotateX", time=(startFrame+f), value=AnimData[tKey]['Rotation'][i][0])
#                 if not cmds.getAttr(objList[i] + ".rotateY", l=True):
#                     cmds.setKeyframe(objList[i] + ".rotateY", time=(startFrame+f), value=AnimData[tKey]['Rotation'][i][1])
#                 if not cmds.getAttr(objList[i] + ".rotateZ", l=True):
#                     cmds.setKeyframe(objList[i] + ".rotateZ", time=(startFrame+f), value=AnimData[tKey]['Rotation'][i][2])

#     log('Filter Curve')
#     for i in range(0,objCount):
#         if (cmds.objExists(objList[i])):
#             cmds.filterCurve(objList[i]+".rotateX",objList[i]+".rotateY",objList[i]+".rotateZ")

#     log('AutoKeyframe')
#     cmds.autoKeyframe(state=oriAutoKeyState)

# def KBakeAnm(objList, startFrame, endFrame):
#     anmData = getAnima(objList, startFrame, endFrame)
#     importAnima(anmData, startFrame)

## Back Mocap 動作到兩組(FK/IK)控制器上
# def bakeCtrlAnim(constNameArr,charNames, mocapNames): # constNameArr = consNameAr;charName = rgnsp

#     # Back 工作
#     poleNodes = []
#     # FK 要Bake的 Node 
#     NdToBake = []
#     for i, charName in enumerate(charNames):
#         mocapName = mocapNames[i]
#         poleNodes += setPoleLocKeys(mocapName,poleVectNameArr)
#         NdToBake.append(charName+":RootX_M")

#         changeConfigFromRigType(charName)

#         for nds in mcToFKNmPar: # nds=mcToFKNmPar[1]
#             if(cmds.objExists(charName+":"+nds[1])):
#                 NdToBake.append(charName+":"+nds[1])
#         for nds in mcToIKNmPar:
#             if(cmds.objExists(charName+":"+nds[1])):
#                 NdToBake.append(charName+":"+nds[1])
    
#     # 手指 bake
#     #for nds in allFingersArr:
#     #    if(cmds.objExists(charName+":"+nds[1])):
#     #        NdToBake.append(charName+":"+nds[1])
#     # minStr = str(int(cmds.playbackOptions(q=True,minTime=True)))
#     # maxStr = str(int(cmds.playbackOptions(q=True,maxTime=True)))
#     minFrm = int(cmds.playbackOptions(q=True,minTime=True))
#     maxFrm = int(cmds.playbackOptions(q=True,maxTime=True))

#     # 部分constraint不知道爲什麽會失效，這個時候只要跳到最後一個frame再開始bake就行了
#     cmds.currentTime(maxFrm)

#     # 測試用debug
#     # maxFrm = 10
#     # cmds.bakeResults( NdToBake, t=(minStr,maxStr), sampleBy=1,simulation=True)
#     KBakeAnm(NdToBake, minFrm, maxFrm)

#     # Apply All Scene Euler Filter
#     rotcurves = cmds.ls(type="animCurveTA")
#     for r in range (0,len(rotcurves)/3): #r=1
#         cmds.filterCurve( rotcurves[3*r] , rotcurves[3*r+1] , rotcurves[3*r+2] )
    
# def deleteGlobalChannelKeyOnHead(fbxNameSpace, withShape):
#     log( 'Delete Global Channel Key OnHead: ' + fbxNameSpace )
#     hdctrlsnm = ["FKHead_M"]
#     hdCtrl = findControls(hdctrlsnm, fbxNameSpace, withShape)
#     if len( hdCtrl ) > 0:
#         cmds.cutKey(hdCtrl[0],cl=True,at="Global")
#         cmds.setAttr(hdCtrl[0]+".Global",0)

def setGlobalFollow( charName, globalFollow ):
    for ctrlName in ['FKShoulder_L', 'FKShoulder_R']:
        objName = charName + ":" + ctrlName
        if cmds.objExists( objName ):
            try:
                cmds.setAttr(objName + ".Global" , globalFollow)
            except:
                Helper.showMessage(objName + ".Global屬性沒有設置到哦")
                print( u"肩膀的Global沒有設置到" )

# 會影響 setRootToZero 這個方法，改的時候請參照之。這邊强制把follow打開，因爲美術在調整動作時，預設是打開follow的。這邊要對上才行
# def setPoleFollow(charName):
#     for ctrlName in ['PoleArm_L', 'PoleArm_R', 'PoleLeg_L', 'PoleLeg_R']:
#         objName = charName + ":" + ctrlName
#         if cmds.objExists( objName ):
#             try:
#                 cmds.setAttr(objName + ".follow" , 10)
#             except:
#                 raise u'pole的follow沒有設置到'

# def skinOnePerson( charName, mocapname, uiname, toolroot, globalFollow ):
    
#     setGlobalFollow( charName, globalFollow )
#     setPoleFollow( charName )

    
#     # create mocap sk
#     log( 'Create Mocap Skeleton: ' + charName )
#     CreateAsMoCapSk(charName, mocapname)
    
#     # 控制器綁定到mocap sk 上
#     log( 'Bind Controller to Mocap Skeleton: ' + charName )
#     consNameAr = snapIKFKCtrlToMo(charName, mocapname) 
    
     
#     # 跳到Fbx的BindPose
#     log( 'Jump To BindPose: ' + charName )

#     # 目前不知道爲什麽需要呼叫adv skeleton 的api。先關掉它
#     # charDefNameFbx = gotoFBXBindPose(uiname, toolroot)

#     # 這邊設定的值基本上跟上面關掉的代碼得到的值是一樣的
#     charDefNameFbx = uiname
    
#     # 這時只有骨頭在動，skin沒有動
#     try:
#         #把骨架對位到mocap骨架的位置上
#         #修正新月骨架位置問題(鎖骨對位)
#         log( 'Snap Mocap Skeleton To FBX Location: ' + charName )
#         appendArr = snapMocapSkToFBXLocation(mocapname)
#         consNameAr += appendArr
#         # 手指綁定
#         #doFingerConstraint(consNameAr,charName)
#     except:
#         type, message, traceback = sys.exc_info()
#         while traceback:
#             print("...")
#             print(type)
#             print(message)
#             print("...")
#             traceback = traceback.tb_next
    
    
#     # openIKController(charName)

#     # 跳到Fbx的MotionPose 初始張
#     log( 'Go To FBX Motion Pose: ' + charName )
#     gotoFBXMotionPose(charDefNameFbx)

#     def deleteAllMocapUselessObjects():
#         fbxSkeleton = charDefNameFbx.replace( '_ncl1_1', '' )
        
#         # 暫時先加這行，會這樣的原因是因爲之前的檔案給新月時，角色名字沒有一致
#         fbxSkeleton = fbxSkeleton.replace('YouQing', 'YunQing')
        
#         seperateNameSpace = fbxSkeleton.split(':')
        
#         charNameSpace = ''
#         for i in range( len(seperateNameSpace ) - 1):
#             charNameSpace += ':' + seperateNameSpace[i]

#         # uiname等於空白的時候，代表是單一匯入的功能。很多的節點名稱是沒有namespace的
#         if uiname == '':
#             charNameSpace = ''
    
#         Helper.deleteNode( charDefNameFbx + '_Ctrl_Reference' )
#         Helper.deleteNode( mocapname + ":Root_MoCap_M" )
#         Helper.deleteNode( fbxSkeleton ) 
#         Helper.deleteNode( charNameSpace + ':R_LegMocapPole_x' )
#         Helper.deleteNode( charNameSpace + ':L_LegMocapPole_x' )
#         Helper.deleteNode( charNameSpace + ':L_ElbowMocapPole_x' )
#         Helper.deleteNode( charNameSpace + ':R_ElbowMocapPole_x' )

#     return consNameAr, deleteAllMocapUselessObjects

# def HIKMotionProcess(toolroot,charPath,savePath,rigNameSpace,globalFollow=10): #toolroot = "E:/00Trunk/PY/JoyFunToolSetMaya/00tools/AdvancedSkeleton/scripts/" , # charPath = 
    
#     # 確認讀取外挂, cmds.createNode('decomposeMatrix')會需要
#     cmds.loadPlugin("matrixNodes")

#     # 開啟FileBrowseDlg ，找尋要import的fbx file
#     openFileDialog1 = System.Windows.Forms.OpenFileDialog()
#     openFileDialog1.Filter = "fbx files (*.fbx)|*.fbx|All files (*.*)|*.*"
#     openFileDialog1.FilterIndex = 1
#     dfmotionLoc = None
#     try:dfmotionLoc = cmds.optionVar( q='asMotionLoc')
#     except:pass
#     if(dfmotionLoc==0):
#         dfmotionLoc = "C:\\"
#         cmds.optionVar(sv=('asMotionLoc', dfmotionLoc) )

#     openFileDialog1.InitialDirectory = dfmotionLoc
#     openFileDialog1.Multiselect = True

#     if (openFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK):
#         allF = openFileDialog1.FileNames
#         cmds.optionVar(sv=('asMotionLoc', os.path.dirname(allF[0])) )
#         rigFilePth = cmds.file(q=True,sn=True)
#         for ff in allF: #ff = allF[0] len(allF)
#             fileN = ff.split('\\')[-1].split('.')[0]
#             if(len(rigFilePth)==0):
#                 System.Windows.Forms.MessageBox.Show(u"請至少開啟一個Rig file 再開始做bake motion")
#                 break
#             charName = rigFilePth.split('/')[-1].split('.')[0]
#             if((rigNameSpace!=None) and(len(rigNameSpace))):
#                 charName = rigNameSpace 
                
#             #檔名去掉 gamebar_
#             _filename = (ff.split('\\')[-1]).split('.')[0]
#             if("gamebar_" in _filename ):
#                 _filename = _filename[8:]
            
#             # 存的目標檔
#             tgtDir = os.path.dirname(ff)
#             tgtFilePth = tgtDir +"\\"+_filename +".ma" 
#             if((len(savePath)) and (savePath != None)):
#                 savePath = savePath.replace('/','\\')
#                 nsp = ""
#                 if((rigNameSpace!=None) and(len(rigNameSpace))):
#                     nsp = rigNameSpace
#                 tgtFilePth = savePath +"\\"+ nsp +"_" + _filename +".ma" 
                
            
#             # 新建空白場景
#             cmds.file(f=True,new=True)
            
#             # mocap回來的fps要60
#             # 場景FPS60
#             cmds.currentUnit(t="ntscf")
            
#             # reference rig data
#             cmds.file(rigFilePth,r=True,options="v=0",namespace=charName,ignoreVersion=True )

#             oriTopDagList = getTopDagList()
            
#             # 開始import fbx 動作
#             _string = 'source "'+toolroot+'FBXImportModule.mel"'
#             mel.eval( _string )
#             sv = 'string $res = doImportFbx("'+ff.replace('\\','/')+'");'
            
#             resStr = mel.eval(sv)
#             if(resStr != "Success"):break
            
#             # get adv skeleton namespace
#             jnts = cmds.ls(type='joint')
#             mocapJoints = [j for j in jnts if charName not in j ]
#             cmds.select(mocapJoints)
#             uiname = pm.selected()[0].root()

#             mocapName = ''
#             consNameAr, deleteAllMocapUselessObjects = skinOnePerson( charName, mocapName, uiname, toolroot, globalFollow )
            
#             # 動作Baking 並刪除多餘資料
#             bakeCtrlAnim(consNameAr,[charName], [mocapName])

#             deleteAllMocapUselessObjects()
#             deleteGlobalChannelKeyOnHead('', False)
            
#             # 刪除額外的物件
#             curTopDagList = getTopDagList()
#             for dag in curTopDagList:
#                 if not dag in oriTopDagList:
#                     Helper.deleteNode(dag)

#             # ?? 頭要改來這
#             #if cmds.objExists( charName+":FKHead_M"):
#             #    cmds.setAttr(charName+":FKHead_M.Global" , globalFollow)
                
#             # 另存新檔 
#             cmds.file(rename=tgtFilePth) # tgtFilePth = "D:\JF_RPG\Art_WorkSpace\Animation\idle_2_crouch_jnt.ma"
#             cmds.file(save=True,type='mayaAscii',force = True)
            
#     # 搜尋charPath
#     return


# 找Main control 
def findMainAndRootJnt():
    rfNds = cmds.ls(rn=True)
    _main = None
    _rootJnt = None
    for rnd in rfNds: # rnd = rfNds[5]
        bufs = cmds.listRelatives(rnd, fullPath=True, shapes=True)
        if(bufs):
            if( ( cmds.nodeType(bufs[0]) == "nurbsCurve" ) and (":Main" in rnd) ):
                _main = rnd
                break
    for rnd in rfNds: # rnd = rfNds[5]
        if((cmds.nodeType(rnd) == "joint") and (":root" in rnd)):
            _rootJnt = rnd
            break
    return _rootJnt,_main

def findControls(ctrlNameArr,charName="",withShape=False):#ctrlNameArr = ['root_control'] withShape=True
    ret = []
    rfNds = cmds.ls(rn=True, l=True)
    if(not withShape):
        for nm in ctrlNameArr:
            nfd = charName+":"+nm
            for rnd in rfNds: 
                if( nfd in rnd ): 
                    ret.append(rnd)
                    break
    else:
        for nm in ctrlNameArr: #nm = ctrlNameArr[0]
            nfd = charName+":"+nm
            cnt = 0
            for rnd in rfNds: # rnd = rfNds[121]
                bufs = cmds.listRelatives(rnd,shapes=True,f=True)
                if (not bufs):continue
                if(( cmds.nodeType(bufs[0]) == "nurbsCurve" ) and (nfd in rnd )): 
                    ret.append(rnd)
                    break
                cnt += 1
    
    return ret

def getAsCharHeight(): 
    bIsZup = False
    if (cmds.upAxis(q=True,ax=True)) == 'z':
        bIsZup = True

    if(cmds.objExists("Root_M")):
        if bIsZup:
            return (cmds.xform("Root_M",q=True,ws=True,t=True)[2])*2
        else:
            return (cmds.xform("Root_M",q=True,ws=True,t=True)[1])*2
    return 0

def getRootDifToZero(_main,_rootJnt):
    dif = om.MVector(0,0,0)
    if((_rootJnt) and (_main) ):
        rootjntTr = cmds.xform(_rootJnt ,q= 1 ,ws = 1,t =1 )
        _mainTr = cmds.xform(_main,q= 1 ,ws = 1,t =1 )
        
        rootjntTrV = om.MVector(rootjntTr[0] ,rootjntTr[1],rootjntTr[2])
        _mainTrV = om.MVector(_mainTr[0] ,_mainTr[1],_mainTr[2])
        
        dif = _mainTrV - rootjntTrV
    return dif

def offsetKey(keyName, value, time = None):

    # 這個方法好像有點問題，要呼叫第二次才正確。
    hasKey = None
    if time == None:
        hasKey = cmds.selectKey(keyName,k=True)
        hasKey = cmds.selectKey(keyName,k=True)
    else:
        hasKey = cmds.selectKey(keyName,k=True, t=(time,time))
        hasKey = cmds.selectKey(keyName,k=True, t=(time,time))

    if hasKey == 1:
        cmds.keyframe( animation = "keys",relative=True,valueChange = value)

def radByAngle(angle):
	return angle / 180.0 * 3.14159265359

def createCircleCross(name, radius, seg = 36, upAxis='z', offset=[0,0,0], color=[0,1,0]):
	listPt = []
	for i in range(seg + 1):
		rScl = 1.0
		if (360.0/seg*i)%90 == 0:
			rScl = 1.5
		pt = [math.cos(radByAngle(360.0/seg*i))*radius*rScl, math.sin(radByAngle(360.0/seg*i))*radius*rScl, 0]
		listPt.append(pt)

	listP = []
	
	if upAxis == 'x':
		for i in range(len(listPt)):
			lst = listPt[i]
			tmp = lst[2]
			lst[2] = lst[1]
			lst[1] = lst[0]
			lst[0] = tmp
			listP.append(lst)
	elif upAxis == 'y':
		for i in range(len(listPt)):
			lst = listPt[i]
			tmp = lst[2]
			lst[2] = lst[0]
			lst[0] = lst[1]
			lst[1] = tmp
			listP.append(lst)
	else: #upAxis == 'z'
		for i in range(len(listPt)):
			lst = listPt[i]
			listP.append(lst)

	listK = []
	for i in range(len(listP)):
		listK.append(i)
		
	obj = cmds.curve(name=name, p=listP, k=listK, d=1)
	
	cmds.setAttr((obj + ".overrideEnabled"), 1)
	cmds.setAttr((obj + ".overrideRGBColors"), 1)
	cmds.setAttr((obj + ".overrideColorR"), color[0])
	cmds.setAttr((obj + ".overrideColorG"), color[1])
	cmds.setAttr((obj + ".overrideColorB"), color[2])
	return obj

def createWireCylinder(name, radius, height, upAxis='z', offset=[0,0,0], color=[0,1,0]):
	listPt = []
	
	for i in range(25):
		pt = [math.cos(radByAngle(360.0/24*i))*radius, math.sin(radByAngle(360.0/24*i))*radius, 0]
		listPt.append(pt)
	for i in range(25):
		pt = [math.cos(radByAngle(360.0/24*i))*radius, math.sin(radByAngle(360.0/24*i))*radius, height]
		listPt.append(pt)
		
	ptTmp = [listPt[26][0], listPt[26][1], listPt[26][2]]
	listPt.append(ptTmp)
	ptTmp = [listPt[27][0], listPt[27][1], listPt[27][2]]
	listPt.append(ptTmp)
	ptTmp = [listPt[28][0], listPt[28][1], listPt[28][2]]
	listPt.append(ptTmp)
	ptTmp = [listPt[29][0], listPt[29][1], listPt[29][2]]
	listPt.append(ptTmp)
	ptTmp = [listPt[30][0], listPt[30][1], listPt[30][2]]
	listPt.append(ptTmp)
	ptTmp = [listPt[31][0], listPt[31][1], listPt[31][2]]
	listPt.append(ptTmp)
	
	ptTmp = [listPt[ 6][0], listPt[ 6][1], listPt[ 6][2]]
	listPt.append(ptTmp)
	ptTmp = [listPt[ 7][0], listPt[ 7][1], listPt[ 7][2]]
	listPt.append(ptTmp)
	ptTmp = [listPt[ 8][0], listPt[ 8][1], listPt[ 8][2]]
	listPt.append(ptTmp)
	ptTmp = [listPt[ 9][0], listPt[ 9][1], listPt[ 9][2]]
	listPt.append(ptTmp)
	ptTmp = [listPt[10][0], listPt[10][1], listPt[10][2]]
	listPt.append(ptTmp)
	ptTmp = [listPt[11][0], listPt[11][1], listPt[11][2]]
	listPt.append(ptTmp)
	ptTmp = [listPt[12][0], listPt[12][1], listPt[12][2]]
	listPt.append(ptTmp)
	
	ptTmp = [listPt[37][0], listPt[37][1], listPt[37][2]]
	listPt.append(ptTmp)
	ptTmp = [listPt[38][0], listPt[38][1], listPt[38][2]]
	listPt.append(ptTmp)
	ptTmp = [listPt[39][0], listPt[39][1], listPt[39][2]]
	listPt.append(ptTmp)
	ptTmp = [listPt[40][0], listPt[40][1], listPt[40][2]]
	listPt.append(ptTmp)
	ptTmp = [listPt[41][0], listPt[41][1], listPt[41][2]]
	listPt.append(ptTmp)
	ptTmp = [listPt[42][0], listPt[42][1], listPt[42][2]]
	listPt.append(ptTmp)
	ptTmp = [listPt[43][0], listPt[43][1], listPt[43][2]]
	listPt.append(ptTmp)
	
	ptTmp = [listPt[18][0], listPt[18][1], listPt[18][2]]
	listPt.append(ptTmp)
	
	listP = []
	
	if upAxis == 'x':
		for i in range(len(listPt)):
			lst = listPt[i]
			tmp = lst[2]
			lst[2] = lst[1]
			lst[1] = lst[0]
			lst[0] = tmp
			listP.append(lst)
	elif upAxis == 'y':
		for i in range(len(listPt)):
			lst = listPt[i]
			tmp = lst[2]
			lst[2] = lst[0]
			lst[0] = lst[1]
			lst[1] = tmp
			listP.append(lst)
	else: #upAxis == 'z'
		for i in range(len(listPt)):
			lst = listPt[i]
			listP.append(lst)
			
	listK = []
	for i in range(len(listP)):
		listK.append(i)
		
	obj = cmds.curve(name=name, p=listP, k=listK, d=1)
	
	cmds.setAttr((obj + ".overrideEnabled"), 1)
	cmds.setAttr((obj + ".overrideRGBColors"), 1)
	cmds.setAttr((obj + ".overrideColorR"), color[0])
	cmds.setAttr((obj + ".overrideColorG"), color[1])
	cmds.setAttr((obj + ".overrideColorB"), color[2])
	return obj
    
def createProxyForOffset(charName, startTime, endTime, rotateRoot = False):

    # 强制解除所有所需要的控制器的所有綁定
    usingListLock = Helper.getRigLockNodes(charName)
    charNodeList = [charName + node for node in usingListLock if cmds.objExists(charName + node)]
    cmds.select(charNodeList)
    cmds.select(charName + "root_ctrl", add=1)
    
    if Helper.checkHasConstraint(cmds.ls(sl=1)):
        import ClearConstraints
        reload(ClearConstraints)
        ClearConstraints.execute()

    # 開始執行功能
    proxyRoot = createCircleCross('proxyRoot', radius=100, seg=64, upAxis='z')

    proxyRootCtrl = cmds.createNode('transform',name='proxy:root_ctrl')
    if rotateRoot: 
        cmds.xform(proxyRootCtrl, ws=True, m=(cmds.xform(charName+'root_ctrl',q=True,ws=True,m=True)))
    else:
        cmds.xform(proxyRootCtrl, ws=True, t=(cmds.xform(charName+'root_ctrl',q=True,ws=True,t=True)))
    cmds.parent(proxyRootCtrl, proxyRoot)

    proxyCtrl = createWireCylinder('proxyCtrl', radius=80, height=20, upAxis='z')
    if rotateRoot:
        cmds.xform(proxyCtrl, ws=True, m=(cmds.xform(proxyRootCtrl,q=True,ws=True,m=True)))
    else:
        cmds.xform(proxyCtrl, ws=True, t=(cmds.xform(proxyRootCtrl,q=True,ws=True,t=True)))
    cmds.parent(proxyCtrl, proxyRootCtrl)

    nodesRoot = cmds.createNode('transform',name='nodesRoot')
    cmds.xform(nodesRoot, ws=True, t=(cmds.xform(proxyCtrl,q=True,ws=True,t=True)))
    cmds.parent(nodesRoot, proxyCtrl)

    constRoot = cmds.createNode('transform',name='constRoot')
    cmds.parent(constRoot, proxyRootCtrl)

    

    for o in usingListLock:
        if cmds.objExists(charName+o):
            prxNode = cmds.createNode('transform',name='proxy:'+o)
            cmds.parent(prxNode, nodesRoot)
            cmds.xform('proxy:'+o, ws=True, m=(cmds.xform(charName+o,q=True,ws=True,m=True)))

    framesCount = endTime - startTime + 1

    for f in range(framesCount):
        tFrame = startTime+f
        cmds.currentTime(tFrame)

        if rotateRoot: 
            cmds.xform(proxyRootCtrl, ws=True, m=(cmds.xform(charName+'root_ctrl',q=True,ws=True,m=True)))
            cmds.setKeyframe(proxyRootCtrl + ".rotate")
        else:
            cmds.xform(proxyRootCtrl, ws=True, t=(cmds.xform(charName+'root_ctrl',q=True,ws=True,t=True)))
        cmds.setKeyframe(proxyRootCtrl + ".translate")

        for o in usingListLock:
            if cmds.objExists(charName+o):
                cmds.xform('proxy:'+o, ws=True, m=(cmds.xform(charName+o,q=True,ws=True,m=True)))
                cmds.setKeyframe('proxy:'+ o + ".translate")
                cmds.setKeyframe('proxy:'+ o + ".rotate")
    
    ConstrainNode = cmds.pointConstraint(proxyCtrl, charName+'root_ctrl', mo=False)[0]
    cmds.parent(ConstrainNode, constRoot)

    if rotateRoot:
        ConstrainNode2 = mel.eval("orientConstraint -offset 0 0 0 -skip x -skip y -weight 1 " + proxyCtrl + " " + charName + "root_ctrl;")[0]
        cmds.parent(ConstrainNode2, constRoot)

    for o in usingListLock:
        if cmds.objExists(charName+o):
            if cmds.getAttr(charName+o+'.rx', k=True) and cmds.getAttr(charName+o+'.ry', k=True) and cmds.getAttr(charName+o+'.rz', k=True):
                if "FK" in o:
                    ConstrainNode = cmds.orientConstraint('proxy:'+o, charName+o, mo=False)[0]
                else:
                    ConstrainNode = cmds.parentConstraint('proxy:'+o, charName+o, mo=False)[0]
            else:
                ConstrainNode = cmds.pointConstraint('proxy:'+o, charName+o, mo=False)[0]
            cmds.parent(ConstrainNode, constRoot)
    return proxyRoot, proxyCtrl

def setCharToZero(target, startTime, endTime, flip = False, rotateRootCtrl = False, deleteProxy = False):
    proxyRoot, proxyCtrl = createProxyForOffset(target  + ":", startTime, endTime, rotateRootCtrl)
    
    cmds.currentTime(startTime)
    if flip: cmds.rotate( 0, 0, '180deg', proxyRoot )

    # 本來是用這行來把角色置中，但是proxyCtrl是proxy:root_ctrl的子層，而proxy:root_ctrl在旋轉蛋的功能中是會被旋轉的。一旋轉，子層的位置如果不是原點的話，就會偏移。
    # cmds.xform(proxyCtrl, t=[0,0,0],ws=True)

    # 這邊改成直接對proxy:root_ctrl的key做整體的位置偏移。這樣proxyCtrl就不會被proxy:root_ctrl的旋轉影響
    cmds.keyframe('proxy:root_ctrl.translateX',edit=True,time=(startTime,endTime),valueChange=-cmds.getAttr("proxy:root_ctrl.translateX"), relative=1)
    cmds.keyframe('proxy:root_ctrl.translateY',edit=True,time=(startTime,endTime),valueChange=-cmds.getAttr("proxy:root_ctrl.translateY"), relative=1)
    cmds.keyframe('proxy:root_ctrl.translateZ',edit=True,time=(startTime,endTime),valueChange=-cmds.getAttr("proxy:root_ctrl.translateZ"), relative=1)

    def clear():
        Helper.deleteNode( proxyRoot )

    rigType = Helper.checkRigType(target)

    # 如果要直接導出fbx的話，就不需要做bake的動作。
    if deleteProxy:
        framesCount = endTime - startTime + 1
        for f in range(framesCount):
            tFrame = startTime+f
            cmds.currentTime(tFrame)
            cmds.setKeyframe('%s:root_ctrl.translate' % target)
        
            for o in Helper.getRigLockNodes(rigType):
                if cmds.objExists(target + ':' + o):
                    cmds.setKeyframe('%s:%s.translate' % (target, o))
                    cmds.setKeyframe('%s:%s.rotate' % (target, o))
        clear()
    return clear

def setRootToZero():
    confirm = Helper.showConfirmDialog(u'會解除特定對象的所有綁定，確定執行？')
    if confirm:
        _rootJnt,_main = findMainAndRootJnt()
        startFrame = int(cmds.playbackOptions(q=True, ast=True))
        endFrame = int(cmds.playbackOptions(q=True, aet=True))
        
        names = _main.split(':')
        names.pop()

        charName = ':'.join(names)
        setCharToZero(charName, startFrame, endFrame, False, False, True)

        # Helper.showMessage(u'注意！因爲清除了某些控制器的綁定，可能會對操作造成影響，所以請謹慎評估要不要儲存')

# 找Main control 並對整段time range 歸0
def setRootToZeroTimeRanged():
    ctrlNameArr = ['RootX_M','Main']
    ctrlsToMov = findControls(ctrlNameArr) 
    if(len(ctrlsToMov)):
        cmds.select(ctrlsToMov[0])
        cmds.copyKey(ctrlsToMov[0],at="tx")
        cmds.pasteKey(ctrlsToMov[1],connect=True,at="tx")
        cmds.copyKey(ctrlsToMov[0],at="tz")
        cmds.pasteKey(ctrlsToMov[1],connect=True,at="tz")
        #cmds.scaleKey(ctrlsToMov[1],valueScale=-1,valuePivot=0)
        cmds.scaleKey(ctrlsToMov[1],valueScale=-1,valuePivot=0,at=["tx","ty","tz","rx","ry","rz"])
        
        
    ''''
    _rootJnt,_main = findMainAndRootJnt()
    if((_rootJnt) and (_main) ):
        tmin = int(cmds.playbackOptions(q=True,minTime=True))
        tmax = int(cmds.playbackOptions(q=True,maxTime=True))
        for k in range(tmin,tmax+1):#k=tmin
            cmds.currentTime(k)
            dif = getRootDifToZero(_main,_rootJnt)
            if(dif.length()>0):
                cmds.xform(_main , ws=True, t=(dif.x,dif.y,dif.z))
                cmds.setKeyframe( _main+".translate" )
        cmds.currentTime(tmin)
    return
    '''
# def setFKToIKAnim(bAnim=False):
#     selection = cmds.ls(sl=True)
#     charName=""
#     if(len(selection)):
#         sel = selection[0]
#         if(cmds.referenceQuery(sel,isNodeReferenced=True) == True):
#             charName = sel.split(':')[0]
    
#     ctrlNameArrFK = [
#                    'FKShoulder_L',
#                    'FKShoulder_R',
#                    'FKElbow_L',
#                    'FKElbow_R',
#                    'FKWrist_L',
#                    'FKWrist_R',
#                    'FKSpine1_M',
#                    'FKSpine2_M',
#                    'FKSpine3_M',
#                    #'FKSpine4_M',
#                    'FKHip_L',
#                    'FKHip_R',
#                    'FKKnee_L',
#                    'FKKnee_R',
#                    'FKAnkle_L',
#                    'FKAnkle_R',
#                   ]
    
#     ctrlNameArrIK = [
#                    'IKXShoulder_L',
#                    'IKXShoulder_R',
#                    'IKXElbow_L',
#                    'IKXElbow_R',
#                    'IKArm_L',
#                    'IKArm_R',
#                    'IKXSpine1_M',
#                    'IKXSpine2_M',
#                    'IKXSpine3_M',
#                    #'IKXSpine4_M',
#                    'IKXHip_L',
#                    'IKXHip_R',
#                    'IKXKnee_L',
#                    'IKXKnee_R',
#                    'IKLeg_L',
#                    'IKLeg_R'
#                   ]
#     ctrlsFK = findControls(ctrlNameArrFK,charName) 
#     ctrlsIK = findControls(ctrlNameArrIK,charName) 
    
#     if((not len(ctrlsFK) ) or (len(ctrlsIK) != len(ctrlsFK) ) ):return
    
#     if(bAnim):
#         tmin = int(cmds.playbackOptions(q=True,minTime=True))
#         tmax = int(cmds.playbackOptions(q=True,maxTime=True))
#         for k in range(tmin,tmax+1):
#             cmds.currentTime(k)
#             for c in range(0,len(ctrlsIK)) : # c = 4
#                 rod = cmds.xform(ctrlsIK[c],q=True,ro=True,ws=True)
#                 if(':FKWrist_L' in ctrlsFK[c]):
#                     maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.lArmLclTm)
#                 elif (':FKWrist_R' in ctrlsFK[c]):
#                     maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.rArmLclTm)
#                 elif (':FKAnkle_L' in ctrlsFK[c]):
#                     maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.lLegLclTm)
#                 elif (':FKAnkle_R' in ctrlsFK[c]):
#                     maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.rLegLclTm)
#                 else:
#                     cmds.xform(ctrlsFK[c],ro=rod ,ws=True)
                
#                 cmds.setKeyframe( ctrlsFK[c]+".rotate" )
#             # 發現只做一次會有偏差，原因不明
#             # 一次不夠，那你有做第二次嗎?
#             for c in range(0,len(ctrlsIK)) : # c = 4
#                 rod = cmds.xform(ctrlsIK[c],q=True,ro=True,ws=True)
#                 if(':FKWrist_L' in ctrlsFK[c]):
#                     maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.lArmLclTm)
#                 elif (':FKWrist_R' in ctrlsFK[c]):
#                     maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.rArmLclTm)
#                 elif (':FKAnkle_L' in ctrlsFK[c]):
#                     maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.lLegLclTm)
#                 elif (':FKAnkle_R' in ctrlsFK[c]):
#                     maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.rLegLclTm)
#                 else:
#                     cmds.xform(ctrlsFK[c],ro=rod ,ws=True)
                
#                 cmds.setKeyframe( ctrlsFK[c]+".rotate" )
                
#         cmds.currentTime(tmin)
#     else:
#         for c in range(0,len(ctrlsIK)) : # c = 4
#             rod = cmds.xform(ctrlsIK[c],q=True,ro=True,ws=True)
#             if(':FKWrist_L' in ctrlsFK[c]):
#                 maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.lArmLclTm)
#             elif (':FKWrist_R' in ctrlsFK[c]):
#                 maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.rArmLclTm)
#             elif (':FKAnkle_L' in ctrlsFK[c]):
#                 maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.lLegLclTm)
#             elif (':FKAnkle_R' in ctrlsFK[c]):
#                 maxs.setObjBTm(ctrlsIK[c],ctrlsFK[c],maxs.rLegLclTm)
#             else:
#                 cmds.xform(ctrlsFK[c],ro=rod ,ws=True)
#             cmds.setKeyframe( ctrlsFK[c]+".rotate" )

# def setControllerTransform(charName,ctrlsIK, ctrlsFK, armLPoleCtrl, armRPoleCtrl, legLPoleCtrl, legRPoleCtrl, lArmLclTm_IK, rArmLclTm_IK, lLegLclTm_IK, rLegLclTm_IK, spine0LclTm_IK, spine1LclTm_IK, poleRelative ):
#     if((not len(ctrlsFK) ) or (len(ctrlsIK) != len(ctrlsFK) ) ): 
#         return

#     rigType = Helper.checkRigType(charName)

#     for c in range(0,len(ctrlsIK)) : # c = 4
#         if(':IKArm_L' in ctrlsIK[c]):
#             maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],lArmLclTm_IK)
#         elif(':IKArm_R' in ctrlsIK[c]):
#             maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],rArmLclTm_IK)
#         elif(':IKLeg_L' in ctrlsIK[c]):
#             if rigType != "shuyao":
#                 maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],lLegLclTm_IK)
#         elif(':IKLeg_R' in ctrlsIK[c]):
#             if rigType != "shuyao":
#                 maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],rLegLclTm_IK)
#         elif(':IKXSpine1_M' in ctrlsIK[c]):
#             maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],spine0LclTm_IK)
#         elif(':IKXSpine2_M' in ctrlsIK[c]):
#             maxs.setObjBTm(ctrlsFK[c],ctrlsIK[c],spine1LclTm_IK)
            
#         cmds.setKeyframe( ctrlsIK[c]+".rotate" )
#         cmds.setKeyframe( ctrlsIK[c]+".translate" )

#     # 更新手肘位置
#     keyframed_setElbowNewPoleLocation(armLPoleCtrl[0],armLPoleCtrl[1],armLPoleCtrl[2],armLPoleCtrl[3], poleRelative[0])
#     keyframed_setElbowNewPoleLocation(armRPoleCtrl[0],armRPoleCtrl[1],armRPoleCtrl[2],armRPoleCtrl[3], poleRelative[1])

#     # 樹妖沒有脚
#     if rigType != "shuyao":
#         # 更新脚的pole
#         keyframed_setElbowNewPoleLocation(legLPoleCtrl[0],legLPoleCtrl[1],legLPoleCtrl[2],legLPoleCtrl[3], poleRelative[2])
#         keyframed_setElbowNewPoleLocation(legRPoleCtrl[0],legRPoleCtrl[1],legRPoleCtrl[2],legRPoleCtrl[3], poleRelative[3])
    
#     if rigType == "shandian":
#         Helper.fixShandianRolls(charName)

# def setIKToFKAnim(poleRelative, bAnim=False, startFrame=-999, endFrame=-999, charNames = ''):
#     utilities2.selAllCtrlBiped()
#     selection = cmds.ls(sl=True)

#     charNames = []
#     rigTypes = []
#     if(len(selection)):
#         sel = selection[0]
#         if(cmds.referenceQuery(sel,isNodeReferenced=True) == True):
#             charName = sel.split(':')[0]
#             charNames.append( charName )
#             rigTypes.append( Helper.checkRigType(charName) )

#     ctrlNameArrFK = [
#                     'FKWrist_L',
#                     'FKWrist_R',
#                     'FKRoot_M',
#                     'FKChest_M',
#                     'FKToes2_L',
#                     'FKToes2_R',
#                     ]
        
#     ctrlNameArrIK = [
#                     'IKArm_L',
#                     'IKArm_R',
#                     'IKSpine2_M',
#                     'IKSpine1_M',
#                     'IKLeg_L',
#                     'IKLeg_R'
#                     ]

#     armLPoleCtrlName = ["FKShoulder_L","FKElbow_L","FKWrist_L" ,"PoleArm_L"]
#     armRPoleCtrlName = ["FKShoulder_R","FKElbow_R","FKWrist_R" ,"PoleArm_R"]
#     legLPoleCtrlName = ["FKHip_L","FKKnee_L","FKAnkle_L" ,"PoleLeg_L"]
#     legRPoleCtrlName = ["FKHip_R","FKKnee_R","FKAnkle_R" ,"PoleLeg_R"]

#     ctrlsFKs = []
#     ctrlsIKs = []
#     armLPoleCtrls = []
#     armRPoleCtrls = []
#     legLPoleCtrls = []
#     legRPoleCtrls = []

#     lArmLclTm_IKs = []
#     rArmLclTm_IKs = []
#     lLegLclTm_IKs = []
#     rLegLclTm_IKs = []
#     spine0LclTm_IKs = []
#     spine1LclTm_IKs = []

#     for charName, rigType in zip(charNames, rigTypes):

#         # 現在這邊做判斷
#         legR = ''
#         legL = ''
#         if rigType == 'human':
#             ctrlNameArrFK[4] = 'FKAnkle_L'
#             ctrlNameArrFK[5] = 'FKAnkle_R'
#             legR = 'Ankle_R'
#             legL = 'Ankle_L'
#         elif rigType == 'shandian':
#             ctrlNameArrFK[4] = 'FKToes2_L'
#             ctrlNameArrFK[5] = 'FKToes2_R'
#             legR = 'Toes2_R'
#             legL = 'Toes2_L'
#         else:
#             # 可能之後還有其他的類型。這裏先把其他的都當成人類
#             ctrlNameArrFK[4] = 'FKAnkle_L'
#             ctrlNameArrFK[5] = 'FKAnkle_R'
#             legR = 'Ankle_R'
#             legL = 'Ankle_L'

#         ctrlsFKs.append( findControls(ctrlNameArrFK,charName) )
#         ctrlsIKs.append( findControls(ctrlNameArrIK,charName) )
#         armLPoleCtrls.append( findControls(armLPoleCtrlName,charName) )
#         armRPoleCtrls.append( findControls(armRPoleCtrlName,charName) )
#         legLPoleCtrls.append( findControls(legLPoleCtrlName,charName) )
#         legRPoleCtrls.append( findControls(legRPoleCtrlName,charName) )

#         # 先切回FK模式，做IK對FK的對位
#         Helper.openFKController(charName)
#         cmds.xform(charName + ":IKArm_L", ws=1,m=cmds.xform( charName + ":Wrist_L", q=1,ws=1,m=1))
#         cmds.xform(charName + ":IKArm_R", ws=1,m=cmds.xform( charName + ":Wrist_R", q=1,ws=1,m=1))
        
#         cmds.xform(charName + ":IKSpine1_M", ws=1,m=cmds.xform( charName + ":Root_M", q=1,ws=1,m=1))
#         cmds.xform(charName + ":IKSpine2_M", ws=1,m=cmds.xform( charName + ":Chest_M", q=1,ws=1,m=1))

#         # 樹妖沒有脚
#         if rigType != 'shuyao':
#             cmds.xform(charName + ":IKLeg_L", ws=1,m=cmds.xform( charName + ":" + legL, q=1,ws=1,m=1))
#             cmds.xform(charName + ":IKLeg_R", ws=1,m=cmds.xform( charName + ":" + legR, q=1,ws=1,m=1))
            

#         # 取出旋轉矩陣
#         lArmLclTm_IKs.append(Helper.rotateIKCrtlCurrectToFKCrtl(charName, ":Wrist_L"))
#         rArmLclTm_IKs.append(Helper.rotateIKCrtlCurrectToFKCrtl(charName, ":Wrist_R"))
#         spine0LclTm_IKs.append(Helper.rotateIKCrtlCurrectToFKCrtl(charName, ":Root_M"))
#         spine1LclTm_IKs.append(Helper.rotateIKCrtlCurrectToFKCrtl(charName, ":Chest_M"))

#         # 樹妖沒有脚
#         if rigType == 'shuyao':
#             lLegLclTm_IKs.append(None)
#             rLegLclTm_IKs.append(None)
#         else:
#             lLegLclTm_IKs.append(Helper.rotateIKCrtlCurrectToFKCrtl(charName, ":" + legL))
#             rLegLclTm_IKs.append(Helper.rotateIKCrtlCurrectToFKCrtl(charName, ":" + legR))
    
#     if bAnim:
#         tmin = int(cmds.playbackOptions(q=True,minTime=True)) if startFrame == -999 else startFrame
#         tmax = int(cmds.playbackOptions(q=True,maxTime=True)) if endFrame == -999 else endFrame
#         # tmax = 10
#         for k in range(tmin,tmax+1):
#             cmds.currentTime(k)

#             for i in range(len(charNames)):
#                 charName = charNames[i]
#                 ctrlsFK = ctrlsFKs[i]
#                 ctrlsIK = ctrlsIKs[i]
#                 armLPoleCtrl = armLPoleCtrls[i]
#                 armRPoleCtrl = armRPoleCtrls[i]
#                 legLPoleCtrl = legLPoleCtrls[i]
#                 legRPoleCtrl = legRPoleCtrls[i]

#                 lArmLclTm_IK = lArmLclTm_IKs[i]
#                 rArmLclTm_IK = rArmLclTm_IKs[i]
#                 lLegLclTm_IK = lLegLclTm_IKs[i]
#                 rLegLclTm_IK = rLegLclTm_IKs[i]
#                 spine0LclTm_IK = spine0LclTm_IKs[i]
#                 spine1LclTm_IK = spine1LclTm_IKs[i]
                
#                 setControllerTransform( charName, ctrlsIK, ctrlsFK, armLPoleCtrl, armRPoleCtrl, legLPoleCtrl, legRPoleCtrl,
#                                         lArmLclTm_IK, rArmLclTm_IK, lLegLclTm_IK, rLegLclTm_IK, spine0LclTm_IK, spine1LclTm_IK, poleRelative )
            
#         cmds.currentTime(tmin)
#     else:

#         for i in range(len(charName)):
#             charName = charNames[i]
#             ctrlsFK = ctrlsFKs[i]
#             ctrlsIK = ctrlsIKs[i]
#             armLPoleCtrl = armLPoleCtrls[i]
#             armRPoleCtrl = armRPoleCtrls[i]
#             legLPoleCtrl = legLPoleCtrls[i]
#             legRPoleCtrl = legRPoleCtrls[i]

#             lArmLclTm_IK = lArmLclTm_IKs[i]
#             rArmLclTm_IK = rArmLclTm_IKs[i]
#             lLegLclTm_IK = lLegLclTm_IKs[i]
#             rLegLclTm_IK = rLegLclTm_IKs[i]
#             spine0LclTm_IK = spine0LclTm_IKs[i]
#             spine1LclTm_IK = spine1LclTm_IKs[i]
            
#             setControllerTransform( charName, ctrlsIK, ctrlsFK, armLPoleCtrl, armRPoleCtrl, legLPoleCtrl, legRPoleCtrl,
#                                     lArmLclTm_IK, rArmLclTm_IK, lLegLclTm_IK, rLegLclTm_IK, spine0LclTm_IK, spine1LclTm_IK, poleRelative )
    
# 生成虛擬碰撞體，黏到 root 上
def generateCapsule():
    upAx = [0,1,0]

    bIsZup = False
    if (cmds.upAxis(q=True,ax=True)) == 'z':
        bIsZup = True
        upAx = [0,0,1]

    if(cmds.objExists("capsule_geo")):return
    
    bQuadroped = False # 是否為四足
    shdLPos = None
    shdRPos = None
    if(cmds.objExists("Shoulder_L")):
        shdLPos = cmds.xform("Shoulder_L",q=True,ws=True,t=True)
    elif(cmds.objExists("JawEnd_M")):
        shdLPos = cmds.xform("JawEnd_M",q=True,ws=True,t=True)
        bQuadroped = True
        
    if(cmds.objExists("Shoulder_R")):
        shdRPos = cmds.xform("Shoulder_R",q=True,ws=True,t=True)
    elif(cmds.objExists("Root_M")):
        shdRPos = cmds.xform("Root_M",q=True,ws=True,t=True)
    
    if( (not shdLPos) or (not shdRPos) ):return
    shdLPos_om = om.MVector(shdLPos[0],shdLPos[1],shdLPos[2])
    shdRPos_om = om.MVector(shdRPos[0],shdRPos[1],shdRPos[2])
    if(bQuadroped):
        _radius = ( shdLPos_om - shdRPos_om ).length()*0.6
    else:
        _radius = ( shdLPos_om - shdRPos_om ).length()*1.2

    sp = cmds.polySphere(r=_radius,ax=upAx,sx=20,sy=20,cuv=2,ch=1)[0]
    cmds.rename(sp,"capsule_geo")
    cmds.select("capsule_geo.f[180:359]", "capsule_geo.f[380:399]")
    if bIsZup:
        cmds.move( 0, 0, (getAsCharHeight()-_radius*2) ,r=True)
    else:
        cmds.move( 0, (getAsCharHeight()-_radius*2), 0 ,r=True)
    cmds.select(cl=True)
    cmds.select("capsule_geo")

    if bIsZup:
        cmds.move( 0, 0, _radius ,r=True)
    else:
        cmds.move( 0, _radius, 0 ,r=True)

    centerPos = cmds.xform("capsule_geo",q=True,ws=True,sp=True)
    BBox = cmds.xform("capsule_geo",q=True,ws=True,bb=True)

    if bIsZup:
        cmds.xform("capsule_geo",piv=(centerPos[0],centerPos[1],BBox[2]),ws=True)
    else:
        cmds.xform("capsule_geo",piv=(centerPos[0],BBox[1],centerPos[2]),ws=True)
    

    bl = cmds.shadingNode("blinn",asShader=True)
    cmds.select("capsule_geo")
    cmds.hyperShade(assign=bl)
    cmds.setAttr( bl+".transparencyR",0.906)
    cmds.setAttr( bl+".transparencyG",0.906)
    cmds.setAttr( bl+".transparencyB",0.906)
    cmds.select(cl=True)
    cmds.parentConstraint("root_ctrl","capsule_geo",mo=True)
    
# 生成4個layer "Controller" "Capsule" "Mesh" "Joint"
# 整理基本物件
def assortBasicLayers():
    if(not cmds.objExists("Joint")):
        cmds.createDisplayLayer(name="Joint")
    if(not cmds.objExists("Mesh")):
        cmds.createDisplayLayer(name="Mesh")
    if(not cmds.objExists("Capsule")):
        cmds.createDisplayLayer(name="Capsule")
    if(not cmds.objExists("Controller")):
        cmds.createDisplayLayer(name="Controller")
    try:
        cmds.setAttr("Joint.visibility",False)
        cmds.setAttr("Joint.displayType",2)
        cmds.setAttr("Capsule.displayType",2)
        cmds.setAttr("Mesh.displayType",2)
    except:pass

def addObjsToLayer(layerName,objSets): #layerName = "Controller" nd = "PoleArm_R"
    for nd in objSets :
        try:
            cmds.connectAttr(layerName+".drawInfo",nd+".drawOverride")
        except RuntimeError:
            print( nd + " invalid object to add")


def asAfterBuildJoyFunModified():
    generateCapsule()
    assortBasicLayers()
    
    allCtrlObj = []
    getShapes(getAllObjects(),allCtrlObj ,_type="nurbsCurve",bGetHidden=True)
    
    capsuleGrpName = ['capsule_geo']
    meshGrpName = getSceneSkelMeshs()
    jntGrpName = ['root']
    
    addObjsToLayer("Controller",allCtrlObj)
    addObjsToLayer("Capsule",capsuleGrpName)
    addObjsToLayer("Mesh",meshGrpName)
    addObjsToLayer("Joint",jntGrpName)

    # 有4個煩人的node 在此一併砍了
    Helper.deleteNode("mentalrayGlobals")
    Helper.deleteNode("mentalrayItemsList")
    Helper.deleteNode("miDefaultFramebuffer")
    Helper.deleteNode("miDefaultOptions")


# # 把選中的 cluster 轉成 Joint Chain & 加入控制器
# def turnClustersToJntChain(bOrderByNum=False,baseJntName="joint"):
#     __obj = []
#     sel = cmds.ls(sl=True)
#     selShps = getShapes(sel,__obj ,_type='clusterHandle')
#     jntArray = [] # 最後完成的joint array
#     cmds.select(cl=True)
#     for i in range(0,len(sel)): # i = 0
#         jntName = baseJntName+"_"+str(i)
#         if(i<10):
#             jntName = baseJntName+"_0"+str(i)
#         thisNd = sel[i]
#         thisNdShp = selShps[i]
        
#         curPos = [0,0,0]
#         try: # cluster 要抓的是origin
#             orig = cmds.getAttr(thisNdShp +".origin")[0]
#             _Pos = cmds.xform(thisNd, q=True,t=True,ws=True)
#             curPos = [(orig[0]+_Pos[0]),(orig[1]+_Pos[1]),(orig[2]+_Pos[2])]
#         except:pass
#         jnt = cmds.joint(n=jntName,p=curPos)
#         jntArray.append(jntName)



## UE4 Import Motion Related
#om.MItDependencyGraph.kUpstream
#om.MFn.kAnimCurve
#om.MFn.kNurbsCurve
#getAllDGNodes(tgtConstr,om.MItDependencyGraph.kUpstream,om.MFn.kTransform)

#import maya.OpenMaya as om
# def getAllDGNodes(inNode,direction,nodeMfnType):
#     nodes = []
#     # Create a MSelectionList with our selected items:
#     selList = om.MSelectionList()
#     selList.add(inNode)
#     mObject = om.MObject()  # The current object
#     selList.getDependNode( 0, mObject )

#     # Create a dependency graph iterator for our current object:
#     mItDependencyGraph = om.MItDependencyGraph(mObject,direction,om.MItDependencyGraph.kPlugLevel)
#     while not mItDependencyGraph.isDone():
#         currentItem = mItDependencyGraph.currentItem()
#         dependNodeFunc = om.MFnDependencyNode(currentItem)
#         # See if the current item is an animCurve:
#         if currentItem.hasFn(nodeMfnType):
#             name = dependNodeFunc.name()
#             nodes.append(name)
#         mItDependencyGraph.next()

#     # See what we found:
#     #for n in sorted(nodes):
#     #    print n

#     return nodes

# 初始化控制器綁定到 UE4 sk 上
# def snapIKFKCtrlToMo_UE4(charName="",jntCollection=[]): # charName = rignsp jntCollection = fbxJntCollection_withKeys
#     # Pole 生成並設定新位置
#     # 這段沒有作用了，先關掉
#     # createPoleMocapLoc_UE4(charName,poleVectNameArr)

#     utilities2.selAllCtrlBiped()
#     cmds.duplicate()

#     # 這邊把copy出來的控制器可能被鎖住的屬性解鎖,因爲是copy出來的,所以charName是空的
#     charName = ""
#     cmds.setAttr( charName + 'FKElbow_L.rx', lock=False )
#     cmds.setAttr( charName + 'FKElbow_L.ry', lock=False )
#     cmds.setAttr( charName + 'FKElbow_R.rx', lock=False )
#     cmds.setAttr( charName + 'FKElbow_R.ry', lock=False )
    
#     constNameArr=[]
#     rootctrlo = cmds.pointConstraint("root",charName+":root_ctrl",mo=True)
#     constNameArr.append(rootctrlo[0].replace("_pointConstraint1", ""))
    
#     _HipFKCtrlo = cmds.parentConstraint("Root_M",charName+":RootX_M",mo=True)
#     constNameArr.append(_HipFKCtrlo[0].replace("_parentConstraint1", ""))
#     ## FK Constraint
#     for k in range(0,len(mcToFKNmPar)): # k = 1
#         TgtN = mcToFKNmPar[k][0]
#         TgtN = TgtN.replace("_MoCap_","_")
#         try:
#             _Ctrl = cmds.parentConstraint(TgtN , charName+":"+mcToFKNmPar[k][1],mo=False)
#             constNameArr.append(_Ctrl[0].replace("_parentConstraint1", ""))
#         except:
#             type, message, traceback = sys.exc_info()
#             while traceback:
#                 print("...")
#                 print(type)
#                 print(message)
#                 print(TgtN, charName+":"+mcToFKNmPar[k][1])
#                 print("...")
#                 traceback = traceback.tb_next
        
#     # 手指
#     doFingerConstraint(constNameArr,charName)
    
#     '''
#     additionalCtrl = []
#     for jnt in jntCollection: # jnt = jntCollection[0]
#         coorspJntChar = charName+":"+jnt
#         if(cmds.objExists(coorspJntChar)):
#             allSource = cmds.listConnections(coorspJntChar+".rx",s=True)
#             if(len(allSource) > 0):
#                 tgtConstr = allSource[0]
            
#             else: # No constraint ,bind the joint itself
#                 _Ctrl = cmds.parentConstraint(jnt , coorspJntChar,mo=True)
#                 constNameArr.append(_Ctrl)
#                 additionalCtrl.append(coorspJntChar)
                
#     '''
#     return constNameArr



## Back Mocap 動作到兩組(FK/IK)控制器上
# def bakeCtrlAnim_UE4(constNameArr,charName=""): #constNameArr = consNameAr ; charName = rgnsp

#     # # Back 工作
#     # #setPoleLocKeys(charName,poleVectNameArr)
#     # # FK 要Back的 Node 
#     # NdToBake = [charName+":RootX_M"]
#     # for nds in mcToFKNmPar: # nds=mcToFKNmPar[1]
#     #     NdToBake.append(charName+":"+nds[1])
#     # #for nds in mcToIKNmPar:
#     # #    NdToBake.append(charName+":"+nds[1])
#     # # 手指 bake
#     # for nds in allFingersArr:
#     #     NdToBake.append(charName+":"+nds[1])

#     # if utilities2.checkIsQuad():
#     #     utilities2.selAllCtrlQuad()
#     # else:
#     #     utilities2.selAllCtrlBiped()

#     # NdToBake = cmds.ls(sl=1)
    
#     # minStr = str(int(cmds.playbackOptions(q=True,minTime=True)))
#     # maxStr = str(int(cmds.playbackOptions(q=True,maxTime=True)))

#     minStr = int(cmds.playbackOptions(q=True,minTime=True))
#     maxStr = int(cmds.playbackOptions(q=True,maxTime=True))

#     # maxStr = 10

#     for f in range(minStr, maxStr):
#         cmds.currentTime(f)
#         for proxy in constNameArr:
#             ctrl = charName + ":" + proxy
#             Helper.attach(proxy, ctrl)

#             # 這兩個控制器是樹妖的藤曼，ue4回來的對應的骨頭會有亂旋轉的現象，所以只要第一幀的位置及旋轉就好
#             if proxy == "_BRIG_MainVine_07_MinbVine_ctl_00_L" or proxy == "_BRIG_MainVine_07_MinbVine_ctl_00_R":
#                 if f == minStr:
#                     cmds.setKeyframe(ctrl + ".translate")
#                     cmds.setKeyframe(ctrl + ".rotate")
#             # 這三個控制器是樹妖的腰部、切斷點、根部，這三個需要取得位移及旋轉
#             elif proxy == "cut_curve" or proxy == "RootX_M" or proxy == "LEGspik_Crl_04":
#                 cmds.setKeyframe(ctrl + ".translate")
#                 cmds.setKeyframe(ctrl + ".rotate")
#             else:
#                 # 其他的都只要旋轉就行
#                 cmds.setKeyframe(ctrl + ".rotate")
#                 cmds.setAttr(ctrl + ".translateX", 0)
#                 cmds.setAttr(ctrl + ".translateY", 0)
#                 cmds.setAttr(ctrl + ".translateZ", 0)

#     Helper.deleteNodes(["Main", "Root_M", getFBXCharName() + ":Ref", "Root_MoCap_M", "L_LegMocapPole_x", "L_ElbowMocapPole_x", "R_LegMocapPole_x", "R_ElbowMocapPole_x", "root", constNameArr])
    
#     charArr = cmds.ls(type="HIKCharacterNode")
#     if (len(charArr)):
#         Helper.deleteNode(charArr)
    
#     try:
#         # 頭部的 global channel 不要有key
#         hdctrlsnm = ["FKHead_M"]
#         hdCtrl = findControls(hdctrlsnm)[0]
#         cmds.cutKey(hdCtrl,cl=True,at="Global")
#         cmds.setAttr(hdCtrl+".Global",0)
#     except:pass

#     # Apply All Scene Euler Filter
#     # 呼叫這邊有機會導致動作變形。先忽略
#     # rotcurves = cmds.ls(type="animCurveTA")
#     # for r in range (0,len(rotcurves)/3): #r=1
#     #     cmds.filterCurve( rotcurves[3*r] , rotcurves[3*r+1] , rotcurves[3*r+2] )
    

# def saveInitPoleRelative(charName):
#     retmat = []
    
#     if Helper.checkRigType(charName) == "shuyao":
#         polemap = [
#             ["FKElbow_L", "PoleArm_L"],
#             ["FKElbow_R", "PoleArm_R"]
#         ]
#     else:
#         polemap = [
#             ["FKElbow_L", "PoleArm_L"],
#             ["FKElbow_R", "PoleArm_R"],
#             ["FKKnee_L" , "PoleLeg_L"],
#             ["FKKnee_R" , "PoleLeg_R"]
#         ]

#     for pole in polemap:
#         fkctrl = charName + ":" + pole[0]
#         polectrl = charName + ":" + pole[1]

#         fkmat = cmds.xform(fkctrl, ws=1,m=1,q=1)
#         polemat = cmds.xform(polectrl, ws=1,m=1,q=1)

#         retmat.append( Helper.getOpenMayaMatrix(polemat) * Helper.getOpenMayaMatrix(fkmat).inverse() )
#     return retmat

def processWithAnimation(rigFilePth, deleteImportFBX = True, globalFollow = 0):
    charName = rigFilePth.split('/')[-1].split('.')[0]

    """ 支援非ue4的fbx的導入，因爲公司在導出fbx的時候會有一些多餘的物件，這邊要把它刪掉 """
    needDelete = None
    for obj in cmds.ls():
        target = obj.split(":")[-1]
        if target == "Group":
            needDelete = obj
    if needDelete: cmds.delete(needDelete)

    """ 公司導出的fbx的骨頭會有namespace的名稱，這邊把namespace刪除 """
    for obj in cmds.ls():
        target = obj.split(":")[-1]
        try:
            cmds.rename(obj, target )
        except:
            pass
    fbxobjs = cmds.ls()
    joints = cmds.ls(type="joint")

    cmds.file(rigFilePth,r=True,options="v=0",namespace=charName,ignoreVersion=True )

    # 不知道爲什麽namespace的結尾會自己多了一個1。這邊確保namespace是正確的
    charName = cmds.referenceQuery(pm.listReferences()[0], namespace = 1)

    cmds.evaluationManager( mode="off" )
    setGlobalFollow( charName, globalFollow )

    (backMethod, extraMethod) = JointToController.genMapAndMatchFKIK("", charName)

    minStr = int(cmds.playbackOptions(q=True,minTime=True))
    maxStr = int(cmds.playbackOptions(q=True,maxTime=True))

    # minStr = 95
    # maxStr = 105

    for i in range(minStr, maxStr+1): backMethod(i)
    extraMethod()

    Helper.fixEulerCurve()
    if deleteImportFBX: Helper.deleteNodes(fbxobjs)
    cmds.evaluationManager( mode="parallel" )

    return (joints, charName)

def UE4MotionProcess(toolroot, globalFollow = 0): #toolroot = "D:/00Trunk/PY/JoyFunToolSetMaya/00tools/AdvancedSkeleton/scripts/" 
    # 開啟FileBrowseDlg ，找尋要import的fbx file
    openFileDialog1 = System.Windows.Forms.OpenFileDialog()
    openFileDialog1.Filter = "fbx files (*.fbx)|*.fbx|All files (*.*)|*.*";
    openFileDialog1.FilterIndex = 1
    dfmotionLoc = None
    try:dfmotionLoc = cmds.optionVar( q='asMotionLoc')
    except:pass
    if(dfmotionLoc==0):
        dfmotionLoc = "C:\\"
        cmds.optionVar(sv=('asMotionLoc', dfmotionLoc) )

    openFileDialog1.InitialDirectory = dfmotionLoc
    openFileDialog1.Multiselect = True

    if (openFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK):
        allF = openFileDialog1.FileNames
        cmds.optionVar(sv=('asMotionLoc', os.path.dirname(allF[0])) )
        rigFilePth = cmds.file(q=True,sn=True)

        success = True
        for ff in allF: #ff = allF[0] len(allF)
            fileN = ff.split('\\')[-1].split('.')[0]
             
            if(len(rigFilePth)==0):
                System.Windows.Forms.MessageBox.Show(u"請至少開啟一個Rig file 再開始做bake motion")
                success = False
                break
                
            # charName = rigFilePth.split('/')[-1].split('.')[0]
            #檔名
            _filename = (ff.split('\\')[-1]).split('.')[0]

            # 存的目標檔
            tgtDir = os.path.dirname(ff)
            tgtFilePth = tgtDir +"\\"+_filename +".ma" 

            # 新建空白場景
            cmds.file(f=True,new=True)

            # 場景FPS60
            # 經測試，無法在外面設定。所以可能視美術需要。要開參數出來
            cmds.currentUnit(t="ntscf")

            # 開始import fbx 動作
            _string = 'source "'+toolroot+'/FBXImportModule.mel"'
            mel.eval( _string )
            sv = 'string $res = doImportFbx("'+ff.replace('\\','/')+'");'
            resStr = mel.eval(sv)
            if(resStr != "Success"):break

            processWithAnimation(rigFilePth, True, globalFollow)

            cmds.file(rename=tgtFilePth) # tgtFilePth = "D:\JF_RPG\Art_WorkSpace\Animation\idle_2_crouch_jnt.ma"
            cmds.file(save=True,type='mayaAscii',force = True)
            print( 'success on', tgtFilePth)
        
        if success:
            cmds.confirmDialog(title='完成'.decode("utf-8"), message='完成'.decode("utf-8"), button='確認'.decode("utf-8"))



            # """ 支援非ue4的fbx的導入，因爲公司在導出fbx的時候會有一些多餘的物件，這邊要把它刪掉 """
            # needDelete = None
            # for obj in cmds.ls():
            #     target = obj.split(":")[-1]
            #     if target == "Group":
            #         needDelete = obj
            # if needDelete: cmds.delete(needDelete)

            # """ 公司導出的fbx的骨頭會有namespace的名稱，這邊把namespace刪除 """
            # for obj in cmds.ls():
            #     target = obj.split(":")[-1]
            #     try:
            #         cmds.rename(obj, target )
            #     except:
            #         pass
            # fbxobjs = cmds.ls()

            # cmds.file(rigFilePth,r=True,options="v=0",namespace=charName,ignoreVersion=True )

            # # 不知道爲什麽namespace的結尾會自己多了一個1。這邊確保namespace是正確的
            # charName = cmds.referenceQuery(pm.listReferences()[0], namespace = 1)

            # cmds.evaluationManager( mode="off" )
            # setGlobalFollow( charName, globalFollow )
            
            # (backMethod, extraMethod) = JointToController.genMapAndMatchFKIK("", charName)

            # minStr = int(cmds.playbackOptions(q=True,minTime=True))
            # maxStr = int(cmds.playbackOptions(q=True,maxTime=True))

            # # minStr = 1100
            # # maxStr = 1200

            # for i in range(minStr, maxStr): backMethod(i)
            # extraMethod()

            # Helper.fixEulerCurve()
            # Helper.deleteNodes(fbxobjs)
            # cmds.evaluationManager( mode="parallel" )

            # # 把所有爲了bake而導入的unlock的rig檔換成有lock的原檔
            # # 在修正成不需要parent constraints的模式之後，就不需要換成unlock的版本
            # # Helper.replaceMocapReferenceToNormal()

            # # 另存新檔 
            # cmds.file(rename=tgtFilePth) # tgtFilePth = "D:\JF_RPG\Art_WorkSpace\Animation\idle_2_crouch_jnt.ma"
            # cmds.file(save=True,type='mayaAscii',force = True)
            # cmds.confirmDialog(title='完成'.decode("utf-8"), message='完成'.decode("utf-8"), button='確認'.decode("utf-8"))

