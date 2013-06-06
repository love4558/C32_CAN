@echo off

del *.bak
del *.tmp
del *.log

del project.ini

del /s source\*.bak
del /s source\*.tmp
del /s source\*.est
del /s source\*.sti
del /s source\*.obj
del /s source\*.inc
del /s source\*.ptt
del /s source\*.pcd
del /s source\*.cro
del /s source\*.log
del /s source\*.dmp
del /s source\*.bpd
del /s source\*.sb
del /s source\*.crd
del /s source\*.p0?
del /s source\*.1??

del /s /q $gen$\*.*


