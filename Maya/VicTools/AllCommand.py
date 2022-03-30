# -*- coding: utf-8 -*-
import maya.mel as mel
import studiolibrary
reload(studiolibrary)

def btn_animationExporter_click():
    import AnimationExporter
    reload(AnimationExporter)

    AnimationExporter.execute()

def on_btn_rerangeAnimation_click():
    import ReRangeAnimation
    reload(ReRangeAnimation)

def on_btn_springBone_click():
    import SpringBone
    reload(SpringBone)

    SpringBone.JFSpringBone(u'彈性骨骼', False)

def on_btn_vertexAnimation_click():
    import VertexAnimation
    reload(VertexAnimation) 

    VertexAnimation.execute()        

def on_btn_studioLibrary_click():
    studiolibrary.main()  

def on_btn_advSkeleton_click():
    file_path = __file__.replace('\\', '/').split('/')[:-1] + ['ThirdPart/AdvancedSkeleton5_862/AdvancedSkeleton5.mel";AdvancedSkeleton5;']
    file_path = '/'.join(file_path)
    mel.eval('source "' + file_path)

widgetData = {
    "btn_animationExporter":{"class":"QPushButton", "content":"動畫輸出", "tip":u"", "events":{"clicked":"btn_animationExporter_click"}},
    "btn_rerangeAnimation":{"class":"QPushButton", "content":"動畫重排", "tip":u"", "events":{"clicked":"on_btn_rerangeAnimation_click"}},
    "btn_springBone":{"class":"QPushButton", "content":"彈性骨骼", "tip":u"", "events":{"clicked":"on_btn_springBone_click"}},
    "btn_vertexAnimation":{"class":"QPushButton", "content":"頂點動畫", "tip":u"", "events":{"clicked":"on_btn_vertexAnimation_click"}},

    "btn_studioLibrary":{"class":"QPushButton", "content":"StudioLibrary", "tip":u"", "events":{"clicked":"on_btn_studioLibrary_click"}},
    "btn_advSkeleton":{"class":"QPushButton", "content":"AdvSkeleton", "tip":u"", "events":{"clicked":"on_btn_advSkeleton_click"}},
}    