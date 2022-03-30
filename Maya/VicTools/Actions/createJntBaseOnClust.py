import maya.cmds as cmds
# UI Lib imports
import PySide.QtGui
# Maya std lib imports
import pymel.core



def setAttrToZero(_objS):
	_trAttr =('.tx', '.ty', '.tz', '.rx', '.ry', '.rz')
	_sAttr =('.sx', '.sy', '.sz')
	for j in range(6):
		cmds.setAttr(_objS+_trAttr[j], 0)
	for k in range(3):
		cmds.setAttr(_objS+_sAttr[k], 1)


# 初始值皆為0
def zeroTmLimit(obj):
	#全部歸零
	## tx
	cmds.setAttr(obj+'.minTransXLimit',0)
	cmds.setAttr(obj+'.maxTransXLimit',0)
	## ty
	cmds.setAttr(obj+'.minTransYLimit',0)
	cmds.setAttr(obj+'.maxTransYLimit',0)
	## tz
	cmds.setAttr(obj+'.minTransZLimit',0)
	cmds.setAttr(obj+'.maxTransZLimit',0)
	## rx
	cmds.setAttr(obj+'.minRotXLimit',0)
	cmds.setAttr(obj+'.maxRotXLimit',0)
	## ry
	cmds.setAttr(obj+'.minRotYLimit',0)
	cmds.setAttr(obj+'.maxRotYLimit',0)
	## rz
	cmds.setAttr(obj+'.minRotZLimit',0)
	cmds.setAttr(obj+'.maxRotZLimit',0)
	

def FreezeTm(_zeroObj,grpName = "_Grp#"):
	_grpName = cmds.group(em=True, name=_zeroObj+grpName)
	cmds.parent(_grpName, _zeroObj) 
	setAttrToZero(_grpName)
	_parentObj = cmds.listRelatives(_zeroObj, p=True)
	try:
		cmds.parent(_grpName, _parentObj)
		cmds.parent(_zeroObj, _grpName)
	except:    
		cmds.parent(_grpName, w=True)
		cmds.parent(_zeroObj, _grpName)
	return _grpName

# 計算層數改變基礎size (較好識別用)
class simpCounter():
	def __init__(self,num):
		self.number = num


def getParentRecursive_Counter(_node_ , cnt ,typ='joint'):
	cnt.number+=1
	_parent = (cmds.listRelatives(_node_,p=True,type=typ))
	if(_parent):
		getParentRecursive_Counter(_parent[0] , cnt)


# 找單一物件層有幾層
def getNumSceneHeirarchyStack(jnt,typ='joint'):
	numStack=simpCounter(0)
	getParentRecursive_Counter(jnt,numStack)
	return numStack.number


# 找最深的層數有幾層
def getMaxSceneHeirarchyStack(scJnts):
	maximumStack=0
	for jnt in scJnts: #jnt=sceneJnts[-1]
		numStack=0
		numStack = getNumSceneHeirarchyStack(jnt)
		if(numStack > maximumStack):maximumStack = numStack
	return maximumStack


def getShapes(objList,objWithShpList,_type="mesh",bGetHidden=False):# 預設隱藏物件不予處理
	resultList = []
	for obj in objList:
		if cmds.nodeType(obj) == "transform":
			bProcess=True
			root = (cmds.ls(obj,l=True)[0]).split('|')[1]
			if(not bGetHidden):
				# 階層中只要有任意一個parent .visibility 是關閉就是隱藏
				hieArr = (cmds.ls(obj,l=True)[0]).split('|')
				for oo in hieArr:
					if(cmds.objExists(oo)):
						if(not cmds.getAttr(oo+".visibility")):
							bProcess=False
			if(bProcess):
				buffers = cmds.listRelatives(obj, fullPath=True, shapes=True)
				if buffers != None and cmds.nodeType(buffers[0]) == _type:
					objWithShpList.append(obj)
					resultList.append(buffers[0])

	return resultList

