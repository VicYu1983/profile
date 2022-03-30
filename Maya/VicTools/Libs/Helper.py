# -*- coding: utf-8 -*-
import maya.cmds as cmds
import maya.mel as mel
import os

if int(cmds.about(version=True)) >= 2017:
    from PySide2.QtGui import *
    from PySide2.QtWidgets import *
    import maya.api.OpenMaya as om
else:
    from PySide.QtGui import *
    import maya.OpenMaya as om

import math

def getAllIKNode(ns):
    ikNodes = [ 'IKArm_R',
                'IKArm_L',
                'PoleArm_R',
                'PoleArm_L',
                'IKLeg_R',
                'IKLeg_L',
                'PoleLeg_R',
                'PoleLeg_L',
                'Ctrl_MainWeapon']
    return [ns + ":" + node for node in ikNodes]

# 打印方法。使用方式：
# log = Helper.getLogger('AdvSkeleton')
# log( obj )
def getLogger(appName):
    def log(logobj):
        title = '[===' + appName + '===]'
        isStr = False
        for typestr in [dict, list]:
            if type(logobj) is typestr:
                isStr = True

        if isStr:
            print(title)
            print(logobj)
        else:
            print(title + ' ' + logobj)
    return log

# 參數用**kwargs進來時，可以把kwargs當成物件來用，視爲{key:value}的物件
# 如果要把物件轉回方法裏的每一個對應參數，就把那個物件加上**。這裏的那個物件就是kwargs
# 所以這裏的流程為
# **kwargs進來 => kwargs物件 => 再轉爲參數形式**kwargs
def cutKey(name, **kwargs):
    try:
        cmds.cutKey(name, **kwargs)
    except: pass

# 參數用**kwargs進來時，可以把kwargs當成物件來用，視爲{key:value}的物件
# 如果要把物件轉回方法裏的每一個對應參數，就把那個物件加上**。這裏的那個物件就是kwargs
# 所以這裏的流程為
# **kwargs進來 => kwargs物件 => 再轉爲參數形式**kwargs
def setKeyframe(name, **kwargs):
    try:
        cmds.setKeyframe(name, **kwargs)
    except: pass

# 安全的設值的方式
def setAttr(attrName, value):
    try:
        cmds.setAttr(attrName, value)
    except:
        pass

# 安全的設值的方式
def getAttr(attrName):
    try:
        return cmds.getAttr(attrName)
    except:
        return None

# 安全的刪除屬性的方式
def deleteAttr(node, attrName):
    try:
        cmds.deleteAttr(node, at=attrName)
    except:
        pass

# 安全的刪掉節點的方式
def deleteNodes(list):
    for node in list:
        deleteNode(node)

def deleteNode(node):
    try:
        cmds.delete(node)
    except:
        pass


    # 由mel的矩陣轉爲openMaya的矩陣
def getOpenMayaMatrix(mat):
    if int(cmds.about(version=True)) >= 2017:
        return om.MMatrix((
            (mat[0],mat[1],mat[2],mat[3]),
            (mat[4],mat[5],mat[6],mat[7]),
            (mat[8],mat[9],mat[10],mat[11]),
            (mat[12],mat[13],mat[14],mat[15])
        ))
    else:
        matrix = om.MMatrix()
        om.MScriptUtil.createMatrixFromList(mat, matrix)
        return matrix
    
# 由openMaya的矩陣轉爲mel的矩陣
def getMelMatrix(mat):
    if int(cmds.about(version=True)) >= 2017:
        return [    mat.getElement(0,0),mat.getElement(0,1),mat.getElement(0,2),mat.getElement(0,3),
                    mat.getElement(1,0),mat.getElement(1,1),mat.getElement(1,2),mat.getElement(1,3),
                    mat.getElement(2,0),mat.getElement(2,1),mat.getElement(2,2),mat.getElement(2,3),
                    mat.getElement(3,0),mat.getElement(3,1),mat.getElement(3,2),mat.getElement(3,3)]
    else:
        return [mat(0,0),mat(0,1),mat(0,2),mat(0,3),
                mat(1,0),mat(1,1),mat(1,2),mat(1,3),
                mat(2,0),mat(2,1),mat(2,2),mat(2,3),
                mat(3,0),mat(3,1),mat(3,2),mat(3,3)]

def openFKController(charName):
    setAttr(charName+":FKIKArm_L.FKIKBlend",0)
    setAttr(charName+":FKIKArm_R.FKIKBlend",0)
    setAttr(charName+":FKIKLeg_L.FKIKBlend",0)
    setAttr(charName+":FKIKLeg_R.FKIKBlend",0)

    # guicha01a
    setAttr(charName+":FKIKArm2_L.FKIKBlend",0)
    setAttr(charName+":FKIKArm2_R.FKIKBlend",0)

def openIKController(charName):
    setAttr(charName+":FKIKArm_L.FKIKBlend",10)
    setAttr(charName+":FKIKArm_R.FKIKBlend",10)
    setAttr(charName+":FKIKLeg_L.FKIKBlend",10)
    setAttr(charName+":FKIKLeg_R.FKIKBlend",10)

    # guicha01a
    setAttr(charName+":FKIKArm2_L.FKIKBlend",10)
    setAttr(charName+":FKIKArm2_R.FKIKBlend",10)

def getIKFKBlend(charName):
    return [
        getAttr(charName+":FKIKArm_L.FKIKBlend"),
        getAttr(charName+":FKIKArm_R.FKIKBlend"),
        getAttr(charName+":FKIKLeg_L.FKIKBlend"),
        getAttr(charName+":FKIKLeg_R.FKIKBlend"),

        # guicha01a
        getAttr(charName+":FKIKArm2_L.FKIKBlend"),
        getAttr(charName+":FKIKArm2_R.FKIKBlend"),
    ]
def setIKFKBlend(charName, blend):
    setAttr(charName+":FKIKArm_L.FKIKBlend",blend[0])
    setAttr(charName+":FKIKArm_R.FKIKBlend",blend[1])
    setAttr(charName+":FKIKLeg_L.FKIKBlend",blend[2])
    setAttr(charName+":FKIKLeg_R.FKIKBlend",blend[3])

    # guicha01a
    setAttr(charName+":FKIKArm2_L.FKIKBlend",blend[4])
    setAttr(charName+":FKIKArm2_R.FKIKBlend",blend[5])

