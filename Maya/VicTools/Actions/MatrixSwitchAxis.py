# -*- coding: utf-8 -*-
# �w��Adv.Sk Controls �x�}����
# Last Modified 2015/08/27
# Author Chih Lun Kang

import maya.cmds as cmds
import maya.mel as mel
import sys,os
import maya.OpenMaya as om
import maya.OpenMayaAnim as omAnim
import maya.OpenMayaMPx as OpenMayaMPx

def getLocalTm(objA,objB): # objA="IKArm_L" objB = "FKWrist_L"
	# objA Matrix
	objA_tm = cmds.xform(objA, query=True, ws=True, matrix=True)
	objA_tm_om = om.MMatrix()
	om.MScriptUtil.createMatrixFromList(objA_tm, objA_tm_om)
	
	# objB Matrix
	objB_tm = cmds.xform(objB, query=True, ws=True, matrix=True)
	objB_tm_om = om.MMatrix()
	om.MScriptUtil.createMatrixFromList(objB_tm, objB_tm_om)
	
	lb = objB_tm_om * objA_tm_om.inverse()
	return [lb(0,0),lb(0,1),lb(0,2),lb(0,3),
			lb(1,0),lb(1,1),lb(1,2),lb(1,3),
			lb(2,0),lb(2,1),lb(2,2),lb(2,3),
			lb(3,0),lb(3,1),lb(3,2),lb(3,3)]


#############################################################################
###############			Fk �|�Ϭ۹��IK local tm ����		#################
#############################################################################

#lArmLclTm = getLocalTm("IKArm_L","FKWrist_L")
lArmLclTm = [-0.9999999999999996,
-8.452961889909992e-18,
 4.5102810375396984e-17,
 0.0,
 -4.336808689942018e-17,
 3.482284313997165e-14,
 -0.9999999999999998,
 0.0,
 -5.551115123125783e-17,
 -0.9999999999999999,
 -3.476776158639616e-14,
 0.0,
 0.0,
 2.842170943040401e-14,
 -1.2434497875801753e-14,
 1.0] 

#rArmLclTm = getLocalTm("IKArm_R","FKWrist_R")
rArmLclTm = [-1.0000000000000002,
 9.433534501590366e-18,
 2.6020852139652106e-16,
 0.0,
 2.3245294578089215e-16,
 -3.153455976513863e-14,
 1.0,
 0.0,
 5.3594146575822294e-17,
 1.0,
 3.165263714908375e-14,
 0.0,
 2.842170943040401e-14,
 0.0,
 1.2434497875801753e-14,
 1.0]

#lLegLclTm = getLocalTm("IKLeg_L","FKAnkle_L")
lLegLclTm= [-2.538201453901476e-16,
 0.9999999999999999,
 7.077671781985374e-16,
 0.0,
 -2.0523383303719464e-17,
 6.522560269672793e-16,
 -0.9999999999999999,
 0.0,
 -1.0,
 -3.093312966214053e-16,
 -3.498776792753871e-17,
 0.0,
 0.0,
 1.4210854715202004e-14,
 -3.375077994860476e-14,
 1.0]

#rLegLclTm = getLocalTm("IKLeg_R","FKAnkle_R")
rLegLclTm= [-9.054426901837266e-16,
 -0.9999999999999999,
 1.3877787807814407e-16,
 0.0,
 -4.084467855162918e-15,
 1.3877787807814481e-16,
 0.9999999999999999,
 0.0,
 -0.9999999999999999,
 8.096798099312216e-16,
 -4.0697803700319784e-15,
 0.0,
 -1.7763568394002505e-15,
 5.329070518200751e-15,
 8.881784197001252e-16,
 1.0]


#############################################################################
###############			Ik �|�Ϭ۹��FK local tm ����		#################
#############################################################################

#lArmLclTm_IK = getLocalTm("FKWrist_L","IKArm_L")
lArmLclTm_IK = [-1.0000000000000004,
 -4.163336342344338e-17,
 -1.449792083884002e-30,
 1.3684555315672042e-48,
 1.6653345369377348e-16,
 3.4763858458575214e-14,
 -0.9999999999999999,
 8.673617379884035e-19,
 4.336808689942649e-17,
 -1.0000000000000004,
 -3.482284313997166e-14,
 4.930380657631324e-32,
 1.4210854715202004e-14,
 -1.2434497875801753e-14,
 5.684341886080802e-14,
 1.0]