# sceneJnts = jntArray
def addSceneJointCtrl(sceneJnts,bAlaignToWorld=False,bAddCtrlToEndNode=True):
	curveObj = []
	grps = []
	#sceneJnts = getJoints(getAllObjects())
	maximumStack = getMaxSceneHeirarchyStack(sceneJnts)
	#removeSceneUndoneCtrl() # 先刪除所有 undone
	for jnt in sceneJnts: #jnt=sceneJnts[0]
		childs = cmds.listRelatives(jnt,allDescendents=True)
		if(not childs):childs=[]
		#判斷是否為最後一節
		bThisJntEndNode=False 
		if(not len(childs)):
			bThisJntEndNode=True
		# 判斷最後一節是否要增加Ctrl
		
		#parentCtrl = parentJnts[0]+"_ctrl"
		cir = cmds.circle(n=(jnt+"_ctrl"),nrx=1,nry=0,nrz=0)[0]
		if(not bAlaignToWorld):
			tm=cmds.xform(jnt,q=1,ws=1,m=1)
			if(bThisJntEndNode): # 最後一節，對齊前一節的旋轉
				parentJnts = cmds.listRelatives(jnt,p=True,type='joint')#jnt='Root_M_bind'
				tm=cmds.xform(parentJnts,q=1,ws=1,m=1)
			cmds.xform(cir,roo='xyz',ws=1,m=tm)
			tarObjPos = cmds.xform(jnt, q=True, t=True, ws=True)
			cmds.xform(cir, t =tarObjPos,a=True, ws=True)
			
		#createDefaultCtrlProp(cir,bind=jnt,parent=parentCtrl)
		# 初始scale，層級越高者越大
		numst = getNumSceneHeirarchyStack(jnt)
		if(numst<1):numst=1
		if(numst==maximumStack):numst=maximumStack-1
		scAmt = 20.0 * (1-(numst/float(maximumStack)))
		_size = cmds.jointDisplayScale(q=True) * (cmds.getAttr(jnt+".radius")) * scAmt
		if(_size<1.0):_size=1.0
		cmds.setAttr(cir+".sx",_size )
		cmds.setAttr(cir+".sy",_size )
		cmds.setAttr(cir+".sz",_size )
		# 上下限歸0
		#zeroTmLimit(cir)
		grp = FreezeTm(cir)
		curveObj.append(cir)
		grps.append(grp)
		
	
	return curveObj

# allCurve = curves
def bindSceneJntToCtrlFromProp(allCurve,gpName):
	allCurveObj=[]
	curveShp = getShapes(allCurve,allCurveObj,_type="nurbsCurve")
	cmds.select(cl=True)
	for cs in allCurveObj: # cs = allCurveObj[1]
		#Reset Xform
		p=None
		try:
			p=cmds.listRelatives(cs,p=True)[0]
			cmds.select(p)
			cmds.ungroup()
		except:pass
		
		curPos = cmds.xform(cs, q=True, t=True, ws=True)
		curRot = cmds.xform(cs, q=True, ro=True, ws=True)
		cmds.xform(cs,t=[0,0,0],ro=[0,0,0], ws=True)
		cmds.setAttr(cs+".tx",0);cmds.setAttr(cs+".ty",0);cmds.setAttr(cs+".tz",0)
		cmds.setAttr(cs+".rx",0);cmds.setAttr(cs+".ry",0);cmds.setAttr(cs+".rz",0)
		cmds.makeIdentity(cs,apply=True,t=1,r=1,s=1,n=0)
		cmds.xform(cs,t=curPos,ro=curRot, ws=True)


	#  parent Constraint
	for cs in allCurveObj: # cs = allCurveObj[1]
		bindJnt = cs[0:-5]
		if(cmds.objExists(bindJnt)): # 
			try:cmds.parentConstraint(cs,bindJnt,mo=True)
			except:pass
		else:
			cmds.warning(bindJnt+" can't be found. probably been deleted.")
	controlGrp=[]
	# FreezeTm
	for cs in allCurveObj: # cs = allCurveObj[1]
		controlGrp.append( FreezeTm(cs,gpName) )
		# 上下限歸0
		#zeroTmLimit(cs)
		#LockTmLimt(cs,False)
		
	for i in range(len(controlGrp)-1,0,-1): # i=1
		cmds.parent(controlGrp[i],controlGrp[i-1])

	#清掉無用Group 
	#delSceEmpNestGrp()


