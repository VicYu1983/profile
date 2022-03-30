import uuid
import maya.cmds as cmds
    
def onRoleAddEvent(data, datas):
    print('onRoleAddEvent', data, datas ) 
    
def onRoleRemoveEvent(data, datas):
    print('onRoleRemoveEvent', data, datas ) 

global datas
datas = []

def clearData():
    global datas
    datas = []

def addData():
    data = {'id':str(uuid.uuid4())}
    datas.append(data)
    onRoleAddEvent(data, datas )
    
def removeDataAt(rowId):
    data = getDataAt(rowId)
    if data:
        datas.pop(rowId)
        onRoleRemoveEvent(data, datas )
    else:
        print('id %i is not in datas' % rowId )

def getDataAt(rowId):
    if rowId < len(datas):
        data = datas[rowId]
        return data
    return None
    
def getDatas():
    return datas
    