# 計算在同一個位置的骨頭在IK及FK模式下的旋轉差距
def rotateIKCrtlCurrectToFKCrtl( charName, joint ):
    oriAutoKeyState = cmds.autoKeyframe(q=True,state=True)
    cmds.autoKeyframe(state=False)

    blendValue = getIKFKBlend(charName)

    joint = charName + joint

    # 在IK模式的時候，調整IKcontroller也會影響到FK的controller
    openFKController(charName)

    # 取出骨頭在FK模式時的矩陣
    jointInFKMat = cmds.xform(joint,q=1,ws=1,m=1)

    # 轉換到IK模式
    openIKController(charName)

    # 取出骨頭在IK模式時的矩陣
    jointInIKMat = cmds.xform(joint,q=1,ws=1,m=1)

    # 計算兩個狀態時的矩陣差
    jointInFKMat = getOpenMayaMatrix(jointInFKMat)
    jointInIKMat = getOpenMayaMatrix(jointInIKMat)

    # 這裏的意思是取出IK到FK的矩陣差
    # 或者說FK矩陣在IK矩陣下的在地坐標
    diffmat = jointInFKMat * jointInIKMat.inverse()

    cmds.autoKeyframe(state=oriAutoKeyState)
    setIKFKBlend(charName, blendValue)

    melMatrix = getMelMatrix( diffmat )
    
    melMatrix[12] = 0
    melMatrix[13] = 0
    melMatrix[14] = 0

    # 因爲有旋轉的關係，要注意矩陣相乘的順序，不同的順序結果不一樣    
    return melMatrix

def addTransform(node, mat):
    orimat = cmds.xform(node, ws=1,q=1,m=1)
    totalmat = getOpenMayaMatrix( mat ) * getOpenMayaMatrix( orimat )
    cmds.xform(node, ws=1,m=getMelMatrix(totalmat))

def attach(target, current):
    # print( current + " attach to " + target)
    cmds.xform(current, ws=1,m=cmds.xform( target, q=1,ws=1,m=1))

def replaceMocapReferenceToNormal():
    refs = cmds.ls(type='reference')
    for ref in refs:
        # reference的資料不知道爲什麽都會產生一些奇怪的東西...
        if 'sharedReferenceNode' in ref: continue
        if '_UNKNOWN_REF_NODE_' in ref: continue
        refFile = cmds.referenceQuery(ref, f = True, shn=False)
        if "_mocap" in refFile:
            oriFile = refFile.split('.')[0].replace("_mocap", "") + ".ma"
            cmds.file(oriFile, loadReference=ref)

DENGSHI_01 = "dengshi01"
GUICHA_01A = "guicha01a"
FUTENG = "futeng"
WEAPON = "weapon"
BAMBOO = "bamboo"
HUAYAO = "huayao"
SHANDIAN = "shandian"
HUMAN = "human"
SHUYAO = "shuyao"
YINBING = "yinbing"
HALFHUMAN = "halfhuman"

listLockNodes = {
    HUMAN: [    'RootX_M',
                'FKHead_M',
                'FKScapula_R',
                'FKScapula_L',
                'FKShoulder_R',
                'FKShoulder_L',
                'IKArm_R',
                'IKArm_L',
                'PoleArm_R',
                'PoleArm_L',
                'FKHip_R',
                'FKHip_L',
                'IKLeg_R',
                'IKLeg_L',
                'PoleLeg_R',
                'PoleLeg_L',
                'counter_P_ctrl'],
    DENGSHI_01:['RootX_M', 'counter_P_ctrl'],
    GUICHA_01A:['RootX_M',
                'FKHead_M',
                'FKScapula_R',
                'FKScapulaArm2_R',
                'FKScapula_L',
                'FKScapulaArm2_L',
                'FKShoulder_R',
                'FKShoulderArm2_R',
                'FKShoulder_L',
                'FKShoulderArm2_L',
                'IKArm_R',
                'IKArm2_R',
                'IKArm_L',
                'IKArm2_L',
                'PoleArm_R',
                'PoleArm2_R',
                'PoleArm_L',
                'PoleArm2_L',
                'FKHip_R',
                'FKHip_L',
                'IKLeg_R',
                'IKLeg_L',
                'PoleLeg_R',
                'PoleLeg_L',
                'counter_P_ctrl'],
    YINBING:[   'RootX_M',
                'FKHead_M',
                'FKScapula_R',
                'FKScapula_L',
                'FKShoulder_R',
                'FKShoulder_L',
                'IKArm_R',
                'IKArm_L',
                'PoleArm_R',
                'PoleArm_L',
                'FKHip_R',
                'FKHip_L',
                'IKLeg_R',
                'IKLeg_L',
                'PoleLeg_R',
                'PoleLeg_L',
                'Head_break_Crl',
                'Elbow_R_break_Crl',
                'Elbow_L_break_Crl',
                'Wrist_R_break_Crl',
                'Wrist_L_break_Crl',
                'Shoulder_R_break_Crl',
                'Shoulder_L_break_Crl',
                'Chest_break_Crl',
                'Spine1_break_Crl',
                'Hip_R_break_Crl',
                'Hip_L_break_Crl',
                'Knee_R_break_Crl',
                'Knee_L_break_Crl',
                'Ankle_R_break_Crl',
                'Ankle_L_break_Crl',
                'counter_P_ctrl'],     
}

def allowToTranferOffsetTool(ns):
    rigType = checkRigType(ns)
    return rigType in listLockNodes

def getRigLockNodes(ns):
    rigType = checkRigType(ns)
    if rigType in listLockNodes: return listLockNodes[rigType]
    return listLockNodes[HUMAN]

def checkHasConstraint(nodes):
    for node in nodes:
        childs = cmds.listRelatives(node, c=1)        
        cons = [child for child in childs if 'Constraint' in child]
        if len(cons) > 0: return True
    return False