# 把選中的 cluster 轉成 Joint Chain & 加入控制器
def turnClustersToJntChain(baseJntName="joint",GroupName="_grp#"):
	__obj = []
	sel = cmds.ls(sl=True)
	selShps = getShapes(sel,__obj ,_type='clusterHandle')
	jntArray = [] # 最後完成的joint array
	cmds.select(cl=True)
	for i in range(0,len(sel)): # i = 0
		jntName = baseJntName+"_"+str(i)
		if(i<10):
			jntName = baseJntName+"_0"+str(i)
		thisNd = sel[i]
		thisNdShp = selShps[i]
		
		curPos = [0,0,0]
		try: # cluster 要抓的是origin
			orig = cmds.getAttr(thisNdShp +".origin")[0]
			_Pos = cmds.xform(thisNd, q=True,t=True,ws=True)
			curPos = [(orig[0]+_Pos[0]),(orig[1]+_Pos[1]),(orig[2]+_Pos[2])]
		except:pass
		jnt = cmds.joint(n=jntName,p=curPos)
		jntArray.append(jntName)

	cmds.joint(jntArray[0],e=True,oj="xyz",secondaryAxisOrient="yup",ch=True,zso=True)

	curves = []
	if(len(jntArray)):
		curves = addSceneJointCtrl(jntArray)
		if(len(curves)):
			bindSceneJntToCtrlFromProp(curves,GroupName)
			





class ClusterJntChainUI():
	def __init__( self ):
		pass
		
	def show( self ):
		window_name = 'ClusterJntChainUI'
		if pymel.core.window( window_name, exists=True ):
			pymel.core.deleteUI( window_name )
			
		# Make the window.
		main_window = pymel.core.window( window_name, wh = ( 200, 200 ), title = 'ClusterJntChainUI')
		main_layout = pymel.core.columnLayout('main_layout', p = main_window )
		
		hor_layout_1 = pymel.core.horizontalLayout( 'hor_layout1', p = main_layout )
		_label_1  = pymel.core.text( 'Chain Base Name: ', p = hor_layout_1  )
		self.BaseName_field  = pymel.core.textField( 'BaseName_field', text = 'jnt', p = hor_layout_1 )
		
		hor_layout_2 = pymel.core.horizontalLayout( 'hor_layout2', p = main_layout )
		_label_2  = pymel.core.text( 'Group Base Name: ', p = hor_layout_2  )
		self.GroupName_field  = pymel.core.textField( 'GroupName_field', text = '_grp#', p = hor_layout_2 )
		
		hor_layout_3 = pymel.core.horizontalLayout( 'hor_layout3', p = main_layout )
		createJntChain_command = pymel.core.Callback( self.createJntChain )
		btn_create = pymel.core.button( 'Build', label = 'Create Joint Ctrl', p = hor_layout_3, c = createJntChain_command)
		
		# re-Arrange 
		horizontal_layouts = [ hor_layout_1 ,hor_layout_2,hor_layout_3]
		for layout in horizontal_layouts:
			layout.redistribute( )
		
		main_window.show( )
		

	def createJntChain(self):
		jntBaseName = pymel.core.textField('BaseName_field',q=True,text=True)
		GrpName = pymel.core.textField('GroupName_field',q=True,text=True)
		turnClustersToJntChain(jntBaseName,GrpName)

jc = ClusterJntChainUI()
jc.show()