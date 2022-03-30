@echo off
set pyfile=%1
set textureWidth=%2
set exportfile=%3
python %pyfile% %1 %textureWidth% %exportfile%
pause 