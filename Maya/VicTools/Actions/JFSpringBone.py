# -*- coding: utf-8 -*-
import maya
import maya.cmds as cmds
import maya.mel as mel
import maya.api.OpenMaya as om
import pymel.core as pm
import pymel.core.datatypes as dt
import Helper
reload(Helper)

def removeListener():
    if hasattr(maya, "eid"):
        om.MDGMessage.removeCallback(getattr(maya, "eid"))
        delattr(maya, "eid")

def deleteAllProxy():
    cmds.delete(cmds.ls( "springProxyLocator*" ))

def createProxy(color=(1,1,0), visible = 1):
    rootProxy = cmds.spaceLocator()[0]
    rootProxy = cmds.rename(rootProxy, "springProxyLocator")
    cmds.setAttr(rootProxy + ".overrideEnabled", 1)
    cmds.setAttr(rootProxy + ".overrideRGBColors",1)
    cmds.setAttr(rootProxy + ".overrideColorR", color[0])
    cmds.setAttr(rootProxy + ".overrideColorG", color[1])
    cmds.setAttr(rootProxy + ".overrideColorB", color[2])
    cmds.setAttr(rootProxy + ".visibility", visible)
    return rootProxy

def getNode(name):
    a = pm.ls(name)
    if a:
        return a[0]
    else: return None
    
def getTrans(obj):
    return dt.Vector(pm.xform(obj, ws=1, t=1,q=1))
    
def getRot(obj):
    return pm.xform(obj,q=1,ws=1,rotation=1)
    
def getMatrix(obj):
    return pm.xform(obj, ws=1, m=1, q=1)

def yanbinMethod(start = 0, end = 0, spring = .2, twist = .2, friction = .7, spread = 3, loopCount = 0, cacheCount = 100, liveEdit = True):
    cmds.currentTime(start)
    # print("init frame", cmds.currentTime(q=1))

    nullSubFix = "_spring"
    objTransDict = {}
    melobjs = []
    objmap = []
    deleteObjs = []
    roots = pm.ls(sl=1)
    for root in roots:
        childs = pm.listRelatives(root, allDescendents=True, type='joint')
        childs.reverse()
        melobjs += [child.name() for child in childs]

        childs = [root] + childs
        
        for obj in childs:
            if len(obj.listRelatives(children=1)) > 0 and (obj.getParent() is not None):
                child = grandChild = None
                if obj.listRelatives(children=1, type='joint'):
                    child = obj.listRelatives(children=1, type='joint')[0]
                if child:
                    if child.listRelatives(children=1, type='transform'):
                        grandChild = child.listRelatives(children=1, type='transform')[0]

                    null = pm.spaceLocator(name=obj.name() + nullSubFix)
                    null.setTranslation( child.getTranslation(space='world'))
                    null.setRotation( child.getRotation(space='world'))
                    pm.parent(null, obj.getParent())
                    deleteObjs.append(null.name())
                    
                    pm.cutKey( obj, time=(start, end+0.99999) )
                    pm.cutKey( child, time=(start, end+0.99999) )
                    
                    pm.setKeyframe(obj, attribute = 'rotate')
                        
                    prevObjPos = getTrans(obj)
                    prevObjYAxis = getMatrix(obj)[4:7]
                    prevChildPos = getTrans(child)
                    boneLength = (prevObjPos - prevChildPos).length()
                    
                    prevRot = getRot(obj)
                    objTransDict[obj] = [prevObjPos, prevChildPos, prevRot, False, False, boneLength, prevObjYAxis]
                    objmap.append([obj, child])
    pm.select(roots)
    def onTimeUpdate(*args):
        # print("update frame", cmds.currentTime(q=1))
        for [obj, child] in objmap:

            prevChildPos = objTransDict[obj][1]
            boneLength = objTransDict[obj][5]

            currObjPos = getTrans(obj)
            objNull = getNode(obj.name() + nullSubFix)
            currChildPos = getTrans(objNull)
            
            prevObjYAxis = objTransDict[obj][6]
            currObjYAxis = getMatrix(objNull)[4:7]
            prevUpVector = dt.Vector(prevObjYAxis[0], prevObjYAxis[1], prevObjYAxis[2]).normal()
            currUpVector = dt.Vector(currObjYAxis[0], currObjYAxis[1], currObjYAxis[2]).normal()
            upVector = (prevUpVector * (1-twist) + currUpVector*twist).normal()
            
            forwardVector = ((prevChildPos - currObjPos) * (1-spring) + (currChildPos - currObjPos) * spring).normal()
            rightVector = (upVector ^ forwardVector).normal()

            newmat = dt.Matrix([
                [forwardVector.x,forwardVector.y,forwardVector.z,0],
                [upVector.x,upVector.y,upVector.z,0],
                [rightVector.x,rightVector.y,rightVector.z,0],
                [currObjPos.x,currObjPos.y,currObjPos.z,1]
            ])
            
            pm.xform(obj, ws=1, m=newmat)
            pm.setKeyframe(obj, attribute = 'rotate')
            obj.setAttr("sx", 1)
            obj.setAttr("sy", 1)
            obj.setAttr("sz", 1)

            r = getRot(obj)
            upVector = getMatrix(obj)[4:7]
            currObjPos = getTrans(obj)
            currChildPos = getTrans(child)
            objTransDict[obj] = [currObjPos, currChildPos, r, False, False, boneLength, upVector]
    return [onTimeUpdate, melobjs, deleteObjs]

