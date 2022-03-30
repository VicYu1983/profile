# -*- coding: utf-8 -*-
import json, cv2, numpy as np
import sys

print(u"輸出中...")

draw_width = int(sys.argv[2])
f_path = sys.argv[3]

f = open(f_path, "r")
data = json.loads(f.read())

pos = data["pos"]
nor = data["nor"]

# 全部的點
width = len(pos[0])

# 幾個frame
height = len(pos)

# 一行有幾個點
line = int(width / draw_width)
if width % draw_width > 0: line += 1
draw_height = height * line

blank_pos_image = np.zeros((draw_height,draw_width,3), np.float32)
blank_nor_image = np.zeros((draw_height,draw_width,3), np.float32)
for y in range(height):
    for x in range(width):
        draw_x = x % draw_width
        line_id = int(x / draw_width)
        draw_y = line_id * height + y

        value = pos[y][x]
        blank_pos_image[draw_y,draw_x] = [value[2],value[1],value[0]]

        value = nor[y][x]
        blank_nor_image[draw_y,draw_x] = [value[2],value[1],value[0]]
        
exr_path = f_path.replace("_temp.txt", "_offset.EXR")
nor_path = f_path.replace("_temp.txt", "_normal.BMP")

cv2.imwrite(exr_path, blank_pos_image)
cv2.imwrite(nor_path, blank_nor_image)

report_file = f_path.replace("_temp.txt", "_report.txt")

report_txt = u"""
===========輸出完畢============
位移貼圖路徑
""" + exr_path + """

法綫貼圖路徑
""" + nor_path + """

頂點數目        """ + str(width) + """

動作幀數        """ + str(height) + """ [UE4]

貼圖寬度        """ + str(draw_width) + """ [UE4]

貼圖高度        """ + str(draw_height) + """

模型頂點佔用行數 """ + str(line) + """ [UE4]
===========輸出完畢============
"""

print(report_txt)

text_file = open(report_file, "w", encoding="utf-8")
text_file.write(report_txt)
text_file.close() 





