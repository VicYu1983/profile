# coding=UTF-8
import maya.cmds as cmds
import maya.mel as mel
import Helper

if int(cmds.about(version=True)) >= 2017:
	from PySide2.QtGui import *
	from PySide2.QtWidgets import *
else:
	from PySide.QtGui import *

def exportFBX(path):
	
	start = cmds.playbackOptions(q=True, ast=True)
	end = cmds.playbackOptions(q=True, aet=True)
	
	# Geometry
	mel.eval("FBXExportSmoothingGroups -v true")
	mel.eval("FBXExportHardEdges -v false")
	mel.eval("FBXExportTangents -v false")
	mel.eval("FBXExportSmoothMesh -v true")
	mel.eval("FBXExportInstances -v false")

	# Animation
	mel.eval("FBXExportBakeComplexAnimation -v true")
	mel.eval("FBXExportAnimationOnly -v false")
	mel.eval("FBXExportBakeComplexStart -v "+ str(start))
	mel.eval("FBXExportBakeComplexEnd -v "+ str(end))
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
	
	mel.eval("FBXExportFileVersion -v \"FBX201600\"")
	# Axis Conversion
	mel.eval("FBXExportUpAxis z")
	mel.eval('FBXExport -f "'+ path +'" -s')

def openPathDialog(do):
	dlg = QFileDialog()
	dlg.setAcceptMode(QFileDialog.AcceptSave)
	dlg.setNameFilter("Fbx files (*.fbx)")
	if dlg.exec_():
		do(dlg.selectedFiles()[0])

def execute():
	if len(cmds.ls(sl=1)) != 0:
		root = cmds.ls(sl=1)[0]
		listToSelect = Helper.getSkelMesh(root)
		cmds.select(listToSelect + [root])
		def export(dir):
			exportFBX( dir )
			cmds.confirmDialog(title=u'完成', message=u'輸出已完成', button=u'確認')
		openPathDialog( export )