def vicMethod(start = 0, end = 0, spring = .2, twist = .2, friction = .7, spread = 3, loopCount = 0, cacheCount = 100, liveEdit = True):
    rootProxyWorldMatPrevsList = []
    rootProxyList = []
    boneProxyMapList = []
    childsList = []
    deleteObjs = []
    roots = cmds.ls(sl=1)
    for root in roots:
        cmds.select(root)
        childs = cmds.listRelatives(allDescendents=True, type='joint')
        childs.reverse()

        cmds.cutKey(childs, time=(start, end))

        rootProxy = createProxy()
        rootProxyWorldMatMel = cmds.xform(root, m=1,ws=1,q=1)
        rootProxyWorldMatOm = Helper.getOpenMayaMatrix(rootProxyWorldMatMel)
        cmds.xform(rootProxy, m=rootProxyWorldMatMel, ws=1)
        rootProxyList.append(rootProxy)
        deleteObjs.append(rootProxy)

        # ??????????????????????????????????????????????????????
        rootProxyWorldMatPrevsList.append([])

        # ??????????????????????????????proxy??????
        # proxyTarget????????????????????????????????????
        # proxyMove????????????????????????????????????
        boneProxyMap = []
        listBone = childs
        for bone in listBone:
            cmds.cutKey(bone, time=(start, end))

            worldMatMel = cmds.xform(bone, q=1, m=1 ,ws=1)
            proxyTarget = createProxy()
            proxyMove = createProxy((0,1,0), 1)
            deleteObjs.append(proxyTarget)
            deleteObjs.append(proxyMove)
            cmds.xform(proxyTarget, m=worldMatMel, ws=1)
            cmds.xform(proxyMove, m=worldMatMel, ws=1)

            worldMatOm = Helper.getOpenMayaMatrix(worldMatMel)
            diffMatOm = worldMatOm * rootProxyWorldMatOm.inverse()
            
            boneProxyMap.append({
                "bone":bone, 
                "proxyTarget": proxyTarget, 
                "proxyMove":proxyMove,
                "diffMatOm":diffMatOm,
                "speed":[om.MVector(),om.MVector()]
            })

        boneCount = len(boneProxyMap)
        boneProxyMapList.append( boneProxyMap )
        childsList.append(childs)
    cmds.select(roots)

    def updateOneBone(currBone, currProxyMove, nextProxyMove):
        nextProxyMovePos = cmds.xform(nextProxyMove, ws=1, t=1, q=1)
        nextProxyMovePos = om.MVector(nextProxyMovePos[0], nextProxyMovePos[1], nextProxyMovePos[2])

        currBonePos = cmds.xform(currBone, ws=1, t=1, q=1)
        currBonePos = om.MVector(currBonePos[0], currBonePos[1], currBonePos[2])

        currBoneMat = cmds.xform(currBone, ws=1, m=1, q=1)

        # ??????????????????
        currProxyMat = cmds.xform(currProxyMove, ws=1, m=1, q=1)

        xDir = (nextProxyMovePos - currBonePos).normal()
        yDir = om.MVector(currProxyMat[4], currProxyMat[5], currProxyMat[6]).normal()
        zDir = (xDir ^ yDir).normal()

        currBoneMat[0] = xDir.x
        currBoneMat[1] = xDir.y
        currBoneMat[2] = xDir.z
        currBoneMat[4] = yDir.x
        currBoneMat[5] = yDir.y
        currBoneMat[6] = yDir.z
        currBoneMat[8] = zDir.x
        currBoneMat[9] = zDir.y
        currBoneMat[10] = zDir.z

        cmds.xform(currBone, ws=1, m=currBoneMat)

        # ????????????????????????????????????????????????????????????1
        cmds.setAttr(currBone+".sx", 1)
        cmds.setAttr(currBone+".sy", 1)
        cmds.setAttr(currBone+".sz", 1)
        
        if not liveEdit: cmds.setKeyframe( currBone+".rotate" )

    def onTimeUpdate(*args):
        for root, rootProxy, rootProxyWorldMatPrevs, boneProxyMap in zip(roots, rootProxyList, rootProxyWorldMatPrevsList, boneProxyMapList):

            rootProxyWorldMatMel = cmds.xform(root, m=1,ws=1,q=1)
            cmds.xform(rootProxy, m=rootProxyWorldMatMel, ws=1)

            rootProxyWorldMatOm = Helper.getOpenMayaMatrix(rootProxyWorldMatMel)

            if len(rootProxyWorldMatPrevs) > cacheCount:
                rootProxyWorldMatPrevs.remove(rootProxyWorldMatPrevs[0])
            rootProxyWorldMatPrevs.append(rootProxyWorldMatOm)

            # ??????????????????????????????proxy???
            for i, map in enumerate(boneProxyMap):
                bone = map["bone"]
                proxyTarget = map["proxyTarget"]
                proxyMove = map["proxyMove"]
                diffMatOm = map["diffMatOm"]
                
                # ????????????
                prevCount = len(rootProxyWorldMatPrevs) - i * spread - 1
                if prevCount > 0:
                    rootProxyWorldMatOm = rootProxyWorldMatPrevs[prevCount]
                else:
                    rootProxyWorldMatOm = rootProxyWorldMatPrevs[0]

                boneWorldMatOm = diffMatOm * rootProxyWorldMatOm
                boneWorldMatMel = Helper.getMelMatrix(boneWorldMatOm)
                cmds.xform(proxyTarget, m=boneWorldMatMel, ws=1)

                # ??????
                acc = map["speed"][0]
                vel = map["speed"][1]

                # ????????????
                targetPos = om.MVector(boneWorldMatMel[12], boneWorldMatMel[13], boneWorldMatMel[14])

                followPos = cmds.xform(proxyMove, q=1, t=1, ws=1)
                followPos = om.MVector(followPos[0], followPos[1], followPos[2])

                acc = (targetPos - followPos) * spring
                vel += acc
                vel *= friction

                followPos += vel

                # ????????????
                targetMat = boneWorldMatOm
                followMat = Helper.getOpenMayaMatrix(cmds.xform(proxyMove, q=1, m=1, ws=1))

                targetQuat = om.MTransformationMatrix(targetMat).rotation(asQuaternion=True)
                followQuat = om.MTransformationMatrix(followMat).rotation(asQuaternion=True)
                followQuat = om.MQuaternion.slerp(targetQuat, followQuat, 1-twist)

                # ?????????????????????
                newmat = om.MTransformationMatrix()
                newmat.translateBy(followPos, 4)
                newmat = newmat.asMatrix()
                rotmat = followQuat.asMatrix()
                newmat = rotmat * newmat
                cmds.xform(proxyMove, ws=1, m=Helper.getMelMatrix(newmat))

                map["speed"][0] = acc
                map["speed"][1] = vel

            # ??????????????????proxy?????????
            # root bone?????????
            for i in range(len(boneProxyMap)):
                if i == len(boneProxyMap) - 1: continue
                currMap = boneProxyMap[i]
                nextMap = boneProxyMap[i+1]
                currBone = currMap["bone"]
                currProxyMove = currMap["proxyMove"]
                nextProxyMove = nextMap["proxyMove"]
                updateOneBone(currBone, currProxyMove, nextProxyMove )

                # ?????????????????????????????????????????????????????????????????????????????????????????????????????????
                # currMap = boneProxyMap[i]
                # currBone = currMap["bone"]
                # proxyMove =  currMap["proxyMove"]    
                # currRot = cmds.xform(proxyMove, ws=1, ro=1, q=1) 
                # cmds.xform(currBone, ws=1, ro=currRot)
                # if not liveEdit: cmds.setKeyframe( currBone+".rotate" )

    return [onTimeUpdate, childsList, deleteObjs]

