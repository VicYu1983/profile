# -*- coding: utf-8 -*-
# Last Modified 2015/08/10
# Author Chih Lun Kang
import os
from os import listdir
from os.path import isfile, join
import maya.cmds as cmds
import maya.mel as mel
import subprocess
import AS_MotionConstrain as AM
try:import clr 
except:pass

if(clr):
	clr.AddReference("System")
	clr.AddReference("System.Windows.Forms")
	import System
	import System.Windows.Forms

# 依據node 找skin node 找mesh
def getRefSkinMesh(nd): # nd = "man_rig_v06:Root_M"
	ch_1lst = cmds.listConnections(nd,d=True)
	sknLst=[]
	meshLst=[]
	for chi in ch_1lst:
		if(cmds.nodeType(chi) == "skinCluster"):
			if( not (chi in sknLst)):
				sknLst.append(chi)
	for sk in sknLst: #sk=sknLst[0]
		rlst = cmds.listConnections(sk,d=True)
		for rh in rlst :#sh = shlst[0]
			shps = cmds.listRelatives(rh,s=True)
			if(shps!=None):
				if(not (rh in meshLst)):
					meshLst.append(rh)
	return meshLst

def getRefSkinSkeleton(nd): # nd = "man_rig_v06:Root_M"
	ch_1lst = cmds.listConnections(nd,d=True)
	sknLst=[]
	jntLst=[]
	for chi in ch_1lst:
		if(cmds.nodeType(chi) == "skinCluster"):
			if( not (chi in sknLst)):
				sknLst.append(chi)
	for sk in sknLst: #sk=sknLst[0]
		rlst = cmds.listConnections(sk,d=True)
		for rh in rlst :#rh = rlst[0]
			if(cmds.nodeType(rh)=="joint"):
				if( not (rh in jntLst)):
					jntLst.append(rh)
	return jntLst

# 模擬單一場景布料
def EnableClothSim():
	#select ncloth shape
	nClothCtrlNd = None
	
	allCtrlObj = []
	AM.getShapes(AM.getAllObjects(),allCtrlObj ,_type="nurbsCurve",bGetHidden=True)
	for shp in allCtrlObj: # shp = allCtrlObj[12]
		pNd = None
		try:pNd = cmds.listRelatives(shp,parent=True)[0]
		except:pass
		if(not pNd):continue
		if(":ncloth_ctrl" in pNd):
			nClothCtrlNd = shp

	if(not nClothCtrlNd):return

	## Get All Boolean value from nClothCtrlNd
	allAttr = cmds.listAttr(nClothCtrlNd,ud=True)
	for at in allAttr: # at = allAttr[4]
		if("Enable_" in at):
			cmds.setAttr(nClothCtrlNd + "." + at,True)
		if("Start_Frame" in at):
			cmds.setAttr(nClothCtrlNd + "." + at,0)