def checkRigType(charName):
    # if cmds.objExists( charName + ":l_cir_root_ctrl") and cmds.objExists( charName + ":r_cir_root_ctrl"):
    #     return SHUANGSHOU01
    if cmds.objExists( charName + ":Knee_L_break_Crl"):
        return YINBING
    if cmds.objExists( charName + ":eye_crl") and cmds.objExists( charName + ":DengShi_01_crl"):
        return DENGSHI_01
    if cmds.objExists( charName + ":FKWristArm2_L"):
        return GUICHA_01A
    if cmds.objExists( charName + ":SubVine_Fk_Crl_10"):
        return FUTENG
    if cmds.objExists( charName + ":AllPowerful_jnt_ctrl"):
        return WEAPON
    if cmds.objExists( charName + ":Vine_FK_ctrl_08"):
        return BAMBOO
    if cmds.objExists( charName + ":FKPinky2Finger3_R") and not cmds.objExists( charName + ":FKPinky2Finger3_L"):
        return HUAYAO
    if cmds.objExists( charName+":Toes2_L"):
        return SHANDIAN
    if cmds.objExists( charName+":Toes_L"):
        return HUMAN
    if cmds.objExists( charName+":BRIG_MainVine_07_MinbVine_ctl_00_L"):
        return SHUYAO
    if not cmds.objExists( charName+":FKKnee_L"):
        return HALFHUMAN
    return ""

def checkRigIsWangLiang(charName):
    if(checkRigType(charName) == SHANDIAN and cmds.objExists( charName+":FKTail8_M")):
        return True
    return False
    

def fixRollToeJoint(charName, joint, parentJoint, controller):
    # 切換到fk
    if "_L" in joint: setAttr(charName+":FKIKLeg_L.FKIKBlend",0)
    else: setAttr(charName+":FKIKLeg_R.FKIKBlend",0)
        
    # 取出fk時的脚踝方向
    fktoe2 = cmds.xform(charName+":"+joint, t=1,q=1,ws=1)
    fktoe1 = cmds.xform(charName+":"+parentJoint, t=1,q=1,ws=1)

    fktoe2vec = om.MVector(fktoe2[0],fktoe2[1],fktoe2[2])
    fktoe1vec = om.MVector(fktoe1[0],fktoe1[1],fktoe1[2])

    fkdiff = fktoe1vec - fktoe2vec

    # 切換到ik
    if "_L" in joint: setAttr(charName+":FKIKLeg_L.FKIKBlend",10)
    else: setAttr(charName+":FKIKLeg_R.FKIKBlend",10)

    # 先把脚踝的controller的轉向歸0
    setAttr(charName+":"+controller+".rotateX", 0)

    # 取出ik時的脚踝方向
    iktoe2 = cmds.xform(charName+":"+joint, t=1,q=1,ws=1)
    iktoe1 = cmds.xform(charName+":"+parentJoint, t=1,q=1,ws=1)

    iktoe2vec = om.MVector(iktoe2[0],iktoe2[1],iktoe2[2])
    iktoe1vec = om.MVector(iktoe1[0],iktoe1[1],iktoe1[2])

    ikdiff = iktoe1vec - iktoe2vec

    # 技術ik和fk狀態的角度差距
    fkdiff.normalize()
    ikdiff.normalize()

    try:
        angle = math.acos(fkdiff * ikdiff)
    except:
        angle = 0

    # 設置角度正值來比對
    degree = angle / 3.14 * 180
    setAttr(charName+":"+controller+".rotateX", degree)

    # 設完角度后,取出比對的骨頭，取距離較進的角度
    iktoe1 = cmds.xform(charName+":"+parentJoint, t=1,q=1,ws=1)
    iktoe1vec = om.MVector(iktoe1[0],iktoe1[1],iktoe1[2])
    compare1 = (iktoe1vec - fktoe1vec).length()
    
    # 設置角度負值來比對
    setAttr(charName+":"+controller+".rotateX", -degree)

    iktoe1 = cmds.xform(charName+":"+parentJoint, t=1,q=1,ws=1)
    iktoe1vec = om.MVector(iktoe1[0],iktoe1[1],iktoe1[2])
    compare2 = (iktoe1vec - fktoe1vec).length()

    # 取用較接近的角度
    if compare1 < compare2:
        setAttr(charName+":"+controller+".rotateX", degree)
    else:
        setAttr(charName+":"+controller+".rotateX", -degree)

def fixShandianRolls(charName):
    fixRollToeJoint( charName, "Toes2_L", "Toes1_L", "RollToes2_L" )
    fixRollToeJoint( charName, "Toes1_L", "Ankle_L", "RollToes1_L" )
    fixRollToeJoint( charName, "Toes2_R", "Toes1_R", "RollToes2_R" )
    fixRollToeJoint( charName, "Toes1_R", "Ankle_R", "RollToes1_R" )
    cmds.setKeyframe(charName+":RollToes1_L" + ".translate")
    cmds.setKeyframe(charName+":RollToes1_L" + ".rotate")
    cmds.setKeyframe(charName+":RollToes2_L" + ".translate")
    cmds.setKeyframe(charName+":RollToes2_L" + ".rotate")
    cmds.setKeyframe(charName+":RollToes1_R" + ".translate")
    cmds.setKeyframe(charName+":RollToes1_R" + ".rotate")
    cmds.setKeyframe(charName+":RollToes2_R" + ".translate")
    cmds.setKeyframe(charName+":RollToes2_R" + ".rotate")

def getOpenMayaMatrixByNode(node):
    return getOpenMayaMatrix( cmds.xform( node, ws=1, m=1, q=1 ) )


