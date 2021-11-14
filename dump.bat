@echo off
REM Tell TASM where to find the correct table to use
REM We are using the lh5801 table
set LHTOOLSDIR=C:\Users\birtj\OneDrive\Vintage_Computers\Software\lhTools\lhTools-0.7.6p1
REM set TASMEXE=%TASMDIR%\tasm323
REM set TASMTABS=%TASMDIR%\tasmTab\
REM Move up to the TASM 'install' directory 
REM call TASM with build args and source file name
@echo on
%LHTOOLSDIR%\lhDump -F CE-158_Low.frag -S CE-158_Low.sym -o CE-158_ROM_LOW.asm CE-158_ROM_SPV_RPU_LOW.bin 
REM %LHTOOLSDIR%\lhDump -F CE-158_High.frag -S CE-158_High.sym -o CE-158_ROM_HIGH.asm CE-158_ROM_SPV_SPU_HIGH.bin 
@echo off
