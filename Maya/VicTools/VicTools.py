# -*- coding:utf-8 -*-
import GuiBase, AllCommand
reload(AllCommand)

layoutData = {
    '1_工具類':[
        ['btn_animationExporter', 'btn_rerangeAnimation'],
        ['btn_springBone', 'btn_vertexAnimation']
    ],
    '2_第三方工具':[
        ['btn_studioLibrary', 'btn_advSkeleton']
    ]
}

ui = GuiBase.BasicUI('VicTools', False)
widgets = ui.generateUIByConfig(AllCommand.widgetData, layoutData, AllCommand)
