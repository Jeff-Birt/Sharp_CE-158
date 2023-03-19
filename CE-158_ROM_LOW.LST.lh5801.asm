; CE-158_ROM_LOW.lh5801.asm

.ORG $8000

;------------------------------------------------------------------------------------------------------------
; BASIC Command Table 8000
;------------------------------------------------------------------------------------------------------------
B_TBL_8000:
8000	55              .BYTE   $55                 ; Marker that BASIC Table follows 

B_TBL_8000_TNUM:
8001	08              .BYTE   $08                 ; Table number

B_TBL_8000_NAME:
8002	43 4F 4D 0D     .TEXT   "COM\r\r\r\r\r"     ; Table name
8006    0D 0D 0D 0D  
                        
B_TBL_8000_INIT:
800A    BA 82 B8        JMP	    COM_TBL_INIT        ; 82B8 - Table initilization vector

B_TBL_8000_INPUT#:
800D	BA 82 C5        JMP	    COM_TBL_INPUT#      ; 82C5 - Table INPUT# vector

B_TBL_8000_PRINT#:
8010	BA 82 C9        JMP	    COM_TBL_PRINT#      ; 82C9 - Table PRINT# vector

B_TBL_8000_JMPS:
8013	9A 9A 9A 9A     .BYTE $9A, $9A, $9A, $9A
8017    9A 9A 9A 9A     .BYTE $9A, $9A, $9A, $9A
801B    9A 9A           .BYTE $9A, $9A              ; Unused jumps

B_TBL_8000_TRACE:
801D	C4 AF FF        VEJ ($C4),$AF,$811F         ; is correct per the book

B_TBL_8000_A_KW:
8020	00 00           .BYTE   $00, $00            ;

B_TBL_8000_B_KW:
8022	80 56           .BYTE   $80, $56            ; $8056

B_TBL_8000_C_KW:
8024	80 60           .BYTE   $80, $60            ; $8060

B_TBL_8000_D_KW:
8026	80 89           .BYTE   $80, $89            ; $8089

B_TBL_8000_E_KW:
8028	80 9A           .BYTE   $80, $9A            ; $809A

B_TBL_8000_F_KW:
802A	80 AA           .BYTE   $80, $AA            ; $80AA

B_TBL_8000_G_KW:
802C	00 00           .BYTE   $00, $00            ;

B_TBL_8000_H_KW:
802E	00 00           .BYTE   $00, $00            ;

B_TBL_8000_I_KW:
8030	80 B3           .BYTE   $80, $B3            ; $80B3

B_TBL_8000_J_KW:
8032	00 00           .BYTE   $00, $00            ;

B_TBL_8000_K_KW:
8034	00 00           .BYTE   $00, $00            ;

B_TBL_8000_L_KW:
8036	80 C8           .BYTE   $80, $C8            ; $80C8

B_TBL_8000_M_KW:
8038	80 DD           .BYTE   $80, $DD            ; $80DD

B_TBL_8000_N_KW:
803A	00 00           .BYTE   $00, $00            ;

B_TBL_8000_O_KW:
803C	80 E7           .BYTE   $80, $E7            ; $80E7

B_TBL_8000_P_KW:
803E	80 F3           .BYTE   $80, $F3            ; $80F3

B_TBL_8000_Q_KW:
8040	00 00           .BYTE   $00, $00            ;

B_TBL_8000_R_KW:
8042	81 0A           .BYTE   $81, $0A            ; $810A

B_TBL_8000_S_KW:
8044	81 16           .BYTE   $81, $16            ; $8116

B_TBL_8000_T_KW:
8046	81 37           .BYTE   $81, $37            ; $8137

B_TBL_8000_U_KW:
8048	00 00           .BYTE   $00, $00            ;

B_TBL_8000_V_KW:
804A	00 00           .BYTE   $00, $00            ;

B_TBL_8000_W_KW:
804C	00 00           .BYTE   $00, $00            ;

B_TBL_8000_X_KW:
804E	00 00           .BYTE   $00, $00            ;

B_TBL_8000_Y_KW:
8050	00 00           .BYTE   $00, $00            ;

B_TBL_8000_Z_KW:
8052	81 59           .BYTE   $81, $59                        ; $8159

B_TBL_8000_CMD_LST:     ;Token Address
8054	$B5 "BREAK"       $F0B3 $CD89                           ; $CD89 - Basic command P___/STEP/OFF/OR/ERROR/AND/THEN/TO
805E	$B5 "CLOAD"       $F089 $82EC                           ; $82EC - MAIN_ENTRY
8068	$C5 "CSAVE"       $F095 $82DD                           ; $82DD - Drops through to MAIN_ENTRY
8072	$C4 "COM$"        $E858 $82D3                           ; $82D3 - Drops through to MAIN_ENTRY
807B	$C7 "CONSOLE"     $F0B1 $82DE                           ; $82DE - Drops through to MAIN_ENTRY      
8087	$D4 "DEV$"        $E857 $82D4                           ; $82D4 - Drops through to MAIN_ENTRY 
8090	$C3 "DTE"         $E884 $82D1                           ; $82D1 - Drops through to MAIN_ENTRY
8098	$D3 "ERN"         $F052 $82DF                           ; $82DF - Drops through to MAIN_ENTRY 
80A0	$C3 "ERL"         $F053 $82E0                           ; $82E0 - Drops through to MAIN_ENTRY
80A8	$D4 "FEED"        $F0B0 $82E1                           ; $82E1 - Drops through to MAIN_ENTRY 
80B1	$D5 "INPUT"       $F091 $82E2                           ; $82E2 - Drops through to MAIN_ENTRY 
80BB	$C6 "INSTAT"      $E859 $82E3                           ; $82E3 - Drops through to MAIN_ENTRY
80C6	$D6 "LPRINT"      $F0B9 $82E4                           ; $82E4 - Drops through to MAIN_ENTRY
80D1	$C5 "LLIST"       $F0B8 $82E5                           ; $82E5 - Drops through to MAIN_ENTRY 
80DB	$D5 "MERGE"       $F08F $82C0                           ; $82C0 - Sets XL=F0, branches to MAIN_ENTRY
80E5	$97 "OUTSTAT"     $E880 $82E6                           ; $82E6 - Drops through to MAIN_ENTRY
80F1	$C5 "PRINT"       $F097 $82E7                           ; $82E7 - Drops through to MAIN_ENTRY
80FB	$C8 "PROTOCOL"    $E881 $82E8                           ; $82E8 - Drops through to MAIN_ENTRY
8108	$D7 "RINKEY$"     $E85A $82E9                           ; $82E9 - Drops through to MAIN_ENTRY 
8114	$D6 "SETCOM"      $E882 $82D6                           ; $82D6 - Drops through to MAIN_ENTRY
811F	$C6 "SETDEV"      $E886 $82D5                           ; $82D5 - Drops through to MAIN_ENTRY  
812A	$C6 "SPACE$"      $F061 $82EA                           ; $82EA - Drops through to MAIN_ENTRY 
8135	$B8 "TERMINAL"    $E883 $82D2                           ; $82D2 - Drops through to MAIN_ENTRY 
8142	$C8 "TRANSMIT"    $E885 $82D7                           ; $82D7 - Drops through to MAIN_ENTRY
814F	$C3 "TAB"         $F0BB $880D                           ; $880D - Uses 8800 BASIC Table TAB/INPUT# vector
8157	$D4 "ZONE"        $F0B4 $82EB                           ; $82EB - Drops through to MAIN_ENTRY 

B_TBL_8800_END:
8160	$D0 



;------------------------------------------------------------------------------------------------------------
; Unused address range 8161-8168
SEPARATOR_8161:
8161	DF 00 FF 00         .BYTE   $DF, $00, $FF, $00          ; FF 00 - Used as seperator / space filler
8165    FF 00 CB 00         .BYTE   $FF, $00, $CB, $00          ; 



;------------------------------------------------------------------------------------------------------------
; CHAR2LPT - Sends charecter in A to LPT
; Same as High Bank
; Called from 826E, 9307, 956D
; Arguments: A: ASCII charecter >=20, i.e. printable
; Outputs: REC = Success, A = 20 Low Battery
; RegMod: A
CHAR2LPT:
8169	FD C8               PSH	    A                           ; A is the ASCII charecter from input buffer?
816B	B5 7F               LDI	    A,$7F                       ; 
816D	FD AE D0 0D         STA     #(CE158_PRT_B_DIR)          ; Bit 7 Read (BUSY), (ME1)
8171	FD A5 D0 0E         LDA     #(CE158_PRT_A)              ; Read CE-158 Port A,  (ME1)
8175	FD A9 D0 0E         AND     #(CE158_PRT_A)              ; Filter out input changes? (ME1)
8179	D9                  SHL                                 ; A = A << 1. Shifted though carry. 0 into MSB
817A	D9                  SHL                                 ; Original    7 6 5 4 3 2 1 0
817B	D9                  SHL                                 ; << 3        4 3 2 1 0 0 0 0 
817C	FD 8A               POP	    A                           ; Get our ASCII character from input buffer back
817E	83 38               BCS+    BRANCH_81B8                 ; If #(PRT_A_IO) Bit 5, (Low Battery) skip to exit
8180	FD ED D0 0F 80      BII     #(CE158_PRT_B),$80          ; (ME1)
8185	8B A5               BZS+    BRANCH_822C                 ; If Bit 7 not set (I/F_BUSY) borrow another exit
8187	FD E9 D0 08 9F      ANI     #(CE158_PRT_C),$9F          ; Clear Bits 6,5 LPT_STROBE,LPT_DATA1 (ME1) 
818C	BD FF               EAI	    $FF                         ; A = A ^ FF. Invert due to inverters in LPT output
818E	D5                  SHR                                 ; A = A >> 1. Shifted through Carry, 0 into MSB
818F	81 05               BCR+    BRANCH_8196                 ; If Bit 0 set (inverted/shifted out), branch fwd
8191	FD EB D0 08 20      ORI     #(CE158_PRT_C),$20          ; Set Bit 5, LPT_DATA1 (ME1)
                                                                ; DATA1 on PORTC, DATA 2-8 on PORTB

BRANCH_8196: ; Branched to from 818F
8196	FD AE D0 0F         STA     #(CE158_PRT_B)              ; #(PRT_B_IO) = A (ME1). A = (A ^ FF) >> 1
                                                                ; Shift in 818C aligns Bits 2-8 to PORTB.
819A	B5 80               LDI	    A,$80                       ; Set up time delay

BRANCH_819C: ; Branched to from 81D9
819C	DF                  DEC	    A                           ; Carry set by first DEC, count 80->0
819D	93 03               BCS-    BRANCH_819C                 ; If Carry set repeat, carry clear after hitting 0
819F	FD BE               RIE                                 ; Disable interrupts 
81A1	FD EB D0 08 40      ORI     #(CE158_PRT_C),$40          ; Set LPT_STROBE (ME1)
81A6	B5 80               LDI	    A,$80                       ; Set up time delay

BRANCH_81A8: ; Branched to from 81A9
81A8	DF                  DEC	    A                           ; Carry set by first DEC, count 80->0
81A9	93 03               BCS-    BRANCH_81A8                 ; If Carry set repeat, Carry clear after hitting 0
81AB	FD E9 D0 08 BF      ANI     #(CE158_PRT_C),$BF          ; CE-158 - Clear LPT_STROBE (ME1)
81B0	FD 81               SIE                                 ; Enable Interrupts
81B2	B5 80               LDI	    A,$80                       ; Set up time delay

BRANCH_81B4: ; Branched to from 81B5
81B4	DF                  DEC	    A                           ; Carry set by first DEC, count 80->0
81B5	93 03               BCS-    BRANCH_81B4                 ; If Carry set repeat, Carry clear after hitting 0
81B7	9A                  RTN                                 ; Carry will be reset by last DEC above

BRANCH_81B8: ; Branced from 817E                                ; Return here if low battery
81B8	B5 20               LDI	    A,$20                       ; Does A = 20 mean low battery?
81BA	FB                  SEC                                 ; Carry used to indicate return state? 
81BB	9A                  RTN                                 ; Set Carry Flag. SEC = Failure



; -----------------------------------------------------------------------------------------------------------
; CHAR2COM - Sends charecter in A to RS232 Port
; Same as High Bank
; Called from 875B, 87EA, 90B1, 9EF0, 8247
; Arguments: A charecter to send
; Outputs: REC = Success, A = #(CE158_PRT_A) Bits 5-2  on failure
; RegMod: A
CHAR2COM:
81BC	FB                  SEC                                 ; Set Carry Flag
81BD	FD A8               PSH     U                           ; Save U.
81BF	2A                  STA	    UL                          ; A is character to send
81C0	FD A5 D0 0E         LDA	    #(CE158_PRT_A)              ; #(CE158_PRT_A) is LPT/RS232 I/F Ctrl (ME1)
81C4	FD A9 D0 0E         AND	    #(CE158_PRT_A)              ; Filter out changes (ME1)
81C8	B9 3C               ANI	    A,$3C                       ; Keep Bits 2->CTS, 3->CD, 4->DSR, 5->Low Battery
81CA	89 17               BZR+    BRANCH_81E3                 ; Branch fwd if any bit 5-2 is set
81CC	A5 78 57            LDA	    (SETDEV_REG)                ; (SETDEV_REG) = What device directed to RS232
                                                                ; B7=? B6=THRE B5? B4=CO B3=CI B2=PO B1=DO B0=KI
81CF	B9 C0               ANI	    A,$C0                       ; Keep Bits 7-6 are set at power on
81D1	D9                  SHL                                 ; A = A < 1. Bit 7 into Carry, 0 carried into LSB
81D2	83 02               BCS+    BRANCH_81D6                 ; Branch fwd if Bit 7 was set.
81D4	B5 04               LDI	    A,$04                       ; A = 4. Set bit 2

BRANCH_81D6: ; Branched to from 81D2
81D6	FD A9 D2 03         AND	    #(CE158_UART_REG_R)        ; A = A & UART_STATUS. A=Bit6 of SETDEV_REG<<1 or $04
                                                                ; clear all but Bit7 (THRE) or Bit2 (PE)
81DA	FB                  SEC                                 ; Set carry flag = failure
81DB	8B 06               BZS+    BRANCH_81E3                 ; Branch fwd if Bit7 (THRE) or Bit2 (PE) not set
81DD	24                  LDA	    UL                          ; Our original A is in UL. Charecter to send.
81DE	FD AE D2 00         STA	    #(CE158_UART_DATA_W)              ; Writes A to UART (ME1)
81E2	F9                  REC                                 ; Reset Carry Flag = Success

BRANCH_81E3: ; Branched to from 81CA, 81DB
81E3	FD 2A               POP	    U                           ; Get original U back, affectes Z only
81E5	9A                  RTN                                 ; A contains #(CE158_PRT_A) Bits 5-2 on failure



;-------------------------------------------------------------------------------------------------------------
; RXCOM - Manipulates LPT/UART registers
; Same as High Bank
; called from 8CBD, 99BC.  Alt entry at 822C, 8CBD
; Arguments: None
; Outputs: REC = Success, A = Failure type or UART data read
; RegMod: A
RXCOM: 
81E6	FD A5 D0 0E         LDA	    #(CE158_PRT_A)              ; #(CE158_PRT_A) is LPT/RS232 control
81EA	FD A9 D0 0E         AND     #(CE158_PRT_A)              ; Filter out changes
81EE	B9 3C               ANI     A,$3C                       ; Keep Bits 2->CTS, 3->CD, 4->DSR, 5->Low Battery
81F0	89 3E               BZR+    BRANCH_8230                 ; Branch fwd if any bits 5-2 were set, failure exit
81F2	FD A5 D2 03         LDA     #(CE_158_UART_REG_R)           ; UART status register
81F6	ED 78 57 40         BII	    (SETDEV_REG),$40            ; Test Bit6 
                                                                ; B7=? B6=THRE B5? B4=CO B3=CI B2=PO B1=DO B0=KI
81FA	8B 01               BZS+    BRANCH_81FD                 ; If TSRE not set branch fwd (last byte not done)
81FC	D9                  SHL                                 ; A = A << 1. UART Status register

BRANCH_81FD: ; Branched to from 81FA
81FD	BF 02               BII	    A,$02                       ; Test Bit1 of A (Bit0 of CE_158_UART_REG_R) OE Overrun Error
81FF	8B 2B               BZS+    BRANCH_822C                 ; It set we had an Rx overrun, branch to failure exit
8201	ED 78 57 80         BII	    (SETDEV_REG),$80            ; Test Bit7
                                                                ; B7=? B6=THRE B5? B4=CO B3=CI B2=PO B1=DO B0=KI
8205	8B 01               BZS+    BRANCH_8208                 ; Branch fwd if Bit7 not set 
8207	D9                  SHL                                 ; A = CE_158_UART_REG_R << 2

BRANCH_8208: ; Branched to from 8205
8208	BF 70               BII	    A,$70                       ; Keep bit 6-4, Bits 4-2 from original (CE_158_UART_REG_R)
820A	8B 1A               BZS+    BRANCH_8226                 ; Bits 6-4 -> ES FE PE, if all bits clear branch (no error?)
820C	FD A5 D2 02         LDA     #(CE158_UART_DATA_R)              ; Read UART Data Register to clear it
8210	ED 78 57 20         BII	    (SETDEV_REG),$20            ; Test Bit5
                                                                ; B7=? B6=THRE B5? B4=CO B3=CI B2=PO B1=DO B0=KI
8214	8B 0C               BZS+    BRANCH_8222                 ; Branch fwd if Bit5 not set, failure
8216	B5 15               LDI	    A,$15                       ; sets: Bit4 WLS2, Bit2 SBS, Bit0 PI
8218	FD AE D2 01         STA     #(CE158_UART_REG_W)           ; Writing UART control reg
821C	B5 05               LDI	    A,$05                       ; sets: Bit2 SBS, Bit0 PI
821E	FD AE D2 01         STA     #(CE158_UART_REG_W)           ; To pulse Bit 4?

BRANCH_8222: ; Branched to from 8214
8222	B5 40               LDI	    A,$40                       ; Failure type
8224	FB                  SEC                                 ; Set Carry Flag
8225	9A                  RTN                                 ; SEC = Failure

BRANCH_8226: ; Branched to from 820A
8226	FD A5 D2 02         LDA     #(CE158_UART_DATA_R)        ; Read data byte
822A	F9                  REC                                 ; REC = Success
822B	9A                  RTN                                 ; Carry flag indicates return state

BRANCH_822C: ; Branched to bfrom 8185, 81FF
822C	B5 00               LDI	    A,$00                       ; Failure type
822E	FB                  SEC                                 ; SEC = Failure
822F	9A                  RTN                                 ; Carry flag indicates return state

BRANCH_8230: ; Branched to from 81F0
8230	FD C8               PSH	    A                           ; A = #(PORTA_IO) & 3C (Bits 5-2), failure type?
8232	FD A5 D2 02         LDA     #(CE158_UART_DATA_R)        ; A = Data read from UART (ME1), clear Rx register
8236	FB                  SEC                                 ; SEC = Failure

BRANCH_8237: ; Branched to from 824A to borrow return
8237	FD 8A               POP	    A                           ; 
8239	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; TXCOM - not sure how this is called ***
; Checks that COM port ready and then calls CHAR2COM to TX char in A
; Arguments: A charecter to send
; Outputs:
; RegMod: UH
TXCOM:
823A	E9 78 50 0F         ANI	    (OUTSTAT_REG),$0F           ; Keep only low nibble Bit0 DTR, Bit1 RTS

BRANCH_823E: ; Branched to from 8250, 8256
823E	FD ED F0 0B 02      BII	    #(PC1500_IF_REG),$02        ; PC-1500 - IF Register Bit1 PB7 (ON Key)
8243	89 6E               BZR+    BRANCH_82B3                 ; If Bit 1 was set branch fwd to an exit (reset)
8245	FD C8               PSH	    A                           ; Save cahracter to TX
8247	BE 81 BC            SJP     CHAR2COM                    ; Sends charecter in A to RS232 Port
824A	91 15               BCR-    BRANCH_8237                 ; Carry Reset = success, branch back to borrow a return
824C	D5                  SHR                                 ;  CHAR2COM returns A = #(PRT_A_IO) Bits 5-2 on failure
824D	D5                  SHR                                 ; A = A >> 2. Through carry. 0 into MSB
824E	FD 8A               POP	    A                           ; POP A only changes Z flag
8250	95 14               BHR-    BRANCH_823E                 ; If Bit 3 (half carry) not set by shifts above (CTS)
8252	EF 78 50 10         ADI	    (OUTSTAT_REG),$10           ; (OUTSTAT_REG) += 10, Bit4 DSR. Being used as a loop counter.
8256	91 1A               BCR-    BRANCH_823E                 ; Are we waiting for a handshaking signal

BRANCH_8258: ; Branched to from 828C, 82AB to borrow return
8258	68 32               LDI	    UH,$32                      ; Return code?

BRANCH_825A: ; Branched to from 8284 to borrow return
825A	9A                  RTN                                 ;



;------------------------------------------------------------------------------------------------------------
; TXLPT - Called from 9893, 9899, 98AB, 98B1
; Sends data to LPT output function, same as in high bank
; Arguments: A = character to send
; Outputs: A = Error code, 20 = Low Battery, 00 = Could not send?, UH: 45 = success
; RegMod: UH
TXLPT:
825B	E9 78 50 0F         ANI	    (OUTSTAT_REG),$0F           ; Keep only low nibble Bit0 DTR, Bit1 RTS

BRANCH_825F: ; Branched to from 828A
825F	FD A8               PSH     U                           ;
8261	6A FF               LDI	    UL,$FF                      ; try to send FF times?
8263	68 00               LDI	    UH,$00                      ; U = 00FF

BRANCH_8265: ; Branched to from 8275, 8279
8265	FD ED F0 0B 02      BII	    #(PC1500_IF_REG),$02        ; PC-1500 - IF Register Bit1 PB7 (ON Key)
826A	89 45               BZR+    BRANCH_82B1                 ; If Bit 1 was set branch fwd to an exit (reset)
826C	FD C8               PSH	    A                           ; Save cahracter to TX
826E	BE 81 69            SJP     CHAR2LPT                    ; Sends charecter in A to LPT, Returns A as failure type
8271	89 0D               BZR+    BRANCH_8280                 ; A = 20 Low Battery, A = 00 is could not send?, C=0=success
8273	FD 8A               POP	    A                           ; A now original character to send
8275	88 12               LOP     UL,BRANCH_8265              ; UL = UL - 1, loop back e if Borrow Flag not set
8277	FD 60               INC	    UH                          ; UH = 1
8279	91 16               BCR-    BRANCH_8265                 ; Keeps trying to send A until timeout ($FF * $FF)
827B	FD 2A               POP	    U                           ; Original U
827D	68 45               LDI	    UH,$45                      ;
827F	9A                  RTN                                 ; Return with ERROR code 45 in UH

BRANCH_8280: ; Branched to from 8271,                           ; Got here because Low Battery or success
8280	FD 8A               POP	    A                           ; Original character to send
8282	FD 2A               POP	    U                           ; Original U
8284	91 2C               BCR-    BRANCH_825A                 ; Carry Clear = Success, borrowing a Return to exit
8286	EF 78 50 10         ADI	    (OUTSTAT_REG),$10           ; (OUTSTAT_REG) += 10, Bit4 DSR. Being used as a loop counter.
828A	91 2D               BCR-    BRANCH_825F                 ; If we did not set carry
828C	9E 36               BCH-    BRANCH_8258                 ; Unconditional back branch, borrowing a return.

BRANCH_828E:
828E	E9 78 50 0F         ANI	    (OUTSTAT_REG),$0F           ; Keep Bits 0-3, Bit_0 = DCD, Bit_1 = DSR (bits we did not mess with)

BRANCH_8292: ; Branched to from 82A0, 82A9
8292	FD ED F0 0B 02      BII	    #(PC1500_IF_REG),$02        ; PC-1500 - IF Register Bit1 PB7 (ON Key)
8297	89 1A               BZR+    BRANCH_82B3                 ; If Bit 1 was set branch fwd to an exit (reset) Failure.
8299	BE 81 E6            SJP     RXCOM                       ; Manipulates LPT/UART registers
829C	81 12               BCR+    BRANCH_82B0                 ;   REC = Success, A = Failure type or UART data read
829E	B9 60               ANI	    A,$60                       ; A = A & 60. Keep bits 6-5
82A0	9B 10               BZS-    BRANCH_8292                 ; If Bits 6 or 5 not set ***need to what these bits are
82A2	D9                  SHL                                 ; A = A << 1. Thru carry. 0 into LSB
82A3	8F 08               BVS+    BRANCH_82AD                 ; If Overlflow set
82A5	EF 78 50 10         ADI	    (OUTSTAT_REG),$10           ; (OUTSTAT_REG) += 10. Bit_0 = DCD, Bit_1 = DSR
82A9	91 19               BCR-    BRANCH_8292                 ; Carry set by shift above
82AB	9E 55               BCH-    BRANCH_8258                 ; Unconditional back branch, borrowing a return.;

BRANCH_82AD: ; Branched to from 82A3
82AD	68 3A               LDI	    UH,$3A                      ; Return value? Failure.
82AF	FB                  SEC                                 ; Set Carry Flag

BRANCH_82B0: ; Branched to from 829C
82B0	9A                  RTN                                 ;

BRANCH_82B1: ; Branched to from 826A
82B1	FD 2A               POP	    U                           ;

BRANCH_82B3: ; Branched to from 8243, 8297
82B3	68 00               LDI	    UH,$00                      ; Return value? Failure.
82B5	FB                  SEC                                 ; Set Carry Flag
82B6	9A                  RTN                                 ;


; Not sure this is reached, ***REACHED
82B7	8E                  .BYTE $8E



;------------------------------------------------------------------------------------------------------------
; COM_TBL_INIT - Called from BASIC table init vector 800A
; Called from BASIC Table 8000 INIT, changes XL which is used to calc index into vector table
; Arguments:
; Outputs:
; RegMod: XL
COM_TBL_INIT:
82B8	4A D0               LDI	    XL,$D0                      ; D0 is command code for INIT
82BA	E9 79 DE EF         ANI	    (UNDEF_REG_79DE),$EF        ; ***What is this a flag for? Clear bit to to signal start of INIT?
82BE	8E 2C               BCH     MAIN_ENTRY                  ; Branch fwd unconditional



;------------------------------------------------------------------------------------------------------------
; Following called via BASIC Table 8000 Command List vectors
; X-REG contains address of function below. Some stubs below change XL. Most drop through.
; XL used to calculate index into vector table
; Arguments:
; Outputs:
; RegMod: UL, XL
MERGE:
82C0	60                  INC	    UL                  ; Line number counter?
82C1	4A F0               LDI	    XL,$F0              ; F0 a command code, used in MAIN_ENTRY
82C3	8E 27               BCH+	MAIN_ENTRY    ; Branch fwd unconditional

COM_TBL_INPUT#:
82C5	4A ED               LDI	    XL,$ED              ; ED a command code, used in MAIN_ENTRY
82C7	8E 23               BCH+	MAIN_ENTRY    ; Branch fwd unconditional

COM_TBL_PRINT#:
82C9	4A EE               LDI	    XL,$EE              ; EE a command code, used in MAIN_ENTRY
82CB	8E 1F               BCH+	MAIN_ENTRY    ; Branch fwd unconditional

LPTR_TBL_PRINT#:
82CD	4A EF               LDI	    XL,$EF              ; EF a command code, used in MAIN_ENTRY
82CF	8E 1B               BCH+	MAIN_ENTRY    ; Branch fwd unconditional

DTE:
82D1	F9                  REC                         ; Reset Carry Flag, does nothing drop through

TERMINAL:
82D2	F9                  REC                         ; Reset Carry Flag, does nothing drop through

COM$:
82D3	F9                  REC                         ; Reset Carry Flag, does nothing drop through

DEV$:
82D4	F9                  REC                         ; Reset Carry Flag, does nothing drop through

SETDEV:
82D5	F9                  REC                         ; Reset Carry Flag, does nothing drop through

SETCOM:
82D6	F9                  REC                         ; Reset Carry Flag, does nothing drop through

TRANSMIT:
82D7	F9                  REC                         ; Reset Carry Flag, does nothing drop through

CONSOLE_2:
82D8	F9                  REC                         ; Reset Carry Flag, does nothing drop through

FEED_2:
82D9	F9                  REC                         ; Reset Carry Flag, does nothing drop through

LPRINT_2:
82DA	F9                  REC                         ; Reset Carry Flag, does nothing drop through

LLIST_2:
82DB	F9                  REC                         ; Reset Carry Flag, does nothing drop through
82DC	F9                  REC                         ; Reset Carry Flag, does nothing drop through

