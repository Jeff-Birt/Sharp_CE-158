What are these files?

The ROMs were disassembled using 'lhDump' which is part of lhTools and then
converted to Sharp lh5801 mnemonic syntax.

ROM High bank:
CE-158_ROM_SPV_SPU_HIGH.bin - Raw binary dump of RAM high bank
CE-158_High.frag            - describes addresses where code segments start, i.e. BYTE, CODE
CE-158_High.sym             - address labels, i.e. BRANCH_91AE
CE-158_ROM_HIGH.asm         - ROM disassembly by lhDump
CE-158_ROM_HIGH.lh5801.asm  - ROM disassembly in Sharp format

ROM Low bank:
CE-158_ROM_SPV_RPU_LOW.bin  - Raw binary dump of RAM high bank
CE-158_Low.frag             - describes addresses where code segments start, i.e. BYTE, CODE
CE-158_Low.sym              - address labels, i.e. BRANCH_91AE
CE-158_ROM_LOW.asm          - ROM disassembly by lhDump
CE-158_ROM_LOW.lh5801.asm   - ROM disassembly in Sharp format


dump.bat                    - batch file called by VS COde to tell lhDump what to do
lhDump_command_line.txt     - command line used to call lhDump (what dump.bat does)