# 取出Ankle和IKLeg的相對矩陣
def getDiffMatFromAnkleAndIKLeg(RollHeel, RollToes, RollToesEnd, IKLeg, Ankle):
    
    # 取出本來?踝的旋轉
    ori_rots = []
    for node in (RollHeel, RollToes, RollToesEnd):
        ori_rots.append( (cmds.getAttr(node + ".rotateX"), cmds.getAttr(node + ".rotateY"), cmds.getAttr(node + ".rotateZ")) )
        
    # 先把RollToes的旋轉歸零再能取得初始狀態下的Ankle和IKLeg的相對矩陣
    for node in (RollHeel, RollToes, RollToesEnd):        
        cmds.setAttr(node + ".rotateX", 0)
        cmds.setAttr(node + ".rotateY", 0)
        cmds.setAttr(node + ".rotateZ", 0)

    # 有時候ik控制器會超出整條腿的長度，這個時候，就要先把ik控制器定位到脚踝骨頭的位置
    # 這樣算出來的旋轉才會是正確的
    ori_IKLeg_xform = cmds.xform(IKLeg, ws=1, m=1, q=1)
    cmds.xform(IKLeg, ws=1, t=cmds.xform(Ankle, ws=1, t=1, q=1))    

    # 這個參數也會影響IKLeg的中心點，所以也要先歸零
    ori_roll = cmds.getAttr(IKLeg + ".roll")
    cmds.setAttr(IKLeg + ".roll", 0)
    
    # 計算相對矩陣
    IKLeg_xform = cmds.xform( IKLeg, ws=1, m=1, q=1 )
    IKLeg_xform_om = getOpenMayaMatrix( IKLeg_xform )
    
    Ankle_xform = cmds.xform( Ankle, ws=1, m=1, q=1 )
    Ankle_xform_om = getOpenMayaMatrix( Ankle_xform )
    
    Ankle_to_IKLeg_xform = IKLeg_xform_om * Ankle_xform_om.inverse()
    
    # 算完后，把?踝的旋轉歸位
    for node, ori_rot in zip((RollHeel, RollToes, RollToesEnd), ori_rots):
        cmds.setAttr(node + ".rotateX", ori_rot[0])
        cmds.setAttr(node + ".rotateY", ori_rot[1])
        cmds.setAttr(node + ".rotateZ", ori_rot[2])
    cmds.setAttr(IKLeg + ".roll", ori_roll)
    cmds.xform(IKLeg, ws=1, m=ori_IKLeg_xform)
    
    return Ankle_to_IKLeg_xform

def fixRollToe(frame, RollHeel, RollToes, RollToesEnd, IKLeg, Ankle, PoleLeg, Toes, FKToes):

    # ===========================================
    # 先把上一個及下一個frame的狀態先bake
    # 否則在設定這個frame的key的時候，後續的動作他會自己内插到下一個有key時的動作
    # 會影響準確性
    # ===========================================

    for setFrame in (frame - 1, frame + 1):
        cmds.currentTime(setFrame)
        setKeyframe( IKLeg + ".translate" )
        setKeyframe( IKLeg + ".rotate" )
        setKeyframe( IKLeg + ".roll" )
        setKeyframe( IKLeg + ".toe" )

        for node in (RollHeel, RollToes, RollToesEnd):
            setKeyframe(node, at="rotate")

        setKeyframe( PoleLeg, at="translate")
        setKeyframe( FKToes, at="rotate")

    # ===========================================
    # 回到當前的frame，開始做轉換
    # ===========================================

    cmds.currentTime(frame)

    Ankle_to_IKLeg_xform = getDiffMatFromAnkleAndIKLeg(RollHeel, RollToes, RollToesEnd, IKLeg, Ankle)
    
    # pole也會被影響到，所以要先記下pole的世界矩陣
    PoleLeg_xform = cmds.xform( PoleLeg, m=1, ws=1, q=1 )
    
    # 這個骨頭的旋轉就是FKToes的旋轉，先記下來，因?待會在調整IKLeg的時候，會影響到Toes
    Toes_xform = cmds.xform( Toes, ws=1, m=1, q=1 )
    
    Ankle_xform = cmds.xform( Ankle, ws=1, m=1, q=1 )
    Ankle_xform_om = getOpenMayaMatrix( Ankle_xform )
    
    IKLeg_xform = Ankle_to_IKLeg_xform * Ankle_xform_om

    # 確保位置是在脚踝骨頭的位置上
    IKLeg_xform[12] = Ankle_xform_om[12]
    IKLeg_xform[13] = Ankle_xform_om[13]
    IKLeg_xform[14] = Ankle_xform_om[14]
    
    cmds.xform( IKLeg, ws=1, m=IKLeg_xform )
    setKeyframe(IKLeg, at="translate")
    setKeyframe(IKLeg, at="rotate")
    setAttr(IKLeg + ".roll", 0)
    setKeyframe(IKLeg, at="roll")
    
    # 這個時候已經把旋轉拉出去了，所以這邊就可以把旋轉歸零
    for node in (RollHeel, RollToes, RollToesEnd):
        setAttr(node + ".rotateX", 0)
        setAttr(node + ".rotateY", 0)
        setAttr(node + ".rotateZ", 0)
        setKeyframe(node, at="rotate")
    
    cmds.xform( PoleLeg, m=PoleLeg_xform, ws=1)
    setKeyframe( PoleLeg, at="translate")

    setAttr( IKLeg + ".toe", 0 )
    setKeyframe(IKLeg, at="toe")
    cmds.xform( FKToes, m=Toes_xform, ws=1 )
    setKeyframe(FKToes, at="rotate")

def fixEulerCurve():
    # 修正萬向鎖
    nodes = cmds.ls()
    for node in nodes:
        rotateKeys = cmds.keyframe( node, at="rotate",q=1 )
        if rotateKeys and len(rotateKeys) > 0:
            try:
                cmds.filterCurve( node + ".rotateX", node + ".rotateY", node + ".rotateZ")
            except: pass

def checkIsNeedFixHumanRole(ns, start, end):
    if checkRigType(ns) != HUMAN: return ([], [])

    oriFrame = int(cmds.currentTime(q=1))
    def checkOneSide(IKLeg, RollToes):
        frames = []
        for frame in range(start, end):
            cmds.currentTime(frame, update=False)
            roll = getAttr(IKLeg + ".roll")
            toe = getAttr(IKLeg + ".toe")
            rollToeRX = getAttr(RollToes + ".rotateX")
            rollToeRY = getAttr(RollToes + ".rotateY")
            rollToeRZ = getAttr(RollToes + ".rotateZ")
            for value in (roll, toe, rollToeRX, rollToeRY, rollToeRZ):
                if value and abs(value) > 0:
                    frames.append(frame)
        return frames   
    result = (checkOneSide(ns + ':IKLeg_L', ns + ":RollToes_L"), checkOneSide(ns + ':IKLeg_R', ns + ":RollToes_R"))
    cmds.currentTime(oriFrame, update=False)
    return result