CSAVE:
82DD	F9                  REC                         ; Reset Carry Flag, does nothing drop through

CONSOLE:
82DE	F9                  REC                         ; Reset Carry Flag, does nothing drop through

ERN:
82DF	F9                  REC                         ; Reset Carry Flag, does nothing drop through

ERL:
82E0	F9                  REC                         ; Reset Carry Flag, does nothing drop through

FEED:
82E1	F9                  REC                         ; Reset Carry Flag, does nothing drop through

INPUT:
82E2	F9                  REC                         ; Reset Carry Flag, does nothing drop through

INSTAT:
82E3	F9                  REC                         ; Reset Carry Flag, does nothing drop through

LPRINT:
82E4	F9                  REC                         ; Reset Carry Flag, does nothing drop through

LLIST:
82E5	F9                  REC                         ; Reset Carry Flag, does nothing drop through

OUTSTAT:
82E6	F9                  REC                         ; Reset Carry Flag, does nothing drop through

PRINT:
82E7	F9                  REC                         ; Reset Carry Flag, does nothing drop through

PROTOCOL:
82E8	F9                  REC                         ; Reset Carry Flag, does nothing drop through

RINKEY$:
82E9	F9                  REC                         ; Reset Carry Flag, does nothing drop through

SPACE$:
82EA	F9                  REC                         ; Reset Carry Flag, does nothing drop through

ZONE:
82EB	F9                  REC                         ; Reset Carry Flag, does nothing drop through



;------------------------------------------------------------------------------------------------------------
; MAIN_ENTRY - Called from 82BE, 82C3, 82C7, 82CB, 82CF ***JMP : Uses a calculated jump
; Arguments: XL = INIT=D0, INPUT#=ED,PRINT#=EE, PRINT#2=EF, MERGE=F0
; Outputs:
; RegMod: U, A, X
MAIN_ENTRY:
82EC	FD BE           RIE                             ; Disable interrupts
82EE	E9 78 50 F7     ANI     (OUTSTAT_REG),$F7       ; Clear Bit 3 = DCD
82F2	68 7A           LDI	    UH,$7A                  ; Point U to ARW
82F4	6A 28           LDI	    UL,$28                  ; U = 7A28 = ARW
82F6	B5 E1           LDI	    A,$E1                   ; Intialize $7A28-$7A31 to: 
82F8	61              SIN     U                       ; $E1 $BA $82 $F0 ->
82F9	B5 BA           LDI	    A,$BA                   ; SPU, JMP $82F0
82FB	61              SIN     U                       ; This code segment sets PU to 
82FC	B5 82           LDI	    A,$82                   ; bank in upper half of
82FE	61              SIN     U                       ; the CE-158 ROM
82FF	B5 F0           LDI	    A,$F0                   ; 
8301	2E              STA     (U)                     ; Jumps to $7A28, runs code segment

BRANCH_8302:
8302	BA 7A 28        JMP	    ARW                     ; poked in above, swtiches to HI bank.

;------------------------------------------------------------------------------------------------------------
; Return from High Bank
; 
; Command     Token    VECT   Bank  Command     Token    VECT   Bank
; "CLOAD"     F089    (901B)  Low   "MERGE"     F08F    (901C)  Low
; "CSAVE"     F095    (901A)  Low   "OUTSTAT"   E880    (8334)  Low
; "CONSOLE"   F0B1    (8365)  Low   "PRINT"     F097    (900D)  Low
; "ERN"       F052    (8312)  Low   "PROTOCOL"  E881    (8317)  Low
; "ERL"       F053    (8309)  Low   "RINKEY$"   E85A    (8357)  Low
; "FEED"      F0B0    (9820)  Low   "SPACE$"    F061    (83D8)  Low
; "INPUT"     F091    (8FFF)  Low   "ZONE"      F0B4    (83D8)  Low
; "INSTAT"    E859    (832A)  Low   "INPUT#"    NNNN    (9660)  Low
; "LPRINT"    F0B9    (9056)  Low   "PRINT#"    NNNN    (93D0)  Low
; "LLIST"     F0B8    (901D)  Low   "PRINT#2"   NNNN    (93D4)  Low
 
BACK_FROM_HI_BANK:                                      ; High bank jumps back here for the above commands
8305	FD 81           SIE                             ; X = new address passed from high bank
8307	FD 5E           STX     P                       ; Jump to address by poking program counter ***JMP


;------------------------------------------------------------------------------------------------------------
; ERL - Jumped to from 8307 via High Bank
; 0=No error, >0=Line at which error occured
; Arguments:
; Outputs:
; RegMod:
ERL:
8309	F4 78 B4        VEJ     ($F4),ERR_LINE_H        ; Loads U-Reg with 16-bit value from address of ($78B4) 
830C	4A 6C           LDI     XL,$6C                  ; X = DA6C? Inside BASIC command MEM
830E	48 DA           LDI     XH,$DA                  ; 
8310	8E 51           BCH+	BRANCH_8363             ; Borrows exit of SPACE_STR__ZONE



;------------------------------------------------------------------------------------------------------------
; ERN - Jumped to from 8307 via High Bank
; Error code 0-255
; Arguments:
; Outputs:
; RegMod:
; Branched to via High Bank
ERN:
8312	A5 78 9B        LDA     (ERL)                   ; Load error #, if any, into Accumulator
8315	8E 19           BCH+	BRANCH_8330             ; Borrows exit of SPACE_STR__ZONE (eventually)



;------------------------------------------------------------------------------------------------------------
; PROTOCOL - Jumped to from 8307 via High Bank
; Protocol used in Terminal, XON/XOFF, ECHO
; Arguments:
; Outputs:
; RegMod:
PROTOCOL:
8317	C2 F1 9C 05     VEJ     ($C2),ON,BRANCH_8320    ; If next char not token 'ON' (F1 9C) branch fwd 5, $8320
831B	E9 78 56 7F     ANI	    (ZONE_REG),$7F          ; AND ZONE_REG (&7856) with $7F
831F	E2              VEJ     ($E2)                   ; Start of Basic Interpreter

BRANCH_8320: ;branched to from 8317
8320	C4 F1 9E 05     VEJ     ($C4),OFF,BRANCH_8329    ; If next char not token 'OFF' (F1 9E) branch fwd 5, $8329
8324	E9 78 56 7F     ANI	    (ZONE_REG),$7F          ; AND ZONE_REG (&7856) with $7F
8328	E2              VEJ     ($E2)                   ; Start of Basic Interpreter

BRANCH_8329: ;branched to from 8320
8329	E4              VEJ     ($E4)                   ; Output error 1 and return to the editor



;------------------------------------------------------------------------------------------------------------
; INSTAT - Jumped to from 8307 to via High Bank
; Returns state of RS232 hansshaking signals (0-31)
; Bit4 = DSR, Bit3 = CD, Bit2 = CTS. Bit1 = RTS, Bit0 = DTR
; Arguments:
; Outputs:
; RegMod:
INSTAT:
832A	FD A5 D0 0E     LDA     #(CE158_PRT_A)          ; 
832E	B9 1F           ANI     A,$1F                   ; Clear bits 5-7, Low Battery / 2 of Baud Rate Select Bits

BRANCH_8330: ;branched to from 8315
8330	4A E4	        LDI     XL,$E4                  ;
8332	8E 2C	        BCH+	BRANCH_8360             ; Branch forward unconditional



;------------------------------------------------------------------------------------------------------------
; OUTSTAT - Jumped to from 8307 via High Bank
; Sets state of RS232 hansshaking signals (0-31)
; Bit4 = DSR, Bit3 = CD, Bit2 = CTS. Bit1 = RTS, Bit0 = DTR 
; Arguments:
; Outputs:
; RegMod:
OUTSTAT:
8334	DE 20	        VEJ     ($DE),BRANCH_8356       ; Calc formula Y-reg points to, res to AR-X, Branch fwd to 8356 on error
8336	D0 04 1D	    VEJ     ($D0),$04,BRANCH_8356   ; Convert AR-X to INT send to U, range of 4, branch fwd to 8356 on error
8339	E9 7A 06 03	    ANI	    (ARX + $06),$03         ; keep bits 0-1
833D	A5 78 50	    LDA	    (OUTSTAT_REG)           ;
8340	B9 FC	        ANI     A,$FC                   ; clear bits 0-1, DTR, RTS
8342	AB 7A 06	    ORA     (ARX + $06)             ; 
8345	AE 78 50	    STA 	(OUTSTAT_REG)           ; Sets DTR and RTS from calc in 8334?
8348	FD A5 D0 0E	    LDA     #(CE158_PRT_A)          ; 
834C	B9 FC	        ANI     A,$FC                   ; clear bits 0-1, DTR, RTS
834E	AB 7A 06	    ORA 	(ARX + $06)             ; 
8351	FD AE D0 0E	    STA     #(CE158_PRT_A)          ; Also set DTR/RTS bits on CE-158
8355	E2              VEJ     ($E2)                   ; Start of Basic Interpreter

BRANCH_8356: ; branched to from 8334, 8336
8356	E0	            VEJ     ($E0)                   ; Indicates if UH is not "00" error message



;------------------------------------------------------------------------------------------------------------
; RINKEY$ - Branched to from 8307 via High Bank
; Returns last byte RXd on COM, UART version of INKEY$
; Arguments: 
; Outputs: ASCII code from UART, $00 = no input
; RegMod:
RINKY$:
8357	BE 81 E6	    SJP 	RXCOM                ; Manipulates LPT/UART registers
835A	81 02	        BCR+    BRANCH_835E             ; REC = Success, A = Failure type or UART data read
835C	B5 00	        LDI	    A,$00                   ; 

BRANCH_835E: ; branched to from 835A
835E	4A AD	        LDI     XL,$AD                  ;

BRANCH_8360: ; branched to from 8332
8360	48 D9	        LDI     XH,$D9                  ; X = D9AD, inside INKEY$
8362	2A	            STA     UL                      ;

BRANCH_8363: ;branched to from 8310
8363	8E 97	        BCH+	BRANCH_83FC             ; Branch forward unconditional



;------------------------------------------------------------------------------------------------------------
; CONSOLE - Branched to from 8307 via High Bank
; Specifies #digits per line. Specifies EOL char TXd (default is CR)
; Arguments:
; Outputs:
; RegMod:
CONSOLE:
8365	C8 5F	        VEJ     ($C8),BRANCH_83C6       ; Syntax check: Jump fwd 5F (83C6) if not end of line/sequence 

8367	6A 00	        LDI     UL,$00                  ;
8369	56	            DEC     Y                       ;

BRANCH_836A: ;branched to from 83CD, 83DF, 83D4
836A	A5 79 D1	    LDA	    (OPN)                   ; 79D1 Indicates a basic extension table.
836D	B7 C4	        CPI     A,$C4                   ;
836F	8B 06	        BZS+    BRANCH_8377             ; Branch fwd if A = C4
8371	24	            LDA     UL                      ;
8372	AE 78 51	    STA	    (RS232C)                ; Console 1 RS232C
8375	8E 04	        BCH+	BRANCH_837B             ; Branch unconditional to 837B