def execute(springMethod, start = 0, end = 0, spring = .2, twist = .2, friction = .7, spread = 3, loopCount = 0, cacheCount = 100, liveEdit = True):
    [onTimeUpdate, childsList, deleteObjs] = springMethod(start, end, spring, twist, friction, spread, loopCount, cacheCount, liveEdit)

    if liveEdit:
        # ??????????????????
        removeListener()

        # ??????frame????????????
        eid = om.MDGMessage.addTimeChangeCallback(onTimeUpdate)
        setattr(maya, "eid", eid)
    else:
        # ????????????
        cmds.currentTime(start+1)
        currentTime = cmds.currentTime(q=1)
        while(currentTime < end+1):
            cmds.currentTime(currentTime)
            onTimeUpdate(None)

            # roop??????
            if currentTime == end and loopCount > 0: 
                for childs in childsList:
                    cmds.cutKey(childs, time=(start, end+1))
                loopCount -= 1
                currentTime = start-1
                
            currentTime += 1
    
    def deleteProxys():
        cmds.delete(deleteObjs)
    return deleteProxys

def getBones():
    root = cmds.ls(sl=1)
    childs = cmds.listRelatives(allDescendents=True, type='joint')
    childs.reverse()
    childs = root + childs
    return childs

def springStraightBonePose(bone):
    bone.setRotation([0,0,0])
    bone.setAttr('rotateAxis', [0,0,0])
    bone.setAttr('jointOrient', [0,0,0])

