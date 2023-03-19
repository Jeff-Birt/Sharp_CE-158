What are these files?

The ROMs were disassembled using 'lhDump' which is part of lhTools and then converted to Sharp lh5801 mnemonic syntax. Further disassembly was was done with my own disaseembler. 

lhTools_Disassembly Folder - 
ROM High bank:
    CE-158_High.frag            - describes addresses where code segments start, i.e. BYTE, CODE
    CE-158_High.sym             - address labels, i.e. BRANCH_91AE
    CE-158_Low.frag             - describes addresses where code segments start, i.e. BYTE, CODE
    CE-158_Low.sym              - address labels, i.e. BRANCH_91AE
    CE-158_ROM_HIGH.asm         - ROM disassembly by lhDump
    CE-158_ROM_LOW.asm          - ROM disassembly by lhDump

root folder - 
    build.bat                   - Used to build CE-158 code with TASM
    CE-150.lib                  - CE-150 library file generated with Sharp_PC-1500_Lib_Builder
    CE-158.lib                  - CE-158 library file generated with Sharp_PC-1500_Lib_Builder
    CE158_Registers.docx        - Information about CE-158 registers
    CE-158_ROM_HIGH.lh5801.asm  - Buildable high bank in Sharp format
    CE-158_ROM_HIGH.LST.lh5801.asm - Original high bank disassembly in list format
    CE-158_ROM_LOW.lh5801.asm   - Buildable low bank in Sharp format
    CE-158_ROM_LOW.LST.lh5801.asm  - Original low bank disassembly in list format
    CE-158_ROM_SPV_RPU_LOW.bin  - Raw binary dump of RAM high bank
    CE-158_ROM_SPV_SPU_HIGH.bin - Raw binary dump of RAM high bank
    PC-1500.lib                 - PC-1500 library file generated with Sharp_PC-1500_Lib_Builder
    README.MD                   - This file









dump.bat                    - batch file called by VS COde to tell lhDump what to do

lhDump_command_line.txt     - command line used to call lhDump (what dump.bat does)
