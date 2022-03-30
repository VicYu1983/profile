import sys

def onMayaDroppedPythonFile(s):
    file_path = __file__.replace('\\', '/')
    tool_path = '/'.join(file_path.split('/')[:-1])
    lib_path = '/'.join(file_path.split('/')[:-1] + ['Libs'])
    features_path = '/'.join(file_path.split('/')[:-1] + ['Features'])
    studioLibrary_path = '/'.join(file_path.split('/')[:-1] + ['ThirdPart/studiolibrary-2.9.6.b3/src/'])

    paths = [lib_path, features_path]
    for path in paths:
        if path not in sys.path:
            sys.path.append(path)

    import GuiBase
    reload(GuiBase)

    path_string = '","'.join([tool_path, lib_path, features_path, studioLibrary_path])
    GuiBase.InstallToShelfPy('["%s"]' % path_string, 'VicTools', 'VicTools')