def fixHumanRoleToe(ns, left, right, start, end, onlyStartFrame = False):
    # 記錄原來的模式設定
    oriLegBlend_L = getAttr(ns+":FKIKLeg_L.FKIKBlend")
    oriLegBlend_R = getAttr(ns+":FKIKLeg_R.FKIKBlend")

    # 換到IK模式，調整脚踝
    setAttr(ns+":FKIKLeg_L.FKIKBlend",10)
    setAttr(ns+":FKIKLeg_R.FKIKBlend",10)

    if onlyStartFrame:
        if left:  fixRollToe( start, ns + ":RollHeel_L", ns + ":RollToes_L", ns + ":RollToesEnd_L", ns + ":IKLeg_L", ns + ":Ankle_L", ns + ":PoleLeg_L", ns + ":Toes_L", ns + ":FKToes_L")
        if right: fixRollToe( start, ns + ":RollHeel_R", ns + ":RollToes_R", ns + ":RollToesEnd_R", ns + ":IKLeg_R", ns + ":Ankle_R", ns + ":PoleLeg_R", ns + ":Toes_R", ns + ":FKToes_R")
    else:
        for f in range(start, end):
            if left:  fixRollToe( f, ns + ":RollHeel_L", ns + ":RollToes_L", ns + ":RollToesEnd_L", ns + ":IKLeg_L", ns + ":Ankle_L", ns + ":PoleLeg_L", ns + ":Toes_L", ns + ":FKToes_L")
            if right: fixRollToe( f, ns + ":RollHeel_R", ns + ":RollToes_R", ns + ":RollToesEnd_R", ns + ":IKLeg_R", ns + ":Ankle_R", ns + ":PoleLeg_R", ns + ":Toes_R", ns + ":FKToes_R")

    # 返回原來的模式設定
    setAttr(ns+":FKIKLeg_L.FKIKBlend",oriLegBlend_L)
    setAttr(ns+":FKIKLeg_R.FKIKBlend",oriLegBlend_R)

def getTimelineInfo():
    return (
        int(cmds.playbackOptions(min=1, q=1)),
        int(cmds.playbackOptions(max=1, q=1)),
        int(cmds.playbackOptions(ast=1, q=1)),
        int(cmds.playbackOptions(aet=1, q=1))
    )

def setTimelineInfo(start, end):
    cmds.playbackOptions(min=start)
    cmds.playbackOptions(max=end)
    cmds.playbackOptions(ast=start)
    cmds.playbackOptions(aet=end)

def importFBX( path ):

    # 在mel裏只支援左斜綫
    path = path.replace('\\', '/')

    mel.eval("FBXImportFillTimeline -v true;")
    mel.eval("FBXImportGenerateLog -v false;")
    mel.eval('FBXImportSkeletonDefinitionsAs -v "humanik";')
    mel.eval('FBXImportSkins -v false;')
    mel.eval('FBXImport -f "' + path + '";')

def showMessage(msg):
    msgBox = QMessageBox()
    msgBox.setText(msg)
    msgBox.exec_()

def getParent(node):
    p = cmds.listRelatives( node, allParents=True )
    if p: return p[0]
    return None

# example:
# p = getNodeRoot(cmds.ls(sl=1))
# print(p)  
def getNodeRoot(node):
    p = getParent(node)
    if p == None:
        mesh = node
    else:
        plist = [p]
        while p != None:
            p = getParent(p)
            plist.append(p)
        if len(plist) > 1:
            mesh = plist[-2]
        else:
            mesh = plist[0]
    return mesh

def getSkelMesh(skel):
    def appendToSelect(node, list):	
        if node not in list and cmds.nodeType( node, api=True ) == "kMesh" and cmds.getAttr("%s.visibility" % node):
            list.append( node )
            
    root = skel
    bones = cmds.listRelatives(root,ad=1)
    bones = [root] + bones
    
    if bones is not None:
        
        # collect export objects
        listToSelect = []
    
        for bone in bones:
    
            # get reference skinCluster
            try:
                listOfSkinCluster = cmds.connectionInfo("%s.objectColorRGB" % bone,dfs=1)
            except:
                print("too many objects or values on bone.objectColorRGB, target:" + bone)
                continue
            
            # find bind mesh
            for sc in listOfSkinCluster:
                skinNode = sc.split(".")[0]
                
                # collect creature type
                bindList = cmds.connectionInfo("%s.outputGeometry[0]" % skinNode,dfs=1)
                for mesh in bindList:
                    node = mesh.split(".")[0]
                    appendToSelect( node, listToSelect )
                
                # collect machine type
                skinsetList = cmds.connectionInfo("%s.message" % skinNode,dfs=1)
                for skinset in skinsetList:
                    node = skinset.split(".")[0]
                    
                    # check has attribute
                    hasAttr = cmds.attributeQuery("memberWireframeColor", node=node, exists=True)
                    if hasAttr:
                        bindList = cmds.connectionInfo("%s.memberWireframeColor" % node,dfs=1)
                        for mesh in bindList:
                            node = mesh.split(".")[0]
                            appendToSelect( node, listToSelect )
        return listToSelect
    return []

def forceDeleteNamespace( namespaceToDelete ):
    cmds.namespace (set=namespaceToDelete)
    cmds.delete(cmds.namespaceInfo (listOnlyDependencyNodes=True))
    cmds.namespace (set=':')
    cmds.namespace(force=True,rm=namespaceToDelete)

def getFPS():
    fps = cmds.currentUnit( query=True, time=True )
    if fps == "game": fps = 15
    if fps == "film": fps = 24
    if fps == "pal": fps = 25
    if fps == "ntsc": fps = 30
    if fps == "show": fps = 48
    if fps == "palf": fps = 50
    if fps == "ntscf": fps = 60
    if "fps" in str(fps): fps = int(fps.replace("fps", ""))
    return fps