def springBindController(subname = "_SpringProxy"):
    ctrlList = pm.ls(sl=1)
    pm.select( d=True )
    proxyJointLst = []
    for ctrl in ctrlList:
        ctrlPos = pm.xform(ctrl,worldSpace =1,rp=1,q=1)
        proxyJoint = pm.joint( 
                            name=ctrl.name()+subname,
                            position=ctrlPos
                            )
        pm.setAttr(proxyJoint.name()+'.radius',50)
        proxyJointLst.append(proxyJoint)
    for joint in proxyJointLst:
        pm.joint(joint,edit=1,orientJoint ='xyz',zeroScaleOrient =True)
        springStraightBonePose(joint)

    if proxyJointLst:
        pm.parent(proxyJointLst[0],ctrlList[0].getParent())

    for joint in proxyJointLst:
        idx=proxyJointLst.index(joint)
        if idx+1<len(ctrlList):
            cns = pm.aimConstraint( ctrlList[idx+1], proxyJointLst[idx], aimVector = [1,0,0], upVector = [0,0,0], worldUpVector = [0,1,0], skip ='x' )
            pm.delete(cns)
        pm.parentConstraint( proxyJointLst[idx], ctrlList[idx], maintainOffset=True )
    return proxyJointLst

def springClearBind(proxyList, start, end, subname = "_SpringProxy"):
    proxyJointLst = proxyList
    pm.select( d=True )
    ctrlList = []

    for bone in proxyJointLst:
        ctrl = pm.ls(bone.name().split(subname)[0])[0]
        ctrlList.append(ctrl)
    for ctrl in ctrlList:
        pm.bakeResults( ctrl, t=(start,end))
    try:
        pm.delete(proxyJointLst)
    except:
        print("invalid")