# 批次輸出動作 #toolroot = "E:/00Trunk/PY/JoyFunToolSetMaya/00tools/AdvancedSkeleton/scripts/" 
def batchExportAnim(toolroot,bCineExport=False, bDoClothSim = False): #bCineExport=False; bDoClothSim = False
	# import 輸出模組
	_string = 'source "'+toolroot+'FBXImportModule.mel"'
	mel.eval( _string )

	dfmotionExLoc = None
	try:dfmotionExLoc = cmds.optionVar( q='asMotionExLoc')
	except:pass
	if(dfmotionExLoc==0):
		dfmotionExLoc = "D:\\JF_RPG\\Art_WorkSpace\\Animation\\"
		cmds.optionVar(sv=('asMotionExLoc', dfmotionExLoc) )
	
	folderBrowserDialog1 = System.Windows.Forms.FolderBrowserDialog()
	folderBrowserDialog1.ShowNewFolderButton = True
	folderBrowserDialog1.Description = "Set Animation Export Path"
	folderBrowserDialog1.SelectedPath = dfmotionExLoc
	result = folderBrowserDialog1.ShowDialog()

	if(result == System.Windows.Forms.DialogResult.OK):
		cmds.optionVar(sv=('asMotionExLoc', folderBrowserDialog1.SelectedPath ) )
		curFilePth = cmds.file(q=True,sn=True)
		if(len(curFilePth)==0):
			System.Windows.Forms.MessageBox.Show("請至少開啟一個動作檔再開始輸出")
			return
		_dir = os.path.dirname(curFilePth)
		allmabF = [ (join(_dir,f)) for f in listdir(_dir ) if ( (isfile(join(_dir,f))) and ((f[-3:]==".ma")or(f[-3:]==".mb")) ) ]
		for mafile in allmabF: # mafile = allmabF[0]
			fl = mafile.replace('/','\\')
			cmds.file(fl,open=True,force=True)
		
			allRefs = cmds.ls(rn=True)
			rootNds = []
			root_M_Nds = []
			for rfd in allRefs:
				if( (":root" in rfd) and 
					(len( rfd.split(':')[-1])==4 )and 
					(not "WP_" in rfd[:3])
				  ):
					_parent = cmds.listRelatives(rfd,p=True)
					if( _parent == None):	
						rootNds.append(rfd)
				if((":Root_M" in rfd) and (len( rfd.split(':')[-1])==6 )):
					root_M_Nds.append(rfd)
			if((len(rootNds)==0)or(len(root_M_Nds)==0)):
				System.Windows.Forms.MessageBox.Show("no ref node in scene !")
				return
			
			if(bCineExport):
				for rfd in rootNds: # rfd = rootNds[0]
					cmds.select(cl=True)
					cmds.select(rfd)
					charname = rfd.split(':')[0]
					motionname = (mafile.split('\\')[-1]).split('.')[0]
					exportPth = folderBrowserDialog1.SelectedPath+"\\"+charname+"_"+motionname+".fbx"
			else:
				if(bDoClothSim):EnableClothSim()
				
				cmds.select(cl=True)
				refModel = getRefSkinMesh(root_M_Nds[0])
				refSk = getRefSkinSkeleton(root_M_Nds[0])
				
				minStr = str(int(cmds.playbackOptions(q=True,minTime=True)))
				maxStr = str(int(cmds.playbackOptions(q=True,maxTime=True)))
				cmds.select(rootNds[0]) #,hi=True
				selectf = cmds.ls(sl=True)
				
				cmds.bakeResults( selectf ,
				  t=(minStr,maxStr),
				  sampleBy=1,simulation=True,
				  disableImplicitControl=True,
				  preserveOutsideKeys=True,
				  sparseAnimCurveBake=False,
				  removeBakedAttributeFromLayer=False,
				  bakeOnOverrideLayer=False,
				  minimizeRotation=True,
				  controlPoints=False,
				  shape=True,
				  hi="below")

				cmds.select(cl=True)
				
				motionname = (mafile.split('\\')[-1]).split('.')[0]
				exportPth = folderBrowserDialog1.SelectedPath+"\\"
				exportPth_dir = exportPth.replace('\\','/')
				exportPth_name = motionname+".fbx"
				#sv = 'string $res = doExportFbxAnim("'+exportPth_dir+'","'+ exportPth_name +'");'
				#resStr = mel.eval(sv)
				cmds.select(rootNds[0])
				joints=cmds.ls(sl=True)

				#find all joints
				joints.extend(cmds.listRelatives(type='joint',allDescendents=True,fullPath=True))

				
				#find your Skinned Geo
				# refSkin = cmds.ls(type="skinCluster")
				# meshes=[]
				# for skin in refSkin: # skin = refSkin[0]
				# 	shape=cmds.skinCluster(skin,query=True,geometry=True)
				# 	if(shape):
				# 		meshTransform=cmds.listRelatives(shape,parent=True,f=True)[0]
				# 		if meshTransform not in meshes:
				# 			meshes.append(meshTransform)
				# Borrowed code ends here.
				
				
				#print exportNames[x]
				# Select the mesh and joints to export
				# cmds.select(joints) # meshes
				#cmds.select("CB_200_0011_rig:CB_1011a:cloth_geo")
				# cmds.select(meshes)
				# cmds.select(joints,add=True) #
				cmds.select(rootNds[0])
				
				# Geometry
				mel.eval("FBXExportSmoothingGroups -v true")
				mel.eval("FBXExportHardEdges -v false")
				mel.eval("FBXExportTangents -v false")
				mel.eval("FBXExportSmoothMesh -v true")
				mel.eval("FBXExportInstances -v false")
				#mel.eval("FBXExportReferencedContainersContent -v false")
				
				# Animation
				mel.eval("FBXExportBakeComplexAnimation -v true")
				mel.eval("FBXExportAnimationOnly -v false")
				mel.eval("FBXExportBakeComplexStart -v "+ minStr)
				mel.eval("FBXExportBakeComplexEnd -v "+ maxStr)
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
				#print ("############ ")
				#print ("FBXExport -f \""+exportPth_dir + exportPth_name +"\" -s")
				mel.eval("FBXExport -f \""+exportPth_dir + exportPth_name +"\" -s")
		
		
		ddir = dfmotionExLoc.replace('\\','\\\\') + "\\\\"
		dstr = 'system ("explorer /select,\\"'+ ddir +'")'
		mel.eval(dstr)
		print ("*******   "+ dstr  ) 



def doExportNpcPart(toolroot): # toolroot = "D:/00Trunk/PY/JoyFunToolSetMaya/00tools/AdvancedSkeleton/scripts/" 
	# import 輸出模組
	_string = 'source "'+toolroot+'FBXImportModule.mel"'
	mel.eval( _string )
	thisFilePth = os.path.dirname(os.path.abspath(cmds.file(q=True,sn=True)))
	#thisFilePth = os.path.dirname(thisFilePth)
	thisFilePth = thisFilePth.replace('\\','/')+'/'
	
	if(len(thisFilePth)):
		allskn = cmds.ls(type="skinCluster")
		meshLst = []
		for sk in allskn: #sk=allskn[0]
				rlst = cmds.listConnections(sk,d=True)
				for rh in rlst :#sh = shlst[0]
					shps = cmds.listRelatives(rh,s=True)
					if(shps!=None):
						if(not (rh in meshLst)):
							meshLst.append(rh)
		for msh in meshLst: # msh = meshLst[0]
			if(cmds.getAttr(msh+".visibility")):
				cmds.select(cl=True)
				cmds.select(msh,r=True)
				cmds.select("root",add=True)
				exportPth_name = msh +"_rig.fbx"
				sv = 'string $res = doExportFbxModel("'+thisFilePth+'","'+ exportPth_name +'");'
				resStr = mel.eval(sv)
		
		thisFilePth_open = (os.path.abspath(cmds.file(q=True,sn=True)))  #os.path.dirname +"\\"
		thisFilePth_open = thisFilePth_open.replace('\\','\\\\')
		mel.eval('system ("explorer /select,\\"'+ thisFilePth_open  +'")')