# example
# makeGlobalNode("Camera")
def makeGlobalNode(node, start = 0, end = 10, copyAttrs = None):
    
    # rc=1 代表要把所有的小孩rename，不然會有重名問題
    # ilf=1 代表要繼承動畫的key
    newone = cmds.duplicate(node, rc=1)[0]
    try:
        cmds.parent(newone,w=1)
    except: pass

    # 把複製出來的camera的所有constraint都刪除，注意上面在複製的時候rc=1（rename）
    consts = cmds.listRelatives(newone, type="constraint")
    if consts != None: 
        for const in consts: cmds.delete( const )

    # 有時候camera的參數會被lock住，這時就無法做constraint，所以要先解鎖
    cmds.setAttr(newone + ".translateX", lock=0)
    cmds.setAttr(newone + ".translateY", lock=0)
    cmds.setAttr(newone + ".translateZ", lock=0)
    cmds.setAttr(newone + ".rotateX", lock=0)
    cmds.setAttr(newone + ".rotateY", lock=0)
    cmds.setAttr(newone + ".rotateZ", lock=0)
    cmds.setAttr(newone + ".scaleX", lock=0)
    cmds.setAttr(newone + ".scaleY", lock=0)
    cmds.setAttr(newone + ".scaleZ", lock=0)
    cmds.parentConstraint( node, newone )

    # 本來用這行會導致被bake的camera的focalLength的key被刪掉,原因不明,改用下面的呼叫方法可以解決
    # cmds.bakeResults( newone, t=(start,end) )

    # 直接從maya的bake指令複製下來的,目前使用沒問題
    mel.eval('bakeResults -simulation false -t "'+str(start)+':'+str(end)+'" -hierarchy below -sampleBy 1 -oversamplingRate 1 -disableImplicitControl true -preserveOutsideKeys true -sparseAnimCurveBake false -removeBakedAttributeFromLayer false -removeBakedAnimFromLayer false -bakeOnOverrideLayer false -minimizeRotation true -controlPoints false -shape true {"'+newone+'"};')

    if copyAttrs:
        for attr in copyAttrs:
            cmds.copyKey( node, at=attr, time=(start,end))

            # 沒有key的時候,貼上會有error,真麻煩啊==
            try:
                cmds.pasteKey( newone, at=attr)
            except: pass
    return newone


# 實現在maya的roll、pitch、yaw
# 如果是ue4的坐標要轉過來的話
# pitch和yaw的值要乘-1
# 範例： 
# obj = createRollPitchYaw()
# obj["setYawKey"](30, 40)
# obj["clear"]()
def createRollPitchYaw():
    rollProxy = cmds.spaceLocator()[0]
    pitchProxy = cmds.spaceLocator()[0]
    yawProxy = cmds.spaceLocator()[0]
    cmds.parent( rollProxy, pitchProxy )
    cmds.parent( pitchProxy, yawProxy ) 
    
    def setXKey(frame,value):
        cmds.setKeyframe( yawProxy + ".translateX", t=(frame,frame), v=value )
        
    def setYKey(frame,value):
        cmds.setKeyframe( yawProxy + ".translateY", t=(frame,frame), v=value )
        
    def setZKey(frame,value):
        cmds.setKeyframe( yawProxy + ".translateZ", t=(frame,frame), v=value )
    
    def setRollKey(frame,value):
        cmds.setKeyframe( rollProxy + ".rotateX", t=(frame,frame), v=value )
    
    def setPitchKey(frame,value):
        cmds.setKeyframe( pitchProxy + ".rotateY", t=(frame,frame), v=value )
        
    def setYawKey(frame,value):
        cmds.setKeyframe( yawProxy + ".rotateZ", t=(frame,frame), v=value )
            
    def setX(value):
        cmds.setAttr(yawProxy +".translateX", value)
        
    def setY(value):
        cmds.setAttr(yawProxy +".translateY", value)
        
    def setZ(value):
        cmds.setAttr(yawProxy +".translateZ", value)
    
    def roll(value):
        cmds.setAttr(rollProxy +".rotateX", value)
        
    def pitch(value):
        cmds.setAttr(pitchProxy +".rotateY", value)
        
    def yaw(value):        
        cmds.setAttr(yawProxy +".rotateZ", value)
        
    def getXform():
        return cmds.xform(rollProxy, q=1,ws=1,m=1)
        
    def clear():
        cmds.delete([rollProxy, pitchProxy, yawProxy])
    
    return locals()
    
def getMocapPath(path):
    if "_mocap.ma" not in path:
        mocapPath = path.replace(".ma", "_mocap.ma")
        if os.path.exists(mocapPath): return mocapPath
    return path

def mergeAllShots2():
    
    def setKeyOnStartEnd( shot, camera ):
        cmds.select(cl=True)
        cmds.select(camera)

        # make sure no parent on camera
        if cmds.listRelatives(p=1):
            parentNode = cmds.listRelatives(p=1)
            cmds.parent(w=1)
            cmds.delete(parentNode)

        # add un=1 can duplicate also animation key
        tempCamera = cmds.duplicate(un=1)[0]
        
        start = cmds.shot( shot, st=1, q=1 )
        end = cmds.shot(shot, et=1, q=1 )
        cmds.currentTime(start)
        cmds.setKeyframe( tempCamera, time=start )
        cmds.currentTime(end)
        cmds.setKeyframe( tempCamera, time=end )
        
        return tempCamera
        
    shots = cmds.ls(type='shot')
    shots = sorted(shots, key=lambda shot: cmds.shot(shot, st=1, q=1 ))

    firstShot = shots[0]
    firstCamera = cmds.shot( firstShot, cc=1, q=1 )
        
    usingCamera = setKeyOnStartEnd( firstShot, firstCamera )
    
    shots = shots[1:]
    for shot in shots:
        camera = cmds.shot( shot, cc=1, q=1 )
        start = cmds.shot( shot, st=1, q=1 )
        end = cmds.shot(shot, et=1, q=1 )

        tempCamera = setKeyOnStartEnd( shot, camera )
        
        cmds.copyKey( tempCamera, time=(start, end))
        cmds.pasteKey( usingCamera )
        cmds.delete( tempCamera )

    return cmds.rename( usingCamera, 'AllShotsCamera')