def getSimulationRange(start, end):
    if start > end:
        end = start + 1
    if start == end:
        start = cmds.playbackOptions(q=True, min=True)
        end = cmds.playbackOptions(q=True, max=True)
    return [True, start, end]

import GuiBase
from PySide2.QtGui import *
from PySide2.QtWidgets import *

class JFSpringBone(GuiBase.BasicUI):
    def _showWindow(self, uiName):
        GuiBase.BasicUI._showWindow(self, uiName)

        vbox = QVBoxLayout(self.getMainWidget())

        subvbox = QHBoxLayout()
        vbox.addLayout(subvbox)

        self.springMethod = None
        def updateUI(*args):
            currentType = combo.currentText()
            if currentType == "Vic":
                spnFriction.setEnabled(True)
                spnSpread.setEnabled(True)
                # spnCache.setEnabled(True)
                self.springMethod = vicMethod
            elif currentType == "Yanbin":
                spnFriction.setEnabled(False)
                spnSpread.setEnabled(False)
                # spnCache.setEnabled(False)
                self.springMethod = yanbinMethod
            else:
                pass

        combo = QComboBox()
        combo.addItem("Yanbin")
        combo.addItem("Vic")
        combo.currentIndexChanged.connect(updateUI)
        subvbox.addWidget(combo)

        def _onTipClick(_tooltip):
            return lambda: GuiBase.showMessage(_tooltip if _tooltip != "" else u"?????????")

        btnDesc = QPushButton("?")
        btnDesc.setMaximumSize(10,btnDesc.height())
        btnDesc.clicked.connect(_onTipClick("Yanbin ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????\nVic ????????????????????????????????????????????????????????????????????????????????????????????????????????????"))
        subvbox.addWidget(btnDesc)

        hbox = QHBoxLayout()
        vbox.addLayout(hbox)

        vbox_sub = QVBoxLayout()
        hbox.addLayout(vbox_sub)
        [spnStart, spnEnd, spnSpring, spnTwist] = GuiBase.addSpinboxToLayout(vbox_sub,[
            ["??????","i", "??????????????????????????????????????????0??????????????????????????????????????????"],
            ["??????","i", "??????????????????????????????????????????0??????????????????????????????????????????"],
            ["??????","f", "????????????????????????0~1???????????????????????????????????????"],
            ["??????","f", "????????????????????????0~1???????????????????????????????????????"],
        ])

        vbox_sub = QVBoxLayout()
        hbox.addLayout(vbox_sub)
        [spnFriction, spnLoopCount, spnSpread, spnCache] = GuiBase.addSpinboxToLayout(vbox_sub,[
            ["?????????","f", "???????????????????????????0~1??????????????????????????????"],
            ["????????????","i", "????????????0??????????????????loop??????\n?????????????????????\n????????????????????????????????????\n"],
            ["?????????","i", "?????????????????????????????????????????????"],
            ["????????????","i", "???????????????????????????????????????????????????"],
        ])

        spnStart.setMaximum(10000)
        spnStart.setMinimum(-10000)
        spnStart.setValue(1)

        spnEnd.setMaximum(10000)
        spnEnd.setMinimum(-10000)
        spnEnd.setValue(1)

        # ??????
        spnSpring.setSingleStep(.1)
        spnSpring.setValue(.2)
        spnSpring.setMaximum(1.0)
        spnSpring.setMinimum(0)

        spnTwist.setSingleStep(.1)
        spnTwist.setValue(.2)
        spnTwist.setMaximum(1.0)
        spnTwist.setMinimum(0)

        # ?????????
        spnFriction.setSingleStep(.1)
        spnFriction.setValue(.7)
        spnFriction.setMaximum(1.0)
        spnFriction.setMinimum(0)

        # ????????????
        spnLoopCount.setMaximum(10)
        spnLoopCount.setMinimum(0)

        def onSpreadChange( v ):
            spnCache.setValue(v*30)

        # ?????????
        spnSpread.setValue(3)
        spnSpread.setMaximum(20)
        spnSpread.setMinimum(1)
        spnSpread.valueChanged.connect(onSpreadChange)

        # ????????????
        spnCache.setMaximum(1000)
        spnCache.setEnabled(False)
        onSpreadChange(spnSpread.value())

        hbox = QHBoxLayout()
        vbox.addLayout(hbox)
        self.proxyList = []
        def bindBone():
            self.proxyList += springBindController()
        def bakeBone():
            [validRange, start, end] = getSimulationRange(spnStart.value(), spnEnd.value())
            if validRange:
                springClearBind(self.proxyList, start, end)
                self.proxyList = []
        btns = GuiBase.addButtonToLayout(hbox, [
            [u"???????????????", bindBone, "??????????????????????????????????????????????????????????????????????????????????????????"],
            [u"??????????????????", bakeBone, "???????????????????????????????????????????????????"]
        ])

        hbox = QHBoxLayout()
        vbox.addLayout(hbox)
        def clearKey():
            childs = getBones()
            childs.remove(childs[0])
            cmds.cutKey(childs)
            for bone in childs:
                cmds.setAttr(bone+".rx", 0)
                cmds.setAttr(bone+".ry", 0)
                cmds.setAttr(bone+".rz", 0)
                cmds.setAttr(bone+".sx", 1)
                cmds.setAttr(bone+".sy", 1)
                cmds.setAttr(bone+".sz", 1)

        btns = GuiBase.addButtonToLayout(hbox, [
            [u"??????key", clearKey, "?????????????????????????????????????????????????????????????????????key"]
        ])

        xforms = None
        childs = None
        startSimFrame = 0
        startSimMaxFrame = None
        startSimAet = None
        deleteProxys = None
        def startSimulation():
            if btns[0].isChecked():

                # ?????????????????????????????????
                if len(cmds.ls(sl=1)) < 1: return

                # ??????????????????
                global xforms, childs, startSimFrame, startSimMaxFrame, startSimAet, deleteProxys
                childs = getBones()
                cmds.cutKey(childs)
                xforms = [ cmds.xform(o,m=1, q=1) for o in childs ]
                startSimFrame = cmds.currentTime(q=1)
                startSimMaxFrame = cmds.playbackOptions(q=1, max=1)
                startSimAet = cmds.playbackOptions(q=1, aet=1)

                # ??????timeline
                cmds.playbackOptions(aet=10000, max=10000)

                # ??????
                deleteProxys = execute(self.springMethod, 0, 0, spnSpring.value(), spnTwist.value(), spnFriction.value(), spnSpread.value(), spnLoopCount.value(), spnCache.value())
                # ??????????????????????????????????????????
                cmds.play( record=True )
            else:
                
                # ??????????????????
                start = cmds.playbackOptions(q=True, min=True)
                end = cmds.playbackOptions(q=True, max=True)

                cmds.currentTime(startSimFrame)
                cmds.playbackOptions(aet=startSimAet, max=startSimMaxFrame)
                for bone, mat in zip(childs, xforms): 
                    cmds.cutKey(childs, time=(start, end))
                    cmds.xform(bone, m=mat)
                removeListener()
                if deleteProxys: deleteProxys()
                cmds.play( state=False )

        def bakeSimulation():

            # ?????????????????????????????????
            if len(cmds.ls(sl=1)) < 1: return
            [validRange, start, end] = getSimulationRange(spnStart.value(), spnEnd.value())
            if validRange:
                deleteProxys = execute(self.springMethod, start, end, spnSpring.value(), spnTwist.value(), spnFriction.value(), spnSpread.value(), spnLoopCount.value(), spnCache.value(), False)
                removeListener()
                deleteProxys()
        
        hbox = QHBoxLayout()
        vbox.addLayout(hbox)

        btns = GuiBase.addButtonToLayout(hbox, [
            [u"????????????", startSimulation, "?????????????????????????????????????????????????????????????????????????????????????????????"],
            [u"??????", bakeSimulation, "??????????????????????????????????????????????????????????????????????????????????????????"]
        ])
        btns[0].setCheckable(True)

        updateUI(None)