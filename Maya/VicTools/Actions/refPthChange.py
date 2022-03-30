# -*- coding: utf-8 -*-
# 批次置換 Animation 檔內的Reference rig file
# 目前只考慮單一檔案
# Last Modified 2015/08/25
# Author Chih Lun Kang

import maya.cmds as cmds
import maya.mel as mel
import __builtin__
import shutil,os
try:import clr 
except:pass

if(clr):
	clr.AddReference("System")
	clr.AddReference("System.Windows.Forms")
	import System
	import System.Windows.Forms
	from DotNet import WinForms
	reload(WinForms)

class refNameChangerUI():
	def __init__(self):
		self._size=[200,200]
		self.createUI()
		try:__builtin__.g_RefNameChUI.TopMost=True
		except:pass
		
	def createUI(self):
		try:__builtin__.g_RefNameChUI.Close()
		except:pass
		__builtin__.g_RefNameChUI = WinForms.GUI(cls='Form',size=self._size,text="File Name Replacer")
		self.Form = __builtin__.g_RefNameChUI
		self.Form.Show()
		_bc=System.Drawing.Color.DimGray
		_bcw=System.Drawing.Color.White
		self.panel1 = WinForms.GUI(cls='Panel',size=self._size,pos=[0,0] ,p=self.Form,bc=_bc)
		
		lbbFromName = WinForms.GUI(cls='Label',size=[70,20],pos=[10,10],bc=_bc,text='from name:',p=self.panel1)
		self.EdtFromName = WinForms.GUI(cls='EditText',size=[60,36],pos=[100,5],bc=_bcw,text="EL_",p=self.panel1)
		lbbToName = WinForms.GUI(cls='Label',size=[70,20],pos=[10,50],bc=_bc,text='to name:',p=self.panel1)
		self.EdtToName = WinForms.GUI(cls='EditText',size=[60,36],pos=[100,45],bc=_bcw,text="FShin_",p=self.panel1)
		self.btnConfirm = WinForms.GUI(cls='Button',size=[150,30],text="Confirm",pos=[10,80],bc=_bc,p=self.panel1)
		self.btnConfirm.Click += self.callBtnEventByTag

	def callBtnEventByTag(self, sender , eventArgs):
		self.batchChangeRefPath(self.EdtFromName.Text,self.EdtToName.Text)
		

	def batchChangeRefPath(self,fromName,toName): # fromName = "EL_" toName = "FShin_"
		#指定單一 rig file
		openFileDialog1 = System.Windows.Forms.OpenFileDialog()
		openFileDialog1.Filter = "ma files (*.ma)|*.ma|mb files (*.mb)|*.mb|All files (*.*)|*.*"
		openFileDialog1.FilterIndex = 1
		openFileDialog1.Multiselect = False
		openFileDialog1.Title = "Select Rig File" 

		if (openFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK):
			rigFilePth = (openFileDialog1.FileName).replace('\\','/')
			
			openFileDialog2 = System.Windows.Forms.OpenFileDialog()
			openFileDialog2.Filter = "ma files (*.ma)|*.ma|mb files (*.mb)|*.mb|All files (*.*)|*.*"
			openFileDialog2.FilterIndex = 1
			openFileDialog2.Multiselect = True
			openFileDialog2.Title = "Select Animation Files" 

			if (openFileDialog2.ShowDialog() == System.Windows.Forms.DialogResult.OK):
				for fi in openFileDialog2.FileNames: # fi = openFileDialog2.FileNames[0]
					fi_m = fi.replace('\\','/')
					cmds.file(fi_m,o=True,f=True,lrd='all',options='v=0',prompt=False)
					saveasFileName = fi_m.replace(fromName,toName)
					
					refList = cmds.ls(typ='reference')
					
					#if( ( 'sharedReferenceNode' in r ) or ( '_UNKNOWN_REF_NODE_' in r) ):
					for r in refList: # r= refList[3]
						if( 'sharedReferenceNode' in r):continue
						if(':' in r):continue
						if('WP_' in r):continue
						if(not '_rig' in r):continue
						#print r
						try:
							cmds.file(rigFilePth ,loadReference=r,type="mayaAscii",options="v=0")
						except:pass
						break
						
					cmds.file(rename=saveasFileName)
					cmds.file( force=True, type='mayaAscii', save=True )
					
					odir = os.path.dirname(fi_m)
					of = os.path.basename(fi_m)
					nwodir = odir+"/done_org/"
					nwrcdir = odir+"/done_rfch/"
					System.IO.Directory.CreateDirectory(nwodir)
					System.IO.Directory.CreateDirectory(nwrcdir)
					nwofile = nwodir + of
					nwrfile = nwrcdir + (of.replace(fromName,toName))
					
					shutil.move(fi_m, nwofile)
					shutil.move(saveasFileName, nwrfile)

