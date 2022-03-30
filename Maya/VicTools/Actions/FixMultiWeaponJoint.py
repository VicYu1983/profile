# -*- coding: utf-8 -*-
import maya.cmds as cmds
import Helper
import GuiBase
from PySide2.QtGui import *
from PySide2.QtWidgets import *
from os.path import isfile, join, exists
import pymel.core as pm

# 檢查跟主角類似的狀況
def checkMethodA():
    weapons = cmds.ls("*:weapon_R_jnt_P2")
    jnts = []
    if ( len(weapons) == 2 ):
        w1 = len(cmds.listRelatives(weapons[0], ap=1, f=1)[0].split("|"))
        w2 = len(cmds.listRelatives(weapons[1], ap=1, f=1)[0].split("|")  )
        jnts = weapons
    elif( len( weapons ) == 1):
        w1 = len(cmds.listRelatives(weapons[0], ap=1, f=1)[0].split("|"))
        w2Weapon = cmds.ls("weapon_R_jnt_P2")[0]
        w2 = len(cmds.listRelatives(w2Weapon, ap=1, f=1)[0].split("|"))
        jnts = [weapons[0], w2Weapon]
    else: 
        return None, None

    if w1 > w2:
        hand_weapon = jnts[0]
        weapon = jnts[1]
    else:
        hand_weapon = jnts[1]
        weapon = jnts[0]

    return hand_weapon, weapon

# 檢查跟mingdeng類似的狀況
def checkMethodB():
    # 開始檢查是否有重複的武器骨頭

    # 所有的骨頭
    jnts = cmds.ls(type="joint")

    # 所有的武器骨頭
    weaponjnts = cmds.ls('*Weapon*', type='joint')
    if len(weaponjnts) == 0: weaponjnts = cmds.ls('*weapon*', type='joint')

    # 沒有開方的長度運算
    def calculateLength(v1, v2):
        return (v1[0]-v2[0])**2 + (v1[1]-v2[1])**2 + (v1[2]-v2[2])**2

    # 檢查所有的骨頭中，有沒有和武器骨頭在幾乎相同的位置
    # 如果有的話，很大概率是多出來的武器

    hand_weapon = weapon = None
    for wjnt in weaponjnts:
        wjnt_pos = cmds.xform(wjnt, q=1, ws=1, t=1)
        
        for jnt in jnts:
            jnt_pos = cmds.xform(jnt, q=1, ws=1, t=1)

            # 略過同名骨頭
            if wjnt != jnt:

                # 長度小於0.001的取出來
                if calculateLength(wjnt_pos, jnt_pos) < .001:

                    # 各自檢查有沒有parent
                    # 沒有parent的大概率是外包人員加出來的，就是我們要找的骨頭
                    wjnt_refs = cmds.listRelatives(wjnt,allParents=1)
                    refs = cmds.listRelatives(jnt,allParents=1)
                    
                    if wjnt_refs:
                        hand_weapon = wjnt
                        weapon = jnt
                    elif refs:
                        hand_weapon = jnt
                        weapon = wjnt

    return hand_weapon, weapon

def execute():

    global fbxPath
    fbxPath = None

    def fbxCallback(path):
        global fbxPath
        fbxPath = path[0]
    GuiBase.openFileDialog(fbxCallback, QFileDialog.AnyFile, "*.fbx")

    if fbxPath and exists(fbxPath):
        cmds.file(new=1, f=1)
        Helper.importFBX(fbxPath)

        hand_weapon, weapon = checkMethodA()
        if not hand_weapon:
            hand_weapon, weapon = checkMethodB()
        if not hand_weapon:
            Helper.showMessage(u'沒有匹配檢查條件，沒有檢查出重複的骨頭，如果有問題，請找技術人員')
            return

        jnts = cmds.ls(type="joint")
        if hand_weapon not in jnts or weapon not in jnts:
            return

        (min_inner, max_inner, min_outer, max_outer) = Helper.getTimelineInfo()
        
        cmds.parentConstraint( weapon, hand_weapon )
        cmds.bakeResults(hand_weapon, t=(min_outer, max_outer), simulation=1)
        cmds.delete(weapon)

        fbxPath = fbxPath.replace(".fbx", "_fix.fbx")
        pm.mel.FBXExport(f=fbxPath)

        Helper.showMessage(u'處理完畢，另存名稱為: \n%s' % fbxPath)



