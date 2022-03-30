import maya.cmds as cmds
import Helper

def execute():
    def clearConstraint(node):
    
        # delete constraints
        childs = cmds.listRelatives(node, c=1)        
        cons = [child for child in childs if 'Constraint' in child]
        for con in cons: cmds.delete(con)
        
        # delete blendParent attributes
        for attr in ['blendParent1', 'blendParent2', 'blendParent3', 'blendParent4', 'blendParent5', 'blendParent6']:
            try: cmds.deleteAttr( node, attribute=attr )
            except: pass

    
    selectNodes = cmds.ls(sl=1)
    if len(selectNodes) > 0:

        # bake all animation first
        (min_inner, max_inner, min_outer, max_outer) = Helper.getTimelineInfo()
        cmds.bakeResults( selectNodes, t=(min_outer, max_outer), simulation=1, bakeOnOverrideLayer=1 )

        # delete all constraints
        for node in selectNodes: clearConstraint( node )