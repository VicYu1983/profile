# -*- coding: utf-8 -*-
import maya.cmds as cmds 

""" 
樹妖因爲root結構比較特別，所以特製一個script修正mocap回來maya后產生的錯誤
"""

def findShuyao():
    shuyaoCtrlNamespace = ""
    shuyaoJointNamespace = ""
    for obj in cmds.ls(type="transform"):
        if "LEGspik_Crl_04" in obj:
            shuyaoCtrlNamespace = ":".join(obj.split(":")[0:-1])
    for obj in cmds.ls(type="transform"):
        if "MinbVine_jot_00_L" in obj:
            tmp = ":".join(obj.split(":")[0:-1])
            if tmp != shuyaoCtrlNamespace:
                shuyaoJointNamespace = tmp
    return (shuyaoCtrlNamespace, shuyaoJointNamespace)

constraintMap = [
   ("LEGspik_Crl_04", "root"),
   ("_BRIG_MainVine_07_MinbVine_ctl_00_L", "MinbVine_jot_00_L"),
   ("_BRIG_MainVine_07_MinbVine_ctl_00_R", "MinbVine_jot_00_R")
]

(ctrlNs, jntNs) = findShuyao()
for (ctrlName, jntName) in constraintMap:
    ctrl = ctrlNs + ":" + ctrlName
    jnt = jntNs + ":" + jntName
    constraint = cmds.parentConstraint(jnt, ctrl, weight=1)
    cmds.delete(constraint)
