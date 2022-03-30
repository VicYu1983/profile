import maya.cmds as cmds
import maya.mel as mel

def makeDir( path ):
    if not os.path.exists(path):
        os.makedirs(path)

def loopDir( path, do ):
    list = cmds.getFileList(folder=path)
    if list != None:
        for name in list:
            subPath = path + '/' + name 
            if name.find('.') == -1:
                loopDir( subPath, do )
            else:
                do( subPath, name )
                
def doExport(path, name):
	ary_str = path.split('/')
	if name.find('.fbx') >= 0:
		ns = ary_str[-2]
		cmds.file(f=True,new=True)
		cmds.file(path,r=True,options="v=0",namespace=ns,ignoreVersion=True )
		mel.eval('FBXExportSkeletonDefinitions -v true;')
		melstr = 'file -force -options "v=0;" -type "FBX export" -pr -ea "%s";' % path
		mel.eval( melstr )

def execute(path):
	path = path.replace('\\', '/' )
	loopDir( path, doExport )

#path = 'D:\Vic\Works2\ImportFBXToRig\HongMeiShuYao_bakeAnim'
#path = path.replace('\\', '/' )
#execute( path )