@echo off
REM Tell TASM where to find the correct table to use
REM We are using the lh5801 table
set TASMTABS=%TASM%\tasmTab\
REM Move up to the TASM 'install' directory 
REM call TASM with build args and source file name

IF "%~1" == "-l" (
    @echo Building low bank
    %TASM%\tasm323\Tasm323.exe -x7 -g3 -5801 CE-158_ROM_LOW.lh5801.asm 
    del CE-158_ROM_LOW.bin
    ren CE-158_ROM_LOW.obj CE-158_ROM_LOW.bin
) ELSE IF "%~1" == "-h" (
    @echo Building high bank
    %TASM%\tasm323\Tasm323.exe -g3 -x7 -5801 CE-158_ROM_HIGH.lh5801.asm 
    del CE-158_ROM_HIGH.bin
    ren CE-158_ROM_HIGH.obj CE-158_ROM_HIGH.bin
) ELSE IF "%~1" == "-b" (
    @echo Building both banks
    %TASM%\tasm323\Tasm323.exe -g3 -x7 -5801 CE-158_ROM_LOW.lh5801.asm 
    del CE-158_ROM_LOW.bin
    ren CE-158_ROM_LOW.obj CE-158_ROM_LOW.bin

    @echo Building high bank
    %TASM%\tasm323\Tasm323.exe -g3 -x7 -5801 CE-158_ROM_HIGH.lh5801.asm 
    del CE-158_ROM_HIGH.bin
    ren CE-158_ROM_HIGH.obj CE-158_ROM_HIGH.bin

    echo "CE-158_ROM_%~2.bin"

    copy CE-158_ROM_LOW.bin/b + CE-158_ROM_HIGH.bin/b "CE-158_ROM_%~2.bin"/b
) ELSE ( 
    @echo Unknown command )

:endparse
