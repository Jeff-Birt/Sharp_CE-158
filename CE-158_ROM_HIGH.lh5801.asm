; CE-158_ROM_HI.lh5801.asm

.ORG $8000

;------------------------------------------------------------------------------------------------------------
; BASIC Table 8000 - (Second table at 8800)
B_TBL_8000:
8000	55                  .BYTE   55                          ; Marker that BASIC Table follows 

B_TBL_8000_TNUM:
8001	08                  .BYTE   08                          ; Table number

B_TBL_8000_NAME:
8002	43 4F 4D 0D   
8006    0D 0D 0D 0D         .TEXT   "COM\r\r\r\r\r"             ; Table name

B_TBL_8000_INIT:
800A    BA 82 B8            JMP     COM_TBL_INIT                ; $82B8 - Table initilization vector

B_TBL_8000_INPUT#:
800D	BA 82 C5            JMP	    COM_TBL_INPUT#              ; $82C5 - Table INPUT# vector (Jumps to MERGE)

B_TBL_8000_PRINT#:
8010	BA 82 C9            JMP	    COM_TBL_PRINT#              ; $82C9 - Table PRINT# vector (Jumps to MERGE)

B_TBL_8000_JMPS:
8013	BA 79 FA 9A         .BYTE BA 79 FA 9A                   ; $79FA - Undefined in main ROM
8017    9A 9A 9A 9A         .BYTE 9A 9A 9A 9A
8021    9A 9A               .BYTE 9A 9A                         ; Unused jumps (79FA unknown)

B_TBL_8000_TRACE:
801D	C4 AF FF            VEJ     (C4),AF,811F                ; Correct per book. Not used?

B_TBL_8000_A_KW:
8020	00 00               .BYTE   00 00                       ; N/A

B_TBL_8000_B_KW:
8022	80 56               .BYTE   80 56                       ; $8056

B_TBL_8000_C_KW:
8024	80 60               .BYTE   80 60                       ; $8060

B_TBL_8000_D_KW:
8026	80 89               .BYTE   80 89                       ; $8089

B_TBL_8000_E_KW:
8028	80 9A               .BYTE   80 9A                       ; $809A

B_TBL_8000_F_KW:
802A	80 AA               .BYTE   80 AA                       ; $80AA

B_TBL_8000_G_KW:
802C	00 00               .BYTE   00 00                        ; N/A

B_TBL_8000_H_KW:
802E	00 00               .BYTE   00 00                       ; N/A

B_TBL_8000_I_KW:
8030	80 B3               .BYTE   80 B3                       ; $80B3

B_TBL_8000_J_KW:
8032	00 00               .BYTE   00 00                       ; N/A

B_TBL_8000_K_KW:
8034	00 00               .BYTE   00 00                       ; N/A

B_TBL_8000_L_KW:
8036	80 C8               .BYTE   80 C8                       ; $80C8

B_TBL_8000_M_KW:
8038	80 DD               .BYTE   80 DD                       ; $80DD

B_TBL_8000_N_KW:
803A	00 00               .BYTE   00 00                       ; N/A

B_TBL_8000_O_KW:
803C	80 E7               .BYTE   80 E7                       ; $80E7

B_TBL_8000_P_KW:
803E	80 F3               .BYTE   80 F3                       ; $80F3

B_TBL_8000_Q_KW:
8040	00 00               .BYTE   00 00                       ; N/A

B_TBL_8000_R_KW:
8042	81 0A               .BYTE   81 0A                       ; $810A

B_TBL_8000_S_KW:
8044	81 16               .BYTE   81 16                       ; $8116

B_TBL_8000_T_KW:
8046	81 37               .BYTE   81 37                       ; $8137

B_TBL_8000_U_KW:
8048	00 00               .BYTE   00 00                       ; N/A

B_TBL_8000_V_KW:
804A	00 00               .BYTE   00 00                       ; N/A

B_TBL_8000_W_KW:
804C	00 00               .BYTE   00 00                       ; N/A

B_TBL_8000_X_KW:
804E	00 00               .BYTE   00 00                       ; N/A

B_TBL_8000_Y_KW:
8050	00 00               .BYTE   00 00                       ; N/A

B_TBL_8000_Z_KW:
8052	81 59               .BYTE   81 59                       ; $8159

B_TBL_8000_CMD_LST:
;Add   Ctrl Name         Token Vector
8054	B5 "BREAK"        F0B3 CD89                             ; $CD89 - Basic command P___/STEP/OFF/OR/ERROR/AND/THEN/TO
805E	B5 "CLOAD"        F089 82EC                             ; $82EC - MAIN_ENTRY/CLOAD
8068	C5 "CSAVE"        F095 82DD                             ; $82DD - Drops through to MAIN_ENTRY/CLOAD
8072	C4 "COM$"         E858 82D3                             ; $82D3 - Drops through to MAIN_ENTRY/CLOAD
807B	C7 "CONSOLE"      F0B1 82DE                             ; $82DE - Drops through to MAIN_ENTRY/CLOAD 
8087	D4 "DEV$"         E857 82D4                             ; $82D4 - Drops through to MAIN_ENTRY/CLOAD 
8090	C3 "DTE"          E884 82D1                             ; $82D1 - Drops through to MAIN_ENTRY/CLOAD 
8098	D3 "ERN"          F052 82DF                             ; $82DF - Drops through to MAIN_ENTRY/CLOAD 
80A0	C3 "ERL"          F053 82E0                             ; $82E0 - Drops through to MAIN_ENTRY/CLOAD 
80A8	D4 "FEED"         F0B0 82E1                             ; $82E1 - Drops through to MAIN_ENTRY/CLOAD 
80B1	D5 "INPUT"        F091 82E2                             ; $82E2 - Drops through to MAIN_ENTRY/CLOAD 
80BB	C6 "INSTAT"       E859 82E3                             ; $82E3 - Drops through to MAIN_ENTRY/CLOAD 
80C6	D6 "LPRINT"       F0B9 82E4                             ; $82E4 - Drops through to MAIN_ENTRY/CLOAD 
80D1	C5 "LLIST"        F0B8 82E5                             ; $82E5 - Drops through to MAIN_ENTRY/CLOAD 
80DB	D5 "MERGE"        F08F 82C0                             ; $82C0 - Sets XL=F0, branches to MAIN_ENTRY/CLOAD
80E5	97 "OUTSTAT"      E880 82E6                             ; $82E6 - Drops through to MAIN_ENTRY/CLOAD 
80F1	C5 "PRINT"        F097 82E7                             ; $82E7 - Drops through to MAIN_ENTRY/CLOAD  
80FB	C8 "PROTOCOL"     E881 82E8                             ; $82E8 - Drops through to MAIN_ENTRY/CLOAD  
8108	D7 "RINKEY$"      E85A 82E9                             ; $82E9 - Drops through to MAIN_ENTRY/CLOAD 
8114	D6 "SETCOM"       E882 82D6                             ; $82D6 - Drops through to MAIN_ENTRY/CLOAD 
811F	C6 "SETDEV"       E886 82D5                             ; $82D5 - Drops through to MAIN_ENTRY/CLOAD 
812A	C6 "SPACE$"       F061 82EA                             ; $82EA - Drops through to MAIN_ENTRY/CLOAD 
8135	B8 "TERMINAL"     E883 82D2                             ; $82D2 - Drops through to MAIN_ENTRY/CLOAD 
8142	C8 "TRANSMIT"     E885 82D7                             ; $82D7 - Drops through to MAIN_ENTRY/CLOAD 
814F	C3 "TAB"          F0BB 880D                             ; $880D - Uses BASIC Table TAB/INPUT# vector
8157	D4 "ZONE"         F0B4 82EB                             ; $82EB - Drops through to MAIN_ENTRY/CLOAD 

B_TBL_8800_END:
8160	D0 

;------------------------------------------------------------------------------------------------------------
; Unused address range 8161-8168
SEPARATOR_8161:
8161	FF 00 FF 00         .BYTE   FF 00 FF 00                 ; FF 00 - Used as seperator / space filler
8164    FF 00 FF 00         .BYTE   FF 00 FF 00                 ; 


;------------------------------------------------------------------------------------------------------------
; CHAR2LPT - Sends charecter in A to LPT
; Called from SUB_PRINT#:9307, SUB_PRINT#:956D, 826E
; Arguments: A: ASCII charecter >=20, i.e. printable
; Outputs: REC = Success, A = 20 Low Battery
; RegMod: A
CHAR2LPT:
8169	FD C8               PSH	    A                           ; A is the ASCII charecter from input buffer?
816B	B5 7F               LDI	    A,7F                        ; 
816D	FD AE D0 0D         STA     #(CE158_PRT_B_DIR)          ; Bit 7 Read (BUSY), (ME1)
8171	FD A5 D0 0E         LDA     #(CE158_PRT_A)              ; Read CE-158 Port A,  (ME1). 
8175	FD A9 D0 0E         AND     #(CE158_PRT_A)              ; Filter out input changes? (ME1)
8179	D9                  SHL                                 ; A = A << 1. Shited though carry. 0 into MSB
817A	D9                  SHL                                 ; Original    7 6 5 4 3 2 1 0
817B	D9                  SHL                                 ; << 3        4 3 2 1 0 0 0 0 
817C	FD 8A               POP	    A                           ; Get our ASCII charecter from input buffer back
817E	83 38               BCS+    BRANCH_81B8                 ; If #(PRT_A_IO) Bit 5, (Low Battery) skip
8180	FD ED D0 0F 80      BII     #(CE158_PRT_B),80           ; (ME1)
8185	8B A5               BZS+    BRANCH_822C                 ; If Bit 7 not set (I/F_BUSY) branch fwd
8187	FD E9 D0 08 9F      ANI     #(CE158_PRT_C),9F           ; Clear Bits 6,5 LPT_STROBE,LPT_DATA1 (ME1) 
818C	BD FF               EAI	    FF                          ; A = A ^ FF. Invert due to invertors in LPT output.
818E	D5                  SHR                                 ; A = A >> 1. Shifted through Carry, 0 into MSB
818F	81 05               BCR+    BRANCH_8196                 ; If Bit 0 set (inverted/shifted out), branch fwd
8191	FD EB D0 08 20      ORI     #(CE158_PRT_C),20           ; Set Bit 5, LPT_DATA1 (ME1)
                                                                ; DATA1 on PORTC, DATA 2-8 on PORTB

BRANCH_8196: ; Branched to from 818F
8196	FD AE D0 0F         STA     #(CE158_PRT_B)              ; #(PRT_B_IO) = A (ME1). A = (A ^ FF) >> 1
                                                                ; Shift in 818C aligns Bits 2-8 to PORTB.
819A	B5 80               LDI	    A,80                        ; Set up time delay

BRANCH_819C: ; Branched to from 81D9
819C	DF                  DEC	    A                           ; Carry set by first DEC, count 80->0
819D	93 03               BCS-    BRANCH_819C                 ; If Carry set repeat, carry clear after hitting 0
819F	FD BE               RIE                                 ; Disable interrupts 
81A1	FD EB D0 08 40      ORI     #(CE158_PRT_C),40           ; Set LPT_STROBE (ME1)
81A6	B5 80               LDI	    A,80                        ; Set up time delay

BRANCH_81A8: ; Branched to from 81A9
81A8	DF                  DEC	    A                           ; Carry set by first DEC, count 80->0
81A9	93 03               BCS-    BRANCH_81A8                 ; If Carry set repeat, Carry clear after hitting 0
81AB	FD E9 D0 08 BF      ANI     #(CE158_PRT_C),BF           ; CE-158 - Clear LPT_STROBE (ME1)
81B0	FD 81               SIE                                 ; Enable Interrupts
81B2	B5 80               LDA	    A,80                        ; Set up time delay

BRANCH_81B4: ; Branched to from 81B5
81B4	DF                  DEC	    A                           ; Carry set by first DEC, count 80->0
81B5	93 03               BCS-    BRANCH_81B4                 ; If Carry set repeat, Carry clear after hitting 0
81B7	9A                  RTN                                 ; Carry will be reset by last DEC above

BRANCH_81B8: ; Branced from 817E                                ; Return here if low battery
81B8	B5 20               LDI	    A,20                        ; Does A = 20 mean low battery?
81BA	FB                  SEC                                 ; Carry used to indicate return state? 
81BB	9A                  RTN                                 ; Set Carry Flag. SEC = Failure



; -----------------------------------------------------------------------------------------------------------
; CHAR2COM - Sends charecter in A to RS232 Port
; Called from STRNG_2COM:875B, NULL2COM, JMP_90B1:90B1, JMP_9ED0:9EF0, 8247
; Arguments: A charecter to send
; Outputs: REC = Success, A = #(CE158_PRT_A) Bits 5-2  on failure
; RegMod: A
CHAR2COM:
81BC	FB                  SEC                                 ; Set Carry Flag
81BD	FD A8               PSH     U                           ; Save U.
81BF	2A                  STA	    UL                          ; A is charecter to send
81C0	FD A5 D0 0E         LDA	    #(CE158_PRT_A)              ; #(CE158_PRT_A) is LPT/RS232 I/F Ctrl (ME1)
81C4	FD A9 D0 0E         AND	    #(CE158_PRT_A)              ; Filter out changes (ME1)
81C8	B9 3C               ANI	    A,3C                        ; Keep Bits 2->CTS, 3->CD 
                                                                ; 4->DSR, 5->Low Battery
81CA	89 17               BZR+    BRANCH_81E3                 ; Branch fwd if any bit 5-2 is set
81CC	A5 78 57            LDA	    (SETDEV_REG)                ; (SETDEV_REG) = What device directed to RS232
81CF	B9 C0               ANI	    A,C0                        ; Keep Bits 7-6, not sure waht these two are
81D1	D9                  SHL                                 ; A = A < 1. Left through Carry, 0 carried into MSB
81D2	83 02               BCS+    BRANCH_81D6                 ; Branch fwd if Bit 7 was set
81D4	B5 04               LDI	    A,04                        ; A = 4. Set bit 2

BRANCH_81D6: ; Branched to from 81D2
81D6	FD A9 D2 03         AND	    #(UART_REG_R)               ; CE-158 - UART Control/Status Read (ME1)
81DA	FB                  SEC                                 ; Set carry flag = failure
81DB	8B 06               BZS+    BRANCH_81E3                 ; Branch fwd if Bit 2 in #(UART_REG_R) or Bits 7-6 in SETDEV
81DD	24                  LDA	    UL                          ; Our original A is in UL. Charecter to send.
81DE	FD AE D2 00         STA	    #(UART_DATA_W)              ; Writes A to UART (ME1)
81E2	F9                  REC                                 ; Reset Carry Flag = Success

BRANCH_81E3: ; Branched to from 81DB
81E3	FD 2A               POP	    U                           ; Get orignal U back, affectes Z only
81E5	9A                  RTN                                 ; A contains #(CE158_PRT_A) Bits 5-2 on failure



;-------------------------------------------------------------------------------------------------------------
; IOCFG - Configures LPT/UART registers
; called from 8CBD, 99BC.  Alt entry at 822C, 8CBD
; Arguments: None
; Outputs: REC = Success, A = Failure type or UART data read
; RegMod: A
IOCFG: 
81E6	FD A5 D0 0E         LDA	    #(CE158_PRT_A)              ; #(CE158_PRT_A) is LPT/RS232 control (ME1)
81EA	FD A9 D0 0E         AND     #(CE158_PRT_A)              ; Filter out changes
81EE	B9 3C               ANI     A,3C                        ; Keep Bits 2->CTS, 3->CD 
                                                                ; 4->DSR, 5->Low Battery
81F0	89 3E               BZR+    BRANCH_8230                 ; Branch fwd if any bits 5-2 were set
81F2	FD A5 D2 03         LDA     #(UART_REG_R)               ; A = #(UART_REG_R) (ME1)
81F6	ED 78 57 40         BII	    (SETDEV_REG),40             ; Keep Bit 6 (BREAK), not sure what bits 5-6-7 are
81FA	8B 01               BZS+    BRANCH_81FD                 ; Branch fwd if Bit 6 was not set
81FC	D9                  SHL                                 ; A = A << 1. Left through Carry, 0 into MSB

BRANCH_81FD: ; Branched to from 81FA
81FD	BF 02               BII	    A,02                        ; FLAGS = (#(UART_REG_R) << 1) & 02. Keep original Bit 0
81FF	8B 2B               BZS+    BRANCH_822C                 ; Branch fwd if Bit 1 (Orig Bit 0) not set
8201	ED 78 57 80         BII	    (SETDEV_REG),80             ; Keep Bit 7, not sure what bits 5, 6, 7 are
8205	8B 01               BZS+    BRANCH_8208                 ; Branch fwd if Bit 7 not set 
8207	D9                  SHL                                 ; A = (#(UART_REG_R) << 2)

BRANCH_8208: ; Branched to from 8205
8208	BF 70               BII	    A,70                        ; Keep bit 6-4, Bits 4-2 from original #(UART_REG_R)
820A	8B 1A               BZS+    BRANCH_8226                 ; Branch fwd if any Bits 6-4 were not set (Orig Bits 4-2)
820C	FD A5 D2 02         LDA     #(UART_DATA_R)              ; (ME1)
8210	ED 78 57 20         BII	    (SETDEV_REG),20             ; Not sure what bits 5, 6, 7 are
8214	8B 0C               BZS+    BRANCH_8222                 ; Branch fwd if Bit 5 not set
8216	B5 15               LDI	    A,15                        ;
8218	FD AE D2 01         STA     #(UART_REG_W)               ; Writing UART control reg (ME1)
821C	B5 05               LDI	    A,05                        ; Why are we writing two values to same I/O?
821E	FD AE D2 01         STA     #(UART_REG_W)               ; To pulse Bit 4?

BRANCH_8222: ; Branched to from 8214
8222	B5 40               LDI	    A,40                        ; Does this signify failure type?
8224	FB                  SEC                                 ; Set Carry Flag
8225	9A                  RTN                                 ; SEC = Failure

BRANCH_8226: ; Branched to from 820A
8226	FD A5 D2 02         LDA     #(UART_DATA_R)              ; (ME1)
822A	F9                  REC                                 ; REC = Success
822B	9A                  RTN                                 ; Carry flag indicates return state

BRANCH_822C: ; Branched to bfrom 8185, 81FF
822C	B5 00               LDI	    A,00                        ; Does this signify failure type?
822E	FB                  SEC                                 ; SEC = Failure
822F	9A                  RTN                                 ; Carry flag indicates return state

BRANCH_8230: ; Branched to from 81F0
8230	FD C8               PSH	    A                           ; A = #(PORTA_IO) & 3C (Bits 5-2), failure type?
8232	FD A5 D2 02         LDA     #(UART_DATA_R)              ; A = Data read from UART (ME1)
8236	FB                  SEC                                 ; SEC = Failure

BRANCH_8237: ; Branched to from 824A to borrow return
8237	FD 8A               POP	    A                           ; Why did we read #(D202) and not use it?
8239	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; Called from ?? - Sends charecter in A to RS232 Port. ***
; not sure what calls into this sub yet
; Arguments: A charecter to send
; Outputs:
; RegMod: UH
UNKNOWN_823A:
823A	E9 78 50 0F         ANI	    (OUTSTAT_REG),0F            ; Keep only low nibble Bit_0 = DCD, Bit_1 = DSR

BRANCH_823E: ; Branched to from 8250, 8256
823E	FD ED F0 0B 02      BII	    #(PC1500_IF_REG),02         ; PC-1500 - IF Register Input / Output, keep Bit 1 (Key Strobe?)
8243	89 6E               BZR+    BRANCH_82B3                 ; If Bit 1 was set branch fwd to an exit
8245	FD C8               PSH	    A                           ; Save A
8247	BE 81 BC            SJP     CHAR2COM                    ; Sends charecter in A to RS232 Port
824A	91 15               BCR-    BRANCH_8237                 ; Carry Reset = success
824C	D5                  SHR                                 ;  returns A = #(PRT_A_IO) Bits 5-2 on failure
824D	D5                  SHR                                 ; A = A >> 2. Through carry. 0 into MSB
824E	FD 8A               POP	    A                           ; POP A only changes Z flag
8250	95 14               BHR-    BRANCH_823E                 ; If Bit 3 (half carry) not set by shifts above (Low Battery Bit 5)
8252	EF 78 50 10         ADI	    (OUTSTAT_REG),10            ; (OUTSTAT_REG) += 10, bit 4, Bit_0 = DCD, Bit_1 = DSR
8256	91 1A               BCR-    BRANCH_823E                 ; Are we waiting for a handshaking signal

BRANCH_8258: ; Branched to from 828C, 82AB to borrow return
8258	68 32               LDI	    UH,32                       ; Return code?

BRANCH_825A: ; Branched to from 8284 to borrow return
825A	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; SUB_825B - Sends data to LPT output function 
; Called from? ***
; Arguments: A = charecter to send
; Outputs: A: Error code, 20 = Low Battery, 00 = Could not send?, UH: 45 = success
; RegMod: UH
SUB_825B:
825B	E9 78 50 0F         ANI	    (OUTSTAT_REG),0F            ; Bit_0 = DCD, Bit_1 = DSR

BRANCH_825F: ; Branched to from 828A
825F	FD A8               PSH     U                           ;
8261	6A FF               LDI	    UL,FF                       ; try to send FF times?
8263	68 00               LDI	    UH,00                       ; U = 00FF

BRANCH_8265: ; Branched to from 8275, 8279
8265	FD ED F0 0B 02      BII	    #(PC1500_IF_REG),02         ; (IF1) Set on rising edge of PB7 input
826A	89 45               BZR+    BRANCH_82B1                 ; If Bit 1 was set = done?, return path.
826C	FD C8               PSH	    A                           ; 
826E	BE 81 69            SJP     CHAR2LPT                    ; Sends charecter in A to LPT, Returns A as failure type
8271	89 0D               BZR+    BRANCH_8280                 ; A = 20 Low Battery, A = 00 is could not send?
8273	FD 8A               POP	    A                           ;
8275	88 12               LOP     UL,BRANCH_8265              ; UL = UL - 1, loop back e if Borrow Flag not set
8277	FD 60               INC	    UH                          ;
8279	91 16               BCR-    BRANCH_8265                 ; Keeps trying to send A until timeout
827B	FD 2A               POP	    U                           ;
827D	68 45               LDI	    UH,45                       ;
827F	9A                  RTN                                 ;

BRANCH_8280: ; Branched to from 8271,                           ; Got here because Low Battery
8280	FD 8A               POP	    A                           ;
8282	FD 2A               POP	    U                           ;
8284	91 2C               BCR-    BRANCH_825A                 ; Carry Clear = Success, borrowing a Return to exit
8286	EF 78 50 10         ADI	    (OUTSTAT_REG),10            ; Bit 4 is DR but that is input?
828A	91 2D               BCR-    BRANCH_825F                 ; If we did not set carry
828C	9E 36               BCH-    BRANCH_8258                 ; Unconditional back branch, borrowing a return.

828E	E9 78 50 0F         ANI	    (OUTSTAT_REG),0F            ; Keep Bits 0-3, Bit_0 = DCD, Bit_1 = DSR

BRANCH_8292: ; Branched to from 82A0, 82A9
8292	FD ED F0 0B 02      BII	    #(PC1500_IF_REG),02         ; (IF1) Set on rising edge of PB7 input
8297	89 1A               BZR+    BRANCH_82B3                 ; If PB7 was set ON key input?
8299	BE 81 E6            SJP     IOCFG                    ; Manipulates LPT/UART registers
829C	81 12               BCR+    BRANCH_82B0                 ; REC = Success, A = Failure type or UART data read
829E	B9 60               ANI	    A,60                        ; A = A & 60.
82A0	9B 10               BZS-    BRANCH_8292                 ; If Bits 5 or 6 not set
82A2	D9                  SHL                                 ; A = A << 1. Thru carry. 0 into LSB
82A3	8F 08               BVS+    BRANCH_82AD                 ; If Overlflow set
82A5	EF 78 50 10         ADI	    (OUTSTAT_REG),10            ; (OUTSTAT_REG) += 10. Bit_0 = DCD, Bit_1 = DSR
82A9	91 19               BCR-    BRANCH_8292                 ; Carry set by shift above
82AB	9E 55               BCH-    BRANCH_8258                 ; Unconditional back branch, borrowing a return?

BRANCH_82AD: ; Branched to from 82A3
82AD	68 3A               LDI	    UH,3A                       ; Return value?
82AF	FB                  SEC                                 ; Set Carry Flag

BRANCH_82B0: ; Branched to from 829C
82B0	9A                  RTN                                 ;

BRANCH_82B1: ; Branched to from 826A
82B1	FD 2A               POP	    U                           ;

BRANCH_82B3: ; Branched to from 8243, 8297
82B3	68 00               LDI	    UH,00                       ; Return value?
82B5	FB                  SEC                                 ; Set Carry Flag
82B6	9A                  RTN                                 ;


; Not sure this is reached, but 8303 is a valid line in MAIN_ENTRY ***
82B7	8E 4A               BCH+    8303                        ; Unconditional fwd branch



;------------------------------------------------------------------------------------------------------------
; COM_TBL_INIT - Called from BASIC table init vector 800A
; Called from BASIC Table 8000 INIT, changes XL which is used to calc index into vector table
; Arguments:
; Outputs:
; RegMod: XL
COM_TBL_INIT:
82B8	4A D0               LDI	    XL,D0                       ; D0 is command code for INIT
82BA	E9 79 DE EF         ANI	    (UNDEF_REG_79DE),EF         ; (UNDEF_REG_79DE) = (UNDEF_REG_79DE) & EF
82BE	8E 2C               BCH+    MAIN_ENTRY/CLOAD            ; Branch fwd unconditional


;------------------------------------------------------------------------------------------------------------
; Following called via BASIC Table 8000 Command List vectors
; X-REG contains address of function below. Some stubs below change XL. Most drop through.
; XL used to calculate index into vector table
; Arguments:
; Outputs:
; RegMod: UL, XL
MERGE:
82C0	60                  INC	    UL                          ; Line number counter?
82C1	4A F0               LDI	    XL,F0                       ; F0 a command code, used in MAIN_ENTRY
82C3	8E 27               BCH+    MAIN_ENTRY/CLOAD            ; Branch fwd unconditional

INPUT#:
82C5	4A ED               LDI	    XL,ED                       ; ED a command code, used in MAIN_ENTRY
82C7	8E 23               BCH+    MAIN_ENTRY/CLOAD            ; Branch fwd unconditional

PRINT#:
82C9	4A EE               LDI	    XL,EE                       ; EE a command code, used in MAIN_ENTRY
82CB	8E 1F               BCH+    MAIN_ENTRY/CLOAD            ; Branch fwd unconditional

PRINT#2:
82CD	4A EF               LDI	    XL,EF                       ; EF a command code, used in MAIN_ENTRY
82CF	8E 1B               BCH+    MAIN_ENTRY/CLOAD            ; Branch fwd unconditional

DTE:
82D1	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

TERMINAL:
82D2	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

COM$:
82D3	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

DEV$:
82D4	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

SETDEV:
82D5	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

SETCOM:
82D6	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

TRANSMIT:
82D7	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

CONSOLE:
82D8	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

FEED:
82D9	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

LPRINT:
82DA	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

LLIST:
82DB	F9                  REC                                 ; Reset Carry Flag, does nothing drop through
82DC	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

CSAVE:
82DD	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

CONSOLE:
82DE	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

ERN:
82DF	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

ERL:
82E0	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

FEED:
82E1	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

INPUT:
82E2	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

INSTAT:
82E3	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

LPRINT:
82E4	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

LLIST:
82E5	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

OUTSTAT:
82E6	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

PRINT:
82E7	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

PROTOCOL:
82E8	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

RINKEY$:
82E9	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

SPACE$:
82EA	F9                  REC                                 ; Reset Carry Flag, does nothing drop through

ZONE:
82EB	F9                  REC                                 ; Reset Carry Flag, does nothing drop through



;------------------------------------------------------------------------------------------------------------
; MAIN_ENTRY/CLOAD - Called from 82BE, 82C3, 82C7, 82CB, 82CF
; Arguments: X-REG=Address BASIC Table pointed to. Y-REG Token
; Outputs: Calculates offset into Command Vector Table at $8331 based on LB address given in BASIC Table.
; A few commands alter the value in XL before reacing here. For some functions, low ROM banked back in.
; Function jumped to be setting its address in P. Table of calcualted vectors below.
; RegMod: U, A, X
;                           Mofified
; Command     Token   Addr  Address    ; PTR   VECT   Bank
; "BREAK"     F0B3    CD89             ; Ignore has a real address 
; "CLOAD"     F089    82EC             ; 8339 (901B)  Low 
; "CSAVE"     F095    82DD             ; 8357 (901A)  Low
; "COM$"      E858    82D3             ; 836B (8893)  High
; "CONSOLE"   F0B1    82DE             ; 8355 (8365)  Low
; "DEV$"      E857    82D4             ; 8369 (8899)  High
; "DTE"       E884    82D1             ; 836F (8C8E)  High
; "ERN"       F052    82DF             ; 8353 (8312)  Low
; "ERL"       F053    82E0             ; 8351 (8309)  Low
; "FEED"      F0B0    82E1             ; 834F (9820)  Low
; "INPUT"     F091    82E2             ; 834D (8FFF)  Low
; "INSTAT"    E859    82E3             ; 834B (832A)  Low
; "LPRINT"    F0B9    82E4             ; 8349 (9056)  Low
; "LLIST"     F0B8    82E5             ; 8347 (901D)  Low
; "MERGE"     F08F    82C0  (82F0)     ; 8331 (901C)  Low
; "OUTSTAT"   E880    82E6             ; 8345 (8334)  Low
; "PRINT"     F097    82E7             ; 8343 (900D)  Low
; "PROTOCOL"  E881    82E8             ; 8341 (8317)  Low
; "RINKEY$"   E85A    82E9             ; 833F (8357)  Low
; "SETCOM"    E882    82D6             ; 8365 (8907)  High
; "SETDEV"    E886    82D5             ; 8367 (8968)  High
; "SPACE$"    F061    82EA             ; 833D (83D8)  Low
; "TERMINAL"  E883    82D2             ; 836D (8C88)  High
; "TRANSMIT"  E885    82D7             ; 8363 (89F5)  High
; "TAB"       F0BB    880D             ; Ignore has a real address
; "ZONE"      F0B4    82EB             ; 843D (83D8)  Low
; "INPUT#"    NNNN    82CE  (82ED)     ; 8337 (9660)  Low
; "PRINT#"    NNNN    82C9  (82EE)     ; 8335 (93D0)  Low 
; "PRINT#2"   NNNN    82CD  (82EF)     ; 8333 (93D4)  Low 
; "INIT"      NNNN    82B8  (82D0)     ; 8371 (880A)  High
MAIN_ENTRY/CLOAD:
82EC	EB 78 50 08         ORI     (OUTSTAT_REG),08            ; Bit_3 = ??, Bit_0 = DCD, Bit_1 = DSR

ME_FRM_LOW_BANK: ; Entry point from Low Bank
82F0	EB 78 55 08         ORI     (CR/LF_REG),08              ; Entry from low bank, set bit 3 in (CR/LF_REG)
82F4	FD 81               SIE                                 ; Enable interrupts. XL set to values for: 
82F6	FD 88               PSH     X                           ;   INIT=D0, INPUT#=ED,PRINT#=EE, PRINT#2=EF, MERGE=F0
82F8	BE 8A 2A            SJP     PORTS_UPDATE                ; Call sub(s) that configure CE-158
82FB	FD 2A               POP	    U                           ; Original X now in U
82FD	68 83               LDI	    UH,83                       ; Setting up pointer, UL is original XL: D0, ED, EE, EF, F0
82FF	FB                  SEC                                 ; Set Carry flag, for SBC below
8300	B5 D7               LDI	    A,D7                        ; Used to calculate offset into vector table
8302	20                  SBC	    UL                          ; A = A - UL. 
8303	6A 63               LDI	    UL,63                       ; U = 8363   
8305	83 08               BCS+    BRANCH_830F:                ; If UL > D7, skip ahead.
8307	FD 62               DEC	    UH                          ; DEC UH 83 -> 82, U = 8263
8309	FD BE               RIE                                 ; Disable interrupts
830B	E9 78 55 F7         ANI	    (CR/LF_REG),F7              ; (CR/LF_REG) = (CR/LF_REG) & F7. Clear Bit 3
                                                                ; Used as flag to swtich back to Low Bank

BRANCH_830F: ;Branched to by 8305.                              ; Calc index into Command Vector Table @ 8331
830F	D9                  SHL                                 ; A << 1: Before: A = INIT=07, A = INIT=A0
8310	FD EA               ADR	    U                           ; U = U + A. U-REG is pointer into vector table
8312	65                  LIN	    U                           ; A = (U) then INC U
8313	08                  STA	    XH                          ; XH = A. i.e. INIT A=88
8314	25                  LDA	    (U)                         ; A = (U). i.e. INIT A=0A
8315	0A                  STA	    XL                          ; X-REG now has address of function
8316	ED 78 55 08         BII	    (CR/LF_REG),08              ; FLAGS = (CR/LF_REG) & 08. Keep bit 3 only.
                                                                ;   This bit cleared in 830B above to signal Low Bank function
831A	8B 02               BZS+    BRANCH_831E                 ; If Bit 3 not set, we dropped through to 8307 so
                                                                ;   skip ahead to go back to Low Bank.
831C	FD 5E               STX     P                           ; P = X, Sets prg Cntr to jump to High Bank function ***JMP

BRANCH_831E: ; Branched to from 831A                            ; Go back to low bank to handle some functions
831E	68 7A               LDI	    UH,7A                       ; U = $7A28 =  AR-W
8320	6A 28               LDI	    UL,28                       ; 
8322	B5 E3               LDI	    A,E3                        ; Intialize $7A28-$7A31 to:
8324	61                  SIN     U                           ; $E3  $BA  $83 $05, which is
8325	B5 BA               LDI	    A,BA                        ; RPU  JMP  $8305
8327	61                  SIN     U                           ; 
8328	B5 83               LDI	    A,83                        ; This code segent sets PU to 
832A	61                  SIN     U                           ;   bank in lower half of the CE-158 ROM
832B	B5 05               LDI	    A,05                        ;
832D	2E                  STA	    (U)                         ; 
832E	BA 7A 28            JMP	    AR-W                        ; Jumps to $7A28, runs code segment poked in above



;------------------------------------------------------------------------------------------------------------
; Command Vector Table
; Used as a vector jump table by MAIN_ENTRY/CLOAD
; 813C Pokes value into program counter to jump to function/command handler
MERGE_VECTOR_8331:
8331	90 1C               .BYTE   90 1C                       ; 901C - MERGE - Low Bank

PRINT#2_VECTOR: 
8333	93 D4               .BYTE   93 D4                       ; 93D4 - PRINT#2 - Low Bank

PRINT#_VECTOR:  
8335	93 D0               .BYTE   93 D0                       ; 93D0 - PRINT# - Low Bank

INPUT#_VECTOR: 
8337	96 60               .BYTE   96 60                       ; 9660 - INPUT# - Low Bank

CLOAD_VECTOR_8339:                                            
8339	90 1B               .BYTE   90 1B                       ; 901B - CLOAD - Low Bank

UNKNOWN_VECTOR_833B:
833B	98 70               .BYTE   98 70                       ; 9870 -  Unknown

SPACE$_VECTOR_833D:
833D	83 D8               .BYTE   83 D8                       ; 83D8 - SPACE$ ZONE - Low Bank

RINKY$_VECTOR_833F:    
833F	83 57               .BYTE   83 57                       ; 8357-  RINKY$ - Low Bank

PROTOCOL_VECTOR_8341:
8341	83 17               .BYTE   83 17                       ; 8317 - PROTOCOL - Low Bank

PRINT_VECTOR_8343:
8343	90 0D               .BYTE   90 0D                       ; 900D - PRINT - Low Bank

OUTSTAT_VECTOR_8345:
8345	83 34               .BYTE   83 34                       ; 8334 - OUTSTAT - Low Bank

LLIST_VECTOR_8347:
8347	90 1D               .BYTE   90 1D                       ; 901D - LLIST - Low Bank

LPRINT_VECTOR_8349: 
8349	90 56               .BYTE   90 56                       ; 9056 - LPRINT - Low Bank

INSTAT_VECTOR_834B:
834B	83 2A               .BYTE   83 2A                       ; 832A - INSTAT - Low Bank

INPUT_VECTOR_834D:
834D	8F FF               .BYTE   8F FF                       ; 8FFF - INPUT - Low Bank

FEED_VECTOR_834F:
834F	98 20               .BYTE   98 20                       ; 9820 - FEED - Low Bank

ERL_VECTOR_8351: 
8351	83 09               .BYTE   83 09                       ; 8309 - ERL - Low Bank

ERN_VECTOR_8353:
8353	83 12               .BYTE   83 12                       ; 8312 - ERN - Low Bank

CONSOLE_VECTOR_8355: 
8355	83 65               .BYTE   83 65                       ; 8365 - CONSOLE - Low Bank

CSAVE_VECTOR_8357: 
8357	90 1A               .BYTE   90 1A                       ; 901A - CSAVE - Low Banks

UNKNOWN_VECTOR_8359: 
8359	98 70               .BYTE   98 70                       ; 9870-  is in SUB_9845

UNKNOWN_VECTOR_835B: 
835B	93 50               .BYTE   93 50                       ; 9350 - is in SUB_PRINT#

UNKNOWN_VECTOR_835D:  
835D	93 D8               .BYTE   93 D8                       ; 93D8 - inside SUB_PRINT#

FEED_DUP_835F: 
835F	98 20               .BYTE   98 20                       ; 9820 - FEED duplicate - Low Bank

CONSOLE_DUP_8361: 
8361	83 65               .BYTE   83 65                       ; 8365 - CONSOLE duplicate - Low Bank

TRANSMIT_8363:
8363	89 F5               .BYTE   89 F5                       ; 89F5 - TRANSMIT - High Bank

SETCOM_VECTOR_8365:                                             ; 
8365	89 07               .BYTE   89 07                       ; 8907 - SETCOM - High Bank

SETDEV_VECTOR_8367:                                             ; 
8367	89 68               .BYTE   89 68                       ; 8968 - SETDEV - High Bank

DEV$_VECTOR_8369:                                               ; 
8369	88 99               .BYTE   88 99                       ; 8899 - DEV$ - High Bank

COM$_VECTOR_836B:                                               ; 
836B	88 93               .BYTE   88 93                       ; 8893 - COM$ - High Bank

TERMINAL_VECTOR_836D:                                           ; 
836D	8C 88               .BYTE   8C 88                       ; 8C88 - Terminal - High Bank

DTE_VECTOR_836F:                                                ; 
836F	8C 8E               .BYTE   8C 8E                       ; 8C8E - DTE - High Bank

INIT_VECTOR: 
8371	88 0A               .BYTE   88 0A                       ; 880A - Points to 8800 BASIC Table Init code

;------------------------------------------------------------------------------------------------------------
; FF 00 ... used to fill unused addresses
SEPARATOR_8373:
8373	FF 00 FF 00         .BYTE  FF 00 FF 00                  ;
8877    FF 00 FF 00         .BYTE  FF 00 FF 00                  ;
887B    FF 00 FF 00         .BYTE  FF 00 FF 00                  ;
887F    FF                  .BYTE  FF                           ;



;-------------------------------------------------------------------------------------------------------------
; JMP_8380 - Jumped to from SUB_8D04:8E52, jumps back to SUB_8D04:8E55
; If Japanese market A = UL. If SETCOM configured for 7 Data Bits then A = 0A
; Arguments: UL
; Output: UL = 02 or 0A
; RegMod: A, UL
8380	ED 78 55 80         BII	    (CR/LF_REG),80              ; Not sure what this register does
8384	8B 17               BZS+    BRANCH_839D                 ; If Bit 7 was set
8386	FD ED F0 0F 08      BII     #(PC1500_PRT_B),08          ; Test Bit 3. (ME1)
838B	89 10               BZR+    BRANCH_839D                 ; If PC-1500 Export model. (Vcc export, Gnd Japanese)
838D	A5 78 BE            LDA	    (DATA_PTR_H)                ; Normally used for DATA statement pointer
8390	89 0B               BZR+    BRANCH_839D                 ; If A > 0 branch fwd
8392	A5 78 58            LDA	    (SETCOM_REG)                ; Bits 3,4 are Word Length
8395	B9 18               ANI	    A,18                        ; Keep Bits 3-4
8397	B7 10               CPI	    A,10                        ; Only Bit 4 set = 7 data bits
8399	89 02               BZR+    BRANCH_839D                 ; If A != 10, i.e. 7 data bits, branch fwd
839B	6A 0A               LDI	    UL,0A                       ; If 7 Data Bits

BRANCH_839D: ; Branched to from 8384, 838B, 8390, 8399
839D	24                  LDA	    UL                          ; Jump directly here if PC-1500 export model
839E	AE 78 B0            STA	    (BRK_TOP_H)                 ; Beginning of program containing BREAK line
83A1	BA 8E 55            JMP	    JMP_8E55                    ; Jumping back into SUB_8D04



;-------------------------------------------------------------------------------------------------------------
; CE-158_IOREG_INIT - Used in MAIN_ENTRY2:BRANCH_8A93 
; Copied to D00F-D008 (Reverse order) to inialize CE-158 lh5801 I/O registers
CE-158_IOREG_INIT:
83B0	FF FF 7F 03 00 00 00 A0 00  



;-------------------------------------------------------------------------------------------------------------
; CE-158_IO-REG_INIT2 - Used in SUB_9F75
CE-158_IO-REG_INIT2:
83B8	00 0D 18 00 00 



;-------------------------------------------------------------------------------------------------------------
; UNKNOWN_83BD -  Not sure where used
UNKNOWN_83BD:
83BD	4F 00 7F 



;------------------------------------------------------------------------------------------------------------
; TBL_BAUD - Used to convert Baud rate settings in SETCOM to ASCII (I think)
; Used by 8ADC, 8C4B
TBL_BAUD:                    ;C7                       ;CF
83C0	00 32 00 64 00 6E 00 C8   01 2C 02 58 04 B0 09 60 

TBL_CDP1854ACE_BAUD:
83D0	99 0D 85 0A 09 85 18 0B



;-------------------------------------------------------------------------------------------------------------
; TBL_SETDEV_TEXT - SETDEV Commnand text
; Used by 88CB, 8981
TBL_SETDEV_TEXT:
83D8    4B 49 01            .BYTE 4B 49 01                      ; KI,  1 = Bit 0 in SETDEV
83DB    44 4F 02            .BYTE 44 4F 02                      ; DO,  2 = Bit 1 in SETDEV
83DE    50 4F 04            .BYTE 50 4F 04                      ; PO,  4 = Bit 2 in SETDEV
83E1	43 49 08            .BYTE 43 49 08                      ; CI,  8 = Bit 3 in SETDEV
83E4    43 4F 10            .BYTE 43 4F 10                      ; CO, 10 = Bit 4 in SETDEV



;------------------------------------------------------------------------------------------------------------
; TBL_CDP1854ACE_CFG - CDP1854ACE UART configuration data for Parity, Stop, Word Length
; Used by 8B99
TBL_CDP1854ACE_CFG:
83E7	42 52 62 72 82 92 A2 B2   46 56 66 76 C6 D6 E6 F6 
83F7	4A 5A 6A 7A CA DA EA FA   4E 5E 6E 7E CE DE EE FE 
8407	89 8D 89 89 81 85 81 81   89 8D 89 89 81 85 81 81 
8417	89 8D 89 89 81 8D 81 81   95 9D 95 99 91 91 91 



;------------------------------------------------------------------------------------------------------------
; 84E7~84EE unknown table. Used by SUB_9A9E_ALT1 copies bytes into 7A00 (AR-X)
TBL_8475:
8475	00 0B 07 00 00 00 7F 41   41 00 02 04 08 10 20 00 
8485	41 41 7F 00 04 02 7F 02   04 08 1C 2A 08 08 00 00 
8495	07 0B 00 06 27 03 2E 02   32 03 35 04 39 05 3E 05 
84A5	44 08 4A 03 53 07 57 15   5F 00 FF 

84B0	19 85 7F 17 85 3F 0A 85   67 0C 85 72 0D 85 B8 04 
84C0	84 EF 05 84 F4 08 85 57   0A 85 A6 06 85 B1 0C 85 
84D0	99 0D 85 0A 09 85 18 0B   85 29 06 85 22 09 85 35 
84E0	0F 84 FA 17 85 C6 18 85   DE 14 85 F7 17 86 0C 



;------------------------------------------------------------------------------------------------------------
; TEXT_84EF - Text for Terminal program menus?
; Used by 870B
TEXT_84EF:
84EF    45 43 48 4F 20      .TEXT "ECHO "
84F4    54 52 41 43 45 20   .TEXT "TRACE "
84FA    43 48 41 4E 47 45   
84FF    20                  .TEXT "CHANGE "
8500    41 55 54 4F 20      .TEXT "AUTO "
8506    53 49 47 4E 42 55 
850C    46 46 45 52 20      .TEXT "SIGNBUFFER "
8511    4C 45 4E 47 54 48
8517    3D 42 41 55 44 20   .TEXT "LENGTH=BAUD "
851D    52 41 54 45 3D 50 
8523    41 52 49 54 59 3D 
8529    57 4F 52 44 20      .TEXT "RATE=PARITY=WORD "
852E    4C 45 4E 47 54 48 
8534    3D 53 54 4F 50 20   .TEXT "LENGTH=STOP "
853A    42 49 54 53 3D 53 
8541    65 74 75 70 3A 20 
8547    20 20 20 20 20 20   .TEXT "BITS=Setup:       "
854C    41 75 74 20         .TEXT "Aut "
8550    46 6E 63 20         .TEXT "Fnc "
8554    43 6F 6D 58 4F 4E 
855A    2F 58 4F 46 46      .TEXT "ComXON/XOFF  "
8561    3F 28 59 2F 4E 29
8567    4C 4F 57 20         .TEXT "?(Y/N)LOW "
8567    42 41 54 54 45 52 
856D    59 53 45 54 54 49   
8573    4E 47 20            .TEXT "BATTERYSETTING "
857A    45 52 52 4F 52 2D 
8580    2D 2D 45 4E 54 45 
8586    52 20               .TEXT "ERROR---ENTER "
8588    4D 45 4E 55 20      .TEXT "MENU "
858D    53 45 4C 45 43 54 
8593    49 4F 4E 20         .TEXT "SELECTION "
8597    2E 2E 45 58 54 2E 
859D    20                  .TEXT "..EXT. "
859E    50 52 49 4E 54 45 
85A4    52 20               .TEXT "PRINTER "
85A6    43 4C 45 41 4E 20   .TEXT "CLEAN "
85AC    54 45 58 54 20      .TEXT "TEXT "
85B1    43 4C 3D 45 54 58
85B7    20                  .TEXT "CL=ETX "
85B8    4C 50 52 49 4E 54 
85BF    52 20               .TEXT "LPRINTER "
85C1    45 52 52 30 52 4F
85C7    70 65 72 61 74 65 
85CD    3A 20 20 20 20 20   .TEXT "ERR0ROperate:     "
85D3    4E 72 6D 20         .TEXT "Nrm "
85D7    41 2F 50 20         .TEXT "A/P "
85DB    41 2F 4C 54 65 72 
85E2    6D 69 6E 61 6C 3A   
85E8    20 20 20 20         .TEXT "A/LTerminal:    "
85EB    45 6E 74 20         .TEXT "Ent Aut "
85F3    41 75 74 20 51 75 
85F9    69 74 50 72 6F 74 
85FF    6F 63 6F 6C 3A 20 
8601    20 20               .TEXT "QuitProtocol:   "
8603    58 4F 2F 4F 20      .TEXT "XO/O "
8608    45 63 68 6F 4F 75 
860E    74 70 75 74 3A 20 
8614    20                  .TEXT "EchoOutput:  "
8615    45 78 74 20         .TEXT "Ext "
8619    54 72 63 20         .TEXT "Trc "
861D    44 73 70 20         .TEXT "Dsp "


8621	45 74 78                                                ; Etx - not sure what this is

;------------------------------------------------------------------------------------------------------------
; SEPARATOR_8624 - FF 00 ... used to fill unused addresses
SEPARATOR_8624:
8624	00 FF 00 FF         .BYTE  00 FF 00 FF                  ;
8628    00 FF 00 FF         .BYTE  00 FF 00 FF                  ;   
862C    00 FF 00 FF         .BYTE  00 FF 00 FF                  ;
8630    00 FF 00 FF         .BYTE  00 FF 00 FF                  ;
8634	00                  .BYTE  00                           ;



;------------------------------------------------------------------------------------------------------------
; TEXT_8635 - More text for Termainal program?
; Used by SUB_95C6
TEXT_8635:
8635    58 4F 2F 4F 20      .TEXT "XO/O "                       ;
863A    42 6B 73 20         .TEXT "Bks "                        ;
863A    50 72 74 20         .TEXT "Prt "                        ;
8642    53 70 63 6C 20      .TEXT "Spcl "                       ;
8647    45 73 63 20         .TEXT "Esc "                        ;
864B    43 74 6C 20 20 20
8652    20 20 20 20 20 20
8658    20 20 20 20 20      .TEXT "Ctl              "           ;
865C    4E 72 6D 20         .TEXT "Nrm "                        ;
8660    41 2F 50 20         .TEXT "A/P "                        ;
8664    41 2F 4C 20 20      .TEXT "A/L  "                       ;



;------------------------------------------------------------------------------------------------------------
; USING_M_INT_TBL_8669 - 
; Used by 906A
USING_M_INT_TBL_8669:
8669	30 41 42 43 7F 1E 7C 7E   7B 5D 7D 60 5C 4D 4E 5E 
8679	5F 1C 1F 53 27 5B 56 1D   58 59 5A



;------------------------------------------------------------------------------------------------------------
; SUB_7A50_1 and SUB_7A50_2
; Either one is poked into 7A50 by SUB_9976, this code is called by 933F
SUB_7A50_1_HDR:
8684	19                 .BYTE   19                           ; UL #loops, 19-0, i.e. 20 total
8685	88                 .BYTE   88                           ; XL of address to copy from, i.e. 8688

SUB_7A50_2_HDR:
8686	43                 .BYTE   43                           ; UL #loops, 43-0, i.e. 44 total
8687	A2                 .BYTE   A2                           ; XL of address to copy from, i.e. 86A2 

; Arguments - Y, UH
SUB_7A50_1:
8688	FD BE              RIE                                  ; (7A50) Disable interrupts
868A	B8                 SPV                                  ; (7A52) Set PV, bank in CE-158
868B	A4                 LDA	    UH                          ; (7A53) A = UH = 20
868C	BE EE 48           SJP      EE48                        ; (7A54) EE48 - Determines for characters from the accumulator address in the character set table
868F	FD 18              LDX	    Y                           ; (7A57) X = Y. Y set by EE48
8691	5A 00              LDI	    YL,00                       ; (7A59) 
8693	58 7A              LDI	    YH,7A                       ; (7A5B) Y = 7A00, X = ?
8695	F5                 TIN                                  ; (7A5D) Y = 7A00 -> 7A01 (Y) = (X) then X += 1, Y += 1
8696	F5                 TIN                                  ; (7A5E) Y = 7A01 -> 7A02
8697	F5                 TIN                                  ; (7A5F) Y = 7A02 -> 7A03
8698	F5                 TIN                                  ; (7A60) Y = 7A04 -> 7A05
8699	F5                 TIN                                  ; (7A61) Y = 7A06 -> 7A07
869A	A8                 RPV                                  ; (7A62) Bank out CE-158
869B	FD 81              RIE                                  ; (7A63) Enable interrupts
869D	59 00              ANI     (Y),00                       ; (7A65) Y = 7A07. (Y) = (Y) & 00, clear (Y)
869F	FD 18              LDX	    Y                           ; (7A67) X = Y
86A1	9A                 RTN                                  ; (7A69) 


;------------------------------------------------------------------------------------------------------------
; SUB_7A50_2 - Poked into 7A50 by SUB_9976
; Something to do with printing on CE-150
SUB_7A50_2:
86A2	B8                  RPV                                 ; (7A50) Reset PV Banks out CE-158, banks in CE-150
86A3	FD BE               RIE                                 ; (7A51) Disable interrupts
86A5	89 16               BZR+    BRANCH_7A87                 ; (7A53) What set Z before getting here?
86A7	ED 78 56 40         BII	    (ZONE_REG),40               ; (7A55) 
86AB	89 0B               BZR+    BRANCH_7A67                 ; (7A59) If Bit 6 was set branch Fwd
86AD	ED 78 56 20         BII	    (ZONE_REG),20               ; (7A5B) 
86B1	8B 25               BZS+    BRANCH_7A87                 ; (7A60) If Bit 5 was set branch Fwd
86B3	BE A9 CB            SJP     A9CB                        ; (7A62) CE-150 something
86B6	8E 14               BCH+    BRANCH_7A7B                 ; (7A65) Unconditional branch fwd

BRANCH_7A67: ; Branched to from 86AB
86B8	BE A9 F1            SJP     A9F1                        ; (7A67) CR with line feed added
86BB	8E 17               BCH+    BRANCH_7A83                 ; (7A6A) Unconditional branch fwd

BRANCH_86BD: ; Branched to from 86A5
86BD	ED 78 56 40         BII	    (ZONE_REG),40               ; (7A6C)
86C1	89 0E               BZR+    BRANCH_7A80                 ; (7A70) If Bit 6 was set branch Fwd
86C3	ED 78 56 20         BII	    (ZONE_REG),20               ; (7A72)
86C7	8B 0F               BZS+    BRANCH_7A87                 ; (7A76) If Bit 5 was set branch Fwd
86C9	BE A7 5B            SJP     A75B                        ; (7A78) CE-150 something

BRANCH_7A7B: ; Branched to from 86B6
86CC	BE A7 47            SJP     A747                        ; (7A7B) CE-150 something
86CF	8E 06               BCH+    BRANCH_7A86                 ; (7A7E)

BRANCH_7A80: ; Branched to from 86C1
86D1	BE A7 81            SJP     A781                        ; (7A80) CE150 Print, send ASCII character to printer (no LF)

BRANCH_7A83: ; Branched to from 86BB
86D4	BE A7 69            SJP     A769                        ; (7A83) CE150 Printer motor OFF

BRANCH_7A86: ; Branched to from 86CF
86D7	A8                  SPV                                 ; (7A86) Set PV, bank back in CE-158

BRANCH_7A87: ; Branched to from 86B1, 86C7
86D8	ED 76 4E 01         BII	    (HIGHLCDFLAG),01            ; (7A87) Bit 0 (Busy) anunciator
86DC	89 05               BZR+    BRANCH_7A92                 ; (7A8B) If Busy set skip ahead
86DE	FD E9 B0 0A FD      ANI     #(CE150_MSK_REG),FD         ; (7A8D) Clear Bit 1, PB7 Interrupt (Paper feed swtich)

BRANCH_7A92: ; Branched to from 86DC
86E3	FD 81               SIE                                 ; (7A92) Enable interrupts
86E5	9A                  RTN                                 ; (7A94)



;------------------------------------------------------------------------------------------------------------
; UNKNOWN_8636 - Not text or sensible code
UNKNOWN_8636:
86E6	5E 30 2B 19 11 09 05 03   00 FF 
       


;------------------------------------------------------------------------------------------------------------
; SUB_86F0 - Called from 8BD4 ***
; Alt entry 86F6 - Called from 8AB9
; Calculates a new address to set P to (Program Counter) and it is poked into P.
; Arguments: U = ?, A
; Output:
; RegMod: U, A, X
SUB_86F0: ; Called from 8F7C
86F0	A5 78 B6            LDA	    (ERROR_TOP_H)               ; Begining address of ERROR line?
86F3	FB                  SEC                                 ; Set Carry Flag
86F4	B1 0A               SBI	    A,0A                        ; A = A - 0A

SUB_86F0_ALT_E1: ; Called from 8AB9 A >= 16 A < 0A
86F6	D5                  SHR                                 ; A = A > 1. Through Carry, 0 into LSB
86F7	FD 2A               POP	    U                           ; Where is U or ? pushed to stack?
86F9	FD C8               PSH	    A                           ; Save A. What is in A?
86FB	65                  LIN	    U                           ; A = (U), then INC U
86FC	FD 28               LDX	    U                           ; X = U (X = original U + 1)
86FE	FD EA               ADR	    U                           ; U = U + A. (U = oringal U + 1 + A)
8700	FD 8A               POP	    A                           ; Get original A back
8702	FD A8               PSH	    U                           ; Save U. (U = oringal U + 1 + A)
8704	FD CA               ADR	    X                           ; X = X + A. (X = original U + 1 + original A)
8706	45                  LIN	    X                           ; A = (X), then INC X. A = (original U + 1 + original A)
8707	FD CA               ADR	    X                           ; X = X + A. (original U + 1 + original A) += A
8709	FD 5E               STX	    P                           ; P = X. Set Program Counter to X ***JMP



;------------------------------------------------------------------------------------------------------------
; TERMTXT_2INBUF - Called from 873A
; Copies text string from TEXT_84EF (Terminal menu text) to Input Buffer (7BB0)
; Arguments: A = multiple of 2, string index
; Outputs:
; RegMod: A, X, Y, U
TERMTXT_2INBUF:
870B	5A B0               LDI	    YL,B0                       ; (Y)=7BB0, INPUT BUFFER Byte 0 START
870D	58 7B               LDI	    YH,7B                       ; Setting up pointer?
870F	4A B0               LDI	    XL,B0                       ; (X)=84B0, inside text @ TEXT_84EF
8711	48 84               LDI	    XH,84                       ; Setting up pointer?
8713	B7 22               CPI	    A,22                        ; A is index into text table.
8715	81 0C               BCR+    BRANCH_8723                 ; Branch fwd if A < 22
8717	B7 2E               CPI	    A,2E                        ; 
8719	83 06               BCS+    BRANCH_8721                 ; Branch fwd if A >= 2E
871B	4A FA               LDI	    XL,FA                       ; X = 84FA ( A >= 22 and A < 2E )
871D	6A 06               LDI	    UL,06                       ; U = loop counter, 7 bytes to copy
871F	8E 11               BCH+    BRANCH_8732                 ; Branch fwd unconditional 

BRANCH_8721: ; A >= 2E
8721	B1 0C               SBI	    A,0C                        ; A = A - 0C, A = 22~F3
                                                                ;
BRANCH_8723: ; A < 22                                           ; A = 0~F3.  A must be an even number.  If A = 0. 
8725	D5                  SHR                                 ; A = A >> 1.                           A = A / 2. 
8726	FD CA               ADR	    X                           ; X= X + A.                             X = 84B0 + 0 = 84B0.
8728	45                  LIN	    X                           ; A = (X) then INC X.                   A = (84B0) = 19
8729	2A                  STA	    UL                          ;                                       UL = 19. Copy 20 bytes
872A	45                  LIN	    X                           ; A = (X) then INC X.                   A = (84B1) = 85
872B	FD C8               PSH	    A                           ; Save A
872D	05                  LDA	    (X)                         ; A = (X).                              A = (84B2) = 7F.
872E	0A                  STA     XL                          ;                                       X = 7F
872F	FD 8A               POP	    A                           ;                                       A = 85
8731	08                  STA	    XH                          ;                                       X = 857F

BRANCH_8732: ; A >= 22 and A < 2E                               ; (7BB0) = (84FA)...84FA starts with 'CHANGE '
8732	F5                  TIN                                 ; (Y) = (X) then X = X + 1, Y = Y + 1         
8733	88 03               LOP	    UL,BRANCH_8732              ; UL = UL - 1, loop back 'e' if Borrow Flag not set
8735	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; TERMTXT_DISP -  Jumped to from 8D45, 8D6D. A = 2E, 02, 30, 32, 40
; Calls TERMTXT_2INBUF Copies text string from TEXT_84EF to Input Buffer (7BB0)
; Then jumps to PRGMDISP (E8CA) to display content of display buffer
; Arguments: A = multiple of 2, string index
; Output:
; RegMod:
TERMTXT_DISP:
8736	E9 78 80 00         ANI	    (7880),00                   ; Reset Display parameter, i.e. how display looks @ READY
873A	BE 87 0B            SJP	    TERMTXT_2INBUF              ; Copies text string from TEXT_84EF to Input Buffer (7BB0)
                                                                ; A = String index
873D	FD C1               SDP                                 ; Sets LCD ON/OFF control flip-flop
873F	BA E8 CA            JMP	    PRGMDISP                    ; Displays contents of display buffer on LCD



;------------------------------------------------------------------------------------------------------------
; These two lines may not be used. 8701 is not a good branch address
8742	F5                  TIN                                 ; (Y) = (X) then X = X + 1, Y = Y + 1
8743	88 44               LOP	    UL,8701                     ; UL = UL - 1, loop back e if Borrow Flag not set



;------------------------------------------------------------------------------------------------------------
; STRNG_2COM - Called from SUB_8D04:8E87
; Sends string to RS232. REG-X holds string, space $20, delimited
; Arguments: X set to first character of string
; Output:
; RegMod: X, UL, A
BRANCH_8744: ; Branched to from 875E
8744	44                  INC	    X                           ; INC to next charecter

STRNG_2COM:
8745	FD BE               RIE                                 ; Disable interrupts
8747	6A 1F               LDI	    UL,1F                       ; Max of 32 tries to send.

BRANCH_8749: ; Branched to from 8760, 8766
8749	05                  LDA	    (X)                         ; A = (X)
874A	BF E0               BII	    A,E0                        ; FLAGS = (X) & E0. Keep bits 7-5
874C	8B 1A               BZS+    BRANCH_8768                 ; If no Bits 7-5 set, < 20, branch fwd
874E	B7 40               CPI	    A,40                        ; '('?
8750	89 02               BZR+    BRANCH_8754                 ; If A != 40 branch
8752	B5 0D               LDI	    A,0D                        ; A = 0D = CR

BRANCH_8754: ; Branched to from 8750
8754	FD ED F0 0B 02      BII	    #(PC1500_IF_REG),02         ; PC-1500 - PB7 Interrupt, PB7 = ON key
8759	89 0D               BZR+    BRANCH_8768                 ;  If ON key pressed
875B	BE 81 BC            SJP	    CHAR2COM                    ; Sends charecter in A to RS232 Port
875E	91 1C               BCR-    BRANCH_8744                 ;  Carry clear = success, send next charecter
8760	9B 19               BZS-    BRANCH_8749                 ;  retry same charecter, Z set when U popped off stack in sub
8762	BF 20               BII	    A,20                        ;  returns A = #(PRT_A_IO) Bits 5-2 on failure
8764	89 02               BZR+    BRANCH_8768                 ; If A != 20, If not Low Battery, carry set by CHAR2COM
8766	88 1F               LOP	    UL,BRANCH_8749              ; UL = UL - 1, loop back 'e' if Borrow Flag not set, DEC try counter

BRANCH_8768: ; Branched to from 874C, 8759, 8764
8768	F9                  REC                                 ; REC = success
8769	FD 81               SIE                                 ; Enable interrupts.
876B	9A                  RTN                                 ; 



;------------------------------------------------------------------------------------------------------------
; IRQ_RESET - Called from  SUB_8D04:8EC3
; Alt Entry at 8780 Called from SUB_8D04:8E7B
; Resets IRQ masks for PC-1500, CE-150, CE-158. 
; Resets CE-150 PB7 mask (Paper feed button), CE-158 DTR, RTS
; Arguments:
; Output:
; RegMod:
IRQ_RESET:
876C	FD EB D0 0A 01      ORI     #(CE158_MSK_REG),01         ; CE-158 - Set Bit 0, Interrupt mask for IRQ
8771	FD E9 B0 0A FD      ANI	    #(CE150_MSK_REG),FD         ; CE-150 - Clear Bit 1, PB7 Interrupt mask. Paper Feed Button
8776	FD EB B0 0A 01      ORI	    #(CE150_MSK_REG),01         ; CE-150 - Set Bit 0. Interrupt mask for IRQ
877B	FD EB F0 0A 01      ORI	    #(PC1500_MSK_REG),01        ; PC-1500 - Set Bit 0. Interrupt mask for IRQ

IRQ_RESET_ALT_E1:
8780	FD E9 D0 0E FC      ANI     #(CE158_PRT_A),FC           ; Clear Bits 1-0 (ME1) Bit 0 = DTR, Bit 1 = RTS
8785	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; JMP_8790 - Jumped to from 8AC3 ***
; Seems to shuffle around BASIC line numbers, maybe for editing?
; Arguments: Y, X
; Output:
; RegMod: U, X
JMP_8790:
8790	6A 50               LDI	    UL,50                       ;
8792	BE D1 4F            SJP	    BCD_Y2ARX                   ; Pass BCD number pointed to by Y-Reg to AR-X
8795	42                  DEC	    XL                          ;
8796	8E 02               BCH+    BRANCH_879A                 ; Unconditional fwd branch
8798	DE 3E               VEJ     (DE),BRANCH_87D8            ; Evaluate formula pointed to by Y-REG,
                                                                ; passes result to AR-X. Jump FWD (n) if error
BRANCH_879A: ; Branched to from 8796, 87A1
879A	D0 03 3B            VEJ     (D0),03,BRANCH_87D8         ; Convert AR-X to integer pass to U. 
                                                                ; 03 specifies range. If exceeded branch fwd
879D	6C 02               CPI	    UH,02                       ; 
879F	81 35               BCR+    BRANCH_87D6                 ; If UH < 2 branch fwd
87A1	C8 37               VEJ     (C8),BRANCH_87DA            ; If the following character does not represent end 
                                                                ; the command sequence or line. C=1 if ":" 

SUB_87A3: ; Called from 8BC3
87A3	F4 78 99            VEJ	    (F4),(VAR_START_H)          ; Loads U with pointer to where variables start in RAM
87A6	CC 67               VEJ     (CC),67                     ; Loads X-Reg with address at 78(67) 78(68)
                                                                ; 7867/68 = End address of basic in RAM
87A8	BE DF E2            SJP	    U_MINUS_X                   ; U = U - X. When upper limit occurs: C=0 and UH=16 
87AB	81 29               BCR+    BRANCH_87D6                 ; Branch fwd if Carry reset (If error?)
87AD	4A 3A               LDI	    XL,3A                       ; 
87AF	48 00               LDI	    XH,00                       ; X = 003A
87B1	BE DF E2            SJP	    U_MINUS_X                   ; U = U - X. When upper limit occurs: C=0 and UH=16 
87B4	81 20               BCR+    BRANCH_87D6                 ; Branch fwd if Carry reset (If error?)
87B6	FD 28               LDX	    U                           ; X = U
87B8	F4 7A 05            VEJ	    (F4),(ARX+5)                ; Loads U with 16-bit value from address in AR-X
87BB	BE DF E2            SJP	    U_MINUS_X                   ; U = U - X, When upper limit occurs: C=0 and UH=16 
87BE	83 16               BCS+    BRANCH_87D6                 ; Branch fwd if Carry set (If error?)
87C0	CC 67               VEJ     (CC),67                     ; Loads X-Reg with address at 78(pp) 78(pp+1)
                                                                ; 7867/68 = End address of basic in RAM
87C2	44                  INC	    X                           ; 
87C3	CA A0               VEJ	    (CA)(A0)                    ;  PREVIOUS ADDRESS
87C5	F4 7A 05            VEJ	    (F4),(ARX+5)                ; Loads U with 16-bit value from address in AR-X
87C8	F6 78 A2            VEJ	    (F6),(PREV_LINE_H)          ; Saves U to (PREV_LINE_H)
87CB	CC 67               VEJ     (CC),67                     ; 7867/68 = End address of basic in RAM
87CD	24                  LDA	    UL                          ;
87CE	02                  ADC	    XL                          ;
87CF	0A                  STA	    XL                          ; XL = UL + XL
87D0	A4                  LDA	    UH                          ;
87D1	82                  ADC	    XH                          ;
87D2	08                  STA	    XH                          ; XH = UH + XH
87D3	CA A4               VEJ	    (CA),(A4)                   ; Transfers X to 78(A4), 78(A4), PREVIOUS TOP
87D5	9A                  RTN                                 ; Return

BRANCH_87D6: ; Branched to from 879F, 87AB, 87B4, 87BE
87D6	68 33               LDI	    UH,33                       ;  Got here if error occured

BRANCH_87D8: ; Branched to from 87DA
87D8	FB                  SEC                                 ; Set Carry Flag = failure
87D9	9A                  RTN                                 ; Return

BRANCH_87DA: ; Branched to from 87A1
87DA	68 01               LDI	    UH,01                       ; Failure code?
87DC	FB                  SEC                                 ; Set Carry Flag  = failure
87DD	9A                  RTN                                 ; Return



;------------------------------------------------------------------------------------------------------------
; NULL2COM
; Sends a 00 (NULL) to RS232 if SETDEV_REG Bit 6 is set (CO)?
; Arguments:
; Output:
; RegMod: UL, A
NULL2COM:
87DE	ED 78 57 40         BII	    (SETDEV_REG),40             ; Test Bit 6 in SETDEV_REG. Bit 6 for CO?
87E2	8B 0D               BZS+    BRANCH_87F1                 ; Branch fwd if Bit 6 not set
87E4	6A 0F               LDI     UL,0F                       ; Try counter
87E6	FD BE               RIE                                 ; Disable interrupts

BRANCH_87E8: ; Branched to from 87EF
87E8	B5 00               LDI	    A,00                        ; Charecter to send
87EA	BE 81 BC            SJP	    CHAR2COM                    ; Sends charecter in A to RS232 Port
87ED	81 02               BCR+    BRANCH_87F1                 ; Branch fwd if Carry reset, Carry clear = success
87EF	88 09               LOP	    UL,BRANCH_87E8              ; UL = UL - 1, loop back 'e' if Borrow Flag not set

BRANCH_87F1:
87F1	FD 81               SIE                                 ; Enable Interrupts
87F3	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; SEPARATOR_87F4 - FF 00 ... used to fill unused addresses
SEPARATOR_87F4:
87F4	00 FF 00 FF        .BYTE 00 FF 00 FF                    ; Unused
87F8    00 FB 00 FF        .BYTE 00 FF 00 FF                    ;
87FB    00 FF 00 DF        .BYTE 00 FF 00 DF                    ;



;------------------------------------------------------------------------------------------------------------
; BASIC Table 8800 - (First table at 8000)
B_TBL_8800:
8800	55                  .BYTE   55                          ; Marker that BASIC Table follows 

B_TBL_8800_TNUM:
8801	08                  .BYTE   08                          ; Table number

B_TBL_8800_NAME:
8802	43 4F 4D 0D         .TEXT   "LPRT\r\r\r\r"              ; Table name
8806    0D 0D 0D 0D 

B_TBL_8800_INIT:
880A    68 01               LDI     UH,01                       ; Table initilization vector
880C    9A                  RTN

B_TBL_8000_TAB:
B_TBL_8000_TAB2:
B_TBL_8800_INPUT#:
880D	68 1B               LDI	    UH,1B                       ; Table INPUT# vector (Jumps to MERGE)
880F    E0                  VEJ     (E0)                        ; Is UH "00" error message

B_TBL_8800_PRINT#:
8810	BA 82 CD            JMP	    82CD                        ; Table PRINT# vector (Jumps to MERGE)

B_TBL_8800_JMPS:
8813	9A 9A 9A 9A         .BYTE 9A 9A 9A 9A                   ; 
8017    9A 9A 9A 9A         .BYTE 9A 9A 9A 9A                   ;
8821    9A BA               .BYTE 9A BA                         ; Unused jumps

B_TBL_8800_TRACE:
881D	C4 AF FF            VEJ     (C4),AF,811F                ; Correct per book. Not used?

B_TBL_8800_A_KW:
8820	00 00               .BYTE   00 00                       ;

B_TBL_8800_B_KW:
8822	00 00               .BYTE   00 00                       ;

B_TBL_8800_C_KW:
8824	88 56               .BYTE   88 56                       ; 8856

B_TBL_8800_D_KW:
8826	00 00               .BYTE   00 00                       ;   

B_TBL_8800_E_KW:
8828	00 00               .BYTE   00 00 

B_TBL_8800_F_KW:
882A	80 62               .BYTE   80 62 

B_TBL_8800_G_KW:
882C	00 00               .BYTE   00 00  

B_TBL_8800_H_KW:
882E	00 00               .BYTE   00 00 

B_TBL_8800_I_KW:
8830	00 00               .BYTE   00 00 

B_TBL_8800_J_KW:
8832	00 00               .BYTE   00 00  

B_TBL_8800_K_KW:
8834	00 00               .BYTE   00 00  

B_TBL_8800_L_KW:
8836	88 6B               .BYTE   88 6B 

B_TBL_8800_M_KW:
8838	00 00               .BYTE   00 00 

B_TBL_8800_N_KW:
883A	00 00               .BYTE   00 00 

B_TBL_8800_O_KW:
883C	00 00               .BYTE   00 00 

B_TBL_8800_P_KW:
883E	00 00               .BYTE   00 00 

B_TBL_8800_Q_KW:
8840	00 00               .BYTE   00 00 

B_TBL_8800_R_KW:
8842	00 00               .BYTE   00 00

B_TBL_8800_S_KW:
8844	00 00               .BYTE   00 00 

B_TBL_8800_T_KW:
8846	88 80               .BYTE   88 80 

B_TBL_8800_U_KW:
8848	00 00               .BYTE   00 00

B_TBL_8800_V_KW:
884A	00 00               .BYTE   00 00 

B_TBL_8800_W_KW:
884C	00 00               .BYTE   00 00

B_TBL_8800_X_KW:
884E	00 00               .BYTE   00 00  

B_TBL_8800_Y_KW:
8850	00 00               .BYTE   00 00 

B_TBL_8800_Z_KW:
8852	00 00               .BYTE   00 00

;Add   Ctrl Name         Token Vector
B_TBL_8800_CMD_LST:
8854	D7 "CONSOLE"      F0B1 82D8 
8860	D4 "FEED"         F0B0 82D9 
8869	D6 "LPRINT"       F0B9 82DA 
8874	C5 "LLIST"        F0B8 82DB 
887E	D3 "TAB"          F0BB 880D 

B_TBL_8800_CMD_LST_END:
8886	D0                .BYTE D0                              ; Why two D0s here and one in 8000 command list?

;------------------------------------------------------------------------------------------------------------
; SEPARATOR_8887 - FF 00 ... used to fill unused addresses
SEPARATOR_8887:
8887	D0 00 FF 00        .BYTE D0 00 FF 00                    ; Unused
888B    FF 00 FF 00        .BYTE FF 00 FF 00                    ;
888F    FF 00 FF 00        .BYTE FF 00 FF 00                    ;



;------------------------------------------------------------------------------------------------------------
; COM$ - Called from Command Vector Table at $8831
; Arguments:
; Output:
; RegMod:
COM$:
8893	E9 78 82 00         ANI	    (STK_PTR_GSB/FOR),00        ; Clear Stack pointer for GOSUB and FOR
                                                                ; Perhaps used as mode switch?
8897	8E 04               BCH+    BRANCH_889D                 ; Unconditional branch fwd



;------------------------------------------------------------------------------------------------------------
; DEV$ - Called from Command Vector Table at $8331
; Converts SETDEV and SETCOM settings into ASCII
; Then it pokes in either 'RPU, RTN' or just 'RTN' to 7A30 and calls it. 
; Arguments:
; Output:
; RegMod: Y, U, A
DEV$:
8899	EB 78 82 FF         ORI	    (STK_PTR_GSB/FOR),FF        ; Set Stack pointer for GOSUB and FOR to $FF
                                                                ; Perhaps used as mode switch?

BRANCH_889D: ; Branched from COM$
889D	5A 2E               LDI	    YL,2E                       ; Set up pointer?
889F	58 7A               LDI	    YH,7A                       ; Y = 7A2E -> in AR-W
88A1	6A 15               LDI	    UL,15                       ; Loop counter, 15-0 16 bytes copied
88A3	B5 2C               LDI	    A,2C                        ; Value to be poked in 2C = ','

BRANCH_88A5: ; Branched from 88A6
88A5	53                  SDE	    Y                           ; (Y) = A. Then DEC Y. Y=7A2E~7A18, fill with 2C ','
88A6	88 03               LOP	    UL,BRANCH_88A5              ; DEC UL, if borrow flag not set loop back
88A8	A5 78 82            LDA	    (STK_PTR_GSB/FOR)           ; Y = 7A18
88AB	89 11               BZR+    BRANCH_88BE                 ; If A != 0 branch fwd
88AD	BE 8C 4B            SJP	    SETCOM2ASCII                    ; Converts Baud Rate setting in SETCOM to ASCII?
88B0	54                  INC	    Y                           ; Y = 7A19
88B1	BE 8C 71            SJP	    WORDLEN2ASCII                    ; Updates (Y) with ASCII value for Word Length, Y = 7A1A
88B4	54                  INC	    Y                           ; Y = 7A1B. Leaving a ',' between
88B5	BE 8C 5F            SJP	    PARITY2ASCII                    ; Updates (Y) with ASCII charecter for Parity, Y = 7A1C
88B8	54                  INC	    Y                           ; Y = 7A1D
88B9	BE 8C 7D            SJP	    STOPBIT2ASCII                    ; Updates (Y) with ASCII charecter for #Stop Bits Y = 7A1E
88BC	8E 25               BCH+    BRANCH_88E3                 ; Branch fwd unconditional

BRANCH_88BE: ; Branched from 88AB
88BE	A5 78 57            LDA	    (SETDEV_REG)                ; Which devices are redirected to RS232
88C1	2A                  STA	    UL                          ;
88C2	A5 79 D1            LDA	    (79D1)                      ; A = (79D1), 79D1 Indicates a basic extension table. 
88C5	B7 C0               CPI	    A,C0                        ; What does C0 mean?
88C7	8B 02               BZS+    BRANCH_88CB                 ; If A != C0 branch fwd
88C9	6A 00               LDI	    UL,00                       ;

BRANCH_88CB: ; Branched from 88C7
88CB	24                  LDA	    UL                          ; A = UL = (SETDEV_REG) or 00
88CC	4A D8               LDI	    XL,D8                       ; X = 83D8. TBL_SETDEV_TEXT, SETDEV Command text table
88CE	48 83               LDI	    XH,83                       ; Y = 7A1E
88D0	6A 04               LDI	    UL,04                       ; Loop counter, 4-0 all 5 SETDEV settings

BRANCH_88D2: ; Branched from 88DC                               ; TBL_SETDEV_TEXT .BYTE 4B 49 01 = K I 01 (Bit 0 in SETDEV)
88D2	F5                  TIN                                 ; (Y) = (X) then INC both X,Y. X = 83D9, Y = 7A1F
88D3	F5                  TIN                                 ; (Y) = (X) then INC both X,Y. X = 83DA, Y = 7A20
88D4	54                  INC	    Y                           ; Y = Y + 1 = 7A21, leaving a ','
88D5	D5                  SHR                                 ; A = A >> 1. A = (SETDEV_REG) or 00
88D6	83 03               BCS+    BRANCH_88DB                 ; If Bit 0 (KI?) was set branch fwd
88D8	56                  DEC	    Y                           ; Y = 7A1F
88D9	56                  DEC	    Y                           ; Y - 7A1E
88DA	56                  DEC	    Y                           ; Y = 7A1D 

BRANCH_88DB: ; Branched from 88D6
88DB	44                  INC	    X                           ; X = 83DB, next text entry
88DC	88 0C               LOP	    UL,BRANCH_88D2              ; UL = UL - 1, loop back 'e' if Borrow Flag not set.
88DE	5E 19               CPI	    YL,19                       ; 
88E0	81 01               BCR+    BRANCH_88E3                 ; If YL < 19 branch fwd
88E2	56                  DEC	    Y                           ;

BRANCH_88E3: ; Branched from 88BC, 88E0
88E3	14                  LDA	    YL                          ;
88E4	FB                  SEC                                 ; Set Carry
88E5	4A 18               LDI	    XL,18                       ;
88E7	00                  SBC	    XL                          ; A = A - XL, A is string length?
88E8	48 7A               LD	    XH,7A                       ; X = 7A18
88EA	BE DF A1 02         SJP	    DFA1,88F0                   ; X points to string to insert into String buffer. Branch if overflow 
88EE	68 00               LDI	    UH,00                       ;
88F0	B5 9A               LDI     A,9A                        ; 
88F2	ED 78 50 80         BII	    (OUTSTAT_REG),80            ;
88F6	89 09               BZR+    BRANCH_8901                 ; If Bit 7 is set branch fwd, to poke RTN, 9A into 7A30
88F8	AE 7A 31            STA	    (7A31)                      ;  or into 7A31
88FB	E9 78 55 F7         ANI	    (CR/LF_REG),F7              ; Clear Bit 3
88FF	B5 E3               LDI     A,E3                        ;

BRANCH_8901:  ; Branched from 88F6
8901	AE 7A 30            STA	    (SREG)                      ; If branched here are are poking 9A RTN, else E3 SPU, 9A RTN (to swtich to low bank)
8904	BA 7A 30            JMP	    SREG                        ; Were are doing RTN to what? 



;--------- ---------------------------------------------------------------------------------------------------
; SETCOM - Called by command vector table by 831C
; Sets COM parameters, i.e. SETCOM 2400,8,N,1
; Arguments: X
; Output:
; RegMod:
SETCOM:
8907	BE 89 CB            SJP	    TXT2STRBUF                  ; Copies string argument into string buffer
890A	81 02               BCR+    BRANCH_890E                 ; C=0 means string not found
890C	FD 88               PUSH    X                           ; X is pointer into current line?

BRANCH_890E: ; Branched to from 890A
890E	C8 05               VEJ     (C8),BRANCH_8915            ; Checks if end of command sequence or end of line. C=1 if ":"
8910	BE 8A A9            SJP	    PORTS_UPDATE_ALT_E1         ;
8913	8E 49               BCH+    BRANCH_895E                 ; Exit, go back to Start of BASIC

BRANCH_8915:
8915	C4 3D 01            VEJ	    (C4),3D,BRANCH_8919         ; Check tokens/char in U-Reg if not 3D '=' branch fwd BRANCH_8919
8918	C0                  VEJ     (C0)                        ; load next character/token to U-Reg

BRANCH_8919: ; Branched to from 8915
8919	C4 2C 04            VEJ     (C4),2C,BRANCH_8920         ; Check tokens/char in U-Reg if not 2C ',' branch fwd BRANCH_8920
891C	C8 10               VEJ     (C8),BRANCH_892E            ; If following character not end to command sequence/line branch fwd BRANCH_892E
891E	8E 3E               BCH+    BRANCH_895E                 ; Exit, go back to Start of BASIC

BRANCH_8920: ; Branched to from 8919
8920	C6                  VEJ     (C6)                        ; Decrements Y-Reg by 2 bytes for tokens, 1 byte for characters in U-Reg
8921	BE 8A CF            SJP	    UNKNOWN_8ACF         ; Creates an int from text?
8924	83 96               BCS+    BRANCH_89BC                 ; Carry set in sub = Failure
8926	C8 02               VEJ     (C8),BRANCH_892A            ; If following character not end to command sequence/line branch fwd BRANCH_892E
8928	8E 34               BCH+    BRANCH_895E                 ; Exit, go back to Start of BASIC

BRANCH_892A:
892A	C4 2C 93            VEJ     (C4),2C,BRANCH_89C0         ; Check tokens/char in U-Reg if not 2C ',' branch fwd BRANCH_89C0 
892D	C0                  VEJ     (C0)                        ; load next character/token to U-Reg

BRANCH_892E: ; Branched to from 891C
892E	C4 2C 04            VEJ     (C4),2C,BRANCH_8935         ; Check tokens/char in U-Reg if not ',' branch fwd BRANCH_8935
8931	C8 10               VEJ     (C8),BRANCH_8943            ; If following character not end to command sequence/line branch fwd BRANCH_892E
8933	8E 29               BCH+    BRANCH_895E                 ; Exit, go back to Start of BASIC

BRANCH_8935: ; Branched to from 892E
8935	C6                  VEJ     (C6)                        ; Decrements Y-Reg by 2 bytes for tokens 1 byte for characters in U-Reg
8936	BE 8B 02            SJP	    PARSE_SETCOM                    ; Processes tokens related to setting COM parameters
8939	83 81               BCS+    BRANCH_89BC                 ; Carry set in sub = Failure
893B	C8 02               VEJ     (C8),BRANCH_893F            ; If following character not end to command sequence/line branch fwd BRANCH_892E
893D	8E 1F               BCH+    BRANCH_895E                 ; Exit, go back to Start of BASIC

BRANCH_893F: ; Branched to from 893B
893F	C4 2C 7E            VEJ     (C4),2C,BRANCH_89C0         ; Check tokens/char in U-Reg if not 2C ',' branch fwd BRANCH_89C0
8942	C0                  VEJ     (C0)                        ; load next character/token to U-Reg

BRANCH_8943: ; Branched to from 8931
8943	C4 2C 05            VEJ     (C4),2C,BRANCH_894B         ; Check tokens/char in U-Reg if not 2C ',' branch fwd BRANCH_894B 
8946	C8 6E               VEJ     (C8),BRANCH_89B6            ; If following character not end to command sequence/line branch fwd BRANCH_89B6
8948	38                  NOP                                 ; Does what it says on the tin
8949	8E 13               BCH+    BRANCH_895E                 ; Exit, go back to Start of BASIC

BRANCH_894B: ; Branched to from 8943
894B	C6                  VEJ     (C6)                        ; Decrements Y-Reg by 2 bytes for tokens 1 byte for characters in U-Reg
894C	BE 8B 1F            SJP	    PORTS_UPDATE_ALT_E4         ; Parity Charater parsing
894F	83 6B               BCS+    BRANCH_89BC                 ; Carry set in sub = Failure
8951	C8 02               VEJ     (C8),BRANCH_8955            ; If following character not end to command sequence/line branch fwd BRANCH_8955
8953	8E 09               BCH+    BRANCH_895E                 ; Exit, go back to Start of BASIC

BRANCH_8955: ; Branched to from 8951
8955	C4 2C 68            VEJ     (C4),2C,BRANCH_89C0         ; Check tokens/char in U-Reg if not 2C ',' branch fwd n
8958	C8 5C               VEJ     (C8),BRANCH_89B6            ; If following character not end to command sequence/line branch fwd BRANCH_89B6 
895A	8E 02               BCH+    BRANCH_895E                 ; Unconditional branch fwd (exit)

BRANCH_895C: ; Branched to from 89BA
895C	C8 62               VEJ     (C8),BRANCH_89C0            ; If following character not end to command sequence/line branch fwd BRANCH_89C0 

; Branched to from 8913, 891E, 8928, 8933, 893D, 8949, 8953, 895A, 897A, 89A7               
BRANCH_895E: 
895E	56                  DEC	    Y                           ; 
895F	A5 78 8E            LDA	    (TRACE_ON)                  ;
8962	CB E2               VZS	    E2                          ; If Z set, i.e. no TRACE_ON, jump to Start of Basic Interpreter
8964	FD 1A               POP	    Y                           ; Get original Y back, what is it? Realted to TRACE?
8966	E2                  VEJ     (E2)                        ; Start of Basic Interpreter



;--------- ---------------------------------------------------------------------------------------------------
; SEPARATOR_8967 - 00 FF used to fill in used areas
SEPARATOR_8967:
8967	FF 



;-------------------------------------------------------------------------------------------------------------
; SETDEV - Called by command vector table by 831C
; Arguments: X
; Output:
; RegMod: A, U, X, Y
SETDEV:
8968	BE 89 CB            SJP	    TXT2STRBUF                  ; Copies string argument into string buffer
896B	E9 78 57 E0         AND	    (SETDEV_REG),E0             ; (SETDEV_REG) = (SETDEV_REG) & E0
896F	81 02               BCR+    BRANCH_8973                 ; C=0 means string not found
8971	FD 88               PSH     X                           ; Save X

BRANCH_8973: ; Branched to from 896F
8973	C8 07               VEJ     (C8),BRANCH_897C            ; If following character not end to command sequence/line branch fwd BRANCH_897C
8975	B5 60               LDI	    A,60                        ;
8977	AE 79 D1            STA	    (79D1)                      ; (79D1) Indicates a basic extension table
897A	9E 1E               BCH-    BRANCH_895E                 ; Unconditional branch back, borrow exit from SETCOM

BRANCH_897C: ; Branched to from 8973
897C	C4 3D 01            VEJ     (C4),3D,BRANCH_8980         ; Check tokens/char in U-Reg if not 3D '=' branch fwd BRANCH_8980
897F	C0                  VEJ     (C0)                        ; load next character/token to U-Reg

BRANCH_8980: ; Branched to from 897C
8980	C6                  VEJ     (C6)                        ; Decrements Y-Reg by 2 bytes for tokens 1 byte for characters in U-Reg

BRANCH_8981: ; Branched to from 89AC
8981	4A D8               LDI	    XL,D8                       ;
8983	48 83               LDI	    XH,83                       ; X = 83D8 = TBL_SETDEV_TEXT
8985	C0                  VEJ     (C0)                        ; load next character/token to U-Reg
8986	83 34               BCS+    BRANCH_89BC                 ; Carry set = sub failure 
8988	24                  LDA	    UL                          ; Where does UL come from?
8989	FD C8               PSH	    A                           ;
898B	C0                  VEJ     (C0)                        ; load next character/token to U-Reg
898C	FD 8A               POP	    A                           ;
898E	83 2C               BCS+    BRANCH_89BC                 ; Carry set = sub failure 
8990	28                  STA	    UH                          ; UH = UL?

BRANCH_8991: ; Branched to from 89B2
8991	A4                  LDA	    UH                          ;
8992	F7                  CIN                                 ; FLAGS = A compared to (X), then INC X
8993	89 19               BZR+    BRANCH_89AE                 ; If A != (X) branch fwd
8995	24                  LDA	    UL                          ; 
8996	F7                  CIN                                 ; FLAGS = A compared to (X), then INC X
8997	89 16               BZR+    BRANCH_89AF                 ; If A != (X) branch fwd
8999	05                  LDA	    (X)                         ; Pulls SETDEV bit value from table
899A	AB 78 57            ORA	    (SETDEV_REG)                ; ORs it in
899D	AE 78 57            STA	    (SETDEV_REG)                ; and saves it
89A0	B5 C0               LDI	    A,C0                        ;
89A2	AE 79 D1            STA	    (79D1)                      ; Indicates a basic extension table.
89A5	C8 02               VEJ     (C8),BRANCH_89A9            ; If following character not end to command sequence/line branch fwd BRANCH_89A9
89A7	9E 4B               BCH-    BRANCH_895E                 ; Unconditional branch back

BRANCH_89A9: ; Branched to from 89A5
89A9	C4 2C 14            VEJ     (C4),2C,BRANCH_89C0         ; In UNKNOWN_CMD_8968. Check tokens/char in U-Reg if not 2C ',' branch fwd n
89AC	9E 2D               BCH-    BRANCH_8981                 ; Unconditional jump back

BRANCH_89AE: ; Branched to from 8993
89AE	44                  INC	    X                           ; X = X + 1

BRANCH_89AF: ; Branched to from 8997
89AF	44                  INC	    X                           ; X = X + 1
89B0	4E E7               CPI	    XL,E7                       ; X is TBL_SETDEV_TEXT
89B2	91 23               BCR-    BRANCH_8991                 ; If XL < E7 branch back, try again for a match?
89B4	8E 06               BCH+    BRANCH_89BC                 ; Unconditional jump fwd

BRANCH_89B6: ; Branched to from 8946, 8958
89B6	C6                  VEJ     (C6)                        ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
89B7	BE 8B 11            SJP	    SUB_8B11                    ; Parse Parity?
89BA	91 60               BCR-    BRANCH_895C                 ; Branches back to another command?

; Branched to from 8924, 8939, 894F, 8986, 898E, 89B4
BRANCH_89BC: 
89BC	68 33               LDI	    UH,33                       ; 
89BE	8E 02               BCH+    BRANCH_89C2                 ; Unconditional jump fwd

BRANCH_89C0: ; Branched to from 892A, 893F, 8955, 895C, 89A9
89C0	68 01               LDI	    UH,01                       ;

BRANCH_89C2: ; Branched to from 89BE
89C2	56                  DEC	    Y                           ;
89C3	A5 78 8E            LDA	    (TRACE_ON)                  ;
89C6	CB E0               VZS	    (E0)                        ; If Z set, i.e. trace not set, Jump Indicates if UH is not "00" error message
89C8	FD 1A               POP	    Y                           ; Does FFE0 use Y?
89CA	E0                  VEJ     (E0)                        ; Indicates if UH is not "00" error message


;------------------------------------------------------------------------------------------------------------
; TXT2STRBUF - copies text from constant or string variable to the string buffer
; Arguments:
; Output: Text into String Buffer, 0D delimited. C=0 if string not found.
; RegMod: A,X,Y
TXT2STRBUF: ; called from 8907, 8968
89CB	CD 36               VMJ	    (36)                        ; Stores CSI of a text constant or text variable in AR-X (C=1). 
                                                                ; If no string is detected, C=0 
89CD	E9 78 8E 00         ANI	    (TRACE_ON),00               ; (TRACE_ON) = Zero 
89D1	81 1B               BCR+    BRANCH_89EE                 ; Carry reset - No string
89D3	FD 98               PSH	    Y                           ; Save Y. Y-REG is pointer into current line?
89D5	EB 78 8E FF         ORI	    (TRACE_ON),FF               ; Set all bits
89D9	DC                  VEJ     (DC)                        ; Loads CSI from AR-X: (X) is Address, UL & A is length. CSI = 'Character String Information' 
89DA	5A 10               LDI	    YL,10                       ; 
89DC	58 7B               LDI     YH,7B                       ; 7B10 - STRING BUFFER Byte 0 Start
89DE	8B 05               BZS+    BRANCH_89E5                 ; Skip if length in UL is zero
89E0	DF                  DEC	    A                           ; A = A - 1
89E1	2A                  STA	    UL                          ; Loop counter

BRANCH_89E2: ; Branched to from 89E3                            ; Copies string from AR-X to String Buffer
89E2	F5                  TIN                                 ; (Y) = (X) then X = X + 1, Y = Y + 1
89E3	88 03               LOP	    UL,BRANCH_89E2              ; UL = UL - 1, loop back 'e' if Borrow Flag not s

BRANCH_89E5: ; Branched to from 89DE
89E5	B5 0D               LDI	    A,0D                        ; 0D = CR
89E7	1E                  STA	    (Y)                         ; (Y) = A, add CR to end of string
89E8	5A 10               LDI	    YL,10                       ; Set Y back to start of buffer
89EA	FD 0A               POP	    X                           ; X=Y pushed at beggining of this sub
89EC	FB                  SEC                                 ; Set Carry Flag
89ED	9A                  RTN                                 ; Return

BRANCH_89EE: ; Branched to from 89D1                            ; We got here if no string was found
89EE	FD 5A               STX     Y                           ; Y = X. Y-REG is pointer into current line?
89F0	9A                  RTN                                 ; Return



;------------------------------------------------------------------------------------------------------------
; SEPARATOR_89F1 - 00 FF fills unused space
SEPARATOR_89F1:
89F1	FF 00 FF 00        .BYTE FF 00 FF 00                    ; Not used



;------------------------------------------------------------------------------------------------------------
; TRANSMIT - Called from Command Vector Table
; Alt entry at 8A07 - Called from JMP_9ED0:9F13
; Parses something and resets UART?
; Arguments:
; Output:
; RegMod: A
TRANSMIT:
89F5	C2 F0 B3 0C         VEJ	    (C2),F0B3,BRANCH_8A05       ; If next character is not 'F0 B3' (BREAK), branch fwd BRANCH_8A05
89F9	C2 2C 09            VEJ	    (C2),2C,BRANCH_8A05         ; If next character is not 2C ',', branch fwd BRANCH_8A05
89FC	DE 08               VEJ	    (DE),BRANCH_8A06            ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
89FE	D0 09 05            VEJ	    (D0),09,BRANCH_8A06         ; Convert AR-X to integer & load to U-Reg. 09 specifies the range. If range exceeded: Branch fwd BRANCH_8A06
8A01	BE 8A 07            SJP	    UNKNOWN_CMD_89F5_ALT_E1     ; 
8A04	E2                  VEJ     (E2)                        ; Start of Basic Interpreter, i.e. EXIT

;Error handeling 
BRANCH_8A05: ; Branched to from 89F5, 89F9
8A05	E4                  VEJ     (E4)                        ; Output error 1 and return to the editor

BRANCH_8A06: ; Branched to from 89FC, 89FE
8A06	E0                  VEJ     (E0)                        ; Is UH "00" error message

UNKNOWN_CMD_89F5_ALT_E1: ; Called from 8A01, 9F13
8A07	B5 0D               LDI	    A,0D                        ; 0D = CR
8A09	AE 78 82            STA	    (STK_PTR_GSB/FOR)           ;
8A0C	BE 8B 72            SJP	    CFG_UART_LPT                    ; Sets D201 which is UART config register
8A0F	F4 7A 05            VEJ	    (F4),(ARX + 5)              ; Loads U-Reg with 16-bit value from address of (ARX + 5)
8A12	BE E8 8C            SJP	    SBRAC                       ; Time delay 15,625 ms * Number from U-Reg.BREAK is possible.
8A15	E9 78 82 00         ANI	    (STK_PTR_GSB/FOR),00        ; (STK_PTR_GSB/FOR) = (STK_PTR_GSB/FOR) & 00. CLear (STK_PTR_GSB/FOR)?
8A19	BE 8B 72            SJP	    CFG_UART_LPT                    ; Sets D201 which is UART config register
8A1C	BA 87 DE            JMP	    NULL2COM                    ; Sends a 00 to RS232 if SETDEV_REG Bit is set, then RTN



;------------------------------------------------------------------------------------------------------------
; SEPARATOR_8A1F - 00 FF filles unused space
SEPARATOR_8A1F:
8A1F	FF                  .BYTE   FF                          ; Unused



;------------------------------------------------------------------------------------------------------------
; RELOC_CODE_8A20 - Poked into Sytem RAM by PORTS_UPDATE to read a value in from (A297) with SPC reset
;                   A297 is Something in CE-150?
; Arguments:
; Output: A = (A297)
; RegMod: A
RELOC_CODE_8A20:
8A20	FD BE               RIE                                 ; (7A26) Disable interrupts
8A22	B8                  RPV                                 ; (7A28) Reset PV Banks out CE-158, banks in CE-150
8A23	A5 A2 97            LDA	    (A297)                      ; (7A29) Something in CE-150?
8A26	A8                  SPV                                 ; (7A2C) Set PV, bank back in CE-158
8A27	FD 81               SIE                                 ; (7A2D) Enable interrupts
8A29	9A                  RTN                                 ; (7A2F) Done



;------------------------------------------------------------------------------------------------------------
; PORTS_UPDATE - Called from 82F8, 8E02, 8E34
; Pokes code from RELOC_CODE_8A20 above into 7A26 and calls it. Checks for something in CE-150
; May update lh5811 ports and do other INIT realted stuff
; Seems to set BAUD and/or DTR/RTS each time too
; Arguments:
; Output:
; RegMod: A, UH
PORTS_UPDATE:
8A2A	B5 9A               LDI	    A,9A                        ; RTN?
8A2C	AE 79 FA            STA	    (UNDEF_REG_79FA)            ; 79FA~79FE used by CE-158
8A2F	FD EB D0 08 80      ORI	    #(CE158_PRT_C),80           ; Paper Feed key (ME1)
8A34	FD 88               PSH	    X                           ; Command Code in X already pushed in MAIN_ENTRY
8A36	4A 29               LDI	    XL,29                       ; RELOC_CODE_8A20 end address (copies backwards)
8A38	48 8A               LDI	    XH,8A                       ; X = 8A29. Set up to copy to sytem RAM
8A3A	6A 2F               LDI	    UL,2F                       ; End address of destination System RAM address
8A3C	68 7A               LDI	    UH,7A                       ; U = 7A2F. 7A26 to 7A2F in AR-W

BRANCH_83AE: ; Branched to from 8A43
8A3E	47                  LDE	    X                           ; A = (X) then X = X - 1. A = (8A29)
8A3F	2E                  STA	    (U)                         ; Copy 8A20->8A29 from ROM to 7A26 to 7A2F (AR-W) in RAM 
8A40	62                  DEC	    UL                          ;  values: FD BE,  B8,   A5 A2 97,  A8, FD 81, 9A
8A41	6E 26               CPI	    UL,26                       ;            REI, RPV, LDA (A297), SPV,   SEI, RTN
8A43	93 07               BCS-    BRANCH_8A3E                 ; Branch back to finish the copying
8A45	4A 56               LDI	    XL,56                       ; 
8A47	48 78               LDI	    XH,78                       ; X = 7856 = ZONE_REG
8A49	49 1F               ANI	    (X),1F                      ; X = (ZONE_REG) & 1F, zeros bits 7-5 of value in ZONE_REG
8A4B	BE 7A 26            SJP	    ARV + 6                     ; Why mask (ZONE_REG) before reading (A297) in sub poked in?
8A4E	89 02               BZR+    BRANCH_8A52                 ; Branch fwd if (A297) was not zero (looks for CE-150?)
8A50	4B 20               ORI	    (X),20                      ; (ZONE_REG) = (ZONE_REG) | 20. Sets bit 5

BRANCH_8A52: ; Branched to from 8A4E
8A52	B7 6D               CPI	    A,6D                        ; FLAGS = A & 6D. A = (A297), some value if CE-150 present.
8A54	89 02               BZR+    BRANCH_8A58                 ; If A != 6D.
8A56	4B 40               ORI	    (X),40                      ; (ZONE_REG) = (ZONE_REG) | 40. Sets bit 6

; this section seems to set PORT_A and PORT_B directions
BRANCH_8A58: ; Branched to from 8A54
8A58	FD 2A               POP     U                           ; Pops original X into U. Command code now in UL.
8A5A	68 D0               LDI	    UH,D0                       ; Changes High Byte to D0. D0 + Command Code
8A5C	ED 79 DE 10         BII	    (UNDEF_REG_79DE),10         ; Bit 4
8A60	8B 19               BZS+    BRANCH_8A7B                 ; Brach fwd if Bit 4 was not set
8A62	4D 20               BII	    (X),20                      ; FLAGS = (ZONE_REG) & 20.
8A64	8B 83               BZS+    BRANCH_8AE9:                ; If bit 6 not set branch fwd
8A66	6A 0D               LDI	    UL,0D                       ; U = D00D.
8A68	B5 7F               LDI	    A,7F                        ; Load A with 7F to send to address
8A6A	FD 2E               STA	    #(U)                        ; pointed to by (U), D00D, PRT_B_IO_DIR (ME1)
8A6C	66                  DEC	    U                           ; DEC U pointer to   D00C, CE158_PRT_A_DIR?
8A6D	B5 C3               LDI     A,C3                        ; Load A with C3 to send to address
8A6F	FD 2E               STA	    #(U)                        ; pointed to by (U), D00C, CE158_PRT_A_DIR (ME1)
8A71	66                  DEC	    U                           ; U = D00B
8A72	66                  DEC	    U                           ; U = D00A, CE158_MSK_REG
8A73	FD 69 00            ANI	    #(U),00                     ; (U) = 00
8A76	AE 78 8E            STA	    (TRACE_ON)                  ; (A still C3?)
8A79	8E 25               BCH+    BRANCH_8AA0                 ; Unconditional fwd branch

BRANCH_8A7B:  ; Branched to from 8A60                           ; UH=D0, UH=Command code
8A7B	EB 79 DE 10         ORI	    (UNDEF_REG_79DE),10         ; Set bit 4
8A7F	B5 FE               LDI	    A,FE                        ; FE used by BZR+ branch
8A81	6E D0               CPI	    UL,D0                       ; FLAGS = UL & D0. Command code D0=INIT command
8A83	89 05               BZR+    BRANCH_8A8A                 ; If UL != D0 branch fwd
8A85	A5 7A 20            LDA	    (ARV)                       ; A =  AR-V
8A88	B9 01               ANI	    A,01                        ; A = A & 01, mask off all but bit 0

BRANCH_8A8A: ; Branched to from 8A83
8A8A	AE 78 8E            STA	    (TRACE_ON)                  ; (TRACE_ON) = A. A = (ARV) & 01 (INT Cmd) or A = FE (rest)
8A8D	4A B0               LDI	    XL,B0                       ; 
8A8F	48 83               LDI	    XH,83                       ; X = 83B0 = CE-158_IOREG_INIT
8A91	6A 0F               LDI	    UL,0F                       ; U = D00F = CE158_PRT_B

BRANCH_8A93:  ; Branched to from 8A99                           ; Sets default state of #(D00F~D008)
8A93	45                  LIN	    X                           ; A = (X) &then X = X + 1. X-Reg set to 83B0 above
8A94	FD 2E               STA     #(U)                        ; (U) = A (ME1). U = D00F?
8A96	62                  DEC	    UL                          ; Copies 8 bytes from X = 83B0-83B7 to U = D00F-D008
8A97	6E 07               CPI	    UL,07                       ;  Inits CE-158 lh5811 IO registers
8A99	93 08               BCS-    BRANCH_8A93                 ; If UL > 07 branch back, = 7 we are done
8A9B	6A 56               LDI	    UL,56                       ; Bytes: FF FF 7F 03 00 00 00 A0
8A9D	BE 9F 75            SJP	    SUB_9F75                    ; U = D056, X = 83B8 (83B8 value not used yet)
                                                                ; Initializes some CE-158 registers

BRANCH_8AA0: ; Branched to from 8A79
8AA0	BE 9F D0            SJP	    SUB_9FD0                    ; Sets DTR/RTS based on OUTSTAT_REG
8AA3	ED 78 8E 01         BII	    (TRACE_ON),01               ; FLAGS = (TRACE_ON) & 01, mask all but bit 0 off
8AA7	89 94               BZR+    BRANCH_8B3D                 ; If bit 0 in (TRACE_ON) set branch fwd
                                                                ; Branch fwd, set BAUD rate, then return

PORTS_UPDATE_ALT_E1: ; Jumped to from to from 8910
8AA9	B5 99               LDI	    A,99                        ;
8AAB	8E 8D               BCH+    BRANCH_8B3A                 ; Branch fwd, set BAUD rate, then return



;-----------------------------------------------------
; PORTS_UPDATE_ALT_E2 - Called from SUB_8D04:8EDA
; Not sure what this does. Searches through TBL_BAUD
; Arguments:
; Output:
; RegMod: A, X
PORTS_UPDATE_ALT_E2:
8AAD	A5 78 B6            LDA	    (ERROR_TOP_H)               ; Begining address of the program containing ERROR line
8AB0	FB                  SEC                                 ; Set Carry Flag
8AB1	B1 16               SBI	    A,16                        ; A = A - 16
8AB3	81 0D               BCR+    BRANCH_8AC2                 ; If A < 16 Branch fwd, Return
8AB5	B7 0A               CPI	    A,0A                        ;
8AB7	83 0D               BCS+    BRANCH_8AC6                 ; A >= 0A Branch, else A >= 16 A < 0A
8AB9	BE 86 F6            SJP	    SUB_86F0_ALT_E1             ; Calculates a new address to set P to, uses U, X, A

; are these 5 lines not used
8ABC	05                  LDA	    (X)                         ; A = (X). What is X?
8ABD	05                  LDA	    (X)                         ; why twice? 
8ABE	10                  SBC	    YL                          ; A = A - YL
8ABF	42                  DEC	    XL                          ; XL = XL - 1
8AC0	5E 4F               CPI	    YL,4F                       ; Setting carry flag for return?

BRANCH_8AC2: ; Branched to from 8AB3
8AC2	9A                  RTN                                 ;

; How is this reached
8AC3	BA 87 90            JMP	    JMP_8790                    ; ***

BRANCH_8AC6:  ; Branched to from 8AB7
8AC6	04                  LDA	    XL                          ; Not sure what X or Y is here
8AC7	10                  SBC	    YL                          ; A = XL - YL
8AC8	FD 18               LDX	    Y                           ; Transfer Y to X
8ACA	CD 24               VMJ	    (24)                        ; Sends address from X-Reg as CSI, format "D0 XH XL length" to AR-X 
8ACC	BA CE D0            JMP	    TXFR_RSV_KEY                ; Transfers reserve key assignment to reserve storage area



;--------------------------------------------------------------------------------------------------
UNKNOWN_8ACF: ; Branched to from 8921
8ACF	6A 50               LDI	    UL,50                       ;
8AD1	BE D1 4F 56         SJP	    SUB39,BRANCH_8B2B           ; Pass decimal number which Y points to AR-X. Jump in case of error 
8AD5	D0 06 53            VEJ     (D0),06,BRANCH_8B2B         ; Convert AR-X to INT & load to U-Reg. 06 is the range. If range exceeded: Branch fwd n
8AD8	4A C0               LDI	    XL,C0                       ; 
8ADA	48 83               LDI	    XH,83                       ; X = 83C0, 'TBL_BAUD'

BRANCH_8ADC: ; Branched to from 8AE7
8ADC	45                  LIN	    X                           ; A = (X) then INC X.   83C0
8ADD	A6                  CPA	    UH                          ; What is U used for here?
8ADE	89 04               BZR+    BRANCH_8AE4                 ; Branch fwd if A != UH
8AE0	05                  LDA	    (X)                         ; A = (X)               83C1
8AE1	26                  CPA	    UL                          ; What is U used for here?
8AE2	8B 06               BZS+    BRANCH_8AEA                 ; Branch fwd if A = UL

BRANCH_8AE4: ; Branched to from 8ADE
8AE4	44                  INC	    X                           ;                       83C2
8AE5	4E D0               CPI	    XL,D0                       ; range of comparison is 83C0 to 83D0?
8AE7	91 0D               BCR-    BRANCH_8ADC                 ; Brach back XL < D0

BRANCH_8AE9: ; Branched to from 8A64
8AE9	9A                  RTN                                 ; Return if match not found?

BRANCH_8AEA: ; Branched to from 8AE2
8AEA	04                  LDA	    XL                          ; X >= 8C31?, A >= 31?
8AEB	B1 C1               SBI	    A,C1                        ; A = A - C1 >= 0?
8AED	F1                  AEX                                 ; Swap hi and low nibbles of Accumulator. 3 2 1 0 7 6 5 4
8AEE	E9 78 58 1F         ANI	    (SETCOM_REG),1F             ; 
8AF2	8E 43               BZS+    BRANCH_8B37                 ; Branch fwd if any bits 7-6-5 not set
8AF4	6A 50               LDI	    UL,50                       ; Is UL used by sub?
8AF6	BE D1 4F 31         SJP	    SUB39,BRANCH_8B2B           ; Pass decimal number which Y points to AR-X. Jump in case of error 
8AFA	D0 08 2E            VEJ     (D0),08,BRANCH_8B2B         ; Convert AR-X to INT & load to U. 08 specifies the range. If range exceeded: Branch fwd n
8AFD	AE 78 B9            STA	    (ON_ERR_ADD_H)              ; (ON_ERR_ADD_H) = A
8B00	F9                  REC                                 ; Reset Carry Flag = success
8B01	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; PARSE_SETCOM: ; Called from 8936
; Parse and set SETCOM settings
; Arguments: A, (SETCOM)
; Output:
; RegMod: A, X
PARSE_SETCOM:
8B02	CD 02 35 39 24      VMJ	    (02),35,39,BRANCH_8B2B      ; Load next token/character in U, check if (UL) in interval n1-n2. If not branch n3
8B07	B1 34               SBI	    A,34                        ; A = A - 34. What is A?
8B09	F1                  AEX                                 ; Swap hi and low nibbles of Accumulator.
8B0A	D5                  SHR                                 ; A = A >> 1. 3 2 1 0 7 6 5 4 > x 3 2 1 0 7 6 5
8B0B	E9 78 58 E7         ANI	    (SETCOM_REG),E7             ; Clear Bits 3,4, World length
8B0F	8E 26               BZS+    BRANCH_8B37                 ; If any Bits 7,6,5,2,1,0 are not set branch fwd

SUB_8B11: ; Called from 89B7
8B11	CD 02 31 33 15      VMJ	    (02),31,33,BRANCH_8B2B      ; Load next token/character in U-Reg, check whether value in UL in interval n1-n2. If not branch n3
8B16	B9 02               ANI	    A,02                        ; Keep Bit 1. What is A?
8B18	D9                  SHL                                 ; A = A << 1. Shifted through Carry, 0 into MSB
8B19	E9 78 58 FB         ANI	    (SETCOM_REG),FB             ; clear Bit 2, Stop Bit. Bits 3,4 cleared above. 
                                                                ; Bits 0,1 Parity, 5,6,7 Baud left
8B1D	8E 18               BZS+    BRANCH_8B37                 ; Branch fwd if Zero set, if Parity and Baud both zero

PORTS_UPDATE_ALT_E4: ; Called from 894C                         ; Parse parity settings
8B1F	C0                  VEJ     (C0)                        ; load next character/token to U-Reg
8B20	83 09               BCS+    BRANCH_8B2B                 ; Branch fwd if Carry set, i.e. error from sub
8B22	CD 34 02            VMJ	    (34),02,                    ; A 'Switch-Case' type of function 
        4E 07                         4E,BRANCH_8B2E            ; If UL is 4E, 'N', branch fwd to 8B2E
        45 06                         45,BRANCH_8B2F            ; If UL is 45, 'E', branch fwd to 8B2F
        4F 02                         4F,BRANCH_8B2D            ; If UL is 4F, 'O', branch fwd to 8B2D
        
BRANCH_8B2B: ; Branched to from 8B02, 8B11, 8B20
8B2B	FB                  SEC                                 ; Set carry flag
8B2C	9A                  RTN                                 ; SEC = Failure

BRANCH_8B2D: ; Branched to from 8B22                            ; Reset Carry Flag = success
8B2D	F9                  REC                                 ; But then we drop to an SEC

BRANCH_8B2E: ; Branched to from 8B22                            ; They like using REC as NOP
8B2E	F9                  REC                                 ; Reset Carry Flag

BRANCH_8B2F: ; Branched to from 8B22
8B2F	FB                  SEC                                 ; Set Carry Flag
8B30	04                  LDA	    XL                          ; What is in XL? Must be SETCOM Parity setting?
8B31	B1 2D               SBI	    A,2D                        ; A = A - 2D
8B33	E9 78 58 FC         ANI	    (SETCOM_REG),FC             ; Clear Bits 0,1. Parity

BRANCH_8B37: ; Branched to from 8AF2, 8B0F, 8B1D
8B37	AB 78 58            ORA	    (SETCOM_REG)                ; A = A | (SETCOM_REG)

BRANCH_8B3A: ; Branched to from 8AAB
8B3A	AE 78 58            STA	    (SETCOM_REG)                ; (SETCOM_REG) = A

BRANCH_8B3D: ; brancnched from 8AA7                             ; Sets Baud rate in CDP1854ACE UART chip
8B3D	E9 78 82 00         ANI	    (STK_PTR_GSB/FOR),00      ; 
8B41	BE 8B 72            SJP	    CFG_UART_LPT                    ; Sets D201 which is a UART config register
8B44	A5 78 58            LDA	    (SETCOM_REG)                ; A = (SETCOM_REG)
8B47	F1                  AEX                                 ; Swap hi and low nibbles of Accumulator. 3 2 1 0 7 6 5 4
8B48	B9 0E               ANI	    A,0E                        ; Keep x x x x 7 6 5 x of (SETCOM), i.e. BAUD
8B4A	D5                  SHR                                 ; A = A >> 1. x x x x x 7 6 5
8B4B	4A D0               LDI	    XL,D0                       ; 
8B4D	48 83               LDI	    XH,83                       ; X = 83D0, TBL_CDP1854ACE_BAUD                         A = 0, 50 BUAD
8B4F	FD CA               ADR	    X                           ; X = X + A. Offset into TBL_CDP1854ACE_BAUD            X = 83D0 + 0
8B51	05                  LDA	    (X)                         ; A = (X).                                              A = 99
8B52	FD EB D0 0C C0      ORI	    #(CE158_PRT_A_DIR),C0       ; Bits 6,7 output, Baud rate select, PC0-4 also (ME1)
8B57	FB                  SEC                                 ; Set carry flag
8B58	D1                  ROR                                 ; A = A >> 1. Carry into bit 7, bit 0 into Carry        A = CC, C = 1
8B59	83 07               BCS+    BRANCH_8B62                 ; Branch fwd if Bit 0 was a 1
8B5B	FD E9 D0 0E 7F      ANI	    #(CE158_PRT_A),7F           ; Clear bit 7 (ME1)
8B60	8E 05               BZS+    BRANCH_8B67                 ; If all Bits 6-0 in clear, branch fwd

BRANCH_8B62: ; branched to from 8B59
8B62	FD EB D0 0E 80      ORI	    #(CE158_PRT_A),80           ; (ME1). Set Bit 7

BRANCH_8B67: ; branched to from 8B60
8B67	FD AE D0 08         STA     #(CE158_PRT_C)              ; Set rest of Baud rate bits (ME1)
8B6B	FD E9 D0 0E BF      ANI	    #(CE158_PRT_A),BF           ; Clear Bit 6
8B70	F9                  REC                                 ; Reset carry flag = success
8B71	9A                  RTN                                 ; Return



;------------------------------------------------------------------------------------------------------------
; CFG_UART_LPT - Called from 8B41, 
; Configures UART
; Arguments: 
; Output:
; RegMod: U, A, X
CFG_UART_LPT:
8B72	6A 01               LDI	    UL,01                       ;
8B74	FD BE               RIE                                 ; Disable interrupts
8B76	68 D2               LDI	    UH,D2                       ; U = D201 = UART_REG_W
8B78	A5 78 57            LDA	    (SETDEV_REG)                ; A = (SETDEV_REG), which devices redirected to RS232
8B7B	D9                  SHL                                 ; A = A << 1. Shifted through Carry, 0 into MSB   C7  6 5 4 3 2 1 0 x
8B7C	DB                  ROL                                 ; A = A << 1. Carry into Bit 0, Bit 7 into Carry  C6  5 4 3 2 1 0 x 7
8B7D	83 3C               BCS+    BRANCH_8BBB                 ; If Bit 6 of (SETDEV_REG) was set branch fwd
8B7F	D1                  ROR                                 ; A = A >> 1. Carry into bit 7, bit 0 into Carry  C7  6 5 4 3 2 1 0 x
8B80	A5 78 58            LDA	    (SETCOM_REG)                ; A = (SETCOM_REG)
8B83	B9 1F               ANI	    A,1F                        ; Clear Bits 7-5, Baud 
8B85	48 83               LDI	    XH,83                       ;
8B87	81 23               BCR+    BRANCH_8BAC                 ; If Bit 7 of (SETDEV_REG) was set branch fwd
8B89	ED 78 82 0D         BII	    (STK_PTR_GSB/FOR),0D        ; 
8B8D	8B 05               BZS+    BRANCH_8B94                 ; If all Bits 3,2,0 clear branch fwd
8B8F	A5 78 82            LDA	    (STK_PTR_GSB/FOR)           ; A = (STK_PTR_GSB/FOR)
8B92	8E 13               BCH+    BRANCH_8BA7                 ; Branch fwd unconditional

BRANCH_8B94: ; branched to from 8B8D
8B94	FD EB D0 08 80      ORI	    #(PRT_C_IO),80              ; Set LPT /INIT (ME1)
8B99	4A E7               LDI	    XL,E7                       ; X = 83E7. TBL_CDP1854ACE_CFG
8B9B	FD E9 D0 08 7F      ANI	    #(PRT_C_IO),7F              ; Clear LPT /INIT, i.e. send initialize signal
8BA0	FD CA               ADR	    X                           ; X = X + A. A = (SET_COM) & 1F, Baud bits cleared
8BA2	05                  LDA	    (X)                         ; A = (X) = config for CDP1854ACE parity, Stop, Word Length
8BA3	FD 2E               STA	    #(U)                        ; (U) = A. U = UART_REG_W (ME1)
8BA5	B5 50               LDI	    A,50                        ; Some sort of code to latch settings in?

BRANCH_8BA7: ; branched to from 8B92, 8BCC, 8BB5, 8BB9
8BA7	FD 2E               STA	    #(U)                        ; (U) = A. U = UART_REG_W (ME1)
8BA9	FD 81               SIE                                 ; Enable interrupts
8BAB	9A                  RTN                                 ; Return


BRANCH_8BAC: ; Branched to from 8B87                            ; This section seems wrong, 8307 is not a table. 8407 is a table ***
8BAC	4A 07               LDI	    XL,07                       ; XH = 83, X = 8307, A = (SETCOM_REG) & 1F
8BAE	FD CA               ADR	    X                           ; X = X + A; 8307 inside MAIN_ENTRY?
8BB0	05                  LDA	    (X)                         ; A = (X)
8BB1	ED 78 82 08         BII	    (STK_PTR_GSB/FOR),08        ; FLAGS = (STK_PTR_GSB/FOR) & 08. Save bit 3
8BB5	99 10               BZR-    BRANCH_8BA7                 ; If bit 3 in (STK_PTR_GSB/FOR) was set
8BB7	BB 60               ORI	    A,60                        ; A = A | 60
8BB9	9E 14               BCH-    BRANCH_8BA7                 ; Unconditional back branch

BRANCH_8BBB: ; Branched to from 8B7D
8BBB	A5 78 58            LDA	    (SETCOM_REG)                ; A = (SETCOM_REG)
8BBE	B9 1F               ANI	    A,1F                        ; A = A & 1F. Mask off bits 7-5, Baud
8BC0	ED 78 82 0D         BII	    (STK_PTR_GSB/FOR),0D        ; FLAGS = (STK_PTR_GSB/FOR) & 0D
8BC4	8B 02               BZS+    BRANCH_8BC8                 ; If all bits 0,2,3 are clear branch fwd
8BC6	BB 40               ORI	    A,40                        ; A = A | 40. Set bit 3

BRANCH_8BC8:
8BC8	FD 2E               STA     #(U)                        ; (U) = A. (ME1)
8BCA	BB 80               ORI	    A,80                        ; Set bit 7
8BCC	9E 27               BCH-    BRANCH_8BA7                 ; Branch back unconditional



;------------------------------------------------------------------------------------------------------------
; SUB_8BCE - called from SUB_8FC1:8EEF
; Arguments: 
; Output:
; RegMod: 
SUB_8BCE:
8BCE	A5 78 B6            LDA	    (ERROR_TOP_H)               ; ERROR TOP (H)
8BD1	BE 87 0B            SJP	    TERMTXT_2INBUF              ; Copies text string from TEXT_84EF to Input Buffer (7BB0)
                                                                ; A = String index. Terminal program menu text?
8BD4	BE 86 F0            SJP	    SUB_86F0                    ; Calculates a new address to set P to (Program Counter), and goes there.

;------
; Seems like nonsense ***
8BD7	12                  ADC	    YL                          ; Was Y passed from a sub?
8BD8	1C                  DCS	    (Y)                         ; A = A - (Y). BCD Subtraction 
8BD9	1E                  STA	    (Y)                         ; (Y) = A
8BDA	1B                  ORA	    (Y)                         ; What are we doing here?
8BDB	18                  STA	    YH                          ;
8BDC	1A                  STA	    YL                          ;
8BDD	1B                  ORA	    (Y)                         ; A = A | (Y)
8BDE	67                  LDE	    (U)                         ; A = U then U = U -1
8BDF	6B 90               ORI	    (U),90                      ; (U) = (U) | 90
8BE1	7D 9A               BII	    (V),9A                      ; FLAGS = (V) & 9A
8BE3	2D                  EOR	    (U)                         ; A = A ^ (U)
8BE4	3C                  DCS	    (V)                         ; A = A - (V). BCD subtraction
8BE5	3B                  ORA	    (V)                         ; A = A | (V)
8BE6	3A                  STA	    VL                          ; VL = A
8BE7	39                  AND	    (V)                         ; A = A & (V)
8BE8	38                  NOP                                 ;
8BE9	2D                  EOR	    (U)                         ;

; this part looks reasonable but is not called 
8BEA	48 85               LDI	    XH,85                       ;
8BEC	4A 60               LDI	    XL,60                       ; X = 8560 in TBL_BAUD
8BEE	6A 06               LDI	    UL,06                       ;

BRANCH_8BF0:
8BF0	F5                  TIN                                 ; (Y) = (X) then X = X + 1, Y = Y + 1
8BF1	88 03               LOP	    UL,BRANCH_8BF0              ; UL = UL - 1, loop back 'e' if Borrow Flag not set
8BF3	9A                  RTN                                 ; Return
; Seems like nonsense
;------



;------------------------------------------------------------------------------------------------------------
; SUB_8BF4 - Called by? ***
; no idea what it does
; Arguments: XL
; Output:
; RegMod: A, UL
SUB_8BF4:
8BF4	F9                  REC                                 ; Reset carry - multiple entries?
8BF5	F9                  REC                                 ; Reset carry, seem to be used as NOPs
8BF6	F9                  REC                                 ; Reset carry
8BF7	F9                  REC                                 ; Reset carry
8BF8	F9                  REC                                 ; Reset carry
8BF9	FB                  SEC                                 ; Set carry
8BFA	04                  LDA	    XL                          ; A = XL. What is XL? Is XL >= F4?
8BFB	B1 F4               SBI	    A,F4                        ; A = A - F4
8BFD	2A                  STA	    UL                          ; UL = A, Loop coutner.
8BFE	A5 78 B4            LDA	    (ERRORLINE)                 ; 
8C01	F1                  AEX                                 ; Swap A high/low nibbles.               3 2 1 0 7 6 5 4

BRANCH_8C02: ; Branched to from 8C03
8C02	D9                  SHL                                 ; A = A << 1. Thru carry, 0 into LSB. C3 2 1 0 7 6 5 4 x
8C03	88 03               LOP	    BRANCH_8C02                 ; UL = UL - 1, loop back 'e' if Borrow Flag not set
8C05	B5 4F               LDI	    A,4F                        ;
8C07	51                  SIN	    (Y)                         ; (Y) = A. Then Y = Y + 1. What is Y?
8C08	B5 4E               LDI	    A,4E                        ;
8C0A	83 03               BCS+    BRANCH_8C0F                 ; Carry set in 8C02 shift?
8C0C	B5 46               LDI	    A,46                        ;
8C0E	51                  SIN	    (Y)                         ; (Y) = A. Then Y = Y + 1

BRANCH_8C0F: ; Branched to from 8C0A
8C0F	51                  SIN	    (Y)                         ; (Y) = A. Then Y = Y + 1
8C10	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; SUB_8C17 - Called from?
; No idea what this does
; Arguments: Y
; Output:
; RegMod: A, Y, X
SUB_8C17_ALT_E1:
8C11	B5 08               LDI	    A,08                        ;

BRANCH_8C13: ; Branched to from 8C1F
8C13	AE 78 84            STA	    (CUR_VAR_ADD_L)             ;

BRANCH_8C16: ; Branched to from 8C36
8C16	9A                  RTN                                 ; 


; SUB_8C17 - called from?
8C17	B5 46               LDI	    A,46                        ;
8C19	51                  SIN	    (Y)                         ; (Y) = A. Then Y = Y + 1. What is Y?
8C1A	B5 36               LDI	    A,36                        ;
8C1C	51                  SIN	    (Y)                         ; (Y) = A. Then Y = Y + 1
8C1D	B5 07               LDI	    A,07                        ;
8C1F	9E 0E               BCH-    BRANCH_8C13                 ; Unconditional branch back

8C21	B5 46               LDI	    A,46                        ;
8C23	51                  SIN	    (Y)                         ; (Y) = A. Then Y = Y + 1
8C24	A5 78 B6            LDA	    (ERROR_TOP_H)               ;
8C27	D5                  SHR                                 ; A = A >> 1. Shifted through Carry, 0 into MSB
8C28	FB                  SEC                                 ; Set Carry
8C29	B1 10               SBI	    A,10                        ; A = A - 10
8C2B	AE 78 84            STA	    (CUR_VAR_ADD_L)             ;
8C2E	BB 30               ORI	    A,30                        ;
8C30	51                  SIN	    (Y)                         ; (Y) = A. Then Y = Y + 1
8C31	B5 3D               LDI	    A,3D                        ;
8C33	51                  SIN	    (Y)                         ; (Y) = A. Then Y = Y + 1
8C34	CD 38               VMJ	    (38)                        ; Determines reserve memory type adress + 8 and stores it in X-Reg. 
                                                                ; Sets C=0 if 2nd reserve memory area is occupied 
8C36	BE CE C4            SJP	    SUB12                       ; Searches for reserve key code in reserve memory
8C39	91 25               BCR-    BRANCH_8C16                 ; If carry not set branch back


BRANCH_8C3B: ; Branched to from 8C43
8C3B	45                  LIN	    (X)                         ; A = (X) then INC X
8C3C	BF E0               BII	    A,E0                        ; 
8C3E	9B 2A               BZS-    BRANCH_8C16                 ; If all Bits 5,6,7 clear branch back (exit)
8C40	51                  SIN	    (Y)                         ; (Y) = A. Then Y = Y + 1
8C41	5E FD               CPI	    YL,FD                       ;
8C43	91 0A               BCR-    BRANCH_8C3B                 ; If YL < FD branch back
8C45	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; SUB_8C46 - is this reached?
; Arguments:
; Output:
; RegMod: U
SUB_8C46:
8C46	F4 78 A2            VEJ	    (F4),(PREV_LINE_H)          ; Loads U-Reg with 16-bit value from address of (PREV_LINE_H)
8C49	8E 10               BCH+    BRANCH_8C5B                 ; Uncondional branch fwd, borrow return


;------------------------------------------------------------------------------------------------------------
; SETCOM2ASCII - Called from DEV$
; Converts Baud Rate setting in SETCOM to ASCII?
; Arguments:
; Output:
; RegMod: A, X, U
SETCOM2ASCII:
8C4B	A5 78 58            LDA	    (SETCOM_REG)                ;
8C4E	B9 E0               ANI	    A,E0                        ; Keep Bits 7-5, baud rate
                                                                ; 0 = 50, 4 = 110, 6 = 200, 8 = 300, A = 600, C = 1200, E = 2400
8C50	F1                  AEX                                 ; Swap high/low nibbles of A. SETCOM_REG Bits 7-5 now 3-1
8C51	4A C0               LDI	    XL,C0                       ;
8C53	48 83               LDI	    XH,83                       ; X = 83C0. Pointer into TBL_BAUD
8C55	FD CA               ADR	    X                           ; X = 83C0 + A.      A = 0,  X = 83C0
8C57	45                  LIN	    X                           ; A = (X), INC X.            A = 00
8C58	28                  STA	    UH                          ;                           UH = 00
8C59	05                  LDA	    (X)                         ;                            A = 32
8C5A	2A                  STA	    UL                          ;                           UL = 32, U = 0032

BRANCH_8C5B: ; Branched to from 8C49
8C5B	CD 10 40            VMJ	    (10),40                     ; Transform AR-X to BCD, starting from Y in ASCII
8C5E	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; PARITY2ASCII - Called from DEV$
; Updates (Y) with ASCII charecter for Parity
; Arguments: Y = 7A1B, MATH_REG_Ua_B4
; Output: (Y) = ASCII cahrecter for Parity
; RegMod: UL, A
PARITY2ASCII:
8C5F	A5 78 58            LDA	    (SETCOM_REG)                ;
8C62	6A 4E               LDI	    UL,4E                       ; UL = 4E if (SETCOM_REG) Bit 0 not set
8C64	D5                  SHR                                 ; A = A >> 1. Shift out Bit 0
8C65	83 07               BCS+    BRANCH_8C6E                 ; If Bit 0 set skip ahead,        No Parity, UL = 4E = 'N'
8C67	6A 45               LDI	    UL,45                       ; 
8C69	D5                  SHR                                 ; A = A >> 1. Shift out Bit 1
8C6A	83 02               BCS+    BRANCH_8C6E                 ; If Bit 1 set skip ahead,      Even Parity, UL = 45 = 'E'
8C6C	6A 4F               LDI	    UL,4F                       ; else,                          Odd Parity, UL = 4F = 'O'

BRANCH_8C6E: ; Branched to from 8C65, 8C6A
8C6E	24                  LDA	    UL                          ; A = UL = ASCII charecter for Parity
8C6F	51                  SIN     Y                           ; (Y) = A then INC Y.
8C70	9A                  RTN                                 ; 



;------------------------------------------------------------------------------------------------------------
; WORDLEN2ASCII - Called from DEV$
; Updates (Y) with ASCII value for Word Length
; Arguments: Y = 7A19, MATH_REG_Ua_B2
; Output: (Y) = ASCII cahrecter for Word Length
; RegMod: A, Y, UL
WORDLEN2ASCII:
8C71	A5 78 58            LDA	    (SETCOM_REG)                ;
8C74	B9 18               ANI	    A,18                        ; Keep bits 4-3. Swap high/low nibbles of A.
8C76	F1                  AEX                                 ;  Bit 3 @ Bit 7, Bit 4 @ Bit 0
8C77	D9                  SHL                                 ; A = A << 1. Bit 7 into carry, Bit 0 into Bit 1
8C78	6A 35               LDI	    UL,35                       ; 
8C7A	22                  ADC	    UL                          ; A = A + UL. Len = 5, A = 0, A = 35 = 5
8C7B	51                  SIN     Y                           ; (Y) = A. Then Y = Y + 1
8C7C	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; STOPBIT2ASCII - Called from DEV$
; Updates (Y) with ASCII charecter for #Stop Bits
; Arguments: Y = 7A1D, MATH_REG_Ua_B6
; Output: (Y) = ASCII cahrecter for #Stop Bits
; RegMod: A, Y
STOPBIT2ASCII:
8C7D	B5 31               LDI	    A,31                        ; A = 31 = '1'
8C7F	ED 78 58 04         BII	    (SETCOM_REG),04             ; Keep Bit 2, Stop Bits
8C83	8B 01               BZS+    BRANCH_8C86                 ; If Bit 2 not set skip ahead, A = 21
8C85	DD                  INC	    A                           ; else, A = 32 = '2'

BRANCH_8C86: ; Branched to from 8C83
8C86	51                  SIN     Y                           ; (Y) = A then INC Y
8C87	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; TERMINAL - Called by command vector table by 831C
; Arguments:
; Output: 
; RegMod:
TERMINAL:
8C88	E9 78 55 7F         ANI	    (CR/LF_REG),7F              ; Clear Bit 7. What is this register used for?
8C8C	8E 09               BCH+    BRANCH_8C97                 ; Unconditional fwd branch


;------------------------------------------------------------------------------------------------------------
; DTE - Called by command vector table by 831C
; Arguments:
; Output: 
; RegMod:
DTE:
8C8E	EB 78 55 80         ORI	    (CR/LF_REG),80              ; Set Bit 7
8C92	B5 92               LDI	    A,92                        ;
8C94	BE 8B 3A            SJP     BRANCH_8B3A                 ; STA to (SETCOM) sets Buad rate in UART

BRANCH_8C97: ; Branched to from TERMINAL
8C97	C8 63               VEJ     (C8),BRANCH_8CFC            ; If following character not end to command sequence/line branch fwd BRANCH_8CFC 
8C99	F4 78 99            VEJ     (F4),(VAR/ARR_PTR_H)        ; Loads U-Reg with 16-bit value from address of (VAR/ARR_PTR_H)
8C9C	CC 67               VEJ     (CC),(67)                   ; Loads X-Reg with address at 78(67) 78(68) End of BASIC RAM (H)
8C9E	BE DF E1            SJP     DFE1                        ; U = U - X - 1. When upper limit occurs: C=0 and UH=16
8CA1	81 56               BCR+    BRANCH_8CF9                 ; If error skip to end
8CA3	4A 3A               LDI	    XL,3A                       ;
8CA5	48 00               LDI	    XH,00                       ; X = 003A
8CA7	BE DF E2            SJP     SUB85                       ; U = U - X, When upper limit occurs: C=0 and UH=16 
8CAA	81 4D               BCR+    BRANCH_8CF9                 ; If error skip to end
8CAC	6C 02               CPI	    UH,02                       ;
8CAE	81 49               BCR+    BRANCH_8CF9                 ; If UH < 02 skip to end
8CB0	F6 7A 05            VEJ     (F6),(ARX + 5)              ; Transfers U to (ARX + 5), (ARX + 5)+1
8CB3	BE 87 A3            SJP     SUB_87A3                    ; shuffle around BASIC line numbers, maybe for editing?
8CB6	C3 E0               VCS     (E0)                        ; If Carry Set Call VEJ(E0)->Indicates if UH is not "00" error message
8CB8	FD E9 F0 0A 00      ANI	    #(PC1500_MSK_REG),00        ; PC-1500 - Reset MSK Register
8CBD	BE 81 E6            SJP     IOCFG                       ; Manipulates LPT/UART registers
8CC0	B5 04               LDI	    A,04                        ;
8CC2	AE 78 95            STA	    (USING_F/F)                 ; Using format, presence of decimal point, comma,etc
8CC5	CC 5D               VEJ     (CC),(5D)                   ; Loads X-Reg with address at 78(5D) 78(5E), KEYBOARD derivation flag
8CC7	CA BE               VEJ     (CA),(BE)                   ; Transfers X to 78(BE), 78(BF) DATA POINTER (H)/(L)
8CC9	6A 40               LDI	    UL,40                       ;
8CCB	68 11               LDI	    UH,11                       ; U = 1140
8CCD	F6 76 4E            VEJ     (F6),(HIGHLCDFLAG)          ; Transfers U to (HIGHLCDFLAG), (HIGHLCDFLAG) + 1
8CD0	CC 99               VEJ     (CC),(99)                   ; Loads X-Reg with address at 78(99) 78(9A), STRING VAR I$ Byte 9,10?
8CD2	B5 C6               LDI	    A,C6                        ;
8CD4	FD CA               ADR	    X                           ; X = X + A, X = 003A + C6 = 100?
8CD6	FD 42               DEC	    XH                          ; X = FF?
8CD8	CA 93               VEJ     (CA),(93)                   ; Transfers X to 78(93), 78(94), Data pointer, Pointer operations
8CDA	BE 8F C1            SJP     SUB_8FC1                    ; Copies 20 bytes to or from String Var P$
8CDD	A5 78 56            LDA	    (ZONE_REG)                  ;
8CE0	B9 60               ANI	    A,60                        ; Keep Bits 6-5
8CE2	D5                  SHR                                 ; A = A >> 1. Shifted through Carry, 0 into MSB
8CE3	BB 0A               ORI	    A,0A                        ; Set Bits 3, 1
8CE5	ED 78 55 80         BII	    (CR/LF_REG),80              ; 
8CE9	8B 02               BZS+    BRANCH_8CED                 ; If Bit 7 was not set
8CEB	B3 03               ADI	    A,03                        ; A = A + 03

BRANCH_8CED: ; Branched to from 8CE9
8CED	AE 78 B4            STA	    (ERRORLINE)                 ; ERROR LINE (Line number where error is met) (H)
8CF0	68 99               LDI	    UH,99                       ;
8CF2	6A AA               LDI	    UL,AA                       ; U = 99AA = SUB_99E6_ALT_E1
8CF4	F6 79 FB            VEJ     (F6),(UNDEF_REG_79FB)       ; Transfers U to (UNDEF_REG_79FB), (UNDEF_REG_79FB)+1
8CF7	8E 10               BCH+    BRANCH_8D09                 ; Unconditional fwd branch

BRANCH_8CF9: ; Branched to from 8CA1, 8CAA, 8CF9
8CF9	68 33               LDI	    UH,33                       ;
8CFB	E0                  VEJ     (E0)                        ; Indicates if UH is not "00" error message

BRANCH_8CFC: ; Branched to from 8C97
8CFC	E4                  VEJ     (E4)                        ; Output error 1 and return to the editor



;------------------------------------------------------------------------------------------------------------
; JMP_8D04 - Called from SUB_PRINT#:90F5
; Alt entry at 8D08 Called from 8FC1:8EE1, Jumped to from JUMP_TBL_915F
; Resets CE-150, LCD annuncuiators, jumps to new code
; Arguments:
; Output: 
; RegMod: A, U, X
;
; JMP_8CFD - Jumped to from SUB_PRINT#_ALT_X1:910A, JMP_94F4:9581, SUB_99E6_ALT_E1:9A51
; Looks like it is setting up A before SUB_8D04 which
JMP_8CFD: ;Branched to from 8D02
8CFD	B5 04               LDI	    A,04                        ;
8CFF	8E 0A               BCH+    SUB_8D04_ALT_E1             ; Unconditional fwd branch

; How is this reached?
8D01	A4                  LDA	    UH                          ;
8D02	99 07               BZR-    JMP_8CFD                    ; If UH != 0  branch back


SUB_8D04:
8D04	FD E9 F0 0B FD      ANI	    #(PC1500_IF_REG),FD         ; PC-1500 - Clear Bit1, PB7 Interrupt (Power button)

BRANCH_8D09: ; Branched to from 8CF7
8D09	B5 00               LDI	    A,00                        ;

SUB_8D04_ALT_E1: ; Called from 8FC1:8EE1
8D0B	FD E9 F0 0A FC      ANI	    #(PC1500_MSK_REG),FC        ; PC-1500 - Clear mask for IRQ and PB7 (ON button)
8D10	BE 9F D0            SJP	    SUB_9FD0                    ; Sets DTR/RTS based on OUTSTAT_REG
8D13	FD C8               PSH	    A                           ;
8D15	B5 9A               LDI	    A,9A                        ;
8D17	AE 79 FA            STA	    (UNDEF_REG_79FA)            ;
8D1A	FB                  SEC                                 ; Set carry flag
8D1B	BE 8F C2            SJP	    SUB_8FC2                    ; Copies 20 bytes to or from String Var P$
8D1E	FD E9 B0 0F BF      ANI	    #(CE150_PRT_B),BF           ; Clear Bit 6, Low Battery
8D23	FD EB B0 0D 40      ORI	    #(CE150_PRT_B_DIR),40       ; Set Bit 6 to Write
8D28	BE 9F EF            SJP	    SUB_9FEF                    ; CE-150 - Clears Pen Descending signal, and applies it again if safe.
8D2B	FD E9 D0 0A FD      ANI	    #(CE158_MSK_REG),FD         ; Clear Bit 1, interrupt mask for PB7, Paper feed button
8D30	FD EB F0 0A 01      ORI	    #(PC1500_MSK_REG),01        ; PC-1500 Set Bit0 IRQ mask
8D35	6A 4E               LDI	    UL,4E                       ;
8D37	68 76               LDI	    UH,76                       ; U = 764E, LCD annunciators
8D39	6B 01               ORI	    (U),01                      ; Set Bit 0, (BUSY)
8D3B	69 7D               ANI	    (U),7D                      ; Clear Bit 1 (SHIFT), 7 (??)
8D3D	64                  INC	    U                           ; U = 764F, LCD annunciators
8D3E	69 70               ANI	    (U),70                      ; Keep Bits 6 (RUN), 5 (PRO), 4 (RESERVE)
8D40	BE D0 34            SJP	    SUB25                       ; Writes over input buffer with 0D
8D43	FD 8A               POP	    A                           ;
8D45	BE 87 36            SJP	    TERMTXT_DISP                ; Copies text string from TEXT_84EF to Display
8D48	6A 3F               LDI	    UL,3F                       ;
8D4A	68 00               LDI	    UH,00                       ; U = 003F
8D4C	BE E8 8C            SJP	    SBRAC                       ; Time delay 15,625 ms * Number from U-Reg.BREAK is possible

BRANCH_8D4F: ; Branched to from 8DC8, 8F86
8D4F	FD C1               SDP                                 ; Sets LCD ON/OFF control flip-flop
8D51	BE D0 34            SJP	    SUB25                       ; Writes over input buffer with 0D
8D54	A5 78 95            LDA	    (USING_F/F)                 ; Using format, presence of decimal point, comma,etc
8D57	6A 17               LDI	    UL,17                       ;
8D59	D5                  SHR                                 ; A = A >> 1. Shifted through Carry, 0 into MSB
8D5A	83 0F               BCS+    BRANCH_8D6B                 ; If (USING_F/F) Bit 0 was set, branch fwd UL = 17
8D5C	6A 01               LDI	    UL,01                       ;
8D5E	D5                  SHR                                 ; A = A >> 1. Shifted through Carry, 0 into MSB
8D5F	83 0A               BCS+    BRANCH_8D6B                 ; If (USING_F/F) Bit 1 was set, branch fwd UL = 01
8D61	6A 18               LDI	    UL,18                       ;
8D63	D5                  SHR                                 ; A = A >> 1. Shifted through Carry, 0 into MSB
8D64	83 05               BCS+    BRANCH_8D6B                 ; If (USING_F/F) Bit 2 was set, branch fwd UL = 18
8D66	60                  INC	    UL                          ; UL = 19
8D67	D5                  SHR                                 ; A = A >> 1. Shifted through Carry, 0 into MSB
8D68	83 01               BCS+    BRANCH_8D6B                 ; If (USING_F/F) Bit 3 was set, branch fwd UL = 19
8D6A	60                  INC	    UL                          ; UL = 20

BRANCH_8D6B: ; Branched to from 8D5A, 8D5F, 8D64, 8D68
8D6B	24                  LDA	    UL                          ; UL = 17, 01, 18, 19, 20 from above
8D6C	D9                  SHL                                 ; A = A << 1. A = 2E, 02, 30, 32, 40
8D6D	BE 87 36            SJP	    TERMTXT_DISP                ; Displays text string from TEXT_84EF index by A

BRANCH_8D70: ; Branched to from 8DAD, BRANCH_TBL_8DD9
8D70	BE 99 8D            SJP	    SUB_998D                    ; Something with LCD annunciators and last key pressed reg
8D73	AA 78 4F            LDI	    S,SYSTEMSTACKBASE           ; (Stack Pointer) S = SYSTEMSTACKBASE
8D76	B7 14               CPI	    A,14                        ; Is A from table index above?
8D78	81 22               BCR+    BRANCH_8D9C                 ; If A < 14 branch fwd
8D7A	B7 17               CPI	    A,17                        ;   else A >= 14
8D7C	83 1E               BCS+    BRANCH_8D9C                 ; If A >= 17 branch fwd
8D7E	B1 16               SBI	    A,16                        ; A=14~16. A = A - 16. 14->(1c FE), 15->(1c FF), 16->(0c 00)
8D80	2A                  STA	    UL                          ;
8D81	A5 78 95            LDA	    (USING_F/F)                 ; $7895 Bit 7: Scientific, Bit 6: asterisk fill, Bit 5: Forced sign, 
                                                                ; Bit 4: Comma,  Bits 3,2,1: used in this ROM for??, Bit 0: used in checking syntax
8D84	B9 1F               ANI	    A,1F                        ; Clear Bits 7-5.

BRANCH_8D86: ; Branched to from 8D8C                            ; 7895 =                01      02      04      08      10
8D86	60                  INC	    UL                          ; UL in = 14, UL out    01      04      07      0A      0D
8D87	60                  INC	    UL                          ; UL in = 15, UL out    02      05      08      0B      0E
8D88	60                  INC	    UL                          ; UL in = 16, UL out    03      06      09      0C      0F <- overshoots table
8D89	D5                  SHR                                 ; 
8D8A	83 02               BCS+    BRANCH_8D8E                 ; 
                                                                ; 
8D8C	99 08               BZR-    BRANCH_8D86                 ; 

BRANCH_8D8E: ; Branchded to from 8D8A
8D8E	24                  LDA	    UL                          ; A = UL = table above
8D8F	6A D9               LDI	    UL,D9                       ; 
8D91	68 8D               LDI	    UH,8D                       ; U = 8DD9, BRANCH_TBL_8DD9
8D93	D9                  SHL                                 ; A = A << 1. A = A * 2
8D94	FD EA               ADR	    U                           ; U = U + A. 
8D96	65                  LIN	    U                           ; A = (U) then INC U. 
8D97	08                  STA	    XH                          ; 
8D98	25                  LDA	    (U)                         ; A = (U)
8D99	0A                  STA	    XL                          ; X = 8E97, 8E9B, 8EA8
8D9A	FD 5E               STX	    P                           ; P = X. Set Program Counter to X ***JMP


BRANCH_8D9C: ; Branced to from 8D78, 8D7C
8D9C	CD 34 06            VMJ	    (34),06,                    ; 06 + 1 = # of two byte arguments following (vectors)
           09 EB                      09,8E8C,                  ; 09->Horz Tab (HT), EB->Branch Fwd to 8E8C
           0A 18                      0A,8DBB,                  ; 0A->Line Feed (LF), 18->Branch Fwd to 8DBB,
           0B 25                      0B,8DCA,                  ; 0B->Vert Tab (VT), 25->Branch Fwd to 8DCA,
           0E 12                      0E,8DB9,                  ; 0E->Shft-Out (SO), 0E->Branch Fwd to 8DB9,
           13 06                      13,8DAF,                  ; 13->Dev Cont 3 (DC3), 06->Branch Fwd to 8DAF,
           19 E6                      19,8E91,                  ; 19->End of Medium (EM), E6->Branch Fwd to 8E91,
           5B 28                      5B,8DD5                   ; 5B->'[', 28->Branch Fwd to 8DD5

8DAD	9E 3F               BCH-    BRANCH_8D70                 ; Unconditional branch back

; rest of this dedicated to modifying (USING_F/F) - Using format, presence of decimal point, comma,etc
BRANCH_8DAF: ; Branched to from 8D9C VMJ
8DAF	B5 14               LDI	    A,14                        ;
8DB1	ED 78 95 10         BII	    (USING_F/F),10              ; Using format, presence of decimal point, comma,etc
8DB5	9B 47               BZS-    BRANCH_8D70                 ; If Bit 4 was not set branch back
8DB7	8E 6A               BCH+    BRANCH_8E23                 ; Unconditional fwd branch

BRANCH_8DB9: ; Branched to from 8D9C VMJ
8DB9	9E B7               BCH-    SUB_8D04                    ; Unconditional back branch

BRANCH_8DBB: ; Branched to from 8D9C VMJ
8DBB	A5 78 95            LDA	    (USING_F/F)                 ; Using format, presence of decimal point, comma,etc
8DBE	B9 0F               ANI	    A,0F                        ; Keep Bits 3-0
8DC0	D5                  SHR                                 ; A = A >> 1. Shift through carry. 0 into MSB
8DC1	89 02               BZR+    BRANCH_8DC5                 ; If Bit 0 was not set branch fwd
8DC3	B5 08               LDI	    A,08                        ;

BRANCH_8DC5: ; Branched to from 8DC1, 8DD0, 8DD3, 8DD7
8DC5	AE 78 95            STA	    (USING_F/F)                 ; Change (USING_F/F) with A from above
8DC8	9E 7B               BCH-    BRANCH_8D4F                 ; Unconditional back branch

BRANCH_8DCA: ; Branched to from 8D9C VMJ
8DCA	A5 78 95            LDA	    (USING_F/F)                 ; Using format, presence of decimal point, comma,etc
8DCD	D9                  SHL                                 ; A = A << 1. 7 6 5 4 3 2 1 0  to  6 5 4 3 2 1 0 x
8DCE	B9 0F               ANI	    A,0F                        ; Keep Bits 3-0   x x x x 2 1 0 x
8DD0	99 0D               BZR-    BRANCH_8DC5                 ; If any Bit 3-0 was set branch back
8DD2	DD                  INC	    A                           ; A = A + 1
8DD3	9E 10               BCH-    BRANCH_8DC5                 ; Unconditional back branch

BRANCH_8DD5: ; Branched to from 8D9C VMJ
8DD5	B5 10               LDI	    A,10                        ;
8DD7	9E 14               BCH-    BRANCH_8DC5                 ; Unconditional back branch



;------------------------------------------------------------------------------------------------------------
; Branch table used by BRANCH_8D8E - used by 8D9A
BRANCH_TBL_8DD9:
8DD9	8E 97               .BYTE   8E 97                       ; BRANCH_8E97
8DDB	8E 9B               .BYTE   8E 9B                       ; BRANCH_8E9B
8DDD	8E A8               .BYTE   8E A8                       ; BRANCH_8EA8
8DDF	8E 1A               .BYTE   8E 1A                       ; BRANCH_8E1A
8DE1	8E 1C               .BYTE   8E 1C                       ; BRANCH_8E1C
8DE3	8E 1E               .BYTE   8E 1E                       ; BRANCH_8E1E
8DE5	8E 31               .BYTE   8E 31                       ; BRANCH_8E31
8DE7	8E 32               .BYTE   8E 32                       ; BRANCH_8E32
8DE9	8D F7               .BYTE   8D F7                       ; BRANCH_8DF7
8DEB	8E 1D               .BYTE   8E 1D                       ; BRANCH_8E1D
8DED	8E 17               .BYTE   8E 17                       ; BRANCH_8E17
8DEF	8D 70               .BYTE   8D 70                       ; BRANCH_8D70
8DF1	8E 1B               .BYTE   8E 1B                       ; BRANCH_8E1B
8DF3	8E 18               .BYTE   8E 18                       ; BRANCH_8E18
8DF5	8E 19               .BYTE   8E 19                       ; BRANCH_8E19



;------------------------------------------------------------------------------------------------------------
; BRANCH_8DF7: ; Branched to from BRANCH_TBL_8DD9
; Resets some things and then does warm boot
; Arguments: 
; Output: 
; RegMod: U, X
BRANCH_8DF7:
8DF7	6A 43               LDI	    UL,43                       ;
8DF9	68 40               LDI	    UH,40                       ; U = 4043
8DFB	F6 76 4E            VEJ	    (F6),(HIGHLCDFLAG)          ; Saves U-Reg to (HIGHLCDFLAG)
8DFE	CC BE               VEJ	    (CC),BE                     ; Loads X-Reg with address at 78(pp) 78(pp+1). DATA POINTER
8E00	CA 5D               VEJ	    (CA),(5D)                   ; Transfers X to 78(5D), 78(5E). KEYBOARD derivation
8E02	BE 8A 2A            SJP	    PORTS_UPDATE                ; 785D = KEYBOARD derivation flag Bit7=1 SPV, Bit7=0 RPV
8E05	FD E9 B0 0D BF      ANI	    #(CE150_PRT_B_DIR),BF       ; CE-150 - Bit 6 input, rest output
8E0A	FD EB F0 0A 01      ORI	    #(PC1500_MSK_REG),01        ; PC-1500 - Set interrupt mask bit for IRQ
8E0F	FD EB B0 0A 03      ORI	    #(CE150_MSK_REG),03         ; CE-150 - Set interrupt mask bit for IRQ, PB7 (Busy input)
8E14	BA CA 55            JMP	    CA55                        ; Clear All then Warm boot


BRANCH_8E17: ; Branched to from BRANCH_TBL_8DD9
8E17	F9                  REC                                 ; Reset Carry flag

BRANCH_8E18: ; Branched to from BRANCH_TBL_8DD9
8E18	F9                  REC                                 ; Reset Carry flag

BRANCH_8E19: ; Branched to from BRANCH_TBL_8DD9
8E19	F9                  REC                                 ; Reset Carry flag

BRANCH_8E1A: ; Branched to from BRANCH_TBL_8DD9
8E1A	F9                  REC                                 ; Reset Carry flag

BRANCH_8E1B: ; Branched to from BRANCH_TBL_8DD9
8E1B	F9                  REC                                 ; Reset Carry flag

BRANCH_8E1C: ; Branched to from BRANCH_TBL_8DD9
8E1C	F9                  REC                                 ; Reset Carry flag

BRANCH_8E1D: ; Branched to from BRANCH_TBL_8DD9
8E1D	F9                  REC                                 ; Reset Carry flag

BRANCH_8E1E: ; Branched to from BRANCH_TBL_8DD9
8E1E	B5 12               LDI	    A,12                        ; X = Program Counter of branch address here up
8E20	FD CA               ADR	    X                           ; X = X + A, i.e. X = 8E1E + 12 = 8E30 if jumped to directly
8E22	05                  LDA	    (X)                         ; Indexing into TBL_8E29 below

BRANCH_8E23: ; Branched to from 8DB7
8E23	AE 78 B6            STA	    (ERROR_TOP_H)               ;
8E26	BA 8E EF            JMP	    JMP_8EEF                    ; May jump to new code or parse then jump to new code


TBL_8E29: ; Used by code directly above
8E29	0A 10 12 20        .BYTE    0A 10 12 20                 ; byte form table poked into (ERROR_TOP_H)
8E2D    0C 22 0E 16        .BYTE    0C 22 0E 16                 ;


BRANCH_8E31: ; Branched to from BRANCH_TBL_8DD9
8E31	F9                  REC                                 ; Reset Carry flag

BRANCH_8E32: ; Branched to from BRANCH_TBL_8DD9
8E32	FD 88               PSH	    X                           ; X = Program Counter i.e. 8E31, 8E32
8E34	BE 8A 2A            SJP	    PORTS_UPDATE                ;
8E37	BE 8F C1            SJP	    SUB_8FC1                    ; Copies 20 bytes to or from String Var P$
8E3A	B5 02               LDI	    A,02                        ;
8E3C	AE 79 F4            STA	    (79F4)                      ; CSIZE (Printing character size select)
8E3F	B5 00               LDI	    A,00                        ;
8E41	AE 79 EA            STA	    (79EA)                      ; Printer LINE TYPE
8E44	AE 79 F2            STA	    (79F2)                      ; ROTATE (Printing direction select)
8E47	BE 9C 92            SJP	    SUB_9C92                    ; Something to do with CE-150
8E4A	48 D8               LDI	    XH,D8                       ;
8E4C	4A B0               LDI	    XL,B0                       ; X = D8B0, inside a program line in main ROM
8E4E	CA B2               VEJ	    (CA),(B2)                   ; Transfers X to 78(B2), 78(B3). ERROR ADDRESS
8E50	6A 02               LDI	    UL,02                       ; 
8E52	BA 83 80            JMP	    JMP_8380                    ; Jumps to 8380, then jumps back immediatly below
                                                                ; If Jap. market & SETCOM cfgd as 7 Data Bits A = 0A, else A = UL

JMP_8E55: ; Jumped to from 83A1, Jumped here from 8E52 through JMP_8380
8E55	CC A0               VEJ	    (CC),(A0)                   ; Loads X-Reg with address at 78(A0) 78(A1). PREVIOUS ADDRESS
8E57	CA A6               VEJ	    (CA),(A6)                   ; Transfers X to 78(5D), 78(5E). KEYBOARD derivation
8E59	EB 78 A8 80         ORI	    (78A8),80                   ; SEARCH LINE (H)
8E5D	F4 78 A2            VEJ     (F4),(PREV_LINE_H)          ; Loads U-Reg with 16-bit value from address of (PREV_LINE_H)
8E60	66                  DEC	    U                           ;
8E61	BE D3 C5            SJP	    D3C5                        ; Deletes U-bytes from where X points
8E64	BE 98 E8            SJP	    SUB_98E8                    ; Updates LCD?
8E67	FD 0A               POP	    X                           ; X = Program Counter i.e. 8E31, 8E32 entry address
8E69	4E 32               CPI	    XL,32                       ; Did we enter at 8E32
8E6B	89 56               BZR+    BRANCH_8EC3                 ; If not branch fwd
8E6D	B5 08               LDI	    A,08                        ;
8E6F	AE 78 84            STA	    (CUR_VAR_ADD_L)             ;

8E72	CD 38               VMJ	    (38)                        ; Determines reserve memory start address+8 and sets it in X. 
                                                                ;  Sets C=0 if 2nd reserve memory area is occupied
8E74	BE CE C4            SJP	    SUB12                       ; Searches for reserve key code in reserve memory
8E77	81 4A               BCR+    BRANCH_8EC3                 ;  Sub returns carry set if success 
8E79	FD 88               PSH	    X                           ; XL was altered by sub
8E7B	BE 87 80            SJP	    IRQ_RESET_ALT_E1            ; #(CE158_PRT_A) Clear Bits 1-0 (ME1), Bit 0 = DTR, Bit 1 = RTS
8E7E	6A 40               LDI	    UL,40                       ;
8E80	68 00               LDI	    UH,00                       ; U = 0040
8E82	BE E8 8C            SJP	    SBRAC                       ; Time delay 15,625 ms * Number from U-Reg.BREAK is possible
8E85	FD 0A               POP	    X                           ; Maybe X was altered by SBRAC?
8E87	BE 87 45            SJP	    STRNG_2COM                  ; Sends string to RS232. X is set with source table address?
8E8A	8E 37               BCH+    BRANCH_8EC3                 ;  

BRANCH_8E8C: ; Branched to from 89DC
8E8C	BE 96 00            SJP	    SUB_9600                    ; Something to do with LCD, than jumps to main ROM. How do we get back here?
8E8F	8E 03               BCH+    BRANCH_8E94                 ;

BRANCH_8E91: ; Branched to from 8D9C VMJ
8E91	BE 95 C6            SJP	    SUB_95C6                    ; Might display text for terminal program?

BRANCH_8E94: ; Branched to from 8E8F, 8EAE
8E94	BA 8D 70            JMP	    BRANCH_8D70                 ; Jumps to the insane tabel indexing code


BRANCH_8E97: ; Branched to from BRANCH_TBL_8DD9
8E97	6A 40               LDI	    UL,40                       ;
8E99	8E 0F               BCH+    BRANCH_8EAA                 ; Unconditional fwd branch


BRANCH_8E9B: ; Branched to from BRANCH_TBL_8DD9
8E9B	6A 20               LDI	    UL,20                       ;
8E9D	B5 FE               LDI	    A,FE                        ;
8E9F	AE 78 AE            STA	    (78AE)                      ; BREAK LINE
8EA2	E9 78 AF 00         ANI	    (78AF),00                   ; BREAK LINE set to FE00. Vectro to DCB7
                                                                ; DCB7 - Checks if UL in interval D1-D2 at Token in U-Reg 
                                                                ;  if interval exceeded continue at Error Return Address.
8EA6	8E 02               BCH+    BRANCH_8EAA                 ; Unconditional fwd branch


BRANCH_8EA8: ; Branched to from BRANCH_TBL_8DD9
8EA8	6A 10               LDI	    UL,10                       ; UL set to 40, 20, 10 based on branch point from BRANCH_TBL_8DD9

BRANCH_8EAA: ; Branched to from 8EA6
8EAA	24                  LDA	    UL                          ;
8EAB	AE 76 4F            STA	    (LOWLCDFLAG)                ; Sets LCD indicators DE, G, RAD, etc.
8EAE	9E 1C               BCH-    BRANCH_8E94                 ; Unconditional back branch

; Not sure how this is reached?
8EB0	B5 80               LDI	    A,80                        ;
8EB2	AD 78 B4            EOR	    (ERRORLINE)                 ;
8EB5	BF 80               BII	    A,80                        ;
8EB7	8B 04               BZS+    BRANCH_8EBD                 ; If Bit 7 set branch forward
8EB9	BF 40               BII	    A,40                        ;
8EBB	9B 29               BZS-    BRANCH_8E94                 ; If Bit 2 set branch back


BRANCH_8EBD: ; Branched to from 8EB7
8EBD	AE 78 B4            STA	    (ERRORLINE)                 ; 
8EC0	BA 8D 70            JMP	    BRANCH_8D70                 ; Jumps to the insane tabel indexing code


BRANCH_8EC3: ; Branched to from 8E6B, 8E77, 8E8A
8EC3	BE 87 6C            SJP	    IRQ_RESET                    ; Resets IRQ masks for CE-150, CE-158
8EC6	E9 78 B1 00         ANI	    (78B1),00                   ; Clear register. BREAK TOP (L)
8ECA	BE 98 02            SJP	    SUB_9802                    ; Resets last pressed key register and repeat speed.
8ECD	FD EB F0 0A 01      ORI	    #(PC1500_MSK_REG),01        ; PC-1500 - Set interrupt mask for IRQ
8ED2	B5 BA               LDI	    A,BA                        ;
8ED4	AE 79 FA            STA	    (UNDEF_REG_79FA)            ; Well, it is undefined
8ED7	BA 96 87            JMP	    SUB_INPUT#_ALT_E1           ;



;------------------------------------------------------------------------------------------------------------
; JMP_8EEF - Jumped to from 8E26, Branched to from 8F64
; Maybe terminal related?
; Arguments: 
; Output: 
; RegMod: A
BRANCH_8EDA: ; Branched to from 8F6A
8EDA	BE 8A AD            SJP	    PORTS_UPDATE_ALT_E2         ;
8EDD	B5 06               LDI	    A,06                        ;
8EDF	81 03               BCR+    BRANCH_8EE4                 ; Carry was set in sub

BRANCH_8EE1: ; Branched to from 8EED
8EE1	BA 8D 0B            JMP	    SUB_8D04_ALT_E1             ; Resets CE-150, LCD annuncuiators, jumps to new code

BRANCH_8EE4: ; Branched to from 8EDF
8EE4	E9 78 B6 FE         ANI	    (ERROR_TOP_H),FE            ; Clear Bit 0
8EE8	A5 78 B6            LDA	    (ERROR_TOP_H)               ;
8EEB	B7 20               CPI	    A,20                        ;
8EED	9B 0E               BZS-    BRANCH_8EE1                 ; If A = 20 branch back

JMP_8EEF: ; Jumped to from 8E26, Branched to from 8F64
8EEF	BE 8B CE            SJP	    SUB_8BCE                    ; Not sure

BRANCH_8EF2: ; Branched to from 8FBE
8EF2	14                  LDA	    YL                          ;
8EF3	AE 78 8B            STA	    (788B)                      ; INPUT BUFFER POINTER
8EF6	B5 40               LDI	    A,40                        ;
8EF8	AE 78 80            STA	    (7880)                      ; Display parameter. Bit 7 = 1 is BREAK.
8EFB	BE D0 21            SJP	    D021                        ; Deletes rest of the Input buffer with "0D"

BRANCH_8EFE: ; Branched to from 8F0D, 8F10, 8F1D, 8F26, 8F30
8EFE	BE E8 CA            SJP	    PRGMDISP                    ; Display content of display buffer
8F01	BE 99 8D            SJP	    SUB_998D                    ; Resets last pressed key register, repeat speed, LCD annunciators
8F04	AA 78 4F            LDI	    S,SYSTEMSTACKBASE           ; Load SYSTEMSTACKBASE into SP register (Stack Pointer)
8F07	B7 20               CPI	    A,20                        ; Where did A come from
8F09	81 07               BCR+    BRANCH_8F12                 ; If A < 20 branch fwd

BRANCH_8F0B: ; Branched to from 8F3B
8F0B	1E                  STA	    (Y)                         ; What is Y here?
8F0C	50                  INC	    YL                          ;
8F0D	91 11               BCR-    BRANCH_8EFE                 ; If YL did not overflow, branch back
8F0F	52                  DEC	    YL                          ;
8F10	9E 14               BCH-    BRANCH_8EFE                 ; Unconditional branch back

BRANCH_8F12: ; Branched to from 8F09                            ; Checks characters in UL for presets in table. 
8F12	CD 34 03            VMJ	    (34),03,                    ; 03 + 1 = # of two byte arguments following (vectors)
	   0D 26                      0D,BRANCH_8F3D,           ; 0D = CR
           0A 19                      0A,BRANCH_8F32,           ; 0A = LF
           0E 04                      0E,BRANCH_8F1F,           ; 0E = Shift Out (SO) / XON
           08 05                      08,BRANCH_8F22            ; 08 = Back Space

8F1D	9E 21               BCH-    BRANCH_8EFE                 ; Unconditional branch back

BRANCH_8F1F: ; Branched to from 8F12
8F1F	BA 8D 04            JMP	    SUB_8D04                    ; Resets CE-150, LCD annuncuiators, jumps to new code

BRANCH_8F22: ; Branched to from 8F12                            ; Hanldes Back Space charecter?
8F22	A5 78 8B            LDA	    (788B)                      ; INPUT BUFFER POINTER
8F25	16                  CPA	    YL                          ;
8F26	9B 2A               BZS-    BRANCH_8EFE                 ;
8F28	52                  DEC	    YL                          ;
8F29	B5 0D               LDI	    A,0D                        ; 0D = CR
8F2B	1E                  STA	    (Y)                         ; What is Y here?
8F2C	EB 7B 0E 40         ORI	    (7B0E),40                   ; Character to blink
8F30	9E 34               BCH-    BRANCH_8EFE                 ; Unconditional branch back

BRANCH_8F32: ;Branched to from  8F37 VMJ                        ; Hanldes LF charecter?
8F32	B5 21               LDI	    A,21                        ;
8F34	A7 78 B6            CPA	    (ERROR_TOP_H)               ;
8F37	89 04               BZR+    BRANCH_8F3D                 ; If A != (ERROR_TOP_H)
8F39	B5 40               LDI	    A,40                        ;
8F3B	9E 32               BCH-    BRANCH_8F0B                 ; Unconditional branch back

BRANCH_8F3D: ; Branched to from 8F12, 8F37 VMJ                  ; Hanldes CR charecter?
8F3D	14                  LDA	    YL                          ;
8F3E	0A                  STA	    XL                          ;
8F3F	A5 78 8B            LDA	    (788B)                      ; INPUT BUFFER POINTER
8F42	1A                  STA	    YL                          ;
8F43	15                  LDA	    (Y)                         ; What are Y and X here?
8F44	B7 0D               CPI	    A,0D                        ; 0D = CR
8F46	89 1E               BZR+    BRANCH_8F66                 ; If A != 0D

BRANCH_8F48: ; Branched to from 8F94
8F48	A5 78 B6            LDA	    (ERROR_TOP_H)               ;
8F4B	DD                  INC	    A                           ; A = (ERROR_TOP_L)
8F4C	BF 01               BII	    A,01                        ;
8F4E	8B 01               BZS+    BRANCH_8F51                 ; If A != 01
8F50	DD                  INC	    A                           ;

BRANCH_8F51: ; Branched to from 8F46
8F51	AE 78 B6            STA	    (ERROR_TOP_H)               ;
8F54	B7 18               CPI	    A,18                        ; 18 = Cancel
8F56	81 2E               BCR+    BRANCH_8F86                 ; If A < 18 branch 
8F58	B7 20               CPI	    A,20                        ; 20 = Space
8F5A	8B 2A               BZS+    BRANCH_8F86                 ; If A != 20
8F5C	B7 22               CPI	    A,22                        ; 22 = #
8F5E	8B 26               BZS+    BRANCH_8F86                 ; If A != 22
8F60	B7 2E               CPI	    A,2E                        ; 2E = .
8F62	83 22               BCS+    BRANCH_8F86                 ; If A >=  2E
8F64	9E 77               BCH-    JMP_8EEF                    ; Unconditional back branch

BRANCH_8F66: ; Branched to from 8F46
8F66	ED 78 B6 01         BII	    (ERROR_TOP_H),01            ;
8F6A	99 92               BZR-    BRANCH_8EDA                 ; If Bit 0 was set
8F6C	55                  LIN     Y                           ; A = (Y) then INC Y
8F6D	B7 59               CPI	    A,59                        ; 59 = Y
8F6F	8B 18               BZS+    BRANCH_8F89                 ; If A = 59 branch fwd
8F71	B7 4E               CPI	    A,4E                        ; 4E = N
8F73	89 11               BZR+    BRANCH_8F86                 ; If != 4E branch fwd
8F75	A5 78 B6            LDA	    (ERROR_TOP_H)               ;
8F78	B7 16               CPI	    A,16                        ; 16 = SYN, Syncronous Idle?
8F7A	83 37               BCS+    BRANCH_8FB3                 ; If A >= 16 branch fwd
8F7C	BE 86 F0            SJP	    SUB_86F0                    ; Calculates a new address to set P to (Program Counter)

;------------
; Nonsense
8F7F	06                  CPA	    XL                          ; Bitwise compre of A + XL
8F80	21                  SBC	    (U)                         ; A = A - (U) w/carry
8F81	24                  LDA	    UL                          ; A = UL
8F82	27                  CPA	    (U)                         ; Bitwise compre of A + (U)
8F83	16                  CPA	    YL                          ; Bitwise compre of A + YL
8F84	19                  AND	    (Y)                         ; A = A & (Y)
8F85	10                  SBC	    YL                          ; A = A - YL
; Nonsense
;-------------

BRANCH_8F86: ; Branched to from 8F56, 8F5A, 8F5E, 8F62, 8F73, 8F8E, 8FB5
8F86	BA 8D 4F            JMP	    BRANCH_8D4F                 ; Jumps to the crazy lookup table jump code

BRANCH_8F89: ; Branched to from 8F6F
8F89	A5 78 B6            LDA	    (ERROR_TOP_H)               ;
8F8C	B7 16               CPI	    A,16                        ; 16 = SYN, Syncronous Idle?
8F8E	91 0A               BCR-    BRANCH_8F86                 ; If A < 16 branch back
8F90	B7 20               CPI	    A,20                        ; 20 = Space
8F92	83 23               BCS+    BRANCH_8FB7                 ; If A >= 20 branch fwd
8F94	9E 4E               BCH-    BRANCH_8F48                 ; Unconditional branch back A > 16 & A < 20


; How is this reached? 
8F96	B5 40               LDI	    A,40                        ; 50 = @
8F98	8E 12               BCH+    BRANCH_8FAC                 ; Unconditional fwd branch
8F9A	B5 08               LDI	    A,08                        ; 08 = Back Space
8F9C	8E 0E               BCH+    BRANCH_8FAC                 ; Unconditional fwd branch
8F9E	B5 01               LDI	    A,01                        ; 01 = SOH Start of Heading
8FA0	8E 0A               BCH+    BRANCH_8FAC                 ; Unconditional fwd branch
8FA2	B5 04               LDI	    A,04                        ; 04 = EOT End of Transmission
8FA4	8E 06               BCH+    BRANCH_8FAC                 ; Unconditional fwd branch
8FA6	B5 80               LDI	    A,80                        ; 80 = past printable ASCII
8FA8	8E 02               BCH+    BRANCH_8FAC                 ; Unconditional fwd branch
8FAA	B5 02               LDI	    A,02                        ; 02 = SOT Start of Text


BRANCH_8FAC: ; Branched to from 8F98, 8F9C, 8FA0, 8FA4, 8FA8
8FAC	AD 78 B4            EOR	    (ERRORLINE)                 ; A = A ^ (ERRORLINE)
8FAF	AE 78 B4            STA	    (ERRORLINE)                 ; Setting error type/cause?
8FB2	9A                  RTN                                 ;

BRANCH_8FB3: ; Branched to from 8F7A                            ; Got here is A >= 16
8FB3	B7 20               CPI	    A,20                        ; 20 = Space
8FB5	93 31               BCS-    BRANCH_8F86                 ; If A >= 20 branch back

BRANCH_8FB7: ; Branched to from 8F92                            ; If dropped through A >= 16 and A < 20
8FB7	EF 78 B6 01         ADI	    (ERROR_TOP_H),01            ; Set error type
8FBB	B5 20               LDI	    A,20                        ;
8FBD	51                  SIN     Y                           ; (Y) = A. Then Y = Y + 1
8FBE	BA 8E F2            JMP	    BRANCH_8EF2                 ; Keep parsing ?



;------------------------------------------------------------------------------------------------------------
; SUB_8FC1: ; Called from 8D04:8E37, 8CDA
; Copies 20 bytes to/from String Var P$
; Arguments: X
; Output: 
; RegMod: X, A, Y, U
SUB_8FC1: 
8FC1	F9                  REC                                 ; Reset Carry Flag

SUB_8FC2: ; Called from 8D1B
8FC2	CC 93               VEJ	    (CC),93                     ; Loads X-Reg with address at 78(93) 78(94). Pointer operations
8FC4	B5 1A               LDI	    A,1A                        ;
8FC6	FD CA               ADR	    X                           ; X = X + A. 
8FC8	83 08               BCS+    BRANCH_8FD2                 ; If X > E5, we carried out
8FCA	FD 5A               STX     Y                           ; Y = X
8FCC	4A 50               LDI	    XL,50                       ;
8FCE	48 77               LDI	    XH,77                       ; X = 7750, String Var P$ Byte 0
8FD0	8E 04               BCH+    BRANCH_8FD6                 ; Unconditional fwd branch
 
BRANCH_8FD2: ; Branched to from 8FC8
8FD2	5A 50               LDI	    YL,50                       ;
8FD4	58 77               LDI	    YH,77                       ; Y = 7750, String Var P$ Byte 0

BRANCH_8FD6: ; Branched to from 8FD0
8FD6	6A 1F               LDI	    UL,1F                       ; Copy 20 bytes?

BRANCH_8FD8: ; Branched to from 8FD9
8FD8	F5                  TIN                                 ; (Y) = (X) then X = X + 1, Y = Y + 1
8FD9	88 03               LOP	    UL,BRANCH_8FD8              ; UL = UL - 1, loop back 'e' if Borrow Flag not set
8FDB	9A                  RTN                                 ;


; not sure what this belongs to
8FDC	5A 50               LDI	    YL,50                       ; 
8FDE	58 FD               LDI	    YH,FD                       ; Y = FD50



;------------------------------------------------------------------------------------------------------------
; JMP_8FE0 - Jumped to from 911B
; Seems like it resets some things
; Arguments: X
; Output: 
; RegMod:
JMP_8FE0:
8FE0	FD C1               SDP                                 ; Sets LCD ON/OFF control flip-flop
8FE2	AA 78 4F            LDI	    S,SYSTEMSTACKBASE           ; Stack Pointer = SYSTEMSTACKBASE
8FE5	BE 97 BA            SJP	    SUB_97BA                    ; Changes last pressed key code and repeat speed?
8FE8	81 4F               BCR+    BRANCH_9039                 ; SUB_97BA Returns C=0=success. 9039 Calls SUB_8FED below
8FEA	BA 92 3E            JMP	    SUB_PRINT#_ALT_E1           ;



;------------------------------------------------------------------------------------------------------------
; SUB_8FED - Called from 9039
; Seems to set LCD annuncitors, maybe for Terminal mode?
; Arguments: U 
; Output: 
; RegMod: A, U
SUB_8FED: 
8FED	6E 0E               CPI	    UL,0E                       ;
8FEF	89 03               BZR+    BRANCH_8FF4                 ; If UL != 0E branch fwd
8FF1	BA 8D 04            JMP	    SUB_8D04                    ; Resets CE-150, LCD annuncuiators, jumps to new code

BRANCH_8FF4: ; Branched to from 8FEF
8FF4	E9 76 4E 7F         ANI	    (HIGHLCDFLAG),7F            ; Clear Bit 7, don't know what this bit is
8FF8	B5 02               LDI	    A,02                        ;
8FFA	68 7F               LDI	    UH,7F                       ;
8FFC	6E 01               CPI	    UL,01                       ; What changed UL from 8FED
8FFE	8B 27               BZS+    BRANCH_9027                 ; If UL = 01 branch fwd
9000	B5 00               LDI	    A,00                        ; 
9002	6E 1B               CPI	    UL,1B                       ; 
9004	8B 21               BZS+    BRANCH_9027                 ; If UL = 1B branch fwd
9006	6E 02               CPI	    UL,02                       ;
9008	89 2E               BZR+    BRANCH_9038                 ; If UL != 02 branch fwd
900A	FD E9 F0 0D F7      ANI	    #(PC1500_PRT_B_DIR),F7      ; Bit 3 set to read, Region bit: Japanese = 0, Export = 1
900F	6A 08               LDI	    UL,08                       ;
9011	68 79               LDI	    UH,79                       ; U = 7908, NUMERIC VAR B Byte 0
9013	FD ED F0 0F 08      BII	    #(PC1500_PRTB),08           ; region bit: Japanese = 0, Export = 1
9018	89 0E               BZR+    BRANCH_9028                 ; If export unit branch fwd
901A	A5 78 BE            LDA	    (78BE)                      ; DATA POINTER (H)
901D	6A 04               LDI	    UL,04                       ;
901F	68 75               LDI	    UH,75                       ; U = 7504
9021	8B 05               BZS+    BRANCH_9028                 ; If (78BE) was zero branch fwd
9023	B5 00               LDI	    A,00                        ;
9025	68 71               LDI	    UH,71                       ; U = 7104

BRANCH_9027: ; Branched to from 8FFE, 9004
9027	2A                  STA	    UL                          ; U = 7F02 or 7F00 or 7100

BRANCH_9028: ; Branched to from 9018, 9021
9028	24                  LDA	    UL                          ; UL = 0E,01,1B,02,08,04,00
9029	AD 76 4E            EOR	    (HIGHLCDFLAG)               ; A = A ^ (HIGHLCDFLAG)
902C	AE 76 4E            STA	    (HIGHLCDFLAG)               ; Toggle some bits BUSY, SHIFT, etc. 
902F	A4                  LDA	    UH                          ; UH = 7F,79,75,71
9030	A9 76 4E            AND	    (HIGHLCDFLAG)               ;
9033	AE 76 4E            STA	    (HIGHLCDFLAG)               ; Set some bits
9036	B5 00               LDI	    A,00                        ;

BRANCH_9038: ; Branched to from 9008
9038	9A                  RTN                                 ;



BRANCH_9039: ; Branched to from 8FE8
9039	BE 8F ED            SJP	    SUB_8FED                    ; Seems to set LCD annuncitors, maybe for Terminal mode?
903C	89 05               BZR+    BRANCH_9043                 ;

JMP_903E: ; Jumped to from 915C
903E	BE 98 02            SJP	    SUB_9802                    ; Resets last pressed key register and repeat speed.
9041	8E 40               BCH+    UNKNOWN_JMP_9083            ; Unconditional fwd branch

BRANCH_9043: ; Branched to from 903C
9043	ED 7B 09 02         BII	    (7B09),02                   ; Repeat speed
9047	8B 03               BZS+    BRANCH_904C                 ; If Bit 2 was not set branch fwd
9049	BA 9F 25            JMP	    JMP_9F25                    ; No idea what this does

BRANCH_904C: ; Branched to from 9047
904C	ED 76 4E 0E         BII	    (HIGHLCDFLAG),0E            ; BUSY, SHIFT, etc.
9050	89 EC               BZR+    BRANCH_913E                 ; If all Bits 3-1 not clear branch fwd
9052	ED 76 4F 07         BII	    (LOWLCDFLAG),07             ; DE, GRAD, RAD, etc.
9056	8B E6               BZS+    BRANCH_913E                 ; If all Bits 0-2 clear 
9058	6E 5B               CPI	    UL,5B                       ; Where did UL come from?
905A	83 E2               BCS+    BRANCH_913E                 ; If UL >= 5B branch fwd
905C	24                  LDA	    UL                          ; UL < 58
905D	B1 40               SBI	    A,40                        ; A = A - 40
905F	81 D9               BCR+    BRANCH_913A                 ; If A was > 40 branch fwd
9061	DD                  INC	    A                           ;

BRANCH_9062: ; Branched to from 913C
9062	ED 76 4F 04         BII	    (LOWLCDFLAG),04             ; DE, GRAD, RAD, etc.
9066	89 07               BZR+    BRANCH_906F                 ; If Bit 2 not set branch fwd
9068	68 86               LDI	    UH,86                       ;
906A	6A 69               LDI	    UL,69                       ; U = 8669, USING_M_INT_TBL_8669
906C	FD EA               ADR	    U                           ; U = U + A. Index into U pointer?       
906E	25                  LDA	    (U)                         ; A = (U)

BRANCH_906F: ; Branched to from 9066
906F	AE 78 96            STA	    (7896)                      ; USING M integer part



;------------------------------------------------------------------------------------------------------------
; UNKNOWN_JMP_9072 - Branched to from 914B, 914F, Jumped to from 9F22, JUMP_TBL_915F
; Changes LCD annunciators branches to SUB_PRINT#_ALT_X1
UNKNOWN_JMP_9072:
9072	2A                  STA	    UL                          ; Where does A come from, fall thru from above?

UNKNOWN_JMP_9073: ; Called from JMP_91BC:9222
9073	A5 78 B2            LDA	    (78B2)                      ; ERROR ADDRESS (H)
9076	0A                  STA	    XL                          ;
9077	48 7B               LDI	    XH,7B                       ; X = 7B##
9079	B7 D8               CPI	    A,D8                        ;
907B	81 06               BCR+    UNKNOWN_JMP_9083            ; If A < D8 branch fwd
907D	24                  LDA	    UL                          ; X >= 7BD8, INPUT BUFFER Byte 40
907E	41                  SIN	    (X)                         ; (X) = A. Then X = X + 1
907F	04                  LDA	    XL                          ;

UNKNOWN_JMP_9080: ; Called from JMP_91BC:9229
9080	AE 78 B2            STA	    (78B2)                      ; ERROR ADDRESS (H)

; Unknown JMP 9083 - Jumped to from 9613, 96C5, 974A
UNKNOWN_JMP_9083:
9083	E9 76 4F F0         AND	    (LOWLCDFLAG),F0             ; Clear low nibble. DE, GRAD, RAD, etc.

UNKNOWN_JMP_9087: ; Jumped to from 962D
9087	E9 76 4E 7F         ANI	    (HIGHLCDFLAG),7F            ; Clear bit 7. BUSY, SHIFT, etc. 

JMP_908B: ; Jumped to from 9255
908B	A5 78 B2            LDA	    (78B2)                      ; ERROR ADDRESS (H)
908E	B7 D8               CPI	    A,D8                        ;
9090	8B 5A               BZS+    SUB_PRINT#_ALT_X1           ; If A = D8 branch fwd
9092	ED 78 B4 02         BII     (ERRORLINE),02              ;
9096	8B 06               BZS+    BRANCH_909E                 ; If Bit 2 was not set branch fwd
9098	ED 78 B0 40         BII     (78B0),40                   ; BREAK TOP (H)
909C	89 4E               BZR+    SUB_PRINT#_ALT_X1           ; If Bit 5 not set

BRANCH_909E: ; Branched to from 9096
909E	ED 78 B4 04         BII     (ERRORLINE),04              ;
90A2	8B 07               BZS+    BRANCH_90AB                 ; If Bit 2 not set
90A4	A5 78 B3            LDA	    (78B3)                      ; ERROR ADDRESS (L)
90A7	B7 D8               CPI	    A,D8                        ;
90A9	83 41               BCS+    SUB_PRINT#_ALT_X1           ; If A >= D8

BRANCH_90AB: ; Branched to from 90A2
90AB	A5 7B D8            LDA	    (7BD8)                      ; INPUT BUFFER Byte 40
90AE	BA 9E D0            JMP	    JMP_9ED0                    ; Not sure



;------------------------------------------------------------------------------------------------------------
; SUB_PRINT#
; JMP_90B1 - Jumped to from JMP_9ED0:9F00
; Sends A to RS232 and checks/changes things in CE-158?
; Arguments: 
; Output: 
; RegMod: XL, Y, A
JMP_90B1:
90B1	BE 81 BC            SJP     CHAR2COM                    ; Sends charecter in A to RS232 Port
90B4	83 36               BCS+    SUB_PRINT#_ALT_X1           ; Carry set = failure
90B6	4A D8               LDI	    XL,D8                       ;
90B8	BE 98 45            SJP     SUB_9845                    ; Shifts display left one charecter
90BB	EF 78 B2 FF         ADI	    (78B2),FF                   ; Set all bits in ERROR ADDRESS (H)
90BF	ED 78 B4 04         BII	    (ERRORLINE),04              ;
90C3	8B 10               BZS+    BRANCH_90D5                 ; If Bit 2 not set
90C5	FD BE               RIE                                 ; Disable interrupts
90C7	A5 78 B3            LDA	    (78B3)                      ; ERROR ADDRESS (L)
90CA	1A                  STA	    YL                          ;
90CB	58 7B               LDI	    YH,7B                       ; Y = 7B##
90CD	A4                  LDA	    UH                          ;
90CE	1E                  STA	    (Y)                         ;
90CF	EF 78 B3 01         ADI	    (78B3),01                   ; ERROR ADDRESS (L)
90D3	FD 81               SIE                                 ; Enable interrupts

BRANCH_90D5: ; Branched to from 90C3
90D5	A5 78 91            LDA	    (7891)                      ; GOSUB pointer
90D8	8B 12               BZS+    SUB_PRINT#_ALT_X1           ; If pointer zero branch fwd
90DA	A5 78 92            LDA	    (7892)                      ; Data pointer
90DD	B7 E6               CPI	    A,E6                        ;
90DF	8B 07               BZS+    BRANCH_90E8                 ; If A = E6

JMP_90E1: ; Jumped to from JMP_9ED0:9F65
90E1	EB 78 91 FF         ORI	    (7891),FF                   ; Set all bits. GOSUB pointer
90E5	BA 93 6E            JMP	    JMP_936E                    ; Jumps into SUB_PRINT#_ALT_X1

BRANCH_90E8: ; Branched to from 90DF
90E8	E9 78 91 00         ANI	    (7891),00                   ; Clear all bits. GOSUB pointer

SUB_PRINT#_ALT_X1: ; Branched to from JMP_90B1:90B4, Jumped to from SUB_PRINT#:94A8
90EC	FD C1               SDP                                 ; Sets LCD ON/OFF control flip-flop
90EE	FD ED F0 0B 02      BII	    #(PC1500_IF_REG),02         ; PC-1500 PB7 interrupt flag, Power Button
90F3	8B 03               BZS+    BRANCH_90F8                 ; If Bit 1 was not set
90F5	BA 8D 04            JMP	    SUB_8D04                    ; Resets CE-150, LCD annuncuiators, jumps to new code

BRANCH_90F8: ; Branched to from 90F3
90F8	FD A5 D0 0E         LDA     #(CE158_PRT_A)              ; 
90FC	FD A9 D0 0E         AND	    #(CE158_PRT_A)              ; 2nd reading to catch changes
9100	BF 20               BII	    A,20                        ; Bit 5, Low Battery
9102	8B 09               BZS+    BRANCH_910D                 ; If bit 5 was not set
9104	EF 78 50 40         ADI	    (OUTSTAT_REG),40            ; (OUTSTAT_REG) = (OUTSTAT_REG) + 40
9108	81 07               BCR+    BRANCH_9111                 ; If (OUTSTAT_REG) was < BF so no Carry set
910A	BA 8C FD            JMP	    JMP_8CFD                    ; Jumps on to SUB_8D04_ALT_E1

BRANCH_910D: ; Branched to from 9102
910D	E9 78 50 0F         ANI	    (OUTSTAT_REG),0F            ; Clear high nibble

BRANCH_9111: ; Branched to from 9108
9111	BE 99 AA            SJP	    SUB_99E6_ALT_E1             ; Not sure?
9114	EF 7B 0E 10         ADI	    (CURS_CTRL),10              ; Character to blink. ADI alters C
9118	BE 91 1E            SJP	    SUB_911E                    ; looking for something at PC-1500 - IF Register?
911B	BA 8F E0            JMP	    JMP_8FE0                    ; Seems like it resets some things



;------------------------------------------------------------------------------------------------------------
; SUB_911E  Called from 9118, 9994
; Exit if Carry clear, else wait until PC-1500 IF_REG IRQ and PB7 (Power Button) are clear before exit
; Arguments: 
; Output: 
; RegMod: UL
SUB_911E: 
911E	81 19               BCR+    BRANCH_9139                 ; If the ADI preceeding this call did not set carry
9120	EF 78 97 01         ADI	    (7897),01                   ; USING & using of character string
9124	81 0F               BCR+    BRANCH_9135                 ; If (7897) was < FF exit
9126	6A 3C               LDI	    UL,3C                       ;
9128	FD BE               RIE                                 ; Disable interrupts
912A	FD C0               RDP                                 ; Sets LCD ON/OFF control flip-flop

BRANCH_912C:
912C	FD ED F0 0B 03      BIT	    #(PC1500_IF_REG),03         ; PC-1500 Bit 0 = IRQ, Bit 1 = PB7 = Power Button (ME1)
9131	89 02               BZR+    BRANCH_9135                 ; If  Bits 0-1 were not both reset
9133	88 09               LOP	    UL,BRANCH_912C              ; UL = UL - 1, loop back 'e' if Borrow Flag not set

BRANCH_9135: ; Branched to from 9124, 9131 
9135	FD 81               SIE                                 ; Enable interrupts
9137	FD C1               SDP                                 ; Sets LCD ON/OFF control flip-flop

BRANCH_9139: ; Branched to from 911E
9139	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; A bit of code added to SUB_8FED
; Arguments A, U
BRANCH_913A: ; Branched to from 905F
913A	B1 EE               SBI	    A,EE                        ; A = A - EE
913C	9B DC               BZS-    BRANCH_9062                 ; If A was = EE branch back

BRANCH_913E: ; Branched to from 9050, 9056, 905A
913E	24                  LDA	    UL                          ; 
913F	BE E3 66            SJP	    E366                        ; Auto Power Off routine, beginning of power back on


BRANCH_9142: ; Branched to from 915A                            ; Auto Power off jump above might return back here
9142	AE 78 96            STA	    (7896)                      ; USING M integer part
9145	B7 20               CPI	    A,20                        ; 20 = space
9147	81 73               BCR+    JMP_91BC                    ; If A < 20 branch, else A >= 20
9149	B7 61               CPI	    A,61                        ; 61 = A 
914B	93 DB               BCS-    UNKNOWN_JMP_9072            ; If A >= 61 branch, else A >=20 A < 61
914D	B7 5B               CPI	    A,5B                        ; 5B = [
914F	91 DF               BCR-    UNKNOWN_JMP_9072            ; If A < 5B branch, else A >= 5B A < 61
9151	8B 05               BZS+    BRANCH_9158                 ; If A = 5B branch, else A > 5B A < 61
9153	B7 5D               CPI	    A,5D                        ; 5D = ]
9155	89 05               BZR+    BRANCH_915C                 ; If A != 5D branch, else A = 5D
9157	DD                  INC	    A                           ; A = 5E = ^

BRANCH_9158: ; Branched to from 9151
9158	B9 1F               ANI	    A,1F                        ; A = 5B or A = 5E -> A = 1B or A = 1E
915A	9E 1A               BCH-    BRANCH_9142                 ; Unconditional back branch

BRANCH_915C: ; Branched to from 9155 
915C	BA 90 3E            JMP	    JMP_903E                    ;



;------------------------------------------------------------------------------------------------------------
; JUMP_TBL_915F - Function address and value of A to pass to function
; Used by 91DE
JUMP_TBL_915F:
915F	92 3E 40            .BYTE   92 3E 40                    ; A1 - 923E     SUB_PRINT#_ALT_E1
9162	92 3E 80            .BYTE   92 3E 80                    ;               SUB_PRINT#_ALT_E1
9165	96 47 80            .BYTE   96 47 80                    ; A2 - 9647     SUB_INPUT#
9168	96 42 40            .BYTE   96 42 40                    ; A3 - 9642     SUB_INPUT#
916B	96 30 20            .BYTE   96 30 20                    ; A4 - 9630     SUB_INPUT#
916E	96 42 10            .BYTE   96 42 10                    ;               SUB_INPUT#  
9171	92 3E 00            .BYTE   92 3E 00                    ;               SUB_PRINT#_ALT_E1
9174	96 C8 01            .BYTE   96 C8 01                    ; A5 - 96C8     SUB_INPUT#
9177	96 16 00            .BYTE   96 16 00                    ; A6 - 9616     SUB_INPUT#
917A	96 C8 01            .BYTE   96 C8 01                    ;               SUB_INPUT#
917D	96 C8 01            .BYTE   96 C8 01                    ;               SUB_INPUT#
9180	96 C8 01            .BYTE   96 C8 01                    ;               SUB_INPUT#
9183	90 72 0D            .BYTE   90 72 0D                    ; A7 - 9072     UNKNOWN_JMP_9072
9186	8D 04 00            .BYTE   8D 04 00                    ; A8 - 8D04     SUB_8D04 
9189	92 3E 00            .BYTE   92 3E 00                    ;               SUB_PRINT#_ALT_E1
918C	92 3E 00            .BYTE   92 3E 00                    ;               SUB_PRINT#_ALT_E1
918F	96 7B 01            .BYTE   96 7B 01                    ; A9 - 967B     SUB_INPUT#
9192	90 72 08            .BYTE   90 72 08                    ;               UNKNOWN_JMP_9072
9195	90 72 08            .BYTE   90 72 08                    ;               UNKNOWN_JMP_9072
9198	90 72 08            .BYTE   90 72 08                    ;               UNKNOWN_JMP_9072
919B	90 72 1B            .BYTE   90 72 1B                    ;               UNKNOWN_JMP_9072
919E	96 1B 04            .BYTE   96 1B 04                    ; A10 - 961B    SUB_INPUT#
91A1	92 3E 00            .BYTE   92 3E 00                    ;               SUB_PRINT#_ALT_E1
91A4	9F 1B 01            .BYTE   9F 1B 01                    ; A11 - 9F1B    JMP_9ED0?
91A7	96 10 01            .BYTE   96 10 01                    ; A12 - 9610    SUB_INPUT#
91AA	9F 06 01            .BYTE   9F 06 01                    ; A13 - 9F06    JMP_9F06
91AD	96 C8 01            .BYTE   96 C8 01                    ;               SUB_INPUT#
91B0	92 3E 00            .BYTE   92 3E 00                    ;               SUB_PRINT#_ALT_E1
91B3	92 3E 00            .BYTE   92 3E 00                    ;               SUB_PRINT#_ALT_E1            
91B6	96 C8 01            .BYTE   96 C8 01                    ;               SUB_INPUT#
91B9	92 3E 00            .BYTE   92 3E 00                    ;               SUB_PRINT#_ALT_E1



;------------------------------------------------------------------------------------------------------------
; JMP_91BC: Branched to from 9147, Jumped to from 9F32
; If A = 0 it points to a line of code. Guessing A must be > 0.
; May use JUMP_TBL_915F to jump to new code
; Arguments: A <= 19 from 9147, A <= 1F 9F32
; Output: 
; RegMod: U, A
JMP_91BC: 
91BC	6A 5C               LDI	    UL,5C                       ;
91BE	EB 78 96 80         ORI	    (7896),80                   ; Set Bit 7. USING M integer part
91C2	68 91               LDI	    UH,91                       ; U = 915C
91C4	BF 08               BII	    A,08                        ; Check bit 3 of A that was passed in
91C6	89 0E               BZR+    BRANCH_91D6                 ; If Bit 3 set skip. 00~07 or 10~17 Z=0, 08~0F or 18~1F Z=1
91C8	ED 76 4E 10         BII	    (HIGHLCDFLAG),10            ; Bit 4, (DEFIII) annunciator on LCD
91CC	89 02               BZR+    BRANCH_91D0                 ; If Bit 4 was set branch fwd
91CE	B9 EF               ANI	    A,EF                        ; A = 00~07 Clear Bit 4

BRANCH_91D0: ; Branched to from 91CC
91D0	ED 76 4E 40         BII	    (HIGHLCDFLAG),40            ; (RUN) annunciator on LCD
91D4	89 20               BZR+    BRANCH_91F6                 ; If Bit 6 set skip jump calculation and jump below
                   
                                                                ; A = 08~0F, 18~1F from 91C6
                                                                ; A = 00~07, 10~17 from 91CC
BRANCH_91D6: ; Branched to from 91C6                            ; A = 00-07        from 91CE
91D6	FD EA               ADR	    U                           ; U = U + A, U = 915C, A = 00~1F.
91D8	D9                  SHL                                 ; A = A * 2
91D9	FD EA               ADR	    U                           ; U = U + 3A is result of all of this
                                                                ; range is 915C to 91B9
91DB	65                  LIN	    (U)                         ; A = (U) then INC U
91DC	08                  STA	    XH                          ;
91DD	65                  LIN	    (U)                         ; A = (U) then INC U, 
91DE	0A                  STA	    XL                          ; X is now the address from JUMP_TBL_915F
91DF	A5 7B 0F            LDA	    (KEY_LAST)                  ; Last pressed key code.
91E2	B7 08               CPI	    A,08                        ; Left Cursor Key
91E4	81 0A               BCR+    BRANCH_91F0                 ; If A < 08 branch fwd (< 08 is only SHFT and SML)
91E6	B7 0D               CPI	    A,0D                        ; Enter Key
91E8	8B 09               BZS+    BRANCH_91F3                 ; If A = 0D/Enter branch fwd
91EA	83 04               BCS+    BRANCH_91F0                 ; If A > 0D branch fwd
91EC	B7 09               CPI	    A,09                        ; Up/Down Cursor. A > 08 & A < 0D
91EE	89 03               BZR+    BRANCH_91F3                 ; If A != 09 branch fwd

BRANCH_91F0: ; Branched to from 91E4, 91EA
91F0	BE 98 02            SJP	    SUB_9802                    ; When A < 8 or A > 0D

BRANCH_91F3: ; Branched to from 91E8, 91EE                      ; If A > 08 & A < 0D & A != 09
91F3	25                  LDA	    (U)                         ; Argument from JUMP_TBL_915F
91F4	FD 5E               STX	    P                           ; P = X. Set Program Counter to X ***JMP


BRANCH_91F6: ; Branched to from 91D4                            ; If we did not jump away above, 
91F6	B7 06               CPI	    A,06                        ; A = 00~07, 10~17 from 91CC, A = 00-07 from 91CE
91F8	81 02               BCR+    BRANCH_91FC                 ; If A < 6 branch fwd
91FA	B5 07               LDI	    A,07                        ; else set A = 07

BRANCH_91FC: ; Branched to from 91F8
91FC	AE 78 84            STA	    (CUR_VAR_ADD_L)             ;
91FF	CD 38               VMJ	    (38)                        ; Determines reserve memory type adress + 8 and stores it in X-Reg. 
                                                                ; Sets C=0 if 2nd reserve memory area is occupied 
9201	BE CE C4            SJP	    SUB12                       ; Searches for reserve key code in reserve memory
9204	81 1F               BCR+    BRANCH_9225                 ; Carry from sub. 9225 -> JMP UNKNOWN_JMP_9083
9206	BA 9F 35            JMP	    JMP_9F35                    ; This is jumping back after 9F32 which jumped here



;------------------------------------------------------------------------------------------------------------
; JMP_9209 - Jumped to from  JMP_9ED0:9F6B
; Reads something from 7BAA (in OUTPUT BUFFER) and then jumps out. Purpose?
; Arguments: A = ERROR ADDRESS (H), X = (CUR_VAR_ADD_L)
; Output: 
; RegMod: UL, X, A
JMP_9209:
9209	2A                  STA	    UL                          ; 
920A	68 7B               LDI	    UH,7B                       ; String buffer?
920C	45                  LIN	    X                           ; A = (X) then INC X
920D	B7 26               CPI	    A,26                        ;
920F	89 1B               BZR+    BRANCH_922C                 ; If A != 26 branch fwd
9211	6A 00               LDI	    UL,00                       ; U = 7B00 - RND Byte 0
9213	BE 9E 3B            SJP	    SUB_9E3B                    ; Reads value from (X) into A and manipulates A 
9216	83 0A               BCS+    BRANCH_9222                 ; Carry = failure
9218	2A                  STA	    UL                          ;
9219	BE 9E 3B            SJP	    SUB_9E3B                    ; Reads value from (X) into A and manipulates A 
921C	83 04               BCS+    BRANCH_9222                 ; Carry = failure
921E	F1                  AEX                                 ; Swap high and low bytes of A
921F	22                  ADC	    UL                          ; A = A + UL
9220	F1                  AEX                                 ; Swap high and low bytes of A
9221	2A                  STA	    UL                          ; Why?

BRANCH_9222: ; Branched to from 9216, 9219, 9232
9222	BA 90 73            JMP	    UNKNOWN_JMP_9073            ; Changes LCD annunciators branches to SUB_PRINT#_ALT_X1

BRANCH_9225: ; Branched to from 9204
9225	BA 90 83            JMP	    UNKNOWN_JMP_9083            ; Changes LCD annunciators branches to SUB_PRINT#_ALT_X1

BRANCH_9228: ; Branched to from 922E
9228	24                  LDA	    UL                          ;
9229	BA 90 80            JMP	    UNKNOWN_JMP_9073            ; Changes LCD annunciators branches to SUB_PRINT#_ALT_X1

BRANCH_922C: ; Branched to from 920F, 923C
922C	BF E0               BII	    A,E0                        ; 
922E	9B 08               BZS-    BRANCH_9228                 ; If A = E0 branch
9230	6E D8               CPI	    UL,D8                       ;
9232	91 12               BCR-    BRANCH_9222                 ; If A < D8 branch
9234	B7 40               CPI	    A,40                        ;
9236	89 02               BZR+    BRANCH_923A                 ; If A != 40 branch
9238	B5 0D               LDI	    A,0D                        ;

BRANCH_923A: ; Branched to from 9236
923A	61                  SIN	    (U)                         ; (U) = A then INC U
923B	45                  LIN	    X                           ; A = (X) then INC X
923C	9E 12               BCH-    BRANCH_922C                 ; Uncondtional back branch



;------------------------------------------------------------------------------------------------------------
; SUB_PRINT# - Entry at 93D0
; SUB_PRINT#_ALT_E1  - Jumped to from JMP_9ED0:9F18
; Not sure seems to do some parsing, but all over the place
; Arguments: 
; Output: 
; RegMod: A, UL, X
SUB_PRINT#_ALT_E1:
923E	A5 78 B3            LDA	    (78B3)                      ; ERROR ADDRESS (L)
9241	B7 B1               CPI	    A,B1                        ;
9243	83 03               BCS+    BRANCH_9248                 ; If A >= B1 branch fwd
9245	BE 99 E6            SJP	    SUB_99E6                    ; Not sure?

BRANCH_9248: ; Branched to from 9243
9248	ED 76 4E 01         BII	    (HIGHLCDFLAG),01            ; LCD (Busy) Annunciator
924C	89 07               BZR+    BRANCH_9255                 ; If Bit 0 was not set
924E	A5 78 B3            LDA	    (78B3)                      ; ERROR ADDRESS (L)
9251	B7 B1               CPI	    A,B1                        ; 
9253	83 09               BCS+    BRANCH_925E                 ; If A >= B1 branch

BRANCH_9255: ; Branched to from 924C
9255	BA 90 8B            JMP	    JMP_908B                    ; Not sure?


TBL_9258:
9258	23 50 43 32 40 0D   .TEXT #PC2@\N                       ; Used in 927C


BRANCH_925E: ; Branched to from 9253
925E	A5 7B B0            LDA	    (INPUTBUF)                  ; INPUT BUFFER Byte 0 START
9261	2A                  STA	    UL                          ;
9262	B7 20               CPI	    A,20                        ; 20 = Space
9264	81 2D               BCR+    BRANCH_9293                 ; If A < 20 branch fwd
9266	8B 1B               BZS+    BRANCH_9283                 ; If A = 20 branch fwd, A > 20 drop below
9268	ED 78 B0 01         BII	    (78B0),01                   ; BREAK TOP (H)
926C	8B 1F               BZS+    BRANCH_928D                 ; If Bit 0 was set branch fwd. A > 20
926E	B7 41               CPI	    A,41                        ; 41 = A
9270	81 1B               BCR+    BRANCH_928D                 ; If A < 41 branch fwd
9272	B7 5B               CPI	    A,5B                        ; 5B = [
9274	83 17               BCS+    BRANCH_928D                 ; If A >= 5B branch fwd
9276	B7 49               CPI	    A,49                        ; 49 = I
9278	89 50               BZR+    BRANCH_92CA                 ; If A != 49 branch fwd (A >=41 & A < 5B)
927A	4A 58               LDI	    XL,58                       ; A = 49
927C	48 92               LDI	    XH,92                       ; X = 9258 = TBL_9258
927E	BE 87 45            SJP	    STRNG_2COM                    ; Sends string  from TBL_9258 to RS232. Alters A?
9281	8E 47               BCH+    BRANCH_92CA                 ; Unconditional fwd branch

BRANCH_9283: ; Branched to from 9266                            ; A = 20 
9283	ED 78 B0 02         BII	    (78B0),02                   ; BREAK TOP (H)
9287	8B 59               BZS+    BRANCH_92E2                 ; If Bit 1 was not set
9289	6A 0C               LDI	    UL,0C                       ;
928B	8E 55               BCH+    BRANCH_92E2                 ; Unconditional fwd branch

BRANCH_928D: ; Branched to from 926C, 9270, 9274                ; BREAK TOP (H) BIt 0 set, (A > 20) | (A < 41 & A >= 5B)
928D	E9 78 B0 FD         ANI	    (78B0),FD                   ; Clear Bit 1. BREAK TOP (H)
9291	8E 4F               BCH+    BRANCH_92E2                 ; Unconditional fwd branch

BRANCH_9293: ; Branched to from 9264                            ; If A < 20. 0 - 0C = F4. 1A - 0C = 0E
9293	B1 0C               SBI	    A,0C                        ; 0C - 0C = 0. 0C = Form Feed
9295	8B 24               BZS+    BRANCH_92BB                 ; If A was = to 0C branch fwd
9297	DD                  INC	    A                           ; A = F5 to A = 0F
9298	8B 34               BZS+    BRANCH_92CE                 ; If A was = 0B branch. 0B = Vert Tab
929A	B3 04               ADI	    A,04                        ; A = A + 04. A = F9 to 13
929C	89 09               BZR+    BRANCH_92A7                 ; If A was != 7
929E	ED 78 B0 01         BII	    (78B0),01                   ; BREAK TOP (H). A = 7
92A2	89 2A               BZR+    BRANCH_92CE                 ;
92A4	BA 94 F4            JMP	    JMP_94F4                    ; Not sure?

BRANCH_92A7: ; Branched to from 929C                            ; A = F9 to 13 
92A7	DD                  INC	    A                           ; A = FA to 14
92A8	89 03               BZR+    BRANCH_92AD                 ; If A was != FF
92AA	BA 94 BA            JMP	    JMP_94BA                    ; A = 0. Looks like it resets some PC-1500 stuff

BRANCH_92AD: ; Branched to from 92A8
92AD	B7 14               CPI	    A,14                        ; A = FA to 14 except 0
92AF	89 1D               BZR+    BRANCH_92CE                 ; If A != 14 branch fwd
92B1	A5 78 B0            LDA	    (78B0)                      ; BREAK TOP (H) (A was = 14 above)
92B4	BD 01               EAI	    01                          ; A = A ^ 01, toggle bit 0
92B6	AE 78 B0            STA	    (78B0)                      ; BREAK TOP (H)
92B9	8E 17               BCH+    BRANCH_92D2                 ; Unconditional fwd branch

BRANCH_92BB: ; Branched to from 9295                            ; A was = 0C, A now = 0
92BB	ED 78 B0 02         BII	    (78B0),02                   ; BREAK TOP (H)
92BF	89 0D               BZR+    BRANCH_92CE                 ;
92C1	EB 78 B0 02         ORI	    (78B0),02                   ; BREAK TOP (H)
92C5	8E 1B               BCH+    BRANCH_92E2                 ; Unconditional fwd branch
92C7	BE 98 E8            SJP	    SUB_98E8                    ;

BRANCH_92CA: ; Branched to from 9278, 9281, 95BD                ; (A >=41 & A < 5B)
92CA	E9 78 B0 FD         ANI	    (78B0),FD                   ; Clear Bit 1. BREAK TOP (H)

BRANCH_92CE: ; Branched to from 9298, 92A2, 92AF, 92BF
92CE	E9 78 B0 FE         ANI	    (78B0),FE                   ; Clear Bit 0. BREAK TOP (H)

BRANCH_92D2: ; Branched to from 92B9
92D2	FD BE               RIE                                 ; Disable interrupts
92D4	4A B0               LDI	    XL,B0                       ; X = 92B0
92D6	BE 98 45            SJP	    SUB_9845                    ; Shifts display left one charecter
92D9	EF 78 B3 FF         ADI	    (78B3),FF                   ; (78B3) = (78B3) + FF. ERROR ADDRESS (L)
92DD	FD 81               SIE                                 ; Enable interrupts

BRANCH_92DF: ; Branched to from 930A
92DF	BA 90 EC            JMP	    SUB_PRINT#_ALT_X1           ;


BRANCH_92E2: ; Branched to from 9287, 928B, 92C5,  
92E2	E9 78 B0 FE         ANI	    (78B0),FE                   ; Clear Bit 0, BREAK TOP (H)
92E6	A5 78 B4            LDA	    (ERRORLINE)                 ; HB of line where error occured
92E9	AE 78 B5            STA	    (78B5)                      ; LB of line where error occured
92EC	D9                  SHL                                 ; A = A << 1. Thru Carry, 0 carried in to LSB
92ED	81 1F               BCR+    BRANCH_930E                 ; If Bit 7 was not set
92EF	D9                  SHL                                 ; A = A << 1. Thru Carry, 0 carried in to LSB
92F0	81 1C               BCR+    BRANCH_930E                 ; If Bit 6 was not set
92F2	6E 20               CPI	    UL,20                       ; 20 = Space. UL = INPUT BUFFER Byte 0 from 9261
92F4	83 10               BCS+    BRANCH_9306                 ; Branch fwd if UL >= 20
92F6	6E 0D               CPI	    UL,0D                       ; 0D = CR
92F8	6A 20               LDI	    UL,20                       ; LDI UL changes no flags
92FA	89 0A               BZR+    BRANCH_9306                 ; If UL != 0D branch. 0D = CR
92FC	6A 0D               LDI	    UL,0D                       ; 
92FE	ED 78 55 10         BII	    (CR/LF_REG),10              ; 
9302	8B 02               BZS+    BRANCH_9306                 ; If Bit 4 was not set branch
9304	6A 0A               LDI	    UL,0A                       ; A = Line Feed

BRANCH_9306: ; Branched to from 92F4 (UL >= 20), 92FA (UL = 20), 9302 (UL = 0D), drop (UL = 0A)
9306	24                  LDA	    UL                          ; 
9307	BE 81 69            SJP	    CHAR2LPT                    ; Sends charecter in A to LPT
930A	93 2D               BCS-    BRANCH_92DF                 ;  If sub failure JMP SUB_PRINT#_ALT_X1
930C	8E 23               BCH+    BRANCH_9331                 ; Unconditional fwd branch

BRANCH_930E: ; Branched to from 92ED, 92F0
930E	E9 78 90 00         ANI	    (7890),00                   ; clear FOR, NEXT stack pointer

BRANCH_9312: ; Branced to from 938E, 
9312	FD C1               SDP                                 ; Sets LCD ON/OFF control flip-flop
9314	24                  LDA	    UL                          ; UL >=20 or UL = 20 or UL = 0D or UL = 0A
9315	AE 7A 08            STA	    (ZREG)                      ; Math reg Z
9318	BE 9A 9E            SJP	    SUB_9A9E                    ; jump code, A indexs into unknown table at X = 92B0?, sets PC
                                                                ; probably does not return

;------
; Nonsense
931B	18                  STA	    YH                  ;
931C	12                  ADC	    YL                  ;
931D	11                  SBC	    (Y)                 ; A = A - (Y)
931E	1A                  STA	    YL                  ;
931F	08                  STA	    XH                  ;
9320	18                  STA	    YH                  ;
9321	01                  SBC	    (X)                 ;
9322	16                  CPA	    YL                  ;
; Nonsense
;-------


9323	BE 9B 2C            SJP	    SUB_9B2C                    ; Copies something from TBL_8475 into system RAM
9326	8E 1A               BCH+    BRANCH_9342                 ; Unconditional branch fwd

9328	4A 00               LDI	    XL,00                       ;
932A	48 7A               LDI	    XH,7A                       ; X=7A00
932C	41                  SIN	    X                           ; (X) = A. Then X = X + 1. A = UH * 4 frm SUB_9B2C
932D	8E 13               BCH+    BRANCH_9342                 ; Unconditional branch fwd

932F	68 01               LDI	    UH,01                       ;


BRANCH_9331: ; Branched to from 9369
9331	BA 94 72            JMP	    BRANCH_9472                 ;


9334	B5 20               LDI     A,20                        ;
9336	AE 7A 08            STA	    (ZREG)                      ;
9339	28                  STA	    UH                          ; UH = 20
933A	B5 00               LDI	    A,00                        ;  A = 00
933C	BE 99 76            SJP	    SUB_9976                    ; Copies code from 8684 + A to System RAM 7A50
933F	BE 7A 50            SJP	    7A50                        ; Call the code just poked in

BRANCH_9342: ; Branched to from 9326, 932D
9342	44                  INC	    X                           ; INC X here for BRANCH_9390
9343	A5 78 90            LDA	    (7890)                      ; FOR, NEXT stack pointer
9346	89 48               BZR+    BRANCH_9390                 ;
9348	A5 78 91            LDA	    (7891)                      ; GOSUB pointer
934B	8B 43               BZS+    BRANCH_9390                 ;
934D	A5 78 93            LDA	    (7893)                      ; Pointer operations
9350	08                  STA	    XH                          ;
9351	A5 78 94            LDA	    (7894)                      ; String buffer pointer
9354	0A                  STA	    XL                          ;
9355	A5 78 92            LDA	    (7892)                      ; Data pointer
9358	FB                  SEC                                 ; Set Carry
9359	B1 E6               SBI     A,E6                        ; A = A - E6
935B	FD CA               ADR	    X                           ; X = X + A
935D	A5 7A 08            LDA	    (ZREG)                      ; Math_REG_Za_B1
9360	0E                  STA	    (X)                         ;
9361	EF 78 92 01         ADI	    (7892),01                   ; (7892) = (7892) + 1. Data pointer
9365	83 04               BCS+    BRANCH_936B                 ; If (7892) was FF
9367	B7 20               CPI	    A,20                        ; 
9369	99 3A               BZR-    BRANCH_9331                 ;

BRANCH_936B: ; Branched to from 9365
936B	BE 98 E8            SJP	    98E8                        ; Blinks cursor and displays something on LCD?

JMP_936E: ; Jumped to from JMP_90B1:90E5
936E	A5 78 92            LDA	    (7892)                      ; Data pointer
9371	FB                  SEC                                 ; Set carry
9372	B1 E6               SBI	    A,E6                        ; A = A - E6
9374	AE 78 90            STA	    (7890)                      ; FOR, NEXT stack pointer
9377	E9 78 92 00         ANI	    (7892),00                   ; Data pointer

BRANCH_937B: ; Branched to from 9464
937B	A5 78 93            LDA	    (7893)                      ; Pointer operations
937E	08                  STA	    XH                          ;
937F	A5 78 94            LDA	    (7894)                      ; String buffer pointer
9382	0A                  STA	    XL                          ;
9383	A5 78 92            LDA	    (7892)                      ; Data pointer
9386	EF 78 92 01         ADI	    (7892),01                   ; (7892) = (7892) + 1. Data pointer
938A	FD CA               ADR	    X                           ; X = X + A
938C	05                  LDA	    (X)                         ; A = (X)
938D	2A                  STA	    UL                          ;
938E	9E 7E               BCH-    BRANCH_9312                 ; Unconditional branch back

BRANCH_9390: ; Branched to from 9346, 934B
9390	A5 78 7E            LDA	    (787E)                      ; Blink cursor position (H)
9393	B7 77               CPI	    A,77                        ;
9395	81 A5               BCR+    BRANCH_943C                 ; If A < 77
9397	ED 78 B4 08         BII	    (ERRORLINE),08              ;
939B	8B 1B               BZS+    BRANCH_93B8                 ; If Bit 7 not set
939D	A5 78 91            LDA	    (7891)                      ; GOSUB pointer
93A0	89 16               BZR+    BRANCH_93B8                 ; If (7891) != 0
93A2	A5 78 7F            LDA	    (787F)                      ; Blink cursor position (L)
93A5	B7 06               CPI	    A,06                        ;
93A7	81 0F               BCR+    BRANCH_93B8                 ; If A < 06
93A9	A5 7A 08            LDA	    (ZREG)                      ;
93AC	B7 20               CPI	    A,20                        ;
93AE	89 08               BZR+    BRANCH_93B8                 ; If A != 20
93B0	B5 E6               LDI	    A,E6                        ;
93B2	AE 78 92            STA	    (7892)                      ; Data pointer
93B5	AE 78 91            STA	    (7891)                      ; GOSUB pointer

BRANCH_93B8: ; Branched to from 939B, 93A0, 93A7, 93AE
93B8	B5 42               LDI	    A,42                        ;
93BA	FB                  SEC                                 ; Set carry for subtrction below
93BB	00                  SBC	    XL                          ; A = A - XL
93BC	00                  SBC	    XL                          ; A = A - XL
93BD	A1 78 7F            SBC	    (787F)                      ; A = A - (787F). Blink cursor position (L)
93C0	83 7A               BCS+    BRANCH_943C                 ; If A < 0
93C2	28                  STA	    UH                          ;
93C3	6A FF               LDI	    UL,FF                       ;
93C5	A5 78 AB            LDA	    (78AB)                      ; SEARCH TOP (L)
93C8	0A                  STA	    XL                          ;
93C9	A5 78 AA            LDA	    (78AA)                      ; SEARCH TOP (H)
93CC	08                  STA	    XH                          ;

BRANCH_93CD: ; Branched to from 93E5
93CD	45                  LIN	    (X)                         ; A = (X) then INC X
93CE	FD C8               PSH	    A                           ;



;------------------------------------------------------------------------------------------------------------
; SUB_PRINT# - 
; Updates the LCD
; Arguments: 
; Output: 
; RegMod: U, A, X
SUB_PRINT#: ; Called through vector at 8335
93D0	BE 99 1E            SJP	    SUB_9912_ALT2               ; Loads PREVIOUS ADDRESS into X
93D3	FD 8A               POP	    A                           ;
93D5	D9                  SHL                                 ; A = A << 1. Through Carry, 0 into LSB
93D6	81 11               BCR+    BRANCH_93E9                 ; If bit 7 was not set fwd
93D8	A5 78 BE            LDA	    (78BE)                      ; DATA POINTER (H)
93DB	8B 0C               BZS+    BRANCH_93E9                 ; If DATA_POINTER_H zero branch fwd
93DD	EF 78 7F FE         ADI	    (787F),FE                   ; Blink cursor position (L)
93E1	60                  INC	    UL                          ; What is U?
93E2	60                  INC	    UL                          ;
93E3	FD 60               INC	    UH                          ;
93E5	91 1A               BCR-    BRANCH_93CD                 ; If Carry not set branch back, i.e. did not overflow
93E7	8E 08               BCH+    BRANCH_93F1                 ; Branch FWD unconditional

BRANCH_93E9: ; Branced to from 93D6, 93DB
93E9	EF 78 7F F4         ADD	    (787F),F4                   ; (787F) = (787F) + F4. Blink cursor position (L)
93ED	B5 0B               LDI	    A,0B                        ; A = 0B
93EF	22                  ADC	    UL                          ; A = A + UL
93F0	2A                  STA	    UL                          ; UL = A

BRANCH_93F1: ; Bracned to from 93E7
93F1	04                  LDA	    XL                          ; Transfers X from SUB_991E
93F2	AE 78 AB            STA	    (78AB)                      ; SEARCH TOP (L)
93F5	84                  LDA	    XH                          ;
93F6	AE 78 AA            STA	    (78AA)                      ; SEARCH TOP (H)
93F9	24                  LDA	    UL                          ;
93FA	FD C8               PSH	    A                           ; 
93FC	68 76               LDI	    UH,76                       ;
93FE	4A 4E               LDI	    XL,4E                       ;
9400	48 77               LDI	    XH,77                       ; X = 774E
9402	FD CA               ADR	    X                           ; X = X + A

; I think this section is updating the LCD
BRANCH_9404: ; Branced to from 9409                             ; copying U -> X. 76## -> 774E. U is display block
9404	25                  LDA	    (U)                         ; A = (U). U > 760B, X = 774E
9405	B9 F0               ANI	    A,F0                        ; Mask off low nibble
9407	F1                  AEX                                 ; Swap high and low bytes of accumulator
9408	43                  SDE	    (X)                         ; (X) = A. X = X - 1
9409	88 07               LOP	    UL,BRANCH_9404              ; UL=UL-1, if borrow flag not set loop back to 9404
940B	FD 8A               POP	    A                           ;
940D	28                  STA     UH                          ;
940E	0A                  STA	    XL                          ;
940F	48 76               LDI	    XH,76                       ;
9411	40                  INC	    XL                          ;
9412	B5 4E               LDI	    A,4E                        ;
9414	00                  SBC	    XL                          ; A = A - XL
9415	2A                  STA	    UL                          ;
9416	5A 00               LDI	    YL,00                       ;
9418	58 76               LDI	    YH,76                       ; Y = 7600, display block

BRANCH_941A: ; Branched to from 941B                            ; Copying X -> Y. 76## -> 7600
941A	F5                  TIN                                 ; (Y) = (X) then X = X + 1, Y = Y + 1
941B	88 03               LOP	    UL,BRANCH_941A              ; UL = UL - 1, if Carry not set loop back to 941A
941D	A4                  LDA	    UH                          ;
941E	2A                  STA	    UL                          ;
941F	FD C8               PSH	    A                           ;
9421	68 77               LDI	    UH,77                       ;
9423	4A 4D               LDI	    XL,4D                       ;
9425	48 76               LDI	    XH,76                       ; X = 7677

BRANCH_9427: ; Branched to from 9429                            ; U -> X. 77## -> 764D
9427	25                  LDA	    (U)                         ; A = (U)
9428	43                  SDE	    (X)                         ; (X) = A. X = X - 1
9429	88 04               LOP	    UL,BRANCH_9427              ; UL = UL - 1, if Carry not set loop back to 9427
942B	FD 8A               POP	    A                           ;
942D	0A                  STA	    XL                          ; XL = A
942E	40                  INC	    XL                          ;
942F	48 77               LDI	    XH,77                       ;
9431	6A 4D               LDI	    UL,4D                       ;
9433	5A 00               LDI	    YL,00                       ;
9435	58 77               LDI	    YH,77                       ; Y = 7700 Writing to screen?

BRANCH_9437: ; Branched to from 9438                            ; X -> Y. X = 77## Y = 7700
9437	F5                  TIN                                 ; (Y) = (X) then X = X + 1, Y = Y + 1
9438	88 03               LOP	    UL,BRANCH_9437              ; UL = UL - 1, if Carry not set loop back to 9437
943A	68 00               LDI	    UH,00                       ;

BRANCH_943C: ; Branched to from 9395, 93C0
943C	6A 05               LDI	    UL,05                       ; U = 0005
943E	ED 7A 08 80         BII	    (ZREG),80                   ; Keep Bit 7
9442	8B 07               BZS+    BRANCH_944B                 ; If Bit 7 was not set
9444	A5 78 BE            LDA	    (78BE)                      ; DATA POINTER (H)
9447	8B 02               BZS+    BRANCH_944B                 ; If (78BE) = 0
9449	6A 00               LDI	    UL,00                       ;

BRANCH_944B: ; Branched to from 9442, 9447
944B	BE 98 C3            SJP	    SUB_98C3                    ; Something related to the display
944E	04                  LDA	    XL                          ;
944F	AE 78 7F            STA	    (787F)                      ; (787F) = A. Blink cursor position (L)
9452	84                  LDA	    XH                          ;
9453	AE 78 7E            STA	    (787E)                      ; (787E) = A. Blink cursor position (H)
9456	BE 99 00            SJP	    SUB_9900                    ; Something related to the display
9459	A5 78 90            LDA	    (7890)                      ; FOR, NEXT stack pointer
945C	8B 14               BZS+    BRANCH_9472                 ; If (7890) = 0
945E	EF 78 90 FF         ADI	    (7890),FF                   ; (7890) = (7890) + FF. FOR, NEXT stack pointer
9462	8B 02               BZS+    BRANCH_9466                 ; If (7890) was = 1
9464	9E EB               BCH-    BRANCH_937B                 ; Unconditional branch back

BRANCH_9466: ; Branched to from 9462
9466	A5 78 91            LDA	    (7891)                      ; GOSUB pointer
9469	E9 78 91 00         ANI	    (7891),00                   ; Clear GOSUB pointer
946D	DD                  INC	    A                           ;
946E	89 02               BZR+    BRANCH_9472                 ; If (7891) was != 0
9470	8E 36               BCH+    BRANCH_94A8                 ; Unconditional branch fwd

BRANCH_9472: ; Branched to from 9331, 945C, 946E 
9472	FD BE               RIE                                 ; Disable interrupts
9474	4A B0               LDI     XL,B0                       ;
9476 	BE 98 45            SJP	    SUB_9845                    ; Shifts display left one charecter
9479	EF 78 B3 FF         ADI	    (78B3),FF                   ; ERROR ADDRESS (L)
947D	FD 81               SIE                                 ; Enable interrupts
947F	BE 99 33            SJP	    SUB_9933                    ; Not sure what this does
9482	A4                  LDA	    UH                          ;
9483	B7 20               CPI	    A,20                        ;
9485	81 08               BCR+    BRANCH_948F                 ; If A < 20
9487	ED 78 B0 02         BII	    (78B0),02                   ; BREAK TOP (H)
948B	8B 02               BZS+    BRANCH_948F                 ; If Bit 1 was not set
948D	B5 0C               LDI	    A,0C                        ;

BRANCH_948F: ; Branched to from 947F, 9485
948F	0E                  STA	    (X)                         ;
9490	ED 76 4F 10         BII	    (LOWLCDFLAG),10             ;
9494	89 15               BZR+    BRANCH_94AB                 ; If Bit 4 was set
9496	ED 76 4F 20         BII	    (LOWLCDFLAG),20             ;
949A	8B 0C               BZS+    BRANCH_94A8                 ; If Bit 5 was set
949C	EF 78 AF 01         ADI	    (78AF),01                   ; (78AF) = (78AF) + 1. BREAK LINE (L)
94A0	81 06               BCR+    BRANCH_94A8                 ; If (78AF) was = FF
94A2	EF 78 AE 01         ADI	    (78AE),01                   ; (78AE) = (78AE) + 1.BREAK LINE (H)
94A6	83 0C               BCS+    BRANCH_94B4                 ; If (78AE) was = FF

BRANCH_94A8: ; Branched to from 9470, 949A, 94A0, 94AD
94A8	BA 90 EC            JMP	    SUB_PRINT#_ALT_X1           ; An exit?

BRANCH_94AB: ; Branced to from 9494
94AB	B7 0D               CPI	    A,0D                        ;
94AD	99 07               BZR-    BRANCH_94A8                 ; If A != 0D

BRANCH_94AF: ; Branched to from 94B8
94AF	B5 01               LDI	    A,01                        ;
94B1	BA 96 7B            JMP	    JMP_967B                    ; Twiddles LCD annunciators and other stuff.

BRANCH_94B4: ; Branched to from 94A6
94B4	EB 78 AE FE         ORI	    (78AE),FE                   ; Set all but Bit 0. BREAK LINE (H)
94B8	9E 0B               BCH-    BRANCH_94AF                 ; Unconditional branch back

JMP_94BA: ; Jumped to from 92AA
94BA	6A 11               LDI	    UL,11                       ;
94BC	B5 5B               LDI	    A,5B                        ;
94BE	FD BE               RIE                                 ; Disable Interrupts
94C0	FD AE F0 07         STA	    #(PC1500_F_REG_LD/DIV)      ; PC-1500 - Loader Divider to F Register

BRANCH_94C4: ; Branched to from 94D2, 94F0
94C4	FD ED F0 0F 20      BII     #(PC1500_PRT_B),20          ; Pin 5 - Timer control
94C9	8B 09               BZS+    BRANCH_94D4                 ; If Pin 5 was not set
94CB	FD ED F0 0B 03      BII     #(PC1500_IF_REG),03         ; PC-1500 - IRQ and PB7 (power button) flags
94D0	89 13               BZR+    BRANCH_94E5                 ; If Bits 0 or 1 set 
94D2	9E 10               BCH-    BRANCH_94C4                 ; Unconditional branch back

BRANCH_94D4: ; Branched to from 94C9
94D4	62                  DEC	    UL                          ; 
94D5	81 0E               BCR+    BRANCH_94E5                 ; If UL was = 0

BRANCH_94D7: ; Branched to from 94E3
94D7	FD ED F0 0F 20      BII     #(PC1500_PRT_B),20          ; Pin 5 - Timer control
94DC	89 12               BZR+    BRANCH_94F0                 ; If Bit 5 was set
94DE	FD ED F0 0B 03      BII     #(PC1500_IF_REG),03         ; PC-1500 - IRQ and PB7 (power button) flags
94E3	9B 0E               BZS-    BRANCH_94D7                 ; If Bits 0 or 1 not set

BRANCH_94E5: ; Branched to from 94D0, 94D5, 94F2
94E5	B5 00               LDI	    A,00                        ;
94E7	FD AE F0 07         STA	    #(PC1500_F_REG_LD/DIV)      ; PC-1500 - Loader Divider to F Register
94EB	FD 81               SIE                                 ; Enable interrupts

BRANCH_94ED: ; Branched to from 950F, 9518
94ED	BA 92 CE            JMP	    BRANCH_92CE                 ; SUB_PRINT#_ALT_E1

BRANCH_94F0: ; Branched to from 94DC
94F0	88 2E               LOP	    UL,BRANCH_94C4              ;
94F2	9E 0F               BCH-    BRANCH_94E5                 ;



;------------------------------------------------------------------------------------------------------------
; JMP_94F4 - Jumped to from SUB_PRINT#_ALT_E1:92A4
; Note sure what it does
; Arguments: 
; Output: 
; RegMod: A, X, Y
JMP_94F4:
94F4	A5 78 91            LDA	    (7891)                      ; GOSUB pointer
94F7	8B 11               BZS+    BRANCH_950A                 ; If (7891) = 0 branch fwd
94F9	B5 E6               LDI	    A,E6                        ;
94FB	A7 78 92            CPA	    (7892)                      ; Data pointer
94FE	83 06               BCS+    BRANCH_9506                 ; If A >= (7892)
9500	EF 78 92 FF         ADI	    (7892),FF                   ; Set to FF and set carry?
9504	8E 04               BCH+    BRANCH_950A                 ; Unconditional branch fwd

BRANCH_9506: ; Branched to from 94FE
9506	E9 78 91 00         ANI	    (7891),00                   ; clear GOSUB pointer

BRANCH_950A: ; Branched to from 94F7, 9504
950A	A5 78 A8            LDA	    (78A8)                      ; SEARCH LINE (H)
950D	08                  STA	    XH                          ;
950E	D9                  SHL                                 ; A = A << 1. Thru carry
950F	93 24               BCS-    BRANCH_94ED                 ; If Bit 7 was set
9511	A5 78 A9            LDA	    (78A9)                      ; SEARCH LINE (L)
9514	0A                  STA	    XL                          ;
9515	FD 5A               STX     Y                           ; Transfered 78A8, 78A9 to Y
9517	47                  LDE	    X                           ; A = (X) then X = X - 1
9518	9B 2D               BZS-    BRANCH_94ED                 ; If A = Zero
951A	FB                  SEC                                 ; Set Carry Flag
951B	04                  LDA	    XL                          ;
951C	A1 78 A1            SBC	    (78A1)                      ; A = A - (78A1). PREVIOUS ADDRESS (L)
951F	84                  LDA	    XH                          ;
9520	A1 78 A0            SBC	    (78A0)                      ; A = A - (78A0). PREVIOUS ADDRESS (H)
9523	83 08               BCS+    BRANCH_952D                 ; Carry from subtraction
9525	A5 78 A5            LDA	    (78A5)                      ; PREVIOUS TOP (L)
9528	0A                  STA	    XL                          ;
9529	A5 78 A4            LDA	    (78A4)                      ; PREVIOUS TOP (H)
952C	08                  STA	    XH                          ;

BRANCH_952D: ; Branched to from 9523
952D	05                  LDA	    (X)                         ;
952E	89 14               BZR+    BRANCH_9544                 ; If A not zero branch fwd
9530	EB 78 A8 80         ORI	    (78A8),80                   ; Set Bit 7. SEARCH LINE (H)
9534	14                  LDA	    YL                          ;
9535	AE 78 BB            STA	    (78BB)                      ; ON ERROR LINE (L)
9538	AE 78 A7            STA	    (78A7)                      ; SEARCH ADDRESS (L)
953B	94                  LDA	    YH                          ;
953C	AE 78 BA            STA	    (78BA)                      ; ON ERROR LINE (H)
953F	AE 78 A6            STA	    (78A6)                      ; SEARCH ADDRESS (H)
9542	8E 1C               BCH+    BRANCH_9560                 ; Unconditional branch fwd

BRANCH_9544: ; Branched to from 952E
9544	14                  LDA	    YL                          ;
9545	A7 78 BB            CPA	    (78BB)                      ; ON ERROR LINE (L)
9548	89 0E               BZR+    BRANCH_9558                 ; If YL != (78BB)
954A	94                  LDA	    YH                          ;
954B	A7 78 BA            CPA	    (78BA)                      ; ON ERROR LINE (H)
954E	89 08               BZR+    BRANCH_9558                 ; If YH != (78BA) 
9550	04                  LDA	    XL                          ;
9551	AE 78 BB            STA	    (78BB)                      ; ON ERROR LINE (L)
9554	84                  LDA	    XH                          ;
9555	AE 78 BA            STA	    (78BA)                      ; ON ERROR LINE (H)

BRANCH_9558: ; Branched to from 9548, 954E
9558	04                  LDA	    XL                          ;
9559	AE 78 A9            STA	    (78A9)                      ; SEARCH LINE (L)
955C	84                  LDA	    XH                          ;
955D	AE 78 A8            STA	    (78A8)                      ; SEARCH LINE (H)

BRANCH_9560: ; Branched to from 9542
9560	15                  LDA	    (Y)                         ;
9561	59 00               ANI	    (Y),00                      ; Clear (Y)
9563	2A                  STA	    UL                          ;
9564	A5 78 B4            LDA	    (ERRORLINE)                 ;
9567	D9                  SHL                                 ; A  = A << 1. Thru carry
9568	81 1A               BCR+    BRANCH_9584                 ; If Bit 7 was not set
956A	6A 5C               LDI	    UL,5C                       ;

BRANCH_956C: ; Branched to from 9577, 957F
956C	24                  LDA	    UL                          ;
956D	BE 81 69            SJP	    CHAR2LPT                    ; Sends charecter in A to LPT
9570	81 4B               BCR+    BRANCH_95BD                 ; If sub success
9572	89 07               BZR+    BRANCH_957B                 ; If sub fail with A != 0?
9574	BE 9B 47            SJP	    SUB_9B47                    ; May return or poke new address into Stack Pointer
9577	9E 0D               BCH-    BRANCH_956C                 ; Unconditional branch back
9579	8E 42               BCH+    BRANCH_95BD                 ; Unconditional branch fwd, why both here?

BRANCH_957B: ; Branched to from 9572
957B	EF 78 50 10         ADI	    (OUTSTAT_REG),10            ; (OUTSTAT_REG) = (OUTSTAT_REG) + 10
957F	91 15               BCR-    BRANCH_956C                 ; If we did not carry out
9581	BA 8C FD            JMP	    JMP_8CFD                    ; Jumps on to SUB_8D04_ALT_E1

BRANCH_9584: ; Branched to from 9568
9584	B5 F4               LDI	    A,F4                        ;
9586	6E 80               CPI	    UL,80                       ;
9588	81 09               BCR+    BRANCH_9593                 ; If UL < 80
958A	F9                  REC                                 ; Reset Carry Flag
958B	ED 78 BE FF         BII	    (78BE),FF                   ; Used to set flags. DATA POINTER (H)
958F	8B 02               BZS+    BRANCH_9593                 ; If (78BE) = 00 branch fwd
9591	B5 FE               LDI	    A,FE                        ;

BRANCH_9593: ; Branched to from 9588, 958F
9593	A3 78 7F            ADC	    (787F)                      ; A = A + (787F). Blink cursor position (L)
9596	0A                  STA	    XL                          ;
9597	A5 78 7E            LDA	    (787E)                      ; Blink cursor position (H)
959A	08                  STA	    XH                          ;
959B	83 0A               BCS+    BRANCH_95A7                 ; Carry set by ADC?
959D	B5 4E               LDI	    A,4E                        ;
959F	02                  ADC	    XL                          ; A = A + XL
95A0	0A                  STA	    XL                          ;
95A1	FD 42               DEC	    XH                          ;
95A3	4C 74               CPI	    XH,74                       ;
95A5	81 19               BCR+    BRANCH_95C0                 ; If XH < 74

BRANCH_95A7: ; Branched to from 959B
95A7	FD 88               PSH	    X                           ;
95A9	BE 99 0C            SJP	    SUB_990C                    ; Converts AR-X to BCD (absolute) for display?
95AC	B5 00               LDI	    A,00                        ;
95AE	CD 88               VMJ	    (88)                        ; Converts AR-X to BCD (absolute) form
95B0	BE 99 0C            SJP	    SUB_990C                    ; Converts AR-X to BCD (absolute) for display?
95B3	FD 0A               POP	    X                           ;
95B5	04                  LDA	    XL                          ;
95B6	AE 78 7F            STA	    (787F)                      ; Blink cursor position (L)
95B9	84                  LDA	    XH                          ;
95BA	BE 98 FD            SJP	    SUB_98FD                    ; Converts AR-X to BCD (absolute) for display?

BRANCH_95BD: ; Branched to from 9570, 9579, 95C3
95BD	BA 92 CA            JMP	    BRANCH_92CA                 ; in SUB_PRINT#_ALT_E1

BRANCH_95C0: ; Branched to from 95A5
95C0	BE 98 E8            SJP	    98E8                        ; Converts AR-X to BCD (absolute) for display?
95C3	9E 08               BCH-    BRANCH_95BD                 ; Unconditional back branch



;---------------
; Not used???
;95C5	9E



;------------------------------------------------------------------------------------------------------------
; SUB_9600 - Entry at 9600 
; SUB_95C6 - Called from 8E91
; Might display text for terminal program?
; Arguments: 
; Output: 
; RegMod: A, X, Y, UL
SUB_95C6:
95C6	ED 76 4E 01         BII	    (HIGHLCDFLAG),01            ; LCD (Busy) Annunciator
95CA	8B 43               BZS+    BRANCH_960F                 ; Bit 0 not set
95CC	B5 01               LDI	    A,01                        ; 
95CE	AD 78 80            EOR	    (7880)                      ; Toggle Bit 0. Display parameter. Bit 7 = 1 is BREAK.
95D1	AE 78 80            STA	    (7880)                      ; Display parameter. Bit 7 = 1 is BREAK.
95D4	D5                  SHR                                 ; A = A >> 1.
95D5	81 26               BCR+    BRANCH_95FD                 ; If we did not shift Bit 0 out
95D7	BE EE 80            SJP     EE80                        ; Cache LCD in buffer

BRANCH_95DA: ; Branched to from 960D
95DA	A5 76 4E            LDA	    (HIGHLCDFLAG)               ; LCD annunciators
95DD	D5                  SHR                                 ; A = A >> 1, x 7 6 5 4 3 2 1
95DE	48 86               LDI	    XH,86                       ;
95E0	4A 35               LDI     XL,35                       ; X = 8635 = TEXT_8635 Text for termainal program?
95E2	87 09               BHS+    BRANCH_95ED                 ; Branch if half carry, original Bit 4 (DEFIII), set 
95E4	D5                  SHR                                 ; A = A >> 1, x x 7 6 5 4 3 2. Might set carry from (Shift)
95E5	B5 1A               LDI	    A,1A                        ; Only changes Z flag
95E7	FD CA               ADR	    X                           ; X = X + A + C (if SHIFT). X = 8635 + 1A + C (if SHIFT) = 864F
95E9	87 02               BHS+    BRANCH_95ED                 ; Branch if half carry
95EB	CD 38               VMJ	    38                          ; Determines reserve memory type adress + 8 and stores in X. 
                                                                ; Sets C=0 if 2nd reserve memory area is occupied 

BRANCH_95ED: ; Branched to from 95E2, 95E9
95ED	6A 19               LDI	    UL,19                       ;
95EF	5A 10               LDI	    YL,10                       ;
95F1	58 7A               LDI	    YH,7A                       ; Y = 7A10 Math_Reg_Ya_B1

BRANCH_95F3: ; Branched to from 95F4
95F3	F5                  TIN                                 ; (Y) = (X) then X = X + 1, Y = Y + 1
95F4	88 03               LOP	    UL,BRANCH_95F3              ;
95F6	FD 18               LDX	    Y                           ;
95F8	49 00               ANI	    (X),00                      ; zero (X)
95FA	BA EF 5B            JMP	    EF5B                        ; Text output on LCD from (AR-Y) to 7AXL

SUB_95FD: ; Branched to from 95D5
95FD	BA EE 99            JMP	    EE99                        ; Retransmit display from cache



;------------------------------------------------------------------------------------------------------------
; SUB_9600 - Called from to from 8E8C, 9616
; Updates LCD?
; Arguments: 
; Output: 
; RegMod: 
SUB_9600:
9600	BE 9E 20            SJP	    SUB_9E20                    ; Returns UL = 40 or 20 or 10 based on status of LCD annuniators
9603	ED 76 4E 01         BII	    (HIGHLCDFLAG),01            ; LCD (Busy) Annunciator
9607	8B 06               BZS+    BRANCH_960F                 ; If Bit 0 not set
9609	ED 78 80 01         BII	    (7880),01                   ; Display parameter. Bit 7 = 1 is BREAK.
960D	99 35               BZR-    BRANCH_95DA                 ; If Bit 0 was set

BRANCH_960F: ; Branched to from 95CA, 9607
960F	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; SUB_INPUT# - Main entry at 9660 
; Alt entry at 9687 Called from SUB_8D04:8ED7, 9634
; 9610, 9616, 961B, 9630, 9642, 9647, 967B, 96C8 jumped to from JUMP_TBL_915F
; Arguments: 
; Output: 
; RegMod: A, UL
JMP_9610: ; Jumped to from JUMP_TBL_915F
9610	BE 95 C6            SJP	    SUB_95C6                    ; Might display text for terminal program?

BRANCH_9613: ; Branched to from 9619, 9845, 964F, 9655, 9661, 965A, 9678
9613	BA 90 83            JMP	    UNKNOWN_JMP_9083            ; Changes LCD annunciators branches to SUB_PRINT#_ALT_X1



;------------------------------------------------------------------------------------------------------------
; JMP_9616 - Jumped to from JUMP_TBL_915F
; Arguments: 
; Output: 
; RegMod:
JMP_9616:
9616	BE 96 00            SJP	    SUB_9600                    ; Updates LCD?
9619	9E 08               BCH-    BRANCH_9613                 ; Unconditional branch back to exit



;------------------------------------------------------------------------------------------------------------
; JMP_961B -  Jumped to from JUMP_TBL_915F
; Arguments: 
; Output: 
; RegMod: UL, A
JMP_961B:
961B	2A                  STA	    UL                          ; What is A here?
961C	B9 0F               ANI	    A,0F                        ;
961E	AD 76 4F            EOR	    (LOWLCDFLAG)                ; Toggle - 0 (DE) 1 (G) 2 (RAD) 3 (vide) 
9621	AE 76 4F            STA	    (LOWLCDFLAG)                ;
9624	24                  LDA	    UL                          ; Get our A back
9625	BB 70               ORI	    A,70                        ; Set 4 (RESERVE) 5 (PRO) 6 (RUN)
9627	A9 76 4F            AND	    (LOWLCDFLAG)                ; Clear any settings not in A
962A	AE 76 4F            STA	    (LOWLCDFLAG)                ;
962D	BA 90 87            JMP	    UNKNOWN_JMP_9087            ; Not sure?


;------------------------------------------------------------------------------------------------------------
; JMP_9630 - Jumped to from JUMP_TBL_915F
; Arguments: 
; Output: 
; RegMod:
JMP_9630:
9630	ED 76 4F 20         BII	    (LOWLCDFLAG),20             ; Bit 5 = 2 (PRO)
9634	89 0C               BZR+    BRANCH_9642                 ; IF Bit 5 was set
9636	E9 78 AF 00         ANI	    (78AF),00                   ; Clear BREAK LINE (L)
963A	E9 78 AE 00         ANI	    (78AE),00                   ; Clear BREAK LINE (H)
963E	EB 78 AE FE         ORI	    (78AE),FE                   ; Bit 0 clear BREAK LINE (H)

BRANCH_9642: ; Branched to from 9634, Jumped to from JUMP_TBL_915F
9642	AE 76 4F            STA	    (LOWLCDFLAG)                ; 0 (DE) 1 (G) 2 (RAD) 3 (vide) 4 (RESERVE) 5 (PRO) 6 (RUN) 7 (DEF)
9645	9E 34               BCH-    BRANCH_9613                 ; Exit



;------------------------------------------------------------------------------------------------------------
; JMP_9647 - Jumped to from JUMP_TBL_915F
; Arguments: 
; Output: 
; RegMod: A
JMP_9647:
9647	AD 78 B4            EOR	    (ERRORLINE),B4              ; Flip 10110100
964A	D9                  SHL                                 ; A = A << 1. 
964B	81 04               BCR+    BRANCH_9651                 ; If Bit 7 was not set
964D	BF 80               BII	    A,80                        ;
964F	9B 3E               BZS-    BRANCH_9613                 ; If Bit 6, before shift, was set

BRANCH_9651: ; Branched to from 964B
9651	D1                  ROR                                 ; A = A >> 1. Rotated right through Carry
9652	AE 78 B4            STA	    (ERRORLINE)                 ; ERROR LINE (H)
9655	9E 44               BCH-    BRANCH_9613                 ; Unconditional branch back

; not reached?
9657	A9 76 4E            AND	    (HIGHLCDFLAG)               ; A = A & (HIGHLCDFGLAG). 0 (Busy), 1 (Shift), 2 (Katana), 3 (Small), 4 (DEFIII), 5 (DEFII), 6 (DEFI)
965A	9B 49               BZS-    BRANCH_9613                 ;
965C	A5 78 B4            LDA	    (ERRORLINE)                 ;
965F	BF 70               BII	    A,70                        ;



;------------------------------------------------------------------------------------------------------------
; SUB_INPUT# -  Jumped to from 831C from Command Vector Table @ 8331
; Adjusts LCD annunciators, may parse or manipulate BASIC lines
; Arguments: 
; Output: 
; RegMod: A
SUB_INPUT#:
;9660	70                  INC	    VL                          ; Undocumented command (test) bugus, check jump logic ***

9661	9B 50               BZS-    BRANCH_9613                 ; If A = 70
9663	BB 80               ORI	    A,80                        ; Set Bit 7
9665	AE 78 B5            STA	    (78B5)                      ; ERROR LINE (L)
9668	F4 78 A8            VEJ     (F4),(78A8)                 ; Loads U-Reg with 16-bit value from address of (78A8). SEARCH LINE
966B	CC AA               VEJ	    (CC),(AA)                   ; Loads X-Reg with address at 78(AA) 78(AB). SEARCH TOP
966D	ED 78 80 80         BII	    (7880),80                   ; Display parameter. Bit 7 = 1 is BREAK.
9671	89 02               BZR+    BRANCH_9675                 ; If Bit 7 set
9673	CC A0               VEJ	    (CC),(A0)                   ; Loads X-Reg with address at 78(A0) 78(A1). PREVIOUS ADDRESS

BRANCH_9675: ; Branched to from 9671
9675	BE 9B D0            SJP     SUB_9B95_ALT_E2             ;
9678	9E 67               BCH-    BRANCH_9613                 ; Uncondional branch back

; not reached ?
967A	00                  SBC	    XL                          ; A = A = XL

JMP_967B: ; Jumped to from SUB_PRINT#:94B1, JUMP_TBL_915F
967B	AD 76 4E            EOR	    (HIGHLCDFLAG)               ; A = A ^ (HIGHLCDFLAG). 0 (Busy), 1 (Shift), 2 (Katana), 3 (Small), 4 (DEFIII), 5 (DEFII), 6 (DEFI)
967E	AE 76 4E            STA	    (HIGHLCDFLAG)               ; 0 (Busy), 1 (Shift), 2 (Katana), 3 (Small), 4 (DEFIII), 5 (DEFII), 6 (DEFI)
9681	D5                  SHR                                 ; A = A >> 1
9682	83 2D               BCS+    BRANCH_96B1                 ; If Bit 0 was set
9684	BE 9D 39            SJP     SUB_9D39                    ; Not sure?

SUB_INPUT#_ALT_E1: ; Called from SUB_8D04:8ED7
9687	CD 8C               VMJ	    (8C)                        ; Calculated in X-Reg matrix column address from matrix pointer
9689	CA 7E               VEJ     (CA),(7E)                   ; Transfers X to 78(7E), 78(7F). Blink cursor position
968B	FD E9 B0 0A FD      ANI	    #(CE150_MSK_REG),FD         ; Clear bits 1. PB7 (Paper feed switch) interrupt mask. 
9690	BE 99 00            SJP     SUB_9900                    ; Converts AR-X to BCD (absolute) form?
9693	BE 99 12            SJP     SUB_9912                    ; Manipulates PREVIOUS TOP and SEARCH LINE
9696	CA BA               VEJ     (CA),(BA)                   ; Transfers X to 78(CA), 78(CB)
9698	A5 78 B3            LDA	    (78B3)                      ; ERROR ADDRESS (L)
969B	B7 B1               CPI     A,B1                        ;
969D	83 03               BCS+    BRANCH_96A2                 ; If A >= B1 Branch fwd
969F	BE 99 EC            SJP     SUB_99EC                    ; Sends charecter to RS232 Port?

BRANCH_96A2: ; Branched to from 969D
96A2	E9 76 4E FE         ANI	    (HIGHLCDFLAG),FE            ; Clear Bit 0 (Busy)
96A6	E9 78 80 00         ANI	    (7880),00                   ; Clear Display parameter. Bit 7 = 1 is BREAK.
96AA	E9 78 91 00         ANI	    (7891),00                   ; Clear GOSUB pointer
96AE	BA 92 3E            JMP	    SUB_PRINT#_ALT_E1           ; 

BRANCH_96B1: ; Branched to from 9682
96B1	BE 9B 95            SJP     SUB_9B95                    ; Not sure
96B4	BE 98 52            SJP     SUB_9852                    ; Not sure
96B7	BE 9F EF            SJP     SUB_9FEF                    ; CE-150 - Clears Pen Descending signal, and applies it again if safe.
96BA	E9 78 80 00         ANI	    (7880),00                   ; Clear Display parameter. Bit 7 = 1 is BREAK.
96BE	EB 76 4E 01         ORI	    (HIGHLCDFLAG),01            ; Set Bit 1 (Busy)

BRANCH_96C2: ; Branched to from 971B
96C2	BE 9D 39            SJP     SUB_9D39                    ; Not sure?

BRANCH_96C5: ; Brabched to from 96D6, 96DC, 96F3
96C5	BA 90 83            JMP	    UNKNOWN_JMP_9083            ; Changes LCD annunciators branches to SUB_PRINT#_ALT_X1

JMP_96C8: ; Jumped to from JUMP_TBL_915F
96C8	A9 76 4E            AND	    (HIGHLCDFLAG)               ; 0 (Busy), 1 (Shift), 2 (Katana), 3 (Small), 4 (DEFIII), 5 (DEFII), 6 (DEFI)
96CB	89 2F               BZR+    BRANCH_96FC                 ;
96CD	E9 78 80 00         ANI	    (7880),00                   ; Clear Display parameter. Bit 7 = 1 is BREAK.
96D1	A5 78 B4            LDA	    (ERRORLINE)                 ;
96D4	B7 C0               CPI     A,C0                        ;
96D6	93 13               BCS-    BRANCH_96C5                 ; If A >= C0 branch back
96D8	ED 76 4F 10         BII	    (LOWLCDFLAG),10             ; Bit 4 (RESERVE)
96DC	99 19               BZR-    BRANCH_96C5                 ; If Bit 4 was set branch back
96DE	BE 9B 95            SJP     SUB_9B95                    ; Not sure?
96E1	BE 98 52            SJP     SUB_9852                    ; Not sure?
96E4	EB 76 4E 01         ORI	    (HIGHLCDFLAG),01            ; Set Bit 0 (BUSY)

BRANCH_96E8: ; Branched to from 96FF, 970B, 9714
96E8	CC A0               VEJ	    (CC),(A0)                   ; Loads X-Reg with address at 78(A0) 78(A1). PREVIOUS ADDRESS
96EA	F4 78 A8            VEJ	    (F4),(78A8)                 ; Loads U-Reg with 16-bit value from address of (78A8)
96ED	BE 9F EF            SJP     SUB_9FEF                    ; CE-150 - Clears Pen Descending signal, and applies it again if safe.
96F0	BE DF E2            SJP     SUB85                       ; U = U - X, When upper limit occurs: C=0 and UH=16
96F3	91 30               BCR-    BRANCH_96C5                 ; Carry returned from sub
96F5	B5 80               LDI	    A,80                        ;
96F7	AE 78 80            STA	    (7880)                      ; Display parameter. Bit 7 = 1 is BREAK.
96FA	8E 97               BCH+    BRANCH_9793                 ; Unconditional brach fwd

BRANCH_96FC: ; Branched to from 96CB
96FC	A5 78 80            LDA	    (7880)                      ; Display parameter. Bit 7 = 1 is BREAK.
96FF	9B 19               BZS-    BRANCH_96E8                 ; If A = 0 branch back
9701	D5                  SHR                                 ; A = A >> 1
9702	81 07               BCR+    BRANCH_970B                 ; If Bit 0 was not set
9704	BE EE 99            SJP     EE99                        ; Retransmit display from cache
9707	E9 78 80 FE         ANI	    (7880),FE                   ; Display parameter. Bit 7 = 1 is BREAK.

BRANCH_970B: ; Branched to from 9702
970B	9B 25               BZS-    BRANCH_96E8                 ; 
970D	A5 78 96            LDA	    (7896)                      ; USING M integer part
9710	B7 9B               CPI     A,9B                        ; 
9712	81 09               BCR+    BRANCH_971D                 ; If A < 9B branch fwd
9714	9B 2E               BZS-    BRANCH_96E8                 ; If A > 9B branch back
9716	B5 80               LDI	    A,80                        ; If A = 9B poke 80 into 7880
9718	AE 78 80            STA	    (7880)                      ; Display parameter. Bit 7 = 1 is BREAK.
971B	9E 5B               BCH+    BRANCH_96C2                 ; Unconditional branch fwd

BRANCH_971D: ; Branched to from 9712
971D	D5                  SHR                                 ; A = A >> 1. A = (7896) = USING M integer part
971E	83 06               BCS+    BRANCH_9726                 ; If Bit 0 was set
9720	D5                  SHR                                 ; A = A >> 1.
9721	83 4B               BCS+    BRANCH_9726                 ; If Bit 1 was set
9723	D5                  SHR                                 ; A = A >> 1.
9724	83 48               BCS+    BRANCH_9726                 ; If Bit 2 was set

BRANCH_9726: ; Branched to from 971E
9726	F4 78 AA            VEJ	    (F4),(78AA)                 ; Loads U-Reg with 16-bit value from address of (78AA)
9729	CC A0               VEJ	    (CC),(A0)                   ; Loads X-Reg with address at 78(A0) 78(A1). PREVIOUS ADDRESS
972B	BE DF E1            SJP     DFE1                        ; U = U - X - 1. When upper limit occurs: C=0 and UH=16
972E	81 1A               BCR+    BRANCH_974A                 ;
9730	CC AA               VEJ	    (CC),(AA)                   ; Loads X-Reg with address at 78(AA) 78(AB). SEARCH TOP
9732	46                  DEC	    X                           ;
9733	ED 7B 0F 01         BII	    (7B0F),01                   ; Last pressed key code
9737	89 24               BZR+    BRANCH_975D                 ; If last key > 0
9739	05                  LDA	    (X)                         ;
973A	B7 0D               CPI     A,0D                        ; 0D = CR
973C	8B 1F               BZS+    BRANCH_975D                 ; If A = 0D branch fwd
973E	B7 20               CPI     A,20                        ; 20 = Space
9740	8B 1B               BZS+    BRANCH_975D                 ; If A = 20 branch fwd
9742	E9 78 B1 00         ANI	    (78B1),00                   ; BREAK TOP (L)
9746	FB                  SEC                                 ; Set Carry Flag
9747	BE 9D 4B            SJP     SUB_9D4B                    ; Not sure

BRANCH_974A: ; Branched to from 972E, 9776, 9796, 97AD
974A	BA 90 83            JMP	    UNKNOWN_JMP_9083            ; Changes LCD annunciators branches to SUB_PRINT#_ALT_X1

BRANCH_974D: ; Branched to from 975D, 9761
974D	46                  DEC	    X                           ; 
974E	05                  LDA	    (X)                         ;
974F	B7 0D               CPI     A,0D                        ; 0D = CR
9751	8B 12               BZS+    BRANCH_9765                 ; If A = 0D branch fwd
9753	ED 7B 0F 01         BII	    (7B0F),01                   ; Last pressed key code
9757	89 04               BZR+    BRANCH_975D                 ; If Bit 0 was not set branch fwd
9759	B7 20               CPI     A,20                        ; 20 = Space
975B	8B 08               BZS+    BRANCH_9765                 ; If A = 20 branch fwd

BRANCH_975D: ; Branched to from 9737, 973C, 9740, 9757
975D	88 12               LOP     UL,BRANCH_974D              ; UL = UL - 1, loop back 'e' if Borrow Flag not set
975F	FD 62               DEC	    UH                          ; U set in 9726, is from (78AA, 78AB) SEARCH TOP
9761	93 16               BCS-    BRANCH_974D                 ; Loop back until copying done.
9763	8E 01               BCH+    BRANCH_9766                 ; Unconditional branch fwd

BRANCH_9765: ; Branched to from 975B
9765	44                  INC	    X                           ;

BRANCH_9766: ; Branched to from 9763
9766	F4 78 A8            VEJ	    (F4),(78A8)                 ; Loads U-Reg with 16-bit value from address of SEARCH LINE
9769	BE DF E2            SJP     SUB85                       ; U = U - X, When upper limit occurs: C=0 and UH=16
976C	8E 25               BCH+    BRANCH_9793                 ; Unconditional branch fwd

BRANCH_9726: ; Branched to from 9721, 9724
976E	F4 78 A8            VEJ	    (F4),(78A8)                 ; Loads U-Reg with 16-bit value from address of SEARCH LINE
9771	CC AC               VEJ	    (CC),(AC)                   ; Loads X-Reg with address at 78(AC) 78(AD). BREAK ADDRESS
9773	BE DF E1            SJP     DFE1                        ; U = U - X - 1. When upper limit occurs: C=0 and UH=16
9776	91 2E               BZR-    BRANCH_974A                 ; What was set to zero in sub
9778	ED 7B 0F 02         BII	    (7B0F),02                   ; Last pressed key code
977C	89 1A               BZR+    BRANCH_9798                 ;
977E	CC AC               VEJ	    (CC),(AC)                   ; Loads X-Reg with address at 78(AC) 78(AD). BREAK ADDRESS
9780	45                  LIN     X                           ; A = (X) then INC X
9781	B7 0D               CPI     A,0D                        ; 0D = CR
9783	8B 04               BZS+    BRANCH_9789                 ; If A = 0D branch fwd
9785	B7 20               CPI     A,20                        ; 20 = Space
9787	89 0A               BZR+    BRANCH_9793                 ; If A = 0D branch fwd

BRANCH_9789: ; Branched to from 9783
9789	CC AA               VEJ     (CC),(AA)                   ; Loads X-Reg with address at 78(AA) 78(AB). SEARCH TOP
978B	F4 78 A8            VEJ	    (F4),(78A8)                 ; Loads U-Reg with 16-bit value from address of (78A8). SEARCH LINE
978E	BE DF E2            SJP     SUB85                       ; U = U - X, When upper limit occurs: C=0 and UH=16
9791	8E 05               BCH+    BRANCH_9798                 ; Unconditional branch fwd

BRANCH_9793: ; Branched to from 96FA, 976C, 9787,979B, 97A5
9793	BE 9D 2A            SJP     SUB_9D2A                    ; Not sure
9796	9E 4E               BCH+    BRANCH_974A                 ; Unconditional branch fwd

BRANCH_9798: ; Branched to from 977C, 9791, 97A7, 97AB
9798	45                  LIN     X                           ; A = (X) then INC X
9799	B7 0D               CPI     A,0D                        ; 0D = CR
979B	9B 0A               BZS-    BRANCH_9793                 ; If A = 0D branch back
979D	ED 7B 0F 02         BII	    (7B0F),02                   ; Last pressed key code
97A1	89 04               BZR+    BRANCH_98A7                 ; If Bit 1 set
97A3	B7 20               CPI     A,20                        ; 20 = Space
97A5	9B 14               BZS-    BRANCH_9793                 ; If A = 20 branch back

BRANCH_97A7: ; Branched to from 97A1
97A7	88 11               LOP     UL,BRANCH_9798              ; UL = UL - 1, loop back 'e' if Borrow Flag not set
97A9	FD 62               DEC	    UH                          ;
97AB	93 15               BCS-    BRANCH_9798                 ; If carry set branch back
97AD	9E 65               BCH-    BRANCH_974A                 ; Branch back unconditional



;------------------------------------------------------------------------------------------------------------
; SUB_97BA - Called from 8FE5, 9997, 9B59
; Changes last pressed key code and repeat speed?
; Arguments: 
; Output: 
; RegMod: UL, A
SUB_97BA:
97BA	BE 79 FA            SJP     UNDEF_REG_79FA              ; Not sure?
97BD	BE 98 11            SJP     SUB_9811                    ; A = 0E or keypress from RS232
97C0	2A                  STA	    UL                          ;
97C1	A7 7B 0F            CPA	    (7B0F)                      ; Last pressed key code
97C4	89 1C               BZR+    BRANCH_97E2                 ; If A != (7B0F) branch fwd
97C6	EF 7B 08 01         ADI	    (7B08),01                   ; (7B08) = (7B08) + 1. Undefined
97CA	89 43               BZR+    BRANCH_980F                 ; If Bit 1 set, exiting
97CC	EF 7B 09 01         ADI	    (7B09),01                   ; (7B09) = (7B09) + 1. Repeat speed
97D0	89 3D               BZR+    BRANCH_980F                 ; If Bit 1 set, exiting
97D2	24                  LDA	    UL                          ;
97D3	8B 08               BZS+    BRANCH_97DD                 ; If A = 0 branch fwd
97D5	EB 7B 09 FF         ORI	    (7B09),FF                   ; Set to FF. Repeat speed
97D9	B5 C0               LDI	    A,C0                        ;
97DB	8E 20               BCH+    BRANCH_97FD                 ; Unconditional fwd branch, exiting

BRANCH_97DD: ; Branched to from 97D3
97DD	EB 7B 0F FF         ORI	    (7B0F),FF                   ; Set to FF, Last pressed key code
97E1	9A                  RTN                                 ; FF = No key pressed?

BRANCH_97E2: ; Branched to from 97C4
97E2	A5 7B 0F            LDA	    (7B0F)                      ; Last pressed key code
97E5	DD                  INC	    A                           ;
97E6	89 1A               BZR+    SUB_9802                    ; Resets last pressed key register and repeat speed.
97E8	24                  LDA	    UL                          ;
97E9	8B 24               BZS+    BRANCH_980F                 ; If A = 0, exiting
97EB	AE 7B 0F            STA	    (7B0F)                      ; Last pressed key code
97EE	BE 98 11            SJP     SUB_9811                    ; A = 0E or keypress from RS232
97F1	A7 7B 0F            CPA	    (7B0F)                      ; Last pressed key code 
97F4	89 0C               BZR+    SUB_9802                    ; Resets last pressed key register and repeat speed.
97F6	B5 FD               LDI	    A,FD                        ;
97F8	AE 7B 09            STA	    (7B09)                      ; Repeat speed
97FB	B5 00               LDI	    A,00                        ;

BRANCH_97FD: ; Branched to from 97D8
97FD	AE 7B 08            STA	    (7B08)                      ; Undefined
9800	F9                  REC                                 ; Reset Carry Flag
9801	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; Resets last pressed key register and repeat speed.
; Branched to from 97E6, 97F4,
; Called from 8ECA, 903E, 91F0, 998D, 9B60
; Arguments: 
; Output: 
; RegMod: A
SUB_9802: ; 
9802	E9 7B 0F 00         ANI	    (7B0F),00                   ; clear last pressed key code
9806	B5 E0               LDI	    A,E0                        ;
9808	AE 7B 08            STA	    (7B08)                      ; Undefined
980B	EB 7B 09 FF         ORI	    (7B09),FF                   ; Set Repeat speed to FF

BRANCH_980F: ; Branched to from 97CA, 97D0, 97E9
980F	FB                  SEC                                 ; Set Carry Flag
9810	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; Called from 97BD, 97EE
; Convert charecter from RS232 to keypress code on PC-1500
; Arguments: 
; Output: 
; RegMod: X, A = 0E or keypress from RS232
SUB_9811:
9811	4A 77               LDI	    XL,77                       ;
9813	FD E9 F0 0D 7F      ANI	    #(PC1500_PRT_B_DIR),7F      ; Clear Bit 7
9818	B5 01               LDI	    A,01                        ; 

BRANCH_981A: ; Branched to from 982F
981A	FD AE F0 0C         STA     #(PC1500_PRT_A_DIR)         ; Bit 0 Write. DTR
981E	FD E9 F0 0E 00      ANI	    #(PC1500_PRT_A_DIR),00      ; Set DTR to zero
9823	08                  STA	    XH                          ; 1st XH = 1, 2nd XH = 2
9824	B5 08               LDI	    A,08                        ; 1st round X = 0177, 
9826	FD CA               ADR	    X                           ; X = X + A + Carry, 1st X = 017F, 2nd X = 0287
9828	FD BA               ITA                                 ; A = Input port IN0-IN7
982A	DD                  INC	    A                           ; No flag change w/16bit register
982B	89 06               BZR+    BRANCH_9833                 ; If A was != 00 branch fwd (we rxd actual charecter)
982D	84                  LDA	    XH                          ; 1st round A = 01
982E	D9                  SHL                                 ; A = A << 1, 1st round A = 2
982F	91 17               BCR-    BRANCH_981A                 ; If Bit 7 was not set, jump back. Done after 255 reads?
9831	8E 08               BCH+    BRANCH_983B                 ; Unconditional branch fwd

BRANCH_9833: ; Branched to from 982B
9833	DF                  DEC	    A                           ; DEC to get original A back

BRANCH_9834: ; Branched to from 9836
9834	40                  INC	    XL                          ; 1st round X = 0180. 2nd X = 0288
9835	D9                  SHL                                 ; A = A << 1.       A << 1 = 60
9836	93 04               BCS-    BRANCH_9834                 ; If Bit 7 was set branch back, move to next char in table?
9838	48 FE               LDI	    XH,FE                       ; 
983A	05                  LDA	    (X)                         ; A = (X). X = FE80 is start of normal keybaord table

BRANCH_983B: ; Branched to from 9831
983B	FD ED F0 0F 80      BII     #(PC1500_PRT_B),80          ; Bit 7 = Busy
9840	8B 02               BZS+    BRANCH_9844                 ; If Bit 7 was not set
9842	B5 0E               LDI	    A,0E                        ;

BRANCH_9844: ; Branched to from 9840
9844	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; SUB_9845, Called from 90B8, 92D6, 9476
; Arguments 90B8:XL = D8, 92D6:XL = B0, 9476:XL = B0
; Shifts display left one charecter
; Arguments: 
; Output: 
; RegMod: X, U, A
SUB_9845:
9845	48 7B               LDI	    XH,7B                       ; X = 7BD8 or X = 7BB0
9847	FD 5A               STX     Y                           ; 7BD8 = INPUT_BUFF_B40, 7BB0 = INPUT_BUFF_B0
9849	45                  LIN	    (X)                         ; A = (X) then INC X. A is 1st charecter
984A	28                  STA     UH                          ; UH = A = INPUT_BUFF_B40 or B0
984B	6A 26               LDI	    UL,26                       ; UL is number of copy loops 38-0 + 1 above 40 decimal

BRANCH_984D:
984D	F5                  TIN                                 ; (Y) = (X) then X = X + 1, Y = Y + 1
984E	88 03               LOP	    UL,BRANCH_984D              ; UL = UL - 1, loop back 'e' if Borrow Flag not set
9850	A4                  LDA	    UH                          ; A is first copied value
9851	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; SUB_9852, SUB_INPUT#_ALT_E1:Called from 96E1, 96B4
; Seems to be involved with editing a line
; Arguments: 
; Output: 
; RegMod: Y, X, U
SUB_9852:                                                       ; (78A6) SEARCH ADDRESS (H)
9852	F4 78 A6            VEJ	    (F4),(78A6)                 ; Loads U-Reg with 16-bit value from address of (78A6). SEARCH ADDRESS
9855	CC A0               VEJ	    (CC),(A0)                   ; Loads X-Reg with address at 78(A0) 78(A1). PREVIOUS ADDRESS
9857	BE DF E2            SJP     SUB85                       ; U = U - X, When upper limit occurs: C=0 and UH=16
985A	18                  STA	    YH                          ;
985B	24                  LDA	    UL                          ;
985C	1A                  STA	    YL                          ;
985D	CA A6               VEJ	    (CA),(A6)                   ; Transfers X to 78(A6), 78(A7). SEARCH ADDRESS
985F	F4 78 A2            VEJ     (F4),(PREV_LINE_H)          ; Loads U-Reg with 16-bit value from address of (78A2). PREVIOUS LINE
9862	46                  DEC	    X                           ; X = X - 1, account for INC below?

BRANCH_9863: ; Branched to from 988B
9863	44                  INC	    X                           ; X = X + 1
9864	84                  LDA	    XH                          ;
9865	AE 78 7C            STA	    (787C)                      ; BLINK
9868	04                  LDA	    XL                          ;
9869	AE 78 7D            STA	    (787D)                      ; Character code to be blinked
986C	05                  LDA	    (X)                         ; X = PREVIOUS ADDRESS?
986D	AE 78 BD            STA	    (78BD)                      ; ON ERROR TOP (L)
9870	8E 1B               BCH+    BRANCH_988D                 ; Unconditional fwd branch: 

BRANCH_9872: ; Branched to from 988D, 9891
9872	BE 98 A5            SJP     SUB_98A5                    ; X = X - Y with perhaps some offset from PREVIOUS LINE
9875	05                  LDA	    (X)                         ;
9876	FD C8               PSH	    A                           ;
9878	A5 78 BD            LDA	    (78BD)                      ; ON ERROR TOP (L)
987B	0E                  STA	    (X)                         ;
987C	FD 8A               POP	    A                           ;
987E	AE 78 BD            STA	    (78BD)                      ; ON ERROR TOP (L)
9881	04                  LDA	    XL                          ;
9882	A7 78 7D            CPA	    (787D)                      ; Character code to be blinked
9885	89 06               BZR+    BRANCH_988D                 ; If XL!= (787D) branch fwd
9887	84                  LDA	    XH                          ;
9888	A7 78 7C            CPA	    (787C)                      ; BLINK
988B	9B 2A               BZS-    BRANCH_9863                 ; If XH != (787C) branch back

BRANCH_988D: ; Branched to from 9870, 9885                      ; U is SEARCH ADDRESS?
988D	88 1D               LOP	    UL,BRANCH_9872              ; UL = UL - 1, loop back e if Borrow Flag not set
988F	FD 62               DEC	    UH                          ;
9891	93 21               BCS-    BRANCH_9872                 ; If carry set branch back
9893	CC A8               VEJ	    (CC),(A8)                   ; Load X with 78A8, 78A9. SEARCH LINE (H) (L)
9895	D9                  SHL                                 ; A = A << 1
9896	83 0C               BCS+    BRANCH_98A4                 ; If Bit 7 shifted out
9898	BE 98 A5            SJP     SUB_98A5                    ; X = X - Y with perhaps some offset from PREVIOUS LINE
989B	CA A8               VEJ     (CA),(A8)                   ; Transfers X to 78A8, 78A9 SEARCH LINE (H) (L)
989D	CC BA               VEJ	    (CC),(BA)                   ; Load X with 78BA, 78BB. ON ERROR LINE (H) (L)
989F	BE 98 A5            SJP     SUB_98A5                    ; X = X - Y with perhaps some offset from PREVIOUS LINE
98A2	CA BA               VEJ     (CA),(BA)                   ; Transfers X to 78BA, 78BB ON ERROR LINE (H) (L)

BRANCH_98A4: ; Branched to from 98A4
98A4	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; SUB_98A5, Called from SUB_9852:9872,9898, 989F
; Maybe adjusting line poiners for BASIC?
; XH = XH - YH, XL = XL - YL or XH = XH - YH + PREVIOUS LINE (H), XL = XL - YL + PREVIOUS LINE (L)
; X = X - Y with perhaps some offset from PREVIOUS LINE
; Arguments: 
; Output: 
; RegMod: A, X
SUB_98A5:
98A5	FB                  SEC                                 ; Set Carry Flag
98A6	04                  LDA	    XL                          ;
98A7	10                  SBC	    YL                          ; A = A - YL
98A8	0A                  STA	    XL                          ; XL = XL - YL
98A9	84                  LDA	    XH                          ;
98AA	90                  SBC	    YH                          ; A = A - YH
98AB	08                  STA	    XH                          ; XH = XH - YH. i.e. X = X - Y
98AC	81 0A               BCR+    BRANCH_98B8                 ; If we did not go negative, skip to exit
98AE	04                  LDA	    XL                          ; This part does nothing but set carry
98AF	A1 78 A1            SBC	    (78A1)                      ; A = A - (78A1). PREVIOUS ADDRESS (L)
98B2	84                  LDA	    XH                          ;
98B3	A1 78 A0            SBC	    (78A0)                      ; A = A - (78A0). PREVIOUS ADDRESS (H)
98B6	83 0A               BCS+    BRANCH_98C2                 ; If carry set, error so branch to exit

BRANCH_98B8: ; Branched to from 98AC                    
98B8	A5 78 A3            LDA	    (78A3)                      ; PREVIOUS LINE (L)
98BB	02                  ADC	    XL                          ; A = A + XL
98BC	0A                  STA	    XL                          ; XL = XL + (78A3). XL = XL - YL + PREVIOUS LINE (L)
98BD	A5 78 A2            LDA	    (PREV_LINE_H)               ; PREVIOUS LINE (H)
98C0	82                  ADC	    XH                          ; A = A + XH
98C1	08                  STA	    XH                          ; XH = XH + (PREV_LINE_H). XH = XH - YH + PREVIOUS LINE (H)

BRANCH_98C2: ; Branched to from 98B6
98C2	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; SUB_98C3 - Called from 944B
; Converts a value in AR-X to BCD for display
; Arguments: 
; Output: 
; RegMod: X, Y, A
SUB_98C3:
98C3	A5 78 7F            LDA	    (787F)                      ; Blink cursor position (L)
98C6	0A                  STA	    XL                          ;
98C7	A5 78 7E            LDA	    (787E)                      ; Blink cursor position (H)
98CA	08                  STA	    XH                          ;
98CB	5A 00               LDI	    YL,00                       ;
98CD	58 7A               LDI	    YH,7A                       ; Y = 7A00, MATH_REG_Xa_B1
98CF	8E 35               BCH+    BRANCH_9906                 ; Unconditional fwd branch



;------------------------------------------------------------------------------------------------------------
; SEPERATOR_8D1 - FF 00 fills unuseed space
SEPARATOR_98D1:
98D1	FF 00 FF 00 FF 00 FF 00   FF 00 FF 00 FF 00 FF 00 
98E1	FF 00 FF 00 FF 00 FF 



;------------------------------------------------------------------------------------------------------------
; SUB_98E8 - Called from 936B, 95C0
; Pulls bit patterns for charecters out of matrix for LCD?
; Arguments: 
; Output: 
; RegMod: A, X, Y
SUB_98E8: ; 
98E8	BE 99 12            SJP	    SUB_9912                    ; Manipulates PREVIOUS TOP and SEARCH LINE
98EB	AE 78 AA            STA	    (78AA)                      ; SEARCH TOP (H)
98EE	04                  LDA	    XL                          ; 
98EF	AE 78 AB            STA	    (78AB)                      ; SEARCH TOP (L)
98F2	F2                  VEJ     (F2)                        ; deletes LCD display
98F3	AE 78 75            STA	    (7875)                      ; CURSOR POINTER (0 to 155)
98F6	0A                  STA	    XL                          ;
98F7	AE 78 7F            STA	    (787F)                      ; Blink cursor position (L) 
98FA	B5 74               LDI	    A,74                        ;
98FC	08                  STA	    XH                          ;

SUB_98FD: ; Called from 95BA
98FD	AE 78 7E            STA	    (787E)                      ; Blink cursor position (H)

SUB_9900: ; Called from 9690
9900	5A DB               LDI	    YL,DB                       ;
9902	58 FD               LDI	    YH,FD                       ; Y = FDDB, inside LCD charecter matrix

BRANCH_9904: ; Branched to from 9910
9904	6A 04               LDI	    UL,04                       ; Loop counter

BRANCH_9906:                                                    ; Y = 7A00 (98CF) or Y = FDDB (9902) or Y = FC0A (9910)
9906	55                  LIN     Y                           ; A = (Y). Then INC Y
9907	CD 88               VMJ     (88)                        ; vector to F661: Converts AR-X to BCD (absolute) form
9909	88 05               LOP	    UL,BRANCH_9906              ; Converts each byte passed to BCD, for display?
990B	9A                  RTN                                 ;

SUB_990C: ;  Called from 95A9, 95B0
990C	5A A0               LDI	    YL,A0                       ;
990E	58 FC               LDI	    YH,FC                       ; Y = FCA0, begging of LCD charecter matrix
9910	9E 0E               BCH-    BRANCH_9904                 ; Unconditional back branch



;------------------------------------------------------------------------------------------------------------
; SUB_9912 - Called from 9933, alt entries at 991D, 991E
; If SEARCH_LINE & 80 > 0 then X = SEARCH_LINE, C=1, else
; If SEARCH_LINE + 1 >= PREVIOUS_TOP then X = SEARCH_LINE, A = SEARCH_LINE_H, C = 0
; If SEARCH_LINE < PREVIOUS_TOP then X = PREVIOUS_ADDRESS, C = 0
; Arguments: 
; Output: 
; RegMod: A, X
SUB_9912:
9912	A5 78 A9            LDA	    (78A9)                      ; SEARCH LINE (L)
9915	0A                  STA	    XL                          ;
9916	A5 78 A8            LDA	    (78A8)                      ; SEARCH LINE (H)
9919	08                  STA	    XH                          ;
991A	D9                  SHL                                 ; A = A << 1
991B	83 0D               BCS+    BRANCH_992A                 ; If Bit 7 was set

SUB_9912_ALT1: ; Called from 9954
991D	44                  INC	    X                           ;

; if Called from 93D0. If X > PREVIOUS_TOP X=X, else X=PREVIOUS_ADDRESS, A=XH
SUB_9912_ALT2: 
991E	04                  LDA	    XL                          ; XL = (SEARCH LINE (L)) + 1
991F	A1 78 A5            SBC	    (78A5)                      ; A = A - (78A5). PREVIOUS TOP (L)
9922	84                  LDA	    XH                          ;
9923	A1 78 A4            SBC	    (78A4)                      ; A = A - (78A4). PREVIOUS TOP (L)
9926	84                  LDA	    XH                          ; Subtractions only to get carry set
9927	81 09               BCR+    BRANCH_9932                 ; Carry set by SBC above
9929	F9                  REC                                 ; Reset Carry Flag

BRANCH_992A: ; Branched to from 991B
992A	A5 78 A1            LDA	    (78A1)                      ; PREVIOUS ADDRESS (L)
992D	0A                  STA	    XL                          ;
992E	A5 78 A0            LDA	    (78A0)                      ; PREVIOUS ADDRESS (H)
9931	08                  STA	    XH                          ;

BRANCH_9932: ; Branched to from 9927
9932	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; SUB_9933, Called from 947F
; Seems to adjust SEARCH_LINE, SEARCH_ADDRESS, ON_ERROR_LINE
; Arguments: 
; Output: 
; RegMod: A, X, 
SUB_9933:
9933	BE 99 12            SJP	    SUB_9912                    ; X = SEARCH_LINE or SEARCH_LINE+1 or X = PREVIOUS_ADDRESS
9936	04                  LDA	    XL                          ; Save the X returned from SUB_9912 to SEARCH_LINE
9937	AE 78 A9            STA	    (78A9)                      ; SEARCH LINE (L)
993A	84                  LDA	    XH                          ;
993B	AE 78 A8            STA	    (78A8)                      ; SEARCH LINE (H)
993E	83 34               BCS+    BRANCH_9974                 ; Carry set in SUB_9912 if (SEARCH_LINE & 80 > 0)

9940	FD A8               PSH	    U                           ; Save U
9942	FD 6A               STX     U                           ; U = X
9944	A5 78 A7            LDA	    (78A7)                      ; SEARCH ADDRESS (L)
9947	0A                  STA	    XL                          ;
9948	A5 78 A6            LDA	    (78A6)                      ; SEARCH ADDRESS (H)
994B	08                  STA	    XH                          ;
994C	A6                  CPA	    UH                          ;
994D	89 20               BZR+    BRANCH_996F                 ; If XH != UH branch fwd
994F	04                  LDA	    XL                          ; XL = (78A7)
9950	26                  CPA	    UL                          ;
9951	89 1C               BZR+    BRANCH_996F                 ; If XL != UL branch fwd

9953	F9                  REC                                 ; Reset Carry Flag
9954	BE 99 1D            SJP	    SUB_9912_ALT1               ; If X > PREVIOUS_TOP X = X, else X = PREVIOUS_ADDRESS. A = XH
9957	AE 78 A6            STA	    (78A6)                      ; A = XH. SEARCH ADDRESS (H)
995A	04                  LDA	    XL                          ;
995B	AE 78 A7            STA	    (78A7)                      ; SEARCH ADDRESS (L)
995E	26                  CPA	    UL                          ;
995F	89 0E               BZR+    BRANCH_996F                 ; If XL != UL branch fwd

9961	A5 78 BA            LDA	    (78BA)                      ; ON ERROR LINE (H)
9964	A6                  CPA	    UH                          ; 
9965	89 08               BZR+    BRANCH_996F                 ; If A != UH branch fwd
9967	04                  LDA	    XL                          ;
9968	AE 78 BB            STA	    (78BB)                      ; ON ERROR LINE (L)
996B	84                  LDA	    XH                          ;
996C	AE 78 BA            STA	    (78BA)                      ; ON ERROR LINE (H)

BRANCH_996F: ; Branched to from 994D, 9951, 995F, 9965
996F	FD 28               LDX	    U                           ; X = U
9971	FD 2A               POP     U                           ;
9973	9A                  RTN                                 ;

BRANCH_9974: ; Branched to from 993E 
9974	F9                  REC                                 ; Reset Carry Flag. Carry set on exit == Error?
9975	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; SUB_9976 - Called from 933C
; A = 0, copies code from (SUB_7A50_#) 8684 + A to System RAM 7A50
; First byte read from table is #bytes of code, second byte is LB of starting address of code
; This copied code seems to move other code around
; Arguments: 
; Output: 
; RegMod: X, UL
SUB_9976:
9976	FD 98               PSH	    Y                           ;
9978	5A 50               LDI	    YL,50                       ;
997A	58 7A               LDI	    YH,7A                       ; Y = 7A50 BASIC STACK Byte 24
997C	4A 84               LDI	    XL,84                       ;
997E	48 86               LDI	    XH,86                       ; X = 8684 = SUB_7A50_1_HDR
9980	FD CA               ADR	    X                           ; X = X + A
9982	45                  LIN	    X                           ; A = (X) then INC X. A = (8684) = 19
9983	2A                  STA	    UL                          ; UL = 19. # of bytes
9984	05                  LDA	    (X)                         ; A = (8685) = 88
9985	0A                  STA	    XL                          ; X = 8688. X = #bytes, X + 1 = XL

BRANCH_9986: ; Branched to from 9987                            ; (7A50) = (8688)
9986	F5                  TIN                                 ; (Y) = (X) then X = X + 1, Y = Y + 1
9987	88 03               LOP     UL,BRANCH_9986              ; UL = UL - 1, loop back 'e' if Borrow Flag not set
9989	FD 1A               POP	    Y                           ;
998B	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; SEPARATOR_998C - 00 FF filles unused space
SEPARATOR_998C:
998C	00                  .BYTE   00                          ;



;------------------------------------------------------------------------------------------------------------
; Called from 8D70, SUB_8FC1:8F01
; Branched to from 999F
; Resets last pressed key register, repeat speed, LCD annunciators
; Arguments: 
; Output: 
; RegMod: A
SUB_998D: 
998D	BE 98 02            SJP	    SUB_9802                    ; Resets last pressed key register and repeat speed.

BRANCH_9990: ; Branched to from 999F
9990	EF 7B 0E 08         ADI	    (7B0E),08                   ; (7B0E) = (7B0E) + 08. Character to blink. Whay add 8? Alters C
9994	BE 91 1E            SJP	    SUB_911E                    ; Exit if Carry clear, else wait until PC-1500 IF_REG IRQ and 
                                                                ;  PB7 (Power Button) are clear before exit
9997	BE 97 BA            SJP	    SUB_97BA                    ; Changes last pressed key code and repeat speed?
999A	93 0C               BCS-    BRANCH_9990                 ;  Carry and UL = Last Pressed Key returend from above
999C	BE 8F ED            SJP	    SUB_8FED                    ; Seems to set LCD annuncitors, maybe for Terminal mode?
999F	9B 14               BZS-    SUB_998D                    ;
99A1	24                  LDA	    UL                          ; Where did UL come from?
99A2	BE E3 66            SJP	    E366                        ; Part of Auto Power Off routine, does it use A?
99A5	E9 76 4E 7D         ANI	    (HIGHLCDFLAG),7D            ; Clear bits 1 & 7. Bit 1 = (Shift)
99A9	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; SUB_9AE6 - Called from SUB_PRINT#_ALT_E1:9245
; Alt entry 99AA Called from SUB_PRINT#_ALT_X1:9111
; Arguments: 
; Output: 
; RegMod: A, Y
SUB_99E6_ALT_E1: ; Branched to from 9A46
99AA	FD E9 D0 0B FE      ANI	    #(CE158_IF_REG),FE          ; Clear Bit 0. CE-158 - IRQ input.
99AF	FD E9 B0 0B FE      ANI	    #(CE150_IF_REG),FE          ; Clear Bit 0. CE-150 - IRQ input. 
99B4	A5 78 B3            LDA	    (78B3)                      ; ERROR ADDRESS (L)
99B7	1A                  STA	    YL                          ;
99B8	58 7B               LDI	    YH,7B                       ; Y = 7B##
99BA	FD BE               RIE                                 ; Disable interrupts
99BC	BE 81 E6            SJP	    IOCFG                       ; Manipulates LPT/UART registers
99BF	FD 81               SIE                                 ; Enable interrupts
99C1	81 91               BCR+    BRANCH_9A54                 ; Carry set in IOCFG
99C3	BF 40               BII	    A,40                        ; 
99C5	8B B5               BZS+    BRANCH_9A7C                 ; If Bit 6 set branch to RTN
99C7	B5 3F               LDI	    A,3F                        ; 

BRANCH_99C9: ; Branched to from 9A58, 9A5C, 9A62, 9A68, 9A6C, 9A8A, 9A97
99C9	5E D8               CPI	    YL,D8                       ; YL = ERROR ADDRESS (L)
99CB	83 33               BCS+    BRANCH_9A00                 ; If Y >= D8
99CD	51                  SIN	    (Y)                         ; (Y) = A then INC Y
99CE	EF 78 B3 01         ADI	    (78B3),01                   ; (78B3) = (78B3) + 1. ERROR ADDRESS (L)
99D2	5E D3               CPI	    YL,D3                       ; 
99D4	89 2A               BZR+    BRANCH_9A00                 ; If YL != D3

SUB_99D6: ; Called from 9B95
99D6	ED 78 B0 80         BII	    (78B0),80                   ; BREAK TOP (H)
99DA	8B 24               BZS+    BRANCH_9A00                 ; If Bit 7 was not set
99DC	ED 78 B4 02         BII	    (ERRORLINE),02              ;
99E0	8B 1E               BZS+    BRANCH_9A00                 ; If Bit 1 was not set
99E2	B5 13               LDI	    A,13                        ; 
99E4	8E 14               BCH+    BRANCH_99FA                 ; Unconditional fwd branch

SUB_99E6: ; Called from SUB_PRINT#_ALT_E1:9245
99E6	ED 76 4E 01         BII	    (HIGHLCDFLAG),01            ; 1 (Shift)
99EA	89 14               BZR+    BRANCH_9A00                 ; If Bit 0 was set

SUB_99EC: ; Called from 969F
99EC	ED 78 B4 02         BII	    (ERRORLINE),02              ;
99F0	8B 0E               BZS+    BRANCH_9A00                 ; If Bit 1 was not set
99F2	ED 78 B0 80         BII	    (78B0),80                   ; BREAK TOP (H)
99F6	89 08               BZR+    BRANCH_9A00                 ; If Bit 7 was set
99F8	B5 11               LDI	    A,11                        ;

BRANCH_99FA: ; Branched to from 99E4
99FA	FD A8               PSH	    U                           ; Save U
99FC	68 1F               LD	    UH,1F                       ;
99FE	8E 05               BCH+    BRANCH_9A05                 ; Unconditional branch fwd

BRANCH_9A00: ; Branched to from 99EA, 99F), 99F6
9A00	9A                  RTN                                 ;

9A01	FD A8               PSH	    U                           ; Save U
9A03	68 00               LDI     UH,00                       ;

BRANCH_9A05: ; Branched to from 99FE
9A05	2A                  STA	    UL                          ; 
9A06	ED 78 B4 02         BII	    (ERRORLINE),02              ;
9A0A	8B 06               BZS+    BRANCH_9A12                 ; If Bit 1 was not set
9A0C	ED 78 B0 40         BII	    (78B0),40                   ; BREAK TOP (H)
9A10	89 1D               BZR+    BRANCH_9A2F                 ; If Bit 6 was set

BRANCH_9A12: ; Branched to from 9A0A, 9A2D
9A12	24                  LDA	    UL                          ; 
9A13	BE 81 BC            SJP	    CHAR2COM                    ; Sends charecter to RS232 Port
9A16	81 1A               BCR+    BRANCH_9A32                 ; Carry returned from sub
9A18	BF 20               BII	    A,20                        ;
9A1A	89 2F               BZR+    BRANCH_9A4B                 ; If Bit 5 was set
9A1C	6C 00               CPI	    UH,00                       ;
9A1E	8B 0F               BZS+    BRANCH_9A2F                 ; If UH = 00
9A20	BF 1C               BII	    A,1C                        ;
9A22	8B 04               BZS+    BRANCH_9A28                 ; If any Bits 2,3,4 not set
9A24	FD 62               DEC	    UH                          ; UH = UH - 1
9A26	81 07               BCR+    BRANCH_9A2F                 ; If UH >= 0

BRANCH_9A28: ; Branched to from 9A22
9A28	FD ED F0 0B 02      BII     #(PC1500_IF_REG),02         ; PB7 interrupt flag, Power Button
9A2D	9B 1D               BZS-    BRANCH_9A12                 ; If Bit 1 was not set

BRANCH_9A2F: ; Branched to from 9A10, 9A1E, 9A26
9A2F	FD 2A               POP     U                           ;
9A31	9A                  RTN                                 ;

BRANCH_9A32: ; Branched to from 9A16
9A32	24                  LDA	    UL                          ; 
9A33	FD 2A               POP     U                           ;
9A35	B7 13               CPI	    A,13                        ;
9A37	89 05               BZR+    BRANCH_9A3E                 ; If A != 13
9A39	E9 78 B0 7F         ANI	    (78B0),7F                   ; BREAK TOP (H)
9A3D	9A                  RTN                                 ;

BRANCH_9A3E: ; Branched to from 9A37
9A3E	B7 11               CPI	    A,11                        ;
9A40	89 06               BZR+    BRANCH_9A48                 ; If A != 11
9A42	EB 78 B0 80         ORI	    (78B0),80                   ; BREAK TOP (H)
9A46	9E 9E               BCH-    SUB_99E6_ALT_E1             ; Unconditional back branch

BRANCH_9A48: ; Branched to from 9A40
9A48	B5 00               LDI	    A,00                        ;
9A4A	9A                  RTN                                 ;

BRANCH_9A4B: ; Branched to from 9A1A
9A4B	EF 78 50 80         ADI	    (OUTSTAT_REG),80            ; (OUTSTAT_REG) = (OUTSTAT_REG) + 80
9A4F	91 3F               BCR-    BRANCH_9A12                 ; If (OUTSTAT_REG) was < 7F
9A51	BA 8C FD            JMP	    JMP_8CFD                    ; Resets CE-150, LCD annuncuiators, jumps to new code

BRANCH_9A54: ; Branched to from 99C1
9A54	B7 20               CPI	    A,20                        ;
9A56	81 16               BCR+    BRANCH_9A6E                 ; If A < 20
9A58	9B 91               BZS-    BRANCH_99C9                 ; If A = 20
9A5A	B7 7F               CPI	    A,7F                        ;
9A5C	9B 95               BZS-    BRANCH_99C9                 ; If A = 7F
9A5E	ED 78 B0 08         BII	    (78B0),08                   ; BREAK TOP (H)
9A62	9B 9B               BZS-    BRANCH_99C9                 ; If Bit 3 was not set
9A64	ED 78 B0 10         BII	    (78B0),10                   ; BREAK TOP (H)
9A68	9B A1               BZS-    BRANCH_99C9                 ; If Bit 4 was not set
9A6A	BB 80               ORI	    A,80                        ; Set bit 7
9A6C	9E A5               BCH-    BRANCH_99C9                 ; Unconditional back branch

BRANCH_9A6E: ; Branched to from 9A56
9A6E	B7 13               CPI	    A,13                        ;
9A70	89 0B               BZR+    BRANCH_9A7D                 ; If A != 13
9A72	ED 78 B4 02         BII	    (ERRORLINE),02              ;
9A76	8B 09               BZS+    BRANCH_9A81                 ; If Bit 1 was not set
9A78	EB 78 B0 40         ORI	    (78B0),40                   ; Set Bit 6. BREAK TOP (H)

BRANCH_9A7C: ; Branched to from 99C5
9A7C	9A                  RTN                                 ;

BRANCH_9A7D: ; Branched to from 9A70
9A7D	B7 11               CPI	    A,11                        ;
9A7F	89 05               BZR+    BRANCH_9A86                 ; If A != 11

BRANCH_9A81: ; Branched to from 9A86
9A81	E9 78 B0 BF         ANI	    (78B0),BF                   ; Clear bit 6. BREAK TOP (H)
9A85	9A                  RTN                                 ;

BRANCH_9A86: ; Branched to from 9A7F
9A86	ED 78 B0 08         BII	    (78B0),08                   ; BREAK TOP (H)
9A8A	9B C3               BZS-    BRANCH_99C9                 ; If Bit 7 was not set
9A8C	B7 0E               CPI	    A,0E                        ;
9A8E	89 05               BZR+    BRANCH_9A95                 ; If A != 0E
9A90	EB 78 B0 10         ORI	    (78B0),10                   ; Set Bit 4. BREAK TOP (H)
9A94	9A                  RTN                                 ;

BRANCH_9A95: ; Branched to from 9A8E
9A95	B7 0F               CPI	    A,0F                        ;
9A97	99 D0               BZR-    BRANCH_99C9                 ; If A != 0F
9A99	E9 78 B0 EF         ANI	    (78B0),EF                   ; Clear Bit 4. BREAK TOP (H)
9A9D	9A                  RTN                                 ;
;------------------------------------------------------------------------------------------------------------



;------------------------------------------------------------------------------------------------------------
; SUB_9A9E - Called from 9318, alt entry at 9B2C
; Arguments A >=20 or A = 20 or A = 0D or A = 0A
; X index to unknown table, no idea what X is
; Arguments: A
; Output: 
; RegMod: U, X
SUB_9A9E:
9A9E	68 00               LDI	    UH,00                       ;
9AA0	2A                  STA	    UL                          ; 
9AA1	B7 20               CPI	    A,20                        ; 20 = Space
9AA3	81 5B               BCR+    BRANCH_9B00                 ; If A < 20, non-printable ASCII
9AA5	8B 21               BZS+    BRANCH_9AC8                 ; If A = 20. 20 = Space
9AA7	B7 80               CPI	    A,80                        ;  
9AA9	81 21               BCR+    BRANCH_9ACC                 ; If A < 80 . Printable ASCII
9AAB	B5 04               LDI	    A,04                        ;
9AAD	ED 78 BE FF         BII	    (78BE),FF                   ; Set Flags w/o changing reg. DATA POINTER (H)
9AB1	89 09               BZR+    BRANCH_9ABC                 ; If (78BE) was not zero
9AB3	6E A1               CPI	    UL,A1                       ; 
9AB5	81 0F               BCR+    BRANCH_9AC6                 ; If A < A1
9AB7	6E E0               CPI	    UL,E0                       ;
9AB9	83 0B               BCS+    BRANCH_9AC6                 ; If A >= E0

BRANCH_9ABB: ; Branched to from 9B0A                            ; A >= A1 & < E0
9ABB	DD                  INC	    A                           ; A = A + 1

BRANCH_9ABC: ; Branched to from 9AB1, 9ACA, 9AF6, 9AFE, 9B02, 9B08
9ABC	FD 0A               POP	    X                           ; Where was X pushed to stack?
9ABE	FD CA               ADR	    X                           ; X = X + A
9AC0	45                  LIN     X                           ; A = (X) then INC X
9AC1	FD CA               ADR	    X                           ; X = X + A
9AC3	24                  LDA	    UL                          ; What table is this using?
9AC4	FD 5E               STX     P                           ; Save X to Program Counter ***JUMP


BRANCH_9AC6: ; Branched to from 9AB5, 9AB9                      ; If A < A1 | A >= E0
9AC6	6A 20               LDI	    UL,20                       ;

BRANCH_9AC8: ; Branched to from 9AA5                            ; If A = 20
9AC8	B5 07               LDI	    A,07                        ;
9ACA	9E 10               BCH-    BRANCH_9ABC                 ; Unconditional back branch

BRANCH_9ACC: ; Branched to from 9AA9                            ; If A < 80
9ACC	A5 78 B5            LDA	    (78B5)                      ; ERROR LINE (L)
9ACF	B7 C0               CPI	    A,C0                        ;
9AD1	24                  LDA	    UL                          ;
9AD2	83 28               BCS+    BRANCH_9AFC                 ; If A >= C0 
9AD4	B1 5A               SBI	    A,5A                        ; A = A - 5A 
9AD6	81 20               BCR+    BRANCH_9AF8                 ; If A was >= 5A
9AD8	B7 06               CPI	    A,06                        ;
9ADA	83 03               BCS+    BRANCH_9ADF                 ; If A >= 06
9ADC	DD                  INC	    A                           ;
9ADD	8E 14               BCH+    BRANCH_9AF3                 ; Unconditional branch fwd

BRANCH_9ADF: ; Branched to from 9ADA
9ADF	ED 78 B5 80         BII	    (78B5),80                   ;
9AE3	8B 17               BZS+    BRANCH_9AFC                 ; If Bit 7 was not set
9AE5	B1 20               SBI	    A,20                        ; A = A - 20
9AE7	81 13               BCR+    BRANCH_9AFC                 ; If A >= 20
9AE9	B3 06               ADI	    A,06                        ; A = A + 06
9AEB	B7 0A               CPI	    A,0A                        ;
9AED	8B 0D               BZS+    BRANCH_9AFC                 ; If A = 0A
9AEF	81 02               BCR+    BRANCH_9AF3                 ; If A < 0A
9AF1	B5 0A               LDI	    A,0A                        ;

BRANCH_9AF3: ; Branched to from 9AD0, 9AEF, 9AFA
9AF3	28                  STA	    UH                          ;
9AF4	B5 06               LDI	    A,06                        ;
9AF6	9E 3C               BCH-    BRANCH_9ABC                 ; Unconditional branch

BRANCH_9AF8: ; Branched to from 9AD6
9AF8	B1 CB               SBI	    A,CB                        ; A = A - CB
9AFA	9B 09               BZS-    BRANCH_9AF3                 ; If A was = CB

BRANCH_9AFC: ; Branched to from 9AD2, 9AE3, 9AE7, 9AED
9AFC	B5 03               LDI	    A,03                        ;
9AFE	9E 44               BCH-    BRANCH_9ABC                 ; Unconditional branch

BRANCH_9B00: ; Branched to from 9AA3                            ; A < 20, non-printable ASCII
9B00	B1 0C               SBI	    A,0C                        ; A = A - 0C
9B02	9B 48               BZS-    BRANCH_9ABC                 ; If A was = 0C
9B04	B5 01               LDI	    A,01                        ;
9B06	6E 0C               CPI	    UL,0C                       ;
9B08	9B 4E               BZS-    BRANCH_9ABC                 ; If UL = 0C
9B0A	9E 51               BCH-    BRANCH_9ABB                 ; Unconditional branch

;-----
; not reached
9B0C	FD 98               PSH	    Y                   ;
9B0E	A4                  LDA	    UH                  ;
9B0F	D9                  SHL                         ;
9B10	48 84               LDI	    XH,84               ;
9B12	4A 98               LDI	    XL,98               ;
9B14	FD CA               ADR	    X                   ;
9B16	5A 00               LDI     YL,00               ;
9B18	58 7A               LDI	    YH,7A               ;
9B1A	B5 7A               LDI	    A,7A                ; 
9B1C	51                  SIN     Y                   ; Save Accumulator to register Y, then INC register Y
9B1D	B5 02               LDI	    A,02                ;
9B1F	51                  SIN     Y                   ; Save Accumulator to register Y, then INC register Y
9B20	B5 7A               LDI	    A,7A                ;
9B22	51                  SIN     Y                   ; Save Accumulator to register Y, then INC register Y
9B23	B5 04               LDI	    A,04                ;
9B25	51                  SIN     Y                   ; Save Accumulator to register Y, then INC register Y
9B26	45                  LIN     X                   ; Load Accumulator with value pointed to by X register and then increment X by one
9B27	2A                  STA	    UL                  ;
9B28	45                  LIN     X                   ; Load Accumulator with value pointed to by X register and then increment X by one
9B29	0A                  STA	    XL                  ;
9B2A	8E 13               BCH+    BRANCH_9B3F         ; Unconditional branch fwd
; Not reached
;------------



;------------------------------------------------------------------------------------------------------------
; SUB_9A9E_ALT1 - Called from 9323,  9C0A
; Copies something from TBL_8475 into system RAM
; Arguments: UH is offset into table
; Arguments: 
; Output: 
; RegMod: A, X, Y, UL
SUB_9B2C:
9B2C	A4                  LDA	    UH                          ; A = UH, what is UH here?
9B2D	4A 75               LDI	    XL,75                       ;
9B2F	48 84               LDI	    XH,84                       ; X = 8475, TBL_8475
9B31	FD CA               ADR	    X                           ; X = X + A
9B33	D9                  SHL                                 ; A = A * 2.
9B34	D9                  SHL                                 ; A = A * 4. 
9B35	6A 04               LDI	    UL,04                       ; # of bytes to copy, total of 5 bytes
9B37	FD CA               ADR	    X                           ; X = X + 5 * A. Offset into table, groups of 5 bytes?
9B39	FD 98               PSH     Y                           ; Save Y
9B3B	5A 00               LDI     YL,00                       ;
9B3D	58 7A               LDI	    YH,7A                       ; Y = 7A00, Math_Register_Xa_B1

BRANCH_9B3F: ; Branched to from 9B2A, 9B40
9B3F	F5                  TIN                                 ; (Y) = (X) then X = X + 1, Y = Y + 1
9B40	88 03               LOP	    UL,BRANCH_9B3F              ; UL = UL - 1, loop back 'e' if Borrow Flag not set
9B42	FD 18               LDX	    Y                           ; X = Y
9B44	FD 1A               POP	    Y                           ; Get original Y back
9B46	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; SUB_9B47 Entry at 9B47 Called from 9BA7, 9BB8, 9C01
; May return or poke new address into Stack Pointer
; Arguments: 
; Output: 
; RegMod: A
SUB_9B47:
9B47	FD A8               PSH	    U                           ; Save U
9B49	B5 FF               LDI	    A,FF                        ;
9B4B	A7 7B 0F            CPA	    (7B0F)                      ; Last pressed key code
9B4E	8B 04               BZS+    BRANCH_9B54                 ; If (7B0F) = FF
9B50	E9 7B 0F 00         ANI	    (7B0F),00                   ; Clear it. Last pressed key code

BRANCH_9B54: ; Branched to from 9B4E
9B54	AE 7B 08            STA	    (7B08)                      ; (7B0B) = A = FF
9B57	FD 98               PSH	    Y                           ; Save Y before calling sub
9B59	BE 97 BA            SJP     SUB_97BA                    ; UL = 0E or byte read from LCD charecter matrix based on what is read from IN0-IN7?
9B5C	FD 1A               POP	    Y                           ; Get the Y back
9B5E	83 0F               BCS+    BRANCH_9B6F                 ; Changes last pressed key code and repeat speed?
9B60	BE 98 02            SJP     SUB_9802                    ; Resets last key register and repeat speed? Does not alter UL
9B63	24                  LDA	    UL                          ; 
9B64	CD 34 03            VMJ	    (34),03,                    ; Checks UL for presets in table, branch fwd if match
           09 09                      09,BRANCH_9B72,           ; Horiz Tab?
           0E 0C                      0E,BRANCH_9B77,           ; Shift Out / X-On?
           11 0F                      11,BRANCH_9B7C,           ; DC1 / XON?
           13 0E                      13,BRANCH_9B7D            ; DC3 / XOFF?

BRANCH_9B6F: ; Branched to from 9B5E, 9B75,9B85,9B1E
9B6F	FD 2A               POP     U                           ; Charecter did not match above?
9B71	9A                  RTN                                 ;

BRANCH_9B72: ; Branched to from 9B64
9B72	BE 9E 20            SJP     SUB_9E20                    ; Handles 09 Horiz Tab?
9B75	9E 08               BCH-    BRANCH_9B6F                 ; Unconditional branch back

BRANCH_9B77: ; Branched to from 9B64
9B77	FD 2A               POP     U                           ; Where was U pushed? Handles Shift Out / X-On?
9B79	BA 8D 04            JMP	    SUB_8D04                    ; No idea what this does

BRANCH_9B7C: ; Branched to from 9B64
9B7C	F9                  REC                                 ; Handles DC1 / XON, Reset Carry Flag - do nothing

BRANCH_9B7D: ; Branched to from 9B64
9B7D	04                  LDA	    XL                          ; Handles DC3 / XOFF?
9B7E	FB                  SEC                                 ; Set Carry Flag
9B7F	B1 7C               SBI	    A,7C                        ; A = A - 7C
9B81	AD 76 4E            EOR	    (HIGHLCDFLAG)               ; A = A ^ (HIGHLCDFLAG)
9B84	D5                  SHR                                 ; A = A >> 1. Thru carry. 0 into MSB
9B85	93 18               BCS-    BRANCH_9B6F                 ; If Bit 1 was set
9B87	ED 76 4E 10         BII	    (HIGHLCDFLAG),10            ;
9B8B	9B 1E               BZS-    BRANCH_9B6F                 ; If Bit 4 was not set
9B8D	FD 2A               POP     U                           ;
9B8F	FD 0A               POP	    X                           ;
9B91	44                  INC	    X                           ;
9B92	44                  INC	    X                           ; INC X twice to walk to next vector?
9B93	FD 5E               STX     P                           ; Save X to Program Counter ***JMP



;------------------------------------------------------------------------------------------------------------
; Called from 96B1, 96DE. 
; Alt entries at 9BD0
; Looks at BUAD setting and lh5811 timer control Bit 5. Why?
; Arguments: 
; Output: 
; RegMod: A, A, U, Y
SUB_9B95:  
9B95	BE 99 D6            SJP     SUB_99D6                    ; 
9B98	A5 78 58            LDA	    (SETCOM_REG)                ;
9B9B	B9 E0               ANI	    A,E0                        ; Keep bits 7-5, BAUD
9B9D	F1                  AEX                                 ; Swap nibbles in A, Bits 7-5 now Bits 3-1
9B9E	D5                  SHR                                 ; A = A >> 1. Bits 7-5 now Bits 2-0
9B9F	4A 96               LDI	    XL,96                       ;
9BA1	48 86               LDI	    XH,86                       ; X = 8696, in UNKNOWN_TBL_8669
9BA3	FD CA               ADR	    XH                          ; X = X + A
9BA5	05                  LDA	    (X)                         ; A = (X). Range 8696-869D
9BA6	2A                  STA	    UL                          ;

BRANCH_9BA7:  ; Branched to from 9BC6
9BA7	BE 9B 47            SJP     SUB_9B47                    ; May return or poke address in SP
9BAA	8E 02               BCH+    BRANCH_9BAE                 ; Unconditional branch fwd


9BAC	FB                  SEC                                 ; Not reached?
9BAD	9A                  RTN                                 ;


BRANCH_9BAE: ; Branched to from 9BAA
9BAE	FD ED F0 0F 20      BII	    #(PC1500_PRT_B),20          ; Port B, Pin 5 - Timer control
9BB3	9B 0E               BZS-    BRANCH_9BA7                 ; If Bit 5 was not set

BRANCH_9BB5: ; Branched to from 9BCE
9BB5	62                  DEC	    UL                          ;
9BB6	81 06               BCR+    BRANCH_9BBE                 ; If UL was zero exit

BRANCH_9BB8: ; Branched to from 9BC4
9BB8	BE 9B 47            SJP     SUB_9B47                    ;
9BBB	8E 02               BCH+    BRANCH_9BBF                 ; Unconditional branch fwd

9BBD	FB                  SEC                                 ; Not reached?

BRANCH_9BBE: ; Branched to from 9BD8
9BBE	9A                  RTN                                 ;

BRANCH_9BBF: ; Branched to from 9BBB
9BBF	FD ED F0 0F 20      BII	    #(PC1500_PRT_B),20          ; Port B, Pin 5 - Timer control
9BC4	99 0E               BZR-    BRANCH_9BB8                 ; If Bit 5 was set
9BC6	88 21               LOP	    UL,BRANCH_9BA7              ; UL = UL - 1, loop back 'e' if Borrow Flag not set
9BC8	F9                  REC                                 ;
9BC9	9A                  RTN                                 ;


9BCA	A5 78 B9            LDA	    (ON_ERR_ADD_H)              ; Not reached?
9BCD	2A                  STA	    UL                          ;
9BCE	9E 1B               BCH-    BRANCH_9BB5                 ;

SUB_9B95_ALT_E1: ; Called from 9675
9BD0	FD C1               SDP                                 ; Sets LCD ON/OFF control flip-flop
9BD2	ED 78 A8 80         BII	    (78A8),80                   ; SEARCH LINE (H)
9BD6	99 1A               BZR-    BRANCH_9BBE                 ; If Bit 7 was not set
9BD8	BE DF E2            SJP	    SUB85                       ;
9BDB	81 29               BCR+    BRANCH_9C06                 ; SUB returns Carry

9BDD	FD 5A               STX     Y                           ; Y = X. What is X here?

BRANCH_9BDF: ; Branched to from 9C08
9BDF	FD A8               PSH	    U                           ;
9BE1	15                  LDA	    (Y)                         ; A = (Y). What is Y here?
9BE2	BE 9C 0A            SJP	    SUB_9C0A                    ; Not sure what this does
9BE5	8E 03               BCH+    BRANCH_9BEA                 ; SUB returns Carry
9BE7	FD 2A               POP	    U                           ;
9BE9	9A                  RTN                                 ;

BRANCH_9BEA: ; Branched to from 9BE5
9BEA	FD 2A               POP	    U                           ;
9BEC	62                  DEC	    UL                          ;
9BED	83 04               BCS+    BRANCH_9BF3                 ; If DEC caused carry
9BEF	FD 62               DEC	    UH                          ;
9BF1	81 13               BCR+    BRANCH_9C06                 ; If DEC did not cause carry exit

BRANCH_9BF3: ; Branched to from 9BED
9BF3	A5 78 B5            LDA     (78B5)                      ; ERROR LINE (L)
9BF6	D9                  SHL                                 ; A = A << 1. Thru carry. 0 into LSB
9BF7	81 0E               BCR+    BRANCH_9C07                 ; If Bit 7 was not set
9BF9	D9                  SHL                                 ; A = A << 1. Thru carry. 0 into LSB
9BFA	81 05               BCR+    BRANCH_9C01                 ; If Bit 6 was not set
9BFC	15                  LDA	    (Y)                         ; A = (Y), What is Y here?
9BFD	B7 0D               CPI	    A,0D                        ;
9BFF	89 06               BZR+    BRANCH_9C07                 ; If A != 0D. 0D = CR

BRANCH_9C01: ; Branched to from 9BFA, 
9C01	BE 9B 47            SJP	    SUB_9B47                    ; May return or poke new address into Stack Pointer
9C04	8E 01               BCH+    BRANCH_9C07                 ; Unconditional fwd branch

BRANCH_9C06: ; Branched to from 9BDB, 9BF1
9C06	9A                  RTN                                 ; Exit

BRANCH_9C07: ; Branched to from 9BF7, 9BFF, 9C04
9C07	54                  INC	    Y                           ;
9C08	9E 2B               BCH-    BRANCH_9BDF                 ; Unconditional back branch



;------------------------------------------------------------------------------------------------------------
; SUB_(C0A - Called from 9BE2
; Reads something from TBL_8475 and may change program counter
; Arguments: 
; Output: 
; RegMod: X, A
SUB_9C0A:
9C0A	BE 9A 9E            SJP     SUB_9A9E            ; Copies something from TBL_8475 into system RAM
9C0D	0E                  STA	    (X)                 ; (X) = A
9C0E	0C                  DCS	    (X)                 ; A = A - (X). BCD subtraction
9C0F	0A                  STA	    XL                  ; XL = A
9C10	08                  STA	    XH                  ; XH = A
9C11	06                  CPA	    XL                  ; 
9C12	04                  LDA	    XL                  ; Seems like a lot of nonsense
9C13	02                  ADC	    XL                  ;
9C14	00                  SBC	    XL                  ;
9C15	F9                  REC                         ; Reset Carry Flag
9C16	F9                  REC                         ; Reset Carry Flag
9C17	F9                  REC                         ; Reset Carry Flag
9C18	F9                  REC                         ; Reset Carry Flag
9C19	F9                  REC                         ; Reset Carry Flag
9C1A	F9                  REC                         ; Reset Carry Flag
9C1B	F9                  REC                         ; Reset Carry Flag
9C1C	B5 21               LDI	    A,21                ;
9C1E	ED 78 B5 80         BII	    (78B5),80           ; ERROR LINE (L)
9C22	8B 0A               BZS+    BRANCH_9C2E         ; If Bit 7 was not set
9C24	B5 29               LDI	    A,29                ;
9C26	ED 78 B5 40         BII	    (78B5),40           ; ERROR LINE (L)
9C2A	8B 02               BZS+    BRANCH_9C2E         ; If Bit 6 was not set
9C2C	B5 31               LDI	    A,31                ;

BRANCH_9C2E: ; Branched to from 9C22, 92CA
9C2E	FD CA               ADR	    X                   ; X = X + A. A = 21 or 29 or 31
9C30	45                  LIN	    (X)                 ; A = (X) then INC X
9C31	FD CA               ADR	    X                   ; X = X + A.
9C33	24                  LDA	    UL                  ; A = UL
9C34	FD 5E               STX     P                   ; Save X to Program Counter, ***Jump


;--------------
; Nonsense here down
9C36	29                  AND	    (U)                 ;
9C37	16                  CPA	    YL                  ;
9C38	27                  CPA	    (U)                 ;
9C39	33                  ADC	    (V)                 ;
9C3A	25                  LDA	    (U)                 ;
9C3B	38                  NOP                         ;
9C3C	37                  CPA	    (V)                 ;
9C3D	20                  SBC	    UL                  ;
9C3E	55                  LIN	    (Y)                 ; A = (Y) then INC Y
9C3F	42                  DEC	    XL                  ;
9C40	53                  SDE	    (Y)                 ; (Y) = A. Y = Y - 1
9C41	AB 51 A9            ORA	    (51A9)              ;
9C44	39                  AND	    (V)                 ;
9C45	4C B3               CPI	    XH,B3               ;
9C47	B2                  ADC	    VH                  ; A = A + VH
9C48	B1 B0               SBI	    A,B0                ;
9C4A	AF A1 A1            BIT	    (A1A1)              ; 
9C4D	A4                  LDA	    UH                  ;
; Nonsense here up
;------------------


9C4E	B5 7A               LDI	    A,7A                ;
9C50	AE 78 5E            STA	    (785E)              ; Keyboard address or user chars address high byte (if 785D = 0)
9C53	E9 78 5D 00         AND	    (785D),00           ; Reset to 0. KEYBOARD derivation flag Bit7=1 SPV, Bit7=0 RPV
9C57	BE 9B 2C            SJP     SUB_9A9E_ALT1       ;
9C5A	B5 80               LDI	    A,80                ;
9C5C	8E 0A               BCH+    BRANCH_9C68         ; Unconditional branch fwd
9C5E	B5 20               LDI	    A,20                ;
9C60	FD C8               PSH	    A                   ;
9C62	CC BE               VEJ	    (CC),(BE)           ; 
9C64	CA 5D               VEJ	    (CA),(5D)           ; Transfers X-Reg in Memory. 5D sets low byte in 78xx
9C66	FD 8A               POP	    A                   ; 

BRANCH_9C68: ; Branched to from 9C5C
9C68	BE ED 4D            SJP     CURMOVONECHAR       ;
9C6B	8E 77               BCH+    BRANCH_9CE4         ; Unconditional branch fwd
9C6D	BE ED EF            SJP     GRAPHDISP           ;
9C70	EF 78 75 01         ADI	    (7875),01           ; CURSOR POINTER (0 to 155)
9C74	9A                  RTN                         ; Exit



;------------------------------------------------------------------------------------------------------------
; SUB_9C92 - Called from SUB_8D04:8E47
; CE-150 - Checks / clears low battery flag
; Arguments: 
; Output: 
; RegMod: U, A
SUB_9C92:
9C92	6A 00               LDI	    UL,00                       ;
9C94	A5 79 F1            LDA	    (BATT/PEN_FLAG)             ;
9C97	89 50               BZR+    BRANCH_9CE9                 ; If (BATT/PEN_FLAG) not zero
9C99	ED 78 56 60         BII	    (ZONE_REG),60               ;
9C9D	8B 4E               BZS+    BRANCH_9CED                 ; If Bits 5 or 6 not set
9C9F	24                  LDA	    UL                          ; A = UL = 00

BRANCH_9CA0: ; Branched to from 9CE2
9CA0	E9 78 B8 00         ANI	    (78B8),00                   ; Clear register. ON ERROR ADDRESS (H)
9CA4	28                  STA	    UH                          ;
9CA5	A4                  LDA	    UH                          ; Why store than load? To set Z flag?
9CA6	8B 0D               BZS+    BRANCH_9CB5                 ; If A/UH = 00 branch fwd
9CA8	A5 79 E6            LDA	    (79E6)                      ; CE-150 Printer - ABSOLUTE POSITION X
9CAB	B7 D8               CPI	    A,D8                        ;
9CAD	81 06               BCR+    BRANCH_9CB5                 ; If A < D8 branch fwd
9CAF	A4                  LDA	    UH                          ;
9CB0	AE 78 B8            STA	    (78B8)                      ; ON ERROR ADDRESS (H)
9CB3	68 00               LDI     UH,00                       ;

BRANCH_9CB5: ; Branched to from 9CA6, 9CAD
9CB5	FD BE               RIE                                 ; Disable Interrupts
9CB7	FD E9 B0 0D BF      ANI	    #(CE150_PRT_B_DIR),BF       ; Bit 6 read, others write. Low Battery
9CBC	FD A5 B0 0F         LDA     #(CE150_PRT_B)              ; Port B Input/ Output
9CC0	FD A9 B0 0F         AND	    #(CE150_PRT_B)              ; Filter out changes
9CC4	FD A9 B0 0F         AND	    #(CE150_PRT_B)              ; Filter out changes
9CC8	BF 40               BII	    A,40                        ;
9CCA	38                  NOP                                 ;
9CCB	38                  NOP                                 ;
9CCC	FD E9 B0 0F BF      ANI	    #(CE150_PRT_B),BF           ; Clear Bit 6. Low battery
9CD1	FD EB B0 0D 40      ORI	    #(CE150_PRT_B_DIR),40       ; Set Bit 6. Set Bit 6 to write
9CD6	FD 98               PSH	    Y                           ;
9CD8	BE 9E 66            SJP	    SUB_9E66                    ; Seems to copy from ROM into System RAM and then call it
9CDB	FD 81               SIE                                 ; Enable interrupts
9CDD	FD 1A               POP	    Y                           ;
9CDF	A5 78 B8            LDA	    (78B8)                      ; ON ERROR ADDRESS (H)
9CE2	99 44               BZR-    BRANCH_9CA0                 ; If (78B8) != 0

BRANCH_9CE4: ; Branched to from 9C6B
9CE4	CC BE               VEJ     (CC),(BE)                   ; Loads X-Reg with address at 78(BE) 78(BF). DATA POINTER (H)
9CE6	CA 5D               VEJ	    (CA),(5D)                   ; Transfers X to 78(5D), 78(5E). Keyboard derivation
9CE8	9A                  RTN                                 ;

BRANCH_9CE9: ; Branched to from 9C97
9CE9	9A                  RTN                                 ;
9CEA	9A                  RTN                                 ;
9CEB	9A                  RTN                                 ;
9CEC	9A                  RTN                                 ;

BRANCH_9CED: ; Branched to from 9C9D
9CED	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; SUB_9D39 - Called from 9C62
; Alt entry 9D4B called from 9747, Alt Entry 9D2A called from 9793
; Seems to be involved in parsing
; Arguments: 
; Output: 
; RegMod: X, U, A
SUB_9D2A:
9D2A	04                  LDA	    XL                          ; 
9D2B	AE 78 AB            STA	    (78AB)                      ; SEARCH TOP (L)
9D2E	84                  LDA	    XH                          ;
9D2F	AE 78 AA            STA	    (78AA)                      ; SEARCH TOP (H)
9D32	E9 78 B1 00         ANI	    (78B1),00                   ; Zero out, BREAK TOP (L)
9D36	FB                  SEC                                 ; Set Carry Flag
9D37	8E 1E               BCH+    BRANCH_9D57                 ; Unconditional fwd branch

SUB_9D39:
9D39	E9 78 91 00         ANI	    (7891),00                   ; Clear GOSUB pointer
9D3D	EB 78 B1 01         ORI	    (78B1),01                   ; Set bit 0. BREAK TOP (L)
9D41	CC A0               VEJ	    (CC),(A0)                   ; Loads X-Reg with address at 78(A0) 78(A1). PREVIOUS ADDRESS
9D43	F4 78 A8            VEJ	    (F4),(78A8)                 ; Loads U-Reg with 16-bit value from address of (78A8) SEARCH LINE (H)
9D46	BE DF E2            SJP     SUB85                       ; U = U - X. When upper limit occurs: C=0 and UH=16 
9D49	CC A8               VEJ	    (CC),(A0)                   ; Loads X-Reg with address at 78(A0) 78(A1). PREVIOUS ADDRESS. 

SUB_9D4B: ; Called from 9747
9D4B	EB 78 B1 02         ORI	    (78B1),02                   ; Set Bit 1. BREAK TOP (L)
9D4F	04                  LDA	    XL                          ;
9D50	AE 78 AD            STA	    (78AD)                      ; BREAK ADDRESS (L)
9D53	84                  LDA	    XH                          ;
9D54	AE 78 AC            STA	    (78AC)                      ; BREAK ADDRESS (H)

BRANCH_9D57: ; Called from 9D37
9D57	E9 78 B5 7F         ANI	    (78B5),7F                   ; Clear Bit 7. ERROR LINE (L)
9D5B	B5 69               LDI	    A,69                        ;
9D5D	AE 78 BC            STA	    (78BC)                      ; ON ERROR TOP (H)
9D60	ED 78 A8 80         BII	    (78A8),80                   ; SEARCH LINE
9D64	89 4E               BZR+    BRANCH_9DB4                 ; If Bit 7 was set
9D66	58 FF               LDI	    YH,FF                       ;
9D68	81 6A               BCR+    BRANCH_9DD4                 ; Carry set if branched to from 9D36
9D6A	8E 10               BCH+    BRANCH_9D7C                 ; Unconditional fwd branch

BRANCH_9D6C: ; Branched to from 9D98, 9DEB
9D6C	62                  DEC	    UL                          ; UL = UL - 1
9D6D	83 04               BCS+    BRANCH_9D73                 ; If UL went past zero
9D6F	FD 62               DEC	    UH                          ;
9D71	81 61               BCR+    BRANCH_9DD4                 ; If UH did not go past zero

BRANCH_9D73: ; Branched to from 9D6D
9D73	44                  INC	    X                           ;
9D74	ED 78 B1 02         BII	    (78B1),02                   ; BREAK TOP (L)
9D78	8B 02               BZS+    BRANCH_9D7C                 ; If Bit 1 was not set
9D7A	46                  DEC	    X                           ;
9D7B	46                  DEC	    X                           ; X = X - 2

BRANCH_9D7C: ; Branched to from 9D6A, 9D78
9D7C	05                  LDA	    (X)                         ; A = (X)
9D7D	B7 80               CPI	    A,80                        ; 
9D7F	81 0B               BCR+    BRANCH_9D8C                 ; If A < 80
9D81	A5 78 BE            LDA	    (78BE)                      ; DATA POINTER (H)
9D84	8B 0E               BZS+    BRANCH_9D94                 ; If (78BE) was zero
9D86	EF 78 BC 01         ADI	    (78BC),01                   ; (78BC) = (78BC) + 1. ON ERROR TOP (H)
9D8A	8E 0C               BCH+    BRANCH_9D98                 ; Unconditional fwd branch

BRANCH_9D8C: ; Branched to from 9D7F
9D8C	B7 20               CPI	    A,20                        ; 
9D8E	81 59               BCR+    BRANCH_9DE9                 ; If A < 20
9D90	89 02               BZR+    BRANCH_9D94                 ; If A > 20
                                                                ; A = 20 drop through
BRANCH_9D92: ; Branched to from 9DF7
9D92	FD 5A               STX     Y                           ; Y = X

BRANCH_9D94: ; Branched to from 9D84, 9D90, 9DF1
9D94	EF 78 BC 06         ADI	    (78BC),06                   ; Keep Bits 1-2. ON ERROR TOP (H)

BRANCH_9D98: ; Branched to from 9D8A
9D98	91 2E               BCR-    BRANCH_9D6C                 ; Carry set in 9D8C or 9D7D
9D9A	A5 78 B1            LDA	    (78B1)                      ; BREAK TOP (L)
9D9D	89 3C               BZR+    BRANCH_9DDB                 ; If (78B1) > 0
9D9F	94                  LDA	    YH                          ;
9DA0	46                  DEC	    X                           ; X = X - 1
9DA1	DD                  INC	    A                           ; A = A + 1
9DA2	8B 0E               BZS+    BRANCH_9DB2                 ; If A = 0 (A was FF before INC)
9DA4	FD 18               LDX	    Y                           ; X = Y
9DA6	05                  LDA	    (X)                         ; A = (X)
9DA7	B7 0D               CPI	    A,0D                        ;
9DA9	89 07               BZR+    BRANCH_9DB2                 ; If A != 0D . 0D = CR
9DAB	44                  INC	    X                           ; X = X + 1
9DAC	05                  LDA	    (X)                         ; A = (X)
9DAD	B7 0D               CPI	    A,0D                        ;
9DAF	8B 01               BZS+    BRANCH_9DB2                 ; If A = 0D
9DB1	46                  DEC	    X                           ; X = X - 1

BRANCH_9DB2: ; Branched to from 9DA2, 9DA9, 9DAF, 9DD7, 9DFA
9DB2	CA AC               VEJ     (CA),(AC)                   ; Transfers X to 78(AC), 78(AD). BREAK ADDRESS (H)

BRANCH_9DB4: ; Branched to from 9D64, 9DE7
9DB4	A5 78 B4            LDA	    (ERRORLINE)                 ;
9DB7	AE 78 B4            STA	    (ERRORLINE)                 ; Setting Z flag
9DBA	F2                  VEJ     (F2)                        ; deletes LCD display
9DBB	AE 78 75            STA	    (7875)                      ; CURSOR POINTER (0 to 155)
9DBE	AE 78 7F            STA	    (787F)                      ; Blink cursor position (L)
9DC1	B5 74               LDI	    A,74                        ;
9DC3	AE 78 7E            STA	    (787E)                      ; Blink cursor position (H)
9DC6	ED 78 A8 80         BII	    (78A8),80                   ; SEARCH LINE
9DCA	99 DF               BZR-    BRANCH_9CED                 ; If Bit 7 was set
9DCC	CC AA               VEJ	    (CC),(A0)                   ; Loads X-Reg with address at 78(A0) 78(A1). PREVIOUS ADDRESS (H)
9DCE	F4 78 AC            VEJ	    (F4),(78AC)                 ; Loads U-Reg with 16-bit value from address of (78AC). BREAK ADDRESS (H)
9DD1	BA 9B D0            JMP	    SUB_9B95_ALT_E1             ; This must be the exit

BRANCH_9DD4: ; Branched to from 9D68, 9D71
9DD4	A5 78 B1            LDA	    (78B1)                      ; BREAK TOP (L)
9DD7	9B 27               BZS-    BRANCH_9DB2                 ; If (78B1) was zero
9DD9	8E 0A               BCH+    BRANCH_9DE5                 ; Unconditional fwd branch

BRANCH_9DDB: ; Branched to from 9D9D
9DDB	D5                  SHR                                 ; A = A >> 1. Thru carry. 0 into MSB
9DDC	83 06               BCS+    BRANCH_9DE4                 ; If Bit 0 was set
9DDE	94                  LDA	    YH                          ;
9DDF	DD                  INC	    A                           ; A = A + 1
9DE0	8B 02               BZS+    BRANCH_9DE4                 ; If A = 0 then A was FF before INC
9DE2	FD 18               LDX	    Y                           ; X = Y

BRANCH_9DE4: ; Branched to from 9DDC, 9DE0, 9DFC
9DE4	44                  INC	    X                           ; X = X + 1

BRANCH_9DE5: ; Branched to from 9DD9
9DE5	CA AA               VEJ     (CA),(AA)                   ; Transfers X to 78(AA), 78(AB). SEARCH TOP
9DE7	9E 35               BCH-    BRANCH_9DB4                 ; Unconditional back branch

BRANCH_9DE9: ; Branched to from 
9DE9	B7 0D               CPI	    A,0D                        ;
9DEB	99 81               BZR-    BRANCH_9D6C                 ; If A != 0D. 0D = CR
9DED	A5 78 B1            LDA	    (78B1)                      ; BREAK TOP (L)
9DF0	D5                  SHR                                 ; A = A >> 1.
9DF1	93 5F               BCS-    BRANCH_9D94                 ; If Bit 0 was set
9DF3	ED 7B 0F 02         BII	    (7B0F),02                   ; 
9DF7	9B 67               BZS-    BRANCH_9D92                 ; If Bit 3 (before SHR) was set
9DF9	D5                  SHR                                 ; A = A >> 1.
9DFA	91 4A               BCR-    BRANCH_9DB2                 ; If Bit 1 (before both SHR) was not set
9DFC	9E 1A               BCH-    BRANCH_9DE4                 ; Unconditional back branch



;------------------------------------------------------------------------------------------------------------
; SEPARATOR_9DFE - 00 FF fills unused space
SEPARATOR_9DFE:
9DFE	00 FF EC 24 00 FF 00 FF   00 FF 00 FF 00 FF 00 FF 
9E0E	00 FF 00 FF 00 FF 00 FF   00 FF 00 FF 00 FF 00 FF 
9E1E	00 FF 



;------------------------------------------------------------------------------------------------------------
; SUB_9E20 - Called from 9600, 9B72
; Sets LCD Annunciators (DEFI), (DEFII), (DEFIII) based on status of (Small) and (Katana)
; Returns UL = 40 or 20 or 10 based on status of LCD annuniators
; Arguments: 
; Output: 
; RegMod: UL, A
SUB_9E20:
9E20	6A 40               LDI	    UL,40                       ; 40 = (DEFI)
9E22	A5 76 4E            LDA	    (HIGHLCDFLAG)               ; 0 (Busy), 1 (Shift), 2 (Katana), 3 (Small), 4 (DEFIII), 5 (DEFII), 6 (DEFI)
9E25	D5                  SHR                                 ; A = A >> 1. Shifted thru Carry, 0 into MSB
9E26	87 07               BHS+    BRANCH_9E2F                 ; If Half carry, Bit 3 (Small) branch set forward
9E28	6A 20               LDI	    UL,20                       ; 20 = (DEFII)
9E2A	D5                  SHR                                 ; A = A >> 1. Shifted through Carry, 0 into MSB
9E2B	85 02               BHR+    BRANCH_9E2F                 ; If Half carry reset, no (Katana), branch forward
9E2D	6A 10               LDI	    UL,10                       ; 10 = (DEFIII)

BRANCH_9E2F: ; Branched to from 9E26, 9E2B
9E2F	E9 76 4E 0F         ANI	    (HIGHLCDFLAG),0F            ; Keep only low nibble. 0 (Busy), 1 (Shift), 2 (Katana), 3 (Small)
9E33	24                  LDA	    UL                          ; UL = 40 or 20 or 10
9E34	AB 76 4E            ORA	    (HIGHLCDFLAG)               ;
9E37	AE 76 4E            STA	    (HIGHLCDFLAG)               ;
9E3A	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; SUB_9E3B - Called from JMP_91BC:9219, JMP_91BC:9213
; Reads value from (X) into A and manipulates A 
; Arguments: X = (CUR_VAR_ADD_L)?
; Output: 
; RegMod: A, X
SUB_9E3B:
9E3B	45                  LIN	    (X)                         ; A = (X) then INC X
9E3C	FB                  SEC                                 ; Set Carry Flag
9E3D	B1 30               SBI	    A,30                        ; A = A - 30
9E3F	81 0F               BCR+    BRANCH_9E50                 ; If A was >= 30
9E41	B7 17               CPI	    A,17                        ;
9E43	83 0A               BCS+    BRANCH_9E4F                 ; If A-30 >= 17
9E45	B7 0A               CPI	    A,0A                        ;
9E47	81 06               BCR+    BRANCH_9E4F                 ; If A-30 < 0A
9E49	B1 11               SBI	    A,11                        ; A = A - 30 - 11
9E4B	81 03               BCR+    BRANCH_9E50                 ; If A-30-11 >= 0
9E4D	B3 09               ADI	    A,09                        ; A = A + 9

BRANCH_9E4F: ; Branched to from 9E43, 9E47
9E4F	9A                  RTN                                 ;

BRANCH_9E50: ; Branched to from 9E3F, 9E4B
9E50	FB                  SEC                                 ; Set Carry Flag
9E51	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; TBL_9E52 - This table is a bit of code that is poked into 7AF1 by SUB_9E3B
; The last three lines are different based on Bit 5 of (ZONE_REG). It seems
; to copy a bit of code from CE-150 ROM into System RAM and then call it.
; Arguments: 
; Output: 
; RegMod: Y, X
TBL_9E52:                                                       ; Y = 7A1C before calling
9E52	B8                  RPV                                 ; (7AF1) Reset PV flip-flop. Bank out CE-158
9E53	F5                  TIN                                 ; (7AF2) (Y) = (X) then X = X + 1, Y = Y + 1
9E54	88 03               LOP	    UL,7AF2                     ; (7AF3) UL = UL - 1, loop back 'e' if Borrow Flag not set
9E56	A8                  SPV                                 ; (7AF5) Set PV flip-flop. Bank in CE-158
9E57	9A                  RTN                                 ; (7AF6) Exit

9E58	B8                  RPV                                 ; (7AF7) Reset PV flip-flop. Bank out CE-158
9E59	BE 7A 1C            SJP	    7A1C                        ; (7AF8) Some other code that was copied in from CE-150

; This set of three lines if (ZONG_REG) Bit 5 was set
9E5C	BE A7 47            SJP	    A747                        ; (7AFB)
9E5F	A8                  SPV                                 ; (7AFE) Set PV flip-flop. Bank in CE-158
9E60	9A                  RTN                                 ; (7AFF)

; Or, this set of three lines if (ZONG_REG) Bit 5 was not set
9E61	BE A7 69            SJP	    A769                        ; (7AFB)
9E64	A8                  SPV                                 ; (7AFE) Set PV flip-flop. Bank in CE-158
9E65	9A                  RTN                                 ; (7AFF)



;------------------------------------------------------------------------------------------------------------
; SUB_9E3B - Called from 9CD8
; Copies code from TBL_9E52 into RAM at 7AF1
; Arguments: 
; Output: 
; RegMod: X, Y, U, A
SUB_9E66:
9E66	4A 52               LDI	    XL,52                       ;
9E68	48 9E               LDI	    XH,9E                       ; X = 9E52, unknown table
9E6A	5A F1               LDI	    YL,F1                       ;
9E6C	58 7A               LDI	    YH,7A                       ; Y = 7AF1, BASIC STACK Byte 185
9E6E	6A 09               LDI	    UL,09                       ; 10 bytes to transfer

BRANCH_9E70: ; Branched to from 9E71
9E70	F5                  TIN                                 ; (Y) = (X) then X = X + 1, Y = Y + 1
9E71	88 03               LOP     UL,BRANCH_9E70              ; UL = UL - 1, loop back e if Borrow Flag not set
9E73	6A 04               LDI	    UL,04                       ; Going to copy 5 more bytes
9E75	B5 05               LDI	    A,05                        ;
9E77	ED 78 56 20         BII	    (ZONE_REG),20               ;
9E7B	89 02               BZR+    BRANCH_9E7F                 ; If Bit 5 was set, X = 9E5C
9E7D	FD CA               ADR	    X                           ; X = X + A. X = 9E61

BRANCH_9E7F: ; Branched to from 9E7B, 9E80
9E7F	F5                  TIN                                 ; (Y) = (X) then X = X + 1, Y = Y + 1
9E80	88 03               LOP     UL,BRANCH_9E7F              ; UL = UL - 1, loop back e if Borrow Flag not set
9E82	A4                  LDA	    UH                          ;
9E83	4A 5B               LDI	    XL,5B                       ;
9E85	48 A7               LDI	    XH,A7                       ; X = A75B, something to do with CE-150
9E87	8B 0C               BZS+    BRANCH_9E95                 ; If A = 0
9E89	ED 78 56 20         BII	    (ZONE_REG),20               ;
9E8D	89 02               BZR+    BRANCH_9E91                 ; If Bit 5 was set
9E8F	4A 81               LDI	    XL,81                       ; X = A781, CE150 Print, send ASCII character to printer (no LF)

BRANCH_9E91: ; Branched to from 9E8D
9E91	6A C3               LDI	    UL,C3                       ;
9E93	8E 0E               BCH+    BRANCH_9EA3                 ; Unconditional fwd branch

BRANCH_9E95: ; Branched to from 9E87
9E95	4A CB               LDI	    XL,CB                       ;
9E97	48 A9               LDI	    XH,A9                       ; X = A9CB, something in CE-150
9E99	ED 78 56 20         BII	    (ZONE_REG),20               ;
9E9D	89 02               BZR+    BRANCH_9EA1                 ; If Bit 5 was set
9E9F	4A F1               LDI	    XL,F1                       ; X = A9F1, CE150 Line Feed

BRANCH_9EA1: ; Branched to from 9E9D
9EA1	6A 5F               LDI	    UL,5F                       ;

BRANCH_9EA3: ; Branched to from 9E93
9EA3	5A 1C               LDI	    YL,1C                       ;
9EA5	58 7A               LDI	    YH,7A                       ; Y = 7A1C
9EA7	BE 7A F1            SJP     7AF1                        ; Calls the code we poke in above
9EAA	B5 FA               LDI	    A,FA                        ;
9EAC	6C 00               CPI	    UH,00                       ;
9EAE	89 02               BZR+    BRANCH_9EB2                 ; If UH != 00
9EB0	B5 F8               LDI	    A,F8                        ;

BRANCH_9EB2: ; Branched to from 9EAE                            ; Y = ?
9EB2	FD DA               ADR	    Y                           ; Y = Y + A
9EB4	FD 52               DEC	    YH                          ; YH = YH - 1
9EB6	B5 38               LDI	    A,38                        ; 38 = NOP
9EB8	51                  SIN	    Y                           ; (Y) = A. Then Y = Y + 1
9EB9	51                  SIN	    Y                           ; (Y) = A. Then Y = Y + 1
9EBA	51                  SIN	    Y                           ; (Y) = A. Then Y = Y + 1. Default values?
9EBB	4A EC               LDI	    XL,EC                       ;
9EBD	48 7A               LDI	    XH,7A                       ; X = 7AEC. In BASIC stack
9EBF	A4                  LDA	    UH                          ;
9EC0	0E                  STA	    (X)                         ; (X) = A
9EC1	89 0A               BZR+    BRANCH_9ECD                 ; If A != 0
9EC3	B5 7A               LDI	    A,7A                        ;
9EC5	AE 7A 2A            STA	    (7A2A)                      ; MATH_REG_Wa_B3
9EC8	B5 39               LDI	    A,39                        ;
9ECA	AE 7A 2B            STA	    (7A2B)                      ; MATH_REG_Wa_B4

BRANCH_9ECD: ; Branched to from 9EC1
9ECD	BA 7A F7            JMP	    7AF7                        ; Part of code we poked into system RAM above



;------------------------------------------------------------------------------------------------------------
; JMP_9ED0 - Jumped to from  UNKNOWN_JMP_9083:90AE
; Arguments: A = (7BD8) ; INPUT BUFFER Byte 40
; Output: 
; RegMod: A
JMP_9ED0:
9ED0	ED 78 B0 08         BII	    (78B0),08                   ; BREAK TOP (H)
9ED4	8B 27               BZS+    BRANCH_9EFD                 ; Branch fwd if Bit 3 was not set
9ED6	B7 80               CPI     A,80                        ; 
9ED8	81 0A               BCR+    BRANCH_9EE4                 ; Branch fwd if A <= 80. Printable?
9EDA	ED 78 B0 20         BII	    (78B0),20                   ; BREAK TOP (H)
9EDE	89 1D               BZR+    BRANCH_9EFD                 ; Branch fwd if Bit 5 was set
9EE0	B5 0E               LDI	    A,0E                        ; If A > 80 then A = 0E? Shift Out / X-On
9EE2	8E 0C               BCH+    BRANCH_9EF0                 ; Unconditional fwd branch, exit

BRANCH_9EE4: ; Branched to from 9ED8
9EE4	B7 20               CPI     A,20                        ; Branch fwd if A <= 20
9EE6	81 15               BCR+    BRANCH_9EFD                 ; else, A >= 20 & A < 80 is printable ASCII
9EE8	ED 78 B0 20         BII	    (78B0),20                   ; BREAK TOP (H)
9EEC	8B 0F               BZS+    BRANCH_9EFD                 ; Branch fwd if Bit 5 was not set
9EEE	B5 0F               LDI	    A,0F                        ; If A >= 20 & A < 80 then A = 0F? Shift In / X-Off

BRANCH_9EF0: ; Branched to from 9EE2, A = 0E or A = 0F
9EF0	BE 81 BC            SJP	    CHAR2COM                    ; Sends charecter in A to RS232 Port
9EF3	83 0E               BCS+    BRANCH_9F03                 ; If error sending
9EF5	A5 78 B0            LDA	    (78B0)                      ; BREAK TOP (H)
9EF8	BD 20               EAI	    20                          ; A = A ^ 20. Toggle Bit 5
9EFA	AE 78 B0            STA	    (78B0)                      ; BREAK TOP (H)

BRANCH_9EFD: ; Branched to from 9ED4, 9EDE, 9EEC
9EFD	A5 7B D8            LDA	    (7BD8)                      ; INPUT BUFFER Byte 40
9F00	BA 90 B1            JMP	    JMP_90B1                    ; Drops into SUB_PRINT#_ALT_X1


BRANCH_9F03: ; Branched to from 9EF3
9F03	BA 90 EC            JMP	    SUB_PRINT#_ALT_X1           ;



;------------------------------------------------------------------------------------------------------------
; JMP_9F06 - Jumped to from JUMP_TBL_915F
; Arguments: 
; Output: 
; RegMod: X
JMP_9F06:
9F06	A9 78 B4            AND     (ERRORLINE)                 ; A = A & (ERRORLINE)
9F09	8B 0D               BZS+    BRANCH_9F18                 ; If (ERRORLINE) = 0
9F0B	4A 0E               LDI	    XL,0E                       ;
9F0D	48 00               LDI	    XH,00                       ; X = 000E
9F0F	CD 24               VMJ	    (24)                        ; Sends address from X-Reg as CSI, format "D0 XH XL length" to AR-X 
9F11	FD BE               RIE                                 ; Disable Interrupts
9F13	BE 8A 07            SJP	    UNKNOWN_CMD_89F5_ALT_E1     ; Something to do with UART config
9F16	FD 81               SIE                                 ; Enable interrupts

BRANCH_9F18: ; Branched to from 9F09, 9F1E
9F18	BA 92 3E            JMP	    SUB_PRINT#_ALT_E1           ;



;------------------------------------------------------------------------------------------------------------
; JMP_9F1B - Jumped to from JUMP_TBL_915F
; Arguments: 
; Output: 
; RegMod: A
JMP_9F1B:
9F1B	A9 78 B4            AND	    (ERRORLINE),B4              ; %=10110100
9F1E	9B 08               BZS-    BRANCH_9F18                 ; Bracn if any bits left set, exit
9F20	B5 03               LDI	    A,03                        ;

BRANCH_9F22: ; Branched to from 9F2A, 9F2E
9F22	BA 90 72            JMP	    UNKNOWN_JMP_9072            ; Changes LCD annunciators branches to SUB_PRINT#_ALT_X1



;------------------------------------------------------------------------------------------------------------
; JMP_9F25 - Jumped to from 9049
; Arguments: 
; Output: 
; RegMod: A,X, UL
JMP_9F25:
9F25	A5 78 96            LDA	    (7896)                      ; USING M integer part
9F28	B7 80               CPI     A,80                        ;
9F2A	91 0A               BCR-    BRANCH_9F22                 ; If A < 80 branch back to exit
9F2C	B7 A0               CPI     A,A0                        ;
9F2E	93 0E               BCS-    BRANCH_9F22                 ; If A >= A0
9F30	B9 7F               ANI	    A,7F                        ; Clear bit 7
9F32	BA 91 BC            JMP	    JUMP_91BC                   ; Jumps to JUMP_91BC and then 
                                                                
JMP_9F35: ; Jumped to from JMP_91BC:9206                        
9F35	A5 78 84            LDA	    (CUR_VAR_ADD_L)             ; JUMP_91BC jumps back to here
9F38	B7 07               CPI     A,07                        ;
9F3A	89 2C               BZR+    BRANCH_9F68                 ; If A != 07
9F3C	ED 78 B4 04         BII	    (ERRORLINE),04              ;
9F40	8B 26               BZS+    BRANCH_9F68                 ; If Bit 2 not set
9F42	BE 87 45            SJP	    STRNG_2COM                    ; Sends string to RS232. X is source table address?
9F45	6A 21               LDI	    UL,21                       ;
9F47	A5 78 93            LDA	    (7893)                      ; Pointer operations
9F4A	08                  STA     XH                          ;
9F4B	A5 78 94            LDA	    (7894)                      ; String buffer pointer
9F4E	0A                  STA	    XL                          ;
9F4F	B5 E7               LDI	    A,E7                        ;
9F51	ED 78 91 FF         BII	    (7891),FF                   ; Set flags from GOSUB pointer
9F55	8B 04               BZS+    BRANCH_9F5B                 ; If (7891) not zero
9F57	A5 78 92            LDA	    (7892)                      ; Data pointer
9F5A	DD                  INC     A                           ;

BRANCH_9F5B: ; Branched to from 9F55
9F5B	AE 78 92            STA	    (7892)                      ; Data pointer
9F5E	F9                  REC                                 ; Reset Carry Flag
9F5F	B1 E6               SBI	    A,E6                        ; A = A - E6
9F61	FD CA               ADR	    X                           ; X = X + A
9F63	24                  LDA	    UL                          ;
9F64	0E                  STA	    (X)                         ; (X) = A
9F65	BA 90 E1            JMP	    JMP_90E1                    ;

BRANCH_9F68: ; Branched to from 9F3A, 9F40
9F68	A5 78 B2            LDA	    (78B2)                      ; ERROR ADDRESS (H)
9F6B	BA 92 09            JMP	    JMP_9209                    ; SUB_911E:JMP_9209



;------------------------------------------------------------------------------------------------------------
; SUB_9F75 - Called from 8AD9
; Arguments: U = D056, X = 83B8 = CE-158_IO-REG_INIT2
; Does some initialization of the CE-158 registers
; Arguments: 
; Output: 
; RegMod: U, X, A
SUB_9F75:
9F75	ED 78 8E 01         BII	    (TRACE_ON),01               ; 
9F79	89 13               BZR+    BRANCH_9F8E                 ; If Bit 0 was set
9F7B	68 78               LDI	    UH,78                       ; U = 7856 = ZONE_REG. 
9F7D	69 60               ANI	    (U),60                      ; Keep Bits 2,3
9F7F	45                  LIN	    (X)                         ; A = (83B8) then INC X. 
9F80	2B                  ORA	    (U)                         ; A = A | (ZONE_REG) 
9F81	8E 01               BCH+    BRANCH_9F84                 ; Branch fwd unconditional

; This section indexs through ; X 83B8 -> 83BC, U 7856 -> 7851. Inits:
; 7852-Console 1 (//), 7853-Undefined, 7854-Undefined, 7855-(CR/LF_REG), 7856-ZONE
BRANCH_9F83:                                            
9F83	45                  LIN	    (X)                         ; A = (X) then INC X.

BRANCH_9F84: ; X = 83B9 U = 7856 on first entering
9F84	2E                  STA	    (U)                         ; U = X read above
9F85	62                  DEC	    UL                          ; DEC pointer.
9F86	6E 51               CPI	    UL,51                       ; 
9F88	93 07               BCS-    BRANCH_9F83                 ; If UL > 51 branch back
9F8A	69 0F               ANI	    (U),0F                      ; (U) = (U) & 0F, here U = 7851 = Console 1 (RS232C)
9F8C	6B 03               ORI	    (U),03                      ; (U) = (U) | 03

BRANCH_9F8E: ; X = 83B8 U = D056 on entering
9F8E	FD A5 D0 0E         LDA	    #(CE158_PRT_A)              ; CE-158 (ME1)
9F92	B9 C0               ANI	    A,C0                        ; Keep bits 6-7 (part of BAUD rate select)
9F94	B7 80               CPI	    A,80                        ; 
9F96	89 02               BZR+    BRANCH_9F9A                 ; If A != 80 branch fwd
9F98	B5 A0               LDI	    A,A0                        ; 

BRANCH_9F9A:
9F9A	ED 78 8E 01         BII	    (TRACE_ON),01               ; 
9F9E	8B 07               BZS+    BRANCH_9FA7                 ; If bit 0 not set branch fwd
9FA0	E9 78 57 1F         ANI	    (SETDEV_REG),1F             ; Clear bits 7-5
9FA4	AB 78 57            ORA	    (SETDEV_REG)                ; A = A | (SETDEV_REG)

BRANCH_9FA7:
9FA7	AE 78 57            STA	    (SETDEV_REG)                ; (SETDEV_REG) = A
9FAA	FD EB D0 0C C0      ORI	    #(CE158_PRT_A_DIR),C0       ; CE-158 - Set bit 7-6 to write. (part of BAUD rate select) (ME1)
9FAF	ED 78 8E 80         BII	    (TRACE_ON),80               ; 
9FB3	89 1A               BZR+    BRANCH_9FCF                 ; If bit 7 was set branch fwd 
9FB5	FD A5 D0 0E         LDA	    #(CE158_PRT_A)              ; A = (CE158_PRT_A) (ME1)
9FB9	6A 28               LDI	    UL,28                       ; setting up a time delay?
9FBB	68 0A               LDI	    UH,0A                       ; U = 0A28

BRANCH_9FBD:
9FBD	88 02               LOP	    UL,9FBD                     ; DEC UL, if borrow flag not set loop back.
9FBF	FD 62               DEC	    UH                          ; DEC UH
9FC1	93 06               BCS-    BRANCH_9FBD                 ; Branch back if have passed zero?
9FC3	FD A9 D0 0E         AND	    #(CE158_PRT_A)              ; A = A & (CE158_PRT_A) (ME1), waiting to see what has changed?
9FC7	BF 20               BII	    A,20                        ; FLAGS = A & 20 (Low Battery)
9FC9	8B 04               BZS+    BRANCH_9FCF                 ; If Bit 5 of not set branch fwd
9FCB	EB 7A 22 01         ORI	    (MATH_REG_Va_B3),01         ; Set Bit 0

BRANCH_9FCF:
9FCF	9A                  RTN                                 ; Return, done



;------------------------------------------------------------------------------------------------------------
; SUB_9FD0 - Called from 8D10, 8AA0
; Sets DTR/RTS based on OUTSTAT_REG
; Arguments: 
; Output: 
; RegMod:
SUB_9FD0:
9FD0	FD C8               PSH	    A                           ; #(CE158_PRT_A) Bit 0 = DTR, Bit 1 = RTS
9FD2	FD A5 D0 0E         LDA	    #(CE158_PRT_A)              ; A = #(CE158_PRT_A) (ME1)
9FD6	B9 FC               ANI	    A,FC                        ; A = #(CE158_PRT_A) & FC. Mask off Bits 0,1
9FD8	ED 78 50 01         BII	    (OUTSTAT_REG),01            ; 
9FDC	8B 01               BZS+    BRANCH_9FDF                 ; If Bit 0 not set skip
9FDE	DD                  INC	    A                           ; If ((OUTSTAT_REG) & 01) A = A + 1

BRANCH_9FDF:
9FDF	ED 78 50 02         BII	    (OUTSTAT_REG),02            ; Mask off all but Bit 1
9FE3	8B 02               BZS+    BRANCH_9FE7                 ; If Bit 1 not set skip
9FE5	DD                  INC	    A                           ;
9FE6	DD                  INC	    A                           ; If ((OUTSTAT_REG) & 02) A = A + 2

BRANCH_9FE7:
9FE7	FD AE D0 0E         STA     #(CE158_PRT_A)              ; We cleared Bits 0-1, then set them based on (OUTSTAT_REG)
9FEB	FD 8A               POP	    A                           ; Get original A back
9FED	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; SUB_9FEF - Called from 96ED, 96B7, 8D28
; CE-150 - Clears Pen Descending signal, and applies it again if safe.
; Arguments: 
; Output: 
; RegMod:
SUB_9FEF:
9FEF	FD E9 B0 0A FD      ANI	    #(CE150_MSK_REG),FD         ; Clear Bit 1, Pen descending?
9FF4	ED 79 F1 FF         BII	    (BATT/PEN_FLAG),FF          ; Set flags based on regsiter
9FF8	89 05               BZR+    BRANCH_9FFF                 ; If any bit was set (Pen ascending, Low battery, Paper feed btn)
9FFA	FD EB B0 0A 02      ORI	    #(CE150_MSK_REG),02         ; Set Bit 1.

BRANCH_9FFF:
9FFF	9A                  RTN                                 ; Return, DONE

