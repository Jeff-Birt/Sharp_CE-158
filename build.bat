@echo off
REM Tell TASM where to find the correct table to use
REM We are using the lh5801 table
set TASMTABS=%TASM%\tasmTab\
REM Move up to the TASM 'install' directory 
REM call TASM with build args and source file name
@echo on
REM %TASM%\tasm323\Tasm323.exe -g3 -x7 -5801 CE-158_ROM_LOW.lh5801.asm
%TASM%\tasm323\Tasm323.exe -g3 -x7 -5801 CE-158_ROM_HIGH.lh5801.asm
@echo off
del *.hex
ren *.obj *.hex