# 這個方法會合并包含camera shot以及刪掉舊有的所有camera
# 如果要不影響舊的camera的話，就用mergeAllShots2方法
def mergeAllShots( onlyCamera = True ):
    
    def setKeyOnStartEnd( shot, camera ):
        start = cmds.shot( shot, st=1, q=1 )
        end = cmds.shot(shot, et=1, q=1 )
        cmds.currentTime(start)
        cmds.setKeyframe( camera, time=start )
        cmds.currentTime(end)
        cmds.setKeyframe( camera, time=end )
    
    shots = cmds.ls(type='shot')
    shots = sorted(shots, key=lambda shot: cmds.shot(shot, st=1, q=1 ))

    allStart = cmds.shot( shots[0], st=1, q=1 )
    allEnd = cmds.shot( shots[-1], et=1, q=1 )

    firstShot = shots[0]
    firstCamera = cmds.shot( firstShot, cc=1, q=1 )
    
    setKeyOnStartEnd( firstShot, firstCamera )
     
    shots = shots[1:]
    for shot in shots:
        camera = cmds.shot( shot, cc=1, q=1 )
        start = cmds.shot( shot, st=1, q=1 )
        end = cmds.shot(shot, et=1, q=1 )

        setKeyOnStartEnd( shot, camera )
        
        cmds.copyKey( camera, time=(start, end))
        cmds.pasteKey( firstCamera )
        cmds.delete( camera )

        # 只合并camera的話，就需要調整shot，把所有shot的camera指向第一個camera
        if onlyCamera: 
            cmds.shot( shot, cc=firstCamera, edit=1 )

    # 合并全部的話，就要把所有shot刪掉。創一個新的出來
    if not onlyCamera:
        cmds.delete( shots + [firstShot] ) 
        cmds.shot( firstCamera, sn=firstCamera, cc=firstCamera, st=allStart, sst=allStart, et=allEnd, set=allEnd )

def isCamera(node):
    try:
        relative = cmds.listRelatives(node)
    except: return False
    if len(cmds.ls(relative)) == 1:
        return cmds.nodeType(relative) == "camera"
    return False

def showConfirmDialog(msg):
    confirm = cmds.confirmDialog( title='Confirm', message=msg, button=['Yes','No'], defaultButton='Yes', cancelButton='No', dismissString='No' )
    return (confirm == 'Yes')

def createTempLocator(name, mat):
    temp = cmds.spaceLocator()[0]
    newName = cmds.rename(temp, name)
    cmds.xform(newName, ws=1, m=mat)

def setRotateZKeyOnRootCtrl(ns, start, end):
    root_ctrl = ns + ":root_ctrl"
    valueOnKeys = cmds.keyframe(root_ctrl, at="rotateZ", vc=1, q=1)
    needBake = True
    
    # 如果有key而且key的值不爲0就不需要bake
    if valueOnKeys:
        hasValue = len([v for v in valueOnKeys if abs(v) > 0]) > 0
        if hasValue: needBake = False
        
    if needBake:
        for i in range(start, end):
            cmds.currentTime(i, update=1)

            # 不能直接使用rotateZ的值，因爲RootX_M有可能有constraint導致坐標系不一樣
            # 改用xform的方式
            xform = cmds.xform( ns + ":RootX_M", q=1, m=1, ws=1)
            x_dir = om.MVector(xform[0], xform[1], 0)
            x_dir.normalize()

            y_dir = om.MVector(xform[4], xform[5], 0)
            y_dir.normalize()

            xform[0] = x_dir.x
            xform[1] = x_dir.y
            xform[2] = x_dir.z

            xform[4] = y_dir.x
            xform[5] = y_dir.y
            xform[6] = y_dir.z

            xform[8] = xform[9] = 0
            xform[10] = 1

            cmds.xform( root_ctrl, ws=1, m=xform )
            cmds.setKeyframe(root_ctrl + ".rotateZ")

            cmds.setAttr(root_ctrl + '.translateX', 0)
            cmds.setAttr(root_ctrl + '.translateY', 0)
            cmds.setAttr(root_ctrl + '.translateZ', 0)

# 先選擇要有動態的物件,再選擇要bake key的物件
# 可以復選,例如(動態=>bake=>動態=>bake),這樣就會一次bake兩個物件
def quickBakeKey():
    jnts = cmds.ls(sl=1,type="joint")

    (min_inner, max_inner, min_outer, max_outer) = getTimelineInfo()
    bakes = []
    for i in range(0, len(jnts), 2):
        hand_weapon = jnts[i+1]
        weapon = jnts[i]
        cmds.parentConstraint( weapon, hand_weapon )
        bakes.append(hand_weapon)
    if(len(bakes) > 0):
        cmds.bakeResults(bakes, t=(min_outer, max_outer), simulation=1)

def checkAndMakeDir(filedir):
    if not os.path.exists(filedir):
        os.makedirs(filedir)
                
