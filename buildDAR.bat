@echo off
REM Concatenate 

Setlocal EnableDelayedExpansion

set index=15
set hex[15]=F
set hex[14]=E
set hex[13]=D
set hex[12]=C
set hex[11]=B
set hex[10]=A
set hex[9]=9
set hex[8]=8
set hex[7]=7
set hex[6]=6
set hex[5]=5
set hex[4]=4
set hex[3]=3
set hex[2]=2
set hex[1]=1
set hex[0]=0

set command= 
set pos=x

for %%x in (%*) do (
    call :sub1
    echo "%%~x" !q!
    set command=!command! CE-158_ROM_%%~x.bin/b +
)

set command=%command:~1,-1% CE-158_ROM_DAR.bin/b
echo %command%

rem copy CE-158_ROM_NHS.bin/b + CE-158_ROM.bin/b CE-158_ROM_DAR.bin/b
copy %command%

goto :endparse

:sub1
    set q=!hex[%index%]!
    rem echo %q%
    set /A index=!index!-1
EXIT /B


:endparse
