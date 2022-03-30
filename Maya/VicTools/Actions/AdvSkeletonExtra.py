# -*- coding: utf-8 -*-
import maya.cmds as cmds
import maya.mel as mel

def fixAdvSkeletonZup():
    if cmds.upAxis(q=1, ax=1) == "z":
        mel.eval('setAttr -k on FitSkeleton.rotateX;')
        cmds.setAttr( 'FitSkeleton.rx', lock=False )
        cmds.setAttr( 'FitSkeleton.rx', 90)

def backToOriSkeleton():
    cmds.setAttr( 'FitSkeleton.rx', 0)

def convertToJF(rootDir, isLimb = False):
    if cmds.upAxis(q=1, ax=1) == "z":
        cmds.setAttr("Main.rotateX", 90 )
        cmds.select(["FitSkeleton", "MotionSystem", "DeformationSystem"])
        cmds.parent(w=1)
        cmds.select("Main")
        cmds.FreezeTransformations()
        cmds.makeIdentity(apply=1,t=1,r=1,s=1,n=0,pn=1)
        cmds.select(["FitSkeleton", "MotionSystem", "DeformationSystem"])
        cmds.select("Main", add=1)
        cmds.parent()
    if not isLimb:  mel.eval('source "' + rootDir + 'ConvertToJF.mel";')
        
def fixZup(node):
    if cmds.objExists(node):
        if cmds.upAxis(q=1, ax=1) == "z":
            cmds.setAttr(node + ".rotateX", l=False)
            cmds.setAttr(node + ".rotateX", 90 )
            cmds.setAttr(node + ".rotateX", l=True)