def JFExportFBX(target_role, start, end, file_path, includeMorph = False, isSimulateCloth = False):
    def GetClothCtrlNode() :
        ctrlNodes = []
        allNodes = cmds.ls(dag = True, type = 'transform', l = True)
        if (allNodes == None) :
            return ctrlNodes
        for node in  allNodes:
            if (node[(len(node) - 11) : len(node)] == 'ncloth_ctrl') : 
                ctrlNodes.append(node)
        return ctrlNodes

    def ClearClothKey(clothctrlNodes):
        for node in clothctrlNodes :
            cmds.cutKey(node, clear=1)

    def SetSimclothParamByShot(clothctrlNodes, startTime, endTime):
        for node in clothctrlNodes :
            allAttrs = cmds.listAttr(node, ud = True)
            if (allAttrs == None):
                continue
            try:
                for attr in allAttrs:
                    if (attr == 'StartFrame'):
                        cmds.setAttr(node + '.' + attr, startTime)
                    else:
                        attrTyp = cmds.getAttr(node + '.' + attr, typ = True)
                        if (attrTyp == 'enum') :
                            cmds.setAttr(node + '.' + attr, 1)
            except:
                print ('warn: set cloth param error ' + node)
        return
        
    _startFrame = start
    _endFrame = end
    bone_root = '%s:Root_M' % target_role
    cmds.select(cl=True)
    cmds.select(bone_root)

    if isSimulateCloth:
        clothctrl = GetClothCtrlNode()
        ClearClothKey( clothctrl )
        SetSimclothParamByShot(clothctrl, _startFrame, _endFrame)
        
    # 如果需要導出morph的key的資料的話，就打開以下三行
    if includeMorph:
        listToSelect = getSkelMesh( bone_root )
        cmds.select(cl=True)
        cmds.select(listToSelect)

    # Geometry
    mel.eval("FBXExportSmoothingGroups -v true")
    mel.eval("FBXExportHardEdges -v false")
    mel.eval("FBXExportTangents -v false")
    mel.eval("FBXExportSmoothMesh -v true")
    mel.eval("FBXExportInstances -v false")

    # Animation
    mel.eval("FBXExportBakeComplexAnimation -v true" )
    mel.eval("FBXExportAnimationOnly -v false")
    mel.eval("FBXExportBakeComplexStart -v "+ str(_startFrame))
    mel.eval("FBXExportBakeComplexEnd -v "+ str(_endFrame))
    mel.eval("FBXExportBakeComplexStep -v 1")
    #mel.eval("FBXExportBakeResampleAll -v true")
    mel.eval("FBXExportUseSceneName -v false")
    mel.eval("FBXExportQuaternion -v euler")
    mel.eval("FBXExportShapes -v true")
    mel.eval("FBXExportSkins -v true")
    # Constraints
    mel.eval("FBXExportConstraints -v false")
    # Cameras
    mel.eval("FBXExportCameras -v false")
    # Lights
    mel.eval("FBXExportLights -v false")
    # Embed Media
    mel.eval("FBXExportEmbeddedTextures -v false")
    # Connections
    mel.eval("FBXExportInputConnections -v true")
    
    mel.eval("FBXExportFileVersion -v \"FBX201400\"")
    # Axis Conversion
    mel.eval("FBXExportUpAxis z")
    # Export!
    mel.eval('FBXExport -f "'+ file_path +'" -s')

def exportFBXAtTimeRange(skel, fbx_path, start, end):
    cmds.select(clear=1)
    cmds.select(skel)
    setTimelineInfo(start, end)
    mel.eval('FBXExport -f "'+ fbx_path +'.fbx" -s')

def bakeResultsWithoutAnimationLayer( node, start, end ):
    cmds.bakeResults( node,
						simulation=True,
						t=(start, end),
						hierarchy="below",
						sampleBy=1,
						disableImplicitControl=True,
						preserveOutsideKeys=True,
						sparseAnimCurveBake=False,
						removeBakedAttributeFromLayer=False,
						removeBakedAnimFromLayer=False,
						bakeOnOverrideLayer=False,
						minimizeRotation=True,
						controlPoints=False,
						shape=True)

# example: autoSplitAnimation('Camera', 0, 100, ('QD:QD1', 'CL1'))
def autoSplitAnimation(camera, start, end, check_roles, step=50):
    import maya.api.OpenMaya as om
    import math

    def checkRoleInCamera( camera, role, check_degree = 40 ):
        if not cmds.objExists(role): return False
        camera_mat = cmds.xform( camera, ws=1, q=1, m=1)
        camera_pos = om.MVector(cmds.xform(camera, ws=1, q=1, t=1))
        camera_z_dir = om.MVector(-camera_mat[8], -camera_mat[9], -camera_mat[10]).normalize()
        
        role_pos = om.MVector(cmds.xform( role, ws=1, q=1, t=1 ))
        role_dir = (role_pos - camera_pos).normalize()
        
        angle = math.acos( camera_z_dir * role_dir )
        degree = angle / 3.14159 * 180
        return degree < check_degree
        
    def appendNewSectionAt(i):
        start_frame = max(start, i-step)
        end_frame = min(end, start_frame+step)
        result[role]['sections'].append([start_frame,end_frame])
        result[role]['open'] = True

    def changeLastSectionAt(i):
        end_frame = min(end, i + step)
        result[role]['sections'][-1][1] = end_frame

    check_max_size = 55000
    check_min_size = 500
    check_max_degree = 90
    check_min_degree = 60

    role_check_degrees = []
    for role in check_roles:
        bounding_box = cmds.exactWorldBoundingBox( '*' + role + ':*' )
        bounding_box_width = bounding_box[3] - bounding_box[0]
        bounding_box_depth = bounding_box[4] - bounding_box[1]
        bounding_box_height = bounding_box[5] - bounding_box[2]
        size = max(bounding_box_width, bounding_box_depth)
        size = max(size, bounding_box_height)

        size_factor = (size - check_min_size) / (check_max_size - check_min_size)
        check_degree = (check_max_degree - check_min_degree) * size_factor + check_min_degree

        check_degree = max( check_min_degree, check_degree)
        check_degree = min( check_max_degree, check_degree)

        role_check_degrees.append(check_degree)

    result = {}
    for i in range(start, end + step, step):
        cmds.currentTime(i)
        for role, check_degree in zip(check_roles, role_check_degrees):

            if role not in result:
                result[role] = {'sections':[], 'open':False}
            
            # check the role show in the camera 
            in_camera = checkRoleInCamera( camera, role + ':Root_M', check_degree )
            if in_camera:
                
                # if show in camera, check need to be add new section of determine current section end frame
                if result[role]['open']:
                    
                    # if role section is open, get current section and replace end frame by current frame
                    changeLastSectionAt(i)
                else:
                    
                    # if role section is close
                    if len(result[role]['sections']) > 0:
                        
                        # if already has section, check last section end frame, 
                        # if end frame distance from last section end frame less then 5
                        # will see it is not new section
                        section_last = result[role]['sections'][-1][1]
                        if i <= section_last + step:
                            changeLastSectionAt(i)
                        else:
                            appendNewSectionAt(i)
                    else:
                        appendNewSectionAt(i)
            else:
                if result[role]['open']:
                    result[role]['open'] = False

    return_ary = []
    for role in check_roles:
        return_ary.append([role, result[role]['sections']])

    return return_ary