BRANCH_8377:  ;branched to from 836F
8377	24 8377	        LDA     UL                      ;
8378	AE 78 52	    STA	    (RS232C_2)              ; Console 1 (//)

BRANCH_837B: ;branched to from 8375
837B	C8 02	        VEJ     ($C8),BRANCH_837F       ; Syntax check: Jump fwd 02 (837F) if not end of line/sequence
837D	56	            DEC     Y                       ; what is Y counting?
837E	E2	            VEJ     ($E2)                   ; Start of Basic Interpreter

BRANCH_837F: ;branched to from 837B
837F	C4 2C 55	    VEJ     ($C4),',',BRANCH_83D7   ; If U-Reg != ',' branch fwd 55 (83D7)
8382	DE 52 	        VEJ     ($DE),BRANCH_83D6       ; Calc formula Y-reg points to, res to AR-X, Branch fwd 52 to 83D6 on error
8384	D0 08 4F	    VEJ     ($D0),$08,BRANCH_83D6   ; Convert AR-X to INT send to U, range of 8, branch fwd 4F to 83D6 on error
8387	68 13	        LDI     UH,$13                  ;
8389	B7 02	        CPI     A,$02                   ; What sets A?
838B	C3 E0	        VCS     ($E0)                   ; If A >= 02 do VEJ (E0) 'Is UH "00" error message'
838D	FD A8	        PSH     U                       ;
838F	C8 06	        VEJ     ($C8),BRANCH_8397       ; Jump fwd 06 (8397) if not end of line/sequence
8391	A4 	            LDA     UH                      ;
8392	56	            DEC     Y                       ;
8393	FD 2A	        POP     U                       ;
8395	8E 0F 	        BCH+    BRANCH_83A6             ; Unconditional forward branch

BRANCH_8397: ;branched to from 838F
8397	C4 2C 3D	    VEJ     ($C4),',',BRANCH_83D7   ; Check tokens/char in U-Reg if not ',' branch fwd 3D (83D7)
839A	DE 3A	        VEJ     ($DE),BRANCH_83D6       ; Calc formula Y-reg points to, res to AR-X, Branch fwd 3A to 83D6 on error
839C	D0 08 37	    VEJ     ($D0),$08,BRANCH_83D6   ; Convert AR-X to INT send to U, range of 8, branch fwd 37 to 83D6 on error
839F	FD 2A 	        POP     U                       ;
83A1	B7 02	        CPI     A,$02                   ;
83A3	C3 E0	        VCS     ($E0)                   ; If A >= 02 do VEJ (E0) 'Is UH "00" error message'
83A5	DD	            INC	    A                       ;

BRANCH_83A6: ;branched to from 8395
83A6	D9	            SHL                             ; Shift A left, A = A * 2
83A7	22	            ADC	    UL                      ; A = A + UL
83A8	2A	            STA	    UL                      ;
83A9	A5 79 D1	    LDA	    (OPN)         ; OPN
83AC	B7 C4	        CPI     A,$C4                   ; What does C4 represent?
83AE	8B 01	        BZS+    BRANCH_83B1             ; If A=(79D1)=C4 branch fwd to 83B1
83B0	F9	            REC                             ; Reset carry flag

BRANCH_83B1: ;branched to from 83AE
83B1	24	            LDA     UL                      ; Branched to if 79D1=C4, carry set if branched
83B2	83 06	        BCS+    BRANCH_83BA             ; Branch fwd if 79D1=C4
83B4	E9 78 55 F8	    ANI     (CRLF_REG),$F8         ; Clear bits 0-2
83B8	8E 05	        BCH+	BRANCH_83BF             ; Branch unconditional fwd

BRANCH_83BA: ;branched to from 83B2
83BA	E9 78 55 8F	    ANI	    (CRLF_REG),$8F         ; clear bits 4,5,6 -           7 x x x 3 2 1 0
83BE	F1	            AEX                             ; Swap high/low nibbles of A - 3 2 1 0 7 x x x

BRANCH_83BF: ;branched to from 83B8                     ; if dropped thru from 83BE 3 2 1 0 7 x x x 
83BF	AB 78 55	    ORA	    (CRLF_REG)             ;                 OR'd with 7 6 5 4 3 2 1 0 
83C2	AE 78 55	    STA	    (CRLF_REG)             ; why?
83C5	E2              VEJ     ($E2)                   ; Start of Basic Interpreter

BRANCH_83C6: ;branched to from 8365 
83C6	C6	            VEJ     ($C6)                   ; DEC Y by 2 for tokens or 1 for characters in U reg
83C7	DE 0D	        VEJ     ($DE),BRANCH_83D6       ; Calc formula Y-reg points to, res to AR-X, Branch fwd 0D to 83D6 on error
83C9	D0 08 0A	    VEJ     ($D0),08,BRANCH_83D6    ; Convert AR-X to INT send to U, range of 8, branch fwd 0A to 83D6 on error
83CC	24	            LDA     UL                      ;
83CD	9B 65	        BZS-    BRANCH_836A             ; If A=UL=0 branch back
83CF	62	            DEC	    UL                      ; If not zero DEC
83D0	6E 0F	        CPI	    UL,$0F                  ; 
83D2	68 13	        LDI	    UH,$13                  ; 
83D4	93 6C	        BCS-    BRANCH_836A             ; If UL >=0f Branch back

BRANCH_83D6: ;branched to from 8382, 8384, 839A, 839C, 83C7, 83C9
83D6	E0	            VEJ     ($E0)                   ; Indicates if UH is not "00" error message

BRANCH_83D7: ;branched to from 837F, 8397
83D7	E4	            VEJ     ($E4)                   ; Output error 1 and return to the editor



;------------------------------------------------------------------------------------------------------------
; SPACE_STR__ZONE - Branched to from 8307 via High Bank, ***JMP : Uses a calculated jump
; SPACE$ arg : (0-32d) Number of spaces
; ZONE arg   : (1-31d) Determine the block length of comma seperate data sent over COM with LPRINT
; Arguments  : XREG = Address, YREG = Token, AR-X is argument after command
; Outputs:
; RegMod:
SPACE_STR__ZONE:
83D8	D0 08 1D	    VEJ     ($D0),$08,BRANCH_83F8   ; Convert AR-X to INT send to U, range of 8, branch fwd 83F8 on error
83DB	6E 21	        CPI	    UL,$21                  ;
83DD	68 19	        LDI	    UH,$19                  ; U = 1921
83DF	83 17 	        BCS+    BRANCH_83F8             ; If UL >= 33d branch fwd, out of range
83E1	4A 08	        LDI	    XL,$08                  ;
83E3	48 7A	        LDI	    XH,$7A                  ; X=7A08, ARZ
83E5	24	            LDA     UL                      ; UL is command's argument
83E6	8B 0A 	        BZS+    BRANCH_83F2             ; If argument=0 branch fwd
83E8	28	            STA	    UH                      ; UH = argument (1-31d)
83E9	62	            DEC	    UL                      ; UL = argument - 1 (0-30d)
83EA	B5 20	        LDI	    A,$20                   ; ASCII for space

BRANCH_83EC: ;branched to from 83ED                     ; Fills AR-Z with arg# of spaces
83EC	41	            SIN     X                       ; (X) = A. Then X = X + 1. Copies A to (X) to (X + UL)
83ED	88 03	        LOP 	UL,BRANCH_83EC          ; UL = UL - 1, loop back 'e' if Borrow Flag not set
83EF	4A 08	        LDI	    XL,$08                  ; X = 7A08
83F1	A4	            LDA 	UH                      ; A = UH = argument

BRANCH_83F2: ;branched to from 83E6                     ; Branch here if is argument = 0
83F2	BE DF A1 02	    SJP	    XREG2STRBUF,BRANCH_83F8 ; X points to string to insert into String buffer. UL = #of chars
                                                        ; Jump if overflow
83F6	68 00	        LDI	    UH,$00                  ;

BRANCH_83F8: ;branched to from 83D8, 83DF, 83F2         ; Branched to if argument out of range
83F8	48 80 83F8	    LDI	    XH,$80                  ; Setting the destination address for 840A
83FA	4A 13	        LDI	    XL,$13                  ; X=8013

BRANCH_83FC: ;branched to from 8363 RINKY$
83FC	B5 38	        LDI 	A,$38                   ; Is this finding if this is OUTSTAT or CR/LF command?
83FE	ED 78 50 08	    BII	    (OUTSTAT_REG),$08       ; Keep Bit3, DCD
8402	8B 06           BZS+    BRANCH_840A             ; If Bit3 was not set
8404	B5 E1           LDI 	A,$E1                   ; 
8406	EB 78 55 08     ORI	    (CRLF_REG),$08         ; Set Bit3 in (CR/LF)

BRANCH_840A:
840A	AE 7A 30        STA	    (ARS)                   ; Store A, (38) NOP or (E1) SPU to AR-S
840D	B5 24           LDI	    A,$24                   ; SPU swtiches to High Bank of ROM
840F	AE 7A 31        STA	    (ARS + $01)             ; next opcode, UL is argument of command
8412	B5 FD           LDI     A,$FD                   ; then: (24)      LDA UL
8414	AE 7A 32        STA	    (ARS + $02)             ;       (FD 5E)   STX P ***JMP
8417	B5 5E           LDI	    A,$5E                   ; Which saves X-Reg (8013) to PC (X set in 83F8)
8419	AE 7A 33        STA	    (ARS + $03)             ; i.e. this is destination address
841C	BA 7A 30        JMP	    ARS                     ; X = 8013 == B_TBL_8000_JMPS, low ROM is just (9A) RET
841F	F8              VEJ     ($F8)                   ; High ROM has: (BA 79 FA 9A) JMP 79FA, RET



;------------------------------------------------------------------------------------------------------------
; TABLE_8420
; Seems like nonsense, does not appear to be used
TABLE_8420:
8420	40 7F 00 FF 00 FF 40 77   00 7F 00 FF 00 FF 0B F7 
8430	4A 7D 00 FF 00 FF 43 DF   02 27 00 FF 00 FF 06 F7 
8440	26 FD 00 FF 00 FF 08 BF   45 EA 00 FF 00 FF 11 FF 
8450	12 FF 00 FF 00 FF 01 DE   10 5A 00 FF 00 FF 11 F2 
8460	80 FD 00 FF 00 FF 22 7D   92 EB 00 FF 00 FF 00 4F 
8470	94 3D 00 FF 00 FF 03 D6   42 AE 00 FF 00 FF 46 FE 
8480	38 EF 00 FF 00 FF 86 DF   A0 BF 00 FF 00 FF 00 FF 
8490	42 FF 00 FF 00 FF 00 8B   03 F5 00 FF 00 FF 10 FF 
84A0	17 B2 00 FF 00 FF 08 FF   48 9D 00 FF 00 FF 03 FD 
84B0	12 F7 00 FF 00 FF D0 DF   00 AF 00 FF 00 FF 08 DD 
84C0	80 7D 00 FF 00 FF 04 7F   0A BB 00 FF 00 FF 00 EF 
84D0	40 FE 00 FF 00 FF 14 7B   00 E6 00 FF 00 FF 04 4F 
84E0	22 39 00 FF 00 FF 00 7D   55 6D 00 FF 00 FF 34 9D 
84F0	10 DF 00 FF 00 FF 65 AD   60 DF 00 FF 00 FF 02 DF 
8500	28 FF 00 FF 00 FF 42 D6   01 EE 00 FF 00 FF 94 F4 
8510	82 FC 00 FF 00 FF 27 7C   08 BF 00 FF 00 FF 46 DF 
8520	0D 33 00 FF 00 FF 02 CF   19 FC 00 FF 00 FF 10 FD 
8530	00 E9 00 FF 00 FF 58 DB   1A FF 00 FF 00 FF 44 FB 
8540	31 EF 00 FF 00 FF 80 E7   00 7C 00 FF 00 FF 80 EF 
8550	C8 DF 00 FF 00 FF 00 7F   58 FB 00 FF 00 FF 01 77 
8560	22 78 00 FF 00 FF 28 FF   84 F3 00 FF 00 FF 90 F2 
8570	64 FF 00 FF 00 FF 91 FF   16 FF 00 FF 00 FF F0 BF 
8580	58 B5 00 FF 00 FF 14 7A   21 7F 00 FF 00 FF 00 DF 
8590	12 FF 00 FF 00 FF 30 FB   11 AF 00 FF 00 FF 32 FE 
85A0	C4 FE 00 FF 00 FF 39 DF   CA FF 00 FF 00 FF C4 DD 
85B0	91 BF 00 FF 00 FF 02 FC   62 BB 00 FF 00 FF 21 FF 
85C0	00 CF 00 FF 00 FF 10 96   00 CF 00 FF 00 FF 00 F7 
85D0	44 F5 00 FF 00 FF 04 FC   5C ED 00 FF 00 FF 18 7F 
85E0	00 BD 00 FF 00 FF 88 FF   61 DE 00 FF 00 FF 00 DD 
85F0	B8 B6 00 FF 00 FF 02 EF   4A FF 00 FF 00 FF 0A AE 
8600	E1 B8 00 FF 00 FF 22 AB   10 3F 00 FF 00 FF 2A F6 
8610	48 FF 00 FF 00 FF 2D EF   86 E3 00 FB 00 FF 0A FB 
8620	59 73 00 FF 00 FF 31 8B   90 D5 00 FF 00 FF 49 BD 
8630	01 FA 00 FF 00 FF 90 9E   80 5F 00 FF 00 FF 04 F5 
8640	00 7F 00 FF 00 FF 30 B6   10 FB 00 FF 00 FF 38 F7 
8650	01 A7 00 FF 00 FF 81 5F   01 EA 00 FF 00 FF 03 F6 
8660	60 ED 00 FF 00 FF 04 FB   21 F7 00 FF 00 FF 84 FF 
8670	10 DF 00 FF 00 FF 20 F3   08 BF 00 FF 00 FF 32 7D 
8680	04 FF 00 FF 00 FF 29 ED   E5 5E 00 FF 00 FF 2D DF 
8690	29 EE 00 FF 00 FF 30 5F   20 BF 00 FF 00 FF 00 EB 
86A0	00 ED 00 FF 00 FF A0 FF   00 7F 00 FF 00 FF 42 FF 
86B0	3A 7E 00 FF 00 FF 22 7F   50 FD 00 FF 00 FF 04 7A 
86C0	20 FE 00 FF 00 FF 51 DF   86 FF 00 FF 00 FF 10 FF 
86D0	05 37 00 FF 00 FF 04 87   D0 BF 00 FF 00 FF 08 85 
86E0	28 5E 00 FF 00 FF 41 DF   94 57 00 FF 00 FF 00 E7 
86F0	4A EF 00 FF 00 FF 02 7F   05 FD 00 FF 00 FF 00 E7 
8700	10 00 00 D3 00 7F 02 00   10 00 00 F9 00 EF 12 00 
8710	D8 00 00 5B 00 7F A4 00   80 00 00 7F 00 B5 09 00 
8720	08 00 00 EC 00 87 8C 00   05 00 00 FD 00 F5 01 00 
8730	D8 00 00 5D 00 7B 16 00   00 12 00 26 00 4F 80 00 
8740	00 00 00 F7 00 FF D1 00   85 00 00 BF 00 3F 22 40 
8750	02 00 00 FD 00 C9 84 00   C0 00 00 BF 00 74 00 00 
8760	80 00 00 E6 00 FF 30 00   A0 20 00 B5 00 E2 38 00 
8770	C0 00 00 FB 00 EE 20 00   B0 00 00 FC 00 FC 10 24 
8780	A0 00 00 3F 00 FD 00 00   01 02 00 FD 00 79 E0 00 
8790	C8 00 00 93 00 23 E0 00   1D 00 00 F7 00 6B 00 00 
87A0	80 00 00 FD 00 FF 98 00   18 00 00 EB 00 4E 42 00 
87B0	08 00 00 FE 00 EF 05 00   11 00 00 6B 00 FB 08 00 
87C0	41 00 00 FB 00 FC 00 04   10 04 00 FE 00 FF 22 00 
87D0	80 20 00 EF 00 E7 02 80   10 00 00 FC 00 FB C0 40 
87E0	20 00 00 AF 00 2F 4A 00   C0 00 00 FF 00 B1 00 00 
87F0	20 40 00 BF 00 BF 61 00   04 00 00 77 00 FF 0C 00 



;------------------------------------------------------------------------------------------------------------
; BASIC Command Table 8800
;------------------------------------------------------------------------------------------------------------
B_TBL_8800:
8800	55                  .BYTE   $55                 ; Marker that BASIC Table follows  

B_TBL_8800_TNUM:
8801	09                  .BYTE   $08                 ; Table number 

B_TBL_8800_NAME:
8802	43 4F 4D 0D         .TEXT   "LPRT\r\r\r\r"      ; Table name
8806    0D 0D 0D 0D 

B_TBL_8800_INIT:
880A    68 01               LDI     UH,$01              ; Table initilization vector
880C    9A                  RTN

B_TBL_8800_INPUT#:
880D	68 1B               LDI	    UH,$1B              ; Table INPUT# vector (Jumps to MERGE)
880F    E0                  VEJ     ($E0)               ; Is UH "00" error message

B_TBL_8800_PRINT#:
8810	BA 82 CD            JMP	    $82CD               ; Table PRINT# vector (Jumps to MERGE)

B_TBL_8800_JMPS:
8813	9A 9A 9A 9A         .BYTE $9A, $9A, $FA, $9A    ; 
8017    9A 9A 9A 9A         .BYTE $9A, $9A, $9A, $9A    ;
8821    9A BA               .BYTE $9A, $BA              ; Unused jumps

B_TBL_8800_TRACE:
881D	C4 AF FF            VEJ     ($C4),$AF,$811F     ; Correct per book. Not used?

B_TBL_8800_A_KW:
8820	00 00               .BYTE   $00, $00            ; 

B_TBL_8800_B_KW:
8822	00 00               .BYTE   $00, $00            ; 

B_TBL_8800_C_KW:
8824	88 56               .BYTE   $88, $56            ; 8856 

B_TBL_8800_D_KW:
8826	00 00               .BYTE   $00, $00            ; 

B_TBL_8800_E_KW:
8828	00 00               .BYTE   $00, $00            ; 

B_TBL_8800_F_KW:
882A	88 62               .BYTE   $88, $62            ; 8862

B_TBL_8800_G_KW:
882C	00 00               .BYTE   $00, $00            ; 

B_TBL_8800_H_KW:
882E	00 00               .BYTE   $00, $00            ; 

B_TBL_8800_I_KW:
8830	00 00               .BYTE   $00, $00            ; 

B_TBL_8800_J_KW:
8832	00 00               .BYTE   $00, $00            ; 

B_TBL_8800_K_KW:
8834	00 00               .BYTE   $00, $00            ; 

B_TBL_8800_L_KW:
8836	88 6B               .BYTE   $88, $6B            ; 886B

B_TBL_8800_M_KW:
8838	00 00               .BYTE   $00, $00            ; 

B_TBL_8800_N_KW:
883A	00 00               .BYTE   $00, $00            ; 

B_TBL_8800_O_KW:
883C	00 00               .BYTE   $00, $00            ;

B_TBL_8800_P_KW:
883E	00 00               .BYTE   $00, $00            ; 

B_TBL_8800_Q_KW:
8840	00 00               .BYTE   $00, $00            ; 

B_TBL_8800_R_KW:
8842	00 00               .BYTE   $00, $00            ; 

B_TBL_8800_S_KW:
8844	00 00               .BYTE   $00, $00            ; 

B_TBL_8800_T_KW:
8846	88 80               .BYTE   $88, $80            ; 8880

B_TBL_8800_U_KW:
8848	00 00               .BYTE   $00, $00            ; 

B_TBL_8800_V_KW:
884A	00 00               .BYTE   $00, $00            ; 

B_TBL_8800_W_KW:
884C	00 00               .BYTE   $00, $00            ; 

B_TBL_8800_X_KW:
884E	00 00               .BYTE   $00, $00            ;  

B_TBL_8800_Y_KW:
8850	00 00               .BYTE   $00, $00            ;  

B_TBL_8800_Z_KW:
8852	00 00               .BYTE   $00, $00            ;  

B_TBL_8800_CMD_LST:   ; Token   Address
8854	$D7 "CONSOLE"      $F0B1 $82D8                  ; 82D8
8860	$D4 "FEED"         $F0B0 $82D9                  ; 82D9 
8869	$D6 "LPRINT"       $F0B9 $82DA                  ; 82DA 
8874	$C5 "LLIST"        $F0B8 $82DB                  ; 82DB 
887E	$D3 "TAB"          $F0BB $880D                  ; 880D 


B_TBL_8800_CMD_LST_END:
8886	D0                .BYTE $D0                     ; Why two D0s here and one in 8000 command list?


;------------------------------------------------------------------------------------------------------------
; TABLE_8887
; Seems like nonsense that is not used
TABLE_8887:
8887	D0 00 FF 00 FF 00 FF 04   FD 90 FD 00 FF 00 FF 00 
8897	FD 82 FF 00 FF 00 FF A0   EF 10 6F 00 FF 00 FF 00 
88A7	DF 04 FF 00 FF 00 FF 82   FE 82 F7 00 FF 00 FF 04 
88B7	FF 20 FF 00 FF 00 FF 00   BF 23 C7 00 FF 00 FF 00 
88C7	FB 12 EE 00 FF 00 FF 28   FB 00 AA 00 FF 00 FF 00 
88D7	77 A8 9F 00 FF 00 FF 40   D9 14 FF 00 FF 00 FF 60 
88E7	FF 00 EF 00 FF 00 FF 08   BF E0 FF 00 FF 00 FF 20 
88F7	FF 04 FF 00 FF 00 FF 0C   EF 41 EF 00 FF 00 FF 42 
8907	F7 4D FF 00 FF 00 FF 24   B7 04 FE 00 FF 00 FF 00 
8917	FF A3 7E 00 FF 00 FF 80   EE 04 D6 00 FF 00 FF 98 
8927	DF 81 FB 00 FF 00 FF 04   43 10 7C 00 FF 00 FF 0A 
8937	FF 16 E6 00 FF 00 FF 06   FB 80 BF 00 FF 00 FF 2A 
8947	27 44 BF 00 FF 00 FF 02   DA 32 7F 00 FF 00 FF 01 
8957	7A 5C FF 00 FF 00 FF 2C   3E 80 83 00 FF 00 FF 80 
8967	FC 21 EB 00 FF 00 FF 05   DF 40 4B 00 FF 00 FF 00 
8977	DF 11 7F 00 FF 00 FF 47   EF 14 BF 00 FF 00 FF 01 
8987	5B A4 1B 00 FF 00 FF 02   FE C0 EE 00 FF 00 FF 01 
8997	6F 18 BB 00 FF 00 FF A8   7E 00 67 00 FF 00 FF 00 
89A7	EF 00 FE 00 FF 00 FF 00   BB 08 FF 00 FF 00 FF 25 
89B7	EF 08 DE 00 FF 00 FF 41   FF 80 D7 00 FF 00 FF 0E 
89C7	DB 08 FE 00 FF 00 FF 00   F3 28 7F 00 FF 00 FF 51 
89D7	FF 00 BB 00 FF 00 FF 90   F7 C1 B7 00 FF 00 FF A1 
89E7	CF 12 E6 00 FF 00 FF 40   77 00 FF 00 FF 00 FF 29 
89F7	BB 10 EB 00 FF 00 FF 46   F7 08 1B 00 FF 00 FF 09 
8A07	7E 9C 7A 00 FF 00 FF 83   BE 92 FF 00 FF 00 FF 0A 
8A17	DF 05 F7 00 FF 00 FF A1   B9 46 F9 00 FF 00 FF 07 
8A27	DD 11 FF 00 FF 00 FF 4B   F7 C1 FF 00 FF 00 FF 04 
8A37	25 02 FF 00 FF 00 FF A0   FF 41 F7 00 FF 00 FF 84 
8A47	FA 4A 9C 00 FF 00 FF 48   BF 10 AF 00 FF 00 FF 06 
8A57	FF 00 EB 00 FF 00 FF 02   FE A1 DB 00 FF 00 FF 2A 
8A67	BF 82 FE 00 FF 00 FF 00   F7 80 1F 00 FF 00 FF 20 
8A77	FF 18 76 00 FF 00 FF 05   CD 00 9E 00 FF 00 FF 01 
8A87	E9 D0 FF 00 FF 00 FF 80   FF 28 9D 00 FF 00 FF 04 
8A97	EE C0 DF 00 FF 00 FF 2D   F7 5C 1D 00 FF 00 FF 01 
8AA7	DA 70 E3 00 FF 00 FF 42   EF 80 AF 00 FF 00 FF 00 
8AB7	8B 00 FF 00 FF 00 FF 00   FD A9 F7 00 FF 00 FF 02 
8AC7	BE 8D BF 00 FF 00 FF 09   FF 43 FF 00 FF 00 FF 00 
8AD7	FF 84 FF 00 FF 00 FF 40   E6 10 D7 00 FF 00 FF 70 
8AE7	BD 60 4F 00 FF 00 FF 0A   33 07 FF 00 FF 00 FF 09 
8AF7	FA 82 FD 00 FF 00 FF 00   1F 80 FF 00 FF 00 FF 12 
8B07	FD 39 B5 00 FF 00 FF 00   17 BB FC 00 FF 00 FF 09 
8B17	F7 00 CE 00 FF 00 FF EA   69 1C 66 00 FF 00 FF 00 
8B27	9E 83 CB 00 FF 00 FF A0   F7 01 1F 00 FF 00 FF 29 
8B37	FD 84 BF 00 FF 00 FF 80   F3 84 FA 00 FF 00 FF 00 
8B47	FF 84 7B 00 FF 00 FF 0C   ED E0 F7 00 FF 00 FF A2 
8B57	AF AC EB 00 FF 00 FF 81   F4 8A 4E 00 FF 00 FF 00 
8B67	FF 00 FA 00 FF 00 FF 03   CE A0 FF 00 FF 00 FF 14 
8B77	FD C2 7D 00 FF 00 FF 04   FD 00 FF 00 FF 00 FF C0 
8B87	FE 04 E4 00 FF 00 FF B8   BF 14 EF 00 FF 00 FF 40 
8B97	FF 81 FF 00 FF 00 FF 08   FE 22 BF 00 FF 00 FF 04 
8BA7	79 A1 F7 00 FF 00 FF 00   ED 55 F1 00 FF 00 FF C8 
8BB7	BF 88 CD 00 FF 00 FF 00   FF 04 7F 00 FF 00 FF 10 
8BC7	FF 04 BB 00 FF 00 FF 21   87 00 FF 00 FF 00 FF 00 
8BD7	EF 00 FB 00 FF 00 FF 80   F7 28 EB 00 FF 00 FF 20 
8BE7	3F 18 B3 00 FF 00 FF 48   67 08 FF 00 FF 00 FF 0E 
8BF7	D9 8B 7D 00 FF 00 FF 08   F7 44 FE 00 FF 00 FF 18 
8C07	8C 8C F5 00 FF 00 FF 90   DD 80 F1 00 FF 00 FF 41 
8C17	FF 20 F7 00 FF 00 FF 00   EB C2 CF 00 FF 00 FF 00 
8C27	B7 03 CF 00 FF 00 FF 48   FD 80 FF 00 FF 00 FF 20 
8C37	FD 68 E7 00 FF 00 FF 03   77 46 D7 00 FF 00 FF 07 
8C47	ED 30 F8 00 FF 00 FF 18   EE 04 3F 00 FF 00 FF 24 
8C57	E6 01 F5 00 FF 00 FF 20   7D 01 FD 00 FF 00 FF 00 
8C67	E3 00 F7 00 FF 00 FF 10   FF 41 5F 00 FF 00 FF 09 
8C77	9B 1E 66 00 FF 00 FF 02   C7 02 13 00 FF 00 FF 02 
8C87	FE 80 67 00 FF 00 FF 11   1B C0 FC 00 FF 00 FF 08 
8C97	BE 20 E6 00 FF 00 FF 00   FF 21 F7 00 FF 00 FF 28 
8CA7	FF 14 BB 00 FF 00 FF 40   FF 13 ED 00 FF 00 FF 80 
8CB7	C6 60 FF 00 FF 00 FF 01   FE 16 FF 00 FF 00 FF 00 
8CC7	7F 40 F8 00 FF 00 FF 01   BA 00 DF 00 FF 00 FF 04 
8CD7	FE C9 6B 00 FF 00 FF A0   EF 09 9E 00 FF 00 FF C0 
8CE7	FF 0A FF 00 FF 00 FF 08   5B 02 3F 00 FF 00 FF 8C 
8CF7	FD 20 75 00 FF 00 FF 0E   F7 50 FF 00 FF 00 FF 74 
8D07	F5 10 66 00 FF 00 FF 80   B6 48 DF 00 FF 00 FF 30 
8D17	FD 48 BF 00 FF 00 FF 14   FA 02 86 00 FF 00 FF 05 
8D27	7B 00 5F 00 FF 00 FF A4   FF 20 FB 00 FF 00 FF 61 
8D37	FF 95 76 00 FF 00 FF 00   3F 06 FA 00 FF 00 FF 04 
8D47	BF 00 F7 00 FF 00 FF 40   FF 92 F7 00 FF 00 FF 04 
8D57	EF 80 FD 00 FF 00 FF 02   FD 05 FE 00 FF 00 FF 08 
8D67	FF 80 76 00 FF 00 FF 05   F7 30 2F 00 FF 00 FF 08 
8D77	FF 01 EE 00 FF 00 FF 52   FF 02 C7 00 FF 00 FF 91 
8D87	E7 00 FD 00 FF 00 FF 44   77 40 FF 00 FF 00 FF 00 
8D97	FD B8 FF 00 FF 00 FF 00   DF 5A FF 00 FF 00 FF 84 
8DA7	FA 43 EF 00 FF 00 FF 94   96 00 FE 00 FF 00 FF 50 
8DB7	FB 04 FF 00 FF 00 FF 26   BF C9 FC 00 FF 00 FF 00 
8DC7	FF 80 BF 00 FF 00 FF 80   FF A0 BB 00 FF 00 FF 0C 
8DD7	B9 04 FB 00 FF 00 FF 05   B9 44 EF 00 FF 00 FF 00 
8DE7	FF 00 7D 00 FF 00 FF 00   BE 41 BB 00 FF 00 FF 10 
8DF7	FF 00 7D 00 FF 00 FF 14   EF AA 7F 00 FF 00 FF C0 
8E07	66 0C F2 00 FF 00 FF 40   FF 28 3D 00 FF 00 FF 40 
8E17	FD 48 FF 00 FF 00 FF 47   F7 08 FF 00 FF 00 FF 00 
8E27	FF 2A FE 00 FF 00 FF 41   A7 15 7E 00 FF 00 FF 62 
8E37	BF C0 FD 00 FF 00 FF 00   FD 26 5F 00 FF 00 FF 00 
8E47	FE 80 FC 00 FF 00 FF 28   BF 08 FF 00 FF 00 FF 46 
8E57	1E 20 CB 00 FF 00 FF 22   EF 20 B5 00 FF 00 FF 03 
8E67	E3 08 1E 00 FF 00 FF 0A   FB 07 FE 00 FF 00 FF 25 
8E77	F7 07 DF 00 FF 00 FF 04   6F 02 FE 00 FF 00 FF 18 
8E87	FF CC BF 00 FF 00 FF 23   7D 18 FF 00 FF 00 FF 18 
8E97	9E 02 3F 00 FF 00 FF C0   FD 50 7A 00 FF 00 FF 00 
8EA7	BD 18 FF 00 FF 00 FF 08   FD 04 FE 00 FF 00 FF 20 
8EB7	DF 44 FE 00 FF 00 FF 02   FF 02 FD 00 FF 00 FF 00 
8EC7	FF 00 DD 00 FF 00 FF 9C   BF 4C 5F 00 FF 00 FF 00 
8ED7	EF 18 FB 00 FF 00 FF A0   53 A0 DF 00 FF 00 FF 34 
8EE7	77 80 F3 00 FF 00 FF 04   EF 13 FD 00 FF 00 FF 05 
8EF7	BF 82 FE 00 FF 00 FF 00   7E 87 00 00 FF 00 DD 4B 
8F07	00 00 00 00 BF 00 7F 81   00 11 80 00 FF 00 EF 00 
8F17	40 21 04 00 FF 00 FF 0E   00 21 00 00 FF 00 FF 09 
8F27	00 80 00 00 F7 00 DF 18   00 41 00 00 FF 00 F7 25 
8F37	00 31 00 00 BB 00 DF 82   00 A8 00 00 FF 00 FF 01 
8F47	00 10 00 00 BF 00 FF 40   00 24 10 00 FF 00 6F 84 
8F57	00 80 00 00 7F 00 EF C4   00 18 00 00 FF 00 FB 28 
8F67	00 40 00 00 FF 00 B7 24   00 10 00 00 D7 00 FF B0
8F77	00 26 00 00 EF 00 3F 00   00 10 00 00 FF 00 FF 10 
8F87	00 18 00 00 FF 00 A3 04   00 06 08 00 FF 00 FF 80 
8F97	00 80 00 00 E5 00 7B 20   00 82 00 00 7F 00 7F 00 
8FA7	00 04 00 00 FF 00 FF 80   00 C0 00 00 A7 00 FF 30 
8FB7	00 2A 02 00 FF 00 7F 90   00 00 02 00 B7 00 FF 42 
8FC7	04 26 00 00 F7 00 FF 24   00 28 04 00 7F 00 FF 10 
8FD7	00 03 00 00 FF 00 FD 00   00 18 00 00 FE 00 9B 03 
8FE7	00 00 00 00 67 00 EF 44   00 0B 00 00 FF 00 DF C0 
8FF7	00 00 00 00 3F 00 F9 C5



;------------------------------------------------------------------------------------------------------------
; INPUT - Jumped to from 8307 via High Bank
; Arguments: X-REG address of function, Y-REG Token
; Output:
; RegMod:
INPUT:
8FFF    C2 23 23          VEJ       ($C2),'#',BRANCH_9025       ; If not an INPUT# skip ahead
9002    B5 84             LDI       A,$84                       ;
9004    AE 78 79          STA       (CASS_FLAG)                 ;
9007    C2 2D 1A          VEJ       ($C2),'-',BRANCH_9024       ; If not '-' skip ahead

BRANCH_900A:
900A    BA E4 F6          JMP       (BCMD_PRINT + $0B)          ; Inside BASIC PRINT command



;------------------------------------------------------------------------------------------------------------
; PRINT - Jumped to from 8307 via High Bank
; Arguments: X-REG address of function, Y-REG Token
; Outputs:
; RegMod:
PRINT:
900D	C2 23 12          VEJ       (C2),'#',BRANCH_9022        ; If not a PRINT# skip ahead
9010	B5 04             LDI	    A,$04                       ;
9012	AE 78 79          STA	    (CASS_FLAG)                 ;
9015	C2 2D 0B          VEJ       (C2),'-',BRANCH_9023        ; If not '-' skip ahead
9018	9E 10             BCH-	    BRANCH_900A                 ;



;------------------------------------------------------------------------------------------------------------
; CSAVE - Branched to from 8307 via High Bank
; Arguments: X-REG address of function, Y-REG Token
; Outputs:
; RegMod:
CSAVE:
901A	F9                REC                                   ; Reset Carry



;------------------------------------------------------------------------------------------------------------
; CLOAD - Jumpedto from 8307 via High Bank
; Arguments: X-REG address of function, Y-REG Token
; Outputs:
; RegMod:
CLOAD:
901B	F9                REC                                   ; Reset Carry



;------------------------------------------------------------------------------------------------------------
; MERGE - Jumped to from 8307 via High Bank
; Arguments: X-REG address of function, Y-REG Token
; Outputs:
; RegMod:
MERGE:
901C	F9                REC                                   ; Reset Carry



;------------------------------------------------------------------------------------------------------------
; LLIST - Jumped to from 8307 via High Bank ***JMP - Does a calcualted jump
; Arguments: X-REG address of function, Y-REG Token
; Outputs:
; RegMod:
LLIST: ; branched to from 905C, 905F (LPRINT X=9056, LLIST X=901D)
901D	C0                VEJ       ($C0)                       ; Load next character/token to U-Reg
901E	B5 04             LDI	    A,$04                       ; X = X + A + Carry
9020	FD CA             ADR	    X                           ; LLIST=901D+04=9021, LPRINT=9018+04=901C, LPRINT=9019+04=901D
                                                                ; CSAVE=901A+04=901E,  CLOAD=901B+04=901F,  MERGE=901C+04=9020

BRANCH_9022: ; branched to from 900D (PRINT X=9010)
9022	F9                REC                                   ; Reset Carry

BRANCH_9023: ; branched to from 9015 (PRINT X=9018)
9023	F9                REC                                   ; Reset Carry

BRANCH_9024: ; branched to from 9007 (INPUT X=900A)
9024	F9                REC                                   ; Reset Carry

BRANCH_9025: ; branched to from 8FFF (INPUT X=9002)
9025	C6                VEJ       ($C6)                       ; DEC Y-Reg by 2 for tokens or 1 for chars in U-Reg
9026	04                LDA	    XL                          ; XL is low byte of Command address
9027	FD C8             PSH	    A                           ; Original LB of X-REG
9029	6A 09             LDI	    UL,$09                      ; Loop counter
902B	68 7A             LDI	    UH,$7A                      ; U = 7A09 (ARZ + $01)
902D	4A 6A             LDI	    XL,$6A                      ; XH = HB of command, XL=6A 
                                                                
BRANCH_902F: ; branched to from 9031                            ; LLIST 906A=5E FD E0 C9 1B 68 28 FD 3C CD
                                                                ; copied backwards 7A00-7A08, LPRINT 906A, **PRINT 906A, INPUT 8F6A**
902F	47                LDE	    (X)                         ; A = (X) then X = X - 1
9030	2E                STA	    (U)                         ;
9031	88 04             LOP	    UL,BRANCH_902F              ; UL = UL - 1, loop back 'e' if Borrow Flag not set
9033	FD 8A             POP	    A                           ; A = original low byte of command before $902F
9035	FB                SEC                                   ; Set carry flag
9036	B1 1C             SBI	    A,$1C                       ; LLIST  21-1C=05 C=1 -> LLIST  05<<3=28 C=0, MERGE  20-1C=## C=# -> MERGE  ##<<3=## C=#
9038	D9                SHL                                   ; LPRINT 1C-1C=00 C=1 -> LPRINT 00<<3=00 C=0, LPRINT 1D-1C=01 C=1 -> LPRINT 01<<3=08 C=0
9039	D9                SHL                                   ; CSAVE  1E-1C=## C=# -> CSAVE  ##<<3=#  C=#, CLOAD  1F-1C=## C=# -> CLOAD  ##<<3=# C=#
903A	D9                SHL                                   ; PRINT  10-1C=## C=# -> PRINT  ##<<3=#  C=#, PRINT  18-1C=## C=# -> PRINT  ##<<3=# C=#
903B	4A 6B             LDI	    XL,$6B                      ; INPUT  0A-1C=## C=# -> INPUT  ##<<3=#  C=#, INPUT  02-1C=## C=# -> INPUT  ##<<3=# C=#
903D	FD CA             ADR	    X                           ; LLIST 9093 C=0, LPRINT(1C) 906B C=0, LPRINT(1D) 9073 C=0
903F	45                LIN	    (X)                         ; LLIST A=4 -> X=9094, A = (X) then INC X
9040	A9 78 57          AND	    (SETDEV_REG)                ; Clear bits based on A. A = A & X
                                                                ; KI = 01, DO = 02, PO = 04, CI = 08, CO = 10

9043	8B 09             BZS+      BRANCH_904E                 ; 1st byte in table does not match SETDEV mode
9045	BE 93 CB          SJP	    BRANCH_93CB                 ; Compares C0 to (OPN)
9048	AE 7B 9E          STA	    (OUT_BUF + $3E)             ; A=C0, set in BRANCH_93CB, (79BE) in OUTPUT_BUFFER
904B	44                INC	    X                           ; skip three bytes in table if in SETDEV mode
904C	44                INC	    X                           ; use 1st three bytes if mode does not match
904D	44                INC	    X                           ; yse 2nd three bytes if mode does match

BRANCH_904E: ; branched to from 9043
904E	45                LIN	    (X)                         ; A = (X) then INC X
904F	28                STA	    UH                          ;
9050	45                LIN	    (X)                         ; A = (X) then INC X
9051	2A                STA	    UL                          ; LLIST U=B754, CE-150 LLIST function
9052	05                LDA	    (X)                         ; A = 58
9053	BA 7A 00          JMP	    ARX                         ; ***JMP to what was poked in to ARX by $902F



;------------------------------------------------------------------------------------------------------------
; LPRINT - Jumped to from 8307 via High Bank
; Arguments: XREG = Address, YREG = Token,
; Outputs:
; RegMod:
LPRINT:
9056	4A 18             LDI	    XL,$18                      ; X=$9018
9058	ED 78 56 40       BII	    (ZONE_REG),$40              ; Test for bit 6 set
905C	9B 41             BZS-      LLIST                       ; If Bit 6 not set branch to LLIST, bit indicates?
905E	40                INC	    XL                          ; XL = $19, X=$9019
905F	9E 44             BCH-      LLIST                       ; Unconditional Branch to LLIST


;-----------------------------------------------------------------------------------------------------------
; TABLE_9061 - Used by $902F
; Code copied reverse order to 7A09->00 
TABLE_9061:
9061	CD 3C FD 28 68 1B C9 E0  FD 5E                          ; 
;7A00   5E FD           CPI         YL,FD                       ; Maybe looking for token in Y? Why would FD be low byte?
;7A02   E0              VEJ         (E0)                        ; Display error message from UH?
;7A03   C9 1B           VZR         (1B)                        ; If Z=0, CALL (FF1B)
;7A05   68 28           LDI         UH,28                       ; UH=28
;7A07   FD 3C CD        VCS#        (CD)                        ; If C=1 CALL (FFCD)



;-----------------------------------------------------------------------------------------------------------
; TABLE_906B - Used by 903F
TABLE_906B:
906B    04 B2 F4 58 93 DE C0 00                                 ; Byte 0 is SETDEV mode mask
9073	04 B2 EC 58 93 DE C0 00                                 ; Byte 1 -> UH
907B    10 B8 A6 5C 90 BB C0 00                                 ; Byte 2 -> UL
9083    08 B8 F9 5C 90 C3 C0 00                                 ; Byte 3 -> A   if SETDEV mode does not match mask
908B    08 B9 95 5C 90 BF C0 00                                 ; Byte 4 -> UH
9093    04 B7 54 58 93 56 C0 00                                 ; Byte 5 -> UL
909B    02 E6 B6 60 93 6A C0 00                                 ; Byte 6 -> A   if SETDEV mode does match mask
90A3	10 E4 F3 5C 94 E0 C0 00                                 ; Byte 7 -> 00 delimiter
90AB    08 E4 F3 5C 94 E0 C0 00                                 ;
90B3	01 C8 FA 60 96 60 C0 00                                 ;



;------------------------------------------------------------------------------------------------------------
; UNKNOWN_SUB_90BB - Jumped to from 
; Looks like a big, long parsing routine
; Arguments: 
; Outputs:
; RegMod:
UNKNOWN_SUB_90BB:
90BB   B5 20              LDI       A,$20                       ;
90BD   8E 06              BCH+      BRANCH_90C5                 ;
90BF   B5 10              LDI       A,$10                       ;
90C1   8E 02              BCH+      BRANCH_90C5                 ;
90C3   B5 00              LDI       A,$00                       ;

BRANCH_90C5:
90C5   AE 7B A1           STA       (OUT_BUF + $41)             ;
90C8   55                 LIN       Y                           ;
90C9   B7 E0              CPI       A,$E0                       ;
90CB   83 23              BCS+      BRANCH_90F0                 ;
90CD   2A                 STA       UL                          ;
90CE   B5 01              LDI       A,$01                       ;
90D0   6E 72              CPI       UL,$72                      ;
90D2   8B 14              BZS+      BRANCH_90E8                 ;
90D4   D9                 SHL                                   ;
90D5   6E 4D              CPI       UL,$4D                      ;
90D7   8B 0F              BZS+      BRANCH_90E8                 ;
90D9   D9                 SHL                                   ;
90DA   6E 61              CPI       UL,$61                      ;
90DC   89 12              BZR+      BRANCH_90F0                 ;
90DE   68 1A              LDI       UH,$1A                      ;
90E0   ED 76 4F 10        BII       (DISP_BUFF + $4F),$10       ;

BRANCH_90E4:
90E4   C9 E0              VZR       ($E0)                       ;
90E6   8E 12              BCH+      BRANCH_90FA                 ;

BRANCH_90E8:
90E8   ED 7B A1 10        BII       (OUT_BUF + $41),$10         ;
90EC   68 01              LDI       UH,$01                      ;
90EE   9E 0C              BCH-      BRANCH_90E4                 ;

BRANCH_90F0:
90F0   56                 DEC       Y                           ;
90F1   B5 00              LDI       A,$00                       ;
90F3   ED 76 4F 10        BII       (DISP_BUFF + $4F),$10       ;
90F7   8B 01              BZS+      BRANCH_90FA                 ;
90F9   DD                 INC       A                           ;

BRANCH_90FA:
90FA   AB 7B A1           ORA       (OUT_BUF + $41)             ;
90FD   AE 7B A1           STA       (OUT_BUF + $41)             ;
9100   BF 30              BII       A,$30                       ;
9102   89 09              BZR+      BRANCH_910D                 ;
9104   BF 02              BII       A,$02                       ;
9106   89 05              BZR+      BRANCH_910D                 ;
9108   68 1A              LDI       UH,$1A                      ;
910A   D8                 VEJ       ($D8)                       ; Checks calculator mode
910B   C9 E0              VZR       ($E0)                       ; Output error from UH

BRANCH_910D:
910D   BE 9D F1           SJP       SUB_9DF1                    ;
9110   C1 E4              VCR       ($E4)                       ; Output Error 1 and return to the editor
9112   A5 7B A1           LDA       (OUT_BUF + $41)             ;
9115   D5                 SHR                                   ;
9116   81 11              BCR+      $BRANCH_9129                ;
9118   CD 38              VMJ       ($38)                       ; Determines reserve memory start address +8
911A   83 08              BCS+      BRANCH_9124                 ;
911C   68 18              LDI       UH,$18                      ;
911E   E9 7B A1 20        ANI       (OUT_BUF + $41),$20         ;
9122   C9 E0              VZR       ($E0)                       ; Output error from UH

BRANCH_9124:
9124   BE 9A 32           SJP       SUB_9A32                    ;
9127   8E 27              BCH+      BRANCH_9150                 ;

BRANCH_9129:
912D   85 13              BHR+      BRANCH_913E                 ;
912B   BE DF F3           SJP       PRGST2XREG                  ; X-Reg = Program Start Address. U-Reg = STATUS 1-2
912E   81 05              BCR+      BRANCH_9135                 ;
9130   BE 9A 2D           SJP       SUB_9A2D                    ;
9133   8E 1B              BCH+      BRANCH_9150                 ;

BRANCH_9135:
9135   E9 7B A1 EF        ANI       (OUT_BUF + $41),$EF         ;

BRANCH_9139:
9139   BE 9A 38           SJP       SUB_9A38                    ;
913C   8E 12              BCH+      BRANCH_9150                 ;

BRANCH_913E:
913E   D5                 SHR
913F   83 0C              BCS+      BRANCH_914D                 ;
9141   95 0A              BHR-      BRANCH_9139                 ;
9143   BE DF F3           SJP       PRGST2XREG                  ; X-Reg = Program Start Address. U-Reg = STATUS 1-2
9146   C1 42              VCR       ($42)                       ; Editor Warm Start
9148   BE 99 49           SJP       SUB_9949                    ;
914B   8E 03              BCH+      BRANCH_9150                 ;

BRANCH_914D:
914D   BE 99 EF           SJP       SUB_99EF                    ;

BRANCH_9150:
9150   C1 E0              VCR       ($E0)                       ; Display error from UH or carry out 'ON-ERROR routine'.
9152   BE 98 BD           SJP       SUB_98BD                    ;
9155   81 03              BCR+      BRANCH_915A                 ;

BRANCH_9157:
9157   BA 96 2B           JMP       BRANCH_962B                 ;

BRANCH_915A:
915A   ED 7B A1 20        BII       (OUT_BUF + $41),$20         ;
915E   8B 0D              BZS+      BRANCH_916D                 ;
9160   ED 7B A1 04        BII       (OUT_BUF + $41),$04         ;
9164   89 17              BZR+      BRANCH_917D                 ;
9166   BE 9C EC           SJP       SUB_9CEC                    ;
9169   93 14              BCS-      BRANCH_9157                 ;
916B   8E 02              BCH+      BRANCH_916F                 ;

BRANCH_916D:
916D   8E E1              BCH+      SUB_9250                    ;


BRANCH_916F:
916F   F4 7B 75           VEJ       ($F4),(OUTBUF + $15)        ; Loads U-Reg with a 16-bit value from the address of the data bytes (D1 D2).
9172   FD 28              LDX       U                           ;
9174   F4 7B 77           VEJ       ($F4),(OUTBUF + $17)        ; Loads U-Reg with a 16-bit value from the address of the data bytes (D1 D2).
9177   BE 9A A7           SJP       BRANCH_9AA7                 ;
917A   BA 96 07           JMP       JMP_9607                    ;


BRANCH_917D:
917D   FD 98              PSH       Y                           ;
917F   F4 7B 75           VEJ       ($F4),(OUT_BUF + $15)       ; Loads U-Reg with a 16-bit value from the address of the data bytes (D1 D2).
9182   FD 28              LDX       U                           ;

BRANCH_9184:
9184   BE 9B E1           SJP       SUB_9BE1                    ;

BRANCH_9187:
9187   83 B8              BCS+      BRANCH_9241                 ;
9189   45                 LIN       X                           ;
918A   28                 STA       UH                          ;
918B   45                 LIN       X                           ;
918C   2A                 STA       UL                          ;
918D   44                 INC       X                           ;
918E   FD 88              PSH       X                           ;
9190   5A 20              LDI       YL,$20                      ;
9192   58 7A              LDI       YH,$7A                      ; Y = $7A20 = ARV
9194   CD 10 40           VMJ       ($10),$40                   ; Convert U-Reg according to data bytes, $40 = Save to (Y-Reg) in ASCII

9197   4A 1F              LDI       XL,$1F                      ; ARU + 7
9199   48 7A              LDI       XH,$7A                      ; X = $7A1F ARU 7A18
919B   14                 LDA       YL                          ;
919C   FB                 SEC                                   ;
919D   B1 21              SBI       A,$21                       ;
919F   ED 7B A1 80        BII       (OUT_BUF + $41),$80         ;
91A3   89 10              BZR+      BRANCH_91B5                 ;
91A5   B5 25              LDI       A,$25                       ;
91A7   10                 SBC       YL                          ;
91A8   2A                 STA       UL                          ;
91A9   B5 20              LDI       A,$20                       ;
91AB   51                 SIN       Y                           ; 

BRANCH_91AC:
91AC   62                 DEC       UL                          ;
91AD   81 03              BCR+      BRANCH_91B2                 ;
91AF   43                 SDE       X                           ;
91B0   9E 06              BCH-      BRANCH_91AC                 ;

BRANCH_91B2:
91B2   44                 INC       X                           ;
91B3   14                 LDA       YL                          ;
91B4   00                 SBC       XL                          ;

BRANCH_91B5:
91B5   2A                 STA       UL                          ;
91B6   FD 1A              POP       Y                           ;
91B8   BE 9A CF           SJP       SUB_9ACF                    ;
91BB   83 84              BCS+      BRANCH_9241                 ;
91BD   C2 0D 02           VEJ       ($C2),$0D,BRANCH_91C2       ; If not CR skip ahead
91C0   8E 47              BCH+      BRANCH_9209                 ; 

BRANCH_91C2:
91C2   4A 08              LDI       XL,$08                      ; 
91C4   48 7A              LDI       XH,$7A                      ; X = $7A08 = ARZ
91C6   FD 98              PSH       Y                           ; 
91C8   FD 5A              STX       Y                           ; 
91CA   A4                 LDA       UH                          ; 
91CB   89 0D              BZR+      BRANCH_91DA                 ; 
91CD   6E 5D              CPI       UL,$5D                      ;
91CF   8B 06              BZS+      BRANCH_91D7                 ;
91D1   6E 5B              CPI       UL,$5B                      ;
91D3   89 06              BZR+      BRANCH_91DB                 ;
91D5   6A 6B              LDI       UL,$6B

BRANCH_91D7:
91D7   B5 F1              LDI       A,$F1                       ;
91D9   28                 STA       UH                          ;

BRANCH_91DA:
91DA   41                 SIN       X                           ;

BRANCH_91DB:
91DB   24                 LDA       UL                          ;
91DC   41                 SIN       X                           ;
91DD   6C E0              CPI       UH,$E0                      ;
91DF   81 20              BCR+      BRANCH_9201                 ;
91E1   CD 1C 02           VMJ       ($1C),$02                   ; Basic command whose token is in U-Reg, transferred from the token table in plain text from (Y-Reg).
91E4   89 10              BZR+      BRANCH_91F6                 ;
91E6   5A 0A              LDI       YL,$0A                      ;
91E8   B5 64              LDI       A,$64                       ;
91EA   A7 7B A1           CPA       (OUT_BUF + $41)             ;
91ED   89 10              BZR+      BRANCH_91FF                 ;
91EF   5A 08              LDI       YL,$08                      ;
91F1   B5 7E              LDI       A,$7E                       ;
91F3   51                 SIN       Y                           ;
91F4   8E 09              BCH+      BRANCH_91FF                 ;


BRANCH_91F6: ; branched to from 91E4
91F6	ED 7B A1 80       BII	    (OUT_BUF + $$41),80         ;
91FA	89 03             BZR+      BRANCH_91FF                 ;
91FC	B5 20             LDI	    A,$20                       ;
91FE	51                SIN       Y                           ; (Y) = A. Then Y = Y + 1

BRANCH_91FF: ; branched to from 91ED, 91F4, 91FA
91FF	FD 18             LDX	    Y                           ; X = Y

BRANCH_9201: ; branched to from 91DF
9201	FB                SEC                                   ; Set Carry
9202	04                LDA	    XL                          ;
9203	B1 09             SBI	    A,$09                       ;
9205	4A 08             LDI	    XL,$08                      ;
9207	9E 54             BCH-	    BRANCH_91B5                 ;


BRANCH_9209: ; branched to from 91C0
9209	BE 9B 41          SJP	    SUB_9B41                    ;
920C	83 33             BCS+      BRANCH_9241                 ;
920E	BE 9B C1          SJP	    SUB_9BC1                    ; Manipulates OUT_BUF
9211	83 2E             BCS+      BRANCH_9241                 ;
9213	BE 9B 76          SJP	    SUB_9B76                    ;
9216	83 29             BCS+      BRANCH_9241                 ;
9218	F4 7B 79          VEJ	    ($F4),(OUT_BUF + $19)       ; Loads U-Reg with 16-bit value from address of (pp)
921B	FD 18             LDX	    Y                           ; X = Y
921D	BE DF E1          SJP	    (U_MINUS_X - 1)             ; DEC U then U-Reg = U-Reg - X-Reg (with overflow C=1)
9220	81 11             BCR+      BRANCH_9233                 ;

BRANCH_9222: ; branched to from 922D, 9231
9222	05                LDA	    (X)                         ;
9223	DD                INC	    A                           ;
9224	99 A2             BZR-      BRANCH_9184                 ;
9226	ED 7B A1 40       BII	    (OUT_BUF  + $41),$40        ;
922A	8B 07             BZS+      BRANCH_9233                 ;
922C	44                INC	    X                           ;
922D	88 0D             LOP	    UL,BRANCH_9222              ; UL = UL - 1, loop back 'e' if Borrow Flag not set
922F	FD 62             DEC	    UH                          ;
9231	93 11             BCS-      BRANCH_9222                 ;

BRANCH_9233: ; branched to from 9220, 922A
9233	ED 7B A1 40       BII	    (OUT_BUF + $41),$40         ;
9237	89 03             BZR+      BRANCH_923C                 ;
9239	BE 9B 41          SJP	    SUB_9B41                    ;

BRANCH_923C: ; branched to from 9237
923C	FD 1A             POP	    Y                           ;
923E	BA 96 07          JMP	    JMP_9607                    ;


BRANCH_9241: ; branched to from 9187, 91BB, 920C, 9211, 9216
9241	BE 9B 5E          SJP	    SUB_9B5E                    ; REC if UH == 3C, 34, 40, 3A
9244	83 05             BCS+      BRANCH_924B                 ;
9246	BE 9C 32          SJP	    SUB_9C32                    ; Pulls some valuse out of OUT_BUF and saves to XH, XL, UH, UL, A
9249	9E C4             BCH- 	    BRANCH_9187                 ;


BRANCH_924B: ; branched to from 9244
924B	FD 1A             POP	    Y                           ;

BRANCH_924D: ; branched to from 9259
924D	BA 96 2B          JMP	    BRANCH_962B                 ;



;------------------------------------------------------------------------------------------------------------
; SUB_9250 - Called from 916D ***JMP
; 
; Arguments:
; Output:
; RegMod:
SUB_9250:
9250	ED 7B A1 04       BII       (OUT_BUF + $41),$04         ; Is Bit3 set? In Output Buffer
9254	89 62             BZR+      BRANCH_92BB                 ; If bit set branch
9256	BE 9D 65          SJP       SUB_9D65                    ; Seems like it might have to do with MERGE
9259	93 0E             BCS-      BRANCH_924D                 ; Jumps to BRANCH_962B, looks at (OUT_BUF  + 41) and ??
925B	BE 9A A7          SJP       BRANCH_9AA7                 ; No idea
925E	83 03             BCS+      BRANCH_9263                 ;
9260	BE 9E 3E          SJP       SUB_9E3E                    ; No idea

BRANCH_9263: ; branched to from 925E
9263	A5 7B A1          LDA	    (OUT_BUF + $41)             ; In Output Buffer, does not affect C
9266	83 27             BCS+      BRANCH_928F                 ;
9268	D5                SHR                                   ; C=0 -> Right shift -> C=B0
9269	81 04             BCR+      BRANCH_926F                 ;
926B	49 00             ANI	    (X),$00                     ; Clear what XREG points to
926D	8E 1D             BCH+      BRANCH_928C                 ;


BRANCH_926F: ; branched to from 9269
926F	D5                SHR                                   ; Right shift
9270	81 0D             BCR+      BRANCH_927F                 ; C=B1
9272	F4 7B 94          VEJ	    ($F4),(OUT_BUF + $34)       ; Loads U-Reg with 16-bit value from address in Output Buffer
9275	26                CPA	    UL                          ;
9276	89 03             BZR+      BRANCH_927B                 ; If A != UL branch
9278	DD                INC	    A                           ;
9279	8B 11             BZS+      BRANCH_928C                 ; $FF + $01 = $00?

BRANCH_927B: ; branched to from 9276
927B	FD 28             LDX       U                           ; X=U, U was from output buffer?
927D	FD 5E             STX       P                           ; X to Program Counter ***JMP


BRANCH_927F: ; branched to from 9270
927F	4B FF             ORI	    (X),$FF                     ; Set all bits 
9281	CA 67             VEJ	    ($CA),($67)                 ; Transfers X to 78(pp), 78(pp+1) BASPRG_END_H 
9283	BE D0 9E          SJP       (DEL_DIM_VARS + $02)        ; Deletes dim variables. If program and variable memory overlap C=1
9286	F4 7B 75          VEJ	    ($F4),(OUT_BUF + $15)       ; Loads U-Reg with 16-bit value from address of (pp)
9289	F6 78 69          VEJ	    ($F6),(BASPRG_EDT_H)        ; Transfers U to pp, pp+1

BRANCH_928C: ; branched to from 926D, 9279
928C	BA 96 0C          JMP	    JMP_960C                    ;


BRANCH_928F: ; branched to from 9266
928F	FD A8             PSH	    U                           ;
9291	D5                SHR                                   ;
9292	81 0B             BCR+      BRANCH_929F                 ; C = B1
9294	4A 08             LDI	    XL,$08                      ; No idea what X is here ***
9296	6A 4E             LDI	    UL,$4E                      ; No idea what X is here ***
9298	B5 00             LDI	    A,$00                       ;

BRANCH_929A: ; branched to from 929B
929A	41                SIN	    X                           ; (X) = A. Then X = X + 1. No idea what X is here
929B	88 03             LOP	    UL,BRANCH_929A              ; UL = UL - 1, loop back 'e' if Borrow Flag not set
929D	8E 14             BCH+      BRANCH_92B3                 ;

BRANCH_929F: ; branched to from 9292
929F	D5                SHR                                   ;
92A0	83 11             BCS+      BRANCH_92B3                 ;
92A2	BE D0 9E          SJP       (DEL_DIM_VARS + $02)        ; Deletes dim variables. If program and variable memory overlap C=1
92A5	E9 7B A1 10       ANI	    (OUT_BUF + $41),$10         ;
92A9	89 08             BZR+      BRANCH_92B3                 ;
92AB	CC 65             VEJ	    ($CC),($65)                 ; Loads X-Reg with address at 78(pp) 78(pp+1) BASPRG_ST_H
92AD	4B FF             ORI	    (X),$FF                     ; Set all bits
92AF	CA 67             VEJ	    ($CA),($67)                 ; Transfers X to 78(pp), 78(pp+1) BASPRG_END_H
92B1	CA 69             VEJ	    ($CA),($69)                 ; Transfers X to 78(pp), 78(pp+1) BASPRG_EDT_H

BRANCH_92B3: ; branched to from 929D, 92A0, 92A9
92B3	FD 2A             POP	    U                           ;
92B5	BA 96 41          JMP	    JMP_9641                    ; no idea


BRANCH_92BB: ; branched to from 9254
92B8	BE D0 0D          SJP       CE158_PRT_B_DIR             ;
92BB	CC 67             VEJ	    ($CC),($67)                 ; Loads X-Reg with address at 78(pp) 78(pp+1) BASPRG_END_H
92BD	44                INC	    X                           ;
92BE	ED 7B A1 10       BII	    (OUT_BUF + $41),$10         ;
92C2	89 02             BZR+      BRANCH_92C6                 ;
92C4	CC 65             VEJ	    ($CC),($65)                 ; Loads X-Reg with address at 78(pp) 78(pp+1) BASPRG_ST_H

BRANCH_92C6: ; branched to from 92C2
92C6	CA 67             VEJ	    ($CA),($67)                 ; Transfers X to 78(pp), 78(pp+1) BASPRG_END_H
92C8	CA 69             VEJ	    ($CA),($69)                 ; Transfers X to 78(pp), 78(pp+1) BASPRG_EDT_H
92CA	4B FF             ORI	    (X),FF                      ; Set all bits
92CC	FD 98             PSH	    Y                           ;

BRANCH_92CE: ; branched to from 9317
92CE	4A 10             LDI	    XL,$10                      ;
92D0	48 7B             LDI	    XH,$7B                      ; X= 7B10 = STR_BUF
92D2	6A 4F             LDI	    UL,$4F                      ;
92D4	BE 9A A5          SJP       SUB_9AA5                    ; No idea
92D7	83 71             BCS+      SUB_934A                    ;
92D9	46                DEC	    X                           ;
92DA	05                LDA	    (X)                         ;
92DB	B7 0D             CPI	    A,$0D                       ; CR
92DD	89 3A             BZR+      BRANCH_9319                 ;
92DF	B5 60             LDI	    A,$60                       ;
92E1	AE 78 8B          STA	    (INBUFPTR_L)                ; Input Buffer pointer (L)
92E4	BE 93 37          SJP       SUB_9337                    ;
92E7	BE F9 57          SJP       TOKENIZE_INBUF              ;
92EA	8B 2F             BZS+      BRANCH_931B                 ;
92EC	F9                REC                                   ; Reset Carry
92ED	04                LDA	    XL                          ;
92EE	B1 60             SBI	    A,$60                       ;
92F0	83 0A             BCS+      BRANCH_92FC                 ;
92F2	BE 93 37          SJP       SUB_9337                    ;

BRANCH_92F5: ; branched to from 934E
92F5	FD EB F0 0A 01    ORI       #(PC1500_MSK_REG),01        ; Set interrupt mask for PC-1500 ON Key
92FA	CD 42             VMJ	    ($42)                       ; Editor warm start 


BRANCH_92FC: ; branched to from 92F0
92FC	B7 4F             CPI	    A,$4F                       ;
92FE	83 19             BCS+      BRANCH_9319                 ;
9300	FD 88             PSH	    X                           ;
9302	5A 60             LDI	    YL,$60                      ;
9304	BE D3 D5          SJP       DEC2HEX                     ; Conversion from decimal to hexadecimal.
9307	FD 0A             POP	    X                           ;
9309	8B 0E             BZS+      BRANCH_9319                 ;
930B	83 0E             BCS+      BRANCH_931B                 ;
930D	BE CF 3A          SJP       (PRGLINE_TDI + $13)         ; Transfer, delete, insert row from Input buffer
9310	08                STA	    XH                          ;
9311	09                AND	    (X)                         ;
9312	06                CPA	    XL                          ;
9313	00                SBC	    XL                          ;
9314	BE 93 37          SJP       SUB_9337                    ;
9317	9E 4B             BCH- 	    BRANCH_92CE                 ;

BRANCH_9319: ; branched to from 92DD, 92FE, 9309
9319	68 43             LDI	    UH,$43                      ;

BRANCH_931B: ; branched to from 92EA, 930B
931B	FD A8             PSH	    U                           ;
931D	BE 93 37          SJP       SUB_9337                    ;
9320	FD 2A             POP	    U                           ;

BRANCH_9322: ; branched to from 934C
9322	FD 1A             POP	    Y                           ;
9324	58 00             LDI	    YH,$00                      ;

JMP_9326: ; jumped to from 969D, 976E
9326	FD EB F0 0A 01    ORI       #(PC1500_MSK_REG),$01       ; Set interrupt mask for PC-1500 ON Key
932B	A4                LDA	    UH                          ;
932C	C9 E0             VZR       ($E0)                       ; Indicates if UH is not "00" error message
932E	D8                VEJ       ($D8)                       ; Checks calculator mode
932F	8B 03             BZS+      BRANCH_9334                 ;
9331	BA C6 84          JMP	    BCMD_DATA                   ; Basic Command RADIAN

BRANCH_9334: ; branched to from 932F
9334	BA C4 C6          JMP	   (BCMD_STOP + $10)            ; BASIC command STOP



;------------------------------------------------------------------------------------------------------------
; SUB_9337 - Called from 92E4, 92F2, 9314, 931D
; 
; Arguments:
; Output:
; RegMod:
SUB_9337:
9337	4A 10             LDI	    XL,$10                      ;
9339	48 7B             LDI	    XH,$7B                      ; X = 7B10 = STR_BUF
933B	5A 60             LDI	    YL,$60                      ;
933D	58 7B             LDI	    YH,$7B                      ; Y = 7B60 = OUT_BUF
933F	6A 4F             LDI	    UL,$4F                      ;

BRANCH_9341: ; branched to from 9347
9341	05                LDA	    (X)                         ;
9342	28                STA	    UH                          ;
9343	15                LDA	    (Y)                         ;
9344	41                SIN	    X                           ; (X) = A. Then X = X + 1 
9345	A4                LDA	    UH                          ;
9346	51                SIN	    (Y)                         ; (Y) = A. Then Y = Y + 1
9347	88 08             LOP	    UL,BRANCH_9341              ; UL = UL - 1, loop back 'e' if Borrow Flag not set
9349	9A                RTN                                   ;



;------------------------------------------------------------------------------------------------------------
; SUB_934A - Called from 92D7
; 
; Arguments: UH
; Output:
; RegMod:
SUB_934A:
934A	6C 42             CPI	    UH,$42                      ; '*'?
934C	99 2C             BZR-      BRANCH_9322                 ; UH != 42
934E	9E 5B             BCH-  	BRANCH_92F5                 ;



;------------------------------------------------------------------------------------------------------------
; SUB_9350 - Called from 
; 
; Arguments:
; Output:
; RegMod:
SUB_9350:
9350	BE 93 C1          SJP	    BRANCH_93C1                 ;
9353	AE 7B 9E          STA	    (OUT_BUF + $3E)             ;
9356	BE DF F3          SJP	    PRGST2XREG                  ; X-Reg = Program Start Address. U-Reg = STATUS 1-2
9359	C1 42             VCR	    ($42)                       ; If Carry, Editor warm start
935B	BE 99 49          SJP	    SUB_9949                    ;
935E	C1 E0             VCR       ($E0)                       ; If Carry, Indicates if UH is not "00" error message
9360	B5 64             LDI	    A,$64                       ;
9362	BE 98 B7          SJP	    SUB_98B7                    ;
9365	83 57             BCS+      BRANCH_93BE                 ;  
9367	BA 91 7D          JMP	    BRANCH_917D                 ;


936A	B5 6C             LDI	    A,$6C                       ;
936C	BE 98 C0          SJP	    SUB_98C0                    ;
936F	83 09             BCS+      BRANCH_937A                 ;  
9371	BE 9B DF          SJP	    SUB_98DF                    ;

BRANCH_9374: ; branched to from 9384
9374	83 04             BCS+      BRANCH_937A                 ;  
9376	C8 0E             VEJ	    ($C8),BRANCH_9386           ; Jump fwd (p) if following character doesn’t represent end to command sequence or line. 
9378	8E 32             BCH+	    BRANCH_93AC                 ;

BRANCH_937A: ; branched to from 936F, 93A8
937A	BE 9B 5E          SJP	    SUB_9B5E                    ; REC if UH == 3C, 34, 40, 3A
937D	83 3F             BCS+      BRANCH_93BE                 ;              
937F	BE 9C 32          SJP	    SUB_9C32                    ; Pulls some valuse out of OUT_BUF and saves to XH, XL, UH, UL, A
9382	FD 5A             STX       Y                           ; Y = X
9384	9E 12             BCH-	    BRANCH_9374                 ;

BRANCH_9386: ; branched to from 9376, 93B5
9386	C6                VEJ       ($C6)                       ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg

BRANCH_9387: ; branched to from 93BA, 
9387	DE 35             VEJ	    ($DE),BRANCH_93BE           ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
9389	D2 08 80          VEJ       ($D2),BRANCH_9393,80        ; If AR-X contains integer value, reseed it with (10)(DD2D) according to D2. If AR-X contains CSI further at distance address corresponding to D1
938C	FD 98             PSH	    Y                           ;
938E	BE EF 1B          SJP	    ARX2STRNG                   ; Convert AR-X to string
9391	FD 1A             POP	    Y                           ;

BRANCH_9393: ; branched to from 9389
9393	DC                VEJ       ($DC)                       ; Loads CSI from AR-X: Address by X-Reg length by UL & A 
9394	DF                DEC	    A                           ;
9395	83 0B             BCS+      BRANCH_93A2                 ;   
9397	A5 7A 04          LDA	    (ARX + $04)                 ;
939A	B1 C0             SBI	    A,$C0                       ; A = A - n
939C	89 0C             BZR+      BRANCH_93AA                 ;
939E	0A                STA	    XL                          ;
939F	48 7A             LDI	    XH,$7A                      ;
93A1	0E                STA	    (X)                         ;

BRANCH_93A2: ; branched to from 9395
93A2	2A                STA	    UL                          ;
93A3	68 00             LDI	    UH,$00                      ;
93A5	BE 9A CF          SJP	    SUB_9ACF                    ; Copies some stuff in OUT_BUF
93A8	93 30             BCS-      BRANCH_937A                 ;

BRANCH_93AA: ; branched to from 939C
93AA	C8 02             VEJ	    ($C8),BRANCH_93AE           ; Jump fwd (p) if following character doesn’t represent end to command sequence or line. 

BRANCH_93AC: ; branched to from 9378
93AC	8E BA             BCH+	    BRANCH_9468                 ;

BRANCH_93AE: ; branched to from 93AA
93AE	C4 3B 06          VEJ       ($C4),';',BRANCH_93B7       ; Check tokens/char in U-Reg if not ';' branch fwd n
93B1	C8 02             VEJ	    ($C8),BRANCH_93B5           ; Jump fwd if following character doesn’t represent end to command sequence or line. 
93B3	8E C5             BCH+	    BRANCH_947A                 ;


BRANCH_93B5: ; branched to from 93B1
93B5	9E 31             BCH-	    BRANCH_9386                 ;


BRANCH_93B7: ; branched to from 93AE
93B7	C4 2C 02          VEJ       ($C4),',',BRANCH_93BC       ; Check tokens/char in U-Reg if not ',' branch fwd n
93BA	9E 35             BCH-	    BRANCH_9387                 ;


BRANCH_93BC: ; branched to from 93B7
93BC	68 01             LDI	    UH,$01                      ;

BRANCH_93BE: ; branched to from 9365, 937D, 9387
93BE	BA 96 2B          JMP	    BRANCH_962B                 ;


BRANCH_93C1: ; branched to from 9350
93C1	B5 C4             LDI	    A,$C4                       ;   

BRANCH_93C3: ; branched to from 93CD
93C3	68 1B             LDI	    UH,$1B                      ;
93C5	A7 79 D1          CPA	    (OPN)             ; This table might be some sort of mode mask
93C8	C9 E0             VZR	    ($E0)                       ; If Z=0 output error code in UH
93CA	9A                RTN                                   ;


BRANCH_93CB: ; branched to from 9045
93CB	B5 C0             LDI	    A,$C0                       ;
93CD	9E 0C             BCH-	    BRANCH_93C3                 ;



;------------------------------------------------------------------------------------------------------------
; Seperator byte
93CF	FF                .BYTE FF                              ; unused byte



;------------------------------------------------------------------------------------------------------------
; PRINT# Jumped to from 8307 via High Bank
; 
; Arguments:
; Output:
; RegMod:
PRINT#
93D0	B5 C0             LDI	    A,$C0                        ; Not reached?
93D2	8E 07             BCH+	    BRANCH_93DB                 ;



;------------------------------------------------------------------------------------------------------------
; PRINT#2 Jumped to from 8307 via High Bank
; 
; Arguments:
; Output:
; RegMod:
PRINT#2: Jumped to from 8307 
93D4	B5 C4             LDI	    A,$C4                       ; Not reached?
93D6	8E 03             BCH+	    BRANCH_93DB                 ;

93D8	BE 93 C1          SJP       BRANCH_93C1                 ; Not reached?

BRANCH_93DB: ; branched to from 93D2, 93D6
93DB	AE 7B 9E          STA	    (OUT_BUF + $3E)             ;
93DE	B5 6C             LDI	    A,$6C                       ;
93E0	BE 98 B7          SJP       SUB_98B7                    ;
93E3	83 7F             BCS+      BRANCH_9464                 ;
93E5	BE 9B DF          SJP       SUB_98DF                    ;

BRANCH_93E8: ; branched to from 949D
93E8	83 7A             BCS+      BRANCH_9464                 ;
93EA	C8 02             VEJ	    ($C8),BRANCH_93EE           ; Jump fwd if following character doesn’t represent end to command sequence or line. 
93EC	8E 7A             BCH+	    BRANCH_9468                 ;

BRANCH_93EE: ; branched to from 93EA
93EE	C6                VEJ       ($C6)                       ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg

BRANCH_93EF: ; branched to from 948F
93EF	E9 7B A0 00       ANI	    (OUT_BUF + $40),$00         ; OUT_BUF + 40

BRANCH_93F3: ; branched to from 9425
93F3	ED 7B A0 80       BII	    (OUT_BUF + $40),$80         ;
93F7	89 0C             BZR+      BRANCH_9405                 ; Not a valid address?
93F9	C2 F0 85 09       VEJ	    ($C2),USING,BRANCH_9406     ;
93FD	EB 7B A0 80       ORI	    (OUT_BUF + $40),$80         ;
9401	BE DA B2 5F       SJP       EVAL_USING,$5F              ; Evaluation of USING paramters from Y-Reg. Not sure about $5F

BRANCH_9405:
9405	C0                VEJ       ($C0)                       ; Load next character/token to U-Reg

BRANCH_9406: ; branched to from 93F9
9406	ED 7B A0 40       BII	    (OUT_BUF + $40),$40         ;
940A	89 1B             BZR+      BRANCH_9427                 ;
940C	C4 F0 BB 17       VEJ       ($C4),TAB,BRANCH_9427       ; Check tokens/char in U-Reg if not TAB branch fwd n
9410	EB 7B A0 40       ORI	    (OUT_BUF + $40),$40         ;
9414	DE 4E             VEJ	    ($DE),BRANCH_9464           ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
9416	D0 08 4B          VEJ	    ($D0),$08,BRANCH_9464       ; Convert AR-X to integer & load to U-Reg. p specifies the range. If range exceeded: Branch fwd n
9419	BE 9A 78          SJP       SUB_9A78                    ;
941C	83 46             BCS+      BRANCH_9464                 ;
941E	C8 02             VEJ	    ($C8),BRANCH_9422           ; Jump fwd if following character doesn’t represent end to command sequence or line. 
9420	8E 58             BCH+	    BRANCH_947A                 ;

BRANCH_9422: ; branched to from 941E
9422	C4 3B 6C          VEJ       ($C4),';',BRANCH_9491       ; Check tokens/char in U-Reg if not ';' branch fwd n
9425	9E 34             BCH-	    BRANCH_93F3                 ;

BRANCH_9427: ; branched to from 94A0, 940C
9427	C6                VEJ       ($C6)                       ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
9428	DE 3A             VEJ	    ($DE),BRANCH_9464           ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
942A	D2 0F 80          VEJ       ($D2),BRANCH_943B,$80       ; If AR-X contains integer value, reseed it with (10)(DD2D) according to D2. If AR-X contains CSI further at distance address corresponding to D1
942D	FD 98             PSH	    Y                           ;
942F	B5 01             LDI	    A,$01                       ;
9431	BE EA 78          SJP       USING_FRMT                  ;
9434	FD 1A             POP	    Y                           ;
9436	83 2C             BCS+      BRANCH_9464                 ;
9438	2A                STA	    UL                          ;
9439	8E 21             BCH+	    BRANCH_945C                 ;

BRANCH_943B: ; branched to from 942A
943B	DC                VEJ       ($DC)                       ; Loads CSI from AR-X: Address by X-Reg length by UL & A 
943C	89 0F             BZR+      BRANCH_944D                 ;
943E	A5 7A 04          LDA	    (ARX + $04)                 ;
9441	B7 C1             CPI	    A,$C1                       ;
9443	89 21             BZR+      BRANCH_9466                 ;
9445	B5 00             LDI	    A,$00                       ;
9447	48 7A             LDI	    XH,$7A                      ;
9449	0A                STA	    XL                          ; X = 7A00 = ARX
944A	0E                STA	    (X)                         ;
944B	6A 01             LDI	    UL,$01                      ;

BRANCH_944D: ; branched to from 943C
944D	A5 78 97          LDA	    (USING&)                    ;
9450	8B 0A             BZS+      BRANCH_945C                 ;
9452	FB                SEC                                   ; Set Carry
9453	28                STA	    UH                          ;
9454	20                SBC	    UL                          ;
9455	81 03             BCR+      BRANCH_945A                 ;
9457	28                STA	    UH                          ;
9458	8E 04             BCH+	    BRANCH_945E                 ;


BRANCH_945A: ; branched to from 9455
945A	A4                LDA	    UH                          ;
945B	2A                STA	    UL                          ;

BRANCH_945C: ; branched to from 9439, 9450
945C	68 00             LDI	    UH,$00                      ;

BRANCH_945E: ; branched to from 9458
945E	62                DEC	    UL                          ;
945F	BE 9A 9D          SJP       BRANCH_9A9D                 ;
9462	81 02             BCR+      BRANCH_9466                 ;

BRANCH_9464: ; branched to from 93E3, 93E8, 9414, 9416, 941C, 9428, 9436
9464	8E 2D             BCH+	    BRANCH_9493                 ;


BRANCH_9466: ; branched to 9443, 9462
9466	C8 0D             VEJ	    ($C8),BRANCH_9475           ; Jump fwd if following character doesn’t represent end to command sequence or line. 

BRANCH_9468: ; branched to from 93AC
9468	BE 9B 41          SJP	    SUB_9B41                    ;
946B	83 26             BCS+      BRANCH_9493                 ;
946D	BE 9B C1          SJP	    SUB_9BC1                    ; Manipulates OUT_BUF
9470	83 21             BCS+      BRANCH_9493                 ;
9472	BA 96 07          JMP	    JMP_9607                    ;


BRANCH_9475:
9475	C4 3B 0A          VEJ       ($C4),';',BRANCH_9482       ; Check tokens/char in U-Reg if not ';' branch fwd n
9478	C8 14             VEJ	    ($C8),BRANCH_948E           ; Jump fwd if following character doesn’t represent end to command sequence or line. 

BRANCH_947A: ; branched to from 93B3, 9420, 948C
947A	BE 9B C1          SJP	    SUB_9BC1                    ; Manipulates OUT_BUF
947D	83 14             BCS+      BRANCH_9493                 ;
947F	BA 96 0C          JMP	    JMP_960C                    ;


BRANCH_9482:
9482	C4 2C 0C          VEJ       ($C4),',',BRANCH_9491       ; Check tokens/char in U-Reg if not ',' branch fwd n
9485	BE 9A 50          SJP	    SUB_9A50                    ;
9488	83 09             BCS+      BRANCH_9493                 ;
948A	C8 02             VEJ	    ($C8),BRANCH_948E           ; Jump fwd if following character doesn’t represent end to command sequence or line. 
948C	9E 14             BCH-	    BRANCH_947A                 ;


BRANCH_948E: ; branched to from 9478, 948A
948E	C6                VEJ       ($C6)                       ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
948F	9E A2             BCH-	    BRANCH_93EF                 ;


BRANCH_9491: ; branched to from 9422, 9482
9491	68 01             LDI	    UH,$01                      ;

BRANCH_9493: ; branched to from 9464, 946B, 9470, 947D, 9488
9493	BE 9B 5E          SJP	    SUB_9B5E                    ; REC if UH == 3C, 34, 40, 3A
9496	83 08             BCS+      BRANCH_94A0                 ;
9498	BE 9C 32          SJP	    SUB_9C32                    ; Pulls some valuse out of OUT_BUF and saves to XH, XL, UH, UL, A
949B	FD 5A             STX       Y                           ; Y = X
949D	BA 93 E8          JMP	    BRANCH_93E8                 ;


BRANCH_94A0: ; branched to from 9518, 9544
94A0	BA 96 2B          JMP	    BRANCH_962B                 ;


; 94A3 ~ 94DF Byte array
94A3	00 0B 00 00 
94A7    88 00 00 00   00 13 00 00 10 00 00 00                   ; Used by $9651 ? ***
94B3	00 D3 19 00 88 00 00 00   01 A3 19 00 10 00 FF 00 
94C3	FF 00 FF 00 FF 00 FF 00   FF 00 FF 00 FF 00 FF 00 
94D3	FF 00 FF 00 FF 00 FF 00   FF 00 FF 20 FF 


;--------------------------------------------------------------------------------------------------
; SUB_94E0
; Called from
SUB_94E0:
94E0	B5 C0             LDI	    A,$C0                       ;
94E2	AE 7B 9E          STA	    (OUT_BUF + $3E)             ;
94E5	B5 28             LDI	    A,$28                       ;
94E7	ED 78 79 80       BII	    (CASS_FLAG),$80             ;
94EB	8B 02             BZS+      BRANCH_94EF                 ;
94ED	B5 08             LDI	    A,$08                       ;

BRANCH_94EF: ; jumped to from 94EB
94EF	BE 98 C0          SJP	    SUB_98C0                    ;
94F2	BE 9D F1          SJP	    SUB_9DF1                    ;
94F5	91 57             BCR-      BRANCH_94A0                 ;
94F7	ED 7B A1 20       BII	    (OUT_BUF + $41),$20         ;
94FB	89 05             BZR+      BRANCH_9502                 ;
94FD	BE 9D 65          SJP	    SUB_9D65                    ;
9500	8E 16             BCH+	    BRANCH_9518                 ;


BRANCH_9502: ; jumped to from 
9502	BE 9C EC          SJP	    SUB_9CEC                    ;
9505	93 67             BCS-      BRANCH_94A0                 ;

JMP_9507: ; jumped to from 9626
9507	ED 7B A1 20       BII	    (OUT_BUF + $41),$20         ;
950B	8B 0D             BZS+      BRANCH_951A                 ;
950D	ED 7B A1 80       BII	    (OUT_BUF + $41),$80         ;
9511	89 05             BZR+      BRANCH_9518                 ;
9513	B5 FF             LDI	    A,$FF                       ;
9515	BE 9B 8C          SJP	    DELAY_A_MS                  ; Time delay of A * 15.625ms

BRANCH_9518: ; branched to from 9511
9518	93 7A             BCS-      BRANCH_94A0                 ;

BRANCH_951A: ; branched to from 950B
951A	CE F1 25          VEJ 	    ($CE),$F1,BRANCH_9542       ; Determines variable 'F1' address all variable types allowed, if errors continue at P+n2
951D	ED 7B A1 20       BII	    (OUT_BUF + $41),$20         ;
9521	89 39             BZR+      BRANCH_955C                 ;
9523	BF 01             BII	    A,$01                       ;
9525	8B 35             BZS+      BRANCH_955C                 ;
9527	BF 20             BII	    A,$20                       ;
9529	89 31             BZR+      BRANCH_955C                 ;
952B	FD C8             PSH	    A                           ;
952D	66                DEC	    U                           ;
952E	66                DEC	    U                           ;
952F	66                DEC	    U                           ;
9530	66                DEC	    U                           ;
9531	CC 99             VEJ       ($CC),($99)                 ; Loads X-Reg with address at 78(pp) 78(pp+1) VAR_START_H
9533	A6                CPA	    UH                          ;
9534	89 04             BZR+      BRANCH_953A                 ;
9536	04                LDA	    XL                          ;
9537	26                CPA	    UL                          ;
9538	8B 02             BZS+      BRANCH_953C                 ;

BRANCH_953A: ; branched to from 9534
953A	64                INC	    U                           ;
953B	64                INC	    U                           ;

BRANCH_953C: ; branched to from 9538
953C	64                INC	    U                           ;
953D	64                INC	    U                           ;
953E	FD 8A             POP	    A                           ;
9540	8E 1A             BCH+	    BRANCH_955C                 ;

BRANCH_9542: ; branched to from 951A
9542	6C 15             CPI	    UH,$15                      ;
9544	99 A6             BZR-      BRANCH_94A0                 ;
9546	24                LDA	    UL                          ;
9547	F1                AEX                                   ; Accumulator High nibble & low nibble swapped
9548	D5                SHR                                   ;
9549	D5                SHR                                   ;
954A	B5 00             LDI	    A,$00                       ;
954C	4A 1F             LDI	    XL,$1F                      ;
954E	48 7A             LDI	    XH,$7A                      ; X = 7A1F = ARU
9550	6A 0F             LDI	    UL,$0F                      ;

BRANCH_9552: ; branched to from 9553
9552	43                SDE	    X                           ; (X) = A. X = X - 1
9553	88 03             LOP 	    UL,BRANCH_9552              ; UL = UL - 1, loop back 'e' if Borrow Flag not set
9555	81 02             BCR+      BRANCH_9559                 ;
9557	B5 08             LDI	    A,$08                       ;

BRANCH_9559: ; branched to from 9555
9559	44                INC	    X                           ;
955A	FD 6A             STX       U                           ; U = X

BRANCH_955C: ; branched to from 9521, 9525, 9529, 9540
955C	AE 78 79          STA	    (CASS_FLAG)                 ;
955F	48 94             LDI	    XH,$94                      ;
9561	4A A7             LDI	    XL,$A7                      ; X = 94A7
9563	FD CA             ADR	    X                           ; X = X + A + Carry
9565	D5                SHR                                   ;
9566	B5 05             LDI	    A,$05                       ;
9568	81 05             BCR+      BRANCH_956F                 ;
956A	FD EA             ADR	    U                           ; U = U + A + Carry
956C	FD 28             LDX	    U                           ; X = U
956E	46                DEC	    X                           ;

BRANCH_956F: ; branched to from 9568
956F	DA                VEJ       ($DA)                       ; Cache/remember variable address from U-Reg and length from AR-X (7A07)
9570	68 7A             LDI	    UH,$7A                      ;
9572	6A 04             LDI	    UL,$04                      ; U = ARX + $04

BRANCH_9574: ; branched to from 9576
9574	47                LDE       X                           ; A = (X) then X = X - 1
9575	2E                STA	    (U)                         ;
9576	88 04             LOP 	    UL,BRANCH_9574              ; UL = UL - 1, loop back 'e' if Borrow Flag not set
9578	FD 28             LDX	    U                           ; X = U
957A	ED 7B A1 20       BII	    (OUT_BUF + $41),$20         ;
957E	89 02             BZR+      BRANCH_9582                 ;
9580	4A 07             LDI	    XL,$07                      ;

BRANCH_9582: ; branched to from 957E
9582	40                INC	    XL                          ;
9583	6A 04             LDI	    UL,$04                      ;
9585	68 00             LDI	    UH,$00                      ;
9587	BE 9B E1          SJP	    SUB_9BE1                    ; Manipulates OUT_BUF

BRANCH_958A: ; branched to from 9603
958A	83 6F             BCS+      BRANCH_95FB                 ;
958C	BE 9A CF          SJP	    SUB_9ACF                    ; Copies some stuff in OUT_BUF
958F	83 6A             BCS+      BRANCH_95FB                 ;
9591	ED 7B A1 20       BII	    (OUT_BUF + $41),$20         ;
9595	89 0B             BZR+      BRANCH_95A2                 ;
9597	68 7A             LDI	    UH,$7A                      ;
9599	6A 04             LDI	    UL,$04                      ; U = $7A04 = (ARX + 4)

BRANCH_959B: ; branched to from 95A0
959B	46                DEC	    X                           ;
959C	25                LDA	    (U)                         ;
959D	07                CPA	    (X)                         ;
959E	89 22             BZR+      BRANCH_95C2                 ;
95A0	88 07             LOP 	    UL,BRANCH_959B              ; UL = UL - 1, loop back 'e' if Borrow Flag not set

BRANCH_95A2: ; branched to from 9595
95A2	CC 83             VEJ       ($CC),($83)                 ; Loads X-Reg with address at 78(pp) 78(pp+1) CURVARADD_H
95A4	A5 78 79          LDA	    (CASS_FLAG)                 ;
95A7	B7 18             CPI	    A,$18                       ;
95A9	8B 1C             BZS+      BRANCH_95C7                 ;
95AB	F4 7A 00          VEJ	    ($F4),(XREG)                ;
95AE	B5 FC             LDI	    A,$FC                       ;
95B0	FD EA             ADR	    U                           ; U = U + A + Carry
95B2	A4                LDA	    UH                          ;
95B3	DF                DEC	    A                           ;

BRANCH_95B4: ; branched to from 95BE, 95F9
95B4	FD C8             PSH	    A                           ;
95B6	BE 9A CF          SJP	    SUB_9ACF                    ; Copies some stuff in OUT_BUF
95B9	FD 8A             POP	    A                           ;
95BB	83 3E             BCS+      BRANCH_95FB                 ;
95BD	DF                DEC	    A                           ;
95BE	93 0C             BCS-      BRANCH_95B4                 ;
95C0	8E 43             BCH+	    BRANCH_9605                 ;


BRANCH_95C2: ; branched to from 959E
95C2	68 42             LDI	    UH,$42                      ;

BRANCH_95C4: ; branched to from 95FE
95C4	BA 96 2B          JMP	    BRANCH_962B                 ;


BRANCH_95C7: ; branched to from 95A9
95C7	6A 3F             LDI	    UL,$3F                      ;
95C9	BE 9A CF          SJP	    SUB_9ACF                    ; Copies some stuff in OUT_BUF
95CC	83 2D             BCS+      BRANCH_95FB                 ;
95CE	ED 7B A1 20       BII	    (OUT_BUF + $41),$20         ;
95D2	8B 07             BZS+      BRANCH_95DB                 ;
95D4	B5 FF             LDI	    A,$FF                       ;
95D6	BE 9B 8C          SJP	    DELAY_A_MS                  ; Time delay of A * 15.625ms
95D9	83 20             BCS+      BRANCH_95FB                 ;

BRANCH_95DB: ; branched to from 95D2
95DB	4A 50             LDI	    XL,$50                      ;
95DD	48 76             LDI	    XH,$76                      ; X = 7650 = STRING_VARS
95DF	6A AF             LDI	    UL,$AF                      ;
95E1	BE 9A CF          SJP	    SUB_9ACF                    ; Copies some stuff in OUT_BUF
95E4	83 15             BCS+      BRANCH_95FB                 ;
95E6	ED 7B A1 20       BII	    (OUT_BUF + $41),$20         ;
95EA	8B 07             BZS+      BRANCH_95F3                 ;
95EC	B5 FF             LDI	    A,$FF                       ;
95EE	BE 9B 8C          SJP	    DELAY_A_MS                  ; Time delay of A * 15.625ms
95F1	83 08             BCS+      BRANCH_95FB                 ;

BRANCH_95F3: ; branched to from 95EA
95F3	4A 50             LDI	    XL,$50                      ;
95F5	6A AF             LDI	    UL,$AF                      ;
95F7	B5 00             LDI	    A,$00                       ;
95F9	9E 47             BCH-	    BRANCH_95B4                 ;

BRANCH_95FB: ; branched to from 958A, 958F, 95BB, 95CC, 95D6, 95D6, 95E4, 95F1
95FB	BE 9B 5E          SJP	    SUB_9B5E                    ; REC if UH == 3C, 34, 40, 3A
95FE	93 3C             BCS-      BRANCH_95C4                 ;
9600	BE 9C 32          SJP	    SUB_9C32                    ; Pulls some valuse out of OUT_BUF and saves to XH, XL, UH, UL, A
9603	9E 7B             BCH-	    BRANCH_958A                 ;


BRANCH_9605: ; branched to from 95C0
9605	C8 0F             VEJ	    ($C8),BRANCH_9616           ; Jump fwd (p) if following character doesn’t represent end to command sequence or line. 

JMP_9607: ; jumped from from 923E, 917A
9607	BE 9E 3E          SJP	    SUB_9E3E                    ;
960A	83 1F             BCS+      BRANCH_962B                 ;

JMP_960C: ; jumped to from 928C, 9859
960C	BE 9B AA          SJP	    SUB_9BAA                    ; Checks some things in OUTPUT BUFFER, pokes values in CE-158 registers
960F	FD EB F0 0A 01    ORI       #(PC1500_MSK_REG),$01       ; PC-1500 - Set interrupt mask for ON Key
9614	56                DEC	    Y                           ;
9615	E2                VEJ       ($E2)                       ; Start of Basic Interpreter

BRANCH_9616:
9616	C4 2C 10          VEJ       ($C4),',',BRANCH_9629       ; Check tokens/char in U-Reg if not ',' branch fwd n
9619	B5 84             LDI	    A,$84                       ;
961B	ED 7B A1 20       BII	    (OUT_BUF + $41),$20         ; In OUT_BUF
961F	8B 02             BZS+      BRANCH_9623                 ;
9621	B5 04             LDI	    A,$04                       ;

BRANCH_9623: ; branched to from 961F
9623	AE 78 79          STA	    (CASS_FLAG)                 ;
9626	BA 95 07          JMP	    JMP_9507                    ; Unknown


BRANCH_9629: ; branched to from 9616
9629	68 01             LDI	    UH,$01                      ;

BRANCH_962B: ; branched to from 9157, jumped to from 985E
962B	A5 7B A1          LDA	    (OUT_BUF  + $41)            ; In OUT_BUF
962E	B7 A0             CPI	    A,$A0                       ;
9630	81 0C             BCR+      BRANCH_963E                 ;
9632	FD 28             LDX	    U                           ; X = U
9634	FD E9 F0 0A FC    ANI       #(PC1500_MSK_REG),$FC       ; Clear IRQ and ON Key interrupt mask for PC-1500
9639	BE 9E 47          SJP	    SUB_9E47                    ; Unknown
963C	FD 6A             STX       U                           ; U = X


BRANCH_963E: ; branched to from 9630
963E	BE 9B AA          SJP       SUB_9BAA                    ; Checks some things in OUTPUT BUFFER, pokes values in CE-158 registers

JMP_9641: ; Jumped to from 92B5
9641	FD EB F0 0A 01    ORI       #(PC1500_MSK_REG),$01       ; Set interrupt mask for PC-1500 ON Key
9646	A4                LDA	    UH                          ;
9647	C9 E0             VZR       ($E0)                       ; If Z=0 output error code in UH
9649	FD EB F0 0B 02    ORI       #(PC1500_IF_REG),$02        ;
964E	BA C6 84          JMP	    BCMD_DATA                   ; Basic Command DATA / ARUN / AREAD



;--------------------------------------------------------------------------------------------------
; 9651 ~ 965F
SEPARATOR_9651:
9651	FF 00 FF 00 FF 00 FF 00   FF 00 FF 00 FF 00 FF 



;--------------------------------------------------------------------------------------------------
; INPUT# - Jumped to from 8307 via High Bank
; Arguments: XREG = Address, YREG = Token,
; Output:
; RegMod:
INPUT#:
9660	B5 C0             LDI	    A,$C0                       ;
9662	AE 7B 9E          STA	    (OUT_BUF + $3E)             ; In OUTPUT_BUFFER
9665	C2 25 46          VEJ	    ($C2),'%',BRANCH_96AE       ; If next character is not '%', branch fwd 'n'.
9668	CE F1 78          VEJ	    ($CE),$F1,BRANCH_96E3       ; Determines variable pointed to by Y-REG if errors branch fwd
966B	FD 28             LDX       U                           ; X = U. U returned from (CE) as start address of variable
966D	68 44             LDI	    UH,$44                      ;    
966F	B7 29             CPI	    A,$29                       ; A must have been changed in (CE) call
9671	C9 E0             VZR       ($E0)                       ; If UH != 00 reset Set Output ERROR 1
9673	46                DEC	    X                           ;
9674	4D 20             BII	    (X),$20                     ; Look for a space before variable?
9676	CB E0             VZS       ($E0)                       ; If Z Set Output ERROR 1 if UH != 00
9678	44                INC	    X                           ; X is back to address of variable
9679	45                LIN	    X                           ; A = (X) then INC X
967A	28                STA	    UH                          ;
967B	45                LIN	    X                           ; A = (X) then INC X
967C	2A                STA       UL                          ; What is U-REG pointing to?
967D	44                INC	    X                           ;
967E	44                INC	    X                           ;
967F	44                INC	    X                           ;
9680	66                DEC	    U                           ;
9681	66                DEC	    U                           ;
9682	66                DEC	    U                           ;
9683	66                DEC	    U                           ;
9684	FD 88             PUSH	    X                           ;
9686	FD A8             PUSH	    U                           ;
9688	BE D3 C5          SJP	    (DELU_FROMX + 1)            ; Deletes U+2 bytes? from X-REG
968B	B5 0C             LDI	    A,$0C                       ;
968D	BE 98 C0          SJP	    SUB_98C0                    ; No idea
9690	FD 2A             POP	    U                           ;
9692	FD 0A             POP	    X                           ;
9694	BE 9A A7          SJP	    BRANCH_9AA7                 ; No idea
9697	81 07             BCR+      BRANCH_96A0                 ;
9699	6C 42             CPI	    UH,$42                      ;
969B	8B 0B             BZS+      BRANCH_96A8                 ; No idea
969D	BA 93 26          JMP	    JMP_9326                    ; No idea


BRANCH_96A0: ; branched to from 9697
96A0	46                DEC	    X                           ; X is still in variable?
96A1	05                LDA	    (X)                         ;
96A2	B7 0D             CPI	    A,$0D                       ; Looking for CR?
96A4	89 02             BZR+      BRANCH_96A8                 ;
96A6	49 00             ANI	    (X),$00                     ; Clear address (X)

BRANCH_96A8: ; branched to from 969B, 96A4
96A8	FD EB F0 0A 01    ORI       #(PC1500_MSK_REG),$01       ; Set interrupt mask for PC-1500 ON Key
96AD	E2                VEJ       ($E2)                       ; Start of Basic Interpreter


BRANCH_96AE: ; branched to from 9665
96AE	C6                VEJ       ($C6)                       ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
96AF	68 1A             LDI	    UH,$1A                      ;
96B1	D8                VEJ       ($D8)                       ; Checks if program ends. If so:Z=0
96B2	CB E0             VZS       ($E0)                       ; If Z=1 CALL (E0). If Z Set Output ERROR 1 if UH != 00
96B4	E9 7B 9F 00       ANI	    (OUT_BUF + $3F),$00         ;
96B8	C2 24 05          VEJ	    ($C2),'$',BRANCH_96C0       ; If next character is not '$', branch fwd 'n'. 
96BB	C0                VEJ       ($C0)                       ; Load next character/token to U-Reg
96BC	EB 7B 9F 01       ORI	    (OUTBUF + $3F),$01          ; In output buffer

BRANCH_96C0: ; branched to from 96B8
96C0	C6                VEJ       ($C6)                       ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
96C1	BE D0 34          SJP	    INBUF_CLR                   ; Inside delete Input_Buffer w/0D
96C4	C2 22 1D          VEJ	    ($C2),'"',BRANCH_96E4       ; If next character is not ' " ', branch fwd 'n'. 
96C7	CD 0C             VMJ	    ($0C)                       ; Determine string length, create CSI in AR-X
96C9	FD 98             PSH	    Y                           ; Y-REG contains end address marker
96CB	5A B0             LDI	    YL,$B0                      ;
96CD	58 7B             LDI	    YH,$7B                      ; Y = 7BB0, INPUT_BUFFER
96CF	A5 7A 07          LDA	    (ARX + $07)                 ; last byte of AR-X
96D2	2A                STA	    UL                          ;
96D3	BE D0 49          SJP	    XREG2YREG                   ; Transfers UL bytes from X-Reg to Y-Reg
96D6	14                LDA	    YL                          ;
96D7	AE 78 8B          STA	    (INBUFPTR_L)                ;
96DA	FD 1A             POP	    Y                           ;
96DC	C2 3B 0D          VEJ	    ($C2),';',BRANCH_96EC       ;  If next character is not ';', branch fwd 'n'. If 'p' is Fn then 3 args, if not 2 args
96DF	B5 40             LDI	    A,$40                       ;
96E1	8E 13             BCH+	    BRANCH_96F6                 ; Must have been ';' so keep parsing?


BRANCH_96E3: ; branched to from 9668
96E3	E0                VEJ       ($E0)                       ; Indicates if UH is not "00" error message

BRANCH_96E4: ; branched to from 96C4
96E4	C6                VEJ       ($C6)                       ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
96E5	B5 3F             LDI	    A,$3F                       ; '?'
96E7	AE 7B B0          STA	    (INPUTBUF)                  ;
96EA	8E 03             BCH+	    BRANCH_96EF                 ;

BRANCH_96EC: ; branched to from 96DC
96EC	C4 2C 78          VEJ       ($C4),',',BRANCH_9767       ; Check tokens/char in U-Reg if not ',' branch fwd n

BRANCH_96EF: ; branched to from 96EA
96EF	B5 B0             LDI	    A,$B0                       ;
96F1	AE 78 8B          STA	    (INBUFPTR_L)                ;
96F4	B5 00             LDI	    A,$00                       ;

BRANCH_96F6: ; branched to from 96E1
96F6	AE 78 80          STA	    (DISPARAM)                  ;
96F9	EB 78 8A 10       ORI	    (BREAKPARAM),$10            ;
96FD	BE EF 67          SJP	    PREPLCDOUT                  ; Prepare the LCD output if C=1
9700	68 20             LDI	    UH,$20                      ;
9702	E9 78 8A 00       ANI	    (BREAKPARAM),$00            ;
9706	C3 E0             VCS       ($E0)                       ; If Carry Set Indicates if UH is not "00" error message
9708	B5 0C             LDI	    A,$0C                       ;
970A	BE 98 C0          SJP	    SUB_98C0                    ; No idea
970D	83 5F             BCS+      BRANCH_976E                 ;
970F	FD 98             PSH	    Y                           ;      
9711	58 7B             LDI	    YH,$7B                      ;
9713	A5 78 8B          LDA	    (INBUFPTR_L)                ;
9716	1A                STA	    YL                          ; Y now points to current position in input buffer?
9717	BE E8 CA          SJP	    PRGMDISP                    ; Displays input buffer on LCD

BRANCH_971A: ; branched to from 97FA
971A	FD 1A             POP	    Y                           ;
971C	CE 58 4F          VEJ	    ($CE),$58,BRANCH_976E       ; Determines variable 'n1' address all variable types allowed, if errors continue at P+n2
971F	F6 78 86          VEJ       ($F6),(LASTVARADD_H)        ; Copy U-REG to 7886-87
9722	44                INC	    X                           ;
9723	A5 7A 07          LDA	    (ARX + $07)                 ;
9726	0E                STA	    (X)                         ;
9727	FD 98             PSH	    Y                           ; 
9729	58 7B             LDI	    YH,$7B                      ;
972B	BE D0 21          SJP	    INBUF_CLRRST                ;
972E	A5 78 8B          LDA	    (INBUFPTR_L)                ;
9731	0A                STA	    XL                          ;
9732	48 7B             LDI	    XH,$7B                      ;
9734	B5 FF             LDI	    A,$FF                       ;
9736	FB                SEC                                   ; Set Carry
9737	00                SBC	    XL                          ;
9738	2A                STA	    UL                          ;
9739	BE 9A A5          SJP	    SUB_9AA5                    ; No idea
973C	83 2A             BCS+      BRANCH_9768                 ;
973E	46                DEC	    X                           ;
973F	68 43             LDI	    UH,$43                      ;
9741	05                LDA	    (X)                         ;
9742	B7 0D             CPI	    A,$0D                       ; Look for CR?
9744	89 26             BZR+      BRANCH_976C                 ;
9746	ED 7B 9F 01       BII	    (OUTBUF + $3F),$01          ; In IN_BUF
974A	89 0B             BZR+      BRANCH_9757                 ;
974C	ED 78 88 80       BII	    (LASTVARTYPE),$80           ;
9750	8B 05             BZS+      BRANCH_9757                 ;
9752	BE F9 57          SJP	    TOKENIZE_INBUF              ;
9755	8B 15             BZS+      BRANCH_976C                 ;

BRANCH_9757: ; branched to from 974A, 9750
9757	A5 78 8B          LDA	    (INBUFPTR_L)                ;
975A	06                CPA	    XL                          ;
975B	81 14             BCR+      BRANCH_9771                 ;

BRANCH_975D: ; branched to from 976A
975D	FD EB F0 0A 01    ORI       #(PC1500_MSK_REG),$01       ; Set interrupt mask for PC-1500 ON Key
9762	FD 1A             POP	    Y                           ;
9764	BA C6 76          JMP	    BCMD_REM                    ; Basic command REM


BRANCH_9767: ; branched to from 96EC
9767	E4                VEJ       ($E4)                       ; Output error 1 and return to the editor


BRANCH_9768: ; branched to from 973C
9768	6C 42             CPI	    UH,$42                      ;
976A	9B 0F             BZS-      BRANCH_975D                 ;

BRANCH_976C: ; branched to from 9744, 9755, 97AA, 9819
976C	FD 1A             POP	    Y                           ;

BRANCH_976E: ; branched to from 970D, 971C, 97D0, 9817
976E	BA 93 26          JMP	    JMP_9326                    ; No idea


BRANCH_9771: ; branched to from 975B
9771	1A                STA	    YL                          ;
9772	58 7B             LDI	    YH,$7B                      ;

BRANCH_9774: ; branched to from 9811
9774	C2 2C 0F          VEJ	    ($C2),',',BRANCH_9786       ; If next character is not ',', branch fwd 'n'. 
9777	EC                VEJ       ($EC)                       ; Clears arithmetic register X
9778	B5 D0             LDI	    A,$D0                       ;
977A	ED 78 88 80       BII	    (LASTVARTYPE),$80           ;
977E	89 03             BZR+      BRANCH_9783                 ;
9780	AE 7A 04          STA	    (ARX + $04)                 ;

BRANCH_9783: ; branched to from 977E
9783	56                DEC	    Y                           ;
9784	8E 30             BCH+	    BRANCH_97B6                 ;

BRANCH_9786: ; branched to from 9774
9786	C6                VEJ       ($C6)                       ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
9787	ED 78 88 80       BII	    (LASTVARTYPE),$80           ;
978B	89 27             BZR+      BRANCH_97B4                 ;
978D	C2 22 04          VEJ	    ($C2),'"',BRANCH_9794       ; If next character is not ' " ', branch fwd 'n'. 
9790	CD 0C             VMJ	    ($0C)                       ; Determine string length, create CSI in AR-X
9792	8E 22             BCH+	    BRANCH_97B6                 ;

BRANCH_9794: ; branched to from 978D
9794	C6                VEJ       ($C6)                       ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
9795	FD 18             LDX	    Y                           ; X = Y
9797	6A 4F             LDI	    UL,$4F                      ;

BRANCH_9799: ; branched to from 97A6
9799	55                LIN	    Y                           ; A = (Y) then INC Y
979A	B7 E0             CPI	    A,$E0                       ;
979C	83 0A             BCS+      BRANCH_97A8                 ;
979E	B7 2C             CPI	    A,$2C                       ; ","
97A0	8B 0A             BZS+      BRANCH_97AC                 ;
97A2	B7 0D             CPI	    A,$0D                       ; CR
97A4	8B 06             BZS+      BRANCH_97AC                 ;
97A6	88 0F             LOP	    UL,BRANCH_9799              ; UL = UL - 1, loop back 'e' if Borrow Flag not set

BRANCH_97A8: ; branched to from 979C, 97F8
97A8	68 1C             LDI	    UH,$1C                      ;
97AA	9E 40             BCH-      BRANCH_976C                 ;

BRANCH_97AC: ; branched to from 97A0, 97A4
97AC	56                DEC	    Y                           ;
97AD	14                LDA	    YL                          ;
97AE	FB                SEC                                   ;
97AF	00                SBC	    XL                          ;
97B0	CD 24             VMJ	    ($24)                       ; Creates CSI in AR-X. X-Reg start address, A length
97B2	8E 02             BCH+	    BRANCH_97B6                 ;

BRANCH_97B4: ; branched to from 978B
97B4	DE 63             VEJ       ($DE),BRANCH_9919           ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error

BRANCH_97B6: ; branched to from 9784, 9792, 97B2
97B6	F4 78 86          VEJ       ($F4),(LASTVARADD_H)        ; Loads U-Reg with last variable address
97B9	CC 88             VEJ	    ($CC),($88)                 ; Loads X-Reg with address at 78(pp) 78(pp+1), LASTVARTYPE
97BB	BE C0 11          SJP	    SAVEVARPTR_A                ; Store address from U-Reg and Accumulator.
97BE	CD 08 58          VMJ	    ($08),BRANCH_9919           ; Transfers the result from AR-X to a fixed variable or clock module
97C1	FD 18             LDX	    Y                           ; X = Y
97C3	FD 1A             POP	    Y                           ;
97C5	FD 88             PSH	    X                           ;
97C7	C8 21             VEJ	    ($C8),BRANCH_97EA           ; Syntax check: Jump fwd (p) if following character doesn’t represent end to command sequence or line. 
97C9	FD 0A             POP	    X                           ;
97CB	05                LDA	    (X)                         ;
97CC	B7 0D             CPI	    A,$0D                       ; CR?
97CE	68 41             LDI	    UH,$41                      ;
97D0	99 64             BZR-      BRANCH_976E                 ;
97D2	FD EB F0 0A 01    ORI       #(PC1500_MSK_REG),$01       ; Set interrupt mask for PC-1500 ON Key
97D7	56                DEC	    Y                           ;
97D8	FD 98             PSH	    Y                           ; 
97DA	58 7B             LDI	    YH,$7B                      ;
97DC	A5 78 8B          LDA	    (INBUFPTR_L)                ;
97DF	1A                STA	    YL                          ;
97E0	E9 78 80 00       ANI	    (DISPARAM),$00              ; Clear Display Parameter flags
97E4	BE E8 CA          SJP	    PRGMDISP                    ; Displays input buffer on LCD
97E7	FD 1A             POP	    Y                           ;
97E9	E2                VEJ       ($E2)                       ; Start of Basic Interpreter


BRANCH_97EA: ; branched to from 97C7
97EA	C4 2C 26          VEJ       ($C4),',',$9813             ; Check tokens/char in U-Reg if not ',' branch fwd n
97ED	FD 0A             POP	    X                           ;
97EF	FD 98             PSH	    Y                           ; 
97F1	45                LIN	    X                           ; A = (X) then INC X
97F2	B7 2C             CPI	    A,$2C                       ;
97F4	8B 06             BZS+      BRANCH_97FC                 ;
97F6	B7 0D             CPI	    A,$0D                       ; CR?
97F8	99 52             BZR-      BRANCH_97A8                 ;
97FA	9E E2             BCH-      BRANCH_971A                 ;

BRANCH_97FC: ; branched to from 97F4
97FC	FD 1A             POP	    Y                           ;
97FE	FD 88             PUSH	    X                           ;
9800	CE 58 12          VEJ	    ($CE),$58,BRANCH_9815       ; Determines variable 'n1' address all variable types allowed, if errors continue at P+n2
9803	F6 78 86          VEJ       ($F6),(LASTVARADD_H)        ; Copy U-REG to 7886-87
9806	44                INC	    X                           ;
9807	A5 7A 07          LDA	    (ARX + $07)                 ;
980A	0E                STA	    (X)                         ;
980B	FD 0A             POP	    X                           ;
980D	FD 98             PSH	    Y                           ; 
980F	FD 5A             STX       Y                           ; Y = X
9811	9E 9F             BCH-      BRANCH_9774                 ;
9813	68 01             LDI	    UH,$01                      ;

BRANCH_9815: ; branched to from 9800
9815	FD 0A             POP	    X                           ;
9817	9E AB             BCH-      BRANCH_976E                 ;

BRANCH_9819: ; branched to from 97B4, 97BE
9819	9E AF             BCH-      BRANCH_976C                 ;



;------------------------------------------------------------------------------------------------------------
; 981B ~ 981E seperator bytes
SEPARATOR_981B:
981B	FF 00 FF 01 BF



;------------------------------------------------------------------------------------------------------------
; FEED - Jumped to from 8307 via High Bank
; Arguments: XREG = Address, YREG = Token,
; Outputs:
; RegMod:
FEED:
9820   A5 79 D1         LDA         (OPN)             ; This table might be some sort of mode mask
9823   AE 7B 9E         STA         (OUT_BUF + $3E)             ; In OUTPUT_BUFFER
9826   B5 6C            LDI         A,$6C                       ;
9828   BE 98 B7         SJP         SUB_98B7                    ;
982B   C8               VEJ         ($C8),BRANCH_9831           ; Syntax check: Jump fwd (p) if following character doesn’t represent end to command sequence or line. 
982D   6A 00            LDI         UL,$00                      ;
982F   8E 0C            BCH+        BRANCH_983D                 ;

BRANCH_9831:
9831   C6               VEJ         ($C6)                       ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
9832   DE               VEJ         ($DE),BRANCH_985E           ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
9834   D0               VEJ         ($D0),$01,BRANCH_985E       ; Convert AR-X to integer & load to U-Reg. p specifies the range. If range exceeded: Branch fwd n
9837   C8               VEJ         ($C8),BRANCH_985C           ; Syntax check: Jump fwd (p) if following character doesn’t represent end to command sequence or line. 
9839   F4 7A 05         VEJ         ($F4),(ARX + $05)           ; Loads U-Reg with $7A05
983C   66               DEC         U

BRANCH_983D:
983D   A5 7B A6         LDA         (OUT_BUF + $46)             ; In OUT_BUF
9840   8B 05            BZS+        BRANCH_9847                 ;
9842   DD               INC         A                           ;
9843   B7 A7            CPI         A,$A7                       ;
9845   8B 07            BZS+        BRANCH_984E                 ;

BRANCH_9847:
9847   B5 20            LDI         A,$20                       ;
9849   BE 7B AA         SJP         OUT_BUF + $4A               ; In OUT_BUF what code has been poked in here?
984C   83 10            BCS+        BRANCH_985E                 ;

BRANCH_984E:
984E   BE 9B 41         SJP         SUB_9B41                    ; No idea  
9851   83 0B            BCS+        BRANCH_985E                 ;
9853   88 0E            LOP         UL,BRANCH_9847              ;
9855   FD 62            DEC         UH                          ;
9857   93 12            BCS-        BRANCH_9847                 ;
9859   BA 96 0C         JMP         JMP_960C                    ;

BRANCH_985C:
985C   68 01            LDI         UH,$01                      ;

BRANCH_985E:
985E   BA 96 2B         JMP         BRANCH_962B                 ;



;------------------------------------------------------------------------------
SEPARATOR_9862:
9861	FA 00 FF 00 FF 45 F7 00 FF   00 FF 00 FF 02 FF



;-------------------------------------------------------------------------------
; *** What calls this ***REACHED
9870	DE 14             VEJ	    ($DE),BRANCH_9886           ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
9872	D0 09 11          VEJ       ($D0),$09,BRANCH_9886       ; Convert AR-X to integer & load to U-Reg. p specifies the range. If range exceeded: Branch fwd n
9875	68 35             LDI	    UH,$35                      ;
9877	BF E0             BII	    A,$E0                       ;
9879	C9 E0             VZR       ($E0)                       ; If Z Reset do Indexed Vectored Call. HB = $FF, LB = n ($00-$F6)
987B	E9 78 56 E0       ANI	    (ZONE_REG),$E0              ;
987F	AB 78 56          ORA	    (ZONE_REG)                  ;
9882	AE 78 56          STA	    (ZONE_REG)                  ;
9885	E2                VEJ       ($E2)                       ; Start of Basic Interpreter

BRANCH_9886: ; branched to from 9870, 9872
9886	E0                VEJ       ($E0)                       ; Indicates if UH is not "00" error message



;-------------------------------------------------------------------------------------
; TBL_9887 - Used by BRANCH_9924
; 
TBL_9887:
9887	BA 82 8E          JMP	    BRANCH_828E                 ; Sends data to LPT output
988A	BA 9B 1C          JMP	    SUB_9B1C                    ;
988D	BA 82 3A          JMP	    TXCOM                       ; Sends charecter in A to RS232 Port.
9890	BA 9B 31          JMP	    SUB_9B31                    ;
9893	BA 82 5B          JMP	    TXLPT                       ;
9896	BA 9B 31          JMP	    SUB_9B31                    ;
9899	BA 82 5B          JMP	    TXLPT                       ;
989C	BA 9B 31          JMP	    SUB_9B31                    ;
989F	BA 9C 99          JMP	    JMP_9C99                    ;
98A2	BA 9B 1C          JMP	    SUB_9B1C                    ;
98A5	BA 9C 60          JMP	    JMP_9C60                    ;
98A8	BA 9B 31          JMP	    SUB_9B31                    ;
98AB	BA 82 5B          JMP	    TXLPT                       ;
98AE	BA 9B 31          JMP	    SUB_9B31                    ;
98B1	BA 82 5B          JMP	    TXLPT                       ;
98B4	BA 9B 31          JMP	    SUB_9B31                    ;



;--------- ---------------------------------------------------------------------------------------------------
; SUB_98B7 - Called from 9828 Feed, 93E0 PRINT#2, 9362 SUB_9350
; 
; Arguments:
; Output:
; RegMod:
SUB_98B7:
98B7	FD C8             PSH	    A                           ; Why PUSH then POP?
98B9	FD 8A             POP	    A                           ;
98BB	8E 04             BCH+	    BRANCH_98C1                 ;



;--------- ---------------------------------------------------------------------------------------------------
; SUB_98BD - Called from 9152
; 
; Arguments:
; Output:
; RegMod:
SUB_99BD: 
98BD	A5 7B A1          LDA	    (OUT_BUF + $41)             ; In OUT_BUF

SUB_98C0: ; called from 936C
98C0	38                NOP                                   ;

BRANCH_98C1: ; branched to from 98BB 
98C1	B9 7F             ANI       A,$7F                       ;
98C3	AE 7B A1          STA	    (OUT_BUF + $41)             ; In OUT_BUF
98C6	FD E9 F0 0A FC    ANI       #(PC1500_MSK_REG),$FC       ; Clear IRQ and ON Key interrupt mask for PC-1500
98CB	4A 87             LDI	    XL,$87                      ;
98CD	48 98             LDI	    XH,$98                      ; X = 9887, TBL_9887 X used in 9924
98CF	FD 98             PSH	    Y                           ;
98D1	5A A6             LDI	    YL,$A6                      ;
98D3	58 7B             LDI	    YH,$7B                      ; Y = (OUT_BUF + $46)
98D5	B9 40             ANI       A,$40                       ;
98D7	8B 1F             BZS+      BRANCH_98F8                 ;
98D9	A5 7B 9E          LDA	    (OUT_BUF + $3E)             ; in OUT_BUF
98DC	B7 C4             CPI	    A,$C4                       ;
98DE	8B 01             BZS+      BRANCH_98E1                 ;
98E0	F9                REC                                   ; Reset Carry

BRANCH_98E1: ; branched to from 98DE
98E1	A5 78 51          LDA	    (RS232C)                    ; *** need to figure out what this is
98E4	81 03             BCR+      BRANCH_98E9                 ;
98E6	A5 78 52          LDA	    (RS232C_2)               ; *** need to figure out what this is

BRANCH_98E9: ; branched to from 98E4
98E9	51                SIN	    (Y)                         ; (Y) = A. Then Y = Y + 1. OUT_BUF + 46 + 1 = 7AB7
98EA	A5 78 53          LDA	    (CE158_UNDEF1)              ; *** need to figure out what this is
98ED	81 03             BCR+      BRANCH_98F2                 ;
98EF	A5 78 54          LDA	    (CE158_UNDEF2)              ; *** need to figure out what this is

BRANCH_98F2: ; branched to from 98ED
98F2	51                SIN	    (Y)                         ; (Y) = A. Then Y = Y + 1. OUT_BUF + 47 + 1 = 7AB8
98F3	A5 78 55          LDA	    (CRLF_REG)                 ; *** need to figure out what this is
98F6	8E 02             BCH+	    BRANCH_98FA                 ;

BRANCH_98F8: ; branched to from 98D7
98F8	51                SIN	    (Y)                         ; (Y) = A. Then Y = Y + 1. 7BA8 + 1 = 7AB9
98F9	51                SIN	    (Y)                         ; (Y) = A. Then Y = Y + 1. OUT_BUF + 49 + 1 = 7ABA

BRANCH_98FA: ; branched to from 98F6
98FA	81 01             BCR+      BRANCH_98FD                 ;
98FC	F1                AEX                                   ; Accumulator High nibble & low nibble swapped

BRANCH_98FD: ; branched to from 98FA
98FD	6A 0D             LDI	    UL,$0D                      ;
98FF	B9 07             ANI       A,$07                       ;
9901	D5                SHR                                   ;
9902	81 02             BCR+      BRANCH_9906                 ;
9904	6A 0A             LDI	    UL,$0A                      ;

BRANCH_9906: ; branched to from 9902
9906	8B 07             BZS+      BRANCH_990F                 ;
9908	D5                SHR                                   ;
9909	B5 0D             LDI	    A,$0D                       ;
990B	83 02             BCS+      BRANCH_990F                 ;
990D	B5 0A             LDI	    A,$0A                       ;

BRANCH_990F: ; branched to from 9906, 990B
990F	51                SIN	    (Y)                         ; (Y) = A. Then Y = Y + 1
9910	24                LDA	    UL                          ;
9911	51                SIN	    (Y)                         ; (Y) = A. Then Y = Y + 1
9912	A5 7B 9E          LDA	    (OUT_BUF + $3E)             ;
9915	B7 C4             CPI	    A,$C4                       ;
9917	8B 01             BZS+      BRANCH_991A                 ;

BRANCH_9919:
9919	F9                REC                                   ; Reset Carry

BRANCH_991A: ; branched to from 9917
991A	A5 7B A1          LDA	    (OUT_BUF + $41)             ; In OUT_BUF
991D	F1                AEX                                   ;
991E	B9 0A             ANI       A,$0A                       ;
9920	81 02             BCR+      BRANCH_9924                 ;
9922	B5 06             LDI	    A,$06                       ;

BRANCH_9924: ; branched to from 9920                            ; X = X = 9887, uses TBL_9887
9924	FD CA             ADR	    X                           ; X = X + A + Carry. A = ?? or 06.  X = 9887 + 1 = 9888
9926	D9                SHL                                   ;
9927	FD CA             ADR	    X                           ; X = X + A + Carry
9929	F5                TIN                                   ; (Y) = (X) then X = X + 1, Y = Y + 1. X = 9888 + 1 = 9889
992A	F5                TIN                                   ; (Y) = (X) then X = X + 1, Y = Y + 1. X = 9889 + 1 = 988A
992B	F5                TIN                                   ; (Y) = (X) then X = X + 1, Y = Y + 1. X = 988A + 1 = 988B
992C	F5                TIN                                   ; (Y) = (X) then X = X + 1, Y = Y + 1. X = 988B + 1 = 988C
992D	F5                TIN                                   ; (Y) = (X) then X = X + 1, Y = Y + 1. X = 988C + 1 = 988D
992E	F5                TIN                                   ; (Y) = (X) then X = X + 1, Y = Y + 1. X = 988D + 1 = 988E
992F	FD 1A             POP	    Y                           ;
9931	BF 04             BII	    A,$04                       ;
9933	8B 0F             BZS+      BRANCH_9944                 ;
9935	BF 10             BII	    A,$10                       ;
9937	8B 0A             BZS+      BRANCH_9943                 ;

BRANCH_9939: ; branched to from 9940
9939	BE 9C FD          SJP	    SUB_9CFD                    ;
993C	81 05             BCR+      BRANCH_9943                 ;
993E	6C 38             CPI	    UH,$38                      ;
9940	9B 09             BZS-      BRANCH_9939                 ;
9942	FB                SEC                                   ; Set Carry

BRANCH_9943: ; branched to from 9937, 993C
9943	9A                RTN                                   ;

BRANCH_9944: ; branched to from 9933
9944	BE 81 E6          SJP	    RXCOM                    ; Manipulates LPT/UART registers
9947	F9                REC                                   ; Reset Carry
9948	9A                RTN                                   ;



;-------------------------------------------------------------------------------------------------------------
; SUB_9949 - Called from 935B SUB_9350, 9148 SUB_90AE
; 
; Arguments:
; Output:
; RegMod:
SUB_9949: 
9949	FD 6A             STX       U                           ; U = X
994B	F6 7B 75          VEJ       ($F6),(OUT_BUF + $15)       ; Transfers U to pp, pp+1 in OUT_BUF 
994E	C8 02             VEJ       ($C8),BRANCH_9952           ; Jump fwd (p) if following character doesn’t represent end to command sequence or line. 
9950	8E 2E             BCH+	    BRANCH_9980                 ;

BRANCH_9952: ; branched to from 994E
9952	C4 2C 02          VEJ       ($C4),',',BRANCH_9957       ; Check tokens/char in U-Reg if not ',' branch fwd n
9955	8E 27             BCH+	    BRANCH_997E                 ;

BRANCH_9957: ; branched to from 9952
9957	C6                VEJ       ($C6)                       ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
9958	DE 1F             VEJ       ($DE),BRANCH_9979           ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
995A	D0 83 1C          VEJ       ($D0),$83,BRANCH_9979       ; Convert AR-X to integer & load to U-Reg. p specifies the range. If range exceeded: Branch fwd n
995D	BE D2 EA          SJP	    LINESEARCH,BRANCH_9973      ; Search for line # from adddress in U-Reg; update program pointer. If not found, jump to Distance Address.

BRANCH_9961: ; branched to from 9977
9961	F4 78 A6          VEJ 	    ($F4),(SRCH_ADD_H)          ; Loads U-Reg with Address of linefound during search (H)
9964	66                DEC	    U                           ;
9965	66                DEC	    U                           ;
9966	66                DEC	    U                           ; The backs up three spots?
9967	F6 7B 75          VEJ       ($F6),(OUT_BUF + $15)       ; Transfers U to pp, pp+1
996A	C8 0F             VEJ       ($C8),BRANCH_997B           ; Jump fwd (p) if following character doesn’t represent end to command sequence or line. 
996C	F4 7B 75          VEJ 	    ($F4),(OUT_BUF + $15)       ; Loads U-Reg with 16-bit value from address of (pp)
996F	64                INC	    U                           ;
9970	64                INC	    U                           ;
9971	8E 2B             BCH+	    BRANCH_999E                 ;

BRANCH_9973:
9973	81 04             BCR+      BRANCH_9979                 ;
9975	6C 0B             CPI	    UH,$0B                      ;
9977	9B 18             BZS-      BRANCH_9961                 ;

BRANCH_9979: ; branched to from 9958, 995A, 9973
9979	F9                REC                                   ; Reset Carry
997A	9A                RTN                                   ;


BRANCH_997B: ; branched to from 9958, 996A
997B	C4 2C CE          VEJ       ($C4),',',BRANCH_9A4C       ; Check tokens/char in U-Reg if not ',' branch fwd n (branch borrows exit)

BRANCH_997E: ; branched to from 9955
997E	C8 05             VEJ       ($C8),BRANCH_9985           ; Jump fwd (p) if following character doesn’t represent end to command sequence or line. 

BRANCH_9980: ; branched to from 9950
9980	F4 78 67          VEJ 	    ($F4),(BASPRG_END_H)        ; Loads U-Reg with End of Basic program in RAM (H)
9983	8E 1C             BCH+	    BRANCH_99A1                 ;

BRANCH_9985: ; branched to from 997E
9985	C6                VEJ       ($C6)                       ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
9986	DE 63             VEJ       ($DE),BRANCH_99EB           ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
9988	D0 83 60          VEJ       ($D0),$83,BRANCH_99EB       ; Convert AR-X to integer & load to U-Reg. p specifies the range. If range exceeded: Branch fwd n
998B	FD A8             PSH	    U                           ;
998D	F4 7B 75          VEJ 	    ($F4),(OUT_BUF + $15)       ; Loads U-Reg with 16-bit value from address of (pp)
9990	FD 28             LDX	    U                           ; X = U
9992	FD 2A             POP	    U                           ;
9994	BE D2 EC 4D       SJP	    SRCHPRGLINE,$4D             ; Search for program line, jump if not found
9998	C8 53             VEJ       ($C8),$53                   ; Syntax check: Jump fwd (n1) if following character doesn’t represent end to command sequence or line. C=1 if ":"
999A	F4 78 A6          VEJ 	    ($F4),(SRCH_ADD_H)          ; Address of linefound during search (H)
999D	66                DEC	    U                           ;

BRANCH_999E: ; branched to from 9971
999E	65                LIN	    (U)                         ; A = (U) then INC U
999F	FD EA             ADR	    U                           ; U = U + A + Carry

BRANCH_99A1: ; branched to from 9983
99A1	F6 7B 79          VEJ       ($F6),(OUT_BUF + $19)       ; Transfers U to pp, pp+1
99A4	F4 7B 75          VEJ 	    ($F4),(OUT_BUF + $15)       ; Loads U-Reg with 16-bit value from address of (pp)
99A7	FD 28             LDX	    U                           ; X = U
99A9	F4 7B 79          VEJ 	    ($F4),(OUT_BUF + $19)       ; Loads U-Reg with 16-bit value from address of (pp)
99AC	FB                SEC                                   ; Set Carry
99AD	A5 78 68          LDA	    (BASPRG_END_L)              ; End of Basic program in RAM (L)
99B0	20                SBC	    UL                          ; A = A - UL. Subtract with Carry
99B1	A5 78 67          LDA	    (BASPRG_END_H)              ; End of Basic program in RAM (H)
99B4	A0                SBC	    UH                          ; A = A - UH. Subtract with Carry
99B5	81 2A             BCR+      BRANCH_99E1                 ;
99B7	A4                LDA	    UH                          ;
99B8	A7 78 64          CPA	    (RAM_END_H)                 ; End of RAM pointer (H)
99BB	83 24             BCS+      BRANCH_99E1                 ;
99BD	BE DF E1          SJP	    (U_MINUS_X - 1)             ; DEC U then U-Reg = U-Reg - X-Reg (with overflow C=1)
99C0	F6 7B 77          VEJ       ($F6),(OUT_BUF + $17)       ; Transfers U to pp, pp+1
99C3	F4 7B 75          VEJ 	    ($F4),(OUT_BUF + $15)       ; Loads U-Reg with 16-bit value from address of (pp)
99C6	A7 78 65          CPA	    (BASPRG_ST_H)               ; Compare A and Start of Basic program in RAM (H)
99C9	81 05             BCR+      BRANCH_99D0                 ;
99CB	A7 78 63          CPA	    (RAM_ST_H)                  ; Compare A and Start of RAM pointer
99CE	83 10             BCS+      BRANCH_99E0                 ;

BRANCH_99D0: ; branched to from 99C9
99D0	CC 60             VEJ       ($CC),($60)                 ; Loads X-Reg with address at 78(pp) 78(pp+1) 7860 - Start of ROM in module
99D2	68 1F             LDI	    UH,$1F                      ;
99D4	4A 00             LDI	    XL,$00                      ;
99D6	05                LDA	    (X)                         ;
99D7	B7 55             CPI	    A,$55                       ;
99D9	F9                REC                                   ; Reset Carry
99DA	89 04             BZR+      BRANCH_99E0                 ;
99DC	4A 07             LDI	    XL,$07                      ;
99DE	05                LDA	    (X)                         ;
99DF	D9                SHL                                   ;

BRANCH_99E0: ; branched to from 99CE
99E0	9A                RTN                                   ;


BRANCH_99E1: ; branched to from 99B5, 99BB
99E1	68 1F             LDI	    UH,$1F                      ;
99E3	F9                REC                                   ; Reset Carry
99E4	9A                RTN                                   ;


99E5	81 04             BCR+      BRANCH_99EB                 ; These three line bogus?
99E7	6C 0B             CPI	    UH,0B                       ; These three line bogus?
99E9	9B 53             BZS-      9998                        ; These three line bogus?

BRANCH_99EB: ; branched to from 9986, 9988, 99E5
99EB	F9                REC                                   ; Reset Carry
99EC	9A                RTN                                   ;



;------------------------------------------------------------------------------------------------------------
; SUB_99ED, 99EF - Called from 
; 
; Arguments:
; Output:
; RegMod:
99ED	8E 5D             BCH+	    BRANCH_9A4C                 ; is this reached

SUB_99EF: ; called from 914D SUB_90AE
99EF	85 29             BHR+      BRANCH_9A1A                 ;
99F1	DE 5B             VEJ       ($DE),BRANCH_9A4E           ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
99F3	D0 00 58          VEJ       ($D0),$00,BRANCH_9A4E       ; Convert AR-X to integer & load to U-Reg. p specifies the range. If range exceeded: Branch fwd n
99F6	F6 7B 75          VEJ       ($F6),(OUT_BUF + $15)       ; Transfers U to pp, pp+1
99F9	C2 2C 50          VEJ   	($C2),',',BRANCH_9A4C       ; If next character is not ''', branch fwd 'n'. If 'p' is Fn then 3 args, if not 2 args
99FC	DE 50             VEJ       ($DE),BRANCH_9A4E           ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
99FE	D0 01 4D          VEJ       ($D0),$01,BRANCH_9A4E       ; Convert AR-X to integer & load to U-Reg. p specifies the range. If range exceeded: Branch fwd n
9A01	A5 7B 75          LDA	    (OUT_BUF + $15)             ;
9A04	08                STA	    XH                          ;
9A05	A5 7B 76          LDA	    (OUT_BUF + $16)             ;
9A08	0A                STA	    XL                          ;
9A09	BE DF E2          SJP	    U_MINUS_X                   ; U-Reg= U-Reg - X-Reg (with overflow C=1)
9A0C	81 41             BCR+      BRANCH_9A4F                 ;
9A0E	F6 7B 77          VEJ       ($F6),(OUT_BUF + $17)       ; Transfers U to pp, pp+1
9A11	C8 0B             VEJ       ($C8),BRANCH_9A1E           ; Jump fwd (p) if following character doesn’t represent end to command sequence or line. 

BRANCH_9A13: ; branched to from 9A1C
9A13	68 FF             LDI	    UH,FF                       ;
9A15	6A FF             LDI	    UL,FF                       ;
9A17	56                DEC	    Y                           ;
9A18	8E 0E             BCH+	    BRANCH_9A28                 ;


BRANCH_9A1A: ; branched to from 99EF
9A1A	C8 06             VEJ       ($C8),BRANCH_9A22           ; Jump fwd (p) if following character doesn’t represent end to command sequence or line. 
9A1C	9E 0B             BCH-	    BRANCH_9A13                 ;


BRANCH_9A1E: ; branched to from 9A11
9A1E	C4 2C 2B          VEJ       ($C4),',',BRANCH_9A4C       ; Check tokens/char in U-Reg if not ',' branch fwd n
9A21	C0                VEJ       ($C0)                       ; Load next character/token to U-Reg

BRANCH_9A22: ; branched to from 9A1A
9A22	C6                VEJ       ($C6)                       ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
9A23	DE 29             VEJ       ($DE),BRANCH_9A4E           ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
9A25	D0 00 26          VEJ       ($D0),$00,BRANCH_9A4E       ; Convert AR-X to integer & load to U-Reg. p specifies the range. If range exceeded: Branch fwd n

BRANCH_9A28: ; branched to from 9A18
9A28	F6 7B 79          VEJ       ($F6),(OUT_BUF + $19)       ; Transfers U to pp, pp+1
9A2B	8E 1B             BCH+	    BRANCH_9A48                 ;



;--------- ---------------------------------------------------------------------------------------------------
; SUB_9A32 - Called from 9130
; 
; Arguments:
; Output:
; RegMod:
SUB_9A2D:
9A2D	BE DF EE          SJP	    MEM_IN_UREG                 ; Calculates the available memory space (MEM) in U-Reg.
9A30	8E 09             BCH+	    BRANCH_9A3B                 ;


SUB_9A32: ; called from 9124
9A32	6A BB             LDI	    UL,$BB                      ;
9A34	68 00             LDI	    UH,$00                      ; U = 00BB
9A36	8E 05             BCH+	    BRANCH_9A3D                 ;

SUB_9A38: ; called from 9139
9A38	BE DF D9          SJP	    (ARX2STRBUF + $15)          ; Inside: Save String buffer pointers to X-Reg and AR-X. Updating pointer with YL

BRANCH_9A3B: ; branched to from 9A30
9A3B	81 12             BCR+      BRANCH_9A4F                 ;

BRANCH_9A3D: ; branched to from 9A36
9A3D	84                LDA	    XH                          ;
9A3E	AE 7B 75          STA	    (OUT_BUF + $15)             ;
9A41	04                LDA	    XL                          ;
9A42	AE 7B 76          STA	    (OUT_BUF + $16)             ;
9A45	F6 7B 77          VEJ	    ($F6),(OUT_BUF + $17)       ; Transfers U to pp, pp+1

BRANCH_9A48:
9A48	C8 02             VEJ       ($C8),BRANCH_9A4C           ; Jump fwd (p) if following character doesn’t represent end to command sequence or line. 

BRANCH_9A4A: ; branched to from 9A81
9A4A	FB                SEC                                   ; Set Carry
9A4B	9A                RTN                                   ;


BRANCH_9A4C: ; branched to from 9A48, 997B
9A4C	68 01             LDI	    UH,$01                      ;

BRANCH_9A4E:
9A4E	F9                REC                                   ; Reset carry

BRANCH_9A4F: ; branched to 9A3B
9A4F	9A                RTN                                   ;



;------------------------------------------------------------------------------------------------------------
; SUB_9A50 - Called from 9419
; 
; Arguments:
; Output:
; RegMod:
SUB_9A50:
9A50	B5 00             LDI	    A,$00                       ;

BRANCH_9A52: ; branched to from 9A5F
9A52	2A                STA	    UL                          ;
9A53	FB                SEC                                   ;
9A54	A1 7B A7          SBC	    (OUT_BUF + $47)             ;
9A57	83 13             BCS+      BRANCH_9A6C                 ;
9A59	A5 78 56          LDA	    (ZONE_REG)                  ; 
9A5C	B9 1F             ANI	    A,$1F                       ;
9A5E	22                ADC	    UL                          ;
9A5F	91 0F             BCR-      BRANCH_9A52                 ;
9A61	A1 7B A7          SBC	    (OUT_BUF + $47)             ;
9A64	2A                STA	    UL                          ;
9A65	A5 7B A6          LDA	    (OUT_BUF + $46)             ;
9A68	89 0B             BZR+      BRANCH_9A75                 ;
9A6A	8E 24             BCH+	    BRANCH_9A90                 ;

BRANCH_9A6C: ; branched to from 9A57
9A6C	2A                STA	    UL                          ;
9A6D	A5 7B A6          LDA	    (OUT_BUF + $46)             ;
9A70	8B 1E             BZS+      BRANCH_9A90                 ;
9A72	26                CPA	    UL                          ;
9A73	83 1B             BCS+      BRANCH_9A90                 ;

BRANCH_9A75: ; branched to from 9A68
9A75	BA 9B 41          JMP	    SUB_9B41                    ;



;--------- ---------------------------------------------------------------------------------------------------
; SUB_9A78 - Called from 9419
; 
; Arguments:
; Output:
; RegMod:
SUB_9A78:
9A78	FB                SEC                                   ;
9A79	68 35             LDI	    UH,$35                      ;
9A7B	A5 7B A6          LDA	    (OUT_BUF + $46)             ;
9A7E	8B 03             BZS+      BRANCH_9A83                 ;
9A80	20                SBC	    UL                          ; A = A - UL
9A81	91 39             BCR-      BRANCH_9A4A                 ;

BRANCH_9A83: ; branched to from 9A7E
9A83	24                LDA	    UL                          ;
9A84	A1 7B A7          SBC	    (OUT_BUF + $47)             ;  
9A87	83 06             BCS+      BRANCH_9A8F                 ;
9A89	BE 9B 41          SJP	    SUB_9B41                    ; No idea, seems to manipualte OUT_BUF
9A8C	83 0E             BCS+      BRANCH_9A9C                 ;
9A8E	24                LDA	    UL                          ;

BRANCH_9A8F: ; branched to from 9A87, 9AA3
9A8F	2A                STA	    UL                          ;

BRANCH_9A90: ; branched to from 9A6A, 9A70, 9A73
9A90	62                DEC	    UL                          ;
9A91	81 09             BCR+      BRANCH_9A9C                 ;

BRANCH_9A93: ; branched to from 9A93
9A93	B5 20             LDI	    A,$20                       ;
9A95	BE 9B 32          SJP	    SUB_9B32                    ; No idea, seems to manipualte OUT_BUF
9A98	83 02             BCS+      BRANCH_9A9C                 ;
9A9A	88 09             LOP	    UL,BRANCH_9A93              ; UL = UL - 1, loop back 'e' if Borrow Flag not set

BRANCH_9A9C: ; branched to from9A8C, 9A91, 9A98, 9AA0
9A9C	9A                RTN                                   ;


BRANCH_9A9D:
9A9D	BE 9A CF          SJP	    SUB_9ACF                    ; Copies some stuff in OUT_BUF
9AA0	93 06             BCS-      BRANCH_9A9C                 ;   
9AA2	A4                LDA	    UH                          ;
9AA3	9E 16             BCH-	    BRANCH_9A8F                 ;



;--------- ---------------------------------------------------------------------------------------------------
; SUB_9AA5 - Called from 92D4, 9739, 9CF1, 9D76
; 
; Arguments:
; Output:
; RegMod:
SUB_9AA5:
9AA5	68 00             LDI	    UH,$00                      ;

BRANCH_9AA7: ; Jmped to from 9177
9AA7	BE 9B E1          SJP	    SUB_9BE1                    ; Manipulates OUT_BUF

BRANCH_9AAA: ; branched to from 9AC9
9AAA	83 15             BCS+      SUB_9AC1                    ; No idea
9AAC	BE 9A CF          SJP	    SUB_9ACF                    ; Copies some stuff in OUT_BUF
9AAF	BE 9A E6          SJP	    SUB_9AE6                    ; No idea
9AB2	83 0D             BCS+      SUB_9AC1                    ; No idea
9AB4	A5 7B 99          LDA	    (OUT_BUF + $39)             ;
9AB7	2A                STA	    UL                          ;
9AB8	A5 7B 98          LDA	    (OUT_BUF + $38)             ;
9ABB	28                STA	    UH                          ;
9ABC	FD 62             DEC	    UH                          ;
9ABE	93 19             BCS-      BRANCH_9AA7                 ;

BRANCH_9AC0: ; branched to from
9AC0	9A                RTN                                   ;



;--------- ---------------------------------------------------------------------------------------------------
; SUB_9AC1 - Called from 9AAA 9AB2 SUB_9AA5
; 
; Arguments:
; Output:
; RegMod:
SUB_9AC1:
9AC1	BE 9B 5E          SJP       SUB_9B5E                    ; REC if UH == 3C, 34, 40, 3A
9AC4	93 06             BCS-      BRANCH_9AC0                 ; If no match, borrow a return
9AC6	BE 9C 32          SJP       SUB_9C32                    ; Pulls some valuse out of OUT_BUF and saves to XH, XL, UH, UL, A
9AC9	9E 21             BCH-	    BRANCH_9AAA                 ;



;--------- ---------------------------------------------------------------------------------------------------
; SUB_9ACB - Called from 9AAC
; Copies some stuff in OUT_BUF
; Arguments:
; Output:
; RegMod:
BRANCH_9ACB: ; branched to from 9AE2
9ACB	4A B0             LDI	    XL,$B0                      ;
9ACD	6A 4F             LDI	    UL,$4F                      ;

SUB_9ACF: ; Called from 91B8, 95B6, 95C9, 95E1, 9A9D, 9AAC   branched to from 9AD4
9ACF	BE 7B AD          SJP       (OUT_BUF + $4D)             ;
9AD2	83 11             BCS+      BRANCH_9AE5                 ;
9AD4	88 07             LOP       UL,SUB_9ACF                 ; UL = UL - 1, loop back 'e' if Borrow Flag not set
9AD6	ED 7B A1 20       BII	    (OUT_BUF + $41),$20         ;
9ADA	89 09             BZR+      BRANCH_9AE5                 ;
9ADC	4C 7B             CPI	    XH,$7B                      ;
9ADE	89 04             BZR+      BRANCH_9AE4                 ;
9AE0	4E 60             CPI	    XL,$60                      ; X = 7B60
9AE2	9B 19             BZS-      BRANCH_9ACB                 ;

BRANCH_9AE4: ; branched to from 9ADE
9AE4	F9                REC                                   ; Reset Carry

BRANCH_9AE5: ; branched to from 9AD2, 9ADA
9AE5	9A                RTN                                   ;



;--------- ---------------------------------------------------------------------------------------------------
; SUB_9AE6 - 
; 
; Arguments:
; Output:
; RegMod:
SUB_9AE6:
9AE6	ED 7B A1 80       BII	    (OUT_BUF + $41),$80         ;
9AEA	8B 24             BZS+      BRANCH_9B10                 ;
9AEC	81 0A             BCR+      BRANCH_9AF8                 ;
9AEE	6C 3F             CPI	    UH,$3F                      ;
9AF0	8B 16             BZS+      BRANCH_9B08                 ;
9AF2	6C 3E             CPI	    UH,$3E                      ;
9AF4	8B 0D             BZS+      BRANCH_9B03                 ;

BRANCH_9AF6: ; called from 9B14
9AF6	FB                SEC                                   ;

BRANCH_9AF7: ; called from 9B01, 9B06, 9B0B, 9B10
9AF7	9A                RTN                                   ;


BRANCH_9AF8: ; called from 9AEC
9AF8	ED 7B A1 20       BII	    (OUT_BUF + $41),$20         ;
9AFC	8B 05             BZS+      BRANCH_9B03                 ;
9AFE	BE 9B C1          SJP	    SUB_9BC1                    ; Manipulates OUT_BUF
9B01	9E 0C             BCH-	    BRANCH_9AF7                 ;

BRANCH_9B03: ; called from 9AF4, 9AFC
9B03	BE 9E 54          SJP	    SUB_9E54                    ; No idea
9B06	93 11             BCS-      BRANCH_9AF7                 ;

BRANCH_9B08: ; called from 9AF0
9B08	BE 9C 94          SJP	    SUB_9C94                    ; No idea
9B0B	93 16             BCS-      BRANCH_9AF7                 ;
9B0D	BA 9C 48          JMP	    SUB_9C48                    ;

BRANCH_9B10: 
9B10	91 1B             BCR-      BRANCH_9AF7                 ;
9B12	6C 3E             CPI	    UH,$3E                      ;
9B14	99 20             BZR-      BRANCH_9AF6                 ;
9B16	E9 7B 98 00       ANI	    (OUT_BUF + $38),$00         ;
9B1A	F9                REC                                   ;
9B1B	9A                RTN                                   ;



;------------------------------------------------------------------------------------------------------------
; SUB_9B1C - Called from 988A, 98A2
; 
; Arguments:
; Output:
; RegMod:
SUB_9B1C:
9B1C	BE 7B AA          SJP	    (OUT_BUF + 4A)              ; Great, this is calling a sub poked into OUT_BUF which is manipualted everywhere!
9B1F	83 0E             BCS+      BRANCH_9B2F                 ;
9B21	B7 0D             CPI	    A,$0D                       ;
9B23	F9                REC                                   ;
9B24	89 09             BZR+      BRANCH_9B2F                 ;
9B26	ED 7B A1 04       BII	    (OUT_BUF + $41),$04         ;
9B2A	8B 03             BZS+      BRANCH_9B2F                 ;
9B2C	FB                SEC                                   ;
9B2D	68 3E             LDI	    UH,$3E                      ;

BRANCH_9B2F: ; called from 9B1F, 9B24, 9B2A
9B2F	41                SIN       X                           ; (X) = A. Then X = X + 1
9B30	9A                RTN                                   ;



;--------- ---------------------------------------------------------------------------------------------------
; SUB_9B31 - 9890, 9896, 989C, 98A8, 98B4
; 
; Arguments:
; Output:
; RegMod:
SUB_9B31:
9B31	45                LIN	    X                           ; A = (X), X = X + 1

SUB_9B32: ; called from 9A95
9B32	BE 7B AA          SJP       (OUT_BUF + $4A)             ; Great, this is calling a sub poked into OUT_BUF which is manipualted everywhere!
9B35	83 20             BCS+      BRANCH_9B57                 ;
9B37	A5 7B A6          LDA	    (OUT_BUF + $46)             ;
9B3A	8B 1C             BZS+      BRANCH_9B58                 ;
9B3C	A1 7B A7          SBC	    (OUT_BUF + $47)             ; A = A - (pp)
9B3F	83 17             BCS+      BRANCH_9B58                 ;

SUB_9B41: ; called from  9209, 9239
9B41	A5 7B A9          LDA	    (OUT_BUF + $49)             ;
9B44	BE 7B AA          SJP       (OUT_BUF + $4A)             ; Great, this is calling a sub poked into OUT_BUF which is manipualted everywhere!
9B47	83 0E             BCS+      BRANCH_9B57                 ;
9B49	A5 7B A8          LDA	    (OUT$BUF + $48)             ;
9B4C	8B 05             BZS+      BRANCH_9B53                 ;
9B4E	BE 7B AA          SJP       (OUT_BUF + $4A)             ; Great, this is calling a sub poked into OUT_BUF which is manipualted everywhere!
9B51	83 04             BCS+      BRANCH_9B57                 ;

BRANCH_9B53: ; branched to from 9B4C
9B53	E9 7B A7 00       ANI	    (OUT_BUF + $47),$00         ;

BRANCH_9B57: ; branched to from 9B35, 9B47, 9B51
9B57	9A                RTN                                   ;


BRANCH_9B58: ; branched to from 9B3A, 9B3F
9B58	EF 7B A7 01       ADI	    (OUT_BUF + $47),$01         ;

BRANCH_9B5C: ; branched to from 9B66, 9B6A, 9B72
9B5C	F9                REC                                   ; Rest Carry
9B5D	9A                RTN                                   ; 



;------------------------------------------------------------------------------------------------------------
; SUB_9B5E - 
; If (OUT_BUF  + 41) * 2 does not overflow then comapre UH to multiple values
; Arguments:
; Output: SEC if (OUT_BUF  + 41) * 2 does not overflow or no match
;         REC if UH == 3C, 34, 40, 3A
; RegMod:
SUB_9B5E: ; Called from 
9B5E	A5 7B A1          LDA	    (OUT_BUF + $41)             ;
9B61	D9                SHL                                   ; (OUT_BUF  + 41) * 2
9B62	81 10             BCR+      BRANCH_9B74                 ;
9B64	6C 3C             CPI	    UH,$3C                      ; < 
9B66	9B 0C             BZS-      BRANCH_9B5C                 ; Borrows return
9B68	6C 34             CPI	    UH,$34                      ; 4
9B6A	9B 10             BZS-      BRANCH_9B5C                 ; Borrows return
9B6C	6C 40             CPI	    UH,$40                      ; &
9B6E	9B 14             BZS-      BRANCH_9B5C                 ; Borrows return
9B70	6C 3A             CPI	    UH,$3A                      ; :
9B72	9B 18             BZS-      BRANCH_9B5C                 ; Borrows return

BRANCH_9B74: ; branched to from 9B62
9B74	FB                SEC                                   ; Set Carry
9B75	9A                RTN                                   ;



;--------- ---------------------------------------------------------------------------------------------------
; SUB_9B76 - Called from 
; 
; Arguments:
; Output:
; RegMod:
SUB_9B76:
9B76	A5 7B A1          LDA	    (OUT_BUF + $41)             ;
9B79	68 7F             LDI	    UH,$7F                      ;
9B7B	B7 24             CPI	    A,$24                       ;
9B7D	8B 08             BZS+      BRANCH_9B87                 ;
9B7F	68 3F             LDI	    UH,$3F                      ;
9B81	B7 A4             CPI	    A,$A4                       ;
9B83	8B 02             BZS+      BRANCH_9B87                 ;
9B85	F9                REC                                   ; Reset Carry
9B86	9A                RTN                                   ;

BRANCH_9B87: ; called from 9B7D, 9B83
9B87	A4                LDA	    UH                          ;
9B88	8E 02             BCH+	    DELAY_A_MS                  ; Time delay of A * 15.625ms



;--------- ---------------------------------------------------------------------------------------------------
; DELAY500MS - Time delay of 500ms, default. 
; DELAY_A_MS - Time delay of A * 15.625ms
; 
; Arguments: A
; Output:
; RegMod: A, UH
DELAY500MS: ; called from 9D38, 
9B8A	B5 32             LDI	    A,$32                       ;

DELAY_A_MS: ; called from 9515, 95D6, 95EE
9B8C	68 00             LDI	    UH,$00                      ;
9B8E	FD A8             PSH	    U                           ;
9B90	2A                STA	    UL                          ;
9B91	BE E8 8C          SJP       TIMEDELAY                   ; Time delay by 15.625 ms* U-Reg 32*15.625ms=500ms
9B94	FD 2A             POP	    U                           ;
9B96	68 00             LDI	    UH,$00                      ;
9B98	9A                RTN                                   ;



;--------- ---------------------------------------------------------------------------------------------------
; SUB_9B99 - 
; 
; Arguments: A
; Output:
; RegMod: A, UH
SUB_9B99: ; Jumped to from 9E1A
9B99	C2 3B 01          VEJ	    ($C2),';',BRANCH_9B9D       ; If next character is not ';', branch fwd 'n'.
9B9C	9A                RTN                                   ; 

BRANCH_9B9D: ; branched to from 9B99
9B9D	C6                VEJ       ($C6)                       ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
9B9E	FB                SEC                                   ; Set Carry
9B9F	A5 7B 65          LDA	    (OUT_BUF + $05)             ;
9BA2	8B 05             BZS+      BRANCH_9BA9                 ;
9BA4	C4 0D 01          VEJ	    ($C4),$0D,BRANCH_9BA8       ; Check tokens/char in U-Reg if not CR branch fwd n
9BA7	9A                RTN                                   ;


BRANCH_9BA8: ; branched to from 9BA4
9BA8	F9                REC                                   ; Reset Carry

BRANCH_9BA9: ; branched to from 9BA2
9BA9	9A                RTN                                   ;



;--------- ---------------------------------------------------------------------------------------------------
; SUB_9BAA - Called from 
; Checks some things in OUTPUT BUFFER, pokes values in CE-158 registers
; Arguments:
; Output:
; RegMod:
SUB_9BAA:
9BAA	ED 7B A1 40       BII	    (OUT_BUF + $41),$40         ;
9BAE	8B 10             BZS+      BRANCH_9BC0                 ;
9BB0	A5 7B A7          LDA	    (OUT_BUF + $47)             ;
9BB3	ED 7B 9E 04       BII	    (OUT_BUF + $3E),$04         ;
9BB7	89 04             BZR+      BRANCH_9BBD                 ;   
9BB9	AE 78 53          STA	    (CE158_UNDEF1)              ; Unkown CE-158 register
9BBC	9A                RTN                                   ;


BRANCH_9BBD: ; branched to from 9BB7
9BBD	AE 78 54          STA	    (CE158_UNDEF2)              ; Unkown CE-158 register

BRANCH_9BC0: ; branched to from 9BAE, 9BCC, 9BD7
9BC0	9A                RTN                                   ;



;------------------------------------------------------------------------------------------------------------
; SUB_9BC1 - Called from 9AFE, 947A, 946D, 920E
; Manipulates OUT_BUF
; Arguments:
; Output:
; RegMod:
SUB_9BC1:
9BC1	ED 7B A1 80       BII	    (OUT_BUF + $41),$80         ;
9BC5	9B 1F             BZS-      BRANCH_9BA8                 ;
9BC7	B5 03             LDI	    A,$03                       ;
9BC9	BE 9C 5C          SJP       BRANCH_9C5C                 ;
9BCC	93 0E             BCS-      BRANCH_9BC0                 ; Borrows return
9BCE	BE 81 E6          SJP       RXCOM                    ; Manipulates LPT/UART registers
9BD1	A5 7B A2          LDA	    (OUT_BUF + $42)             ;
9BD4	BE 9C 57          SJP       BRANCH_9C57                 ; no idea
9BD7	93 19             BCS-      BRANCH_9BC0                 ; Borrows return
9BD9	FB                SEC                                   ; Set Carry
9BDA	B5 F2             LDI	    A,$F2                       ;
9BDC	BA 9C FD          JMP	    SUB_9CFD                    ; no idea



;--------- ---------------------------------------------------------------------------------------------------
; SUB_98DF - called from 93E5, 9371
; SUB_9BE1 - called from 9AA7, 9587, 9184
; Manipulates OUT_BUF
; Arguments:
; Output:
; RegMod:
SUB_98DF:
98DF	FD 18             LDX       Y                           ; X = Y              

SUB_9BE1: ; Jumped to from 9184
9BE1	E9 7B A5 7F       ANI	    (OUT_BUF + $45),$7F         ;
9BE5	B5 FD             LDI	    A,$FD                       ;
9BE7	AE 7B A4          STA	    (OUT_BUF + $44)             ;
9BEA	04                LDA	    XL                          ;
9BEB	AE 7B 97          STA	    (OUT_BUF + $37)             ;
9BEE	84                LDA	    XH                          ;
9BEF	AE 7B 96          STA	    (OUT_BUF + $36)             ;
9BF2	24                LDA	    UL                          ;
9BF3	AE 7B 99          STA	    (OUT_BUF + $39)             ;
9BF6	A4                LDA	    UH                          ;
9BF7	AE 7B 98          STA	    (OUT_BUF + $38)             ;

BRANCH_9BFA: ; branched to from 9C46
9BFA	8B 02             BZS+      BRANCH_9BFE                 ;
9BFC	6A FF             LDI	    UL,$FF                      ;

BRANCH_9BFE: ; branched to from 9BFA
9BFE	A5 7B A1          LDA	    (OUT_BUF + $41)             ;
9C01	D9                SHL                                   ;
9C02	81 2D             BCR+      BRANCH_9C31                 ;
9C04	E9 7B A2 00       ANI	    (OUT_BUF + $42),$00         ;
9C08	D9                SHL                                   ;
9C09	A5 7B A5          LDA	    (OUT_BUF + $45)             ;
9C0C	E9 7B A5 00       ANI	    (OUT_BUF + $45),$00         ;
9C10	8F 3A             BVS+      BRANCH_9C4C                 ;
9C12	D9                SHL                                   ;
9C13	81 05             BCR+      BRANCH_9C1A                 ;
9C15	B5 3D             LDI	    A,$3D                       ;
9C17	BE 9C 31          SJP       BRANCH_9C31                 ;

BRANCH_9C1A: ; branched to from 9C13
9C1A	BE 9C 94          SJP       SUB_9C94                    ; No idea
9C1D	83 12             BCS+      BRANCH_9C31                 ;
9C1F	B7 02             CPI	    A,$02                       ;
9C21	F9                REC                                   ; Reset Carry
9C22	8B 0D             BZS+      BRANCH_9C31                 ;
9C24	B7 2D             CPI	    A,$2D                       ;
9C26	8B 20             BZS+      SUB_9C48                    ; no idea
9C28	68 42             LDI	    UH,$42                      ;
9C2A	B7 37             CPI	    A,$37                       ;
9C2C	8B 03             BZS+      BRANCH_9C31                 ;
9C2E	FB                SEC                                   ; Set Carry
9C2F	68 3A             LDI	    UH,$3A                      ;

BRANCH_9C31: ; branched to from 9C4E, 9C53, 9C02, 9C17, 9C1D, 9C22, 9C2C
9C31	9A                RTN                                   ;



;--------- ---------------------------------------------------------------------------------------------------
; SUB_9C32 - called from 9AC6
; Pulls some values out of OUT_BUF and saves to XH, XL, UH, UL, A
; Arguments:
; Output:
; RegMod:
SUB_9C32: 
9C32	EB 7B A5 80       ORI	    (OUT_BUF + $45),$80         ;
9C36	A5 7B 97          LDA	    (OUT_BUF + $37)             ;
9C39	0A                STA	    XL                          ;
9C3A	A5 7B 96          LDA	    (OUT_BUF + $36)             ;
9C3D	08                STA	    XH                          ;    
9C3E	A5 7B 99          LDA	    (OUT_BUF + $39)             ;
9C41	2A                STA	    UL                          ;
9C42	A5 7B 98          LDA	    (OUT_BUF + $38)             ;
9C45	28                STA	    UH                          ;
9C46	9E 4E             BCH-	    BRANCH_9BFA                 ;



;--------- ---------------------------------------------------------------------------------------------------
; SUB_9C48 - Called from    branched to from 9CEA
; 
; Arguments:
; Output:
; RegMod:
SUB_9C48:
9C48	B5 70             LDI	    A,$70                       ;
9C4A	8E 0B             BCH+	    BRANCH_9C57                 ;


BRANCH_9C4C: ; branched to from 9C10
9C4C	BF C0             BII	    A,$C0                       ;
9C4E	9B 1F             BZS-      BRANCH_9C31                 ; Borrowing Return
9C50	BE 9C FD          SJP       SUB_9CFD                    ; no idea
9C53	93 24             BCS-      BRANCH_9C31                 ;
9C55	B5 02             LDI	    A,$02                       ; Borrowing Return

BRANCH_9C57: ; branched to from 9C4A, 9BD4
9C57	FD A8             PSH	    U                           ;
9C59	2A                STA	    UL                          ;
9C5A	8E 16             BCH+	    BRANCH_9C72                 ;


BRANCH_9C5C: ; branched to from 9BC9
9C5C	FD A8             PSH	    U                           ;
9C5E	8E 09             BCH+	    BRANCH_9C69                 ;


JMP_9C60: ; branched to from TBL_9887->9895
9C60	FD A8             PSH	    U                           ;
9C62	2A                STA	    UL                          ;
9C63	B7 40             CPI	    A,$40                       ;
9C65	83 02             BCS+      BRANCH_9C69                 ;
9C67	B3 40             ADI	    A,$40                       ;

BRANCH_9C69: ; branched to from 9C5E, 9C65
9C69	28                STA       UH                          ; X = U
9C6A	BE 9C 89          SJP       BRANCH_9C89                 ;
9C6D	A4                LDA	    UH                          ;
9C6E	B7 40             CPI	    A,$40                       ;
9C70	81 12             BCR+      BRANCH_9C84                 ;

BRANCH_9C72: ; branched to from 9C5A
9C72	24                LDA	    UL                          ;
9C73	B7 40             CPI	    A,$40                       ;
9C75	83 0D             BCS+      BRANCH_9C84                 ;
9C77	B5 10             LDI	    A,$10                       ;
9C79	BE 82 3A          SJP       TXCOM                       ; Sends charecter in A to RS232 Port.
9C7C	81 03             BCR+      BRANCH_9C81                 ;
9C7E	FD 0A             POP	    X                           ;
9C80	9A                RTN                                   ;


BRANCH_9C81: ; branched to from 9C7C
9C81	24                LDA	    UL                          ;
9C82	B3 40             ADI	    A,$40                       ;

BRANCH_9C84: ; branched to from 9C70, 9C75
9C84	FD 2A             POP	    U                           ;
9C86	BA 82 3A          JMP	    TXCOM                       ; Sends charecter in A to RS232 Port.


BRANCH_9C89: ; branched to from 9C6A, called from 9CBA, 9CD9
9C89	A5 7B A2          LDA	    (OUT_BUF + $42)             ;
9C8C	D9                SHL                                   ;
9C8D	A2                ADC	    UH                          ;
9C8E	B3 00             ADI	    A,$00                       ;
9C90	AE 7B A2          STA	    (OUT_BUF + $42)             ;
9C93	9A                RTN                                   ;



;--------- ---------------------------------------------------------------------------------------------------
; SUB_9C94 - Called from
; 
; Arguments:
; Output:
; RegMod:
SUB_9C94:
9C94	24                LDA	    UL                          ;
9C95	6A 00             LDI	    UL,$00                      ;
9C97	8E 03             BCH+      BRANCH_9C9C                 ;

JMP_9C99: ; jumped to from 989F
9C99	24                LDA	    UL                          ;
9C9A	6A 02             LDI	    UL,$02                      ;

BRANCH_9C9C: ; branched to from 9C97
9C9C	FD C8             PSH	    A                           ;
9C9E	BE 82 8E          SJP       BRANCH_828E                 ; Sends data to LPT output
9CA1	83 1E             BCS+      BRANCH_9CC1                 ;
9CA3	28                STA	    UH                          ;
9CA4	B7 40             CPI	    A,$40                       ;
9CA6	83 0E             BCS+      BRANCH_9CB6                 ;
9CA8	B7 10             CPI	    A,$10                       ;
9CAA	89 1A             BZR+      BRANCH_9CC6                 ;
9CAC	BE 82 8E          SJP       BRANCH_828E                 ; Sends data to LPT output
9CAF	83 10             BCS+      BRANCH_9CC1                 ;
9CB1	28                STA	    UH                          ;
9CB2	B1 3F             SBI	    A,$3F                       ; A = A - N
9CB4	81 17             BCR+      BRANCH_9CCD                 ;

BRANCH_9CB6: ; branched to from 9CA6
9CB6	62                DEC	    UL                          ;
9CB7	81 28             BCR+      BRANCH_9CE1                 ;
9CB9	2A                STA	    UL                          ;
9CBA	BE 9C 89          SJP       BRANCH_9C89                 ;
9CBD	A5 7B A2          LDA	    (OUT_BUF + $42)             ;
9CC0	28                STA	    UH                          ;

BRANCH_9CC1: ; branched to from 9CA1, 9CAF, 9CD1, 9CD6, 9CDF
9CC1	FD 8A             POP	    A                           ;
9CC3	2A                STA	    UL                          ;
9CC4	A4                LDA	    UH                          ;
9CC5	9A                RTN                                   ;


BRANCH_9CC6: ; branched to from 9CAA
9CC6	62                DEC	    UL                          ;
9CC7	81 04             BCR+      BRANCH_9CCD                 ;
9CC9	B7 03             CPI	    A,$03                       ;
9CCB	8B 0B             BZS+      BRANCH_9CD8                 ;

BRANCH_9CCD: ; branched to from 9CB4, 9CC7
9CCD	68 3B             LDI	    UH,$3B                      ;
9CCF	B7 37             CPI	    A,$37                       ;
9CD1	9B 12             BZS-      BRANCH_9CC1                 ;
9CD3	68 3A             LDI	    UH,$3A                      ;

BRANCH_9CD5: ; branched to from 9CE5
9CD5	FB                SEC                                   ; Set Carry
9CD6	9E 17             BCH-      BRANCH_9CC1                 ;


BRANCH_9CD8: ; branched to from 9CCB
9CD8	28                STA	    UH                          ;
9CD9	BE 9C 89          SJP       BRANCH_9C89                 ;
9CDC	68 3F             LDI	    UH,$3F                      ;
9CDE	FB                SEC                                   ; Set Carry
9CDF	9E 20             BCH-      BRANCH_9CC1                 ;


BRANCH_9CE1: ; branched to from 9CB7
9CE1	68 3C             LDI	    UH,$3C                      ;
9CE3	B7 A2             CPI	    A,$A2                       ;
9CE5	99 12             BZR-      BRANCH_9CD5                 ;
9CE7	FD 8A             POP	    A                           ;
9CE9	2A                STA	    UL                          ;
9CEA	9E A4             BCH-      SUB_9C48                    ; no idea

SUB_9CEC: ; Jumped to from 9166
9CEC	4A 60             LDI	    XL,$60                      ;
9CEE	48 7B             LDI	    XH,$7B                      ; X = 7B60 = OUT_BUF
9CF0	6A 1A             LDI	    UL,$1A                      ;
9CF2	ED 7B A1 80       BII	    (OUT_BUF + $41),$80         ;
9CF6	8B 02             BZS+      BRANCH_9CFA                 ; Exit
9CF8	44                INC	    X                           ;
9CF9	62                DEC	    UL                          ;

BRANCH_9CFA:
9CFA	BA 9A A5          JMP	    SUB_9AA5                    ; No idea



;------------------------------------------------------------------------------------------------------------
; SUB_9CFD - Called from
; 
; Arguments:
; Output:
; RegMod:
SUB_9CFD:
9CFD	BE 81 E6          CALL	    RXCOM                    ; Manipulates LPT/UART registers
9D00	FB                SEC                                   ; Set Carry
9D01	EB 7B A5 40       ORI	    (OUT_BUF + $45),$40         ;
9D05	B5 F2             LDI	    A,$F2                       ;
9D07	E9 7B A5 DF       ANI	    (OUT_BUF + $45),$DF         ;
9D0B	AE 7B A3          STA	    (OUT_BUF + $43)             ;
9D0E	68 00             LDI	    UH,$00                      ;
9D10	83 19             BCS+      BRANCH_9D2B                 ;

BRANCH_9D12: ; branched to from 9D26
9D12	B5 2D             LDI	    A,$2D                       ;
9D14	BE 81 BC          SJP	    CHAR2COM                    ; Sends charecter in A to RS232 Port
9D17	81 11             BCR+      BRANCH_9D2A                 ;
9D19	BF 20             BII       A,$20                       ;
9D1B	89 0D             BZR+      BRANCH_9D2A                 ;

BRANCH_9D1D: ; branched to from 9D54
9D1D	BE 9B 8A          SJP	    DELAY500MS                  ; 500ms delay
9D20	83 08             BCS+      BRANCH_9D2A                 ;
9D22	EF 7B A3 01       ADI	    (OUT_BUF + $43),$01         ;
9D26	91 16             BCR-      BRANCH_9D12                 ;

BRANCH_9D28: ; branched to from 9D41
9D28	68 38             LDI	    UH,$38                      ;

BRANCH_9D2A: ; branched to from 9D17, 9D1B, 9D20, 9D32
9D2A	9A                RTN                                   ;


BRANCH_9D2B: ; branched to from 9D10, 9D43, 9D5C
9D2B	BE 81 E6          SJP	    RXCOM                    ; Manipulates LPT/UART registers
9D2E	81 15             BCR+      BRANCH_9D45                 ;
9D30	BF 40             BII       A,$40                       ;
9D32	99 0A             BZR-      BRANCH_9D2A                 ;
9D34	BF 1C             BII       A,$1C                       ;
9D36	89 18             BZR+      BRANCH_9D50                 ;
9D38	BE 9B 8A          SJP	    DELAY500MS                  ; 500ms delay
9D3B	83 27             BCS+      BRANCH_9D64                 ;
9D3D	EF 7B A3 01       ADI	    (OUT_BUF + $43),$01         ;
9D41	93 1B             BCS-      BRANCH_9D28                 ;
9D43	9E 1A             BCH-      BRANCH_9D2B                 ;


BRANCH_9D45: ; branched to from 9D2E
9D45	ED 7B A5 20       BII	    (OUT_BUF + $45),$20         ;
9D49	8B 0B             BZS+      BRANCH_9D56                 ;
9D4B	B7 70             CPI	    A,$70                       ;
9D4D	F9                REC                                   ; Reset Carry
9D4E	8B 14             BZS+      BRANCH_9D64                 ;

BRANCH_9D50: ; branched to from 9D36, 9D60
9D50	E9 7B A5 DF       ANI	    (OUT_BUF + $45),$DF         ;
9D54	9E 39             BCH-      BRANCH_9D1D                 ;


BRANCH_9D56: ; branched to from 9D49
9D56	EB 7B A5 20       ORI	    (OUT_BUF + $45),$20         ;
9D5A	B7 10             CPI	    A,$10                       ;
9D5C	9B 33             BZS-      BRANCH_9D2B                 ;
9D5E	B7 3D             CPI	    A,$3D                       ;
9D60	99 12             BZR-      BRANCH_9D50                 ;
9D62	68 39             LDI	    UH,$39                      ;

BRANCH_9D64: ; branched to from 9D3B, 9D4E
9D64	9A                RET                                   ;



;------------------------------------------------------------------------------------------------------------
; SUB9D65 - Called from 9256
; 
; Arguments:
; Output:
; RegMod:
SUB_9D65:
9D65	BE 81 E6          SJP	    RXCOM                    ; Manipulates LPT/UART registers
9D68	4A 7B             LDI	    XL,$7B                      ;
9D6A	6A 1A             LDI	    UL,$1A                      ;
9D6C	ED 7B A1 80       BII	    (OUT_BUF  + $41),$80        ;
9D70	8B 02             BZS+      BRANCH_9D74                 ;
9D72	40                INC	    XL                          ;
9D73	62                DEC	    UL                          ;

BRANCH_9D74: ; branched to from 9D70
9D74	48 7B             LDI	    XH,$7B                      ;
9D76	BE 9A A5          SJP	    SUB_9AA5                    ; No idea
9D79	83 75             BCS+      BRANCH_9DF0                 ;
9D7B	4A 60             LDI	    XL,$60                      ; X = 7B60 = OUT_BUF
9D7D	6A 04             LDI	    UL,$04                      ;
9D7F	FD 98             PSH	    Y                           ;
9D81	A5 7B A1          LDA	    (OUT_BUF + $41)             ;
9D84	D9                SHL                                   ;
9D85	5A 7B             LDI	    YL,$7B                      ;
9D87	81 03             BCR+      BRANCH_9D8C                 ;
9D89	40                INC	    XL                          ;
9D8A	50                INC	    YL                          ;
9D8B	62                DEC	    UL                          ;

BRANCH_9D8C: ; branched to from 9D87
9D8C	48 7B             LDI	    XH,$7B                      ;
9D8E	58 7B             LDI	    YH,$7B                      ;
9D90	68 3D             LDI	    UH,$3D                      ;

BRANCH_9D92: ; branched to from 9D96
9D92	55                LIN	    (Y)                         ; A = (Y) then INC Y
9D93	F7                CIN                                   ; FLAGS = A compared to (X) register, then INC X.
9D94	89 57             BZR+      BRANCH_9DED                 ;
9D96	88 06             LOP	    UL,BRANCH_9D92              ;
9D98	05                LDA	    (X)                         ;
9D99	8B 08             BZS+      BRANCH_9DA3                 ;
9D9B	6A 0F             LDI	    UL,$0F                      ;

BRANCH_9D9D: ; branched to from 9DA1
9D9D	55                LIN	    (Y)                         ; A = (Y) then INC Y
9D9E	F7                CIN                                   ; FLAGS = A compared to (X) register, then INC X.
9D9F	89 4C             BZR+      BRANCH_9DED                 ;
9DA1	88 06             LOP	    UL,BRANCH_9D9D              ; UL = UL - 1, loop back 'e' if Borrow Flag not set

BRANCH_9DA3: ; branched to from 9D99
9DA3	FD 1A             POP	    Y                           ;
9DA5	A5 7B A1          LDA	    (OUT_BUF + $41)             ;
9DA8	D9                SHL                                   ;
9DA9	87 40             BHS+      BRANCH_9DEB                 ;
9DAB	D9                SHL                                   ;
9DAC	87 32             BHS+      BRANCH_9DE0                 ;
9DAE	D9                SHL                                   ;
9DAF	87 17             BHS+      BRANCH_9DC8                 ;
9DB1	F4 7B 92          VEJ	    ($F4),(OUT_BUF + $32)       ; Loads U-Reg with 16-bit value from address of (pp)
9DB4	FD 28             LDX       U                           ; X = U
9DB6	F4 7B 77          VEJ	    ($F4),(OUT_BUF + $17)       ; Loads U-Reg with 16-bit value from address of (pp)
9DB9	BE DF E2          SJP	    U_MINUS_X                   ;
9DBC	81 31             BCR+      BRANCH_9DEF                 ;
9DBE	F4 7B 75          VEJ	    ($F4),(OUT_BUF + $15)       ; Loads U-Reg with 16-bit value from address of (pp)

BRANCH_9DC1: ; branched to from 9DD4, 9DDE
9DC1	FD 28             LDX       U                           ; X = U
9DC3	F4 7B 92          VEJ	    ($F4),(OUT_BUF + $32)       ; Loads U-Reg with 16-bit value from address of (pp)
9DC6	F9                REC                                   ; Reset Carry
9DC7	9A                RTN                                   ;


BRANCH_9DC8: ; branched to from 9DAF
9DC8	F4 7B 79          VEJ	    ($F4),(OUT_BUF + $19)       ; Loads U-Reg with 16-bit value from address of (pp)
9DCB	26                CPA	    UL                          ;
9DCC	89 08             BZR+      BRANCH_9DD6                 ;
9DCE	DD                INC	    A                           ;
9DCF	81 05             BCR+      BRANCH_9DD6                 ;
9DD1	F4 7B 90          VEJ	    ($F4),(OUT_BUF + $30)       ; Loads U-Reg with 16-bit value from address of (pp)
9DD4	9E 15             BCH-	    BRANCH_9DC1                 ;


BRANCH_9DD6: ; branched to from 9DCC, 9DCF
9DD6	EB 7B 94 FF       ORI	    (OUT_BUF + $34),$FF         ;
9DDA	EB 7B 95 FF       ORI	    (OUT_BUF + $35),$FF         ;
9DDE	9E 1F             BCH-	    BRANCH_9DC1                 ;


BRANCH_9DE0: ; branched to from 9DAC
9DE0	F4 7B 75          VEJ	    ($F4),(OUT_BUF + $15)       ; Loads U-Reg with 16-bit value from address of (pp)
9DE3	F6 78 69          VEJ	    ($F6),(BASPRG_EDT_H)        ; Transfers U to Start of Basic program edit (H)
9DE6	F6 78 67          VEJ	    ($F6),(BASPRG_END_H)        ; Transfers U to End of Basic program in RAM (H)
9DE9	6B FF             ORI	    (U),$FF                     ;

BRANCH_9DEB: ; branched to from 9DA9
9DEB	F9                REC                                   ; Reset Carry
9DEC	9A                RTN                                   ;


BRANCH_9DED: ; branched to from 9D94, 9D9F
9DED	FD 1A             POP	    Y                           ;

BRANCH_9DEF: ; branched to from 9DBC
9DEF	FB                SEC                                   ; Set Carry

BRANCH_9DF0: ; branched to from 9D79
9DF0	9A                RTN                                   ;



;------------------------------------------------------------------------------------------------------------
; SUB_9DF1 - Called from 9452, 910D
; 
; Arguments:
; Output:
; RegMod:
SUB_9DF1:
9DF1	CD 36             VMJ	    ($36)                       ; Stores CSI of a text/text var in AR-X (C=1). If no string in Y-Reg, C=0.
9DF3	83 28             BCS+      BRANCH_9E1D                 ; no idea
9DF5	FD 88             PSH	    X                           ;
9DF7	5A 62             LDI	    YL,$62                      ;
9DF9	58 7B             LDI	    YH,$7B                      ; Y = 7B62, (OUT_BUF + 2)
9DFB	6A 15             LDI	    UL,$15                      ;

BRANCH_9DFD: ; called from 9E38, 9E3E
9DFD	B5 00             LDI	    A,00                        ;

BRANCH_9DFF: ; called from 9E00
9DFF	51                SIN	    Y                           ; (Y) = A. Then Y = Y + 1
9E00	88 03             LOP	    UL,BRANCH_9DFF              ; UL = UL - 1, loop back 'e' if Borrow Flag not set
9E02	5A 60             LDI	    YL,$60                      ;
9E04	B5 01             LDI	    A,$01                       ;
9E06	51                SIN	    Y                           ; (Y) = A. Then Y = Y + 1
9E07	A5 7B A1          LDA	    (OUT_BUF + $41)             ;
9E0A	B9 4F             ANI	    A,$4F                       ;
9E0C	BB 40             ORI	    A,$40                       ;
9E0E	51                SIN	    Y                           ; (Y) = A. Then Y = Y + 1
9E0F	B5 43             LDI	    A,$43                       ;
9E11	51                SIN	    Y                           ; (Y) = A. Then Y = Y + 1
9E12	B5 4F             LDI	    A,$4F                       ;
9E14	51                SIN	    Y                           ; (Y) = A. Then Y = Y + 1
9E15	B5 4D             LDI	    A,$4D                       ;
9E17	51                SIN	    Y                           ; (Y) = A. Then Y = Y + 1
9E18	FD 1A             POP	    Y                           ;
9E1A	BA 9B 99          JMP	    SUB_9B99                    ; no idea


BRANCH_9E1D: ; called from 9DF3
9E1D	FD 98             PSH	    Y                           ;
9E1F	5A 65             LDI	    YL,$65                      ;
9E21	58 7B             LDI	    YH,$7B                      ; Y = (OUT_BUF + 5)
9E23	DC                VEJ       ($DC)                       ; Loads CSI from AR-X: Address by X-Reg length by UL & A 
9E24	B7 10             CPI	    A,$10                       ;
9E26	81 02             BCR+      BRANCH_9E2A                 ;
9E28	B5 10             LDI	    A,$10                       ;

BRANCH_9E2A: ; called from 9E26
9E2A	2A                STA	    UL                          ;
9E2B	8E 01             BCH+	    BRANCH_9E2E                 ;


BRANCH_9E2D: ; called from 9E2E
9E2D	F5                TIN                                   ; (Y) = (X) then X = X + 1, Y = Y + 1

BRANCH_9E2E: ; called from 9E28
9E2E	88 03             LOP	    UL,BRANCH_9E2D              ;
9E30	6A 05             LDI	    UL,$05                      ;
9E32	B5 0F             LDI	    A,$0F                       ;
9E34	FB                SEC                                   ;
9E35	A1 7A 07          SBC	    (ARX + $07)                 ;
9E38	91 3D             BCR-      BRANCH_9DFD                 ;
9E3A	22                ADC	    UL                          ;
9E3B	2A                STA	    UL                          ;
9E3C	9E 41             BCH-	    BRANCH_9DFD                 ;



;------------------------------------------------------------------------------------------------------------
; SUB_9E3E - Called from 9607
; SUB_9E47 - Called from called from 9639
; Arguments:
; Output:
; RegMod:
SUB_9E3E:
9E3E	A5 7B A1          LDA	    (OUT_BUF + $41)             ;
9E41	D9                SHL                                   ;
9E42	81 2F             BCR+      BRANCH_9E73                 ;
9E44	D9                SHL                                   ;
9E45	8D 05             BVR+      BRANCH_9E4C                 ;

SUB_9E47: 
9E47	B5 37             LDI	    A,$37                       ;
9E49	BA 82 3A          JMP	    TXCOM                       ; Sends charecter in A to RS232 Port.


BRANCH_9E4C: ; called from 9E45
9E4C	68 37             LDI	    UH,$37                      ;
9E4E	8E 0A             BCH+ 	    BRANCH_9E5A                 ;


9E50	68 2D             LDI	    UH,$2D                      ;
9E52	8E 06             BCH+ 	    BRANCH_9E5A                 ;



;------------------------------------------------------------------------------------------------------------
; SUB_9E54 - called from 9B03
; Arguments:
; Output:
; RegMod:
SUB_9E54: 
9E54	68 03             LDI	    UH,$03                      ;
9E56	8E 02             BCH+ 	    BRANCH_9E5A                 ;

9E58	68 02             LDI	    UH,$02                      ;

BRANCH_9E5A: ; branched to from 9E4E, 9E52, 9E56
9E5A	BE 82 8E          SJP	    BRANCH_828E                 ; Sends data to LPT output
9E5D	83 14             BCS+      BRANCH_9E73                 ;
9E5F	A6                CPA	    UH                          ;
9E60	89 08             BZR+      BRANCH_9E6A                 ;
9E62	B7 2D             CPI	    A,$2D                       ;
9E64	F9                REC                                   ; Reset Carry
9E65	8B 0C             BZS+      BRANCH_9E73                 ;
9E67	BA 9C 48          JMP	    SUB_9C48                    ; no idea


BRANCH_9E6A: ; branched to from 9E60
9E6A	68 3B             LDI	    UH,$3B                      ;
9E6C	B7 37             CPI	    A,$37                       ;
9E6E	8B 03             BZS+      BRANCH_9E73                 ;
9E70	68 3A             LDI	    UH,$3A                      ;
9E72	FB                SEC                                   ; Set Carry

BRANCH_9E73: ; branched to from 9E5D, 9E65, 9E6E
9E73	9A                RTN                                   ;



;------------------------------------------------------------------------------------------------------------
; SEPARATOR_9E74 - Unused
SEPARATOR_9E74:
9E74	00 FF 03 D7 26 F7 00 FF   00 FF 00 BF 04 EE 00 FF 
9E84	00 FF 82 FF 06 FE 00 FF   00 FF 09 FE 00 FF 00 FF 
9E94	00 FF 80 FF 05 FE 00 FF   00 FF 00 FF 00 3F 00 FF 
9EA4	00 FF 40 FF 04 FF 00 FF   00 FF 00 FF 80 FF 00 FF 
9EB4	00 FF 00 FF 21 DF 00 FF   00 FF 00 FF 80 FF 00 FF 
9EC4	00 FF 82 FF 50 FD 00 FF   00 FF 00 FF 00 E2 00 FF 
9ED4	00 FF 42 F5 80 7F 00 FF   00 FF 0C CF 08 FF 00 FF 
9EE4	00 FF 00 FE 08 FF 00 FF   00 FF 40 FF 01 FF 00 FF 
9EF4	00 FF 44 FD 82 FF 00 FF   00 FF 10 FF 40 00 00 ED 
9F04	00 FF 10 00 00 00 00 5F   00 FF 01 00 00 00 00 FF 
9F14	00 FD 22 00 00 00 00 FF   00 BF 01 00 00 00 00 DF 
9F24	00 DF 00 00 00 00 00 DD   00 EF 11 00 21 00 00 EF 
9F34	00 CD 00 00 83 00 00 FE   00 7F 02 00 41 00 00 B9 
9F44	00 7F 48 00 01 00 00 9F   00 8D 00 00 40 00 00 FF 
9F54	00 EF 08 00 88 00 00 FB   00 FF 0A 00 10 00 00 DF 
9F64	00 FF 40 00 00 00 00 FE   00 FF 00 00 00 00 00 F7 
9F74	00 FE 08 00 08 00 00 FE   00 7F 02 00 80 00 00 7B 
9F84	00 FF 00 00 00 00 00 F7   00 7F 00 04 20 08 00 FF 
9F94	00 7F 05 00 81 00 00 7F   00 FF 44 00 40 00 00 7F 
9FA4	00 DD 84 00 A0 00 00 7F   00 BF 01 00 81 00 00 BF 
9FB4	00 7F 10 00 00 00 00 BF   00 FF 02 02 02 00 00 FF 
9FC4	00 FE 00 00 21 00 00 EF   00 FC 10 00 02 00 00 DE 
9FD4	00 F7 00 00 34 00 00 4F   00 3F 12 00 00 00 00 DF 
9FE4	00 7F 08 00 01 00 00 FF   00 FF 04 00 84 00 00 9A 
9FF4	00 AF 00 00 80 00 00 7F   00 FF 04 00 