#rArmLclTm_IK = getLocalTm("FKWrist_R","IKArm_R")
rArmLclTm_IK = [-0.9999999999999998,
 2.636779683484747e-16,
 8.314968651635308e-30,
 1.0947644252537633e-47,
 5.551115123125783e-17,
 -3.164829509572087e-14,
 1.0,
 8.673617379884035e-19,
 2.324529457808953e-16,
 1.0,
 3.153455976513864e-14,
 2.465190328815662e-32,
 2.842170943040401e-14,
 -1.3322676295501878e-14,
 -2.842170943040401e-14,
 1.0]

#lLegLclTm_IK = getLocalTm("FKAnkle_L","IKLeg_L")
lLegLclTm_IK = [-3.025480629675245e-16,
 -2.937497026188145e-17,
 -1.0,
 0.0,
 1.0,
 6.661338147750939e-16,
 -2.220446049250313e-16,
 0.0,
 6.522560269672793e-16,
 -1.0000000000000002,
 2.0523383303719464e-17,
 0.0,
 -1.4210854715202004e-14,
 -3.375077994860476e-14,
 0.0,
 1.0]


#rLegLclTm_IK = getLocalTm("FKAnkle_R","IKLeg_R")
rLegLclTm_IK = [-7.563701574188146e-16,
 -4.014729163074004e-15,
 -1.0,
 1.232595164407831e-32,
 -1.0,
 2.220446049250313e-16,
 8.881784197001252e-16,
 1.3877787807814457e-17,
 1.387778780781422e-16,
 1.0,
 -4.084467855162919e-15,
 -1.5407439555097887e-33,
 7.105427357601002e-15,
 -1.7763568394002505e-15,
 -1.7763568394002505e-15,
 1.0]



# spine1LclTm_IK = getLocalTm("FKChest_M","IKSpine2_M")
spine1LclTm_IK = [-3.824524887973023e-16,
 -4.6702627357036085e-15,
 1.0,
 -3.851859888774472e-34,
 0.9824224812538319,
 0.1866710163015782,
 1.1920214630438732e-15,
 8.673617379884035e-19,
 -0.18667101630157829,
 0.9824224812538319,
 4.461267158915131e-15,
 -2.168404344971009e-19,
 0.0,
 0.0,
 7.451383285384825e-14,
 1.0]



# spine0LclTm_IK = getLocalTm("FKRoot_M","IKSpine1_M")
spine0LclTm_IK = [7.216449660063518e-16,
 -7.771561172376096e-16,
 1.0,
 0.0,
 1.0,
 -5.551115123125722e-17,
 -7.771561172376097e-16,
 0.0,
 5.207714569623086e-31,
 1.0,
 7.216449660063518e-16,
 0.0,
 0.0,
 0.0,
 0.0,
 1.0] 

# using method 'getLocalTm' to get the [local transform] of B from A
# set B transform by multi [[local transform] of B from A] and [A transform]
def setObjBTm(objA,objB,B_localTm):
	# objA Matrix
	objA_tm = cmds.xform(objA, query=True, ws=True, matrix=True)
	objA_tm_om = om.MMatrix()
	om.MScriptUtil.createMatrixFromList(objA_tm, objA_tm_om)
	
	# objB Matrix Local
	objB_tm_local_om = om.MMatrix()
	om.MScriptUtil.createMatrixFromList(B_localTm, objB_tm_local_om)
	
	# here is assuming objB_tm_local_om is the rotation matrix
	lb = objB_tm_local_om * objA_tm_om
	res = [lb(0,0),lb(0,1),lb(0,2),lb(0,3),
			lb(1,0),lb(1,1),lb(1,2),lb(1,3),
			lb(2,0),lb(2,1),lb(2,2),lb(2,3),
			lb(3,0),lb(3,1),lb(3,2),lb(3,3)]
	
	cmds.xform(objB, ws=True, matrix=res)
	






'''
# ��ӯx�}��K���b�V����
def transferMatrix(mat,pdx,pdy,pdz,x1,x2,x3,y1,y2,y3,z1,z2,z3):
	xx = mat[0]
	xy = mat[1]
	xz = mat[2]

	yx = mat[4]
	yy = mat[5]
	yz = mat[6]

	zx = mat[8]
	zy = mat[9]
	zz = mat[10]
	
	#  �b�V���� �O -x -z -y
	nxx = pdx*mat[x1]
	nxy = pdx*mat[x2]
	nxz = pdx*mat[x3]

	nyx = pdx*mat[y1]
	nyy = pdy*mat[y2]
	nyz = pdz*mat[y3]

	nzx = pdx*mat[z1]
	nzy = pdx*mat[z2]
	nzz = pdx*mat[z3]
	
	matx = mat
	
	matx[0] = nxx
	matx[1] = nxy
	matx[2] = nxz

	matx[4] = nyx
	matx[5] = nyy
	matx[6] = nyz

	matx[8] = nzx
	matx[9] = nzy
	matx[10] = nzz
	
	return matx
'''