; CE-158_ROM_HI.lh5801.asm
; High Bank of Sharp CE-158 RS232/LPT interface
; To fold: Hightlight Ctrl+K Ctrl+,
;
; Modifications enabled by uncommenting #DEFINEs. Not all defines used in both banks.
; BUSY      - (LB) Enables a blinking BUSY annunciator while loading and saving
; E7BUG     - (HB) Fixes bug in HB_CFG_URT_LPT at $8BAC
; ENBPD     - (LB,HB) Include BPD/BPD$ commands
; CE158V2   - Build for new hardware CE-158X
; CE158_48  - Original hardware. Make top baud rate 4800bps, eliminate 50bps
; HIGHSPEED - (HB) Enables faster baud rates of 4800,9600,19200 & 38400 (38400 uses SETCOM3840 due to signed ints)

#INCLUDE    "lib/PC-1500.lib"
#INCLUDE    "lib/CE-150.lib"
#INCLUDE    "lib/CE-158.lib"
#INCLUDE    "lib/CE-158N.lib"
#INCLUDE    "lib/PC-1500_Macros.lib"

#INCLUDE    CE-158_ROM_LOW.exp              ; Export table from low bank


#DEFINE E7BUG                               ; Fixes bug in HB_CFG_URT_LPT at $8BAC
#DEFINE ENBPD                               ; Include BPD/BPD$ commands
;#DEFINE CE158_48                            ; Make top baud rate 4800bps, eliminate 50bps
#DEFINE CE158V2                             ; New hardware CE-158XBuild for new hardware CE-158X
#DEFINE HIGHSPEED                           ; New hardware: Enable up to 38400 BAUD
#DEFINE REDIRECT                            ; Redirect CHAR2LPT and TXLPT to Low Bank to save space

;------------------------------------------------------------------------------------------------------------
; Define default BAUD rate based on configuration
#IFDEF CE158_48
BPSDEF EQU $79                              ; 300bps default for 4800 enabled build
#ELSE
BPSDEF EQU $99                              ; 300bps default for stock build, and V2
#ENDIF
;------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------
; Define BackPack Drive BAUD rate based on configuration
#IFDEF CE158V2
 #IFDEF HIGHSPEED
BPSBP EQU $59                               ; 19200bps 
 #ELSE
BPSBP EQU $F9                               ; 2400bps for Backpack w/o CE158_48
 #ENDIF
#ELSE
 #IFDEF CE158_48
BPSBP EQU $D9                               ; 2400bps for Backpack w/CE158_48
 #ELSE
BPSBP EQU $F9                               ; 2400bps for Backpack w/o CE158_48
 #ENDIF
#ENDIF   
;------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------
; Symbols to export to CE-158_ROM_HIGH.exp to be imported into low bank
.EXPORT HB_JMP_FRM_LB, HB_BPD_STR, HB_CFG_URT_BD, HB_CFG_URT_LPT, HB_SETDEV

.ORG $8000

;------------------------------------------------------------------------------------------------------------
; BASIC Table 8000 - (Second table at 8800)
; Basically a copy of the low bank table. Special equates below to get it to build same as low bank
B_TBL_8000:
     .BYTE   $55                            ; Marker that BASIC Table follows 

B_TBL_8000_TNUM:
     .BYTE   $08                            ; Table number

B_TBL_8000_NAME:
     .TEXT   "COM\r\r\r\r\r"                ; Table name

B_TBL_8000_INIT:
     JMP    COM_TBL_INIT                    ; $82B8 - Table initilization vector

B_TBL_8000_INPUT_NUM:
     JMP	COM_TBL_INPUT_NUM               ; $82C5 - Table INPUT# vector (Jumps to MERGE)

B_TBL_8000_PRINT_NUM:
     JMP    COM_TBL_PRINT_NUM               ; $82C9 - Table PRINT# vector (Jumps to MERGE)

B_TBL_8000_JMPS:
     .BYTE $BA,$79,$FA,$9A,$9A,$9A,$9A,$9A,$9A,$9A   ; The unused interrupt functionality used the BA 79 FA

B_TBL_8000_TRACE:
     VEJ     (C4) \                         ; Correct per book. Not used?
                ABYT($AF) \                 ;
                ABRF($811F)                 ;

B_TBL_8000_A_KW:
     .WORD   $0000                          ; N/A

B_TBL_8000_B_KW:
     .WORD   LET_B                          ; 

B_TBL_8000_C_KW:
     .WORD   LET_C                          ; $8060

B_TBL_8000_D_KW:
     .WORD   LET_D                          ; $8089

B_TBL_8000_E_KW:
     .WORD   LET_E                          ; $809A

B_TBL_8000_F_KW:
     .WORD   LET_F                          ; $80AA

B_TBL_8000_G_KW:
     .WORD   $0000                          ; N/A

B_TBL_8000_H_KW:
     .WORD   $0000                          ; N/A

B_TBL_8000_I_KW:
     .WORD   LET_I                          ; $80B3

B_TBL_8000_J_KW:
     .WORD   $0000                          ; N/A

B_TBL_8000_K_KW:
     .WORD   $0000                          ; N/A

B_TBL_8000_L_KW:
     .WORD   LET_L                          ; $80C8

B_TBL_8000_M_KW:
     .WORD   LET_M                          ; $80DD

B_TBL_8000_N_KW:
     .WORD   $0000                          ; N/A

B_TBL_8000_O_KW:
     .WORD   LET_O                          ; $80E7

B_TBL_8000_P_KW:
     .WORD   LET_P                          ; $80F3

B_TBL_8000_Q_KW:
     .WORD   $0000                          ; N/A

B_TBL_8000_R_KW:
     .WORD   LET_R                          ; $810A                  

B_TBL_8000_S_KW:
     .WORD   LET_S                          ; $8116

B_TBL_8000_T_KW:
     .WORD   LET_T                          ; $8137

B_TBL_8000_U_KW:
     .WORD   LET_U                          ; N/A

B_TBL_8000_V_KW:
     .WORD   $0000                          ; N/A

B_TBL_8000_W_KW:
     .WORD   $0000                          ; N/A

B_TBL_8000_X_KW:
     .WORD   $0000                          ; N/A

B_TBL_8000_Y_KW:
     .WORD   $0000                          ; N/A

B_TBL_8000_Z_KW:
     .WORD   LET_Z                          ; $8159


B_TBL_8000_CMD_LST: ;Token LB < 80 command is function, else is proceedure
;Ctrl nibble    Ctrl nib calc            Name               Token  Vector
LET_B:  EQU ($ + 2) ; First keyword starting with 'B'. LET_B = Address of 'R' in BREAK
CN1:    EQU $B5 \ CNIB($B5,CN1)   \ .TEXT "BREAK"    \ .WORD $F0B3, ERR1          ; $CD89 - Basic command P

LET_C:  EQU ($ + 2) ; First keyword starting with 'C'. LET_C = Address of 'L' in BREAK
CN2:    EQU $C5 \ CNIB(CN1,CN2)   \ .TEXT "CLOAD"    \ .WORD $F089, MAIN_ENTRY    ; $82EC - MAIN_ENTRY
CN3:    EQU $C5 \ CNIB(CN2,CN3)   \ .TEXT "CSAVE"    \ .WORD $F095, CSAVE_V       ; $82DD - Drops through to MAIN_ENTRY
CN4:    EQU $C4 \ CNIB(CN3,CN4)   \ .TEXT "COM$"     \ .WORD $E858, LB_COM_STR_V  ; $82D3 - Drops through to MAIN_ENTRY
CN5:    EQU $D7 \ CNIB(CN4,CN5)   \ .TEXT "CONSOLE"  \ .WORD $F0B1, LB_CONSOL_V   ; $82DE - Drops through to MAIN_ENTRY

LET_D:  EQU ($ + 2) ; First keyword starting with 'D'. LET_D = Address of 'E' in DEV$
CN6:    EQU $C4 \ CNIB(CN5,CN6)   \ .TEXT "DEV$"     \ .WORD $E857, LB_DEV_STR_V  ; $82D4 - Drops through to MAIN_ENTRY
CN7:    EQU $D3 \ CNIB(CN6,CN7)   \ .TEXT "DTE"      \ .WORD $E884, DTE_V         ; $82D1 - Drops through to MAIN_ENTRY

LET_E:  EQU ($ + 2) ; First keyword starting with 'E'. LET_E = Address of 'R' in ERN
CN8:    EQU $C3 \ CNIB(CN7,CN8)   \ .TEXT "ERN"      \ .WORD $F052, ERN_V         ; $82DF - Drops through to MAIN_ENTRY
CN9:    EQU $D3 \ CNIB(CN8,CN9)   \ .TEXT "ERL"      \ .WORD $F053, ERL_V         ; $82E0 - Drops through to MAIN_ENTRY

LET_F:  EQU ($ + 2) ; First keyword starting with 'F'. LET_F = Address of 'E' in FEED
CN10:   EQU $D4 \ CNIB(CN9,CN10)  \ .TEXT "FEED"     \ .WORD $F0B0, LB_FEED_V     ; $82E1 - Drops through to MAIN_ENTRY

LET_I:  EQU ($ + 2) ; First keyword starting with 'I'. LET_I = Address of 'N' in INPUT
CN11:   EQU $C5 \ CNIB(CN10,CN11) \ .TEXT "INPUT"    \ .WORD $F091, INPUT_V       ; $82E2 - Drops through to MAIN_ENTRY
CN12:   EQU $D6 \ CNIB(CN11,CN12) \ .TEXT "INSTAT"   \ .WORD $E859, INSTAT_V      ; $82E3 - Drops through to MAIN_ENTRY

LET_L:  EQU ($ + 2) ; First keyword starting with 'L'. LET_L = Address of 'P' in LPRINT
CN13:   EQU $C6 \ CNIB(CN12,CN13) \ .TEXT "LPRINT"   \ .WORD $F0B9, LB_LPRINT_V   ; $82E4 - Drops through to MAIN_ENTRY
CN14:   EQU $D5 \ CNIB(CN13,CN14) \ .TEXT "LLIST"    \ .WORD $F0B8, LB_LLIST_V    ; $82E5 - Drops through to MAIN_ENTRY

LET_M:  EQU ($ + 2) ; First keyword starting with 'M'. LET_M = Address of 'E' in MERGE
CN15:   EQU $95 \ CNIB(CN14,CN15) \ .TEXT "MERGE"    \ .WORD $F08F, MERGE_V       ; $82C0 - Sets XL=F0, branches to MAIN_ENTRY

LET_O:  EQU ($ + 2) ; First keyword starting with 'O'. LET_O = Address of 'U' in OUTSTAT
CN16:   EQU $C7 \ CNIB(CN15,CN16) \ .TEXT "OUTSTAT"  \ .WORD $E880, OUTSTAT_V     ; $82E6 - Drops through to MAIN_ENTRY

LET_P:  EQU ($ + 2) ; First keyword starting with 'P'. LET_P = Address of 'R' in PRINT
CN17:   EQU $C5 \ CNIB(CN16,CN17) \ .TEXT "PRINT"    \ .WORD $F097, PRINT_V       ; $82E7 - Drops through to MAIN_ENTRY
CN18:   EQU $D8 \ CNIB(CN17,CN18) \ .TEXT "PROTOCOL" \ .WORD $E881, PROTOCOL_V    ; $82E8 - Drops through to MAIN_ENTRY

LET_R:  EQU ($ + 2) ; First keyword starting with 'R'. LET_R = Address of 'I' in RINKY$
CN19:   EQU $D7 \ CNIB(CN18,CN19) \ .TEXT "RINKEY$"  \ .WORD $E85A, RINKEY_STR_V  ; $82E9 - Drops through to MAIN_ENTRY

LET_S:  EQU ($ + 2) ; First keyword starting with 'S'. LET_S = Address of 'E' in SETCOM
CN20:   EQU $C6 \ CNIB(CN19,CN20) \ .TEXT "SETCOM"   \ .WORD $E882, SETCOM_V      ; $82D6 - Drops through to MAIN_ENTRY
CN21:   EQU $C6 \ CNIB(CN20,CN21) \ .TEXT "SETDEV"   \ .WORD $E886, SETDEV_V      ; $82D5 - Drops through to MAIN_ENTRY
CN22:   EQU $B6 \ CNIB(CN21,CN22) \ .TEXT "SPACE$"   \ .WORD $F061, SPACE_STR_V   ; $82EA - Drops through to MAIN_ENTRY

LET_T:  EQU ($ + 2) ; First keyword starting with 'T'. LET_T = Address of 'E' in TERMINAL
CN23:   EQU $C8 \ CNIB(CN22,CN23) \ .TEXT "TERMINAL" \ .WORD $E883, TERMINAL_V    ; $82D2 - Drops through to MAIN_ENTRY
CN24:   EQU $C8 \ CNIB(CN23,CN24) \ .TEXT "TRANSMIT" \ .WORD $E885, TRANSMIT_V    ; $82D7 - Drops through to MAIN_ENTRY
CN25:   EQU $D3 \ CNIB(CN24,CN25) \ .TEXT "TAB"      \ .WORD $F0BB, B_TBL_8800_INPUT_NUM  ; $880D - Uses 8800 BASIC Table TAB/INPUT# vector

#IFDEF ENBPD
LET_U:  EQU ($ + 2) ; First keyword starting with 'U'. LET_U = Address of 'E' in UR$
CN25_2: EQU $C3 \ CNIB(CN25,CN25_2) \ .TEXT "UR$"    \ .WORD $E856, HB_BPD_STR    ; 9DFE

LET_Z:  EQU ($ + 2) ; First keyword starting with 'Z'. LET_Z = Address of 'O' in ZONE
CN26:   EQU $D4 \ CNIB(CN25_2,CN26) \ .TEXT "ZONE"   \ .WORD $F0B4, ZONE_V        ; $82EB - Drops through to MAIN_ENTRY
#ENDIF

#IFNDEF ENBPD
LET_U: EQU $00
LET_Z: EQU ($ + 2) ; First keyword starting with 'Z'. LET_Z = Address of 'O' in ZONE
CN26:  EQU $D4 \ CNIB(CN25,CN26)   \ .TEXT "ZONE"     \ .WORD $F0B4, ZONE_V        ; $82EB - Drops through to MAIN_ENTRY
#ENDIF

CN27: EQU $D0 \ .BYTE CN27

B_TBL_8000_END:



;------------------------------------------------------------------------------------------------------------
; Unused address range 8161-8168 in original ROM
; - Used for BPD command in modified ROM
#IFNDEF ENBPD
SEPARATOR_8161:
     .BYTE   $FF,$00,$FF,$00,$FF,$00,$FF,$00    ; FF 00 - Used as seperator / space filler
#ENDIF



;------------------------------------------------------------------------------------------------------------
; CHAR2LPT - Sends character in A to LPT
; Called from SUB_PRINT_NUM:9307, SUB_PRINT_NUM:956D, TXLPT:826E
; Arguments: A: ASCII charecter >=20, i.e. printable
; Outputs: REC = Success, SEC = Failure, A = 20 Low Battery
; RegMod: A
#IFNDEF REDIRECT
CHAR2LPT: ; 8169
#IFNDEF CE158V2
; ************ Modified >
    PSH     A                               ; A is the ASCII charecter from input buffer?
    LDI	    A,$7F                           ; 
    STA     #(CE158_PRT_B_DIR)              ; Bit 7 Read (BUSY), (ME1)
    LDA     #(CE158_PRT_A)                  ; Read CE-158 Port A,  (ME1)
    AND     #(CE158_PRT_A)                  ; Filter out input changes? (ME1)
    SHL  
#ENDIF

#IFDEF CE158V2
    PSH     A                               ; A is the ASCII charecter from input buffer?
    LDA     #(CE158_UART_MSR0)              ; Read CE-158 Port MSR0,  (ME1)
    ;AND     #(CE158_UART_MSR0)              ; Filter out input changes? (ME1)
; <************
#ENDIF

    SHL                                     ; Original    7 6 5 4 3 2 1 0
    SHL                                     ; << 3        4 3 2 1 0 0 0 0 
    POP	    A                               ; Get our ASCII character from input buffer back
    BCS     BRANCH_81B8                     ; If #(PRT_A_IO) Bit 5, (Low Battery) skip to exit

#IFDEF CE158V2
; ************ Modified >
    BII     #(CE158_LPT_STATUS_READ),$80    ; (ME1)
    BZS     BRANCH_822C                     ; If Bit 7 not set (I/F_BUSY) borrow another exit
    ORI     #(CE158_LPT_CTL_WRITE),$01      ; SET LPT_STROBE (ME1) 

BRANCH_8196: ; Branched to from 818F

    STA     #(CE158_LPT_DATA_WRITE)         ; #(CE158_LPT_DATA_WRITE) = A (ME1).
                                            ; Shift in 818C aligns Bits 2-8 to PORTB.
    LDI	    A,$80                           ; Set up time delay

BRANCH_819C: ; Branched to from 81D9
    DEC	    A                               ; Carry set by first DEC, count 80->0
    BCS     BRANCH_819C                     ; If Carry set repeat, carry clear after hitting 0
    RIE                                     ; Disable interrupts 
    ANI     #(CE158_LPT_CTL_WRITE),$FE      ; CLR strobe bit (ME1) 
    LDI	    A,$80                           ; Set up time delay

BRANCH_81A8: ; Branched to from 81A9
    DEC	    A                               ; Carry set by first DEC, count 80->0
    BCS     BRANCH_81A8                     ; If Carry set repeat, Carry clear after hitting 0

    ORI     #(CE158_LPT_CTL_WRITE),$01      ; SET LPT_STROBE (ME1) 
    SIE                                     ; Enable Interrupts
    LDI	    A,$80                           ; Set up time delay
; <************
#ENDIF

#IFNDEF CE158V2
; ************ Modified >
    BII     #(CE158_PRT_B),$80              ; (ME1)
    BZS     BRANCH_822C                     ; If Bit 7 not set (I/F_BUSY) borrow another exit
    ANI     #(CE158_PRT_C),$9F              ; Clear Bits 6,5 LPT_STROBE,LPT_DATA1 (ME1) 
    EAI	    $FF                             ; A = A ^ FF. Invert due to inverters in LPT output
    SHR                                     ; A = A >> 1. Shifted through Carry, 0 into MSB
    BCR     BRANCH_8196                     ; If Bit 0 set (inverted/shifted out), branch fwd
    ORI     #(CE158_PRT_C),$20              ; Set Bit 5, LPT_DATA1 (ME1)

BRANCH_8196: ; Branched to from 818F
    STA     #(CE158_PRT_B)                  ; #(PRT_B_IO) = A (ME1). A = (A ^ FF) >> 1
    LDI	    A,$80                           ; Set up time delay

BRANCH_819C: ; Branched to from 81D9
    DEC	    A                               ; Carry set by first DEC, count 80->0
    BCS     BRANCH_819C                     ; If Carry set repeat, carry clear after hitting 0
    RIE                                     ; Disable interrupts 
    ORI     #(CE158_PRT_C),$40              ; Set LPT_STROBE (ME1)
    LDI	    A,$80                           ; Set up time delay

BRANCH_81A8: ; Branched to from 81A9
    DEC	    A                               ; Carry set by first DEC, count 80->0
    BCS     BRANCH_81A8                     ; If Carry set repeat, Carry clear after hitting 0
    ANI     #(CE158_PRT_C),$BF              ; CE-158 - Clear LPT_STROBE (ME1)
    SIE                                     ; Enable Interrupts
    LDI	    A,$80                           ; Set up time delay
; <************
#ENDIF 

BRANCH_81B4: ; Branched to from 81B5
    DEC	    A                               ; Carry set by first DEC, count 80->0
    BCS     BRANCH_81B4                     ; If Carry set repeat, Carry clear after hitting 0
    RTN                                     ; Carry will be reset by last DEC above

BRANCH_81B8: ; Branced from 817E            ; Return here if low battery
    LDI	    A,$20                           ; Does A = 20 mean low battery?
    SEC                                     ; Carry used to indicate return state? 
    RTN                                     ; Set Carry Flag. SEC = Failure
#ENDIF


; **We redirect this function to the low bank to free up room**
#IFDEF REDIRECT
CHAR2LPT: ; 8169
    PSH     A                               ; (1) Need to save char which is in A
    LDI     A,HB(LB_CHAR2LPT)               ; (2) HB of target
    STA     (ARW + $02)                     ; (3)
    LDI     A,LB(LB_CHAR2LPT)               ; (2) LB of target
    STA     (ARW + $03)                     ; (3) 
    POP     A                               ; (1) Get out character back
    JMP     LB_REDIRECT                     ; (3) [13]
    RTN                                     ; (1) 
#ENDIF


#IFDEF REDIRECT
;------------------------------------------------------------------------------------------------------------
;  Generic redirect to Low Bank - Target function address poked in ARW by caller
; Bank switch routine poked in ARW, target called, returns to High Bank
; !!!Called function cannot alter ARW!!!
LB_REDIRECT:
    PSH     A                               ; (1) Save A as we are modifying it
    LDI     A,$E3                           ; (2) RPU 'E3'
    STA     (ARW)                           ; (3)  ARW is scratch RAM
    LDI     A,$BE                           ; (2) SJP 'BE'
    STA     (ARW + $01)                     ; (3) 
    ; LDI     A,HB(Target)                  ; (2) HB of target address
    ; STA     (ARW + $02)                   ; (3) Saved by calling function
    ; LDA     A,LB(Target)                  ; (2) LB of target address
    ; STA     (ARW + $03)                   ; (3) Saved by calling function
    LDI     A,$E1                           ; (2) SPU 'E1'
    STA     (ARW + $04)                     ; (3)    
    LDI     A,$9A                           ; (2) RTN '9A'. Returns to what called func in High Bank.
    STA     (ARW + $05)                     ; (3)    
    POP     A                               ; (1) Get out original A back
    JMP     ARW                             ; (3) [33] {23}
#ENDIF

.FILL ($81BC - $)
.ORG $81BC 
; -----------------------------------------------------------------------------------------------------------
; CHAR2COM - Sends character in A to RS232 Port
; Called from:  TXCOM:8247, STRNG_2COM:875B, NULL2COM:87EA, 
;               SUB_PRINT_NUM:90B1, SUB_99D6:9A13, JMP_9ED0:BRANCH_9EF0
; Arguments: A character to send
; Outputs: REC = Success, A = #(CE158_PRT_A) Bits 5-2  on failure
; RegMod: A
CHAR2COM: ; 81BC
    SEC                                     ; Set Carry Flag
    PSH     U                               ; Save U.
    STA	    UL                              ; A is character to send

#IFNDEF CE158V2 
; ************ Modified >
    LDA	    #(CE158_PRT_A)                  ; #(CE158_PRT_A) is LPT/RS232 I/F Ctrl (ME1)
    AND	    #(CE158_PRT_A)                  ; Filter out changes (ME1)
    ANI	    A,$3C                           ; Keep Bits 2->CTS, 3->CD, 4->DSR, 5->Low Battery
    BZR     BRANCH_81E3                     ; Branch fwd if any bit 5-2 is set MODIFIED BRANCH ADDRESS
#ENDIF

#IFDEF CE158V2
    LDA	    #(CE158_UART_MSR0)              ; #(CE158_UART_MSR0) is RS232 I/F Ctrl (ME1)
 ;  AND	    #(CE158_UART_MSR0)              ; Filter out changes (ME1)
 	EAI     $30                             ; Invert the CTS/DSR bits-TI part does this automatically.
    ANI     A,$70                           ; NEW     4->CTS, 5->DSR, 6->Low Battery

    BZR     BRANCH_81E3A                    ; Branch fwd if any bit 5-2 is set MODIFIED BRANCH ADDRESS
 ; <************
 #ENDIF

    LDA	    (SETDEV_REG)                    ; (SETDEV_REG) = What device directed to RS232
                                            ; B7=? B6=THRE B5? B4=CO B3=CI B2=PO B1=DO B0=KI
    ANI	    A,$C0                           ; Keep Bits 7-6 are set at power on
    SHL                                     ; A = A < 1. Bit 7 into Carry, 0 carried into LSB
    BCS     BRANCH_81D6                     ; Branch fwd if Bit 7 was set.
    LDI	    A,$04                           ; A = 6. Set bit 2

BRANCH_81D6: ; Branched to from 81D2
#IFNDEF CE158V2 
 ; ************ Modified >
    AND	    #(CE158_UART_REGR)              ; A = A & UART_STATUS. A=Bit6 of SETDEV_REG<<1 or $04
                                            ; clear all but Bit7 (THRE) or Bit2 (PE)
    SEC                                     ; Set carry flag = failure
    BZS     BRANCH_81E3                     ; Branch fwd if Bit7 (THRE) or Bit2 (PE) not set
    LDA	    UL                              ; Our original A is in UL. Charecter to send.
    STA	    #(CE158_UART_DATAW)             ; Writes A to UART (ME1)
    REC                                     ; Reset Carry Flag = Success
#ENDIF

#IFDEF CE158V2
  	ROR
    AND	    #(CE158_UART_LSR0)              ; A = A & UART_STATUS. A=Bit6 of SETDEV_REG or $04
    SEC                                     ; Set carry flag = failure
    BZS     BRANCH_81E3                     ; Branch fwd if Bit7 (THRE) or Bit2 (PE) not set
    LDA	    UL                              ; Our original A is in UL. Charecter to send.

    STA	    #(CE158_UART_THR0)              ; Writes A to UART (ME1)
    REC                                     ; Reset Carry Flag = Success
    BCH     BRANCH_81E3

BRANCH_81E3A:
	SJP   DSRCTSFIX                         ; A = #(PORTA_IO) & 3C (Bits 5-2), failure type?
; <************
#ENDIF

BRANCH_81E3: ; Branched to from 81CA, 81DB 
    POP	    U                               ; Get original U back, affectes Z only
    RTN                                     ; A contains #(CE158_PRT_A) Bits 5-2 on failure



;-------------------------------------------------------------------------------------------------------------
; RXCOM - Configures LPT/UART registers
; Same as low bank
; called from 8CBD, 99BC.  Alt entry at 822C, 8CBD
; Arguments: None
; Outputs: REC = Success, A = Failure type or UART data read
; RegMod: A
RXCOM: 
    #IFNDEF CE158V2
; ************ Modified >
    LDA	    #(CE158_PRT_A)                  ; #(CE158_PRT_A) is LPT/RS232 I/F Ctrl (ME1)
    AND	    #(CE158_PRT_A)                  ; Filter out changes (ME1)
    ANI     A,$3C                           ; Keep Bits 2->CTS, 3->CD, 4->DSR, 5->Low Battery
    BZR     BRANCH_8230                     ; Branch fwd if any bits 5-2 were set, failure exit
    LDA     #(CE158_UART_REGR)              ; UART status register
#ENDIF

#IFDEF CE158V2
; ************ Modified > 
    LDA	    #(CE158_UART_MSR0)              ; #(CE158_UART_MSR0) is RS232 I/F Ctrl (ME1)
    AND	    #(CE158_UART_MSR0)              ; Filter out changes (ME1)

 	EAI     $30                             ;Invert the CTS/DSR bits-TI part does this automatically.
    ANI     A,$70                           ; NEW     4->CTS, 5->DSR, 6->Low Battery
    BZR     BRANCH_8230                     ; Branch fwd if any bits 4,5,6 were set, failure exit
    LDA     #(CE158_UART_LSR0)              ; UART status register
    ANI     A,$CF 
; <************
#ENDIF

    BII	    (SETDEV_REG),$40                ; Test Bit6                                             
                                            ; B7=? B6=THRE B5? B4=CO B3=CI B2=PO B1=DO B0=KI
    BZS     BRANCH_81FD                     ; If THRE not set branch fwd (last byte not done)
    SHL                                     ; A = A << 1. UART Status register

BRANCH_81FD: ; Branched to from 81FA
    BII	    A,$02                           ; Test Bit1 of A (Bit0 of CE158_UART_REGR) OE Overrun Error
    BZS     BRANCH_822C                     ; If set we had an Rx overrun, branch to failure exit

    BII	    (SETDEV_REG),$80                ; Test Bit7                               
                                            ; B7=? B6=THRE B5? B4=CO B3=CI B2=PO B1=DO B0=KI
    BZS     BRANCH_8208                     ; Branch fwd if Bit7 not set 
    SHL                                     ; A = CE158_UART_REGR << 2

BRANCH_8208: ; Branched to from 8205
    BII	    A,$70                           ; Keep bit 6-4, Bits 4-2 from original (CE158_UART_REGR)
    BZS     BRANCH_8226                     ; Bits 6-4 -> FE PE, if all bits clear branch (no error?)

#IFNDEF CE158V2
; ************ Modified > 
    LDA     #(CE158_UART_DATAR)             ; Read UART Data Register to clear it
    BII	    (SETDEV_REG),$20                ; Test Bit5  ; B7=? B6=THRE B5? B4=CO B3=CI B2=PO B1=DO B0=KI
    BZS     BRANCH_8222                     ; Branch fwd if Bit5 not set, failure 
    LDI	    A,$15                           ; sets: Bit4 WLS2, Bit2 SBS, Bit0 PI
    STA     #(CE158_UART_REGW)              ; Writing UART control reg
    LDI	    A,$05                           ; sets: Bit2 SBS, Bit0 PI
    STA     #(CE158_UART_REGW)              ; To pulse Bit 4?
#ENDIF

#IFDEF CE158V2
    LDA     #(CE158_UART_RBR0)              ; Read UART Data Register to clear it
    BII	    (SETDEV_REG),$20                ; Test Bit5  ; B7=? B6=THRE B5? B4=CO B3=CI B2=PO B1=DO B0=KI
    BZS     BRANCH_8222                     ; Branch fwd if Bit5 not set, failure
; <************ 
#ENDIF   

BRANCH_8222: ; Branched to from 8214
    LDI	    A,$40                           ; Failure type
    SEC                                     ; Set Carry Flag
    RTN                                     ; SEC = Failure

BRANCH_8226: ; Branched to from 820A        ; Success
#IFNDEF CE158V2
; ************ Modified > 
    LDA     #(CE158_UART_DATAR)             ; Read data byte
    REC                                     ; REC = Success
    RTN                                     ; Carry flag indicates return state

BRANCH_822C: ; Branched to bfrom 8185, 81FF ; OE Error
    LDI	    A,$00                           ; Failure type
    SEC                                     ; SEC = Failure
    RTN                                     ; Carry flag indicates return state

BRANCH_8230: ; Branched to from 81F0
    PSH     A
    LDA     #(CE158_UART_DATAR)             ; A = Data read from UART (ME1), clear Rx register  
#ENDIF

#IFDEF CE158V2
    LDA     #(CE158_UART_RBR0)              ; Read data byte
    REC                                     ; REC = Success
    RTN                                     ; Carry flag indicates return state

BRANCH_822C: ; Branched to bfrom 8185, 81FF ; OE Error
    LDI	    A,$00                           ; Failure type
    SEC                                     ; SEC = Failure
    RTN                                     ; Carry flag indicates return state

BRANCH_8230: ; Branched to from 81F0
	SJP     DSRCTSFIX                       ; A = #(PORTA_IO) & 3C (Bits 5-2), failure type?
	PSH     A                               ; 
    LDA     #(CE158_UART_RBR0)              ; Read data byte
; <************ 
#ENDIF

    SEC                                     ; SEC = Failure

BRANCH_8237: ; Branched to from 824A to borrow return
    POP	    A                               ; 
    RTN                                     ; A contains #(CE158_PRT_A) Bits 5-2 on failure



;------------------------------------------------------------------------------------------------------------
; TXCOM - not sure how this is called ***
; Checks that COM port ready and then calls CHAR2COM to TX char in A
; Arguments: A charecter to send
; Outputs:
; RegMod: UH
TXCOM:
    ANI	    (OUTSTAT_REG),$0F               ; Keep only low nibble Bit0 DTR, Bit1 RTS

BRANCH_823E: ; Branched to from 8250, 8256
    BII	    #(PC1500_IF_REG),$02            ; PC-1500 - IF Register Bit1 PB7 (ON Key)
    BZR     BRANCH_82B3                     ; If Bit 1 was set branch fwd to an exit (reset)
    PSH	    A                               ; Save cahracter to TX
    SJP     CHAR2COM                        ; Sends charecter in A to RS232 Port
    BCR     BRANCH_8237                     ; Carry Reset = success, branch back to borrow a return
    SHR                                     ;  CHAR2COM returns A = #(PRT_A_IO) Bits 5-2 on failure
    SHR                                     ; A = A >> 2. Through carry. 0 into MSB
    POP	    A                               ; POP A only changes Z flag
    BHR     BRANCH_823E                     ; If Bit 3 (half carry) not set by shifts above (CTS)
    ADI	    (OUTSTAT_REG),$10               ; (OUTSTAT_REG) += 10, Bit4 DSR. Being used as a loop counter.
    BCR     BRANCH_823E                     ; Are we waiting for a handshaking signal

BRANCH_8258: ; Branched to from 828C, 82AB to borrow return
    LDI	    UH,$32                          ; Return code?

BRANCH_825A: ; Branched to from 8284 to borrow return
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; TXLPT - Called from? ***
; Sends data to LPT output function, same as in low bank
; Arguments: A = character to send
; Outputs: A = Error code, 20 = Low Battery, 00 = Could not send?, UH: 45 = success
; RegMod: UH
#IFNDEF REDIRECT
TXLPT:
    ANI	    (OUTSTAT_REG),$0F               ; Keep only low nibble Bit0 DTR, Bit1 RTS

BRANCH_825F: ; Branched to from 828A
    PSH     U                               ;
    LDI	    UL,$FF                          ; try to send FF times?
    LDI	    UH,$00                          ; U = 00FF

BRANCH_8265: ; Branched to from 8275, 8279
    BII	    #(PC1500_IF_REG),$02            ; PC-1500 - IF Register Bit1 PB7 (ON Key)
    BZR     BRANCH_82B1                     ; If Bit 1 was set branch fwd to an exit (reset)
    PSH	    A                               ; Save cahracter to TX
    SJP     CHAR2LPT                        ; Sends charecter in A to LPT, Returns A as failure type
    BZR     BRANCH_8280                     ; A = 20 Low Battery, A = 00 is could not send?, C=0=success
    POP	    A                               ; A now original character to send
    LOP     UL,BRANCH_8265                  ; UL = UL - 1, loop back e if Borrow Flag not set
    INC	    UH                              ; UH = 1
    BCR     BRANCH_8265                     ; Keeps trying to send A until timeout ($FF * $FF)
    POP	    U                               ; Original U
    LDI	    UH,$45                          ;
    RTN                                     ; Return with ERROR code 45 in UH

BRANCH_8280: ; Branched to from 8271,       ; Got here because Low Battery or success
    POP	    A                               ; Original character to send
    POP	    U                               ; Original U
    BCR     BRANCH_825A                     ; Carry Clear = Success, borrowing a Return to exit
    ADI	    (OUTSTAT_REG),$10               ; (OUTSTAT_REG) += 10, Bit4 DSR. Being used as a loop counter.
    BCR     BRANCH_825F                     ; If we did not set carry
    BCH     BRANCH_8258                     ; Unconditional back branch, borrowing a return.

    ANI	    (OUTSTAT_REG),$0F               ; Keep Bits 0-3, Bit_0 = DCD, Bit_1 = DSR (bits we did not mess with)

BRANCH_8292: ; Branched to from 82A0, 82A9
    BII	    #(PC1500_IF_REG),$02            ; PC-1500 - IF Register Bit1 PB7 (ON Key)
    BZR     BRANCH_82B3                     ; If Bit 1 was set branch fwd to an exit (reset) Failure.
    SJP     RXCOM                           ; Manipulates LPT/UART registers
    BCR     BRANCH_82B0                     ;   REC = Success, A = Failure type or UART data read
    ANI	    A,$60                           ; A = A & 60. Keep bits 6-5
    BZS     BRANCH_8292                     ; If Bits 6 or 5 not set ***need to what these bits are
    SHL                                     ; A = A << 1. Thru carry. 0 into LSB
    BVS     BRANCH_82AD                     ; If Overlflow set
    ADI	    (OUTSTAT_REG),$10               ; (OUTSTAT_REG) += 10. Bit_0 = DCD, Bit_1 = DSR
    BCR     BRANCH_8292                     ; Carry set by shift above
    BCH     BRANCH_8258                     ; Unconditional back branch, borrowing a return.;

BRANCH_82AD: ; Branched to from 82A3
    LDI	    UH,$3A                          ; Return value? Failure.
    SEC                                     ; Set Carry Flag

BRANCH_82B0: ; Branched to from 829C
    RTN                                     ;

BRANCH_82B1: ; Branched to from 826A
    POP	    U                               ;

BRANCH_82B3: ; Branched to from 8243, 8297
    LDI	    UH,$00                          ; Return value? Failure.
    SEC                                     ; Set Carry Flag
    RTN                                     ;

#IFNDEF CE158V2
UKNOWN_82B7:
    .BYTE   $8E
#ENDIF
#ENDIF


; **We redirect this function to the low bank to free up room**
#IFDEF REDIRECT
TXLPT: ;
    LDI     A,HB(LB_TXLPT)                  ; (2) HB of target
    STA     (ARW + $02)                     ; (3)
    LDI     A,LB(LB_TXLPT)                  ; (2) LB of target
    STA     (ARW + $03)                     ; (3) 
    JMP     LB_REDIRECT                     ; (3) [13]
    RTN                                     ; (1) 

; needed for TXCOM exit
BRANCH_82B3: ; Branched to from 8243, 8297
    LDI	    UH,$00                          ; Return value? Failure.
    SEC                                     ; Set Carry Flag
    RTN                                     ;
#ENDIF

ADDRCHK($82B8,"COM_TBL_INIT")
.FILL ($82B8 - $),$FF
.ORG $82B8
;------------------------------------------------------------------------------------------------------------
; COM_TBL_INIT
; Called from BASIC Table 8000 INIT, changes XL which is used to calc index into vector table
; Arguments:
; Outputs:
; RegMod: XL
COM_TBL_INIT:
    LDI	    XL,$D0                          ; D0 is command code for INIT
    ANI	    (CE158_REG_79DE),$EF            ; ***What is this a flag for? Clear bit to to signal start of INIT?
    BCH     MAIN_ENTRY                      ; Branch fwd unconditional



;------------------------------------------------------------------------------------------------------------
; Following called via BASIC Table 8000 Command List vectors
; X-REG contains address of function below. Some stubs below change XL. Most drop through.
; XL used to calculate index into vector table
; Arguments:
; Outputs:
; RegMod: UL, XL
MERGE_V:
    INC	    UL                              ; Line number counter?
    LDI	    XL,$F0                          ; F0 a command code, used in MAIN_ENTRY
    BCH     MAIN_ENTRY                      ; Branch fwd unconditional

COM_TBL_INPUT_NUM:
    LDI	    XL,$ED                          ; ED a command code, used in MAIN_ENTRY
    BCH     MAIN_ENTRY                      ; Branch fwd unconditional

COM_TBL_PRINT_NUM:
    LDI	    XL,$EE                          ; EE a command code, used in MAIN_ENTRY
    BCH     MAIN_ENTRY                      ; Branch fwd unconditional

LPTR_TBL_PRINT_NUM:
    LDI	    XL,$EF                          ; EF a command code, used in MAIN_ENTRY
    BCH     MAIN_ENTRY                      ; Branch fwd unconditional

DTE_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

TERMINAL_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

COM_STR_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

DEV_STR_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

SETDEV_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

SETCOM_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

TRANSMIT_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

CONSOLE_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

FEED_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

LPRINT_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

LLIST_V:
    REC                                     ; Reset Carry Flag, does nothing drop through
    REC                                     ; Reset Carry Flag, does nothing drop through

CSAVE_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

CONSOLE_V2:
    REC                                     ; Reset Carry Flag, does nothing drop through

ERN_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

ERL_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

FEED_V2:
    REC                                     ; Reset Carry Flag, does nothing drop through

INPUT_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

INSTAT_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

LPRINT_V2:
    REC                                     ; Reset Carry Flag, does nothing drop through

LLIST_V2:
    REC                                     ; Reset Carry Flag, does nothing drop through

OUTSTAT_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

PRINT_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

PROTOCOL_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

RINKEY_STR_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

SPACE_STR_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

ZONE_V:
    REC                                     ; Reset Carry Flag, does nothing drop through



;------------------------------------------------------------------------------------------------------------
; MAIN_ENTRY - Called from 82BE, 82C3, 82C7, 82CB, 82CF
; Arguments: X-REG=Address BASIC Table pointed to. Y-REG Token
; Outputs: Calculates offset into Command Vector Table at $8331 based on LB address given in BASIC Table.
; A few commands alter the value in XL before reacing here. For some functions, low ROM banked back in.
; Function jumped to be setting its address in P. Table of calcualted vectors below.
; RegMod: U, A, X
;
; Addr low byte > D7 indicates a Low Bank command
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
; "PRINT#2"   NNNN    82CD  (82EF)     ; 8333 (93D4)  Low (for LPT)
; "INIT"      NNNN    82B8  (82D0)     ; 8371 (880A)  High, only one that does INC UL
MAIN_ENTRY: ; 82EC
    ORI     (OUTSTAT_REG),$08               ; Set Bit_3 = (D)CD (opposite of low bank)

HB_JMP_FRM_LB: ; 82F0 - Entry point from Low Bank
    ORI     (CRLF_REG),$08                  ; Entry from low bank, set Bit3 in CRLF_REGas High Bank flag
    SIE                                     ; Enable interrupts 
    PSH     X                               ; X-REG=Address BASIC Table pointed to
    SJP     PORTS_UPDATE                    ; Call sub(s) that configure CE-158 ***Is U used here?
    POP	    U                               ; Original X now in U
    LDI	    UH,$83                          ; Setting up pointer, UL is original XL in table above
    SEC                                     ; Set Carry flag, for SBC below
    LDI	    A,$D7                           ; Used to calculate offset into vector table
    SBC	    UL                              ; A = A - UL. 

BRANCH_8303:
    LDI	    UL,$63                          ; U = 8363
       
    BCS     BRANCH_830F                     ; If UL <= D7, High Bank command, skip ahead.
    DEC	    UH                              ; DEC UH 83 -> 82, U = 8263
    RIE                                     ; Disable interrupts
    ANI	    (CRLF_REG),$F7                  ; (CRLF_REG) = (CRLF_REG) & F7. Clear Bit 3
                                            ; Used as flag to swtich back to Low Bank

BRANCH_830F: ;Branched to by 8305.          ; Calc index into Command Vector Table @ 8331
    SHL                                     ; A << 1: Before: A = INIT=07, A = INIT=A0   
    ADR	    U                               ; U = U + A. U-REG is pointer into vector table
    LIN	    U                               ; A = (U) then INC U. Reading from Command Vector Table below
    STA	    XH                              ; XH = A. i.e. INIT A=88
    LDA	    (U)                             ; A = (U). i.e. INIT A=0A
    STA	    XL                              ; X-REG now has address of function
    BII	    (CRLF_REG),$08                  ; Test Bit3
                                            ;   This bit cleared in 830B above to signal Low Bank function
    BZS     BRANCH_831E                     ; If Bit 3 not set, we dropped through to 8307 so
                                            ;   skip ahead to go back to Low Bank.
    STX     P                               ; P = X, Sets prg Cntr to jump to High Bank function ***JMP


BRANCH_831E: ; Branched to from 831A        ; Go back to low bank to handle some functions
    LDI	    UH,HB(ARW)                      ; U = $7A28 =  AR-W
    LDI	    UL,LB(ARW)                      ; 
    LDI	    A,$E3                           ; Intialize $7A28-$7A31 to:
    SIN     U                               ; $E3  $BA  $83 $05, which is
    LDI	    A,$BA                           ; RPU  
    SIN     U                               ; JMP  $8305

    LDI	    A,HB(LB_RTN_FRM_HB)             ; This code segent sets PU to 
    SIN     U                               ;   bank in lower half of the CE-158 ROM
    LDI	    A,LB(LB_RTN_FRM_HB)             ;
    STA	    (U)                             ; 
    JMP	    ARW                             ; Jumps to $7A28, runs code segment POKED in above



;------------------------------------------------------------------------------------------------------------
; Command Vector Table
; Used as a vector jump table by MAIN_ENTRY
; 813C POKES value calulated with these numbers into program counter to jump to function/command handler
MERGE_VECTOR_8331:
    .WORD   $901C                           ; 901C - MERGE - Low Bank

PRINT_NUM2_VECTOR: 
    .WORD   $93D4                           ; 93D4 - PRINT#2 - Low Bank

PRINT_NUM_VECTOR:  
    .WORD   $93D0                           ; 93D0 - PRINT# - Low Bank

INPUT_NUM_VECTOR: 
    .WORD   $9660                           ; 9660 - INPUT# - Low Bank

CLOAD_VECTOR_8339:                                            
    .WORD   $901B                           ; 901B - CLOAD - Low Bank

UNKNOWN_VECTOR_833B:
    .WORD   $9870                           ; 9870 -  Unknown

SPACE_STR_VECTOR_833D:
    .WORD   $83D8                           ; 83D8 - SPACE$ ZONE - Low Bank

RINKY_STR_VECTOR_833F:    
    .WORD   $8357                           ; 8357-  RINKY$ - Low Bank

PROTOCOL_VECTOR_8341:
    .WORD   $8317                           ; 8317 - PROTOCOL - Low Bank

PRINT_VECTOR_8343:
    .WORD   $900D                           ; 900D - PRINT - Low Bank

OUTSTAT_VECTOR_8345:
    .WORD   $8334                           ; 8334 - OUTSTAT - Low Bank

LLIST_VECTOR_8347:
    .WORD   $901D                           ; 901D - LLIST - Low Bank

LPRINT_VECTOR_8349: 
    .WORD   $9056                           ; 9056 - LPRINT - Low Bank

INSTAT_VECTOR_834B:
    .WORD   $832A                           ; 832A - INSTAT - Low Bank

INPUT_VECTOR_834D:
    .WORD   $8FFF                           ; 8FFF - INPUT - Low Bank

FEED_VECTOR_834F:
    .WORD   $9820                           ; 9820 - FEED - Low Bank

ERL_VECTOR_8351: 
    .WORD   $8309                           ; 8309 - ERL - Low Bank

ERN_VECTOR_8353:
    .WORD   $8312                           ; 8312 - ERN - Low Bank

CONSOLE_VECTOR_8355: 
    .WORD   $8365                           ; 8365 - CONSOLE - Low Bank

CSAVE_VECTOR_8357: 
    .WORD   $901A                           ; 901A - CSAVE - Low Banks

UNKNOWN_VECTOR_8359: 
    .WORD   $9870                           ; 9870-  is in SUB_9845

UNKNOWN_VECTOR_835B: 
    .WORD   $9350                           ; 9350 - is in SUB_PRINT_NUM

UNKNOWN_VECTOR_835D:  
    .WORD   $93D8                           ; 93D8 - inside SUB_PRINT_NUM

FEED_DUP_835F: 
    .WORD   $9820                           ; 9820 - FEED duplicate - Low Bank

CONSOLE_DUP_8361: 
    .WORD   $8365                           ; 8365 - CONSOLE duplicate - Low Bank

TRANSMIT_8363:
    .WORD   $89F5                           ; 89F5 - TRANSMIT - High Bank

SETCOM_VECTOR_8365:                         ; 
    .WORD   $8907                           ; 8907 - SETCOM - High Bank

SETDEV_VECTOR_8367:                         ; 
    .WORD   $8968                           ; 8968 - SETDEV - High Bank

DEV_STR_VECTOR_8369:                        ; 
    .WORD   $8899                           ; 8899 - DEV$ - High Bank

COM_STR_VECTOR_836B:                        ; 
    .WORD   $8893                           ; 8893 - COM$ - High Bank

TERMINAL_VECTOR_836D:                       ; 
    .WORD   $8C88                           ; 8C88 - Terminal - High Bank

DTE_VECTOR_836F:                            ; 
    .WORD   $8C8E                           ; 8C8E - DTE - High Bank

INIT_VECTOR: 
    .WORD   $880A                           ; 880A - Points to 8800 BASIC Table Init code



;------------------------------------------------------------------------------------------------------------
; SEPARATOR_8373 - FF 00 ... used to fill unused addresses
#IFNDEF CE158V2
 #IFNDEF CE158_48
; ************ Modified >
SEPARATOR_8373:
    .BYTE  $FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF  ;
 #ENDIF
#ENDIF

; #IFDEF CE158_48
; CE158_48FIX:
;     ;If A=A1 Then (4800) B6=1, B7=7, Else (2400) B6=0, B7=1
;     BZS     SET2400                         ; (2) If Z=1 then 2400, else 4800
;     ORI	    #(CE158_PRT_A),$40              ; (4) (ME1). Set Bit 6
;     RTN                                     ; (1) 

; SET2400:
;     ORI	    #(CE158_PRT_A),$80              ; (4) (ME1) Set Bit 7
;     RTN                                     ; (1) [12]
; #ENDIF

;------------------------------------------------------------------------------------------------------------
; DSRCTSFIX - 
; Sets bits correctly for CTS/DSR/LBI
;   ORIGINAL 2->CTS, 3->CD, 4->DSR, 5->Low Battery
;   NEW                     4->CTS, 5->DSR, 6->Low Battery
; Fix CTS/DSR/LBI so they match the existing code base
#IFDEF CE158V2
DSRCTSFIX:
    SHR
    ANI    A,$30                            ; Keep the LBI and DSR bits
    BHR    DSR_CLR_RXCOM                    ; Check Bit 4. If not set skip otherwise set a CTS
	ORI    A,$04

DSR_CLR_RXCOM:
	RTN
; <************ 
#ENDIF



.FILL ($8380 - $)
.ORG $8380
;-------------------------------------------------------------------------------------------------------------
; JMP_8380
; Jumped to from SUB_8D04:8E52 with UL = $02
;   jumps back to SUB_8D04:8E55
; If CRLF_REG Bit7 set OR Japanese market OR DATA_PTR_H > 0 OR 7 Data Bits then UL = $02. Else UL = 0A
; 
; Arguments: UL
; Output: UL/A = 02 or 0A
; RegMod: A, UL
JMP_8380:
    BII	    (CRLF_REG),$80                  ; Not sure what this register does
    BZS     BRANCH_839D                     ; If Bit 7 was set
    BII     #(PC1500_PRT_B),$08             ; Test Bit3. Japanese/Export jumper.
    BZR     BRANCH_839D                     ; If PC-1500 Export model. (Vcc export, Gnd Japanese)
    LDA	    (DATA_PTR_H)                    ; Normally used for DATA statement pointer
    BZR     BRANCH_839D                     ; If A > 0 branch fwd
    LDA	    (SETCOM_REG)                    ; Bits 3,4 are Word Length
    ANI	    A,$18                           ; Keep Bits 3-4
    CPI	    A,$10                           ; Only Bit 4 set = 7 data bits
    BZR     BRANCH_839D                     ; If A != 10, i.e. 7 data bits, branch fwd
    LDI	    UL,$0A                          ; If 7 Data Bits

BRANCH_839D: ; Branched to from 8384, 838B, 8390, 8399
    LDA	    UL                              ; Jump directly here if PC-1500 export model
    STA	    (BRK_TOP_H)                     ; Beginning of program containing BREAK line
    JMP	    JMP_8E55                        ; Jumping back into SUB_8D04



;------------------------------------------------------------------------------------------------------------
; Unused space on original ROM
; We shift the rest of tables up and add this to bottom of TBL_SETDEV_TEXT in modified ROM
FILLER_83A4:
#IFNDEF ENBPD
    .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF,  $00,$FF,$00,$FF
#ENDIF 



;-------------------------------------------------------------------------------------------------------------
; CE158_IOREG_INIT - Used in PORTS_UPDATE:BRANCH_8A93 
; Copied to D00F-D008 (Reverse order) to inialize CE-158 lh5801 I/O registers
CE158_IOREG_INIT: ; 83B0 ORG, 83A4 BPD
#IFNDEF CE158V2
    .BYTE	$FF,$FF,$7F,$03,$00,$00,$00,$A0  
#ELSE
    .BYTE   $08,$03,$FF,$FF,$FF,$FF,$FF,$FF
#ENDIF



;-------------------------------------------------------------------------------------------------------------
; CE158_IO_REG_INIT2 - Used in SUB_9F75
; Copied to (reverse order) 7852-Console 1 (//), 7853-Undefined, 7854-Undefined, 7855-(MAIN_ENTRY), 7856-ZONE
CE158_IO_REG_INIT2: ; 83B8 ORG, 83AC BPD
    .BYTE	$00,$0D,$18,$00,$00 



;-------------------------------------------------------------------------------------------------------------
; UNKNOWN_83BD -  Not sure where used
UNKNOWN_83BD: ; 83BD ORG, 83B1 BPD
    .BYTE   $4F,$00,$7F 



;------------------------------------------------------------------------------------------------------------
; TBL_BAUD - Used to convert Baud rate settings in SETCOM to ASCII (I think)
; Used by 8ADC, 8C4B
TBL_BAUD: ; 83C0 ORG, 83B4 BPD          ;C7                               ;CF
#IFNDEF HIGHSPEED
 #IFNDEF CE158_48
; SETCOM_REG   19     39     59     79     99     B9     D9     F9
            ;  50    100    110    200    300    600   1200   2400
    .WORD   $0032, $0064, $006E, $00C8, $012C, $0258, $04B0, $0960 
 #ELSE
; SETCOM_REG   19     39     59     79     99     B9     D9     F9
            ; 100    110    200    300    600   1200   2400   4800 
    .WORD   $0064, $006E, $00C8, $012C, $0258, $04B0, $0960, $12C0
 #ENDIF
#ELSE
; SETCOM_REG   19     39     59     79     99     B9     D9     F9
            ;4800   9600  19200  38400    300    600   1200   2400  
    .WORD   $12C0, $2580, $4B00, $9600, $012C, $0258, $04B0, $0960
#ENDIF



;-------------------------------------------------------------------------------------------------------------
; TBL_WORDLEN - Actually BAUD settings for lh5811
; Used by PARSE_WORDLEN: $8B4D
TBL_WORDLEN: ; 83D0 ORG, 83C4 BPD
#IFNDEF CE158V2
 #IFNDEF CE158_48
; ************ Modified >
           ; 50  100  110  200  300  600  1200 2400
    .BYTE   $70, $58, $56, $4C, $48, $44, $42, $41
 #ELSE
           ;100  110  200  300  600  1200 2400 4800
    .BYTE   $58, $56, $4C, $48, $44, $42, $51, $49
 #ENDIF
#ENDIF

#IFDEF CE158V2
 #IFNDEF  HIGHSPEED
    ; BAUD   50      100     110     200    300     600     1200   2400
    .BYTE $24,$00,$12,$00,$10,$5D,$09,$00,$06,$00,$03,$00,$01,$80,$00,$C0
 #ELSE
	; Higher Baud Rate divisors supported by the CE158x
    ; BAUD  4800   9600    19200   38400    300     600     1200   2400
    .BYTE $00,$60,$00,$30,$00,$18,$00,$0C,$06,$00,$03,$00,$01,$80,$00,$C0
 #ENDIF
; <************
#ENDIF



;-------------------------------------------------------------------------------------------------------------
; TBL_SETDEV_TEXT - SETDEV Commnand text
; Used by 88CB, 8981
TBL_SETDEV_TEXT: ; 83D8 ORIG, 83CC BPD, 8391 BPD+V2
    .BYTE $4B, $49, $01                     ; KI,  1 = Bit 0 in SETDEV
    .BYTE $44, $4F, $02                     ; DO,  2 = Bit 1 in SETDEV
    .BYTE $50, $4F, $04                     ; PO,  4 = Bit 2 in SETDEV
    .BYTE $43, $49, $08                     ; CI,  8 = Bit 3 in SETDEV
    .BYTE $43, $4F, $10                     ; CO, 10 = Bit 4 in SETDEV
#IFNDEF ENBPD
TBL_SETDEV_END:                             ; Defines beginning of last row of table
#ENDIF

#IFDEF ENBPD
    ; 12 bytes from 83A4~83AF shifted to here, last 3 used in SETDEV_EXT1
    .BYTE $55, $30, $81 ;$80                ; U0, use UART 1 (Bit0=0=UART1)
    .BYTE $55, $31, $82 ;$81                ; U1, use UART 2 (Bit0=1=UART2) 
    .BYTE $42, $50, $9C ;$98                ; BP, enable BDP mode. 
                                            ; B4-3 set to pass mode mask in LB &903F
#IFDEF ENBPD
TBL_SETDEV_END:                             ; Defines beginning of last row of table
#ENDIF   
    .BYTE $00, $00, $00                     ; spare
#ENDIF 


;------------------------------------------------------------------------------------------------------------
; TBL_1854_CFG - CDP1854ACE UART configuration data for Parity, Stop, Word Length
; Used by 8B99
TBL_1854_CFG: ; 83E7 ORG, 83E7 BPD, 83EF BPD+V2
#IFNDEF CE158V2
; ************ Modified >
   .BYTE $42,$52,$62,$72,$82,$92,$A2,$B2,$46,$56,$66,$76,$C6,$D6,$E6,$F6 
   .BYTE $4A,$5A,$6A,$7A,$CA,$DA,$EA,$FA,$4E,$5E,$6E,$7E,$CE,$DE,$EE,$FE 
   .BYTE $89,$8D,$89,$89,$81,$85,$81,$81,$89,$8D,$89,$89,$81,$85,$81,$81 
   .BYTE $89,$8D,$89,$89,$81,$8D,$81,$81,$95,$9D,$95,$99,$91,$91,$91,$91
   .BYTE $12,$09,$49,$52,$61,$71,$C1,$03,$62,$56,$C2,$03,$09,$DC,$01,$42
   .BYTE $56,$E2,$02,$56,$2A,$4A,$FA,$01,$09,$5A,$4A,$2A,$C4,$0B,$59,$52
   .BYTE $41,$71,$E1,$04,$61,$59,$52,$61,$41,$52,$49,$C1,$02,$52,$12,$D2
   .BYTE $41,$49,$52,$41,$61,$52,$59,$E1,$44,$56,$64,$76,$03,$49,$11,$6A
   .BYTE $21,$4B,$11,$6C,$11,$4C,$11,$6C,$11,$4B,$21,$6A,$11,$C9
#ENDIF

#IFDEF CE158V2
; TI Config table for LCR register Parity, Stop, Word Length
    .BYTE $08,$00,$18,$10,$0C,$04,$1C,$14 ; 5 Bit settings
    .BYTE $09,$01,$19,$11,$0D,$05,$1D,$15 ; 6 Bit settings
    .BYTE $0A,$02,$1A,$12,$0E,$06,$1E,$16 ; 7 Bit settings
    .BYTE $0B,$03,$1B,$13,$0F,$07,$1F,$17 ; 8 Bit settings


;------------------------------------------------------------------------------------------------------------
; CONFIG_UARTS - Replacement init for TI part
CONFIG_UARTS:
	LDI      A,$03	
	STA      #(CE158_UART_LCR0)             ; Set 8,N,1 D203
	STA      #(CE158_UART_LCR1)             ; Set 8,N,1 for UART 1
 
	LDI      A,$08
	STA      #(CE158_UART_MCR0)             ; Set DTR/RTS = 1 TI PART INVERTS BITS, enable INT0 output
    LDI      A,$09                          ; Set DTR = 0, can be used to dynamically control the LPT
	STA      #(CE158_UART_MCR1)             ; Set DTR/RTS for UART 1, enable INT1 output

; Set up UART 2 as 19200,8,N,1 - May need to change when more commands are added.
 	LDI     A,00                            ; Set UART 1 to 2400,8,N,1
; THE SETTING OF A=0 IS USED MULTIPLE TIMES TO RESET REGISTERS
    STA     #(CE158_UART_IER0)              ; CLEAR IER REG
    STA     #(CE158_UART_IER1)              ; CLEAR IER REG
    STA     #(CE158_LPT_DATA_WRITE)         ; store in Parallel port output buffer
    STA     #(CE158_LPT_CTL_WRITE)          ; store in Parallel port Control Reg
;Set Baud Rate
    ORI	    #(CE158_UART_LCR1),$80          ; Set DLAB to point to Divisor Registers
    STA     #(CE158_UART_DLM1)              ; store first byte of divisor
	LDI     A,$18                           ; A = $18. 19200 BPS                                         
    STA     #(CE158_UART_DLL1)              ; store second byte of divisor;
    ANI	    #(CE158_UART_LCR1),$7F          ; Reset DLAB
	RTN
; <************
#ENDIF



;------------------------------------------------------------------------------------------------------------
; SETDEV_EXT2 - Extension for SETDEV to support SETUR
; Elsewhere for non V2 build
#IFDEF ENBPD
 #IFDEF CE158V2
SETDEV_EXT2:
    PSH     A                               ; We need orignal A later
    BII     A,$01                           ; If Bit 0 set, we are using UART 1
    BZS     EXT2_2                          ; Branch to UART 1 HB address set

    LDI     A,$D2                           ; Store the HB address for U0
    STA     (CE158_REG_79FE)                ;
    BCH     EXT2_3                          ;

EXT2_2:
    LDI     A,$D4                           ; Store the HB address for U1
    STA     (CE158_REG_79FE)                ;

EXT2_3:
    POP     A                               ; Get original A back
    ANI     (SETDEV_REG),$E0                ; clears bits used for SETDEV MODE
    ANI     A,$18                           ; keeps bits 4-3 of A (BPD CI CO settings),
    ORA     (SETDEV_REG)                    ;  allows passing  mode mask at LB $903F
    STA     (SETDEV_REG)                    ; 
    RTN                                     ;

 #ENDIF
#ENDIF



#IFDEF CE158V2
.FILL ($8475 - $),$FF
.ORG $8475
#ENDIF
;------------------------------------------------------------------------------------------------------------
; 84E7~84EE unknown table. Used by SUB_9A9E_ALT1 copies bytes into 7A00 (AR-X)
TBL_8475: ; 8475 ORG
    .BYTE $00,$0B,$07,$00,$00,$00,$7F,$41,$41,$00,$02,$04,$08,$10,$20,$00 
    .BYTE $41,$41,$7F,$00,$04,$02,$7F,$02,$04,$08,$1C,$2A,$08,$08,$00,$00 
    .BYTE $07,$0B,$00,$06,$27,$03,$2E,$02,$32,$03,$35,$04,$39,$05,$3E,$05 
    .BYTE $44,$08,$4A,$03,$53,$07,$57,$15,$5F,$00,$FF
    

TBL_84B0: ; 84B0 ORG
    .BYTE $19,$85,$7F,$17,$85 ;84B0
    .BYTE $3F,$0A,$85,$67,$0C,$85,$72,$0D,$85,$B8,$04,$84,$EF,$05,$84,$F4
    .BYTE $08,$85,$57,$0A,$85,$A6,$06,$85,$B1,$0C,$85,$99,$0D,$85,$0A,$09
    .BYTE $85,$18,$0B,$85,$29,$06,$85,$22,$09,$85,$35,$0F,$84,$FA,$17,$85
    .BYTE $C6,$18,$85,$DE,$14,$85,$F7,$17,$86,$0C



;------------------------------------------------------------------------------------------------------------
; TEXT_84EF - Text for Terminal program menus?
; Used by 870B
TEXT_84EF:
    .TEXT "ECHO "                           ;
    .TEXT "TRACE "                          ;
    .TEXT "CHANGE "                         ;
    .TEXT "AUTO "                           ;
    .TEXT "SIGNBUFFER "                     ;                                          
    .TEXT "LENGTH=BAUD "                    ;                    
    .TEXT "RATE=PARITY=WORD "               ;
    .TEXT "LENGTH=STOP "                    ;
    .TEXT "BITS=Setup:       "              ;
    .TEXT "Aut "                            ;
    .TEXT "Fnc "                            ;
    .TEXT "ComXON/XOFF  "                   ;
    .TEXT "?(Y/N)LOW "                      ;
    .TEXT "BATTERYSETTING "                 ;
    .TEXT "ERROR---ENTER "                  ;
    .TEXT "MENU "                           ;
    .TEXT "SELECTION "                      ;
    .TEXT "..EXT. "                         ;
    .TEXT "PRINTER "                        ;
    .TEXT "CLEAN "                          ;
    .TEXT "TEXT "                           ;
    .TEXT "CL=ETX "                         ;
    .TEXT "LPRINTER "                       ;
#IFNDEF CE158V2
    .TEXT "ERR0ROperate:     "              ;
#ENDIF
#IFDEF CE158V2
    .TEXT "ERROROperate:     "              ;
#ENDIF
    .TEXT "Nrm "                            ;
    .TEXT "A/P "                            ;
    .TEXT "A/LTerminal:    "                ;
    .TEXT "Ent Aut "                        ;
    .TEXT "QuitProtocol:   "                ;
    .TEXT "XO/O "                           ;
    .TEXT "EchoOutput:  "                   ;
    .TEXT "Ext "                            ;
    .TEXT "Trc "                            ;
    .TEXT "Dsp "                            ;
    .TEXT "Etx"                             ; 



;------------------------------------------------------------------------------------------------------------
; Unused space on original ROM
; SETDEV_EXT2 is Tail end of SETDEV extension on modified ROM for CE-158,
; Elsewhere if CE158V2 build
#IFDEF ENBPD
 #IFNDEF CE158V2
SETDEV_EXT2:
    ANI     (SETDEV_REG),$E0                ; clears bits used for SETDEV MODE
    ANI     A,$18                           ; keeps bits 4-3 of A (BPD CI CO settings),
    ORA     (SETDEV_REG)                    ;  allows passing  mode mask at LB $903F
    STA     (SETDEV_REG)                    ; 
    RTN                                     ;

    .BYTE  $00,$FF,$00,$FF                  ; remaining unused bytes
 #ELSE
    .BYTE  $00,$FF,$00,$FF,$00,$FF,$00,$FF, $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00  ;
 #ENDIF
#ELSE
    .BYTE  $00,$FF,$00,$FF,$00,$FF,$00,$FF, $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00  ;
#ENDIF



;------------------------------------------------------------------------------------------------------------
; TEXT_8635 - More text for Termainal program?
; Used by SUB_95C6
TEXT_8635:
    .TEXT "XO/O "                           ;
    .TEXT "Bks "                            ;
    .TEXT "Prt "                            ;
    .TEXT "Spcl "                           ;
    .TEXT "Esc "                            ;
    .TEXT "Ctl              "               ;
    .TEXT "Nrm "                            ;
    .TEXT "A/P "                            ;
    .TEXT "A/L  "                           ;



;------------------------------------------------------------------------------------------------------------
; TBL_8669 - 
; Used by 906A for setting LCD anunciators or terminal mode?
TBL_8669:
    .BYTE $30,$41,$42,$43,$7F,$1E,$7C,$7E,$7B,$5D,$7D,$60,$5C,$4D,$4E,$5E 
    .BYTE $5F,$1C,$1F,$53,$27,$5B,$56,$1D,$58,$59,$5A



;------------------------------------------------------------------------------------------------------------
; SUB_7A50_1 and SUB_7A50_2
; Either one is POKED into 7A50 by SUB_9976, this code is called by 933F
;
SUB_7A50_1: ; 8684
ORIGPC:     EQU $                           ; Save current PC
.ORG (B_STACK + $18)                        ; ($7A50) Set new PC to where this code will be POKE into RAM

SUB7A50_1:
SUB7A50_1HDR1:
    .BYTE   $19                             ; UL #loops, 19-0, i.e. 20 total
    .BYTE   $88                             ; XL of address to copy from, i.e. 8688

SUB7A50_1HDR2:
    .BYTE   $43                             ; UL #loops, 43-0, i.e. 44 total
    .BYTE   $A2                             ; XL of address to copy from, i.e. 86A2 

; Arguments - Y, UH
SUB_7A50_V1:
    RIE                                     ; (7A50) Disable interrupts
    RPV                                     ; (7A52) Set PV, bank in CE-158
    LDA     UH                              ; (7A53) A = UH = 20
    SJP     (CHAR2ADDR)                     ; (7A54) EE48 - Get address in char set table for char in A
    LDX	    Y                               ; (7A57) X = Y. Y set by $EE48
    LDI	    YL,LB(ARX)                      ; (7A59) 
    LDI	    YH,HB(ARX)                      ; (7A5B) Y = 7A00, X = ?
    TIN                                     ; (7A5D) Y = 7A00 -> 7A01 (Y) = (X) then X += 1, Y += 1
    TIN                                     ; (7A5E) Y = 7A01 -> 7A02
    TIN                                     ; (7A5F) Y = 7A02 -> 7A03
    TIN                                     ; (7A60) Y = 7A04 -> 7A05
    TIN                                     ; (7A61) Y = 7A06 -> 7A07
    SPV                                     ; (7A62) Bank out CE-158
    SIE                                     ; (7A63) Enable interrupts
    ANI     (Y),$00                         ; (7A65) Y = 7A07. (Y) = (Y) & 00, clear (Y)
    LDX	    Y                               ; (7A67) X = Y
    RTN                                     ; (7A69) 
        
.ORG (ORIGPC + ($-SUB7A50_1))               ; Set PC back to original range



;------------------------------------------------------------------------------------------------------------
; SUB_7A50_2 - POKED into 7A50 by SUB_9976
; Something to do with printing on CE-150
SUB_7A50_2: ; 86A2
ORIGPC2:    EQU $                           ; Save current PC
.ORG (B_STACK + $18)                        ; ($7A50) Set new PC to where this code will be POKE into RAM

SUB7A50_2:
    RPV                                     ; (7A50) [86A2] Reset PV Banks out CE-158, banks in CE-150
    RIE                                     ; (7A51) Disable interrupts
    BZR     BRANCH_7A6B                     ; (7A53) What set Z before getting here?
    BII	    (ZONE_REG),$40                  ; (7A55) 
    BZR     BRANCH_7A67                     ; (7A59) If Bit 6 was set branch Fwd
    BII	    (ZONE_REG),$20                  ; (7A5B) 
    BZS     BRANCH_7A87                     ; (7A60) If Bit 5 was set branch Fwd
    SJP     (LFEED + $7A)                   ; (7A62) $A9CB CE-150 something
    BCH     BRANCH_7A7B                     ; (7A65) Unconditional branch fwd

BRANCH_7A67: ; Branched to from 86AB
    SJP     (LFEED + $A0)                   ; (7A67) $A9F1 CR with line feed added
    BCH     BRANCH_7A83                     ; (7A6A) Unconditional branch fwd

BRANCH_7A6B: ; Branched to from 86A5
    BII	    (ZONE_REG),$40                  ; (7A6C)
    BZR     BRANCH_7A80                     ; (7A70) If Bit 6 was set branch Fwd
    BII	    (ZONE_REG),$20                  ; (7A72)
    BZS     BRANCH_7A87                     ; (7A76) If Bit 5 was set branch Fwd
    SJP     (COLDES + $0242)                ; (7A78) $A75B CE-150 something

BRANCH_7A7B: ; Branched to from 86B6
    SJP     (COLDES + $022E)                ; (7A7B) $A747 CE-150 something
    BCH     BRANCH_7A86                     ; (7A7E)

BRANCH_7A80: ; Branched to from 86C1
    SJP     PRINT_150                       ; (7A80) $A781 CE150 Print, send ASCII character to printer (no LF)

BRANCH_7A83: ; Branched to from 86BB
    SJP     MOTOFF                          ; (7A83) $A769 CE150 Printer motor OFF

BRANCH_7A86: ; Branched to from 86CF
    SPV                                     ; (7A86) Set PV, bank back in CE-158

BRANCH_7A87: ; Branched to from 86B1, 86C7
    BII	    (DISP_BUFF+$4E),$01             ; (7A87) Bit 0 (Busy) anunciator
    BZR     BRANCH_7A92                     ; (7A8B) If Busy set skip ahead
    ANI     #(CE150_MSK_REG),$FD            ; (7A8D) Clear Bit 1, PB7 Interrupt (Paper feed swtich)

BRANCH_7A92: ; Branched to from 86DC
    SIE                                     ; (7A92) Enable interrupts
    RTN                                     ; (7A94) 
     
.ORG (ORIGPC2 + ($-SUB7A50_2))               ; Set PC back to original range



;------------------------------------------------------------------------------------------------------------
; UNKNOWN_86E6 - Not text or sensible code
UNKNOWN_86E6:
    .BYTE   $5E,$30,$2B,$19,$11,$09,$05,$03,$00,$FF 
       


;------------------------------------------------------------------------------------------------------------
; SUB_86F0 -  ***JMP
; Calculates a new address to set P to (Program Counter) and it is POKED into P.
; Part of Terminal program
; Arguments: A
; Output:
; RegMod: U, A, X
SUB_86F0: ; Called from 8BD4, 8F7C
    LDA	    (ERR_TOP_H)                     ; Being used as a place to pass values to functions
                                            ; 8BD4 A >= $0A and A <= $2E, $8F7C A >= $0A and A <= $15
    SEC                                     ; Set Carry Flag
                                            ; To subtract set carry. If carry is cleared it indicates a borrow
    SBI	    A,$0A                           ; A = A - 0A

SUB_86F0_ALT_E1: ; Called from 8AB9 A < 0A / 2, A = 0-4
    SHR                                     ; A = A > 1. Through Carry, 0 into LSB A /= 2
    POP	    U                               ; Pops return address off of stack: $8BD7, $8F7F, $8ABC
                                            ; $8BD7 table $01+$12 bytes, $8F7F $01+$06 bytes, $8ABC table $01+$05 bytes
    PSH	    A                               ; Save A. 
    LIN	    U                               ; A = (U), then INC U. A = (8BD7) or A = (8F7F) or A = (8ABC)
                                            ;                      A = 12     or A = 06     or A =  05   
    LDX	    U                               ; X = 8BD8 or X = 8F80 or X = 8ABD 
    ADR	    U                               ; U = U + A.
                                            ; U = 8BD8 + 12 = 8BEA or U = 8F80 + 06 = 8F86 or U = 8ABD + 05 = 8AC2, 
                                            ;    All three look like valid addresses

BRANCH_8700: ; Branched to from 8743
    POP	    A                               ; Get original A back (12, 6, 5)
    PSH	    U                               ; Save U. Return address?
    ADR	    X                               ; X = $8BD8 + $00~$12 -> X = $8BD8~$8BEA
                                            ; X = $8F80 + $00~$05 -> X = $8F80~$8F85
                                            ; X = $8ABD + $00~$04 -> X = $8ABD~$8AC1
    LIN	    X                               ; A = (X), X = X + 1
                                            ; A = ($8BD8~$8BEA) = 1C 1E 1B 18 1A 1B 67  6B 90 7D 9A 2D 3C 3B 3A  39 38 2D
                                            ; A = ($8F80~$8F85) = 21 24 27 16 19 10
                                            ; A = ($8ABD~$8AC1) = 05 10 42 5E 4F
    ADR	    X                               ; X = X + A (+ 1 from above LIN)
                                            ; - $8BD9+$1C=$8BF5, $8BDA+$1E=$8BF8, $8BDB+$1B=$8BF6, $8BDC+$18=$8BF4, $8BDD+$1A=$8BF7 
                                            ;   $8BDE+$1B=$8BF9, $8BDF+$67=$8C46, $8BE0+$6B=$8C4B, $8BE1+$90=$8C71, $8BE2+$7D=$8C5F
                                            ;   $8BE3+$9A=$8C7D, $8BE4+$2D=$8C11, $8BE5+$3C=$8C21, $8BE6+$3B=$8C21, $8BE7+$3A=$8C21
                                            ;   $8BE8+$39=$8C21, $8BE9+$38=$8C21, $8BEA+$2D=$8C17
                                            ; - $8F81+$21=$8FA2, $8F82+$24=$8FA6, $8F83+$27=$8FAA, $8F84+$16=$8F9A, $8F85+$19=$8F9E
                                            ;   $8F86+$10=$8F96
                                            ; - $8ABE+$05=$8AC3, $8ABF+$10=$8ACF, $8AC0+$42=$8B02, $8AC1+$5E=$8B1F, $8AC2+$4F=$8B11 
    STX	    P                               ; P = X. Set Program Counter to X ***JMP



;------------------------------------------------------------------------------------------------------------
; TERMTXT_2INBUF - Called from 873A
; Copies text string from TEXT_84EF (Terminal menu text) to Input Buffer (7BB0)
; Arguments: A = multiple of 2, string index
; Outputs:
; RegMod: A, X, Y, U
TERMTXT_2INBUF:
    LDI	    YL,LB(IN_BUF)                   ; (Y)=7BB0, INPUT BUFFER Byte 0 START
    LDI	    YH,HB(IN_BUF)                   ; Setting up pointer?
    LDI	    XL,LB(TBL_84B0)                 ; (X)=84B0, inside text @ TEXT_84EF
    LDI	    XH,HB(TBL_84B0)                 ; Setting up pointer?
    CPI	    A,$22                           ; A is index into text table.
    BCR     BRANCH_8723                     ; Branch fwd if A < 22
    CPI	    A,$2E                           ; 
    BCS     BRANCH_8721                     ; Branch fwd if A >= 2E
    LDI	    XL,$FA                          ; X = 84FA ( A >= 22 and A < 2E )
    LDI	    UL,$06                          ; U = loop counter, 7 bytes to copy
    BCH     BRANCH_8732                     ; Branch fwd unconditional 

BRANCH_8721: ; branched to from 8719 A >= 2E
    SBI	    A,$0C                           ; A = A - 0C, A = 22~??

BRANCH_8723: ; branched to from 8715 A < 22
    ADR     X                               ; X = 84B0 to 85A3?                                  
                                            ; A = 0~F3.  A must be an even number.  If A = 0. 
    SHR                                     ; A = A >> 1.                           A = A / 2. 
    ADR	    X                               ; X= X + A.                             X = 84B0 + 0 = 84B0.
    LIN	    X                               ; A = (X) then INC X.                   A = (84B0) = 19
    STA	    UL                              ;                                       UL = 19. Copy 20 bytes
    LIN	    X                               ; A = (X) then INC X.                   A = (84B1) = 85
    PSH	    A                               ; Save A
    LDA	    (X)                             ; A = (X).                              A = (84B2) = 7F.
    STA     XL                              ;                                       X = 7F
    POP	    A                               ;                                       A = 85
    STA	    XH                              ;                                       X = 857F

BRANCH_8732: ; A >= 22 and A < 2E           ; (7BB0) = (84FA)...84FA starts with 'CHANGE '
    TIN                                     ; (Y) = (X) then X = X + 1, Y = Y + 1         
    LOP	    UL,BRANCH_8732                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; TERMTXT_DISP -  Jumped to from 8D45, 8D6D. A = 2E, 02, 30, 32, 40
; Calls TERMTXT_2INBUF Copies text string from TEXT_84EF to Input Buffer (7BB0)
; Then jumps to PRGMDISP (E8CA) to display content of display buffer
; Arguments: A = multiple of 2, string index
; Output:
; RegMod:
TERMTXT_DISP:
    ANI	    (DISPARAM),$00                  ; Reset Display parameter, i.e. how display looks @ READY
    SJP	    TERMTXT_2INBUF                  ; Copies text string from TEXT_84EF to Input Buffer (7BB0)
                                            ; A = String index
    SDP                                     ; Sets LCD ON/OFF control flip-flop
    JMP	    PRGMDISP                        ; Displays contents of display buffer on LCD



;------------------------------------------------------------------------------------------------------------
; Not used ?
UNKNOWN_8742:
    .BYTE   $F5,$88



;------------------------------------------------------------------------------------------------------------
; STRNG_2COM - Called from SUB_8D04:8E87
; Sends string to RS232. X-REG holds string, space $20, delimited
; Arguments: X set to first character of string
; Output:
; RegMod: X, UL, A
STRNG_2COM:
    INC     X
    
STRNG_2COM_ALT_E1:    
    RIE                                     ; Disable interrupts
    LDI	    UL,$1F                          ; Max of 32 tries to send.

BRANCH_8749: ; Branched to from 8760, 8766
    LDA	    (X)                             ; A = (X)
    BII	    A,$E0                           ; FLAGS = (X) & E0. Keep bits 7-5
    BZS     BRANCH_8768                     ; If no Bits 7-5 set, < 20, branch fwd
    CPI	    A,$40                           ; '('?
    BZR     BRANCH_8754                     ; If A != 40 branch
    LDI	    A,$0D                           ; A = 0D = CR

BRANCH_8754: ; Branched to from 8750 
    BII	    #(PC1500_IF_REG),$02            ; PC-1500 - PB7 Interrupt, PB7 = ON key
    BZR     BRANCH_8768                     ;  If ON key pressed
    SJP	    CHAR2COM                        ; Sends charecter in A to RS232 Port
    BCR     STRNG_2COM                      ;  Carry clear = success, send next charecter
    BZS     BRANCH_8749                     ;  retry same charecter, Z set when U popped off stack in sub
    BII	    A,$20                           ;  returns A = #(PRT_A_IO) Bits 5-2 on failure
    BZR     BRANCH_8768                     ; If A != 20, If not Low Battery, carry set by CHAR2COM
    LOP	    UL,BRANCH_8749                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set, DEC try counter

BRANCH_8768: ; Branched to from 874C, 8759, 8764
    REC                                     ; REC = success
    SIE                                     ; Enable interrupts.
    RTN                                     ; 



; .FILL ($876C - $)
;.ORG $876C 
;------------------------------------------------------------------------------------------------------------
; IRQ_RESET - Called from  SUB_8D04:8EC3
; Alt Entry at 8780 Called from SUB_8D04:8E7B
; Resets IRQ masks for PC-1500, CE-150, CE-158. 
; Resets CE-150 PB7 mask (Paper feed button), CE-158 DTR, RTS
; Arguments:
; Output:
; RegMod:
IRQ_RESET:
#IFNDEF CE158V2
; ************ Modified >
    ORI     #(CE158_MSK_REG),$01            ; CE-158 -  Set Bit0,   Interrupt mask for IRQ
#ELSE
    ORI     #(CE158_UART_IER0),$01          ; TI Set data ready IRQ ENABLE bit (DR) in IER0 Register
; <************
#ENDIF
    ANI	    #(CE150_MSK_REG),$FD            ; CE-150 -  Clear Bit1, PB7 Interrupt mask. Paper Feed Button
    ORI	    #(CE150_MSK_REG),$01            ; CE-150 -  Set Bit0.   Interrupt mask for IRQ
    ORI	    #(PC1500_MSK_REG),$01           ; PC-1500 - Set Bit0.   Interrupt mask for IRQ


IRQ_RESET_ALT_E1:
#IFNDEF CE158V2
; ************ Modified >
    ANI     #(CE158_PRT_A),$FC              ; Clear Bits 1-0 (ME1) Bit 0 = DTR, Bit 1 = RTS
#ELSE
    ORI     #(CE158_UART_MCR0),$03          ; Clear Bits 1-0 (ME1) Bit 0 = DTR, Bit 1 = RTS, TI PART INVERTS THE BITS
; <************
#ENDIF
    RTN                                     ;



.FILL ($8786 - $)
.ORG $8786
;------------------------------------------------------------------------------------------------------------
; Nonsense?
UNKNOWN_8786:
    .BYTE   $F0,$0A,$01,$FD,$E9,$D0,$0E,$FC,$9A,$BF

; 8786    F0                  VEJ (F0)
; 8787    0A                  STA XL
; 8788    01                  SBC (X)
; 8789    FD E9 D0 0E FC      ANI #(pp),$FC
; 878E    9A                  RTN
; 878F    BF                  BII A,n



;------------------------------------------------------------------------------------------------------------
; JMP_8790 - Jumped to from $8AC3 by way of 8709 vector calculation
; Part of Terminal program? May be reserving more buffer space?
; Arguments: Y, X = address jumped to from vector table $8AC3
; Output:
; RegMod: U, X
JMP_8790:
    LDI	    UL,$50                          ;
    SJP	    BCD_Y2ARX                       ; Pass BCD number pointed to by Y-Reg to AR-X
                ABYT($42)                   ;
    BCH     BRANCH_879A                     ; Unconditional fwd branch

    VEJ     (DE)                            ; Evaluate formula pointed to by Y-REG,
                ABRF(BRANCH_87D8)           ; passes result to AR-X. Jump FWD (n) if error

BRANCH_879A: ; Branched to from 8796, 87A1
    VEJ     (D0)                            ; Convert AR-X to integer pass to U. 
                ABYT($03)                   ; 03 specifies range. If exceeded branch fwd
                ABRF(BRANCH_87D8)           ;

    CPI	    UH,$02                          ; 
    BCR     BRANCH_87D6                     ; If UH < 2 branch fwd
    VEJ     (C8)                            ; If the following character does not represent end 
                ABRF(BRANCH_87DA)           ; the command sequence or line. C=1 if ":" 


SUB_87A3: ; Called from 8BC3
    VEJ	    (F4)                            ; Loads U with pointer to where variables start in RAM
                AWRD(VAR_START_H)           ;
    VEJ     (CC)                            ; Loads X-Reg with address at 78(67) 78(68)End address of basic in RAM
                ABYT($67)                   ;
    SJP	    U_MINUS_X                       ; U = U - X. When upper limit occurs: C=0 and UH=16 
    BCR     BRANCH_87D6                     ; Branch fwd if Carry reset (If error)
    LDI	    XL,$3A                          ; 
    LDI	    XH,$00                          ; X = 003A
    SJP	    U_MINUS_X                       ; U = U - X. When upper limit occurs: C=0 and UH=16 
    BCR     BRANCH_87D6                     ; Branch fwd if Carry reset (If error?)
    LDX	    U                               ; X = U
    VEJ	    (F4)                            ; Loads U with 16-bit value from address in AR-X
                AWRD(ARX + $05)             ;
    SJP	    U_MINUS_X                       ; U = U - X, When upper limit occurs: C=0 and UH=16 
    BCS     BRANCH_87D6                     ; Branch fwd if Carry set (If error?)
    VEJ     (CC)                            ; Loads X-Reg with address at 78(pp) 78(pp+1) End address of basic in RAM
                ABYT($67)                   ;
    INC	    X                               ; 
    VEJ	    (CA)                            ; X-REG to PREV_ADD_H (PREV_ADD_H)
                ABYT($A0)                   ;
    VEJ	    (F4)                            ; Loads U with 16-bit value from address in AR-X
                AWRD(ARX + $05)             ;
    VEJ	    (F6)                            ; Saves U to (PREV_LINE_H)
                AWRD(PREV_LINE_H)           ;
    VEJ     (CC)                            ; Loads X-Reg with address at 78(pp) 78(pp+1) End address of basic in RAM
                ABYT($67)                   ;
    LDA	    UL                              ;
    ADC	    XL                              ;
    STA	    XL                              ; XL = UL + XL
    LDA	    UH                              ;
    ADC	    XH                              ;
    STA	    XH                              ; XH = UH + XH
    VEJ	    (CA)                            ; Transfers X-REG to 78(A4), 78(A4), PREVIOUS TOP
                ABYT($A4)                   ;
    RTN                                     ; Returnm success


BRANCH_87D6: ; Branched to from 879F, 87AB, 87B4, 87BE
    LDI	    UH,$33                          ;  Got here if error occured

BRANCH_87D8: ; Branched to from 87DA
    SEC                                     ; Set Carry Flag = failure
    RTN                                     ; Return


BRANCH_87DA: ; Branched to from 87A1
    LDI	    UH,$01                          ; Failure code?
    SEC                                     ; Set Carry Flag  = failure
    RTN                                     ; Return



;------------------------------------------------------------------------------------------------------------
; NULL2COM
; Sends a 00 (NULL) to RS232 if SETDEV_REG Bit 6 is set.
; Arguments:
; Output:
; RegMod: UL, A 
NULL2COM:
    BII	    (SETDEV_REG),$40                ; Test Bit 6 in SETDEV_REG. Bit 6 for CO?
                                            ; KI = 01, DO = 02, PO = 04, CI = 08, CO = 10
    BZS     BRANCH_87F1                     ; Branch fwd if Bit 6 not set. Is Bit 6 a retry flag?
                                            ; Bits 6-7 set on power on reset. Bit 7 might be THRE?
    LDI     UL,$0F                          ; Try counter
    RIE                                     ; Disable interrupts

BRANCH_87E8: ; Branched to from 87EF
    LDI	    A,$00                           ; Charecter to send
    SJP	    CHAR2COM                        ; Sends charecter in A to RS232 Port
    BCR     BRANCH_87F1                     ; Branch fwd if Carry reset, Carry reset = success
    LOP	    UL,BRANCH_87E8                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set

BRANCH_87F1:
    SIE                                     ; Enable Interrupts
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; SEPARATOR_87F4 - FF 00 ... used to fill unused addresses
; CE158_48_EXT   - Handles 2400 and 4800 buad settings
#IFNDEF CE158_48
SEPARATOR_87F4:
    .BYTE $00,$FF,$00,$FF,$00,$FB,$00,$FF, $00,$FF,$00,$DF   ; Unused
#ELSE
CE158_48_EXT:
    ANI     A,$0F                           ; (2) Keep low nibble 2400=$A8->$08, 4800=$A4->$04
    AEX                                     ; (1) 2400=$80=%1000 0000, 4800=$40=%0100 0000 (bit positions in PortA)
    ORA	    #(CE158_PRT_A)                  ; (4) (ME1). Set Bit 6/7
    STA     #(CE158_PRT_A)                  ; (4) Write A back to PortA
    RET                                     ; (1) [12]
#ENDIF



;------------------------------------------------------------------------------------------------------------
; BASIC Table 8800 - (First table at 8000)
; Basically a copy of the low bank table. Special equates below to get it to build same as low bank
B_TBL_8800:
    .BYTE   $55                             ; Marker that BASIC Table follows 

B_TBL_8800_TNUM:
    .BYTE   $09                             ; Table number

B_TBL_8800_NAME:
    .TEXT   "LPRT\r\r\r\r"                  ; Table name

B_TBL_8800_INIT:
    LDI     UH,$01                          ; Table initilization vector
    RTN

B_TBL_8000_TAB:
B_TBL_8000_TAB2:
B_TBL_8800_INPUT_NUM:
    LDI	    UH,$1B                          ; Table INPUT# vector (Jumps to MERGE)
    VEJ     (E0)                            ; Is UH "00" error message

B_TBL_8800_PRINT_NUM:
    JMP	    $82CD                           ; Table PRINT# vector (Jumps to MERGE)

B_TBL_8800_JMPS:
    .BYTE $9A,$9A,$9A,$9A,$9A,$9A,$9A,$9A,$9A,$BA   ; Unused jumps                  

B_TBL_8800_TRACE:
    VEJ (C4) \                              ; Correct per book. Not used?
        ABYT($AF) \                         ;
        ABRF($811F)                         ;

B_TBL_8800_A_KW:
    .WORD   $0000                           ; 

B_TBL_8800_B_KW:
    .WORD   $0000                           ; 

B_TBL_8800_C_KW:
    .WORD   LET_C2                          ; 8856

B_TBL_8800_D_KW:
    .WORD   $0000                           ; 

B_TBL_8800_E_KW:
    .WORD   $0000                           ;  

B_TBL_8800_F_KW:
    .WORD   LET_F2                          ; 8862

B_TBL_8800_G_KW:
    .WORD   $0000                           ;   

B_TBL_8800_H_KW:
    .WORD   $0000                           ;  

B_TBL_8800_I_KW:
    .WORD   $0000                           ; 

B_TBL_8800_J_KW:
    .WORD   $0000                           ;   

B_TBL_8800_K_KW:
    .WORD   $0000                           ;   

B_TBL_8800_L_KW:
    .WORD   LET_L2                          ;

B_TBL_8800_M_KW:
    .WORD   $0000                           ;  

B_TBL_8800_N_KW:
    .WORD   $0000                           ;  

B_TBL_8800_O_KW:
    .WORD   $0000                           ;  

B_TBL_8800_P_KW:
    .WORD   $0000                           ;  

B_TBL_8800_Q_KW:
    .WORD   $0000                           ;  

B_TBL_8800_R_KW:
    .WORD   $0000                           ; 

B_TBL_8800_S_KW:
    .WORD   LET_S2                          ; 

B_TBL_8800_T_KW:
    .WORD   LET_T2                          ;

B_TBL_8800_U_KW:
    .WORD   $0000                           ; 

B_TBL_8800_V_KW:
    .WORD   $0000                           ; 

B_TBL_8800_W_KW:
    .WORD   $0000                           ; 

B_TBL_8800_X_KW:
    .WORD   $0000                           ;          

B_TBL_8800_Y_KW:
    .WORD   $0000                           ; 

B_TBL_8800_Z_KW:
    .WORD   $0000                           ; 

; Set some equates here to allow this to build the same as the low bank
B_TBL_8800_CMD_LST: ;Token LB < 80 command is function, else is proceedure

;Ctrl nibble    Ctrl nib calc            Name                  Token  Vector
LET_C2: EQU ($ + 2) ; ($ + 2) ; First keyword starting with 'C'. LET_C2 = Address of 'O' in CONSOLE
CN28:   EQU $D7 \ CNIB($D7,CN28)    \ .TEXT "CONSOLE"  \ .WORD $F0B1, LB_CONSOLE_2V; 82D8

LET_F2: EQU ($ + 2) ; ($ + 2) ; First keyword starting with 'F'. LET_F2= Address of 'E' in FEED
CN29:   EQU $D4 \ CNIB(CN28,CN29)   \ .TEXT "FEED"     \ .WORD $F0B0, LB_FEED_2V   ; 82D9

LET_L2: EQU ($ + 2) ; ($ + 2) ; First keyword starting with 'L'. LET_L2= Address of 'P' in LPRINT
CN30:   EQU $C6 \ CNIB(CN29,CN30)   \ .TEXT "LPRINT"   \ .WORD $F0B9, LB_LPRINT_2V ; 82DA
CN31:   EQU $D5 \ CNIB(CN30,CN31)   \ .TEXT "LLIST"    \ .WORD $F0B8, LB_LLIST_2V  ; 82DB 

#IFDEF ENBPD
LET_S2: EQU ($ + 2) ; ($ + 2) ; First keyword starting with 'D'. LET_D2
CN31_2: EQU $D5 \ CNIB(CN31,CN31_2) \ .TEXT "SETUR"    \ .WORD $E987, SETDEV_V     ; $82D5

LET_T2: EQU ($ + 2) ; First keyword starting with 'T'. LET_T2= Address of 'A' in TAB
CN32:   EQU $D3 \ CNIB(CN31_2,CN32) \ .TEXT "TAB"      \ .WORD $F0BB, B_TBL_8800_INPUT_NUM ; 880D
#ENDIF

#IFNDEF ENBPD
LET_S2: EQU $00
LET_T2: EQU ($ + 2) ; First keyword starting with 'T'. LET_T2= Address of 'A' in TAB
CN32:   EQU $D3 \ CNIB(CN31,CN32)   \ .TEXT "TAB"      \ .WORD $F0BB, B_TBL_8800_INPUT_NUM ; 880D
#ENDIF

CN33:   EQU $D0 \ .BYTE CN33 

B_TBL_
_CMD_LST_END:
.BYTE $D0



;------------------------------------------------------------------------------------------------------------
; SEPARATOR_8880 - Unused on original ROM
; Used as a jump vector for BPD command on modified ROM
BPD_8888:
#IFNDEF ENBPD
    .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00   ; Unused
#ELSE
    .BYTE $00;,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00   ; Unused
#ENDIF



;------------------------------------------------------------------------------------------------------------
; COM$ - Called from Command Vector Table at $8831
; Arguments:
; Output:
; RegMod:
COM_STR: ; 8893
    ANI	    (STK_PTR_GSB_FOR),$00           ; $00 = COM$, $FF= DEV$
    BCH     BRANCH_889D                     ; Branch into DEV_STR hander



;------------------------------------------------------------------------------------------------------------
; DEV$ - Called from Command Vector Table at $8331
; Converts SETDEV and SETCOM settings into ASCII
; Then it POKES in either 'RPU, RTN' or just 'RTN' to 7A30 and calls it. 
; Arguments:
; Output:
; RegMod: Y, U, A
DEV_STR:
    ORI	    (STK_PTR_GSB_FOR),$FF           ; $00 = COM$, $FF= DEV$

BRANCH_889D: ; Branched from COM$
    LDI	    YL,LBO(ARW,$06)                 ; Set up pointer?
    LDI	    YH,HBO(ARW,$06)                 ; Y = 7A2E -> in AR-W
    LDI	    UL,$15                          ; Loop counter, 15-0 16 bytes copied
    LDI	    A,$2C                           ; Value to be poked in $2C ','

BRANCH_88A5: ; Branched from 88A6           ; COM$ - Value to string 
    SDE	    Y                               ; (Y) = A. Then DEC Y. Y=7A2E~7A18, fill with 2C ','
    LOP	    UL,BRANCH_88A5                  ; DEC UL, if borrow flag not set loop back

    LDA	    (STK_PTR_GSB_FOR)               ; (STK_PTR_GSB_FOR) = $00 COM$ or $FF DEV$. Y = 7A18
    BZR     BRANCH_88BE                     ; [5] If A != 0 branch fwd. If mode is COM$ or UR$

    SJP	    SETCOM2ASCII                    ; COM$. Converts Baud Rate setting in SETCOM to ASCII?
    INC	    Y                               ; Y = 7A19. Leaving a ',' between
    SJP	    WORDLEN2ASCII                   ; Updates (Y) with ASCII value for Word Length, Y = 7A1A
    INC	    Y                               ; Y = 7A1B. Leaving a ',' between
    SJP	    PARITY2ASCII                    ; Updates (Y) with ASCII charecter for Parity, Y = 7A1C
    INC	    Y                               ; Y = 7A1D. Leaving a ',' between
    SJP	    STOPBIT2ASCII                   ; Updates (Y) with ASCII charecter for #Stop Bits Y = 7A1E
    BCH     BRANCH_88E3                     ; Branch fwd to display section


BRANCH_88BE: ; Branched from 88AB           ; DEV$ - value to string
#IFNDEF ENBPD
    LDA	    (SETDEV_REG)                    ; (3) Which devices are redirected to RS232
                                            ; KI = 01, DO = 02, PO = 04, CI = 08, CO = 10
    STA	    UL                              ; (2) UL = A = SETDEV_REG
    LDA	    (OPN)                           ; (3) OPN device code, Basic table to search first
    CPI	    A,$C0                           ; (2) Is OPN set to CE-158?
    BZS     BRANCH_88CB                     ; (2) If A == C0 branch fwd
    LDI	    UL,$00                          ; (2) [11] If OPN != CE-158 zero what was read from SETDEV_REG

BRANCH_88CB: ; Branched from 88C7           
    LDA	    UL                              ; (1) A = UL = (SETDEV_REG) or $00 is OPN != $0C (OPN)
    LDI	    XL,LB(TBL_SETDEV_TEXT)          ; (2) X = 83D8. SETDEV Command text table
    LDI	    XH,HB(TBL_SETDEV_TEXT)          ; (2) Y = 7A1E 
    LDI	    UL,$04                          ; (2) [7] Loop counter, 4-0 all 5 possible SETDEV settings
#ENDIF

#IFDEF ENBPD
    SJP    DEVSTR_EXT1                      ; (3) 
    BII     A,$80                           ; (2) If bit 7 set then UR$
    BZR     BRANCH_88CB                     ; (2) Skip OPN test
    BII     (OPN),$C0                       ; (3) Test OPN mode
    BZR     BRANCH_88CB                     ; (2) If OPN set to CE-158 then skip ahead
    LDI     A,$00                           ; (2) [11] else zero out settings read in, they are not in effect

BRANCH_88CB: ; Branched from 88C7           ; Change start,  # loops, OR in $80 to A for UR$
    SJP     DEVSTR_EXT2                     ; (3) Change start point past SETDEV entries
    LDI	    XH,HB(TBL_SETDEV_TEXT)          ; (2) Y = 7A1E
#ENDIF

BRANCH_88D2: ; Branched from 88DC           ; TBL_SETDEV_TEXT .BYTE 4B 49 01 = K I 01 (Bit 0 in SETDEV)
    TIN                                     ; (Y) = (X) then INC both X,Y. X = 83D9, Y = 7A1F
    TIN                                     ; (Y) = (X) then INC both X,Y. X = 83DA, Y = 7A20
    INC	    Y                               ; Y = Y + 1 = 7A21, leaving a ','
    SHR                                     ; A = A >> 1. A = (SETDEV_REG) or $00
    BCS     BRANCH_88DB                     ; If Bit 0 (KI?) was set branch fwd
    DEC	    Y                               ; Y = 7A1F 
    DEC	    Y                               ; Y - 7A1E
    DEC	    Y                               ; Y = 7A1D 

BRANCH_88DB: ; Branched from 88D6
    INC	    X                               ; X = 83DB, next text entry (DO)
    LOP	    UL,BRANCH_88D2                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set.

    CPI	    YL,$19                          ; Y=7A19?
    BCR     BRANCH_88E3                     ; If YL < 19 branch fwd
    DEC	    Y                               ;


BRANCH_88E3: ; Branched from 88BC, 88E0     ; This is the display section
    LDA	    YL                              ;
    SEC                                     ; Set Carry
    LDI	    XL,LB(ARU)                      ;
    SBC	    XL                              ; A = A - XL, A is string length?
    LDI	    XH,HB(ARU)                      ; X = 7A18
    SJP	    XREG2STRBUF                     ; X points to string to insert into String buffer. Branch if overflow 
                ABRF(BRANCH_88F0)           ;
    LDI	    UH,$00                          ;
    
BRANCH_88F0:    
    LDI     A,$9A                           ; 
    BII	    (OUTSTAT_REG),$80               ; No idea what Bit7 is
    BZR     BRANCH_8901                     ; If Bit 7 is set branch fwd, to poke RTN, 9A into 7A30
    STA	    (ARS + $01)                     ;  or into 7A31
    ANI	    (CRLF_REG),$F7                  ; Clear Bit 3. Flag for?
    LDI     A,$E3                           ; RPU opcode

BRANCH_8901:  ; Branched from 88F6
    STA	    (ARS)                           ; If branched here are are poking 9A RTN, else E3 SPU, 9A RTN (to swtich to low bank)
    JMP	    ARS                             ; Were are doing RTN to what? 



;-------------------------------------------------------------------------------------------------------------
; SETCOM - Called by command vector table by 831C
; Sets COM parameters, i.e. SETCOM 2400,8,N,1
; Arguments: X=$8097, Y=token
; Output:
; RegMod:
SETCOM:
    SJP	    TXT2STRBUF                      ; Copies string arg to String buffer. (Y) points to buffer
    BCR     BRANCH_890E                     ; C=0 means arguments found
    PSH     X                               ; X is pointer to $8907?

BRANCH_890E: ; Branched to from 890A
    VEJ     (C8)                            ; If not end of line, branch fwd. Look for arguments
                ABRF(BRANCH_8915)           ; 
    SJP	    SET_DEFAULT_BAUD                ; Use default of 300,8,N,1
    BCH     BRANCH_895E                     ; Exit, go back to Start of BASIC


BRANCH_8915:                                ; Handles '=' if exists
    VEJ	    (C4)                            ; Check tokens/char in U-Reg 
                ABYT($3D)                   ; if not 3D '=' branch fwd BRANCH_8919
                ABRF(BRANCH_8919)           ;
    VEJ     (C0)                            ; load next character/token to U-Reg

BRANCH_8919: ; Branched to from 8915        ; Handles place holder ',' for BAUD
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not 2C ',' branch fwd BRANCH_8920
                ACHR(COMMA)                 ;
                ABRF(BRANCH_8920)           ;
    VEJ     (C8)                            ; If not at end of line, branch fwd BRANCH_892E
                ABRF(BRANCH_892E)           ;
    BCH     BRANCH_895E                     ; Exit, go back to Start of BASIC


BRANCH_8920: ; Branched to from 8919        ; Handles BAUD argument
    VEJ     (C6)                            ; Decrements Y-Reg by 2 bytes for tokens, 1 byte for characters in U-Reg
    SJP	    PARSE_BAUD                      ; Creates an int from text? BAUD
    BCS     BRANCH_89BC                     ; If PARSE_BAUD returned C=1, failure, borrow exit
    VEJ     (C8)                            ; If not at end of line, branch fwd BRANCH_892E
                ABRF(BRANCH_892A)           ;
    BCH     BRANCH_895E                     ; Exit, go back to Start of BASIC


BRANCH_892A:                                ; Checks for ',' for between BAUD and Word Length
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not 2C ',' branch fwd BRANCH_89C0 
                ACHR(COMMA)                 ;
                ABRF(BRANCH_89C0)           ;
    VEJ     (C0)                            ; load next character/token to U-Reg

BRANCH_892E: ; Branched to from 891C        ; Handles place holder ',' for Word Length
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not ',' branch fwd BRANCH_8935
                ACHR(COMMA)                 ;
                ABRF(BRANCH_8935)           ;    
    VEJ     (C8)                            ; If not at end of line, branch fwd BRANCH_8943
                ABRF(BRANCH_8943)           ;
    BCH     BRANCH_895E                     ; Exit, go back to Start of BASIC


BRANCH_8935: ; Branched to from 892E        ; Handles Word Length
    VEJ     (C6)                            ; Decrements Y-Reg by 2 bytes for tokens 1 byte for characters in U-Reg
    SJP	    PARSE_WORDLEN                   ; Parse Word Length argument
    BCS     BRANCH_89BC                     ; Carry set in sub = Failure
    VEJ     (C8)                            ; If following character not end to command sequence/line branch fwd BRANCH_893F
                ABRF(BRANCH_893F)           ;
    BCH     BRANCH_895E                     ; Exit, go back to Start of BASIC


BRANCH_893F: ; Branched to from 893B        ; Checks for ',' for between Word Length and Parity
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not 2C ',' branch fwd BRANCH_89C0
                ACHR(COMMA)                 ;
                ABRF(BRANCH_89C0)           ;    
    VEJ     (C0)                            ; load next character/token to U-Reg

BRANCH_8943: ; Branched to from 8931        ; Handles place holder ',' for Parity
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not 2C ',' branch fwd BRANCH_894B 
                ACHR(COMMA)                 ;
                ABRF(BRANCH_894B)           ;    
    VEJ     (C8)                            ; If following character not end to command sequence/line branch fwd BRANCH_89B6
                ABRF(BRANCH_89B6)           ; Processes Stop Bits
    NOP                                     ; Does what it says on the tin
    BCH     BRANCH_895E                     ; Exit, go back to Start of BASIC


BRANCH_894B: ; Branched to from 8943        ; Handles Parity 
    VEJ     (C6)                            ; Decrements Y-Reg by 2 bytes for tokens 1 byte for characters in U-Reg
    SJP	    PARSE_PARITY                    ; Parity Charater parsing
    BCS     BRANCH_89BC                     ; Carry set in sub = Failure
    VEJ     (C8)                            ; If following character not end to command sequence/line branch fwd BRANCH_8955
                ABRF(BRANCH_8955)           ;
    BCH     BRANCH_895E                     ; Exit, go back to Start of BASIC


BRANCH_8955: ; Branched to from 8951        ; Checks for ',' for between Parity and Stop Bits
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not 2C ',' branch fwd n
                ACHR(COMMA)                 ;
                ABRF(BRANCH_89C0)           ;     
    VEJ     (C8)                            ; If following character not end to command sequence/line branch fwd BRANCH_89B6 
                ABRF(BRANCH_89B6)           ; Processes Stop Bits
    BCH     BRANCH_895E                     ; Unconditional branch fwd (exit)


BRANCH_895C: ; Branched to from 89BA
    VEJ     (C8)                            ; If following character not end to command sequence/line branch fwd BRANCH_89C0 
                ABRF(BRANCH_89C0)           ;

BRANCH_895E: ; Branched to from 8913, 891E, 8928, 8933, 893D, 8949, 8953, 895A, 897A, 89A7  
    DEC	    Y                               ; 
    LDA	    (TRACE)                         ;
    VZS	    ($E2)                           ; If Z set, i.e. no TRACE, jump to Start of Basic Interpreter
    POP	    Y                               ; Get original Y back, what is it? Realted to TRACE?
    VEJ     (E2)                            ; Start of Basic Interpreter



;--------- ---------------------------------------------------------------------------------------------------
; SEPARATOR_8967 - 00 FF used to fill in used areas
SEPARATOR_8967:
    .BYTE   $FF 



;-------------------------------------------------------------------------------------------------------------
; SETDEV - Called by command vector table by 831C
; Arguments: X=$8968, Y=token
; Output:
; RegMod: A, U, X, Y
HB_SETDEV: ; 8968
    SJP	    TXT2STRBUF                      ; Copies string argument into string buffer
    AND	    (SETDEV_REG),$E0                ; (SETDEV_REG) = (SETDEV_REG) & E0, clears bits 4-0
                                            ; KI = 01, DO = 02, PO = 04, CI = 08, CO = 10
    BCR     BRANCH_8973                     ; C=0 means string not found, I.E. CI used instead of "CI"
    PSH     X                               ; String arg used, i.e. "CI". X is pointer to CSI

BRANCH_8973: ; Branched to from 896F        ; If no argument set OPN back to LCD
    VEJ     (C8)                            ; If following character not end to command sequence/line branch fwd BRANCH_897C
                ABRF(BRANCH_897C)           ; 
    LDI	    A,$60                           ; 60 = LCD
    STA	    (OPN)                           ; (OPN) Idicates which BASIC table to parse first
    BCH     BRANCH_895E                     ; Unconditional branch back, borrow exit from SETCOM

BRANCH_897C: ; Branched to from 8973        ; Handle '=' if exists
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not 3D '=' branch fwd BRANCH_8980
                ACHR(EQUALS)                ;
                ABRF(BRANCH_8980)           ;    
    VEJ     (C0)                            ; load next character/token to U-Reg

BRANCH_8980: ; Branched to from 897C
    VEJ     (C6)                            ; Decrements Y-Reg by 2 bytes for tokens 1 byte for characters in U-Reg

BRANCH_8981: ; Branched to from 89AC
    LDI	    XL,LB(TBL_SETDEV_TEXT)          ;
    LDI	    XH,HB(TBL_SETDEV_TEXT)          ; X = 83D8 = TBL_SETDEV_TEXT
    VEJ     (C0)                            ; load next character/token to U-Reg
    BCS     BRANCH_89BC                     ; Carry set means token found
    LDA	    UL                              ; Character loaded via (C0)
    PSH	    A                               ; save it
    VEJ     (C0)                            ; load next character/token to U-Reg
    POP	    A                               ; A = first character loaded
    BCS     BRANCH_89BC                     ; Carry set = token loaded 
    STA	    UH                              ; UH = first character, UL = second character

BRANCH_8991: ; Branched to from 89B2
    LDA	    UH                              ; 1st char = 1st char of table? X = $83D8
    CIN                                     ; FLAGS = A CMP (X), INC X.
    BZR     BRANCH_89AE                     ; If A != (X) branch fwd
    LDA	    UL                              ; 2nd char
    CIN                                     ; FLAGS = A CPI (X),INC X
    BZR     BRANCH_89AF                     ; If A != (X) branch fwd
    LDA	    (X)                             ; Both chars matched so pull SETDEV bit value from table

    #IFNDEF ENBPD                           ; If BPD command not enabled
    ORA	    (SETDEV_REG)                    ; ORs it in
    STA	    (SETDEV_REG)                    ; and saves it
    #ENDIF

    #IFDEF ENBPD                            ; If BPD command is enabled
    SJP     SETDEV_EXT1                     ; Jump to extened code to handle BPD command related code
    STA	    (SETDEV_REG)                    ; The ORA part in done in SETDEV_EXT1
    #ENDIF
                                            ; KI = 01, DO = 02, PO = 04, CI = 08, CO = 10
    LDI	    A,$C0                           ;
    STA	    (OPN)                           ; (OPN) Parse CE-158 BASIC tables first
    VEJ     (C8)                            ; If following character not end to command sequence/line branch fwd BRANCH_89A9
                ABRF(BRANCH_89A9)           ;        
    BCH    BRANCH_895E                      ; Unconditional branch back

BRANCH_89A9: ; Branched to from 89A5
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not 2C ',' branch fwd n
                ACHR(COMMA)                 ;
                ABRF(BRANCH_89C0)           ; Error exit
    BCH     BRANCH_8981                     ; Unconditional jump back. *** Why start over?


BRANCH_89AE: ; Branched to from 8993
    INC	    X                               ; X = X + 1

BRANCH_89AF: ; Branched to from 8997
    INC	    X                               ; X = X + 1
    CPI	    XL,LB(TBL_SETDEV_END)           ; X is TBL_SETDEV_TEXT $E7/$E1 is LB beginning of last row of table
    BCR     BRANCH_8991                     ; If XL < E7 branch back, try again for a match?
    BCH     BRANCH_89BC                     ; Unconditional jump fwd


BRANCH_89B6: ; Branched to from 8946, 8958  ; This seems like it was just stuck in an empty holes
    VEJ     (C6)                            ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
    SJP	    PARSE_STOPBITS                  ; Parse Stop Bits
    BCR     BRANCH_895C                     ; Exit?


BRANCH_89BC: ; Branched to from 8924, 8939, 894F, 8986, 898E, 89B4
    LDI	    UH,$33                          ; Failure code?
    BCH     BRANCH_89C2                     ; Unconditional jump fwd


BRANCH_89C0: ; Branched to from 892A, 893F, 8955, 895C, 89A9
    LDI	    UH,$01                          ; Failure code?

BRANCH_89C2: ; Branched to from 89BE
    DEC	    Y                               ;
    LDA	    (TRACE)                         ;
    VZS	    ($E0)                           ; If Z set, i.e. trace not set, Jump Indicates if UH is not "00" error message
    POP	    Y                               ; Does FFE0 use Y? Might be original X we pushed, used for error address?
    VEJ     (E0)                            ; Indicates if UH is not "00" error message



;------------------------------------------------------------------------------------------------------------
; TXT2STRBUF - copies text from constant or string variable to the String buffer
; Arguments: (8968) X=$8068, Y=token, (8907) X=$8097, Y=token
; Output: Text into String Buffer, 0D delimited. C=0 if string not found.
; RegMod: A,X,Y
TXT2STRBUF: ; $89CB, called from 8907, 8968
    VMJ	    ($36)                           ; Stores CSI of text constant or text variable in AR-X (C=1). 
                                            ; If no string is detected, C=0 
    ANI	    (TRACE),$00                     ; Clear all bits, flag for no string?
    BCR     BRANCH_89EE                     ; Carry reset - No string
    PSH	    Y                               ; Save Y. Y-REG is token of calling function
    ORI	    (TRACE),$FF                     ; Set all bits, flag for string?
    VEJ     (DC)                            ; Loads CSI from AR-X: (X) Address, UL & A length. 
    LDI	    YL,LB(STR_BUF)                  ; CSI = 'Character String Information' 
    LDI     YH,HB(STR_BUF)                  ; $7B10 - STRING BUFFER Byte 0 Start
    BZS     BRANCH_89E5                     ; Skip if length in UL is zero
    DEC	    A                               ; A = A - 1. A is string length.
    STA	    UL                              ; Loop counter

BRANCH_89E2: ; Branched to from 89E3        ; Copies string from AR-X to String Buffer
    TIN                                     ; (Y) = (X) then X = X + 1, Y = Y + 1
    LOP	    UL,BRANCH_89E2                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set

BRANCH_89E5: ; Branched to from 89DE        ; Return if success
    LDI	    A,$0D                           ; 0D = CR
    STA	    (Y)                             ; (Y) = A, add CR to end of string
    LDI	    YL,$10                          ; Set Y back to start of buffer
    POP	    X                               ; X=token of calling function?
    SEC                                     ; Set Carry Flag
    RTN                                     ; Return

BRANCH_89EE: ; Branched to from 89D1        ; Return if failure
    STX     Y                               ; Y = X. Y-REG is address of calling function.
    RTN                                     ; Return



;------------------------------------------------------------------------------------------------------------
; SEPARATOR_89F1 - 00 FF fills unused space
SEPARATOR_89F1:
    .BYTE $FF, $00, $FF, $00                ; Not used



;------------------------------------------------------------------------------------------------------------
; TRANSMIT - Called from Command Vector Table
; Alt entry at 8A07 - Called from JMP_9ED0:9F13
; Parses something and resets UART?
; Arguments: X-REG=$89F5, Y-REG Token
; Output:
; RegMod: A
TRANSMIT: ; 89F5
    VEJ	    (C2)                            ; If next token is not 'F0 B3' (BREAK), branch fwd BRANCH_8A05
                AWRD($F0B3)                 ; 'F0 B3' is the BREAK token
                ABRF(BRANCH_8A05)           ;     
    VEJ	    (C2)                            ; If next character is not 2C ',', branch fwd BRANCH_8A05
                ACHR(COMMA)                 ;
                ABRF(BRANCH_8A05)           ;    
    VEJ	    (DE)                            ; Calculate formula which Y-Reg points to, pass result to AR-X. Jump FWD (n) if error
                ABRF(BRANCH_8A06)           ;    
    VEJ	    (D0)                            ; Convert AR-X to integer & load to U-Reg. 09 is range. Range exceeded: Branch fwd BRANCH_8A06
                ABYT($09)                   ;
                ABRF(BRANCH_8A06)           ;
    SJP	    UNKNOWN_8A07                    ; 
    VEJ     (E2)                            ; Start of Basic Interpreter, i.e. EXIT

;Error handeling 
BRANCH_8A05: ; Branched to from 89F5, 89F9
    VEJ     (E4)                            ; Output error 1 and return to the editor

BRANCH_8A06: ; Branched to from 89FC, 89FE
    VEJ     (E0)                            ; Is UH "00" error message



;------------------------------------------------------------------------------------------------------------
; UNKNOWN_8A07 - 
; Parses something and resets UART?
; Arguments: 
; Output:
; RegMod: A
UNKNOWN_8A07: ; Called from 8A01, 9F13
    LDI	    A,$0D                           ; 0D = CR
    STA	    (STK_PTR_GSB_FOR)               ; Used for flags
    SJP	    HB_CFG_URT_LPT                  ; Sets D201 which is UART config register
    VEJ	    (F4)                            ; Loads U-Reg with 16-bit value from address (ARX + 5)
                AWRD(ARX + $05)             ;
    SJP	    TIMEDELAY                       ; Time delay 15,625 ms * Number from U-Reg. BREAK is possible.
    ANI	    (STK_PTR_GSB_FOR),$00           ; Used for flags, clear it
    SJP	    HB_CFG_URT_LPT                    ; Sets D201 which is UART config register
    JMP	    NULL2COM                        ; Sends a 00 to RS232 if SETDEV_REG Bit is set, then RTN



;------------------------------------------------------------------------------------------------------------
; SEPARATOR_8A1F - 00 FF filles unused space
SEPARATOR_8A1F:
    .BYTE   $FF                             ; Unused



;------------------------------------------------------------------------------------------------------------
; RELOC_CODE_8A20 - POKED into Sytem RAM by PORTS_UPDATE to read a value in from (A297) with SPC reset
;                   A297 is in CE-150 ROM
; Arguments:
; Output: A = (A297)
; RegMod: A
ORIGPC3:     EQU $                          ; Save current PC
RELOC_CODE_8A20:
.ORG (ARV+$06)                              ; Set new PC to where this code will be POKE into RAM
   
RELOC_8A20:
    RIE                                     ; (7A26) Disable interrupts
    RPV                                     ; (7A28) Reset PV Banks out CE-158, banks in CE-150
    LDA	    (MGP1_150 + $0C)                ; (7A29) $A297Something in CE-150? CE-150 ROM has $6D
    SPV                                     ; (7A2C) Set PV, bank back in CE-158
    SIE                                     ; (7A2D) Enable interrupts
    RTN                                     ; (7A2F) Done

.ORG (ORIGPC3 + ($-RELOC_8A20))            ; Set PC back to original range



.FILL ($8A2A-$),$FF
.ORG $8A2A
;------------------------------------------------------------------------------------------------------------
; PORTS_UPDATE - Called from 82F8, 8E02, 8E34
; Pokes code from RELOC_CODE_8A20 above into 7A26 and calls it. Checks for something in CE-150
; May update lh5811 ports and do other INIT realted stuff
; Seems to set BAUD and/or DTR/RTS each time too
; Arguments: X = Address BASIC Table pointed to, Y = token
; Output:
; RegMod: A, UH
PORTS_UPDATE: ; 8A2A
    LDI	    A,$9A                           ; RTN?
    STA	    (CE158_REG_79FA)                ; 79FA~79FE used by CE-158

#IFNDEF CE158V2
; ************ Modified >
    ORI	    #(CE158_PRT_C),$80              ; Paper Feed key (ME1)
#ENDIF

#IFDEF CE158V2
    ORI     #(CE158_LPT_CTL_WRITE),$01      ; SET LPT_STROBE (ME1) 
; <************
#ENDIF

    PSH	    X                               ; Command Code in X already pushed in MAIN_ENTRY
    LDI	    XL,(LB(RELOC_CODE_8A20) + $09)  ; RELOC_CODE_8A20 end address (copies backwards)
    LDI	    XH,HB(RELOC_CODE_8A20)          ; X = 8A29. Set up to copy to sytem RAM
    LDI	    UL,LB(ARW + $07)                ; End address of destination System RAM address
    LDI	    UH,HB(ARW)                      ; U = 7A2F. 7A26 to 7A2F in AR-W

BRANCH_8A3E: ; Branched to from 8A43
    LDE	    X                               ; A = (X) then X = X - 1. A = (8A29)
    STA	    (U)                             ; Copy 8A20->8A29 from ROM to 7A26 to 7A2F (AR-W) in RAM 
    DEC	    UL                              ;  values: FD BE,  B8,   A5 A2 97,  A8, FD 81, 9A
    CPI	    UL,$26                          ;            REI, RPV, LDA (A297), SPV,   SEI, RTN
    BCS     BRANCH_8A3E                     ; Branch back to finish the copying

    LDI	    XL,LB(ZONE_REG)                 ; 
    LDI	    XH,HB(ZONE_REG)                 ; X = 7856 = ZONE_REG Bits 4-0 used for ZONE
    ANI	    (X),$1F                         ; X = (ZONE_REG) & 1F, zeros bits 7-5 of value in ZONE_REG
    SJP	    (ARV + $06)                     ; Call (A297) sub poked in above.
                                            ;  No CE-150,  No CE-158 A297=FF. No CE-150, Yes CE-158 A297=F7
                                            ; Yes CE-150, Yes CE-158 A297=6D
    BZR     BRANCH_8A52                     ; Branch fwd if (A297) was not zero
    ORI	    (X),$20                         ; Set Bit 5 (ZONE_REG) CE-150 mystery ROM

BRANCH_8A52: ; Branched to from 8A4E
    CPI	    A,$6D                           ; Compare t0 $6D, CE-150 and CE-158
    BZR     BRANCH_8A58                     ; If A != 6D.
    ORI	    (X),$40                         ; (ZONE_REG) Sets Bit6, has CE-150

; this section seems to set PORT_A and PORT_B directions
BRANCH_8A58: ; Branched to from 8A54        ; Bit6=1=CE-150, Bit6=0=/CE-150, Bit5=1=?? CE-150 FW version?
    POP     U                               ; Pops original X into U. Command code now in UL.
    LDI	    UH,HB($D00D)                    ; Changes High Byte to D0. D0 + Command Code (see $82EC)
    BII	    (CE158_REG_79DE),$10            ; Test Bit4 ***what is this register
    BZS     BRANCH_8A7B                     ; Brach fwd if Bit4 was not set
    BII	    (X),$20                         ; (ZONE_REG) Bit5. (CE-150 mystery ROM)
    BZS     BRANCH_8AE9                     ; If Bit5 not set branch fwd, borrow a return

#IFNDEF CE158V2                                       
; ************ Modified >                   ; Code below only for mystery ROM?                        
    LDI	    UL,LB($D00D)                    ; U = D00D (CE158_PRT_B_DIR)
    LDI	    A,$7F                           ; Load A with 7F to send to address
    STA	    #(U)                            ; pointed to by (U), D00D (CE158_PRT_B_DIR) $7F
    DEC	    U                               ; DEC U pointer to   D00C (CE158_PRT_A_DIR)
    LDI     A,$C3                           ; Load A with C3 to send to address
    STA	    #(U)                            ; pointed to by (U), D00C (CE158_PRT_A_DIR) $C3
    DEC	    U                               ; U = D00B
    DEC	    U                               ; U = D00A, (CE158_MSK_REG)
    ANI	    #(U),$00                        ; Clear D00A
; <************
#ENDIF

#IFDEF CE158V2
    LDI     A,$C3                           ; Load A with C3 to send to address
#ENDIF

    STA	    (TRACE)                         ; (A still C3?)
    BCH     BRANCH_8AA0                     ; Unconditional fwd branch


.FILL ($8A7B - $),$FF
.ORG $8A7B
BRANCH_8A7B:  ; Branched to from 8A60       ; UH=D0, UL=Command code
    ORI	    (CE158_REG_79DE),$10            ; Set bit 4
    LDI	    A,$FE                           ; FE used by BZR+ branch
    CPI	    UL,$D0                          ; FLAGS = UL & D0. Command code D0=INIT command
    BZR     BRANCH_8A8A                     ; If UL != D0 branch fwd

                                            ; INIT code?
    LDA	    (ARV)                           ; A = (AR-V)
    ANI	    A,$01                           ; A = A & 01, mask off all but bit 0

BRANCH_8A8A: ; Branched to from 8A83
    STA	    (TRACE)                         ; (TRACE) = A. A = (ARV) & 01 (INIT Cmd) or A = FE (else)

#IFNDEF CE158V2
; ************ Modified >
    LDI	    XL,LB(CE158_IOREG_INIT)         ; 
    LDI	    XH,HB(CE158_IOREG_INIT)         ; X = 83B0 = CE158_IOREG_INIT
    LDI	    UL,$0F                          ; U = D00F = CE158_PRT_B

BRANCH_8A93:  ; Branched to from 8A99       ; Sets default state of #(D00F~D008) copied backwards
    LIN	    X                               ; A = (X) &then X = X + 1. X=83B1
    STA     #(U)                            ; (U) = A. U = D00F
    DEC	    UL                              ; Copies 8 bytes from X = 83B0-83B7 to U = D00F-D008   
    CPI	    UL,$07                          ;  Inits CE-158 lh5811 IO registers. Bytes: FF FF 7F 03 00 00 00 A0
    BCS     BRANCH_8A93                     ; If UL > 07 branch back, = 7 we are done
#ENDIF

#IFDEF CE158V2
;Replacement init for TI part
    ORI	    #(CE158_UART_SCR0),$FF          ; CE-158 (Scratch register)
    SJP CONFIG_UARTS                        ; Configure the UARTS
; <************
#ENDIF

   LDI	    UL,LB($D056)                    ; U = D056, X = 83B8 (83B8 value not used yet) 
   SJP	    SUB_9F75                        ; Initializes some CE-158 registers

BRANCH_8AA0: ; Branched to from 8A79
    SJP	    SET_DTR_RTS                     ; Sets DTR/RTS based on OUTSTAT_REG
    BII	    (TRACE),$01                     ; FLAGS = (TRACE) & 01, mask all but bit 0 off
    BZR     HB_CFG_URT_BD                   ; If bit 0 in (TRACE) set, branch fwd
                                            ; Branch fwd, set BAUD rate, then return

;--------------------------------------------------------------------------------------------------
; SET_DEFAULT_BAUD - 
SET_DEFAULT_BAUD: ; Jumped to from to from 8910
#IFDEF CE158V2
 #IFDEF ENBPD
    LDI     A,$81                           ; (2) Set default for or SETUR to UR0
    SJP     SETDEV_EXT1                     ; (3) Only needed with CE158V2 & ENBPD
 #ENDIF
#ENDIF

    LDI	    A,BPSDEF                        ; 300,8,N,1 default setting
    BCH     BRANCH_8B3A                     ; Branch fwd, set BAUD rate, then return



;.ORG $8AAD
;--------------------------------------------------------------------------------------------------
; PORTS_UPDATE_ALT_E2 - Called from SUB_8D04:8EDA
; Not sure what this does. Searches through TBL_BAUD at $83C0
; Part of terminal program?
; Arguments:
; Output:
; RegMod: A, X
PORTS_UPDATE_ALT_E2: ; xxxx ORG, 8AB3 V2
    LDA	    (ERR_TOP_H)                     ; Used as unknown flags
    SEC                                     ; Set Carry Flag
    SBI	    A,$16                           ; A = A - 16
    BCR     BRANCH_8AC2                     ; If A < 16 Branch fwd, Return
    CPI	    A,$0A                           ; A 0~E9 at this point
    BCS     BRANCH_8AC6                     ; A >= 0A Branch fwd, else A < 0A
    SJP	    SUB_86F0_ALT_E1                 ; Calculates a new address to set P to, uses U, X, A

DATA_8ABC: ; Used by SUB_86F0_ALT_E1        ; SUB_86F0_ALT_E1 pops the return address of above
    .BYTE $05,$05,$10,$42,$5E,$4F           ; off stack to know where this data table starts.

BRANCH_8AC2: ; Branched to from 8AB3
    RTN                                     ;


; Jumped to from 8709 vector calculation
    JMP	    JMP_8790                        ;


BRANCH_8AC6:  ; Branched to from 8AB7
    LDA	    XL                              ; Not sure what X or Y is here
    SBC	    YL                              ; A = XL - YL
    LDX	    Y                               ; Transfer Y to X
    VMJ	    ($24)                           ; Sends address from X-Reg as CSI, format "D0 XH XL length" to AR-X 
    JMP	    TXFR_RSV_KEY                    ; Transfers reserve key assignment to reserve storage area



;--------------------------------------------------------------------------------------------------
; PARSE_BAUD
; Arguments: from 8709 X = 8ACF, Y = Token
; Output:
; RegMod: A, X ; 8AD5 V2
PARSE_BAUD: ; Branched to from 8921, Jumped to from 8709 vector calculation
    LDI     UL,$50                          ; Length argument for BCD_Y2ARX
    SJP	    BCD_Y2ARX                       ; Pass BCD number pointed to by Y-Reg to AR-X
                ABRF(BRANCH_8B2B)           ;
    VEJ     (D0)                            ; Convert AR-X to INT & load to U-Reg. 06 is range. If range exceeded: Branch fwd
            #IFNDEF HIGHSPEED
                ABYT($06)                   ; Limit values to < 32769
            #ELSE 
                ABYT($00)                   ; Limit values to < 65536
            #ENDIF
                ABRF(BRANCH_8B2B)           ;    
    LDI	    XL,LB(TBL_BAUD)                 ; 
    LDI	    XH,HB(TBL_BAUD)                 ; X = 83C0, 'TBL_BAUD'

                                            ;            100   110    200    300    600    1200   2400   4800 
                                            ;   .WORD   $0064, $006E, $00C8, $012C, $0258, $04B0, $0960, $12C0
                                            ;            50    100    110    200    300    600    1200   2400   
BRANCH_8ADC: ; Branched to from 8AE7        ; TBL_BAUD: 00 32  00 64  00 6E  00 C8  01 2C  02 58  04 B0  09 60 
    LIN	    X                               ; A = (X) then INC X.   X=83C1
    CPA	    UH                              ; U is INT version of argument 
    BZR     BRANCH_8AE4                     ; Branch fwd if A != UH
    LDA	    (X)                             ; A = (X)               83C1
    CPA	    UL                              ; What is U used for here?
    BZS     BRANCH_8AEA                     ; Branch fwd if A = UL

BRANCH_8AE4: ; Branched to from 8ADE
    INC	    X                               ; X = 83C2
    CPI     XL,LBO(TBL_BAUD,$10)            ; Check for end of table: XL Orig: $D0, Mod: $C4
    BCR     BRANCH_8ADC                     ; Brach back if XL < D0

BRANCH_8AE9: ; Branched to from 8A64
    RTN                                     ; Return if match not found?


BRANCH_8AEA: ; Branched to from 8AE2        ; Got here is match found
    LDA	    XL                              ; LB of last adddress read. X >= 8C31?, A >= 31?     
    SBI     A,LBO(TBL_BAUD,$01)             ; Distance of match from end of first data pair
    AEX                                     ; Swap hi and low nibbles of Accumulator. 3 2 1 0 7 6 5 4
    ANI	    (SETCOM_REG),$1F                ; Keeps Bits 7-5. Bits 0,1 Parity. Bit 2 Stop Bit. Bits 3,4 Word Length. Bits 5,6,7 Baud. 
    BCH     BRANCH_8B37                     ; Branch fwd if any bits 7-6-5 not set
    LDI	    UL,$50                          ; Length of second argument?
    SJP	    BCD_Y2ARX                       ; Pass decimal number which Y points to AR-X. Jump in case of error 
                ABRF(BRANCH_8B2B)           ;
    VEJ     (D0)                            ; Convert AR-X to INT & load to U. 08 specifies the range. If range exceeded: Branch fwd n
                ABYT($08)                   ;    
                ABRF(BRANCH_8B2B)           ;     
    STA	    (ON_ERR_ADD_L)                  ; (ON_ERR_ADD_H) = A
    REC                                     ; Reset Carry Flag = success
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; PARSE_WORDLEN: ; Called from 8936
; Parse and set SETCOM settings
; Arguments: A, (SETCOM)
; Output:
; RegMod: A, X
PARSE_WORDLEN: ; Jumped to from 8709 vector calculation
    VMJ	    (02)                            ; Load next token/character into U, A = UL
                ABYT($35)                   ; check if (UL) in interval n1-n2. If not branch n3
                ABYT($39)                   ; $35-$39: 5,6,7,9 i.e. Word length
                ABRF(BRANCH_8B2B)           ;
    SBI	    A,$34                           ; A = A - 34. Convert ASCII # to int
    AEX                                     ; Swap hi and low nibbles of A. If A = 08 then A = 80
    SHR                                     ; A = A >> 1. A = 80 >> = 40
    ANI	    (SETCOM_REG),$E7                ; Bits 0,1 Parity. Bit 2 Stop Bit. Bits 3,4 Word Length. Bits 5,6,7 Baud. 
    BCH     BRANCH_8B37                     ; Unconditional branch fwd. Argument in A


PARSE_STOPBITS: ; Called from 89B7, Jumped to from 8709 vector calculation
    VMJ	    (02)                            ; Load next token/character into U-Reg, A = UL
                ABYT($31)                   ; check whether value in UL in interval n1-n2. If not branch n3
                ABYT($33)                   ; $31-$33: 1,2,3 i.e. Stop Bits
                ABRF(BRANCH_8B2B)           ;    
    ANI	    A,$02                           ; Keep Bit 1.
    SHL                                     ; A = A << 1. Shifted through Carry, 0 into LSB
    ANI	    (SETCOM_REG),$FB                ; clear Bit 2, Stop Bit. Bits 3,4 cleared above. 
                                            ; Bits 0,1 Parity. Bit 2 Stop Bit. Bits 3,4 Word Length. Bits 5,6,7 Baud.  
    BCH     BRANCH_8B37                     ; Unconditional branch fwd. Argument in A


PARSE_PARITY: ; Called from 894C, Jumped to from 8709 vector calculation  ; Parse parity settings
    VEJ     (C0)                            ; load next character/token into U-Reg
    BCS     BRANCH_8B2B                     ; Branch fwd if Carry set, i.e. error from sub
    VMJ	    ($34)                           ; A 'Switch-Case' type of function 
                ABYT($02)                   ; 0-2 cases. Bits 0,1 Parity. Bit 2 Stop Bit. Bits 3,4 Word Length. Bits 5,6,7 Baud. 
                ABYT($4E) \ ABRF(BRANCH_8B2E)   ; If UL is 4E, 'N', branch fwd to 8B2E
                ABYT($45) \ ABRF(BRANCH_8B2F)   ; If UL is 45, 'E', branch fwd to 8B2F
                ABYT($4F) \ ABRF(BRANCH_8B2D)   ; If UL is 4F, 'O', branch fwd to 8B2D
        
BRANCH_8B2B: ; Branched to from 8B02, 8B11, 8B20. Failure exit
    SEC                                     ; Set carry flag
    RTN                                     ; SEC = Failure


BRANCH_8B2D: ; Branched to from 8B22        ; ODD parity
    REC                                     ; 

BRANCH_8B2E: ; Branched to from 8B22        ; NONE parity
    REC                                     ; Reset Carry Flag

BRANCH_8B2F: ; Branched to from 8B22
    SEC                                     ; EVEN parity
    LDA	    XL                              ; XL is LB or address branched to 8B2D, 8B2E, 8B2F
    ;SBI	    A,$2D                           ; A = A - 2D. ODD = 0, NONE = 1, EVEN = 2
    SBI	    A,LB(BRANCH_8B2D)               ; A = A - 2D. ODD = 0, NONE = 1, EVEN = 2 ***
    ANI	    (SETCOM_REG),$FC                ; Clear Bits 0,1. Parity


BRANCH_8B37: ; Branched to from 8AF2, 8B0F, 8B1D
    ORA	    (SETCOM_REG)                    ; A = A | (SETCOM_REG). ORs in any changes from Word lenght, Stop bits, Parity

BRANCH_8B3A: ; Branched to from 8AAB
    STA	    (SETCOM_REG)                    ; (SETCOM_REG) = A. Stores changes back to SETCOM



;------------------------------------------------------------------------------------------------------------
; HB_CFG_URT_BD - 
HB_CFG_URT_BD: ; 8B3D, brancnched from 8AA7 ; Sets Baud rate in CDP1854ACE UART chip (SET BAUD)
    ANI	    (STK_PTR_GSB_FOR),$00           ; Clear
    SJP	    HB_CFG_URT_LPT                  ; Sets D201 which is a UART config register
    LDA	    (SETCOM_REG)                    ; A = (SETCOM_REG)
    AEX                                     ; Swap hi and low nibbles of Accumulator. 3 2 1 0 7 6 5 4
    ANI	    A,$0E                           ; Keep x x x x 7 6 5 x of (SETCOM), i.e. BAUD

#IFDEF CE158V2
; ************ Modified >
    LDI	    XL,LB(TBL_WORDLEN)              ; 
    LDI	    XH,HB(TBL_WORDLEN)              ; X = 83D0, TBL_WORDLEN                         A = 0, 50 BAUD
    STA	    #(CE158_UART_SCR0)              ; Clear CE-158 (Scratch register)	
    ADR	    X                               ; X = X + A. Offset into TBL_WORDLEN            X = 83D0 + 0
    LDA	    (X)                             ; A = (X).                                              A = 99
    ORI	    #(CE158_UART_LCR0),$80          ; Set DLAB to point to Divisor Registers
    STA     #(CE158_UART_DLM0)              ; store first byte of divisor
    INC     X
    LDA	    (X)                             ; A = (X).                                      A = 99
    ;Hack to get around setting of the SETDEV Register checks for 2400BPS
 	CPI     A,$C0                           ; if 2400 then scr = 80 else = 0
 	BZR     SKIP_SET
    ORI	    #(CE158_UART_SCR0),$80          ; CE-158 (Scratch register)	

SKIP_SET: 
    STA     #(CE158_UART_DLL0)              ; store second byte of divisor
    ANI	    #(CE158_UART_LCR0),$7F          ; Reset DLAB

    REC                                     ; Reset carry flag = success
    RTN                                     ; Return
; <************
#ELSE
 #IFDEF CE158_48
    SHR                                     ; A = A >> 1. x x x x x 7 6 5 of SETCOM
    LDI	    XL,LB(TBL_WORDLEN)              ; 
    LDI	    XH,HB(TBL_WORDLEN)              ; X = 83D0, TBL_WORDLEN                         A = 0, 50 BUAD
    ADR	    X                               ; X = X + A. Offset into TBL_WORDLEN            X = 83D0 + 0
    LDA	    (X)                             ; A = (X).  2400 A=$51, 4800 A=$49              A = 99
    ORI	    #(CE158_PRT_A_DIR),$C0          ; Bits 6,7 output, Baud rate select, PC0-4 also (ME1)
    ANI	    #(CE158_PRT_A),~$C0             ; Clear bits 6,7 (ME1)
    SEC                                     ; Set carry flag                                    2400 A=$51->$A8
    ROR                                     ; A = A >> 1. Carry into bit 7, bit 0 into Carry    4800 A=$49->$A4
    BCR     BRANCH_8B67                     ; If carry not set, skip special 2400/4800 logic (-2)

    SJP     CE158_48_EXT                    ; (3)
    LDI     A,$A0                           ; (2) Set A back to what it should have been

    NOP \ NOP                               ;

BRANCH_8B67: ; branched to from 8B60
    STA     #(CE158_PRT_C)                  ; Set rest of Baud rate bits (ME1) (-4)
    NOP \ NOP \ NOP \ NOP \ NOP             ; Fill unused space
    REC                                     ; Reset carry flag = success
    RTN                                     ; Return
;------ End of #IFDEF CE158_48

 #ELSE ; Original build
    SHR                                     ; A = A >> 1. x x x x x 7 6 5 of SETCOM
    LDI	    XL,LB(TBL_WORDLEN)              ; 
    LDI	    XH,HB(TBL_WORDLEN)              ; X = 83D0, TBL_WORDLEN                         A = 0, 50 BUAD
    ADR	    X                               ; X = X + A. Offset into TBL_WORDLEN            X = 83D0 + 0
    LDA	    (X)                             ; A = (X).                                              A = 99
    ORI	    #(CE158_PRT_A_DIR),$C0          ; Bits 6,7 output, Baud rate select, PC0-4 also (ME1)
    SEC                                     ; Set carry flag
    ROR                                     ; A = A >> 1. Carry into bit 7, bit 0 into Carry        A = CC, C = 1
    BCS     BRANCH_8B62                     ; Branch fwd if Bit 0 was a 1

    ANI	    #(CE158_PRT_A),$7F              ; Clear bit 7 (ME1)
    BCH     BRANCH_8B67                     ; If all Bits 6-0 in clear, branch fwd

BRANCH_8B62: ; branched to from 8B59
    ORI	    #(CE158_PRT_A),$80              ; (ME1). Set Bit 7

BRANCH_8B67: ; branched to from 8B60
    STA     #(CE158_PRT_C)                  ; Set rest of Baud rate bits (ME1)
    ANI	    #(CE158_PRT_A),$BF              ; Clear Bit 6

    REC                                     ; Reset carry flag = success
    RTN                                     ; Return   
 #ENDIF ;---- End of Original build

#ENDIF



;.ORG $8B72
;------------------------------------------------------------------------------------------------------------
; HB_CFG_URT_LPT - Called from 8B41, 
; Configures UART
; Arguments: 
; Output:
; RegMod: U, A, X
HB_CFG_URT_LPT: ; 8B72
; ************ Modified >
#IFNDEF CE158V2
    LDI	    UL,LB(CE158_UART_REGW)          ;
    RIE                                     ; Disable interrupts
    LDI	    UH,HB(CE158_UART_REGW)          ; U = D201 = CE158_UART_REGW
#ELSE
    LDI	    UL,LB(CE158_UART_LCR0)          ;
    LDI	    UH,HB(CE158_UART_LCR0)          ;
    LDI	    XL,LB(TBL_1854_CFG)             ; X = 83E7. TBL_1854_CFG
    LDI	    XH,HB(TBL_1854_CFG)             ;
    RIE                                     ; Disable interrupts
; <************
#ENDIF

    LDA	    (SETDEV_REG)                    ; A = (SETDEV_REG), which devices redirected to RS232
                                            ; KI = 01, DO = 02, PO = 04, CI = 08, CO = 10
    SHL                                     ; A = A << 1. Shifted through Carry, 0 into MSB   C7  6 5 4 3 2 1 0 x
    ROL                                     ; A = A << 1. Carry into Bit 0, Bit 7 into Carry  C6  5 4 3 2 1 0 x 7
    BCS     BRANCH_8BBB                     ; If Bit 6 of (SETDEV_REG) was set branch fwd
    ROR                                     ; A = A >> 1. Carry into bit 7, bit 0 into Carry  C7  6 5 4 3 2 1 0 x
    LDA	    (SETCOM_REG)                    ; A = (SETCOM_REG)
    ANI	    A,$1F                           ; Clear Bits 7-5, Baud ***BAUD
#IFNDEF CE158V2
    LDI	    XH,HB(TBL_1854_CFG)             ;
#ENDIF
    BCR     BRANCH_8BAC                     ; If Bit 7 of (SETDEV_REG) was set branch fwd
    BII	    (STK_PTR_GSB_FOR),$0D           ;  RESET UART
    BZS     BRANCH_8B94                     ; If all Bits 3,2,0 clear branch fwd
    LDA	    (STK_PTR_GSB_FOR)               ; A = (STK_PTR_GSB_FOR) 
#IFDEF CE158V2    
    ADR	    X                               ; X = X + A. A = (SET_COM) & 1F, Baud bits cleared
    LDA	    (X)                             ; A = (X) = config for CDP1854ACE parity, Stop, Word Length
#ENDIF    
    BCH     BRANCH_8BA7                     ; Branch fwd unconditional

BRANCH_8B94: ; branched to from 8B8D
; ************ Modified >
#IFNDEF CE158V2
    ORI	    #(CE158_PRT_C),$80              ; Set LPT /INIT
    LDI	    XL,LB(TBL_1854_CFG)             ; X = 83E7. TBL_1854_CFG
    ANI	    #(CE158_PRT_C),$7F              ; Clear LPT /INIT, i.e. send initialize signal
    ADR	    X                               ; X = X + A. A = (SET_COM) & 1F, Baud bits cleared
    LDA	    (X)                             ; A = (X) = config for CDP1854ACE parity, Stop, Word Length
    STA	    #(U)                            ; (U) = A. U = CE158_UART_REGW
    LDI	    A,$50                           ; Some sort of code to latch settings in?  CHANGED FROM $50 to $40    
#ELSE
    ADR	    X                               ; X = X + A. A = (SET_COM) & 1F, Baud bits cleared
    LDA	    (X)                             ; A = (X) = config for CDP1854ACE parity, Stop, Word Length
    STA	    #(U)                            ; (U) = A. U = CE158_UART_REGW
; <************    
#ENDIF

BRANCH_8BA7: ; branched to from 8B92, 8BCC, 8BB5, 8BB9
    STA	    #(U)                            ; (U) = A. U = CE158_UART_LCR0
    SIE                                     ; Enable interrupts
    RTN                                     ; Return


BRANCH_8BAC: ; Branched to from 8B87        ; Must calculate index into  TBL_1854_CFG at 83E7
#IFNDEF CE158V2
; ************ Modified >
    LDI	    XL,$07                          ; XH = 83, X = 8307, A = (SETCOM_REG) & 1F
    ADR	    X                               ; X = X + A. Default SETCOM IS $99. $99<<1=$0132+$8307=$8439
    LDA	    (X)                             ; A = (X)
    BII	    (STK_PTR_GSB_FOR),$08           ; Test Bit3
    BZR     BRANCH_8BA7                     ; If Bit3 in (STK_PTR_GSB_FOR) was set
    ORI	    A,$60                           ; A = A | 60
    BCH     BRANCH_8BA7                     ; Unconditional back branch

BRANCH_8BBB: ; Branched to from 8B7D
    LDA	    (SETCOM_REG)                    ; A = (SETCOM_REG)
    ANI	    A,$1F                           ; A = A & 1F. Mask off bits 7-5, Baud

    BII	    (STK_PTR_GSB_FOR),$D            ; FLAGS = (STK_PTR_GSB_FOR) & 0D
    BZS     BRANCH_8BC8                     ; If all bits 0,2,3 are clear branch fwd
    ORI	    A,$40                           ; A = A | 40. Set bit 3

BRANCH_8BC8: ; Branched to from 8BC4
    STA     #(U)                            ; U=CE158_UART_LCR0. (U) = A. A=Manipulated SETDEV_REG
    ORI	    A,$80                           ; Set bit 7

#ELSE ; #IFDEF CE158V2
    ADR	    X                               ; X = X + A. Default SETCOM IS $99. $99<<1=$0132+$8307=$8439
    LDA	    (X)                             ; A = (X)
    BII	    (STK_PTR_GSB_FOR),$08           ; Test Bit3
    BZR     BRANCH_8BA7                     ; If Bit3 in (STK_PTR_GSB_FOR) was set
;   ORI	    A,$40                           ; A = A | 60 CHANGED FROM $60 to $40
;	LDI     A,$03                           ; Set Default 8,N,1
    BCH     BRANCH_8BA7                     ; Unconditional back branch

BRANCH_8BBB: ; Branched to from 8B7D
    LDA	    (SETCOM_REG)                    ; A = (SETCOM_REG)
    ANI	    A,$1F                           ; A = A & 1F. Mask off bits 7-5, Baud
    ADR     X                               ; Index into table to get TI settings
    LDA     (X)                             ; A Now has TI settings

    BII	    (STK_PTR_GSB_FOR),$D            ; FLAGS = (STK_PTR_GSB_FOR) & 0D
    BZS     BRANCH_8BC8                     ; If all bits 0,2,3 are clear branch fwd
    ORI	    A,$40                           ; A = A | 40. Set bit 3

BRANCH_8BC8: ; Branched to from 8BC4
    STA     #(U)                            ; U=CE158_UART_LCR0. (U) = A. A=Manipulated SETDEV_REG
    ANI	    A,$BF                           ; Clear break bit
; <************    
#ENDIF

    BCH     BRANCH_8BA7                     ; Branch back unconditional



.FILL ($8BCE - $),$FF
.ORG $8BCE
;------------------------------------------------------------------------------------------------------------
; SUB_8BCE - called from SUB_8FC1:8EEF
; Arguments: 
; Output:
; RegMod: 
SUB_8BCE:
    LDA	    (ERR_TOP_H)                     ; Used for unknown flags
    SJP	    TERMTXT_2INBUF                  ; Copies text string from TEXT_84EF to Input Buffer (7BB0)
                                            ; A = String index. Terminal program menu text?
    SJP	    SUB_86F0                        ; Calculates a new address to set P to (Program Counter), and goes there.

; Used by SUB_86F0                          ; SUB_86F0 pops the return address from SJP above
DATA_8BD7:                                  ; off stack to know where this data table starts.
    .BYTE   $12,$1C,$1E,$1B,$18,$1A,$1B,$67,  $6B,$90,$7D,$9A,$2D,$3C,$3B,$3A
    .BYTE   $39,$38,$2D 


; this part looks reasonable but is not called 
UNKNOWN_8BEA:
    LDI	    XH,HBO(TEXT_84EF,$71)           ;
    LDI	    XL,LBO(TEXT_84EF,$71)           ; X = 8560 is in TEXT_84EF
    LDI	    UL,$06                          ;

BRANCH_8BF0:
    TIN                                     ; (Y) = (X) then X = X + 1, Y = Y + 1
    LOP	    UL,BRANCH_8BF0                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set
    RTN                                     ; Return
; Seems like nonsense
;------



;------------------------------------------------------------------------------------------------------------
; SUB_8BF4 - Called 8709 vector jump
; May be part of terminal program
; Arguments: X=8BF4~8BF9
; Output:
; RegMod: A, UL
SUB_8BF4:
    REC                                     ; Jumped to from 8709 vector calculation
    REC                                     ; Jumped to from 8709 vector calculation
    REC                                     ; Jumped to from 8709 vector calculation
    REC                                     ; Jumped to from 8709 vector calculation
    REC                                     ; Jumped to from 8709 vector calculation
    SEC                                     ; Jumped to from 8709 vector calculation

    LDA	    XL                              ; A = XL. XL - F4-F9. LB of address called
    SBI	    A,$F4                           ; A = A - F4. A = 0~5
    STA	    UL                              ; UL = A, Loop coutner.
    LDA	    (ERR_LINE_H)                    ; Unknown flags
    AEX                                     ; Swap A high/low nibbles.               3 2 1 0 7 6 5 4

BRANCH_8C02: ; Branched to from 8C03
    SHL                                     ; A = A << 1. Thru carry, 0 into LSB. C3 2 1 0 7 6 5 4 x
    LOP	    UL,BRANCH_8C02                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set
    LDI	    A,$4F                           ;
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1. What is Y? ***
    LDI	    A,$4E                           ;
    BCS     BRANCH_8C0F                     ; Carry set in 8C02 shift?
    LDI	    A,$46                           ;
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1

BRANCH_8C0F: ; Branched to from 8C0A
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; SUB_8C17 - Called from?
; No idea what this does
; Arguments: Y
; Output:
; RegMod: A, Y, X
SUB_8C17_ALT_E1: ; Jumped to from 8709 vector calculation
    LDI	    A,$08                           ;

BRANCH_8C13: ; Branched to from 8C1F
    STA	    (CURVARADD_L)                   ;

BRANCH_8C16: ; Branched to from 8C36
    RTN                                     ; 



;--------------------------------------------------------------------------------------------------
;
; Arguments: Y
; Output:
; RegMod:
JMP_8C17: ; Jumped to from 8709 vector calculation
    LDI	    A,$46                           ;
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1. What is Y? ***
    LDI	    A,$36                           ;
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1
    LDI	    A,$07                           ;
    BCH     BRANCH_8C13                     ;    Unconditional branch back



;--------------------------------------------------------------------------------------------------
; JMP_8C21: 
; Used by Terminal program. Maybe to set RESERVE memory area
; Arguments: Y
; Output:
; RegMod:
JMP_8C21: ; Jumped to from 8709 vector calculation
    LDI	    A,$46                           ; 
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1
    LDA	    (ERR_TOP_H)                     ; Unknown flags
    SHR                                     ; A = A >> 1. Shifted through Carry, 0 into MSB
    SEC                                     ; Set Carry
    SBI	    A,$10                           ; A = A - 10
    STA	    (CURVARADD_L)                   ;
    ORI	    A,$30                           ;
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1
    LDI	    A,$3D                           ;
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1
    VMJ	    ($38)                           ; Determines reserve memory type adress + 8 and stores it in X-Reg. 
                                            ; Sets C=0 if 2nd reserve memory area is occupied 
    SJP	    RESKEY_SRCH                     ; Searches for reserve key code in reserve memory
    BCR     BRANCH_8C16                     ; If carry not set branch back


BRANCH_8C3B: ; Branched to from 8C43
    LIN	    X                               ; A = (X) then INC X
    BII	    A,$E0                           ; 
    BZS     BRANCH_8C16                     ; If all Bits 5,6,7 clear branch back (exit)
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1
    CPI	    YL,$FD                          ;
    BCR     BRANCH_8C3B                     ; If YL < FD branch back
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; SUB_8C46 - Called from vector calculation jump at 8709
; Arguments:
; Output:
; RegMod: U
SUB_8C46: ; Jumped to from 8709 vector calculation
    VEJ	    (F4)                            ; Loads U-Reg with 16-bit value from address of (PREV_LINE_H)
                AWRD(PREV_LINE_H)           ;
    BCH     BRANCH_8C5B                     ; Uncondional branch fwd, borrow return



;------------------------------------------------------------------------------------------------------------
; SETCOM2ASCII - Called from DEV$
; Converts Baud Rate setting in SETCOM to ASCII?
; Arguments:
; Output:
; RegMod: A, X, U
SETCOM2ASCII: ; Jumped to from 8709 vector calculation
    LDA	    (SETCOM_REG)                    ;
    ANI	    A,$E0                           ; Keep Bits 7-5, baud rate
                                            ; 000 00000 = 50,  010 00000 =  110, 011 00000 =  200, 100 00000 = 300, 
                                            ; 101 00000 = 600, 110 00000 = 1200, 111 00000 = 2400
    AEX                                     ; Swap high/low nibbles of A. SETCOM_REG Bits 7-5 now 3-1
    LDI	    XL,LB(TBL_BAUD)                 ;
    LDI	    XH,HB(TBL_BAUD)                 ; X = 83C0. Pointer into TBL_BAUD
    ADR	    X                               ; X = 83C0 + A.      50Baud, X = 83C0           300Baud X = 83C0 + 08 = 83C8
    LIN	    X                               ; A = (X), INC X.            A =   00                   A =   01   
    STA	    UH                              ;                           UH =   00                  UH =   01
    LDA	    (X)                             ;                            A =   32                   A =   2C
    STA	    UL                              ;                           UL = 32, U = 0032          UL =   2C, U = 012C

BRANCH_8C5B: ; Branched to from 8C49
    VMJ	    ($10)                           ; Convert U-Reg, Save to (Y-Reg) in ASCII
                ABYT($40)                   ;
    RTN                                     ; Two BCD digits



;------------------------------------------------------------------------------------------------------------
; PARITY2ASCII - Called from DEV$
; Updates (Y) with ASCII charecter for Parity
; Arguments: Y = 7A1B, MATH_REG_Ua_B4
; Output: (Y) = ASCII cahrecter for Parity
; RegMod: UL, A
PARITY2ASCII: ; Jumped to from 8709 vector calculation
    LDA	    (SETCOM_REG)                    ;
    LDI	    UL,$4E                          ; UL = 4E if (SETCOM_REG) Bit 0 not set
    SHR                                     ; A = A >> 1. Shift out Bit 0
    BCS     BRANCH_8C6E                     ; If Bit 0 set skip ahead,        No Parity, UL = 4E = 'N'
    LDI	    UL,$45                          ; 
    SHR                                     ; A = A >> 1. Shift out Bit 1
    BCS     BRANCH_8C6E                     ; If Bit 1 set skip ahead,      Even Parity, UL = 45 = 'E'
    LDI	    UL,$4F                          ; else,                          Odd Parity, UL = 4F = 'O'

BRANCH_8C6E: ; Branched to from 8C65, 8C6A
    LDA	    UL                              ; A = UL = ASCII charecter for Parity
    SIN     Y                               ; (Y) = A then INC Y.
    RTN                                     ; 



;------------------------------------------------------------------------------------------------------------
; WORDLEN2ASCII - Called from DEV$
; Updates (Y) with ASCII value for Word Length
; Arguments: Y = 7A19, MATH_REG_Ua_B2
; Output: (Y) = ASCII cahrecter for Word Length
; RegMod: A, Y, UL
WORDLEN2ASCII: ; Jumped to from 8709 vector calculation
    LDA	    (SETCOM_REG)                    ; Keep SETCOM Bits 4,3: 
    ANI	    A,$18                           ; 5 = 0000 0000, 6 = 0000 1000, 7 = 0001 0000, 8 = 0001 1000
    AEX                                     ; Swap high/low nibbles of A
                                            ; 5 = 0000 0000, 6 = 1000 0000, 7 = 0000 0001, 8 = 1000 0001
    SHL                                     ; A = A << 1. Bit 7 into carry, Bit 0 into Bit 1
                                            ; 5 = 0000 0000, 6 = 1 0000 0000, 7 = 0000 0010, 8 = 1 0000 0010
    LDI	    UL,$35                          ; 
    ADC	    UL                              ; A = A + UL.
                                            ; 5 A = 35, 6 A = 36, 7 A = 37, 8 A = 38
    SIN     Y                               ; (Y) = A. Then Y = Y + 1. What is Y ***
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; STOPBIT2ASCII - Called from DEV$
; Updates (Y) with ASCII charecter for #Stop Bits
; Arguments: Y = 7A1D, MATH_REG_Ua_B6
; Output: (Y) = ASCII cahrecter for #Stop Bits
; RegMod: A, Y
STOPBIT2ASCII: ; Jumped to from 8709 vector calculation
    LDI	    A,$31                           ; A = 31 = '1'
    BII	    (SETCOM_REG),$04                ; Keep Bit 2, Stop Bits
    BZS     BRANCH_8C86                     ; If Bit2 not set skip ahead, A = 21
    INC	    A                               ; else, A = 32 = '2'

BRANCH_8C86: ; Branched to from 8C83
    SIN     Y                               ; (Y) = A then INC Y
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; TERMINAL - Called by command vector table by 831C
; Arguments:
; Output: 
; RegMod:
TERMINAL:
    ANI	    (CRLF_REG),$7F                  ; Clear Bit 7. What is this register used for?
    BCH     BRANCH_8C97                     ; Unconditional fwd branch



;------------------------------------------------------------------------------------------------------------
; DTE - Called by command vector table by 831C
; Arguments:
; Output: 
; RegMod:
DTE:
    ORI	    (CRLF_REG),$80                  ; Set Bit 7. Unknown flags
    LDI	    A,$92                           ;
    SJP     BRANCH_8B3A                     ; STA to (SETCOM) sets Buad rate in UART. Default?

BRANCH_8C97: ; Branched to from TERMINAL
    VEJ     (C8)                            ; If following character not end to command sequence/line branch fwd BRANCH_8CFC 
                ABRF(BRANCH_8CFC)           ;
    VEJ     (F4)                            ; Loads U-Reg with START OF VARIABLES in main memory (H)(L)
                AWRD(VAR_START_H)           ;
    VEJ     (CC)                            ; Loads X-Reg with address at 78(67) 78(68) End of BASIC RAM (H)
                ABYT($67)                   ;
    SJP     (U_MINUS_X - 1)                 ; DEC U then U = U - X. When upper limit occurs: C=0 and UH=16
    BCR     BRANCH_8CF9                     ; If error skip to end

    LDI	    XL,$3A                          ;
    LDI	    XH,$00                          ; X = 003A
    SJP     (U_MINUS_X)                     ; U = U - X, When upper limit occurs: C=0 and UH=16 
    BCR     BRANCH_8CF9                     ; If error skip to end

    CPI	    UH,$02                          ;
    BCR     BRANCH_8CF9                     ; If UH < 02 skip to end
    VEJ     (F6)                            ; Transfers U to (ARX + 5), (ARX + 5)+1
                AWRD(ARX + $05)             ;
    SJP     SUB_87A3                        ; Part of terminal program
    VCS     ($E0)                           ; If Carry Set Call VEJ(E0)->Indicates if UH is not "00" error message

    ANI	    #(PC1500_MSK_REG),$00           ; PC-1500 - Reset MSK Register, clear
    SJP     RXCOM                           ; Manipulates LPT/UART registers
    LDI	    A,$04                           ;
    STA	    (USINGF)                        ; Using format, presence of decimal point, comma,etc
    VEJ     (CC)                            ; Loads X-Reg with address at 78(5D) 78(5E), KEYBOARD derivation flag
                ABYT($5D)                   ;
    VEJ     (CA)                            ; Transfers X to 78(BE), 78(BF) DATA POINTER (H)/(L)
                ABYT($BE)                   ;
    LDI	    UL,$40                          ;
    LDI	    UH,$11                          ; U = 1140
    VEJ     (F6)                            ; Transfers U to (DISP_BUFF+$4E), (DISP_BUFF+$4E) + 1
                AWRD(DISP_BUFF+$4E)         ;
    VEJ     (CC)                            ; Loads X-Reg with address at 78(99) 78(9A), STRING VAR I$ Byte 9,10?
                ABYT($99)                   ;
    LDI	    A,$C6                           ;
    ADR	    X                               ; X = X + A, X = 003A + C6 = 100?
    DEC	    XH                              ; X = FF?
    VEJ     (CA)                            ; Transfers X to 78(93), 78(94), BASIC PENDING OP STACK pointer (L)(H)
                ABYT($93)                   ;
    SJP     SUB_8FC1                        ; Copies 20 bytes to or from String Var P$
    LDA	    (ZONE_REG)                      ;
    ANI	    A,$60                           ; Keep Bits 6-5
    SHR                                     ; A = A >> 1. Shifted through Carry, 0 into MSB
    ORI	    A,$0A                           ; Set Bits 3, 1
    BII	    (CRLF_REG),$80                  ; 
    BZS     BRANCH_8CED                     ; If Bit 7 was not set
    ADI	    A,$03                           ; A = A + 03

BRANCH_8CED: ; Branched to from 8CE9
    STA	    (ERR_LINE_H)                    ; ERROR LINE (Line number where error is met) (H)
    LDI	    UH,HB(SUB_99D6_ALT_E1)          ;
    LDI	    UL,LB(SUB_99D6_ALT_E1)          ; U = 99AA = SUB_99D6_ALT_E1
    VEJ     (F6)                            ; Transfers U to (CE158_REG_79FB), (CE158_REG_79FB)+1
                AWRD(CE158_REG_79FB)        ;
    BCH     BRANCH_8D09                     ; Unconditional fwd branch

BRANCH_8CF9: ; Branched to from 8CA1, 8CAA, 8CF9
    LDI	    UH,$33                          ;
    VEJ     (E0)                            ; Indicates if UH is not "00" error message

BRANCH_8CFC: ; Branched to from 8C97
    VEJ     (E4)                            ; Output error 1 and return to the editor



;------------------------------------------------------------------------------------------------------------
; JMP_8D04 - Called from SUB_PRINT_NUM:90F5
; Alt entry at 8D08 Called from 8FC1:8EE1, Jumped to from JUMP_TBL_915F
; Resets CE-150, LCD annuncuiators, jumps to new code
; Arguments:
; Output: 
; RegMod: A, U, X
;
; JMP_8CFD - Jumped to from SUB_PRINT_NUM_ALT_X1:910A, JMP_94F4:9581, SUB_99D6_ALT_E1:9A51
; Looks like it is setting up A before SUB_8D04 which
JMP_8CFD: ;Branched to from 8D02
    LDI	    A,$04                           ;
    BCH     SUB_8D04_ALT_E1                 ; Unconditional fwd branch

; How is this reached? 8D01
    LDA	    UH                              ; ***
    BZR     JMP_8CFD                        ; If UH != 0  branch back


SUB_8D04:
    ANI	    #(PC1500_IF_REG),$FD            ; PC-1500 - Clear Bit1, PB7 Interrupt (Power button)

BRANCH_8D09: ; Branched to from 8CF7
    LDI	    A,$00                           ;

SUB_8D04_ALT_E1: ; Called from 8FC1:8EE1
    ANI	    #(PC1500_MSK_REG),$FC           ; PC-1500 - Clear mask for IRQ and PB7 (ON button)
    SJP	    SET_DTR_RTS                        ; Sets DTR/RTS based on OUTSTAT_REG
    PSH	    A                               ;
    LDI	    A,$9A                           ;
    STA	    (CE158_REG_79FA)                ;
    SEC                                     ; Set carry flag
    SJP	    SUB_8FC2                        ; Copies 20 bytes to or from String Var P$
    ANI	    #(CE150_PRT_B),$BF              ; Clear Bit 6, Low Battery
    ORI	    #(CE150_PRT_B_DIR),$40          ; Set Bit 6 to Write
    SJP	    SUB_9FEF                        ; CE-150 - Clears Pen Descending signal, and applies it again if safe.
    
#IFNDEF CE158V2
; ************ Modified >
    ANI	    #(CE158_MSK_REG),$FD            ; Clear Bit 1, interrupt mask for PB7, Paper feed button
#ELSE
	NOP                                     ; PAD MISSING INSTRUCTION 
	NOP
	NOP
	NOP 
	NOP
; <************
#ENDIF

    ORI	    #(PC1500_MSK_REG),$01           ; PC-1500 Set Bit0 IRQ mask
    LDI	    UL,LBO(DISP_BUFF,$4E)           ;
    LDI	    UH,HBO(DISP_BUFF,$4E)           ; U = 764E, LCD annunciators
    ORI	    (U),$01                         ; Set Bit 0, (BUSY)
    ANI	    (U),$7D                         ; Clear Bit 1 (SHIFT), 7 (??)
    INC	    U                               ; U = 764F, LCD annunciators
    ANI	    (U),$70                         ; Keep Bits 6 (RUN), 5 (PRO), 4 (RESERVE)
    SJP	    INBUF_CLR                       ; Writes over input buffer with 0D
    POP	    A                               ;
    SJP	    TERMTXT_DISP                    ; Copies text string from TEXT_84EF to Display
    LDI	    UL,$3F                          ;
    LDI	    UH,$00                          ; U = 003F
    SJP	    TIMEDELAY                       ; Time delay 15,625 ms * Number from U-Reg.BREAK is possible

BRANCH_8D4F: ; Branched to from 8DC8, 8F86
    SDP                                     ; Sets LCD ON/OFF control flip-flop
    SJP	    INBUF_CLR                       ; Writes over input buffer with 0D
    LDA	    (USINGF)                        ; Using format, presence of decimal point, comma,etc
    LDI	    UL,$17                          ;
    SHR                                     ; A = A >> 1. Shifted through Carry, 0 into MSB
    BCS     BRANCH_8D6B                     ; If (USINGF) Bit 0 was set, branch fwd UL = 17
    LDI	    UL,$01                          ;
    SHR                                     ; A = A >> 1. Shifted through Carry, 0 into MSB
    BCS     BRANCH_8D6B                     ; If (USINGF) Bit 1 was set, branch fwd UL = 01
    LDI	    UL,$18                          ;
    SHR                                     ; A = A >> 1. Shifted through Carry, 0 into MSB
    BCS     BRANCH_8D6B                     ; If (USINGF) Bit 2 was set, branch fwd UL = 18
    INC	    UL                              ; UL = 19
    SHR                                     ; A = A >> 1. Shifted through Carry, 0 into MSB
    BCS     BRANCH_8D6B                     ; If (USINGF) Bit 3 was set, branch fwd UL = 19
    INC	    UL                              ; UL = 20

BRANCH_8D6B: ; Branched to from 8D5A, 8D5F, 8D64, 8D68
    LDA	    UL                              ; UL = 17, 01, 18, 19, 20 from above
    SHL                                     ; A = A << 1. A = 2E, 02, 30, 32, 40
    SJP	    TERMTXT_DISP                    ; Displays text string from TEXT_84EF index by A

BRANCH_8D70: ; Branched to from 8DAD, BRANCH_TBL_8DD9
    SJP	    SUB_998D                        ; Something with LCD annunciators and last key pressed reg
    LDI	    S,(CPU_STACK + $4F)             ; (Stack Pointer) S = (CPU_STACK + $4F)
    CPI	    A,$14                           ; Is A from table index above?
    BCR     BRANCH_8D9C                     ; If A < 14 branch fwd
    CPI	    A,$17                           ;   else A >= 14
    BCS     BRANCH_8D9C                     ; If A >= 17 branch fwd
    SBI	    A,$16                           ; A=14~16. A = A - 16. 14->(1c FE), 15->(1c FF), 16->(0c 00)
    STA	    UL                              ;
    LDA	    (USINGF)                        ; $7895 Bit 7: Scientific, Bit 6: asterisk fill, Bit 5: Forced sign, 
                                            ; Bit 4: Comma,  Bits 3,2,1: used in this ROM for??, Bit 0: used in checking syntax
    ANI	    A,$1F                           ; Clear Bits 7-5.

BRANCH_8D86: ; Branched to from 8D8C        ; 7895 =                01      02      04      08      10
    INC	    UL                              ; UL in = 14, UL out    01      04      07      0A      0D
    INC	    UL                              ; UL in = 15, UL out    02      05      08      0B      0E
    INC	    UL                              ; UL in = 16, UL out    03      06      09      0C      0F <- overshoots table
    SHR                                     ; 
    BCS     BRANCH_8D8E                     ; 
                                            ; 
    BZR     BRANCH_8D86                     ; 

BRANCH_8D8E: ; Branchded to from 8D8A
    LDA	    UL                              ; A = UL = table above
    LDI	    UL,LB(BRANCH_TBL_8DD9)          ; 
    LDI	    UH,HB(BRANCH_TBL_8DD9)          ; U = 8DD9, BRANCH_TBL_8DD9
    SHL                                     ; A = A << 1. A = A * 2
    ADR	    U                               ; U = U + A. 
    LIN	    U                               ; A = (U) then INC U. 
    STA	    XH                              ; 
    LDA	    (U)                             ; A = (U)
    STA	    XL                              ; X = 8E97, 8E9B, 8EA8
    STX	    P                               ; P = X. Set Program Counter to X ***JMP


BRANCH_8D9C: ; Branced to from 8D78, 8D7C
    VMJ	    ($34)                           ; 06 + 1 = # of two byte arguments following (vectors)
              ABYT($06)                     ;
              ABYT($09) \ ABRF(BRANCH_8E8C) ; 09->Horz Tab (HT), EB->Branch Fwd to 8E8C
              ABYT($0A) \ ABRF(BRANCH_8DBB) ; 0A->Line Feed (LF), 18->Branch Fwd to 8DBB,
              ABYT($0B) \ ABRF(BRANCH_8DCA) ; 0B->Vert Tab (VT), 25->Branch Fwd to 8DCA,
              ABYT($0E) \ ABRF(BRANCH_8DB9) ; 0E->Shft-Out (SO), 0E->Branch Fwd to 8DB9,
              ABYT($13) \ ABRF(BRANCH_8DAF) ; 13->Dev Cont 3 (DC3), 06->Branch Fwd to 8DAF,
              ABYT($19) \ ABRF(BRANCH_8E91) ; 19->End of Medium (EM), E6->Branch Fwd to 8E91,
              ABYT($5B) \ ABRF(BRANCH_8DD5) ; 5B->'[', 28->Branch Fwd to 8DD5

    BCH     BRANCH_8D70                     ; Unconditional branch back

; rest of this dedicated to modifying (USINGF) - Using format, presence of decimal point, comma,etc
BRANCH_8DAF: ; Branched to from 8D9C VMJ
    LDI	    A,$14                           ;
    BII	    (USINGF),$10                    ; Using format, presence of decimal point, comma,etc
    BZS     BRANCH_8D70                     ; If Bit 4 was not set branch back
    BCH     BRANCH_8E23                     ; Unconditional fwd branch

BRANCH_8DB9: ; Branched to from 8D9C VMJ
    BCH     SUB_8D04                        ; Unconditional back branch

BRANCH_8DBB: ; Branched to from 8D9C VMJ
    LDA	    (USINGF)                        ; Using format, presence of decimal point, comma,etc
    ANI	    A,$0F                           ; Keep Bits 3-0
    SHR                                     ; A = A >> 1. Shift through carry. 0 into MSB
    BZR     BRANCH_8DC5                     ; If Bit 0 was not set branch fwd
    LDI	    A,$08                           ;

BRANCH_8DC5: ; Branched to from 8DC1, 8DD0, 8DD3, 8DD7
    STA	    (USINGF)                        ; Change (USINGF) with A from above
    BCH     BRANCH_8D4F                     ; Unconditional back branch

BRANCH_8DCA: ; Branched to from 8D9C VMJ
    LDA	    (USINGF)                        ; Using format, presence of decimal point, comma,etc
    SHL                                     ; A = A << 1. 7 6 5 4 3 2 1 0  to  6 5 4 3 2 1 0 x
    ANI	    A,$0F                           ; Keep Bits 3-0   x x x x 2 1 0 x
    BZR     BRANCH_8DC5                     ; If any Bit 3-0 was set branch back
    INC	    A                               ; A = A + 1
    BCH     BRANCH_8DC5                     ; Unconditional back branch

BRANCH_8DD5: ; Branched to from 8D9C VMJ
    LDI	    A,$10                           ;
    BCH     BRANCH_8DC5                     ; Unconditional back branch



;------------------------------------------------------------------------------------------------------------
; Branch table used by BRANCH_8D8E - used by 8D9A
BRANCH_TBL_8DD9:
    .WORD   BRANCH_8E97                     ; BRANCH_8E97
    .WORD   BRANCH_8E9B                     ; BRANCH_8E9B
    .WORD   BRANCH_8EA8                     ; BRANCH_8EA8
    .WORD   BRANCH_8E1A                     ; BRANCH_8E1A
    .WORD   BRANCH_8E1C                     ; BRANCH_8E1C
    .WORD   BRANCH_8E1E                     ; BRANCH_8E1E
    .WORD   BRANCH_8E31                     ; BRANCH_8E31
    .WORD   BRANCH_8E32                     ; BRANCH_8E32
    .WORD   BRANCH_8DF7                     ; BRANCH_8DF7
    .WORD   BRANCH_8E1D                     ; BRANCH_8E1D
    .WORD   BRANCH_8E17                     ; BRANCH_8E17
    .WORD   BRANCH_8D70                     ; BRANCH_8D70
    .WORD   BRANCH_8E1B                     ; BRANCH_8E1B
    .WORD   BRANCH_8E18                     ; BRANCH_8E18
    .WORD   BRANCH_8E19                     ; BRANCH_8E19



;------------------------------------------------------------------------------------------------------------
; BRANCH_8DF7: ; Branched to from BRANCH_TBL_8DD9
; Resets some things and then does warm boot
; Arguments: 
; Output: 
; RegMod: U, X
BRANCH_8DF7:
    LDI	    UL,$43                          ;
    LDI	    UH,$40                          ; U = 4043
    VEJ	    (F6)                            ; Saves U-Reg to (DISP_BUFF+$4E)
                AWRD(DISP_BUFF+$4E)         ;
    VEJ	    (CC)                            ; Loads X-Reg with address at 78(BE) 78(BF). DATA POINTER
                ABYT($BE)                   ;
    VEJ	    (CA)                            ; Transfers X to 78(5D), 78(5E). KEYBOARD derivation
                ABYT($5D)                   ;    
    SJP	    PORTS_UPDATE                    ; KATAFLAGS = KEYBOARD derivation flag Bit7=1 SPV, Bit7=0 RPV
    ANI	    #(CE150_PRT_B_DIR),$BF          ; CE-150 - Bit 6 input, rest output
    ORI	    #(PC1500_MSK_REG),$01           ; PC-1500 - Set interrupt mask bit for IRQ
    ORI	    #(CE150_MSK_REG),$03            ; CE-150 - Set interrupt mask bit for IRQ, PB7 (Busy input)
    JMP	    BTN_SHCL                        ; SHIFT CL (Clear All)



JMP_8E17:
BRANCH_8E17: ; Branched to from BRANCH_TBL_8DD9
    REC                                     ; Reset Carry flag

BRANCH_8E18: ; Branched to from BRANCH_TBL_8DD9
    REC                                     ; Reset Carry flag

BRANCH_8E19: ; Branched to from BRANCH_TBL_8DD9
    REC                                     ; Reset Carry flag

BRANCH_8E1A: ; Branched to from BRANCH_TBL_8DD9
    REC                                     ; Reset Carry flag

BRANCH_8E1B: ; Branched to from BRANCH_TBL_8DD9
    REC                                     ; Reset Carry flag

BRANCH_8E1C: ; Branched to from BRANCH_TBL_8DD9
    REC                                     ; Reset Carry flag

BRANCH_8E1D: ; Branched to from BRANCH_TBL_8DD9
    REC                                     ; Reset Carry flag

BRANCH_8E1E: ; Branched to from BRANCH_TBL_8DD9
    LDI	    A,$12                           ; X = Program Counter of branch address here up
    ADR	    X                               ; X = X + A, i.e. X = 8E1E + 12 = 8E30 if jumped to directly
    LDA	    (X)                             ; Indexing into TBL_8E29 below

BRANCH_8E23: ; Branched to from 8DB7
    STA	    (ERR_TOP_H)                     ;
    JMP	    JMP_8EEF                        ; May jump to new code or parse then jump to new code


TBL_8E29: ; Used by code directly above
    .BYTE    $0A,$10,$12,$20,$0C, $22, $0E, $16 ; byte from table poked into (ERR_TOP_H)


BRANCH_8E31: ; Branched to from BRANCH_TBL_8DD9
    REC                                     ; Reset Carry flag

BRANCH_8E32: ; Branched to from BRANCH_TBL_8DD9
    PSH	    X                               ; X = Program Counter i.e. 8E31, 8E32
    SJP	    PORTS_UPDATE                    ;
    SJP	    SUB_8FC1                        ; Copies 20 bytes to or from String Var P$
    LDI	    A,$02                           ;
    STA	    (PRNT_CSIZE)                    ; CSIZE (Printing character size select)
    LDI	    A,$00                           ;
    STA	    (LINE_TYPE)                     ; Printer LINE TYPE
    STA	    (PRNT_ROTATE)                   ; ROTATE (Printing direction select)
    SJP	    SUB_9C92                        ; Something to do with CE-150
    LDI	    XH,$D8                          ;
    LDI	    XL,$B0                          ; X = D8B0, inside a program line in main ROM
    VEJ	    (CA)                            ; Transfers X to 78(B2), 78(B3). ERROR ADDRESS
                ABYT($B2)                   ;
    LDI	    UL,$02                          ; 
    JMP	    JMP_8380                        ; Jumps to 8380, then jumps back immediatly below
                                            ; If Jap. market & SETCOM cfgd as 7 Data Bits A = 0A, else A = UL

JMP_8E55: ; Jumped to from 83A1, Jumped here from 8E52 through JMP_8380
    VEJ	    (CC)                            ; Loads X-Reg with address at 78(A0) 78(A1). PREVIOUS ADDRESS
                ABYT($A0)                   ;
    VEJ	    (CA)                            ; Transfers X to 78(5D), 78(5E). KEYBOARD derivation
                ABYT($A6)                   ;
    ORI	    (SRCH_LINE_H),$80               ; SEARCH LINE (H)
    VEJ     (F4)                            ; Loads U-Reg with 16-bit value from address of (PREV_LINE_H)
                AWRD(PREV_LINE_H)           ;
    DEC	    U                               ;
    SJP	    (DELU_FROMX + $01)              ; Deletes U-bytes from where X points
    SJP	    SUB_98E8                        ; Updates LCD?
    POP	    X                               ; X = Program Counter i.e. 8E31, 8E32 entry address
    CPI	    XL,$32                          ; Did we enter at 8E32
    BZR     BRANCH_8EC3                     ; If not branch fwd
    LDI	    A,$08                           ;
    STA	    (CURVARADD_L)                   ;

    VMJ	    ($38)                           ; Determines reserve memory start address+8 and sets it in X. 
                                            ;  Sets C=0 if 2nd reserve memory area is occupied
    SJP	    RESKEY_SRCH                     ; Searches for reserve key code in reserve memory
    BCR     BRANCH_8EC3                     ;  Sub returns carry set if success 
    PSH	    X                               ; XL was altered by sub
    SJP	    IRQ_RESET_ALT_E1                ; #(CE158_PRT_A) Clear Bits 1-0 (ME1), Bit 0 = DTR, Bit 1 = RTS
    LDI	    UL,$40                          ;
    LDI	    UH,$00                          ; U = 0040
    SJP	    TIMEDELAY                       ; Time delay 15,625 ms * Number from U-Reg.BREAK is possible
    POP	    X                               ; Maybe X was altered by TIMEDELAY?
    SJP	    STRNG_2COM_ALT_E1               ; Sends string to RS232. X is set with source table address?
    BCH     BRANCH_8EC3                     ;  


BRANCH_8E8C: ; Branched to from 89DC
    SJP	    SUB_9600                        ; Something to do with LCD, than jumps to main ROM. How do we get back here?
    BCH     BRANCH_8E94                     ;


BRANCH_8E91: ; Branched to from 8D9C VMJ
    SJP	    SUB_95C6                        ; Might display text for terminal program?

BRANCH_8E94: ; Branched to from 8E8F, 8EAE
    JMP	    BRANCH_8D70                     ; Jumps to the insane tabel indexing code


BRANCH_8E97: ; Branched to from BRANCH_TBL_8DD9
    LDI	    UL,$40                          ;
    BCH     BRANCH_8EAA                     ; Unconditional fwd branch


BRANCH_8E9B: ; Branched to from BRANCH_TBL_8DD9
    LDI	    UL,$20                          ;
    LDI	    A,$FE                           ;
    STA	    (BRK_LINE_H)                    ; BREAK LINE (L)
    ANI	    (BRK_LINE_L),$00                ; BREAK LINE (H) set to FE00. Vectro to DCB7
                                            ; DCB7 - Checks if UL in interval D1-D2 at Token in U-Reg 
                                            ;  if interval exceeded continue at Error Return Address.
    BCH     BRANCH_8EAA                     ; Unconditional fwd branch


BRANCH_8EA8: ; Branched to from BRANCH_TBL_8DD9
    LDI	    UL,$10                          ; UL set to 40, 20, 10 based on branch point from BRANCH_TBL_8DD9

BRANCH_8EAA: ; Branched to from 8EA6
    LDA	    UL                              ;
    STA	    (DISP_BUFF + $4F)               ; Sets LCD indicators DE, G, RAD, etc.
    BCH     BRANCH_8E94                     ; Unconditional back branch

; Not sure how this is reached?
    LDI	    A,$80                           ;
    EOR	    (ERR_LINE_H)                    ;
    BII	    A,$80                           ;
    BZS     BRANCH_8EBD                     ; If Bit 7 set branch forward
    BII	    A,$40                           ;
    BZS     BRANCH_8E94                     ; If Bit 2 set branch back


BRANCH_8EBD: ; Branched to from 8EB7
    STA	    (ERR_LINE_H)                    ; 
    JMP	    BRANCH_8D70                     ; Jumps to the insane tabel indexing code


BRANCH_8EC3: ; Branched to from 8E6B, 8E77, 8E8A
    SJP	    IRQ_RESET                       ; Resets IRQ masks for CE-150, CE-158
    ANI	    (BRK_TOP_L),$00                 ; Clear register. BREAK TOP (L)
    SJP	    SUB_9802                        ; Resets last pressed key register and repeat speed.
    ORI	    #(PC1500_MSK_REG),$01           ; PC-1500 - Set interrupt mask for IRQ
    LDI	    A,$BA                           ;
    STA	    (CE158_REG_79FA)                ; Well, it is undefined
    JMP	    SUB_INPUT_NUM_ALT_E1            ;



;------------------------------------------------------------------------------------------------------------
; JMP_8EEF - Jumped to from 8E26, Branched to from 8F64
; Maybe terminal related?
; Arguments: 
; Output: 
; RegMod: A
BRANCH_8EDA: ; Branched to from 8F6A
    SJP	    PORTS_UPDATE_ALT_E2             ;
    LDI	    A,$06                           ;
    BCR     BRANCH_8EE4                     ; Carry was set in sub

BRANCH_8EE1: ; Branched to from 8EED
    JMP	    SUB_8D04_ALT_E1                 ; Resets CE-150, LCD annuncuiators, jumps to new code


BRANCH_8EE4: ; Branched to from 8EDF
    ANI	    (ERR_TOP_H),$FE                 ; Clear Bit 0 (unknown flags)
    LDA	    (ERR_TOP_H)                     ;
    CPI	    A,$20                           ;
    BZS     BRANCH_8EE1                     ; If A = 20 branch back

JMP_8EEF: ; Jumped to from 8E26, Branched to from 8F64
    SJP	    SUB_8BCE                        ; Not sure

BRANCH_8EF2: ; Branched to from 8FBE
    LDA	    YL                              ;
    STA	    (INBUFPTR_L)                    ; INPUT BUFFER POINTER (L)
    LDI	    A,$40                           ;
    STA	    (DISPARAM)                      ; Determines display at READY. Bit 7 = 1 is BREAK.
    SJP	    INBUF_CLRRST                    ; Cleaers rest of the Input buffer with "0D"

BRANCH_8EFE: ; Branched to from 8F0D, 8F10, 8F1D, 8F26, 8F30
    SJP	    PRGMDISP                        ; Display content of display buffer
    SJP	    SUB_998D                        ; Resets last pressed key register, repeat speed, LCD annunciators
    LDI	    S,(CPU_STACK + $4F)             ; Load (CPU_STACK + $4F) into SP register (Stack Pointer)
    CPI	    A,$20                           ; Where did A come from
    BCR     BRANCH_8F12                     ; If A < 20 branch fwd

BRANCH_8F0B: ; Branched to from 8F3B
    STA	    (Y)                             ; What is Y here?
    INC	    YL                              ;
    BCR     BRANCH_8EFE                     ; If YL did not overflow, branch back
    DEC	    YL                              ;
    BCH     BRANCH_8EFE                     ; Unconditional branch back

BRANCH_8F12: ; Branched to from 8F09        ; Checks characters in UL for presets in table. 
    VMJ	    ($34)                           ; 03 + 1 = # of two byte arguments following (vectors)
                ABYT($03)
                ABYT($0D) \ ABRF(BRANCH_8F3D)   ; 0D = CR
                ABYT($0A) \ ABRF(BRANCH_8F32)   ; 0A = LF
                ABYT($0E) \ ABRF(BRANCH_8F1F)   ; 0E = Shift Out (SO) / XON
                ABYT($08) \ ABRF(BRANCH_8F22)   ; 08 = Back Space

    BCH     BRANCH_8EFE                     ; Unconditional branch back

BRANCH_8F1F: ; Branched to from 8F12
    JMP	    SUB_8D04                        ; Resets CE-150, LCD annuncuiators, jumps to new code

BRANCH_8F22: ; Branched to from 8F12        ; Hanldes Back Space charecter?
    LDA	    (INBUFPTR_L)                    ; INPUT BUFFER POINTER
    CPA	    YL                              ;
    BZS     BRANCH_8EFE                     ;
    DEC	    YL                              ;
    LDI	    A,$0D                           ; 0D = CR
    STA	    (Y)                             ; What is Y here?
    ORI	    (CURS_CTRL),$40                 ; Character to blink
    BCH     BRANCH_8EFE                     ; Unconditional branch back

BRANCH_8F32: ;Branched to from  8F37 VMJ    ; Hanldes LF charecter?
    LDI	    A,$21                           ;
    CPA	    (ERR_TOP_H)                     ;
    BZR     BRANCH_8F3D                     ; If A != (ERR_TOP_H)
    LDI	    A,$40                           ;
    BCH     BRANCH_8F0B                     ; Unconditional branch back

BRANCH_8F3D: ; Branched to from 8F12, 8F37 VMJ  ; Hanldes CR charecter?
    LDA	    YL                              ;
    STA	    XL                              ;
    LDA	    (INBUFPTR_L)                    ; INPUT BUFFER POINTER (L)
    STA	    YL                              ;
    LDA	    (Y)                             ; What are Y and X here?
    CPI	    A,$0D                           ; 0D = CR
    BZR     BRANCH_8F66                     ; If A != 0D

BRANCH_8F48: ; Branched to from 8F94
    LDA	    (ERR_TOP_H)                     ;
    INC	    A                               ; A = (ERROR_TOP_L)
    BII	    A,$01                           ;
    BZS     BRANCH_8F51                     ; If A != 01
    INC	    A                               ;

BRANCH_8F51: ; Branched to from 8F46
    STA	    (ERR_TOP_H)                     ;
    CPI	    A,$18                           ; 18 = Cancel
    BCR     BRANCH_8F86                     ; If A < 18 branch 
    CPI	    A,$20                           ; 20 = Space
    BZS     BRANCH_8F86                     ; If A != 20
    CPI	    A,$22                           ; 22 = #
    BZS     BRANCH_8F86                     ; If A != 22
    CPI	    A,$2E                           ; 2E = .
    BCS     BRANCH_8F86                     ; If A >=  2E
    BCH     JMP_8EEF                        ; Unconditional back branch

BRANCH_8F66: ; Branched to from 8F46
    BII	    (ERR_TOP_H),$01                 ; Test Bit0
    BZR     BRANCH_8EDA                     ; If Bit0 was set
    LIN     Y                               ; A = (Y) then INC Y
    CPI	    A,$59                           ; 59 = Y
    BZS     BRANCH_8F89                     ; If A = 59 branch fwd
    CPI	    A,$4E                           ; 4E = N
    BZR     BRANCH_8F86                     ; If != 4E branch fwd
    LDA	    (ERR_TOP_H)                     ;
    CPI	    A,$16                           ; 16 = SYN, Syncronous Idle?
    BCS     BRANCH_8FB3                     ; If A >= 16 branch fwd
    SJP	    SUB_86F0                        ; A < 16 Calculates a new address to set P to (Program Counter)

; TBL_8F7F - Used by SUB_86F0 for jump calculations
TBL_8F7F:                                   ; SUB_86F0 pops the return address of above
    .BYTE   $06,$21,$24,$27,$16,$19,$10     ; off stack to know where this data table starts.


BRANCH_8F86: ; Branched to from 8F56, 8F5A, 8F5E, 8F62, 8F73, 8F8E, 8FB5
    JMP	    BRANCH_8D4F                     ; Jumps to the crazy lookup table jump code

BRANCH_8F89: ; Branched to from 8F6F
    LDA	    (ERR_TOP_H)                     ;
    CPI	    A,$16                           ; 16 = SYN, Syncronous Idle?
    BCR     BRANCH_8F86                     ; If A < 16 branch back
    CPI	    A,$20                           ; 20 = Space
    BCS     BRANCH_8FB7                     ; If A >= 20 branch fwd
    BCH     BRANCH_8F48                     ; Unconditional branch back A > 16 & A < 20


; Jumped to from 8709 vector calculation
    LDI	    A,$40                           ; 50 = @
    BCH     BRANCH_8FAC                     ; Unconditional fwd branch

; Jumped to from 8709 vector calculation
    LDI	    A,$08                           ; 08 = Back Space
    BCH     BRANCH_8FAC                     ; Unconditional fwd branch

; Jumped to from 8709 vector calculation
    LDI	    A,$01                           ; 01 = SOH Start of Heading
    BCH     BRANCH_8FAC                     ; Unconditional fwd branch

; Jumped to from 8709 vector calculation
    LDI	    A,$04                           ; 04 = EOT End of Transmission
    BCH     BRANCH_8FAC                     ; Unconditional fwd branch

; Jumped to from 8709 vector calculation
    LDI	    A,$80                           ; 80 = past printable ASCII
    BCH     BRANCH_8FAC                     ; Unconditional fwd branch

; Jumped to from 8709 vector calculation
    LDI	    A,$02                           ; 02 = SOT Start of Text


BRANCH_8FAC: ; Branched to from 8F98, 8F9C, 8FA0, 8FA4, 8FA8
    EOR	    (ERR_LINE_H)                    ; A = A ^ (ERR_LINE_H)
    STA	    (ERR_LINE_H)                    ; Setting error type/cause?
    RTN                                     ;

BRANCH_8FB3: ; Branched to from 8F7A        ; Got here is A >= 16
    CPI	    A,$20                           ; 20 = Space
    BCS     BRANCH_8F86                     ; If A >= 20 branch back

BRANCH_8FB7: ; Branched to from 8F92        ; If dropped through A >= 16 and A < 20
    ADI	    (ERR_TOP_H),01                  ; Set error type
    LDI	    A,$20                           ;
    SIN     Y                               ; (Y) = A. Then Y = Y + 1
    JMP	    BRANCH_8EF2                     ; Keep parsing ?



;------------------------------------------------------------------------------------------------------------
; SUB_8FC1: ; Called from 8D04:8E37, 8CDA
; Copies 20 bytes to/from String Var P$. ***what is p& used for?
; Arguments: X
; Output: 
; RegMod: X, A, Y, U
SUB_8FC1: 
    REC                                     ; Reset Carry Flag

SUB_8FC2: ; Called from 8D1B
    VEJ	    (CC)                            ; Loads X-Reg with address at 78(93) 78(94). BAS_PENOP_STK_L
                ABYT($93)                   ;
    LDI	    A,$1A                           ;
    ADR	    X                               ; X = X + A. 
    BCS     BRANCH_8FD2                     ; If X > E5, we carried out
    STX     Y                               ; Y = X
    LDI	    XL,LBO(STRING_VARS,$0100)       ; STRING_VARS = 7650
    LDI	    XH,HBO(STRING_VARS,$0100)       ; X = 7750, String Var P$ Byte 0
    BCH     BRANCH_8FD6                     ; Unconditional fwd branch
 
BRANCH_8FD2: ; Branched to from 8FC8
    LDI	    YL,LBO(STRING_VARS,$0100)       ; STRING_VARS = 7650
    LDI	    YH,HBO(STRING_VARS,$0100)       ; X = 7750, String Var P$ Byte 0

BRANCH_8FD6: ; Branched to from 8FD0
    LDI	    UL,$1F                          ; Copy 20 bytes?

BRANCH_8FD8: ; Branched to from 8FD9
    TIN                                     ; (Y) = (X) then X = X + 1, Y = Y + 1
    LOP	    UL,BRANCH_8FD8                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set
    RTN                                     ;


; not sure what this belongs to ***
    LDI	    YL,$50                          ; 
    LDI	    YH,$FD                          ; Y = FD50



;------------------------------------------------------------------------------------------------------------
; JMP_8FE0 - Jumped to from 911B
; Seems like it resets some things
; Arguments: X
; Output: 
; RegMod:
JMP_8FE0:
    SDP                                     ; Sets LCD ON/OFF control flip-flop
    LDI	    S,(CPU_STACK + $4F)             ; Stack Pointer = (CPU_STACK + $4F)
    SJP	    SUB_97BA                        ; Changes last pressed key code and repeat speed?
    BCR     BRANCH_9039                     ; SUB_97BA Returns C=0=success. 9039 Calls SUB_8FED below
    JMP	    SUB_PRINT_NUM_ALT_E1            ;



;------------------------------------------------------------------------------------------------------------
; SUB_8FED - Called from 9039
; Seems to set LCD annuncitors, maybe for Terminal mode?
; Arguments: U 
; Output: 
; RegMod: A, U
SUB_8FED: 
    CPI	    UL,$0E                          ;
    BZR     BRANCH_8FF4                     ; If UL != 0E branch fwd
    JMP	    SUB_8D04                        ; Resets CE-150, LCD annuncuiators, jumps to new code


BRANCH_8FF4: ; Branched to from 8FEF
    ANI	    (DISP_BUFF+$4E),$7F             ; Clear Bit 7, don't know what this bit is
    LDI	    A,$02                           ;
    LDI	    UH,$7F                          ;
    CPI	    UL,$01                          ; What changed UL from 8FED
    BZS     BRANCH_9027                     ; If UL = 01 branch fwd
    LDI	    A,$00                           ; 
    CPI	    UL,$1B                          ; 
    BZS     BRANCH_9027                     ; If UL = 1B branch fwd
    CPI	    UL,$02                          ;
    BZR     BRANCH_9038                     ; If UL != 02 branch fwd
    ANI	    #(PC1500_PRT_B_DIR),$F7         ; Bit 3 set to read, Region bit: Japanese = 0, Export = 1
    LDI	    UL,LBO(FIXED_VARS,$48)          ; 
    LDI	    UH,HBO(FIXED_VARS,$48)          ; U = 7908, NUMERIC VAR B Byte 0
    BII	    #(PC1500_PRT_B),$08             ; region bit: Japanese = 0, Export = 1
    BZR     BRANCH_9028                     ; If export unit branch fwd
    LDA	    (DATA_PTR_H)                    ; DATA POINTER (H)
    LDI	    UL,LB($7504)                    ;
    LDI	    UH,HB($7504)                    ; U = 7504
    BZS     BRANCH_9028                     ; If (DATA_PTR_H) was zero branch fwd
    LDI	    A,$00                           ;
    LDI	    UH,HB($7104)                    ; U = 7104

BRANCH_9027: ; Branched to from 8FFE, 9004
    STA	    UL                              ; U = 7F02 or 7F00 or 7100

BRANCH_9028: ; Branched to from 9018, 9021
    LDA	    UL                              ; UL = 0E,01,1B,02,08,04,00
    EOR	    (DISP_BUFF+$4E)                 ; A = A ^ (DISP_BUFF+$4E)
    STA	    (DISP_BUFF+$4E)                 ; Toggle some bits BUSY, SHIFT, etc. 
    LDA	    UH                              ; UH = 7F,79,75,71
    AND	    (DISP_BUFF+$4E)                 ;
    STA	    (DISP_BUFF+$4E)                 ; Set some bits
    LDI	    A,$00                           ;

BRANCH_9038: ; Branched to from 9008
    RTN                                     ;


BRANCH_9039: ; Branched to from 8FE8
    SJP	    SUB_8FED                        ; Seems to set LCD annuncitors, maybe for Terminal mode?
    BZR     BRANCH_9043                     ;

JMP_903E: ; Jumped to from 915C
    SJP	    SUB_9802                        ; Resets last pressed key register and repeat speed.
    BCH     UNKNOWN_JMP_9083                ; Unconditional fwd branch

BRANCH_9043: ; Branched to from 903C
    BII	    (KEY_REPEAT),$02                ; Repeat speed
    BZS     BRANCH_904C                     ; If Bit 2 was not set branch fwd
    JMP	    JMP_9F25                        ; No idea what this does

BRANCH_904C: ; Branched to from 9047
    BII	    (DISP_BUFF + $4E),$0E           ; BUSY, SHIFT, etc.
    BZR     BRANCH_913E                     ; If all Bits 3-1 not clear branch fwd
    BII	    (DISP_BUFF + $4F),$07           ; DE, GRAD, RAD, etc.
    BZS     BRANCH_913E                     ; If all Bits 0-2 clear 
    CPI	    UL,$5B                          ; Where did UL come from?
    BCS     BRANCH_913E                     ; If UL >= 5B branch fwd
    LDA	    UL                              ; UL < 58
    SBI	    A,$40                           ; A = A - 40
    BCR     BRANCH_913A                     ; If A was > 40 branch fwd
    INC	    A                               ;

BRANCH_9062: ; Branched to from 913C
    BII	    (DISP_BUFF + $4F),$04           ; DE, GRAD, RAD, etc.
    BZR     BRANCH_906F                     ; If Bit 2 not set branch fwd
    LDI	    UH,HB(TBL_8669)                 ;
    LDI	    UL,LB(TBL_8669)                 ; U = 8669, TBL_8669
    ADR	    U                               ; U = U + A. Index into U pointer?       
    LDA	    (U)                             ; A = (U)

BRANCH_906F: ; Branched to from 9066
    STA	    (USINGM)                        ; USING M integer part



;------------------------------------------------------------------------------------------------------------
; UNKNOWN_JMP_9072 - Branched to from 914B, 914F, Jumped to from 9F22, JUMP_TBL_915F
; Changes LCD annunciators branches to SUB_PRINT_NUM_ALT_X1
UNKNOWN_JMP_9072:
    STA	    UL                              ; Where does A come from, fall thru from above?

UNKNOWN_JMP_9073: ; Called from JUMP_91BC:9222
    LDA	    (ERR_ADD_H)                     ; ERROR ADDRESS (H)
    STA	    XL                              ;
    LDI	    XH,$7B                          ; X = 7B##
    CPI	    A,$D8                           ;
    BCR     UNKNOWN_JMP_9083                ; If A < D8 branch fwd
    LDA	    UL                              ; X >= 7BD8, INPUT BUFFER Byte 40
    SIN	    X                               ; (X) = A. Then X = X + 1
    LDA	    XL                              ;

UNKNOWN_JMP_9080: ; Called from JUMP_91BC:9229
    STA	    (ERR_ADD_H)                     ; ERROR ADDRESS (H)

; Unknown JMP 9083 - Jumped to from 9613, 96C5, 974A
UNKNOWN_JMP_9083:
    AND	    (DISP_BUFF + $4F),$F0           ; Clear low nibble. DE, GRAD, RAD, etc.

UNKNOWN_JMP_9087: ; Jumped to from 962D
    ANI	    (DISP_BUFF + $4E),$7F           ; Clear bit 7. BUSY, SHIFT, etc. 

JMP_908B: ; Jumped to from 9255
    LDA	    (ERR_ADD_H)                     ; ERROR ADDRESS (H)
    CPI	    A,$D8                           ;
    BZS     SUB_PRINT_NUM_ALT_X1            ; If A = D8 branch fwd
    BII     (ERR_LINE_H),$02                ;
    BZS     BRANCH_909E                     ; If Bit 2 was not set branch fwd
    BII     (BRK_TOP_H),$40                 ; BREAK TOP (H)
    BZR     SUB_PRINT_NUM_ALT_X1            ; If Bit 5 not set

BRANCH_909E: ; Branched to from 9096
    BII     (ERR_LINE_H),$04                ;
    BZS     BRANCH_90AB                     ; If Bit 2 not set
    LDA	    (ERR_ADD_L)                     ; ERROR ADDRESS (L)
    CPI	    A,$D8                           ;
    BCS     SUB_PRINT_NUM_ALT_X1            ; If A >= D8

BRANCH_90AB: ; Branched to from 90A2
    LDA	    (IN_BUF + $28)                  ; inside INPUT BUFFER
    JMP	    JMP_9ED0                        ; Not sure



;------------------------------------------------------------------------------------------------------------
; SUB_PRINT_NUM
; JMP_90B1 - Jumped to from JMP_9ED0:9F00
; Sends A to RS232 and checks/changes things in CE-158?
; Arguments: 
; Output: 
; RegMod: XL, Y, A 
JMP_90B1:
    SJP     CHAR2COM                        ; Sends charecter in A to RS232 Port
    BCS     SUB_PRINT_NUM_ALT_X1            ; Carry set = failure
    LDI	    XL,$D8                          ;
    SJP     SUB_9845                        ; Shifts display left one charecter
    ADI	    (ERR_ADD_H),$FF                 ; Set all bits in ERROR ADDRESS (H)
    BII	    (ERR_LINE_H),$04                ;
    BZS     BRANCH_90D5                     ; If Bit 2 not set
    RIE                                     ; Disable interrupts
    LDA	    (ERR_ADD_L)                     ; ERROR ADDRESS (L)
    STA	    YL                              ;
    LDI	    YH,$7B                          ; Y = 7B##
    LDA	    UH                              ;
    STA	    (Y)                             ;
    ADI	    (ERR_ADD_L),$01                 ; ERROR ADDRESS (L)
    SIE                                     ; Enable interrupts

BRANCH_90D5: ; Branched to from 90C3
    LDA	    (GOSB_STK_PTR_L)                ; GOSUB pointer
    BZS     SUB_PRINT_NUM_ALT_X1               ; If pointer zero branch fwd
    LDA	    (BAS_DATA_STK_L)                ; Data pointer
    CPI	    A,$E6                           ;
    BZS     BRANCH_90E8                     ; If A = E6

JMP_90E1: ; Jumped to from JMP_9ED0:9F65
    ORI	    (GOSB_STK_PTR_L),$FF            ; Set all bits. GOSUB pointer
    JMP	    JMP_936E                        ; Jumps into SUB_PRINT_NUM_ALT_X1


BRANCH_90E8: ; Branched to from 90DF
    ANI	    (GOSB_STK_PTR_L),00             ; Clear all bits. GOSUB pointer

SUB_PRINT_NUM_ALT_X1: ; Branched to from JMP_90B1:90B4, Jumped to from SUB_PRINT_NUM:94A8
    SDP                                     ; Sets LCD ON/OFF control flip-flop
    BII	    #(PC1500_IF_REG),$02            ; PC-1500 PB7 interrupt flag, Power Button
    BZS     BRANCH_90F8                     ; If Bit 1 was not set
    JMP	    SUB_8D04                        ; Resets CE-150, LCD annuncuiators, jumps to new code


BRANCH_90F8: ; Branched to from 90F3
#IFNDEF CE158V2
; ************ Modified >
    LDA     #(CE158_PRT_A)                  ; 
    AND	    #(CE158_PRT_A)                  ; 2nd reading to catch changes
    BII	    A,$20                           ; Bit 5, Low Battery
#ELSE
    LDA	    #(CE158_UART_MSR0)              ; #(CE158_UART_MSR0) is RS232 I/F Ctrl (ME1)
    AND	    #(CE158_UART_MSR0)              ; Filter out changes (ME1)
    BII	    A,$40                           ; Bit 6, Low Battery for the new TI parts
; <************
#ENDIF

    BZS     BRANCH_910D                     ; If bit 5 was not set
    ADI	    (OUTSTAT_REG),$40               ; (OUTSTAT_REG) = (OUTSTAT_REG) + 40
    BCR     BRANCH_9111                     ; If (OUTSTAT_REG) was < BF so no Carry set
    JMP	    JMP_8CFD                        ; Jumps on to SUB_8D04_ALT_E1

BRANCH_910D: ; Branched to from 9102
    ANI	    (OUTSTAT_REG),$0F               ; Clear high nibble

BRANCH_9111: ; Branched to from 9108
    SJP	    SUB_99D6_ALT_E1                 ; Not sure?
    ADI	    (CURS_CTRL),$10                 ; Character to blink. ADI alters C
    SJP	    SUB_911E                        ; looking for something at PC-1500 - IF Register?
    JMP	    JMP_8FE0                        ; Seems like it resets some things



;------------------------------------------------------------------------------------------------------------
; SUB_911E  Called from 9118, 9994
; Exit if Carry clear, else wait until PC-1500 IF_REG IRQ and PB7 (Power Button) are clear before exit
; Arguments: 
; Output: 
; RegMod: UL
SUB_911E: 
    BCR     BRANCH_9139                     ; If the ADI preceeding this call did not set carry
    ADI	    (USING_CHR),$01                 ; USING & using of character string
    BCR     BRANCH_9135                     ; If (USING_CHR) was < FF exit
    LDI	    UL,$3C                          ;
    RIE                                     ; Disable interrupts
    RDP                                     ; Sets LCD ON/OFF control flip-flop

BRANCH_912C:
    BII	    #(PC1500_IF_REG),$03            ; PC-1500 Bit 0 = IRQ, Bit 1 = PB7 = Power Button (ME1)
    BZR     BRANCH_9135                     ; If  Bits 0-1 were not both reset
    LOP	    UL,BRANCH_912C                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set

BRANCH_9135: ; Branched to from 9124, 9131 
    SIE                                     ; Enable interrupts
    SDP                                     ; Sets LCD ON/OFF control flip-flop

BRANCH_9139: ; Branched to from 911E
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; A bit of code added to SUB_8FED
; Arguments A, U
BRANCH_913A: ; Branched to from 905F
    SBI	    A,$EE                           ; A = A - EE
    BZS     BRANCH_9062                     ; If A was = EE branch back

BRANCH_913E: ; Branched to from 9050, 9056, 905A
    LDA	    UL                              ; 
    SJP	    (AUTO_OFF + $27)                ; Auto Power Off routine, beginning of power back on


BRANCH_9142: ; Branched to from 915A        ; Auto Power off jump above might return back here
    STA	    (USINGM)                        ; USING M integer part
    CPI	    A,$20                           ; 20 = space
    BCR     JUMP_91BC                       ; If A < 20 branch, else A >= 20
    CPI	    A,$61                           ; 61 = A 
    BCS     UNKNOWN_JMP_9072                ; If A >= 61 branch, else A >=20 A < 61
    CPI	    A,$5B                           ; 5B = [
    BCR     UNKNOWN_JMP_9072                ; If A < 5B branch, else A >= 5B A < 61
    BZS     BRANCH_9158                     ; If A = 5B branch, else A > 5B A < 61
    CPI	    A,$5D                           ; 5D = ]
    BZR     BRANCH_915C                     ; If A != 5D branch, else A = 5D
    INC	    A                               ; A = 5E = ^

BRANCH_9158: ; Branched to from 9151
    ANI	    A,$1F                           ; A = 5B or A = 5E -> A = 1B or A = 1E
    BCH     BRANCH_9142                     ; Unconditional back branch

BRANCH_915C: ; Branched to from 9155 
    JMP	    JMP_903E                        ;



;------------------------------------------------------------------------------------------------------------
; JUMP_TBL_915F - Function address and value of A to pass to function
; Used by 91DE
JUMP_TBL_915F:
    .WORD   SUB_PRINT_NUM_ALT_E1 \ .BYTE $40    ; A1  - 923E    SUB_PRINT_NUM_ALT_E1
    .WORD   SUB_PRINT_NUM_ALT_E1 \ .BYTE $80    ;     - 923E    SUB_PRINT_NUM_ALT_E1
    .WORD   JMP_9647             \ .BYTE $80    ; A2  - 9647    JMP_9647
    .WORD   BRANCH_9642          \ .BYTE $40    ; A3  - 9642    BRANCH_9642
    .WORD   JMP_9630             \ .BYTE $20    ; A4  - 9630    JMP_9630
    .WORD   BRANCH_9642          \ .BYTE $10    ;     - 9642    BRANCH_9642 
    .WORD   SUB_PRINT_NUM_ALT_E1 \ .BYTE $00    ;     - 923E    SUB_PRINT_NUM_ALT_E1
    .WORD   JMP_96C8             \ .BYTE $01    ; A5  - 96C8    JMP_96C8
    .WORD   JMP_9616             \ .BYTE $00    ; A6  - 9616    JMP_9616
    .WORD   JMP_96C8             \ .BYTE $01    ;     - 96C8    JMP_96C8
    .WORD   JMP_96C8             \ .BYTE $01    ;     - 96C8    JMP_96C8
    .WORD   JMP_96C8             \ .BYTE $01    ;     - 96C8    JMP_96C8
    .WORD   UNKNOWN_JMP_9072     \ .BYTE $0D    ; A7  - 9072    UNKNOWN_JMP_9072
    .WORD   SUB_8D04             \ .BYTE $00    ; A8  - 8D04    SUB_8D04 
    .WORD   SUB_PRINT_NUM_ALT_E1 \ .BYTE $00    ;     - 923E    SUB_PRINT_NUM_ALT_E1
    .WORD   SUB_PRINT_NUM_ALT_E1 \ .BYTE $00    ;     - 923E    SUB_PRINT_NUM_ALT_E1
    .WORD   JMP_967B             \ .BYTE $01    ; A9  - 967B    JMP_967B 
    .WORD   UNKNOWN_JMP_9072     \ .BYTE $08    ;     - 9072    UNKNOWN_JMP_9072
    .WORD   JMP_9657             \ .BYTE $01    ;     - 9657    JMP_9657
    .WORD   JMP_961B             \ .BYTE $03    ;     - 961B    JMP_961B
    .WORD   UNKNOWN_JMP_9072     \ .BYTE $1B    ;     - 9072    UNKNOWN_JMP_9072
    .WORD   JMP_961B             \ .BYTE $04    ; A10 - 961B    JMP_961B
    .WORD   SUB_PRINT_NUM_ALT_E1 \ .BYTE $00    ;     - 923E    SUB_PRINT_NUM_ALT_E1
    .WORD   JMP_9F1B             \ .BYTE $01    ; A11 - 9F1B    JMP_9F1B
    .WORD   JMP_9610             \ .BYTE $01    ; A12 - 9610    JMP_9610
    .WORD   JMP_9F06             \ .BYTE $01    ; A13 - 9F06    JMP_9F06
    .WORD   JMP_96C8             \ .BYTE $01    ;     - 96C8    JMP_96C8
    .WORD   SUB_PRINT_NUM_ALT_E1 \ .BYTE $00    ;     - 923E    SUB_PRINT_NUM_ALT_E1
    .WORD   SUB_PRINT_NUM_ALT_E1 \ .BYTE $00    ;     - 923E    SUB_PRINT_NUM_ALT_E1            
    .WORD   JMP_96C8             \ .BYTE $01    ;     - 96C8    JMP_96C8
    .WORD   SUB_PRINT_NUM_ALT_E1 \ .BYTE $00    ;     - 923E    SUB_PRINT_NUM_ALT_E1



;------------------------------------------------------------------------------------------------------------
; JUMP_91BC: Branched to from 9147, Jumped to from 9F32 ***JMP
; If A = 0 it points to a line of code. Guessing A must be > 0.
; May use JUMP_TBL_915F to jump to new code
; Arguments: A <= 19 from 9147, A=80~1F 9F32
; Output: 
; RegMod: U, A
JUMP_91BC: 
    LDI	    UL,$5C                          ;
    ORI	    (USINGM),$80                    ; Set Bit 7. USING M integer part
    LDI	    UH,$91                          ; U = 915C
    BII	    A,$08                           ; Check bit 3 of A that was passed in
    BZR     BRANCH_91D6                     ; If Bit 3 set skip. 00~07 or 10~17 Z=0, 08~0F or 18~1F Z=1
    BII	    (DISP_BUFF + $4E),$10           ; Bit 4, (DEFIII) annunciator on LCD
    BZR     BRANCH_91D0                     ; If Bit 4 was set branch fwd
    ANI	    A,$EF                           ; A = 00~07 Clear Bit 4

BRANCH_91D0: ; Branched to from 91CC
    BII	    (DISP_BUFF + $4E),$40           ; (RUN) annunciator on LCD
    BZR     BRANCH_91F6                     ; If Bit 6 set skip jump calculation and jump below
                   
                                            ; A = 08~0F, 18~1F from 91C6
                                            ; A = 00~07, 10~17 from 91CC
BRANCH_91D6: ; Branched to from 91C6        ; A = 00-07        from 91CE
    ADR	    U                               ; U = U + A, U = 915C, A = 00~1F.
    SHL                                     ; A = A * 2
    ADR	    U                               ; U = U + 3A is result of all of this
                                            ; range is 915C to 91B9
    LIN	    U                               ; A = (U) then INC U
    STA	    XH                              ;
    LIN	    U                               ; A = (U) then INC U, 
    STA	    XL                              ; X is now the address from JUMP_TBL_915F
    LDA	    (KEY_LAST)                      ; Last pressed key code.
    CPI	    A,$08                           ; Left Cursor Key
    BCR     BRANCH_91F0                     ; If A < 08 branch fwd (< 08 is only SHFT and SML)
    CPI	    A,$0D                           ; Enter Key
    BZS     BRANCH_91F3                     ; If A = 0D/Enter branch fwd
    BCS     BRANCH_91F0                     ; If A > 0D branch fwd
    CPI	    A,$09                           ; Up/Down Cursor. A > 08 & A < 0D
    BZR     BRANCH_91F3                     ; If A != 09 branch fwd

BRANCH_91F0: ; Branched to from 91E4, 91EA
    SJP	    SUB_9802                        ; When A < 8 or A > 0D

BRANCH_91F3: ; Branched to from 91E8, 91EE  ; If A > 08 & A < 0D & A != 09
    LDA	    (U)                             ; Argument from JUMP_TBL_915F
    STX	    P                               ; P = X. Set Program Counter to X ***JMP


BRANCH_91F6: ; Branched to from 91D4        ; If we did not jump away above, 
    CPI	    A,$06                           ; A = 00~07, 10~17 from 91CC, A = 00-07 from 91CE
    BCR     BRANCH_91FC                     ; If A < 6 branch fwd
    LDI	    A,$07                           ; else set A = 07

BRANCH_91FC: ; Branched to from 91F8
    STA	    (CURVARADD_L)                   ;
    VMJ	    ($38)                           ; Determines reserve memory type adress + 8 and stores it in X-Reg. 
                                            ; Sets C=0 if 2nd reserve memory area is occupied 
    SJP	    RESKEY_SRCH                     ; Searches for reserve key code in reserve memory
    BCR     BRANCH_9225                     ; Carry from sub. 9225 -> JMP UNKNOWN_JMP_9083
    JMP	    JMP_9F35                        ; This is jumping back after 9F32 which jumped here



;------------------------------------------------------------------------------------------------------------
; JMP_9209 - Jumped to from  JMP_9ED0:9F6B
; Reads something from 7BAA (in OUTPUT BUFFER) and then jumps out. Purpose?
; Arguments: A = ERROR ADDRESS (H), X = (CURVARADD_L)
; Output: 
; RegMod: UL, X, A
JMP_9209:
    STA	    UL                              ; 
    LDI	    UH,$7B                          ; String buffer?
    LIN	    X                               ; A = (X) then INC X
    CPI	    A,$26                           ;
    BZR     BRANCH_922C                     ; If A != 26 branch fwd
    LDI	    UL,$00                          ; U = 7B00 - RND Byte 0
    SJP	    SUB_9E3B                        ; Reads value from (X) into A and manipulates A 
    BCS     BRANCH_9222                     ; Carry = failure
    STA	    UL                              ;
    SJP	    SUB_9E3B                        ; Reads value from (X) into A and manipulates A 
    BCS     BRANCH_9222                     ; Carry = failure
    AEX                                     ; Swap high and low bytes of A
    ADC	    UL                              ; A = A + UL
    AEX                                     ; Swap high and low bytes of A
    STA	    UL                              ; Why?

BRANCH_9222: ; Branched to from 9216, 9219, 9232
    JMP	    UNKNOWN_JMP_9073                ; Changes LCD annunciators branches to SUB_PRINT_NUM_ALT_X1


BRANCH_9225: ; Branched to from 9204
    JMP	    UNKNOWN_JMP_9083                ; Changes LCD annunciators branches to SUB_PRINT_NUM_ALT_X1


BRANCH_9228: ; Branched to from 922E
    LDA	    UL                              ;
    JMP	    UNKNOWN_JMP_9080                ; Changes LCD annunciators branches to SUB_PRINT_NUM_ALT_X1


BRANCH_922C: ; Branched to from 920F, 923C
    BII	    A,$E0                           ; 
    BZS     BRANCH_9228                     ; If A = E0 branch
    CPI	    UL,$D8                          ;
    BCR     BRANCH_9222                     ; If A < D8 branch
    CPI	    A,$40                           ;
    BZR     BRANCH_923A                     ; If A != 40 branch
    LDI	    A,$0D                           ;

BRANCH_923A: ; Branched to from 9236
    SIN	    U                               ; (U) = A then INC U
    LIN	    X                               ; A = (X) then INC X
    BCH     BRANCH_922C                     ; Uncondtional back branch



;------------------------------------------------------------------------------------------------------------
; SUB_PRINT_NUM - Entry at 93D0
; SUB_PRINT_NUM_ALT_E1  - Jumped to from JMP_9ED0:9F18
; Not sure seems to do some parsing, but all over the place
; Arguments: 
; Output: 
; RegMod: A, UL, X
SUB_PRINT_NUM_ALT_E1: ; 923E
    LDA	    (ERR_ADD_L)                     ; ERROR ADDRESS (L)
    CPI	    A,$B1                           ;
    BCS     BRANCH_9248                     ; If A >= B1 branch fwd
    SJP	    SUB_99E6                        ; Not sure?

BRANCH_9248: ; Branched to from 9243
    BII	    (DISP_BUFF + $4E),$01           ; LCD (Busy) Annunciator
    BZR     BRANCH_9255                     ; If Bit 0 was not set
    LDA	    (ERR_ADD_L)                     ; ERROR ADDRESS (L)
    CPI	    A,$B1                           ; 
    BCS     BRANCH_925E                     ; If A >= B1 branch

BRANCH_9255: ; Branched to from 924C
    JMP	    JMP_908B                        ; Not sure?


TBL_9258:
    .TEXT "#PC2@\r"                         ; Used in 927C


BRANCH_925E: ; Branched to from 9253
    LDA	    (IN_BUF)                        ; INPUT BUFFER Byte 0 START
    STA	    UL                              ;
    CPI	    A,$20                           ; 20 = Space
    BCR     BRANCH_9293                     ; If A < 20 branch fwd
    BZS     BRANCH_9283                     ; If A = 20 branch fwd, A > 20 drop below
    BII	    (BRK_TOP_H),$01                 ; BREAK TOP (H)
    BZS     BRANCH_928D                     ; If Bit 0 was set branch fwd. A > 20
    CPI	    A,$41                           ; 41 = A
    BCR     BRANCH_928D                     ; If A < 41 branch fwd
    CPI	    A,$5B                           ; 5B = [
    BCS     BRANCH_928D                     ; If A >= 5B branch fwd
    CPI	    A,$49                           ; 49 = I
    BZR     BRANCH_92CA                     ; If A != 49 branch fwd (A >=41 & A < 5B)
    LDI	    XL,LB(TBL_9258)                 ; A = 49
    LDI	    XH,HB(TBL_9258)                 ; X = 9258 = TBL_9258
    SJP	    STRNG_2COM_ALT_E1               ; Sends string  from TBL_9258 to RS232. Alters A?
    BCH     BRANCH_92CA                     ; Unconditional fwd branch

BRANCH_9283: ; Branched to from 9266        ; A = 20 
    BII	    (BRK_TOP_H),$02                 ; BREAK TOP (H)
    BZS     BRANCH_92E2                     ; If Bit 1 was not set
    LDI	    UL,$0C                          ;
    BCH     BRANCH_92E2                     ; Unconditional fwd branch

BRANCH_928D: ; Branched to from 926C, 9270, 9274    ; BREAK TOP (H) BIt 0 set, (A > 20) | (A < 41 & A >= 5B)
    ANI	    (BRK_TOP_H),$FD                 ; Clear Bit 1. BREAK TOP (H)
    BCH     BRANCH_92E2                     ; Unconditional fwd branch

BRANCH_9293: ; Branched to from 9264        ; If A < 20. 0 - 0C = F4. 1A - 0C = 0E
    SBI	    A,$0C                           ; 0C - 0C = 0. 0C = Form Feed
    BZS     BRANCH_92BB                     ; If A was = to 0C branch fwd
    INC	    A                               ; A = F5 to A = 0F
    BZS     BRANCH_92CE                     ; If A was = 0B branch. 0B = Vert Tab
    ADI	    A,$04                           ; A = A + 04. A = F9 to 13
    BZR     BRANCH_92A7                     ; If A was != 7
    BII	    (BRK_TOP_H),$01                 ; BREAK TOP (H). A = 7
    BZR     BRANCH_92CE                     ;
    JMP	    JMP_94F4                        ; Not sure?

BRANCH_92A7: ; Branched to from 929C        ; A = F9 to 13 
    INC	    A                               ; A = FA to 14
    BZR     BRANCH_92AD                     ; If A was != FF
    JMP	    JMP_94BA                        ; A = 0. Looks like it resets some PC-1500 stuff

BRANCH_92AD: ; Branched to from 92A8
    CPI	    A,$14                           ; A = FA to 14 except 0
    BZR     BRANCH_92CE                     ; If A != 14 branch fwd
    LDA	    (BRK_TOP_H)                     ; BREAK TOP (H) (A was = 14 above)
    EAI	    $01                             ; A = A ^ 01, toggle bit 0
    STA	    (BRK_TOP_H)                     ; BREAK TOP (H)
    BCH     BRANCH_92D2                     ; Unconditional fwd branch

BRANCH_92BB: ; Branched to from 9295        ; A was = 0C, A now = 0
    BII	    (BRK_TOP_H),$02                 ; BREAK TOP (H)
    BZR     BRANCH_92CE                     ;
    ORI	    (BRK_TOP_H),$02                 ; BREAK TOP (H)
    BCH     BRANCH_92E2                     ; Unconditional fwd branch
    SJP	    SUB_98E8                        ;

BRANCH_92CA: ; Branched to from 9278, 9281, 95BD    ; (A >=41 & A < 5B)
    ANI	    (BRK_TOP_H),$FD                 ; Clear Bit 1. BREAK TOP (H)

BRANCH_92CE: ; Branched to from 9298, 92A2, 92AF, 92BF
    ANI	    (BRK_TOP_H),$FE                 ; Clear Bit 0. BREAK TOP (H)

BRANCH_92D2: ; Branched to from 92B9
    RIE                                     ; Disable interrupts
    LDI	    XL,$B0                          ; X = 92B0
    SJP	    SUB_9845                        ; Shifts display left one charecter
    ADI	    (ERR_ADD_L),$FF                 ; (ERR_ADD_L) = (ERR_ADD_L) + FF. ERROR ADDRESS (L)
    SIE                                     ; Enable interrupts

BRANCH_92DF: ; Branched to from 930A
    JMP	    SUB_PRINT_NUM_ALT_X1               ;


BRANCH_92E2: ; Branched to from 9287, 928B, 92C5,  
    ANI	    (BRK_TOP_H),$FE                 ; Clear Bit 0, BREAK TOP (H)
    LDA	    (ERR_LINE_H)                    ; HB of line where error occured
    STA	    (ERR_LINE_L)                    ; LB of line where error occured
    SHL                                     ; A = A << 1. Thru Carry, 0 carried in to LSB
    BCR     BRANCH_930E                     ; If Bit 7 was not set
    SHL                                     ; A = A << 1. Thru Carry, 0 carried in to LSB
    BCR     BRANCH_930E                     ; If Bit 6 was not set
    CPI	    UL,$20                          ; 20 = Space. UL = INPUT BUFFER Byte 0 from 9261
    BCS     BRANCH_9306                     ; Branch fwd if UL >= 20
    CPI	    UL,$0D                          ; 0D = CR
    LDI	    UL,$20                          ; LDI UL changes no flags
    BZR     BRANCH_9306                     ; If UL != 0D branch. 0D = CR
    LDI	    UL,$0D                          ; 
    BII	    (CRLF_REG),$10                  ; 
    BZS     BRANCH_9306                     ; If Bit 4 was not set branch
    LDI	    UL,0A                           ; A = Line Feed

BRANCH_9306: ; Branched to from 92F4 (UL >= 20), 92FA (UL = 20), 9302 (UL = 0D), drop (UL = 0A)
    LDA	    UL                              ; 
    SJP	    CHAR2LPT                        ; Sends charecter in A to LPT
    BCS     BRANCH_92DF                     ;  If sub failure JMP SUB_PRINT_NUM_ALT_X1
    BCH     BRANCH_9331                     ; Unconditional fwd branch

BRANCH_930E: ; Branched to from 92ED, 92F0
    ANI	    (FORNXT_STK_PTR),$00            ; clear FOR, NEXT stack pointer

BRANCH_9312: ; Branced to from 938E, 
    SDP                                     ; Sets LCD ON/OFF control flip-flop
    LDA	    UL                              ; UL >=20 or UL = 20 or UL = 0D or UL = 0A
    STA	    (ARZ)                           ; Math reg Z
    SJP	    SUB_9A9E                        ; jump code, A indexs into unknown table at X = 92B0?, sets PC
                                            ; probably does not return

;------
; Nonsense
DATA_931B:
    .BYTE   $18,$12,$11,$1A,$08,$18,$01,$16


;9323
    SJP	    SUB_9B2C                        ; Copies something from TBL_8475 into system RAM
    BCH     BRANCH_9342                     ; Unconditional branch fwd

    LDI	    XL,LB(ARX)                      ;
    LDI	    XH,HB(ARX)                      ; X=7A00
    SIN	    X                               ; (X) = A. Then X = X + 1. A = UH * 4 frm SUB_9B2C
    BCH     BRANCH_9342                     ; Unconditional branch fwd

    LDI	    UH,$01                          ;


BRANCH_9331: ; Branched to from 9369
    JMP	    BRANCH_9472                     ;


    LDI     A,$20                           ;
    STA	    (ARZ)                           ;
    STA	    UH                              ; UH = 20
    LDI	    A,$00                           ;  A = 00
    SJP	    SUB_9976                        ; Copies code from 8684 + A to System RAM 7A50
    SJP	    (B_STACK + $18)                 ; Call the code just poked in

BRANCH_9342: ; Branched to from 9326, 932D
    INC	    X                               ; INC X here for BRANCH_9390
    LDA	    (FORNXT_STK_PTR)                ; FOR, NEXT stack pointer
    BZR     BRANCH_9390                     ;
    LDA	    (GOSB_STK_PTR_L)                ; GOSUB pointer
    BZS     BRANCH_9390                     ;
    LDA	    (BAS_PENOP_STK_L)               ; Pointer operations
    STA	    XH                              ;
    LDA	    (STR_BUF_PTR_L)                 ; String buffer pointer
    STA	    XL                              ;
    LDA	    (BAS_DATA_STK_L)                ; Data pointer
    SEC                                     ; Set Carry
    SBI     A,$E6                           ; A = A - E6
    ADR	    X                               ; X = X + A
    LDA	    (ARZ)                           ; Math_REG_Za_B1
    STA	    (X)                             ;
    ADI	    (BAS_DATA_STK_L),$01            ; (BAS_DATA_STK_L) = (BAS_DATA_STK_L) + 1. Data pointer
    BCS     BRANCH_936B                     ; If (BAS_DATA_STK_L) was FF
    CPI	    A,$20                           ; 
    BZR     BRANCH_9331                     ;

BRANCH_936B: ; Branched to from 9365
    SJP	    SUB_98E8                        ; Blinks cursor and displays something on LCD?

JMP_936E: ; Jumped to from JMP_90B1:90E5
    LDA	    (BAS_DATA_STK_L)                ; Data pointer
    SEC                                     ; Set carry
    SBI	    A,$E6                           ; A = A - E6
    STA	    (FORNXT_STK_PTR)                ; FOR, NEXT stack pointer
    ANI	    (BAS_DATA_STK_L),$00            ; Data pointer

BRANCH_937B: ; Branched to from 9464
    LDA	    (BAS_PENOP_STK_L)             ; Pointer operations
    STA	    XH                              ;
    LDA	    (STR_BUF_PTR_L)                 ; String buffer pointer
    STA	    XL                              ;
    LDA	    (BAS_DATA_STK_L)                ; Data pointer
    ADI	    (BAS_DATA_STK_L),$01            ; (BAS_DATA_STK_L) = (BAS_DATA_STK_L) + 1. Data pointer
    ADR	    X                               ; X = X + A
    LDA	    (X)                             ; A = (X)
    STA	    UL                              ;
    BCH     BRANCH_9312                     ; Unconditional branch back

BRANCH_9390: ; Branched to from 9346, 934B
    LDA	    (CURS_POS_NBUF_H)               ; Blink cursor position (H)
    CPI	    A,$77                           ;
    BCR     BRANCH_943C                     ; If A < 77
    BII	    (ERR_LINE_H),$08                ;
    BZS     BRANCH_93B8                     ; If Bit 7 not set
    LDA	    (GOSB_STK_PTR_L)                ; GOSUB pointer
    BZR     BRANCH_93B8                     ; If (GOSB_STK_PTR_L) != 0
    LDA	    (CURS_POS_NBUF_L)               ; Blink cursor position (L)
    CPI	    A,$06                           ;
    BCR     BRANCH_93B8                     ; If A < 06
    LDA	    (ARZ)                           ;
    CPI	    A,$20                           ;
    BZR     BRANCH_93B8                     ; If A != 20
    LDI	    A,$E6                           ;
    STA	    (BAS_DATA_STK_L)                ; Data pointer
    STA	    (GOSB_STK_PTR_L)                ; GOSUB pointer

BRANCH_93B8: ; Branched to from 939B, 93A0, 93A7, 93AE
    LDI	    A,$42                           ;
    SEC                                     ; Set carry for subtrction below
    SBC	    XL                              ; A = A - XL
    SBC	    XL                              ; A = A - XL
    SBC	    (CURS_POS_NBUF_L)               ; A = A - (CURS_POS_NBUF_L). Blink cursor position (L)
    BCS     BRANCH_943C                     ; If A < 0
    STA	    UH                              ;
    LDI	    UL,$FF                          ;
    LDA	    (SRCH_TOP_L)                    ; SEARCH TOP (L)
    STA	    XL                              ;
    LDA	    (SRCH_TOP_H)                    ; SEARCH TOP (H)
    STA	    XH                              ;

BRANCH_93CD: ; Branched to from 93E5
    LIN	    X                               ; A = (X) then INC X
    PSH	    A                               ;



;------------------------------------------------------------------------------------------------------------
; SUB_PRINT_NUM - 
; Updates the LCD
; Arguments: 
; Output: 
; RegMod: U, A, X
SUB_PRINT_NUM: ; 93D0 Called through vector at 8335
    SJP	    SUB_9912_ALT2                   ; Loads PREVIOUS ADDRESS into X
    POP	    A                               ;
    SHL                                     ; A = A << 1. Through Carry, 0 into LSB
    BCR     BRANCH_93E9                     ; If bit 7 was not set fwd
    LDA	    (DATA_PTR_H)                    ; DATA POINTER (H)
    BZS     BRANCH_93E9                     ; If DATA_POINTER_H zero branch fwd
    ADI	    (CURS_POS_NBUF_L),$FE           ; Blink cursor position (L)
    INC	    UL                              ; What is U?
    INC	    UL                              ;
    INC	    UH                              ;
    BCR     BRANCH_93CD                     ; If Carry not set branch back, i.e. did not overflow
    BCH     BRANCH_93F1                     ; Branch FWD unconditional

BRANCH_93E9: ; Branced to from 93D6, 93DB
    ADD	    (CURS_POS_NBUF_L),$F4           ; (CURS_POS_NBUF_L) = (CURS_POS_NBUF_L) + F4. Blink cursor position (L)
    LDI	    A,$0B                           ; A = 0B
    ADC	    UL                              ; A = A + UL
    STA	    UL                              ; UL = A

BRANCH_93F1: ; Bracned to from 93E7
    LDA	    XL                              ; Transfers X from SUB_991E
    STA	    (SRCH_TOP_L)                    ; SEARCH TOP (L)
    LDA	    XH                              ;
    STA	    (SRCH_TOP_H)                    ; SEARCH TOP (H)
    LDA	    UL                              ;
    PSH	    A                               ; 
    LDI	    UH,$76                          ;
    LDI	    XL,LBO(STRING_VARS,$FE)         ;
    LDI	    XH,HBO(STRING_VARS,$FE)         ; X = 774E
    ADR	    X                               ; X = X + A

; I think this section is updating the LCD
BRANCH_9404: ; Branced to from 9409         ; copying U -> X. 76## -> 774E. U is display block
    LDA	    (U)                             ; A = (U). U > 760B, X = 774E
    ANI	    A,$F0                           ; Mask off low nibble
    AEX                                     ; Swap high and low bytes of accumulator
    SDE	    X                               ; (X) = A. X = X - 1
    LOP	    UL,BRANCH_9404                  ; UL=UL-1, if borrow flag not set loop back to 9404
    POP	    A                               ;
    STA     UH                              ;
    STA	    XL                              ;
    LDI	    XH,$76                          ;
    INC	    XL                              ;
    LDI	    A,$4E                           ;
    SBC	    XL                              ; A = A - XL
    STA	    UL                              ;
    LDI	    YL,LB(DISP_BUFF)                ;
    LDI	    YH,HB(DISP_BUFF)                ; Y = 7600, display block

BRANCH_941A: ; Branched to from 941B        ; Copying X -> Y. 76## -> 7600
    TIN                                     ; (Y) = (X) then X = X + 1, Y = Y + 1
    LOP	    UL,BRANCH_941A                  ; UL = UL - 1, if Carry not set loop back to 941A
    LDA	    UH                              ;
    STA	    UL                              ;
    PSH	    A                               ;
    LDI	    UH,$77                          ;
    LDI	    XL,LBO(DISP_BUFF,$4D)           ;
    LDI	    XH,HBO(DISP_BUFF,$4D)           ; X = 764D

BRANCH_9427: ; Branched to from 9429        ; U -> X. 77## -> 764D
    LDA	    (U)                             ; A = (U)
    SDE	    X                               ; (X) = A. X = X - 1
    LOP	    UL,BRANCH_9427                  ; UL = UL - 1, if Carry not set loop back to 9427
    POP	    A                               ;
    STA	    XL                              ; XL = A
    INC	    XL                              ;
    LDI	    XH,$77                          ;
    LDI	    UL,$4D                          ;
    LDI	    YL,LBO(STRING_VARS,$B0)         ;
    LDI	    YH,HBO(STRING_VARS,$B0)         ; Y = 7700 Writing to screen?

BRANCH_9437: ; Branched to from 9438        ; X -> Y. X = 77## Y = 7700
    TIN                                     ; (Y) = (X) then X = X + 1, Y = Y + 1
    LOP	    UL,BRANCH_9437                  ; UL = UL - 1, if Carry not set loop back to 9437
    LDI	    UH,$00                          ;

BRANCH_943C: ; Branched to from 9395, 93C0
    LDI	    UL,$05                          ; U = 0005
    BII	    (ARZ),$80                       ; Keep Bit 7
    BZS     BRANCH_944B                     ; If Bit 7 was not set
    LDA	    (DATA_PTR_H)                    ; DATA POINTER (H)
    BZS     BRANCH_944B                     ; If (DATA_PTR_H) = 0
    LDI	    UL,$00                          ;

BRANCH_944B: ; Branched to from 9442, 9447
    SJP	    SUB_98C3                        ; Something related to the display
    LDA	    XL                              ;
    STA	    (CURS_POS_NBUF_L)               ; (CURS_POS_NBUF_L) = A. Blink cursor position (L)
    LDA	    XH                              ;
    STA	    (CURS_POS_NBUF_H)               ; (CURS_POS_NBUF_H) = A. Blink cursor position (H)
    SJP	    SUB_9900                        ; Something related to the display
    LDA	    (FORNXT_STK_PTR)                ; FOR, NEXT stack pointer
    BZS     BRANCH_9472                     ; If (FORNXT_STK_PTR) = 0
    ADI	    (FORNXT_STK_PTR),$FF            ; (FORNXT_STK_PTR) = (FORNXT_STK_PTR) + FF. FOR, NEXT stack pointer
    BZS     BRANCH_9466                     ; If (FORNXT_STK_PTR) was = 1
    BCH     BRANCH_937B                     ; Unconditional branch back

BRANCH_9466: ; Branched to from 9462
    LDA	    (GOSB_STK_PTR_L)                ; GOSUB pointer
    ANI	    (GOSB_STK_PTR_L),$00            ; Clear GOSUB pointer
    INC	    A                               ;
    BZR     BRANCH_9472                     ; If (GOSB_STK_PTR_L) was != 0
    BCH     BRANCH_94A8                     ; Unconditional branch fwd

BRANCH_9472: ; Branched to from 9331, 945C, 946E 
    RIE                                     ; Disable interrupts
    LDI     XL,$B0                          ;
    SJP	    SUB_9845                        ; Shifts display left one charecter
    ADI	    (ERR_ADD_L),$FF                 ; ERROR ADDRESS (L)
    SIE                                     ; Enable interrupts
    SJP	    SUB_9933                        ; Not sure what this does
    LDA	    UH                              ;
    CPI	    A,$20                           ;
    BCR     BRANCH_948F                     ; If A < 20
    BII	    (BRK_TOP_H),$02                 ; BREAK TOP (H)
    BZS     BRANCH_948F                     ; If Bit 1 was not set
    LDI	    A,$0C                           ;

BRANCH_948F: ; Branched to from 947F, 9485
    STA	    (X)                             ;
    BII	    (DISP_BUFF + $4F),$10                ;
    BZR     BRANCH_94AB                     ; If Bit 4 was set
    BII	    (DISP_BUFF + $4F),$20                ;
    BZS     BRANCH_94A8                     ; If Bit 5 was set
    ADI	    (BRK_LINE_L),$01                ; (BRK_LINE_L) = (BRK_LINE_L) + 1. BREAK LINE (L)
    BCR     BRANCH_94A8                     ; If (BRK_LINE_L) was = FF
    ADI	    (BRK_LINE_H),$01                ; (BRK_LINE_H) = (BRK_LINE_H) + 1.BREAK LINE (H)
    BCS     BRANCH_94B4                     ; If (BRK_LINE_H) was = FF

BRANCH_94A8: ; Branched to from 9470, 949A, 94A0, 94AD
    JMP	    SUB_PRINT_NUM_ALT_X1               ; An exit?

BRANCH_94AB: ; Branced to from 9494
    CPI	    A,$0D                           ;
    BZR     BRANCH_94A8                     ; If A != 0D

BRANCH_94AF: ; Branched to from 94B8
    LDI	    A,$01                           ;
    JMP	    JMP_967B                        ; Twiddles LCD annunciators and other stuff.

BRANCH_94B4: ; Branched to from 94A6
    ORI	    (BRK_LINE_H),$FE                ; Set all but Bit 0. BREAK LINE (H)
    BCH     BRANCH_94AF                     ; Unconditional branch back

JMP_94BA: ; Jumped to from 92AA
    LDI	    UL,$11                          ;
    LDI	    A,$5B                           ;
    RIE                                     ; Disable Interrupts
    STA	    #(PC1500_F_REG)                 ; PC-1500 - Loader Divider to F Register

BRANCH_94C4: ; Branched to from 94D2, 94F0
    BII     #(PC1500_PRT_B),$20             ; Pin 5 - Timer control
    BZS     BRANCH_94D4                     ; If Pin 5 was not set
    BII     #(PC1500_IF_REG),$03            ; PC-1500 - IRQ and PB7 (power button) flags
    BZR     BRANCH_94E5                     ; If Bits 0 or 1 set 
    BCH     BRANCH_94C4                     ; Unconditional branch back

BRANCH_94D4: ; Branched to from 94C9
    DEC	    UL                              ; 
    BCR     BRANCH_94E5                     ; If UL was = 0

BRANCH_94D7: ; Branched to from 94E3
    BII     #(PC1500_PRT_B),$20             ; Pin 5 - Timer control
    BZR     BRANCH_94F0                     ; If Bit 5 was set
    BII     #(PC1500_IF_REG),$03            ; PC-1500 - IRQ and PB7 (power button) flags
    BZS     BRANCH_94D7                     ; If Bits 0 or 1 not set

BRANCH_94E5: ; Branched to from 94D0, 94D5, 94F2
    LDI	    A,$00                           ;
    STA	    #(PC1500_F_REG)          ; PC-1500 - Loader Divider to F Register
    SIE                                     ; Enable interrupts

BRANCH_94ED: ; Branched to from 950F, 9518
    JMP	    BRANCH_92CE                     ; SUB_PRINT_NUM_ALT_E1

BRANCH_94F0: ; Branched to from 94DC
    LOP	    UL,BRANCH_94C4                  ;
    BCH     BRANCH_94E5                     ;



;------------------------------------------------------------------------------------------------------------
; JMP_94F4 - Jumped to from SUB_PRINT_NUM_ALT_E1:92A4
; Note sure what it does
; Arguments: 
; Output: 
; RegMod: A, X, Y
JMP_94F4:
    LDA	    (GOSB_STK_PTR_L)                ; GOSUB pointer
    BZS     BRANCH_950A                     ; If (GOSB_STK_PTR_L) = 0 branch fwd
    LDI	    A,$E6                           ;
    CPA	    (BAS_DATA_STK_L)                ; Data pointer
    BCS     BRANCH_9506                     ; If A >= (BAS_DATA_STK_L)
    ADI	    (BAS_DATA_STK_L),$FF            ; Set to FF and set carry?
    BCH     BRANCH_950A                     ; Unconditional branch fwd


BRANCH_9506: ; Branched to from 94FE
    ANI	    (GOSB_STK_PTR_L),$00            ; clear GOSUB pointer

BRANCH_950A: ; Branched to from 94F7, 9504
    LDA	    (SRCH_LINE_H)                   ; SEARCH LINE (H)
    STA	    XH                              ;
    SHL                                     ; A = A << 1. Thru carry
    BCS     BRANCH_94ED                     ; If Bit 7 was set
    LDA	    (SRCH_LINE_L)                   ; SEARCH LINE (L)
    STA	    XL                              ;
    STX     Y                               ; Transfered SRCH_LINE_H, SRCH_LINE_L to Y
    LDE	    X                               ; A = (X) then X = X - 1
    BZS     BRANCH_94ED                     ; If A = Zero
    SEC                                     ; Set Carry Flag
    LDA	    XL                              ;
    SBC	    (PREV_ADD_L)                    ; A = A - (PREV_ADD_L). PREVIOUS ADDRESS (L)
    LDA	    XH                              ;
    SBC	    (PREV_ADD_H)                    ; A = A - (PREV_ADD_H). PREVIOUS ADDRESS (H)
    BCS     BRANCH_952D                     ; Carry from subtraction
    LDA	    (PREV_TOP_L)                    ; PREVIOUS TOP (L)
    STA	    XL                              ;
    LDA	    (PREV_TOP_H)                    ; PREVIOUS TOP (H)
    STA	    XH                              ;

BRANCH_952D: ; Branched to from 9523
    LDA	    (X)                             ;
    BZR     BRANCH_9544                     ; If A not zero branch fwd
    ORI	    (SRCH_LINE_H),$80               ; Set Bit 7. SEARCH LINE (H)
    LDA	    YL                              ;
    STA	    (ON_ERR_LINE_L)                 ; ON ERROR LINE (L)
    STA	    (SRCH_ADD_L)                    ; SEARCH ADDRESS (L)
    LDA	    YH                              ;
    STA	    (ON_ERR_LINE_H)                 ; ON ERROR LINE (H)
    STA	    (SRCH_ADD_H)                    ; SEARCH ADDRESS (H)
    BCH     BRANCH_9560                     ; Unconditional branch fwd
 

BRANCH_9544: ; Branched to from 952E
    LDA	    YL                              ;
    CPA	    (ON_ERR_LINE_L)                 ; ON ERROR LINE (L)
    BZR     BRANCH_9558                     ; If YL != (ON_ERR_LINE_L)
    LDA	    YH                              ;
    CPA	    (ON_ERR_LINE_H)                 ; ON ERROR LINE (H)
    BZR     BRANCH_9558                     ; If YH != (ON_ERR_LINE_H) 
    LDA	    XL                              ;
    STA	    (ON_ERR_LINE_L)                 ; ON ERROR LINE (L)
    LDA	    XH                              ;
    STA	    (ON_ERR_LINE_H)                 ; ON ERROR LINE (H)

BRANCH_9558: ; Branched to from 9548, 954E
    LDA	    XL                              ;
    STA	    (SRCH_LINE_L)                   ; SEARCH LINE (L)
    LDA	    XH                              ;
    STA	    (SRCH_LINE_H)                   ; SEARCH LINE (H)

BRANCH_9560: ; Branched to from 9542
    LDA	    (Y)                             ;
    ANI	    (Y),$00                         ; Clear (Y)
    STA	    UL                              ;
    LDA	    (ERR_LINE_H)                     ;
    SHL                                     ; A  = A << 1. Thru carry
    BCR     BRANCH_9584                     ; If Bit 7 was not set
    LDI	    UL,$5C                          ;

BRANCH_956C: ; Branched to from 9577, 957F
    LDA	    UL                              ;
    SJP	    CHAR2LPT                        ; Sends charecter in A to LPT
    BCR     BRANCH_95BD                     ; If sub success
    BZR     BRANCH_957B                     ; If sub fail with A != 0?
    SJP	    SUB_9B47                        ; May return or poke new address into Stack Pointer
    BCH     BRANCH_956C                     ; Unconditional branch back
    BCH     BRANCH_95BD                     ; Unconditional branch fwd, why both here?


BRANCH_957B: ; Branched to from 9572
    ADI	    (OUTSTAT_REG),$10               ; (OUTSTAT_REG) = (OUTSTAT_REG) + 10
    BCR     BRANCH_956C                     ; If we did not carry out
    JMP	    JMP_8CFD                        ; Jumps on to SUB_8D04_ALT_E1


BRANCH_9584: ; Branched to from 9568
    LDI	    A,$F4                           ;
    CPI	    UL,$80                          ;
    BCR     BRANCH_9593                     ; If UL < 80
    REC                                     ; Reset Carry Flag
    BII	    (DATA_PTR_H),$FF                ; Used to set flags. DATA POINTER (H)
    BZS     BRANCH_9593                     ; If (DATA_PTR_H) = 00 branch fwd
    LDI	    A,$FE                           ;

BRANCH_9593: ; Branched to from 9588, 958F
    ADC	    (CURS_POS_NBUF_L)               ; A = A + (CURS_POS_NBUF_L). Blink cursor position (L)
    STA	    XL                              ;
    LDA	    (CURS_POS_NBUF_H)               ; Blink cursor position (H)
    STA	    XH                              ;
    BCS     BRANCH_95A7                     ; Carry set by ADC?
    LDI	    A,$4E                           ;
    ADC	    XL                              ; A = A + XL
    STA	    XL                              ;
    DEC	    XH                              ;
    CPI	    XH,$74                          ;
    BCR     BRANCH_95C0                     ; If XH < 74

BRANCH_95A7: ; Branched to from 959B
    PSH	    X                               ;
    SJP	    SUB_990C                        ; Converts AR-X to BCD (absolute) for display?
    LDI	    A,$00                           ;
    VMJ	    ($88)                           ; Converts AR-X to BCD (absolute) form
    SJP	    SUB_990C                        ; Converts AR-X to BCD (absolute) for display?
    POP	    X                               ;
    LDA	    XL                              ;
    STA	    (CURS_POS_NBUF_L)               ; Blink cursor position (L)
    LDA	    XH                              ;
    SJP	    SUB_98FD                        ; Converts AR-X to BCD (absolute) for display?

BRANCH_95BD: ; Branched to from 9570, 9579, 95C3
    JMP	    BRANCH_92CA                     ; in SUB_PRINT_NUM_ALT_E1

BRANCH_95C0: ; Branched to from 95A5
    SJP	    SUB_98E8                        ; Converts AR-X to BCD (absolute) for display?
    BCH     BRANCH_95BD                     ; Unconditional back branch



;---------------
UNKNOWN_95C5: ; Not used???
    .BYTE $9E



;------------------------------------------------------------------------------------------------------------
; SUB_9600 - Entry at 9600 
; SUB_95C6 - Called from 8E91
; Might display text for terminal program?
; Arguments: 
; Output: 
; RegMod: A, X, Y, UL
SUB_95C6:
    BII	    (DISP_BUFF+$4E),$01             ; LCD (Busy) Annunciator
    BZS     BRANCH_960F                     ; Bit 0 not set
    LDI	    A,$01                           ; 
    EOR	    (DISPARAM)                      ; Toggle Bit 0. Display parameter. Bit 7 = 1 is BREAK.
    STA	    (DISPARAM)                      ; Display parameter. Bit 7 = 1 is BREAK.
    SHR                                     ; A = A >> 1.
    BCR     BRANCH_95FD                     ; If we did not shift Bit 0 out
    SJP     SAVELCD2BUF                     ; Cache LCD in buffer

BRANCH_95DA: ; Branched to from 960D
    LDA	    (DISP_BUFF + $4E)               ; LCD annunciators
    SHR                                     ; A = A >> 1, x 7 6 5 4 3 2 1
    LDI	    XH,HB(TEXT_8635)                ;
    LDI     XL,LB(TEXT_8635)                ; X = 8635 = TEXT_8635 Text for terminal program?
    BHS     BRANCH_95ED                     ; Branch if half carry, original Bit 4 (DEFIII), set 
    SHR                                     ; A = A >> 1, x x 7 6 5 4 3 2. Might set carry from (Shift)
    LDI	    A,$1A                           ; Only changes Z flag
    ADR	    X                               ; X = X + A + C (if SHIFT). X = 8635 + 1A + C (if SHIFT) = 864F
    BHS     BRANCH_95ED                     ; Branch if half carry
    VMJ	    ($38)                           ; Determines reserve memory type adress + 8 and stores in X. 
                                            ; Sets C=0 if 2nd reserve memory area is occupied 

BRANCH_95ED: ; Branched to from 95E2, 95E9
    LDI	    UL,$19                          ;   
    LDI	    YL,LB(ARY)                      ;
    LDI	    YH,HB(ARY)                      ; Y = 7A10 ARY

BRANCH_95F3: ; Branched to from 95F4
    TIN                                     ; (Y) = (X) then X = X + 1, Y = Y + 1
    LOP	    UL,BRANCH_95F3                  ;
    LDX	    Y                               ;
    ANI	    (X),$00                         ; zero (X)
    JMP	    TXT2LCD_ARY                     ; Text output on LCD from (AR-Y) to 7AXL

BRANCH_95FD: ; Branched to from 95D5
    JMP	    BUF2LCD                         ; Retransmit display from cache



;------------------------------------------------------------------------------------------------------------
; SUB_9600 - Called from to from 8E8C, 9616
; Updates LCD?
; Arguments: 
; Output: 
; RegMod: 
SUB_9600:
    SJP	    SUB_9E20                        ; Returns UL = 40 or 20 or 10 based on status of LCD annuniators
    BII	    (DISP_BUFF + $4E),$01           ; LCD (Busy) Annunciator
    BZS     BRANCH_960F                     ; If Bit 0 not set
    BII	    (DISPARAM),$01                  ; Display parameter. Bit 7 = 1 is BREAK.
    BZR     BRANCH_95DA                     ; If Bit 0 was set

BRANCH_960F: ; Branched to from 95CA, 9607
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; SUB_INPUT_NUM - Main entry at 9660 
; Alt entry at 9687 Called from SUB_8D04:8ED7, 9634
; 9610, 9616, 961B, 9630, 9642, 9647, 967B, 96C8 jumped to from JUMP_TBL_915F
; Arguments: 
; Output: 
; RegMod: A, UL
JMP_9610: ; Jumped to from JUMP_TBL_915F
    SJP	    SUB_95C6                        ; Might display text for terminal program?

BRANCH_9613: ; Branched to from 9619, 9845, 964F, 9655, 9661, 965A, 9678
    JMP	    UNKNOWN_JMP_9083                ; Changes LCD annunciators branches to SUB_PRINT_NUM_ALT_X1



;------------------------------------------------------------------------------------------------------------
; JMP_9616 - Jumped to from JUMP_TBL_915F
; Arguments: 
; Output: 
; RegMod:
JMP_9616:
    SJP	    SUB_9600                        ; Updates LCD?
    BCH     BRANCH_9613                     ; Unconditional branch back to exit



;------------------------------------------------------------------------------------------------------------
; JMP_961B -  Jumped to from JUMP_TBL_915F
; Arguments: 
; Output: 
; RegMod: UL, A
JMP_961B:
    STA	    UL                              ; What is A here?
    ANI	    A,$0F                           ;
    EOR	    (DISP_BUFF + $4F)                    ; Toggle - 0 (DE) 1 (G) 2 (RAD) 3 (vide) 
    STA	    (DISP_BUFF + $4F)                    ;
    LDA	    UL                              ; Get our A back
    ORI	    A,$70                           ; Set 4 (RESERVE) 5 (PRO) 6 (RUN)
    AND	    (DISP_BUFF + $4F)                    ; Clear any settings not in A
    STA	    (DISP_BUFF + $4F)                    ;
    JMP	    UNKNOWN_JMP_9087                ; Not sure?



;------------------------------------------------------------------------------------------------------------
; JMP_9630 - Jumped to from JUMP_TBL_915F
; Arguments: 
; Output: 
; RegMod:
JMP_9630:
    BII	    (DISP_BUFF + $4F),$20                ; Bit 5 = 2 (PRO)
    BZR     BRANCH_9642                     ; IF Bit 5 was set
    ANI	    (BRK_LINE_L),$00                ; Clear BREAK LINE (L)
    ANI	    (BRK_LINE_H),$00                ; Clear BREAK LINE (H)
    ORI	    (BRK_LINE_H),$FE                ; Bit 0 clear BREAK LINE (H)

BRANCH_9642: ; Branched to from 9634, Jumped to from JUMP_TBL_915F
    STA	    (DISP_BUFF + $4F)                    ; 0 (DE) 1 (G) 2 (RAD) 3 (vide) 4 (RESERVE) 5 (PRO) 6 (RUN) 7 (DEF)
    BCH     BRANCH_9613                     ; Exit



;------------------------------------------------------------------------------------------------------------
; JMP_9647 - Jumped to from JUMP_TBL_915F
; Arguments: 
; Output: 
; RegMod: A
JMP_9647:
    EOR	    (ERR_LINE_H)                    ; Flip 10110100
    SHL                                     ; A = A << 1. 
    BCR     BRANCH_9651                     ; If Bit 7 was not set
    BII	    A,$80                           ;
    BZS     BRANCH_9613                     ; If Bit 6, before shift, was set

BRANCH_9651: ; Branched to from 964B
    ROR                                     ; A = A >> 1. Rotated right through Carry
    STA	    (ERR_LINE_H)                    ; ERROR LINE (H)
    BCH     BRANCH_9613                     ; Unconditional branch back


JMP_9657: ; called via JUMP_TBL_915F
    AND	    (DISP_BUFF + $4E)               ; A = A & (HIGHLCDFGLAG). 0 (Busy), 1 (Shift), 2 (Katana), 3 (Small), 4 (DEFIII), 5 (DEFII), 6 (DEFI)
    BZS     BRANCH_9613                     ;
    LDA	    (ERR_LINE_H)                    ;
    BII	    A,$70                           ;



;------------------------------------------------------------------------------------------------------------
; SUB_INPUT_NUM -  Jumped to from 831C from Command Vector Table @ 8331
; Adjusts LCD annunciators, may parse or manipulate BASIC lines
; Arguments: 
; Output: 
; RegMod: A
SUB_INPUT_NUM:
    BZS     BRANCH_9613                     ; If A = 70
    ORI	    A,$80                           ; Set Bit 7
    STA	    (ERR_LINE_L)                    ; ERROR LINE (L)
    VEJ     (F4)                            ; Loads U-Reg with 16-bit value from address of (SRCH_LINE_H). SEARCH LINE
                AWRD(SRCH_LINE_H)           ;
    VEJ	    (CC)                            ; Loads X-Reg with address at 78(AA) 78(AB). SEARCH TOP
                ABYT($AA)                   ;
    BII	    (DISPARAM),$80                  ; Display parameter. Bit 7 = 1 is BREAK.
    BZR     BRANCH_9675                     ; If Bit 7 set
    VEJ	    (CC)                            ; Loads X-Reg with address at 78(A0) 78(A1). PREVIOUS ADDRESS
                ABYT($A0)                   ;

BRANCH_9675: ; Branched to from 9671
    SJP     SUB_9B95_ALT_E1                 ;
    BCH     BRANCH_9613                     ;    Uncondional branch back


; 967A - not reached ?
    SBC	    XL                              ; A = A = XL

JMP_967B: ; Jumped to from SUB_PRINT_NUM:94B1, JUMP_TBL_915F
    EOR	    (DISP_BUFF + $4E)               ; A = A ^ (DISP_BUFF+$4E). 0 (Busy), 1 (Shift), 2 (Katana), 3 (Small), 4 (DEFIII), 5 (DEFII), 6 (DEFI)
    STA	    (DISP_BUFF + $4E)               ; 0 (Busy), 1 (Shift), 2 (Katana), 3 (Small), 4 (DEFIII), 5 (DEFII), 6 (DEFI)
    SHR                                     ; A = A >> 1
    BCS     BRANCH_96B1                     ; If Bit 0 was set
    SJP     SUB_9D39                        ; Not sure?

SUB_INPUT_NUM_ALT_E1: ; Called from SUB_8D04:8ED7
    VMJ	    ($8C)                           ; Calculated in X-Reg matrix column address from matrix pointer
    VEJ     (CA)                            ; Transfers X to 78(7E), 78(7F). Blink cursor position
                ABYT($7E)                   ;
    ANI	    #(CE150_MSK_REG),$FD            ; Clear bits 1. PB7 (Paper feed switch) interrupt mask. 
    SJP     SUB_9900                        ; Converts AR-X to BCD (absolute) form?
    SJP     SUB_9912                        ; Manipulates PREVIOUS TOP and SEARCH LINE
    VEJ     (CA)                            ; Transfers X to 78(CA), 78(CB)
                ABYT($BA)                   ;
    LDA	    (ERR_ADD_L)                     ; ERROR ADDRESS (L)
    CPI     A,$B1                           ;
    BCS     BRANCH_96A2                     ; If A >= B1 Branch fwd
    SJP     SUB_99EC                        ; Sends charecter to RS232 Port?

BRANCH_96A2: ; Branched to from 969D
    ANI	    (DISP_BUFF + $4E),$FE           ; Clear Bit 0 (Busy)
    ANI	    (DISPARAM),$00                  ; Clear Display parameter. Bit 7 = 1 is BREAK.
    ANI	    (GOSB_STK_PTR_L),$00            ; Clear GOSUB pointer
    JMP	    SUB_PRINT_NUM_ALT_E1            ; 


BRANCH_96B1: ; Branched to from 9682
    SJP     SUB_9B95                        ; Not sure
    SJP     SUB_9852                        ; Not sure
    SJP     SUB_9FEF                        ; CE-150 - Clears Pen Descending signal, and applies it again if safe.
    ANI	    (DISPARAM),$00                  ; Clear Display parameter. Bit 7 = 1 is BREAK.
    ORI	    (DISP_BUFF + $4E),$01           ; Set Bit 1 (Busy)

BRANCH_96C2: ; Branched to from 971B
    SJP     SUB_9D39                        ; Not sure?

BRANCH_96C5: ; Brabched to from 96D6, 96DC, 96F3
    JMP	    UNKNOWN_JMP_9083                ; Changes LCD annunciators branches to SUB_PRINT_NUM_ALT_X1


JMP_96C8: ; Jumped to from JUMP_TBL_915F
    AND	    (DISP_BUFF + $4E)               ; 0 (Busy), 1 (Shift), 2 (Katana), 3 (Small), 4 (DEFIII), 5 (DEFII), 6 (DEFI)
    BZR     BRANCH_96FC                     ;
    ANI	    (DISPARAM),$00                  ; Clear Display parameter. Bit 7 = 1 is BREAK.
    LDA	    (ERR_LINE_H)                    ;
    CPI     A,$C0                           ;
    BCS     BRANCH_96C5                     ; If A >= C0 branch back
    BII	    (DISP_BUFF + $4F),$10           ; Bit 4 (RESERVE)
    BZR     BRANCH_96C5                     ; If Bit 4 was set branch back
    SJP     SUB_9B95                        ; Not sure?
    SJP     SUB_9852                        ; Not sure?
    ORI	    (DISP_BUFF + $4E),$01           ; Set Bit 0 (BUSY)

BRANCH_96E8: ; Branched to from 96FF, 970B, 9714
    VEJ	    (CC)                            ; Loads X-Reg with address at 78(A0) 78(A1). PREVIOUS ADDRESS
                ABYT($A0)                   ;
    VEJ	    (F4)                            ; Loads U-Reg with 16-bit value from address of (SRCH_LINE_H)
                AWRD(SRCH_LINE_H)           ;
    SJP     SUB_9FEF                        ; CE-150 - Clears Pen Descending signal, and applies it again if safe.
    SJP     (U_MINUS_X )                    ; U = U - X, When upper limit occurs: C=0 and UH=16
    BCR     BRANCH_96C5                     ; Carry returned from sub
    LDI	    A,$80                           ;
    STA	    (DISPARAM)                      ; Display parameter. Bit 7 = 1 is BREAK.
    BCH     BRANCH_9793                     ; Unconditional brach fwd


BRANCH_96FC: ; Branched to from 96CB
    LDA	    (DISPARAM)                      ; Display parameter. Bit 7 = 1 is BREAK.
    BZS     BRANCH_96E8                     ; If A = 0 branch back
    SHR                                     ; A = A >> 1
    BCR     BRANCH_970B                     ; If Bit 0 was not set
    SJP     BUF2LCD                         ; Retransmit display from cache
    ANI	    (DISPARAM),$FE                  ; Display parameter. Bit 7 = 1 is BREAK.

BRANCH_970B: ; Branched to from 9702
    BZS     BRANCH_96E8                     ; 
    LDA	    (USINGM)                        ; USING M integer part
    CPI     A,$9B                           ; 
    BCR     BRANCH_971D                     ; If A < 9B branch fwd
    BZS     BRANCH_96E8                     ; If A > 9B branch back
    LDI	    A,$80                           ; If A = 9B poke 80 into DISPARAM
    STA	    (DISPARAM)                      ; Display parameter. Bit 7 = 1 is BREAK.
    BCH     BRANCH_96C2                     ; Unconditional branch fwd


BRANCH_971D: ; Branched to from 9712
    SHR                                     ; A = A >> 1. A = (USINGM) = USING M integer part
    BCS     BRANCH_9726                     ; If Bit 0 was set
    SHR                                     ; A = A >> 1.
    BCS     BRANCH_976E                     ; If Bit 1 was set
    SHR                                     ; A = A >> 1.
    BCS     BRANCH_976E                     ; If Bit 2 was set

BRANCH_9726: ; Branched to from 971E
    VEJ	    (F4)                            ; Loads U-Reg with 16-bit value from address of (SRCH_TOP_H)
                AWRD(SRCH_TOP_H)            ;
    VEJ	    (CC)                            ; Loads X-Reg with address at 78(A0) 78(A1). PREVIOUS ADDRESS
                ABYT($A0)                   ;
    SJP     (U_MINUS_X - $01)               ; U = U - X - 1. When upper limit occurs: C=0 and UH=16
    BCR     BRANCH_974A                     ;
    VEJ	    (CC)                            ; Loads X-Reg with address at 78(AA) 78(AB). SEARCH TOP
                ABYT($AA)                   ;
    DEC	    X                               ;
    BII	    (KEY_LAST),$01                  ; Last pressed key code
    BZR     BRANCH_975D                     ; If last key > 0
    LDA	    (X)                             ;
    CPI     A,$0D                           ; 0D = CR
    BZS     BRANCH_975D                     ; If A = 0D branch fwd
    CPI     A,$20                           ; 20 = Space
    BZS     BRANCH_975D                     ; If A = 20 branch fwd
    ANI	    (BRK_TOP_L),$00                 ; BREAK TOP (L)
    SEC                                     ; Set Carry Flag
    SJP     SUB_9D4B                        ; Not sure

BRANCH_974A: ; Branched to from 972E, 9776, 9796, 97AD
    JMP	    UNKNOWN_JMP_9083                ; Changes LCD annunciators branches to SUB_PRINT_NUM_ALT_X1


BRANCH_974D: ; Branched to from 975D, 9761
    DEC	    X                               ; 
    LDA	    (X)                             ;
    CPI     A,$0D                           ; 0D = CR
    BZS     BRANCH_9765                     ; If A = 0D branch fwd
    BII	    (KEY_LAST),$01                  ; Last pressed key code
    BZR     BRANCH_975D                     ; If Bit 0 was not set branch fwd
    CPI     A,$20                           ; 20 = Space
    BZS     BRANCH_9765                     ; If A = 20 branch fwd

BRANCH_975D: ; Branched to from 9737, 973C, 9740, 9757
    LOP     UL,BRANCH_974D                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set
    DEC	    UH                              ; U set in 9726, is from (SRCH_TOP_H, SRCH_TOP_L) SEARCH TOP
    BCS     BRANCH_974D                     ; Loop back until copying done.
    BCH     BRANCH_9766                     ; Unconditional branch fwd


BRANCH_9765: ; Branched to from 975B
    INC	    X                               ;

BRANCH_9766: ; Branched to from 9763
    VEJ	    (F4)                            ; Loads U-Reg with 16-bit value from address of SEARCH LINE
                AWRD(SRCH_LINE_H)           ;
    SJP     (U_MINUS_X )                    ; U = U - X, When upper limit occurs: C=0 and UH=16
    BCH     BRANCH_9793                     ; Unconditional branch fwd


BRANCH_976E: ; Branched to from 9721, 9724
    VEJ	    (F4)                            ; Loads U-Reg with 16-bit value from address of SEARCH LINE
                AWRD(SRCH_LINE_H)           ;
    VEJ	    (CC)                            ; Loads X-Reg with address at 78(AC) 78(AD). BREAK ADDRESS
                ABYT($AC)                   ;
    SJP     (U_MINUS_X - $01)               ; U = U - X - 1. When upper limit occurs: C=0 and UH=16
    BCR     BRANCH_974A                     ; What was set to zero in sub
    BII	    (KEY_LAST),$02                  ; Last pressed key code
    BZR     BRANCH_9798                     ;
    VEJ	    (CC)                            ; Loads X-Reg with address at 78(AC) 78(AD). BREAK ADDRESS
                ABYT($AC)                   ;
    LIN     X                               ; A = (X) then INC X
    CPI     A,$0D                           ; 0D = CR
    BZS     BRANCH_9789                     ; If A = 0D branch fwd
    CPI     A,$20                           ; 20 = Space
    BZR     BRANCH_9793                     ; If A = 0D branch fwd

BRANCH_9789: ; Branched to from 9783
    VEJ     (CC)                            ; Loads X-Reg with address at 78(AA) 78(AB). SEARCH TOP
                ABYT($AA)                   ;
    VEJ	    (F4)                            ; Loads U-Reg with 16-bit value from address of (SRCH_LINE_H). SEARCH LINE
                AWRD(SRCH_LINE_H)           ;
    SJP     (U_MINUS_X )                    ; U = U - X, When upper limit occurs: C=0 and UH=16
    BCH     BRANCH_9798                     ; Unconditional branch fwd


BRANCH_9793: ; Branched to from 96FA, 976C, 9787,979B, 97A5
    SJP     SUB_9D2A                        ; Not sure
    BCH     BRANCH_974A                     ; Unconditional branch fwd


BRANCH_9798: ; Branched to from 977C, 9791, 97A7, 97AB
    LIN     X                               ; A = (X) then INC X
    CPI     A,$0D                           ; 0D = CR
    BZS     BRANCH_9793                     ; If A = 0D branch back
    BII	    (KEY_LAST),$02                  ; Last pressed key code
    BZR     BRANCH_97A7                     ; If Bit 1 set
    CPI     A,$20                           ; 20 = Space
    BZS     BRANCH_9793                     ; If A = 20 branch back

BRANCH_97A7: ; Branched to from 97A1
    LOP     UL,BRANCH_9798                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set
    DEC	    UH                              ;
    BCS     BRANCH_9798                     ; If carry set branch back
    BCH     BRANCH_974A                     ; Branch back unconditional



HB_BPD_STR: ; 9A7F - need lable here for EXPORT
#IFNDEF ENBPD
;------------------------------------------------------------------------------------------------------------
;UNKNOWN_97AF:
UNKNOWN_97AF:
    .BYTE   $20,$00,$40,$00,$FF,$00,$FF,$00,$00,$00,$00

#ELSE

;------------------------------------------------------------------------------------------------------------
; X-REG address of function, Y-REG Token
;HB_BPD_STR: ; 9A7F
    LDI     A,$01                           ; (2) $00 = COM$, $01 = UR$, $FF= DEV$
    STA	    (STK_PTR_GSB_FOR)               ; (3) Register for type operation type
    JMP     BRANCH_889D                     ; (3) [8]

    .BYTE   $20,$00,$40;,$00,$FF,$00,$FF,$00,$00,$00,$00
#ENDIF


;------------------------------------------------------------------------------------------------------------
; SUB_97BA - Called from 8FE5, 9997, 9B59
; Changes last pressed key code and repeat speed?
; Arguments: 
; Output: 
; RegMod: UL, A
SUB_97BA:
    SJP     CE158_REG_79FA                  ; Not sure?
    SJP     SUB_9811                        ; A = 0E or keypress from RS232
    STA	    UL                              ;
    CPA	    (KEY_LAST)                      ; Last pressed key code
    BZR     BRANCH_97E2                     ; If A != (KEY_LAST) branch fwd
    ADI	    (CE158_7B08),$01                ; (CE158_7B08) = (CE158_7B08) + 1. Undefined
    BZR     BRANCH_980F                     ; If Bit 1 set, exiting
    ADI	    (KEY_REPEAT),$01                ; (KEY_REPEAT) = (KEY_REPEAT) + 1. Repeat speed
    BZR     BRANCH_980F                     ; If Bit 1 set, exiting
    LDA	    UL                              ;
    BZS     BRANCH_97DD                     ; If A = 0 branch fwd
    ORI	    (KEY_REPEAT),$FF                ; Set to FF. Repeat speed
    LDI	    A,$C0                           ;
    BCH     BRANCH_97FD                     ; Unconditional fwd branch, exiting


BRANCH_97DD: ; Branched to from 97D3
    ORI	    (KEY_LAST),$FF                  ; Set to FF, Last pressed key code
    RTN                                     ; FF = No key pressed?


BRANCH_97E2: ; Branched to from 97C4
    LDA	    (KEY_LAST)                      ; Last pressed key code
    INC	    A                               ;
    BZR     SUB_9802                        ; Resets last pressed key register and repeat speed.
    LDA	    UL                              ;
    BZS     BRANCH_980F                     ; If A = 0, exiting
    STA	    (KEY_LAST)                      ; Last pressed key code
    SJP     SUB_9811                        ; A = 0E or keypress from RS232
    CPA	    (KEY_LAST)                      ; Last pressed key code 
    BZR     SUB_9802                        ; Resets last pressed key register and repeat speed.
    LDI	    A,$FD                           ;
    STA	    (KEY_REPEAT)                    ; Repeat speed
    LDI	    A,$00                           ;

BRANCH_97FD: ; Branched to from 97D8
    STA	    (CE158_7B08)                    ; Undefined
    REC                                     ; Reset Carry Flag
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; Resets last pressed key register and repeat speed.
; Branched to from 97E6, 97F4,
; Called from 8ECA, 903E, 91F0, 998D, 9B60
; Arguments: 
; Output: 
; RegMod: A
SUB_9802: ; 
    ANI	    (KEY_LAST),$00                  ; clear last pressed key code
    LDI	    A,$E0                           ;
    STA	    (CE158_7B08)                    ; Undefined
    ORI	    (KEY_REPEAT),$FF                ; Set Repeat speed to FF

BRANCH_980F: ; Branched to from 97CA, 97D0, 97E9
    SEC                                     ; Set Carry Flag
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; Called from 97BD, 97EE
; Convert charecter from RS232 to keypress code on PC-1500
; Arguments: 
; Output: 
; RegMod: X, A = 0E or keypress from RS232
SUB_9811:
    LDI	    XL,$77                          ;
    ANI	    #(PC1500_PRT_B_DIR),$7F         ; Clear Bit 7
    LDI	    A,$01                           ; 

BRANCH_981A: ; Branched to from 982F
    STA     #(PC1500_PRT_A_DIR)             ; Bit 0 Write. DTR
    ANI	    #(PC1500_PRT_A),$00             ; Set DTR to zero
    STA	    XH                              ; 1st XH = 1, 2nd XH = 2
    LDI	    A,$08                           ; 1st round X = 0177, 
    ADR	    X                               ; X = X + A + Carry, 1st X = 017F, 2nd X = 0287
    ITA                                     ; A = Input port IN0-IN7
    INC	    A                               ; No flag change w/16bit register
    BZR     BRANCH_9833                     ; If A was != 00 branch fwd (we rxd actual charecter)
    LDA	    XH                              ; 1st round A = 01
    SHL                                     ; A = A << 1, 1st round A = 2
    BCR     BRANCH_981A                     ; If Bit 7 was not set, jump back. Done after 255 reads?
    BCH     BRANCH_983B                     ; Unconditional branch fwd


BRANCH_9833: ; Branched to from 982B
    DEC	    A                               ; DEC to get original A back

BRANCH_9834: ; Branched to from 9836
    INC	    XL                              ; 1st round X = 0180. 2nd X = 0288
    SHL                                     ; A = A << 1.       A << 1 = 60
    BCS     BRANCH_9834                     ; If Bit 7 was set branch back, move to next char in table?
    LDI	    XH,$FE                          ; 
    LDA	    (X)                             ; A = (X). X = FE80 is start of normal keybaord table

BRANCH_983B: ; Branched to from 9831
    BII     #(PC1500_PRT_B),$80             ; Bit 7 = Busy
    BZS     BRANCH_9844                     ; If Bit 7 was not set
    LDI	    A,$0E                           ;

BRANCH_9844: ; Branched to from 9840
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; SUB_9845, Called from 90B8, 92D6, 9476
; Arguments 90B8:XL = D8, 92D6:XL = B0, 9476:XL = B0
; Shifts display left one charecter
; Arguments: 
; Output: 
; RegMod: X, U, A
SUB_9845:
    LDI	    XH,$7B                          ; X = 7BD8 or X = 7BB0
    STX     Y                               ; 7BD8 = INPUT_BUFF_B40, 7BB0 = INPUT_BUFF_B0
    LIN	    X                               ; A = (X) then INC X. A is 1st charecter
    STA     UH                              ; UH = A = INPUT_BUFF_B40 or B0
    LDI	    UL,$26                          ; UL is number of copy loops 38-0 + 1 above 40 decimal

BRANCH_984D:
    TIN                                     ; (Y) = (X) then X = X + 1, Y = Y + 1
    LOP	    UL,BRANCH_984D                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set
    LDA	    UH                              ; A is first copied value
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; SUB_9852, SUB_INPUT_NUM_ALT_E1:Called from 96E1, 96B4
; Seems to be involved with editing a line
; Arguments: 
; Output: 
; RegMod: Y, X, U
SUB_9852:                                   ; (SRCH_ADD_H) SEARCH ADDRESS (H)
    VEJ	    (F4)                            ; Loads U-Reg with 16-bit value from address of (SRCH_ADD_H). SEARCH ADDRESS
                AWRD(SRCH_ADD_H)            ;
    VEJ	    (CC)                            ; Loads X-Reg with address at 78(A0) 78(A1). PREVIOUS ADDRESS
                ABYT($A0)                   ;
    SJP     (U_MINUS_X )                    ; U = U - X, When upper limit occurs: C=0 and UH=16
    STA	    YH                              ;
    LDA	    UL                              ;
    STA	    YL                              ;
    VEJ	    (CA)                            ; Transfers X to 78(A6), 78(A7). SEARCH ADDRESS
                ABYT($A6)                   ;
    VEJ     (F4)                            ; Loads U-Reg with 16-bit value from address of (78A2). PREVIOUS LINE
                AWRD(PREV_LINE_H)           ;
    DEC	    X                               ; X = X - 1, account for INC below?

BRANCH_9863: ; Branched to from 988B
    INC	    X                               ; X = X + 1
    LDA	    XH                              ;
    STA	    (CURSOR_BLNK)                   ; BLINK
    LDA	    XL                              ;
    STA	    (BLNKD_CHAR_CODE)               ; Character code to be blinked
    LDA	    (X)                             ; X = PREVIOUS ADDRESS?
    STA	    (ON_ERR_TOP_L)                  ; ON ERROR TOP (L)
    BCH     BRANCH_988D                     ; Unconditional fwd branch: 

BRANCH_9872: ; Branched to from 988D, 9891
    SJP     SUB_98A5                        ; X = X - Y with perhaps some offset from PREVIOUS LINE
    LDA	    (X)                             ;
    PSH	    A                               ;
    LDA	    (ON_ERR_TOP_L)                  ; ON ERROR TOP (L)
    STA	    (X)                             ;
    POP	    A                               ;
    STA	    (ON_ERR_TOP_L)                  ; ON ERROR TOP (L)
    LDA	    XL                              ;
    CPA	    (BLNKD_CHAR_CODE)               ; Character code to be blinked
    BZR     BRANCH_988D                     ; If XL!= (BLNKD_CHAR_CODE) branch fwd
    LDA	    XH                              ;
    CPA	    (CURSOR_BLNK)                   ; BLINK
    BZS     BRANCH_9863                     ; If XH != (CURSOR_BLNK) branch back

BRANCH_988D: ; Branched to from 9870, 9885  ; U is SEARCH ADDRESS?
    LOP	    UL,BRANCH_9872                  ; UL = UL - 1, loop back e if Borrow Flag not set
    DEC	    UH                              ;
    BCS     BRANCH_9872                     ; If carry set branch back
    VEJ	    (CC)                            ; Load X with SRCH_LINE_H, SRCH_LINE_L. SEARCH LINE (H) (L)
                ABYT($A8)                   ;
    SHL                                     ; A = A << 1
    BCS     BRANCH_98A4                     ; If Bit 7 shifted out
    SJP     SUB_98A5                        ; X = X - Y with perhaps some offset from PREVIOUS LINE
    VEJ     (CA)                            ; Transfers X to SRCH_LINE_H, SRCH_LINE_L SEARCH LINE (H) (L)
                ABYT($A8)                   ;
    VEJ	    (CC)                            ; Load X with ON_ERR_LINE_H, ON_ERR_LINE_L. ON ERROR LINE (H) (L)
                ABYT($BA)                   ;
    SJP     SUB_98A5                        ; X = X - Y with perhaps some offset from PREVIOUS LINE
    VEJ     (CA)                            ; Transfers X to ON_ERR_LINE_H, ON_ERR_LINE_L ON ERROR LINE (H) (L)
                ABYT($BA)                   ;

BRANCH_98A4: ; Branched to from 98A4
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; SUB_98A5, Called from SUB_9852:9872,9898, 989F
; Maybe adjusting line poiners for BASIC?
; XH = XH - YH, XL = XL - YL or XH = XH - YH + PREVIOUS LINE (H), XL = XL - YL + PREVIOUS LINE (L)
; X = X - Y with perhaps some offset from PREVIOUS LINE
; Arguments: 
; Output: 
; RegMod: A, X
SUB_98A5:
    SEC                                     ; Set Carry Flag
    LDA	    XL                              ;
    
BRANCH_98A7:    
    SBC	    YL                              ; A = A - YL
    STA	    XL                              ; XL = XL - YL
    LDA	    XH                              ;
    SBC	    YH                              ; A = A - YH
    STA	    XH                              ; XH = XH - YH. i.e. X = X - Y
    BCR     BRANCH_98B8                     ; If we did not go negative, skip to exit
    LDA	    XL                              ; This part does nothing but set carry
    SBC	    (PREV_ADD_L)                    ; A = A - (PREV_ADD_L). PREVIOUS ADDRESS (L)
    LDA	    XH                              ;
    SBC	    (PREV_ADD_H)                    ; A = A - (PREV_ADD_H). PREVIOUS ADDRESS (H)
    BCS     BRANCH_98C2                     ; If carry set, error so branch to exit

BRANCH_98B8: ; Branched to from 98AC                    
    LDA	    (PREV_LINE_L)                   ; PREVIOUS LINE (L)
    ADC	    XL                              ; A = A + XL
    STA	    XL                              ; XL = XL + (PREV_LINE_L). XL = XL - YL + PREVIOUS LINE (L)
    LDA	    (PREV_LINE_H)                   ; PREVIOUS LINE (H)
    ADC	    XH                              ; A = A + XH
    STA	    XH                              ; XH = XH + (PREV_LINE_H). XH = XH - YH + PREVIOUS LINE (H)

BRANCH_98C2: ; Branched to from 98B6
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; SUB_98C3 - Called from 944B
; Converts a value in AR-X to BCD for display
; Arguments: 
; Output: 
; RegMod: X, Y, A
SUB_98C3:
    LDA	    (CURS_POS_NBUF_L)               ; Blink cursor position (L)
    STA	    XL                              ;
    LDA	    (CURS_POS_NBUF_H)               ; Blink cursor position (H)
    STA	    XH                              ;
    LDI	    YL,LB(ARX)                      ;
    LDI	    YH,HB(ARX)                      ; Y = 7A00, ARC
    BCH     BRANCH_9906                     ; Unconditional fwd branch


#IFNDEF ENBPD
;------------------------------------------------------------------------------------------------------------
; SEPERATOR_98D1 - Unused space on original ROM
; Used for extended SETDEV for BPD command
SEPARATOR_98D1:
    .BYTE   $FF,$00,$FF,$00,$FF,$00,$FF,$00,  $FF,$00,$FF,$00,$FF,$00,$FF,$00 
    .BYTE   $FF,$00,$FF,$00,$FF,$00,$FF 

#ELSE
; Extensinon of SETDEV to handle BPD 
; 3rd byte of TBL_SETDEV_TEXT is in A. Values with Bit 7 set are for BPD
; CE158_REG_79DD flags for BPD settings
; B0=0 U0, B0=1 U1, B4-3=1 BPD mode. We don't keep bit 7
SETDEV_EXT1: ; 98D1
    BII     A,$80                           ;
    BZR     SETDEV_EXT_DONE                 ; If Bit 7 set value is for BPD
    ORA	    (SETDEV_REG)                    ; ORs it in
    RTN                                     ; (8 bytes)

SETDEV_EXT_DONE:  
    ANI     (CE158_REG_79DD),~$9F           ; clears bits 4-3 of BPD flag
    ANI     A,$9F                           ; bit 8 BPD mode flag to differentiate values from SETDEV
    ORA     (CE158_REG_79DD)                ; bits 4,3 used to pass mode mask at LB $903F
    STA     (CE158_REG_79DD)                ; and bit 0 for UART 1 or 2 selection (0=UART1)
    JMP     SETDEV_EXT2                     ;
#ENDIF



;------------------------------------------------------------------------------------------------------------
; SUB_98E8 - Called from 936B, 95C0
; Pulls bit patterns for charecters out of matrix for LCD?
; Arguments: 
; Output: 
; RegMod: A, X, Y
SUB_98E8: ; 
    SJP	    SUB_9912                        ; Manipulates PREVIOUS TOP and SEARCH LINE
    STA	    (SRCH_TOP_H)                    ; SEARCH TOP (H)
    LDA	    XL                              ; 
    STA	    (SRCH_TOP_L)                    ; SEARCH TOP (L)
    VEJ     (F2)                            ; deletes LCD display
    STA	    (CURSOR_PTR)                    ; CURSOR POINTER (0 to 155)
    STA	    XL                              ;
    STA	    (CURS_POS_NBUF_L)               ; Blink cursor position (L) 
    LDI	    A,$74                           ;
    STA	    XH                              ;

SUB_98FD: ; Called from 95BA
    STA	    (CURS_POS_NBUF_H)               ; Blink cursor position (H)

SUB_9900: ; Called from 9690
    LDI	    YL,LBO(CHARSET,$013B)           ;
    LDI	    YH,HBO(CHARSET,$013B)           ; Y = FDDB, inside LCD charecter matrix

BRANCH_9904: ; Branched to from 9910
    LDI	    UL,$04                          ; Loop counter

BRANCH_9906:                                ; Y = 7A00 (98CF) or Y = FDDB (9902) or Y = FC0A (9910)
    LIN     Y                               ; A = (Y). Then INC Y
    VMJ     ($88)                           ; vector to F661: Converts AR-X to BCD (absolute) form
    LOP	    UL,BRANCH_9906                  ; Converts each byte passed to BCD, for display?
    RTN                                     ;

SUB_990C: ;  Called from 95A9, 95B0
    LDI	    YL,LB(CHARSET)                  ; 
    LDI	    YH,HB(CHARSET)                  ; Y = FCA0, beggining of LCD charecter matrix
    BCH     BRANCH_9904                     ; Unconditional back branch



;------------------------------------------------------------------------------------------------------------
; SUB_9912 - Called from 9933, alt entries at 991D, 991E
; If SEARCH_LINE & 80 > 0 then X = SEARCH_LINE, C=1, else
; If SEARCH_LINE + 1 >= PREVIOUS_TOP then X = SEARCH_LINE, A = SEARCH_LINE_H, C = 0
; If SEARCH_LINE < PREVIOUS_TOP then X = PREVIOUS_ADDRESS, C = 0
; Arguments: 
; Output: 
; RegMod: A, X
SUB_9912:
    LDA	    (SRCH_LINE_L)                   ; SEARCH LINE (L)
    STA	    XL                              ;
    LDA	    (SRCH_LINE_H)                   ; SEARCH LINE (H)
    STA	    XH                              ;
    SHL                                     ; A = A << 1
    BCS     BRANCH_992A                     ; If Bit 7 was set

SUB_9912_ALT1: ; Called from 9954
    INC	    X                               ;

; if Called from 93D0. If X > PREVIOUS_TOP X=X, else X=PREVIOUS_ADDRESS, A=XH
SUB_9912_ALT2: 
    LDA	    XL                              ; XL = (SEARCH LINE (L)) + 1
    SBC	    (PREV_TOP_L)                    ; A = A - (PREV_TOP_L). PREVIOUS TOP (L)
    LDA	    XH                              ;
    SBC	    (PREV_TOP_H)                    ; A = A - (PREV_TOP_H). PREVIOUS TOP (L)
    LDA	    XH                              ; Subtractions only to get carry set
    BCR     BRANCH_9932                     ; Carry set by SBC above
    REC                                     ; Reset Carry Flag

BRANCH_992A: ; Branched to from 991B
    LDA	    (PREV_ADD_L)                    ; PREVIOUS ADDRESS (L)
    STA	    XL                              ;
    LDA	    (PREV_ADD_H)                    ; PREVIOUS ADDRESS (H)
    STA	    XH                              ;

BRANCH_9932: ; Branched to from 9927
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; SUB_9933, Called from 947F
; Seems to adjust SEARCH_LINE, SEARCH_ADDRESS, ON_ERROR_LINE
; Arguments: 
; Output: 
; RegMod: A, X, 
SUB_9933:
    SJP	    SUB_9912                        ; X = SEARCH_LINE or SEARCH_LINE+1 or X = PREVIOUS_ADDRESS
    LDA	    XL                              ; Save the X returned from SUB_9912 to SEARCH_LINE
    STA	    (SRCH_LINE_L)                   ; SEARCH LINE (L)
    LDA	    XH                              ;
    STA	    (SRCH_LINE_H)                   ; SEARCH LINE (H)
    BCS     BRANCH_9974                     ; Carry set in SUB_9912 if (SEARCH_LINE & 80 > 0)

    PSH	    U                               ; Save U
    STX     U                               ; U = X
    LDA	    (SRCH_ADD_L)                    ; SEARCH ADDRESS (L)
    STA	    XL                              ;
    LDA	    (SRCH_ADD_H)                    ; SEARCH ADDRESS (H)
    STA	    XH                              ;
    CPA	    UH                              ;
    BZR     BRANCH_996F                     ; If XH != UH branch fwd
    LDA	    XL                              ; XL = (SRCH_ADD_L)
    CPA	    UL                              ;
    BZR     BRANCH_996F                     ; If XL != UL branch fwd

    REC                                     ; Reset Carry Flag
    SJP	    SUB_9912_ALT1                   ; If X > PREVIOUS_TOP X = X, else X = PREVIOUS_ADDRESS. A = XH
    STA	    (SRCH_ADD_H)                    ; A = XH. SEARCH ADDRESS (H)
    LDA	    XL                              ;
    STA	    (SRCH_ADD_L)                    ; SEARCH ADDRESS (L)
    CPA	    UL                              ;
    BZR     BRANCH_996F                     ; If XL != UL branch fwd

    LDA	    (ON_ERR_LINE_H)                 ; ON ERROR LINE (H)
    CPA	    UH                              ; 
    BZR     BRANCH_996F                     ; If A != UH branch fwd
    LDA	    XL                              ;
    STA	    (ON_ERR_LINE_L)                 ; ON ERROR LINE (L)
    LDA	    XH                              ;
    STA	    (ON_ERR_LINE_H)                 ; ON ERROR LINE (H)

BRANCH_996F: ; Branched to from 994D, 9951, 995F, 9965
    LDX	    U                               ; X = U
    POP     U                               ;
    RTN                                     ;


BRANCH_9974: ; Branched to from 993E 
    REC                                     ; Reset Carry Flag. Carry set on exit == Error?
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; SUB_9976 - Called from 933C
; A = 0, copies code from (SUB_7A50_#) 8684 + A to System RAM 7A50
; First byte read from table is #bytes of code, second byte is LB of starting address of code
; This copied code seems to move other code around
; Arguments: 
; Output: 
; RegMod: X, UL
SUB_9976:
    PSH	    Y                               ;
    LDI	    YL,LB(SUB7A50_1)                ; BASIC STACK 7A38
    LDI	    YH,HB(SUB7A50_1)                ; Y = 7A50 BASIC STACK Byte 24
    LDI	    XL,LB(SUB_7A50_1)               ;
    LDI	    XH,HB(SUB_7A50_1)               ; X = 8684 = SUB_7A50_1_HDR
    ADR	    X                               ; X = X + A
    LIN	    X                               ; A = (X) then INC X. A = (8684) = 19
    STA	    UL                              ; UL = 19. # of bytes
    LDA	    (X)                             ; A = (8685) = 88
    STA	    XL                              ; X = 8688. X = #bytes, X + 1 = XL

BRANCH_9986: ; Branched to from 9987        ; (7A50) = (8688)
    TIN                                     ; (Y) = (X) then X = X + 1, Y = Y + 1
    LOP     UL,BRANCH_9986                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set
    POP	    Y                               ;
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; SEPARATOR_998C - 00 FF filles unused space
SEPARATOR_998C:
    .BYTE   $00                             ;



;------------------------------------------------------------------------------------------------------------
; Called from 8D70, SUB_8FC1:8F01
; Branched to from 999F
; Resets last pressed key register, repeat speed, LCD annunciators
; Arguments: 
; Output: 
; RegMod: A
SUB_998D: 
    SJP	    SUB_9802                        ; Resets last pressed key register and repeat speed.

BRANCH_9990: ; Branched to from 999F
    ADI	    (CURS_CTRL),$08                 ; (CURS_CTRL) = (CURS_CTRL) + 08. Character to blink. Whay add 8? Alters C
    SJP	    SUB_911E                        ; Exit if Carry clear, else wait until PC-1500 IF_REG IRQ and 
                                            ;  PB7 (Power Button) are clear before exit
    SJP	    SUB_97BA                        ; Changes last pressed key code and repeat speed?
    BCS     BRANCH_9990                     ;  Carry and UL = Last Pressed Key returend from above
    SJP	    SUB_8FED                        ; Seems to set LCD annuncitors, maybe for Terminal mode?
    BZS     SUB_998D                        ;
    LDA	    UL                              ; Where did UL come from?
    SJP	    (AUTO_OFF + $27)                ; Part of Auto Power Off routine, does it use A?
    ANI	    (DISP_BUFF + $4E),$7D           ; Clear bits 1 & 7. Bit 1 = (Shift)
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; SUB_9AE6 - Called from SUB_PRINT_NUM_ALT_E1:9245
; Called by interrupt routine
; Alt entry 99AA Called from SUB_PRINT_NUM_ALT_X1:9111
; Arguments: 
; Output: 
; RegMod: A, Y
SUB_99D6_ALT_E1: ; Branched to from 9A46
#IFNDEF CE158V2
; ************ Modified >
    ANI	    #(CE158_IF_REG),$FE             ; Clear Bit 0. CE-158 - IRQ input.
#ELSE
	NOP                                     ; PAD MISSING INSTRUCTION 
	NOP
	NOP
	NOP 
	NOP 
; <************
#ENDIF

    ANI	    #(CE150_IF_REG),$FE             ; Clear Bit 0. CE-150 - IRQ input. 
    LDA	    (ERR_ADD_L)                     ; ERROR ADDRESS (L)
    STA	    YL                              ;
    LDI	    YH,$7B                          ; Y = 7B##
    RIE                                     ; Disable interrupts
    SJP	    RXCOM                           ; Manipulates LPT/UART registers
    SIE                                     ; Enable interrupts
    BCR     BRANCH_9A54                     ; Carry set in RXCOM
    BII	    A,$40                           ; 
    BZS     BRANCH_9A7C                     ; If Bit 6 set branch to RTN
    LDI	    A,$3F                           ; 

BRANCH_99C9: ; Branched to from 9A58, 9A5C, 9A62, 9A68, 9A6C, 9A8A, 9A97
    CPI	    YL,$D8                          ; YL = ERROR ADDRESS (L)
    BCS     BRANCH_9A00                     ; If Y >= D8
    SIN	    Y                               ; (Y) = A then INC Y
    ADI	    (ERR_ADD_L),$01                 ; (ERR_ADD_L) = (ERR_ADD_L) + 1. ERROR ADDRESS (L)
    CPI	    YL,$D3                          ; 
    BZR     BRANCH_9A00                     ; If YL != D3

SUB_99D6: ; Called from 9B95
    BII	    (BRK_TOP_H),$80                 ; BREAK TOP (H)
    BZS     BRANCH_9A00                     ; If Bit 7 was not set
    BII	    (ERR_LINE_H),$02                 ;
    BZS     BRANCH_9A00                     ; If Bit 1 was not set
    LDI	    A,$13                           ; 
    BCH     BRANCH_99FA                     ; Unconditional fwd branch

SUB_99E6: ; Called from SUB_PRINT_NUM_ALT_E1:9245
    BII	    (DISP_BUFF + $4E),$01           ; 1 (Shift)
    BZR     BRANCH_9A00                     ; If Bit 0 was set

SUB_99EC: ; Called from 969F
    BII	    (ERR_LINE_H),$02                 ;
    BZS     BRANCH_9A00                     ; If Bit 1 was not set
    BII	    (BRK_TOP_H),$80                 ; BREAK TOP (H)
    BZR     BRANCH_9A00                     ; If Bit 7 was set
    LDI	    A,$11                           ;

BRANCH_99FA: ; Branched to from 99E4
    PSH	    U                               ; Save U
    LDI	    UH,$1F                          ;
    BCH     BRANCH_9A05                     ; Unconditional branch fwd


BRANCH_9A00: ; Branched to from 99EA, 99F), 99F6
    RTN                                     ;


    PSH	    U                               ; Save U
    LDI     UH,$00                          ;

BRANCH_9A05: ; Branched to from 99FE
    STA	    UL                              ; 
    BII	    (ERR_LINE_H),$02                 ;
    BZS     BRANCH_9A12                     ; If Bit 1 was not set
    BII	    (BRK_TOP_H),$40                 ; BREAK TOP (H)
    BZR     BRANCH_9A2F                     ; If Bit 6 was set

BRANCH_9A12: ; Branched to from 
    LDA	    UL                              ; 
    SJP	    CHAR2COM                        ; Sends charecter to RS232 Port
    BCR     BRANCH_9A32                     ; Carry returned from sub
    BII	    A,$20                           ;
    BZR     BRANCH_9A4B                     ; If Bit 5 was set
    CPI	    UH,$00                          ;
    BZS     BRANCH_9A2F                     ; If UH = 00
    BII	    A,$1C                           ;
    BZS     BRANCH_9A28                     ; If any Bits 2,3,4 not set
    DEC	    UH                              ; UH = UH - 1
    BCR     BRANCH_9A2F                     ; If UH >= 0

BRANCH_9A28: ; Branched to from 9A22
    BII     #(PC1500_IF_REG),$02            ; PB7 interrupt flag, Power Button
    BZS     BRANCH_9A12                     ; If Bit 1 was not set

BRANCH_9A2F: ; Branched to from 9A10, 9A1E, 9A26
    POP     U                               ;
    RTN                                     ;


BRANCH_9A32: ; Branched to from 9A16
    LDA	    UL                              ; 
    POP     U                               ;
    CPI	    A,$13                           ;
    BZR     BRANCH_9A3E                     ; If A != 13
    ANI	    (BRK_TOP_H),$7F                 ; BREAK TOP (H)
    RTN                                     ;

BRANCH_9A3E: ; Branched to from 9A37
    CPI	    A,$11                           ;
    BZR     BRANCH_9A48                     ; If A != 11
    ORI	    (BRK_TOP_H),$80                 ; BREAK TOP (H)
    BCH     SUB_99D6_ALT_E1                 ; Unconditional back branch

BRANCH_9A48: ; Branched to from 9A40
    LDI	    A,$00                           ;
    RTN                                     ;


BRANCH_9A4B: ; Branched to from 9A1A
    ADI	    (OUTSTAT_REG),$80               ; (OUTSTAT_REG) = (OUTSTAT_REG) + 80
    BCR     BRANCH_9A12                     ; If (OUTSTAT_REG) was < 7F
    JMP	    JMP_8CFD                        ; Resets CE-150, LCD annuncuiators, jumps to new code

BRANCH_9A54: ; Branched to from 99C1
    CPI	    A,$20                           ;
    BCR     BRANCH_9A6E                     ; If A < 20
    BZS     BRANCH_99C9                     ; If A = 20
    CPI	    A,$7F                           ;
    BZS     BRANCH_99C9                     ; If A = 7F
    BII	    (BRK_TOP_H),$08                 ; BREAK TOP (H)
    BZS     BRANCH_99C9                     ; If Bit 3 was not set
    BII	    (BRK_TOP_H),$10                 ; BREAK TOP (H)
    BZS     BRANCH_99C9                     ; If Bit 4 was not set
    ORI	    A,$80                           ; Set bit 7
    BCH     BRANCH_99C9                     ; Unconditional back branch


BRANCH_9A6E: ; Branched to from 9A56
    CPI	    A,$13                           ;
    BZR     BRANCH_9A7D                     ; If A != 13
    BII	    (ERR_LINE_H),$02                ;
    BZS     BRANCH_9A81                     ; If Bit 1 was not set
    ORI	    (BRK_TOP_H),$40                 ; Set Bit 6. BREAK TOP (H)

BRANCH_9A7C: ; Branched to from 99C5
    RTN                                     ;


BRANCH_9A7D: ; Branched to from 9A70
    CPI	    A,$11                           ;
    BZR     BRANCH_9A86                     ; If A != 11

BRANCH_9A81: ; Branched to from 9A86
    ANI	    (BRK_TOP_H),$BF                 ; Clear bit 6. BREAK TOP (H)
    RTN                                     ;


BRANCH_9A86: ; Branched to from 9A7F
    BII	    (BRK_TOP_H),$08                 ; BREAK TOP (H)
    BZS     BRANCH_99C9                     ; If Bit 7 was not set
    CPI	    A,$0E                           ;
    BZR     BRANCH_9A95                     ; If A != 0E
    ORI	    (BRK_TOP_H),$10                 ; Set Bit 4. BREAK TOP (H)
    RTN                                     ;


BRANCH_9A95: ; Branched to from 9A8E
    CPI	    A,$0F                           ;
    BZR     BRANCH_99C9                     ; If A != 0F
    ANI	    (BRK_TOP_H),$EF                 ; Clear Bit 4. BREAK TOP (H)
    RTN                                     ;
;------------------------------------------------------------------------------------------------------------



;------------------------------------------------------------------------------------------------------------
; SUB_9A9E - Called from 9318, alt entry at 9B2C
; Arguments A >=20 or A = 20 or A = 0D or A = 0A
; X index to unknown table, no idea what X is
; Arguments: A
; Output: 
; RegMod: U, X
SUB_9A9E:
    LDI	    UH,$00                          ;
    STA	    UL                              ; 
    CPI	    A,$20                           ; 20 = Space
    BCR     BRANCH_9B00                     ; If A < 20, non-printable ASCII
    BZS     BRANCH_9AC8                     ; If A = 20. 20 = Space
    CPI	    A,$80                           ;  
    BCR     BRANCH_9ACC                     ; If A < 80 . Printable ASCII
    LDI	    A,$04                           ;
    BII	    (DATA_PTR_H),$FF                ; Set Flags w/o changing reg. DATA POINTER (H)
    BZR     BRANCH_9ABC                     ; If (DATA_PTR_H) was not zero
    CPI	    UL,$A1                          ; 
    BCR     BRANCH_9AC6                     ; If A < A1
    CPI	    UL,$E0                          ;
    BCS     BRANCH_9AC6                     ; If A >= E0

BRANCH_9ABB: ; Branched to from 9B0A        ; A >= A1 & < E0
    INC	    A                               ; A = A + 1

BRANCH_9ABC: ; Branched to from 9AB1, 9ACA, 9AF6, 9AFE, 9B02, 9B08
    POP	    X                               ; Where was X pushed to stack?
    ADR	    X                               ; X = X + A
    LIN     X                               ; A = (X) then INC X
    ADR	    X                               ; X = X + A
    LDA	    UL                              ; What table is this using?
    STX     P                               ; Save X to Program Counter ***JUMP


BRANCH_9AC6: ; Branched to from 9AB5, 9AB9  ; If A < A1 | A >= E0
    LDI	    UL,$20                          ;

BRANCH_9AC8: ; Branched to from 9AA5        ; If A = 20
    LDI	    A,$07                           ;
    BCH     BRANCH_9ABC                     ; Unconditional back branch


BRANCH_9ACC: ; Branched to from 9AA9        ; If A < 80
    LDA	    (ERR_LINE_L)                    ; ERROR LINE (L)
    CPI	    A,$C0                           ;
    LDA	    UL                              ;
    BCS     BRANCH_9AFC                     ; If A >= C0 
    SBI	    A,$5A                           ; A = A - 5A 
    BCR     BRANCH_9AF8                     ; If A was >= 5A
    CPI	    A,$06                           ;
    BCS     BRANCH_9ADF                     ; If A >= 06
    INC	    A                               ;
    BCH     BRANCH_9AF3                     ; Unconditional branch fwd


BRANCH_9ADF: ; Branched to from 9ADA
    BII	    (ERR_LINE_L),$80                ;
    BZS     BRANCH_9AFC                     ; If Bit 7 was not set
    SBI	    A,$20                           ; A = A - 20
    BCR     BRANCH_9AFC                     ; If A >= 20
    ADI	    A,$06                           ; A = A + 06
    CPI	    A,$0A                           ;
    BZS     BRANCH_9AFC                     ; If A = 0A
    BCR     BRANCH_9AF3                     ; If A < 0A
    LDI	    A,$0A                           ;

BRANCH_9AF3: ; Branched to from 9AD0, 9AEF, 9AFA
    STA	    UH                              ;
    LDI	    A,$06                           ;
    BCH     BRANCH_9ABC                     ; Unconditional branch


BRANCH_9AF8: ; Branched to from 9AD6
    SBI	    A,$CB                           ; A = A - CB
    BZS     BRANCH_9AF3                     ; If A was = CB

BRANCH_9AFC: ; Branched to from 9AD2, 9AE3, 9AE7, 9AED
    LDI	    A,$03                           ;
    BCH     BRANCH_9ABC                     ; Unconditional branch


BRANCH_9B00: ; Branched to from 9AA3        ; A < 20, non-printable ASCII
    SBI	    A,$0C                           ; A = A - 0C
    BZS     BRANCH_9ABC                     ; If A was = 0C
    LDI	    A,$01                           ;
    CPI	    UL,$0C                          ;
    BZS     BRANCH_9ABC                     ; If UL = 0C
    BCH     BRANCH_9ABB                     ; Unconditional branch


;-----
; 9B0C-9B2B not reached?
    PSH	    Y                               ;
    LDA	    UH                              ;
    SHL                                     ;
    LDI	    XH,HB($8498)                    ;
    LDI	    XL,LB($8498)                    ; X = 8498 inside TBL_8475
    ADR	    X                               ; X = X + A
    LDI     YL,LB($7A00)                    ;
    LDI	    YH,HB($7A00)                    ; Y = 7A00
    LDI	    A,HB($7A02)                     ; 
    SIN     Y                               ; Save Accumulator to register Y, then INC register Y
    LDI	    A,LB($7A02)                     ;
    SIN     Y                               ; Save Accumulator to register Y, then INC register Y
    LDI	    A,HB($7A04)                     ;
    SIN     Y                               ; Save Accumulator to register Y, then INC register Y
    LDI	    A,LB($7A04)                     ;
    SIN     Y                               ; Save Accumulator to register Y, then INC register Y
    LIN     X                               ; Load Accumulator with value pointed to by X register and then increment X by one
    STA	    UL                              ;
    LIN     X                               ; Load Accumulator with value pointed to by X register and then increment X by one
    STA	    XL                              ;
    BCH     BRANCH_9B3F                     ; Unconditional branch fwd, does more copying
; Not reached
;------------



;------------------------------------------------------------------------------------------------------------
; SUB_9A9E_ALT1 - Called from 9323,  9C0A
; Copies something from TBL_8475 into system RAM at $7A00 AR-X
; Arguments: UH is offset into table
; Output: 
; RegMod: A, X, Y, UL
SUB_9B2C:
    LDA	    UH                              ; A = UH, what is UH here?
    LDI	    XL,LB(TBL_8475)                 ;
    LDI	    XH,HB(TBL_8475)                 ; X = 8475, TBL_8475
    ADR	    X                               ; X = X + A
    SHL                                     ; A = A * 2.
    SHL                                     ; A = A * 4. 
    LDI	    UL,$04                          ; # of bytes to copy, total of 5 bytes
    ADR	    X                               ; X = X + 5 * A. Offset into table, groups of 5 bytes?
    PSH     Y                               ; Save Y
    LDI     YL,LB(ARX)                      ;
    LDI	    YH,HB(ARX)                      ; Y = 7A00, AR-X

BRANCH_9B3F: ; Branched to from 9B2A, 9B40
    TIN                                     ; (Y) = (X) then X = X + 1, Y = Y + 1
    LOP	    UL,BRANCH_9B3F                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set
    LDX	    Y                               ; X = Y, X = next free byte?
    POP	    Y                               ; Get original Y back
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; SUB_9B47 Entry at 9B47 Called from 9BA7, 9BB8, 9C01
; May return or POKE new address into Stack Pointer
; Arguments: 
; Output: 
; RegMod: A
SUB_9B47:
    PSH	    U                               ; Save U
    LDI	    A,$FF                           ;
    CPA	    (KEY_LAST)                      ; Last pressed key code
    BZS     BRANCH_9B54                     ; If (KEY_LAST) = FF
    ANI	    (KEY_LAST),$00                  ; Clear it. Last pressed key code

BRANCH_9B54: ; Branched to from 9B4E
    STA	    (CE158_7B08)                    ; (7B08) = A = FF
    PSH	    Y                               ; Save Y before calling sub
    SJP     SUB_97BA                        ; UL = 0E or byte read from LCD charecter matrix based on what is read from IN0-IN7?
    POP	    Y                               ; Get the Y back
    BCS     BRANCH_9B6F                     ; Changes last pressed key code and repeat speed?
    SJP     SUB_9802                        ; Resets last key register and repeat speed? Does not alter UL
    LDA	    UL                              ; 
    VMJ	    ($34)                           ; Checks UL for presets in table, branch fwd if match
                ABYT($03)                   ;
                ABYT($09) \ ABRF(BRANCH_9B72) ; Horiz Tab?
                ABYT($0E) \ ABRF(BRANCH_9B77) ; Shift Out / X-On?
                ABYT($11) \ ABRF(BRANCH_9B7C) ; DC1 / XON?
                ABYT($13) \ ABRF(BRANCH_9B7D) ; DC3 / XOFF?

BRANCH_9B6F: ; Branched to from 9B5E, 9B75,9B85,9B1E
    POP     U                               ; Charecter did not match above?
    RTN                                     ;


BRANCH_9B72: ; Branched to from 9B64
    SJP     SUB_9E20                        ; Handles 09 Horiz Tab?
    BCH     BRANCH_9B6F                     ; Unconditional branch back


BRANCH_9B77: ; Branched to from 9B64
    POP     U                               ; Where was U pushed? Handles Shift Out / X-On?
    JMP	    SUB_8D04                        ; No idea what this does


BRANCH_9B7C: ; Branched to from 9B64
    REC                                     ; Handles DC1 / XON, Reset Carry Flag - do nothing

BRANCH_9B7D: ; Branched to from 9B64
    LDA	    XL                              ; Handles DC3 / XOFF?
    SEC                                     ; Set Carry Flag
    SBI	    A,$7C                           ; A = A - 7C
    EOR	    (DISP_BUFF + $4E)               ; A = A ^ (DISP_BUFF+$4E)
    SHR                                     ; A = A >> 1. Thru carry. 0 into MSB
    BCS     BRANCH_9B6F                     ; If Bit 1 was set
    BII	    (DISP_BUFF + $4E),$10           ;
    BZS     BRANCH_9B6F                     ; If Bit 4 was not set
    POP     U                               ;
    
BRANCH_9B8F: ; Branched to from $9D18  
    POP	    X                               ;
    INC	    X                               ;
    INC	    X                               ; INC X twice to walk to next vector?
    STX     P                               ; Save X to Program Counter ***JMP



;------------------------------------------------------------------------------------------------------------
; Called from 96B1, 96DE. 
; Alt entries at 9BD0
; Looks at BUAD setting and lh5811 timer control Bit 5. Why?
; Arguments: 
; Output: 
; RegMod: A, A, U, Y
SUB_9B95:  
    SJP     SUB_99D6                        ; 
    LDA	    (SETCOM_REG)                    ;
    ANI	    A,$E0                           ; Keep bits 7-5, BAUD
    AEX                                     ; Swap nibbles in A, Bits 7-5 now Bits 3-1
    SHR                                     ; A = A >> 1. Bits 7-5 now Bits 2-0
    LDI	    XL,LBO(TBL_8669,$2D)            ;
    LDI	    XH,HBO(TBL_8669,$2D)            ; X = 8696, in TBL_8669
    ADR	    X                               ; X = X + A
    LDA	    (X)                             ; A = (X). Range 8696-869D
    STA	    UL                              ;

BRANCH_9BA7:  ; Branched to from 9BC6
    SJP     SUB_9B47                        ; May return or poke address in SP
    BCH     BRANCH_9BAE                     ; Unconditional branch fwd


    SEC                                     ; Not reached?
    RTN                                     ;


BRANCH_9BAE: ; Branched to from 9BAA
    BII	    #(PC1500_PRT_B),$20             ; Port B, Pin 5 - Timer control
    BZS     BRANCH_9BA7                     ; If Bit 5 was not set

BRANCH_9BB5: ; Branched to from 9BCE
    DEC	    UL                              ;
    BCR     BRANCH_9BBE                     ; If UL was zero exit

BRANCH_9BB8: ; Branched to from 9BC4
    SJP     SUB_9B47                        ;
    BCH     BRANCH_9BBF                     ; Unconditional branch fwd


    SEC                                     ; Not reached?

BRANCH_9BBE: ; Branched to from 9BD8
    RTN                                     ;

BRANCH_9BBF: ; Branched to from 9BBB
    BII	    #(PC1500_PRT_B),$20             ; Port B, Pin 5 - Timer control
    BZR     BRANCH_9BB8                     ; If Bit 5 was set
    LOP	    UL,BRANCH_9BA7                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set
    REC                                     ;
    RTN                                     ;


    LDA	    (ON_ERR_ADD_L)                  ; Not reached?
    STA	    UL                              ;
    BCH     BRANCH_9BB5                     ;

SUB_9B95_ALT_E1: ; Called from 9675
    SDP                                     ; Sets LCD ON/OFF control flip-flop
    BII	    (SRCH_LINE_H),$80               ; SEARCH LINE (H)
    BZR     BRANCH_9BBE                     ; If Bit 7 was not set
    SJP	    (U_MINUS_X )                    ;
    BCR     BRANCH_9C06                     ; SUB returns Carry

    STX     Y                               ; Y = X. What is X here?

BRANCH_9BDF: ; Branched to from 9C08
    PSH	    U                               ;
    LDA	    (Y)                             ; A = (Y). What is Y here?
    SJP	    SUB_9C0A                        ; Not sure what this does
    BCH     BRANCH_9BEA                     ; SUB returns Carry
    POP	    U                               ;
    RTN                                     ;


BRANCH_9BEA: ; Branched to from 9BE5
    POP	    U                               ;
    DEC	    UL                              ;
    BCS     BRANCH_9BF3                     ; If DEC caused carry
    DEC	    UH                              ;
    BCR     BRANCH_9C06                     ; If DEC did not cause carry exit

BRANCH_9BF3: ; Branched to from 9BED
    LDA     (ERR_LINE_L)                    ; ERROR LINE (L)
    SHL                                     ; A = A << 1. Thru carry. 0 into LSB
    BCR     BRANCH_9C07                     ; If Bit 7 was not set
    SHL                                     ; A = A << 1. Thru carry. 0 into LSB
    BCR     BRANCH_9C01                     ; If Bit 6 was not set
    LDA	    (Y)                             ; A = (Y), What is Y here?
    CPI	    A,$0D                           ;
    BZR     BRANCH_9C07                     ; If A != 0D. 0D = CR

BRANCH_9C01: ; Branched to from 9BFA, 
    SJP	    SUB_9B47                        ; May return or poke new address into Stack Pointer
    BCH     BRANCH_9C07                     ; Unconditional fwd branch


BRANCH_9C06: ; Branched to from 9BDB, 9BF1
    RTN                                     ; Exit


BRANCH_9C07: ; Branched to from 9BF7, 9BFF, 9C04
    INC	    Y                               ;
    BCH     BRANCH_9BDF                     ; Unconditional back branch



;------------------------------------------------------------------------------------------------------------
; SUB_9C0A - Called from 9BE2
; Reads something from TBL_8475 and may change program counter
; Arguments: 
; Output: 
; RegMod: X, A
SUB_9C0A:
    SJP     SUB_9A9E                ; Copies something from TBL_8475 into system RAM
    STA	    (X)                     ; (X) = A
    DCS	    (X)                     ; A = A - (X). BCD subtraction
    STA	    XL                      ; XL = A
    STA	    XH                      ; XH = A
    CPA	    XL                      ; 
    LDA	    XL                      ; Seems like a lot of nonsense
    ADC	    XL                      ;
    SBC	    XL                      ;
    REC                             ; Reset Carry Flag
    REC                             ; Reset Carry Flag
    REC                             ; Reset Carry Flag
    REC                             ; Reset Carry Flag
    REC                             ; Reset Carry Flag
    REC                             ; Reset Carry Flag
    REC                             ; Reset Carry Flag
    LDI	    A,$21                   ;
    BII	    (ERR_LINE_L),$80        ; ERROR LINE (L)
    BZS     BRANCH_9C2E             ; If Bit 7 was not set
    LDI	    A,$29                   ;
    BII	    (ERR_LINE_L),$40        ; ERROR LINE (L)
    BZS     BRANCH_9C2E             ; If Bit 6 was not set
    LDI	    A,$31                   ;

BRANCH_9C2E: ; Branched to from 9C22, 92CA
    ADR	    X                       ; X = X + A. A = 21 or 29 or 31
    LIN	    X                       ; A = (X) then INC X
    ADR	    X                       ; X = X + A.
    LDA	    UL                      ; A = UL
    STX     P                       ; Save X to Program Counter, ***Jump


DATA_93C6: ; Nonsense?
    .BYTE   $29,$16,$27,$33,$25,$38,$37,$20,  $55,$42,$53,$AB,$51,$A9,$39,$4C      
    .BYTE   $B3,$B2,$B1,$B0,$AF,$A1,$A1,$A4  
       

    LDI	    A,$7A                   ;
    STA	    (KATACHAR)              ; Keyboard address or user chars address high byte (if KATAFLAGS = 0)
    AND	    (KATAFLAGS),$00         ; Reset to 0. KEYBOARD derivation flag Bit7=1 SPV, Bit7=0 RPV
    SJP     SUB_9B2C                ;
    LDI	    A,$80                   ;
    BCH     BRANCH_9C68             ; Unconditional branch fwd
    LDI	    A,$20                   ;
    PSH	    A                       ;
    VEJ	    (CC)                    ; 
                ABYT($BE)           ;
    VEJ	    (CA)                    ; Transfers X-Reg in Memory. 5D sets low byte in 78xx
                ABYT($5D)           ;
    POP	    A                       ; 

BRANCH_9C68: ; Branched to from 9C5C
    SJP     CHAR2COL                ;
    BCH     BRANCH_9CE4             ; Unconditional branch fwd
    SJP     HEX2COL                 ;
    ADI	    (CURSOR_PTR),$01        ; CURSOR POINTER (0 to 155)
    RTN                             ; Exit



;------------------------------------------------------------------------------------------------------------
SEPERATOR_9C75:                                 ;9C80
    .BYTE   $FF,$00,$FF,$00,$FF,$00,$FF,$00, $FF,$6A,$20,$8E,$12,$BE,$9B,$0C
    .BYTE   $B5,$78,$AE,$78,$5E,$E9,$78,$5D, $00,$6A,$80,$8E,$02 



;------------------------------------------------------------------------------------------------------------
; SUB_9C92 - Called from SUB_8D04:8E47
; CE-150 - Checks / clears low battery flag
; Arguments: 
; Output: 
; RegMod: U, A
SUB_9C92:
    LDI	    UL,$00                          ;
    LDA	    (PRNT_DISABLE)                  ;
    BZR     BRANCH_9CE9                     ; If (PRNT_DISABLE) not zero
    BII	    (ZONE_REG),$60                  ;
    BZS     BRANCH_9CED                     ; If Bits 5 or 6 not set
    LDA	    UL                              ; A = UL = 00

BRANCH_9CA0: ; Branched to from 9CE2
    ANI	    (ON_ERR_ADD_H),$00              ; Clear register. ON ERROR ADDRESS (H)
    STA	    UH                              ;
    LDA	    UH                              ; Why store than load? To set Z flag?
    BZS     BRANCH_9CB5                     ; If A/UH = 00 branch fwd
    LDA	    (ABS_POSX)                      ; CE-150 Printer - ABSOLUTE POSITION X
    CPI	    A,$D8                           ;
    BCR     BRANCH_9CB5                     ; If A < D8 branch fwd
    LDA	    UH                              ;
    STA	    (ON_ERR_ADD_H)                  ; ON ERROR ADDRESS (H)
    LDI     UH,$00                          ;

BRANCH_9CB5: ; Branched to from 9CA6, 9CAD
    RIE                                     ; Disable Interrupts
    ANI	    #(CE150_PRT_B_DIR),$BF          ; Bit 6 read, others write. Low Battery
    LDA     #(CE150_PRT_B)                  ; Port B Input/ Output
    AND	    #(CE150_PRT_B)                  ; Filter out changes
    AND	    #(CE150_PRT_B)                  ; Filter out changes
    BII	    A,$40                           ;
    NOP                                     ;
    NOP                                     ;
    ANI	    #(CE150_PRT_B),$BF              ; Clear Bit 6. Low battery
    ORI	    #(CE150_PRT_B_DIR),$40          ; Set Bit 6. Set Bit 6 to write
    PSH	    Y                               ;
    SJP	    SUB_9E66                        ; Seems to copy from ROM into System RAM and then call it
    SIE                                     ; Enable interrupts
    POP	    Y                               ;
    LDA	    (ON_ERR_ADD_H)                  ; ON ERROR ADDRESS (H)
    BZR     BRANCH_9CA0                     ; If (ON_ERR_ADD_H) != 0

BRANCH_9CE4: ; Branched to from 9C6B
    VEJ     (CC)                            ; Loads X-Reg with address at 78(BE) 78(BF). DATA POINTER (H)
                ABYT($BE)                   ;
    VEJ	    (CA)                            ; Transfers X to 78(5D), 78(5E). Keyboard derivation
                ABYT($5D)                   ;
    RTN                                     ;


BRANCH_9CE9: ; Branched to from 9C97
    RTN                                     ;
    RTN                                     ;
    RTN                                     ;
    RTN                                     ;


BRANCH_9CED: ; Branched to from 9C9D
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
UNKNOWN_9CEE:
    LDI     UL,$20                          ; 9CEE $6A,$20,
    BCH     BRANCH_9CFA                     ; 9CF0 $8E,$08,

    BII     (OUTSTAT_REG + $05),$10         ; 9CF2 $ED,$78,$55,$10, ($7855)
    BZS     BRANCH_9CFA                     ; 9CF6 $8B,$02,
    LDI     UL,$0A                          ; 9CF8 $6A,$0A,

BRANCH_9CFA:
    LDA     UL                              ; 9CFA $24,
    LDI     UL,$FF                          ; 9CFB $6A,$FF,
    LDI     UH,$00                          ; 9CFD $68 $00
    
BRANACH_9CFF:   
    PSH     A                               ; 9CFF $FD,$C8
    SJP     CHAR2LPT                        ; 9D00 $BE,$81,$69,

    BCR     BRANCH_9D1E                     ; 9D03 $81,$19
    BII     A,$20                           ; 9D05 $BF,$20
    BZR     BRANCH_9D22                     ; 9D07 $89,$18

    DEC     UL                              ; 9D09 $62
    BCS     BRANCH_9D1B                     ; 9D0A $83,$0E
    INC     UH                              ; 9D0C $FD $60
    BCS     BRANCH_9D25                     ; 9D0D $83,$14,
    SJP     SUB_9B47                        ; 9D0F $BE,$9B,$47,
    BCH     BRANCH_9D1B                     ; 9D12 $8E,$05

    POP     A                               ; 9D14 $FD,$8A
    JMP     BRANCH_9B8F                     ; 9D15 $BA,$9B,$8F

BRANCH_9D1B:
    POP     A                               ; 9D18 $FD,$8A
    BCH     BRANACH_9CFF                    ; 9D19 $9E $20

BRANCH_9D1E:
    POP     A                               ; 9D1B $FD,$8A
    RTN                                     ; 9D1C $9A, 

BRANCH_9D22:
    JMP    JMP_8CFD                         ; 9D1D $BA,$8C $FD

BRANCH_9D25:
    LDI     A,$08                           ; 9D20 $B5,$08, 
    JMP     SUB_8D04_ALT_E1                 ; 9D22 $BA,$8D,$0B



;------------------------------------------------------------------------------------------------------------
; SUB_9D39 - Called from 9C62
; Alt entry 9D4B called from 9747, Alt Entry 9D2A called from 9793
; Seems to be involved in parsing
; Arguments: 
; Output: 
; RegMod: X, U, A
SUB_9D2A:
    LDA	    XL                              ; 
    STA	    (SRCH_TOP_L)                    ; SEARCH TOP (L)
    LDA	    XH                              ;
    STA	    (SRCH_TOP_H)                    ; SEARCH TOP (H)
    ANI	    (BRK_TOP_L),$00                 ; Zero out, BREAK TOP (L)
    SEC                                     ; Set Carry Flag
    BCH     BRANCH_9D57                     ; Unconditional fwd branch


SUB_9D39:
    ANI	    (GOSB_STK_PTR_L),$00            ; Clear GOSUB pointer
    ORI	    (BRK_TOP_L),$01                 ; Set bit 0. BREAK TOP (L)
    VEJ	    (CC)                            ; Loads X-Reg with address at 78(A0) 78(A1). PREVIOUS ADDRESS
                ABYT($A0)                   ;
    VEJ	    (F4)                            ; Loads U-Reg with 16-bit value from address of (SRCH_LINE_H) SEARCH LINE (H)
                AWRD(SRCH_LINE_H)           ;
    SJP     (U_MINUS_X )                    ; U = U - X. When upper limit occurs: C=0 and UH=16 
    VEJ	    (CC)                            ; Loads X-Reg with address at 78(A0) 78(A1). PREVIOUS ADDRESS. 
                ABYT($A8)                   ;

SUB_9D4B: ; Called from 9747
    ORI	    (BRK_TOP_L),$02                 ; Set Bit 1. BREAK TOP (L)
    LDA	    XL                              ;
    STA	    (BRK_ADD_L)                     ; BREAK ADDRESS (L)
    LDA	    XH                              ;
    STA	    (BRK_ADD_H)                     ; BREAK ADDRESS (H)

BRANCH_9D57: ; Called from 9D37
    ANI	    (ERR_LINE_L),$7F                ; Clear Bit 7. ERROR LINE (L)
    LDI	    A,$69                           ;
    STA	    (ON_ERR_TOP_H)                  ; ON ERROR TOP (H)
    BII	    (SRCH_LINE_H),$80               ; SEARCH LINE
    BZR     BRANCH_9DB4                     ; If Bit 7 was set
    LDI	    YH,$FF                          ;
    BCR     BRANCH_9DD4                     ; Carry set if branched to from 9D36
    BCH     BRANCH_9D7C                     ; Unconditional fwd branch


BRANCH_9D6C: ; Branched to from 9D98, 9DEB
    DEC	    UL                              ; UL = UL - 1
    BCS     BRANCH_9D73                     ; If UL went past zero
    DEC	    UH                              ;
    BCR     BRANCH_9DD4                     ; If UH did not go past zero

BRANCH_9D73: ; Branched to from 9D6D
    INC	    X                               ;
    BII	    (BRK_TOP_L),$02                 ; BREAK TOP (L)
    BZS     BRANCH_9D7C                     ; If Bit 1 was not set
    DEC	    X                               ;
    DEC	    X                               ; X = X - 2

BRANCH_9D7C: ; Branched to from 9D6A, 9D78
    LDA	    (X)                             ; A = (X)
    CPI	    A,$80                           ; 
    BCR     BRANCH_9D8C                     ; If A < 80
    LDA	    (DATA_PTR_H)                    ; DATA POINTER (H)
    BZS     BRANCH_9D94                     ; If (DATA_PTR_H) was zero
    ADI	    (ON_ERR_TOP_H),$01              ; (ON_ERR_TOP_H) = (ON_ERR_TOP_H) + 1. ON ERROR TOP (H)
    BCH     BRANCH_9D98                     ; Unconditional fwd branch


BRANCH_9D8C: ; Branched to from 9D7F
    CPI	    A,$20                           ; 
    BCR     BRANCH_9DE9                     ; If A < 20
    BZR     BRANCH_9D94                     ; If A > 20
                                            ; A = 20 drop through
BRANCH_9D92: ; Branched to from 9DF7
    STX     Y                               ; Y = X

BRANCH_9D94: ; Branched to from 9D84, 9D90, 9DF1
    ADI	    (ON_ERR_TOP_H),$06              ; Keep Bits 1-2. ON ERROR TOP (H)

BRANCH_9D98: ; Branched to from 9D8A
    BCR     BRANCH_9D6C                     ; Carry set in 9D8C or 9D7D
    LDA	    (BRK_TOP_L)                     ; BREAK TOP (L)
    BZR     BRANCH_9DDB                     ; If (BRK_TOP_L) > 0
    LDA	    YH                              ;
    DEC	    X                               ; X = X - 1
    INC	    A                               ; A = A + 1
    BZS     BRANCH_9DB2                     ; If A = 0 (A was FF before INC)
    LDX	    Y                               ; X = Y
    LDA	    (X)                             ; A = (X)
    CPI	    A,$0D                           ;
    BZR     BRANCH_9DB2                     ; If A != 0D . 0D = CR
    INC	    X                               ; X = X + 1
    LDA	    (X)                             ; A = (X)
    CPI	    A,$0D                           ;
    BZS     BRANCH_9DB2                     ; If A = 0D
    DEC	    X                               ; X = X - 1

BRANCH_9DB2: ; Branched to from 9DA2, 9DA9, 9DAF, 9DD7, 9DFA
    VEJ     (CA)                            ; Transfers X to 78(AC), 78(AD). BREAK ADDRESS (H)
                ABYT($AC)                   ;

BRANCH_9DB4: ; Branched to from 9D64, 9DE7
    LDA	    (ERR_LINE_H)                    ;
    STA	    (ERR_LINE_H)                    ; Setting Z flag
    VEJ     (F2)                            ; deletes LCD display
    STA	    (CURSOR_PTR)                    ; CURSOR POINTER (0 to 155)
    STA	    (CURS_POS_NBUF_L)               ; Blink cursor position (L)
    LDI	    A,$74                           ;
    STA	    (CURS_POS_NBUF_H)               ; Blink cursor position (H)
    BII	    (SRCH_LINE_H),$80               ; SEARCH LINE
    BZR     BRANCH_9CED                     ; If Bit 7 was set
    VEJ	    (CC)                            ; Loads X-Reg with address at 78(A0) 78(A1). PREVIOUS ADDRESS (H)
                ABYT($AA)                   ;
    VEJ	    (F4)                            ; Loads U-Reg with 16-bit value from address of (BRK_ADD_H). BREAK ADDRESS (H)
                AWRD(BRK_ADD_H)             ;
    JMP	    SUB_9B95_ALT_E1                 ; This must be the exit


BRANCH_9DD4: ; Branched to from 9D68, 9D71
    LDA	    (BRK_TOP_L)                     ; BREAK TOP (L)
    BZS     BRANCH_9DB2                     ; If (BRK_TOP_L) was zero
    BCH     BRANCH_9DE5                     ; Unconditional fwd branch


BRANCH_9DDB: ; Branched to from 9D9D
    SHR                                     ; A = A >> 1. Thru carry. 0 into MSB
    BCS     BRANCH_9DE4                     ; If Bit 0 was set
    LDA	    YH                              ;
    INC	    A                               ; A = A + 1
    BZS     BRANCH_9DE4                     ; If A = 0 then A was FF before INC
    LDX	    Y                               ; X = Y

BRANCH_9DE4: ; Branched to from 9DDC, 9DE0, 9DFC
    INC	    X                               ; X = X + 1

BRANCH_9DE5: ; Branched to from 9DD9
    VEJ     (CA)                            ; Transfers X to 78(AA), 78(AB). SEARCH TOP
                ABYT($AA)                   ;
    BCH     BRANCH_9DB4                     ; Unconditional back branch


BRANCH_9DE9: ; Branched to from 
    CPI	    A,$0D                           ;
    BZR     BRANCH_9D6C                     ; If A != 0D. 0D = CR
    LDA	    (BRK_TOP_L)                     ; BREAK TOP (L)
    SHR                                     ; A = A >> 1.
    BCS     BRANCH_9D94                     ; If Bit 0 was set
    BII	    (KEY_LAST),$02                  ; 
    BZS     BRANCH_9D92                     ; If Bit 3 (before SHR) was set
    SHR                                     ; A = A >> 1.
    BCR     BRANCH_9DB2                     ; If Bit 1 (before both SHR) was not set
    BCH     BRANCH_9DE4                     ; Unconditional back branch


#IFNDEF ENBPD
;------------------------------------------------------------------------------------------------------------
; SEPARATOR_9DFE - 00 FF fills unused space
SEPARATOR_9DFE:
    .BYTE $00,$FF,$EC,$24,$00,$FF,$00,$FF,  $00,$FF,$00,$FF,$00,$FF,$00,$FF 
    .BYTE $00,$FF,$00,$FF,$00,$FF,$00,$FF,  $00,$FF,$00,$FF,$00,$FF,$00,$FF 
    .BYTE $00,$FF

#ELSE

;------------------------------------------------------------------------------------------------------------
; X-REG address of function, Y-REG Token
DEVSTR_EXT1: ; 9DFE
    BII     (STK_PTR_GSB_FOR),$02           ; (4) A=$FF=DEV$, A=$01=UR$
    BZR     ISDEV_STR1                      ; (2) If Bit2=1 then A=$FF, is DEV$
    LDA	    (CE158_REG_79DD)                ; (3)
    RTN

ISDEV_STR1:
    LDA	    (SETDEV_REG)                    ; (3)
    RTN                                     ; (1) [13]

DEVSTR_EXT2: ; 9E06
    BII     (STK_PTR_GSB_FOR),$02           ; (4) A=$FF=DEV$, A=$01=UR$
    BZR     ISDEV_STR2                      ; (2) If Bit2=1 then A=$FF, is DEV$

ISUR_STR:
    LDI     XL,(LB(TBL_SETDEV_TEXT) + $0F)  ; (2) Start search past SETDEV entries
    LDI	    UL,$02                          ; (2) Loop counter, 2-0 all 3 possible SETUR settings
    RTN                                     ; (1) [11] Done!

ISDEV_STR2:
    LDI     XL,LB(TBL_SETDEV_TEXT)          ; (2) Start search past SETDEV entries
    LDI	    UL,$04                          ; (2) Loop counter, 4-0 all 5 possible SETDEV settings
    RTN                                     ; (1) [5] {29}

    ;.BYTE $00,$FF,$EC,$24,$00,$FF,$00,$FF,  $00,$FF,$00,$FF,$00,$FF,$00,$FF 
    .BYTE $00,$FF;,$00,$FF,$00,$FF,$00,$FF,  $00,$FF,$00,$FF,$00,$FF,$00,$FF 
    .BYTE $00,$FF 
#ENDIF
 


;------------------------------------------------------------------------------------------------------------
; SUB_9E20 - Called from 9600, 9B72
; Sets LCD Annunciators (DEFI), (DEFII), (DEFIII) based on status of (Small) and (Katana)
; Returns UL = 40 or 20 or 10 based on status of LCD annuniators
; Arguments: 
; Output: 
; RegMod: UL, A
SUB_9E20:
    LDI	    UL,$40                          ; 40 = (DEFI)
    LDA	    (DISP_BUFF + $4E)               ; 0 (Busy), 1 (Shift), 2 (Katana), 3 (Small), 4 (DEFIII), 5 (DEFII), 6 (DEFI)
    SHR                                     ; A = A >> 1. Shifted thru Carry, 0 into MSB
    BHS     BRANCH_9E2F                     ; If Half carry, Bit 3 (Small) branch set forward
    LDI	    UL,$20                          ; 20 = (DEFII)
    SHR                                     ; A = A >> 1. Shifted through Carry, 0 into MSB
    BHR     BRANCH_9E2F                     ; If Half carry reset, no (Katana), branch forward
    LDI	    UL,$10                          ; 10 = (DEFIII)

BRANCH_9E2F: ; Branched to from 9E26, 9E2B
    ANI	    (DISP_BUFF + $4E),$0F           ; Keep only low nibble. 0 (Busy), 1 (Shift), 2 (Katana), 3 (Small)
    LDA	    UL                              ; UL = 40 or 20 or 10
    ORA	    (DISP_BUFF + $4E)               ;
    STA	    (DISP_BUFF + $4E)               ;
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; SUB_9E3B - Called from JUMP_91BC:9219, JUMP_91BC:9213
; Reads value from (X) into A and manipulates A 
; Arguments: X = (CURVARADD_L)?
; Output: 
; RegMod: A, X
SUB_9E3B:
    LIN	    X                               ; A = (X) then INC X
    SEC                                     ; Set Carry Flag
    SBI	    A,$30                           ; A = A - 30
    BCR     BRANCH_9E50                     ; If A was >= 30
    CPI	    A,$17                           ;
    BCS     BRANCH_9E4F                     ; If A-30 >= 17
    CPI	    A,$0A                           ;
    BCR     BRANCH_9E4F                     ; If A-30 < 0A
    SBI	    A,$11                           ; A = A - 30 - 11
    BCR     BRANCH_9E50                     ; If A-30-11 >= 0
    ADI	    A,$09                           ; A = A + 9

BRANCH_9E4F: ; Branched to from 9E43, 9E47
    RTN                                     ;


BRANCH_9E50: ; Branched to from 9E3F, 9E4B
    SEC                                     ; Set Carry Flag
    RTN                                     ;



;------------------------------------------------------------------------------------------------------------
; TBL_9E52 - This table is a bit of code that is poked into 7AF1 by SUB_9E3B
; The last three lines are different based on Bit 5 of (ZONE_REG). It seems
; to copy a bit of code from CE-150 ROM into System RAM and then call it.
; Arguments: 
; Output: 
; RegMod: Y, X
TBL_9E52:
ORIGPC4:     EQU $                          ; Save current PC
.ORG $7AF1                                  ; Set new PC to where this code will be POKE into RAM
TBL9E52:
                                            ; Y = 7A1C before calling
    RPV                                     ; (7AF1) $B8 Reset PV flip-flop. Bank out CE-158

BRANCH_7A52:    
    TIN                                     ; (7AF2) $F5 (Y) = (X) then X = X + 1, Y = Y + 1
    LOP	    UL,(BRANCH_7A52)                ; (7AF3) $88 $03 UL = UL - 1, loop back 'e' if Borrow Flag not set
    SPV                                     ; (7AF5) $A8 Set PV flip-flop. Bank in CE-158
    RTN                                     ; (7AF6) $9A Exit

    RPV                                     ; (7AF7) $B8 Reset PV flip-flop. Bank out CE-158
    SJP	    (ARU + $04)                     ; (7AF8) $BE,$7A,$1C, Some other code that was copied in from CE-150

; This set of three lines if (ZONG_REG) Bit 5 was set
    SJP	    (COLDES + $022E)                ; (7AFB) $BE,$A7,$47,
    SPV                                     ; (7AFE) $A8 Set PV flip-flop. Bank in CE-158
    RTN                                     ; (7AFF) $9A

; Or, this set of three lines if (ZONG_REG) Bit 5 was not set
    SJP	    MOTOFF                          ; (7AFB) $BE,$A7 $69
    SPV                                     ; (7AFE) $A8 Set PV flip-flop. Bank in CE-158
    RTN                                     ; (7AFF) $9A

.ORG (ORIGPC4 + ($-TBL9E52))                ; Set PC back to original range



;------------------------------------------------------------------------------------------------------------
; SUB_9E3B - Called from 9CD8
; Copies code from TBL_9E52 into RAM at 7AF1
; Arguments: 
; Output: 
; RegMod: X, Y, U, A
SUB_9E66:
    LDI	    XL,LB(TBL_9E52)                 ;
    LDI	    XH,HB(TBL_9E52)                 ; X = 9E52, unknown table
    LDI	    YL,LBO(B_STACK,$B9)             ;
    LDI	    YH,HB(B_STACK)                  ; Y = 7AF1, BASIC STACK Byte 185
    LDI	    UL,$09                          ; 10 bytes to transfer

BRANCH_9E70: ; Branched to from 9E71
    TIN                                     ; (Y) = (X) then X = X + 1, Y = Y + 1
    LOP     UL,BRANCH_9E70                  ; UL = UL - 1, loop back e if Borrow Flag not set
    LDI	    UL,$04                          ; Going to copy 5 more bytes
    LDI	    A,$05                           ;
    BII	    (ZONE_REG),$20                  ;
    BZR     BRANCH_9E7F                     ; If Bit 5 was set, X = 9E5C
    ADR	    X                               ; X = X + A. X = 9E61

BRANCH_9E7F: ; Branched to from 9E7B, 9E80
    TIN                                     ; (Y) = (X) then X = X + 1, Y = Y + 1
    LOP     UL,BRANCH_9E7F                  ; UL = UL - 1, loop back e if Borrow Flag not set
    LDA	    UH                              ;
    LDI	    XL,LBO(COLDES,$242)             ;
    LDI	    XH,HBO(COLDES,$242)             ; X = A75B, something to do with CE-150
    BZS     BRANCH_9E95                     ; If A = 0
    BII	    (ZONE_REG),$20                  ;
    BZR     BRANCH_9E91                     ; If Bit 5 was set
    LDI	    XL,$81                          ; X = A781, CE150 Print, send ASCII character to printer (no LF)

BRANCH_9E91: ; Branched to from 9E8D
    LDI	    UL,$C3                          ;
    BCH     BRANCH_9EA3                     ; Unconditional fwd branch

BRANCH_9E95: ; Branched to from 9E87
    LDI	    XL,LBO(LFEED,$7A)               ;
    LDI	    XH,HBO(LFEED,$7A)               ; X = A9CB, something in CE-150
    BII	    (ZONE_REG),$20                  ;
    BZR     BRANCH_9EA1                     ; If Bit 5 was set
    LDI	    XL,$F1                          ; X = A9F1, CE150 Line Feed

BRANCH_9EA1: ; Branched to from 9E9D
    LDI	    UL,$5F                          ;

BRANCH_9EA3: ; Branched to from 9E93
    LDI	    YL,LBO(ARU,$04)                 ;
    LDI	    YH,HBO(ARU,$04)                 ; Y = 7A1C
    SJP     (B_STACK + $B9)                 ; Calls the code we poke in above
    LDI	    A,$FA                           ;
    CPI	    UH,$00                          ;
    BZR     BRANCH_9EB2                     ; If UH != 00
    LDI	    A,$F8                           ;

BRANCH_9EB2: ; Branched to from 9EAE                            ; Y = ?
    ADR	    Y                               ; Y = Y + A
    DEC	    YH                              ; YH = YH - 1
    LDI	    A,$38                           ; 38 = NOP
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1. Default values?
    LDI	    XL,LBO(B_STACK,$B4)             ;
    LDI	    XH,HBO(B_STACK,$B4)             ; X = 7AEC. In BASIC stack
    LDA	    UH                              ;
    STA	    (X)                             ; (X) = A
    BZR     BRANCH_9ECD                     ; If A != 0
    LDI	    A,$7A                           ;
    STA	    (ARW + $02)                     ; 
    LDI	    A,$39                           ;
    STA	    (ARW + $03)                     ; 

BRANCH_9ECD: ; Branched to from 9EC1
    JMP	    (B_STACK + $BF)                 ; Part of code we poked into system RAM above



;------------------------------------------------------------------------------------------------------------
; JMP_9ED0 - Jumped to from  UNKNOWN_JMP_9083:90AE
; Arguments: A = (7BD8) ; INPUT BUFFER Byte 40
; Output: 
; RegMod: A
JMP_9ED0:
    BII	    (BRK_TOP_H),$08                 ; BREAK TOP (H)
    BZS     BRANCH_9EFD                     ; Branch fwd if Bit 3 was not set
    CPI     A,$80                           ; 
    BCR     BRANCH_9EE4                     ; Branch fwd if A <= 80. Printable?
    BII	    (BRK_TOP_H),$20                 ; BREAK TOP (H)
    BZR     BRANCH_9EFD                     ; Branch fwd if Bit 5 was set
    LDI	    A,$0E                           ; If A > 80 then A = 0E? Shift Out / X-On
    BCH     BRANCH_9EF0                     ; Unconditional fwd branch, exit

BRANCH_9EE4: ; Branched to from 9ED8
    CPI     A,$20                           ; Branch fwd if A <= 20
    BCR     BRANCH_9EFD                     ; else, A >= 20 & A < 80 is printable ASCII
    BII	    (BRK_TOP_H),$20                 ; BREAK TOP (H)
    BZS     BRANCH_9EFD                     ; Branch fwd if Bit 5 was not set
    LDI	    A,$0F                           ; If A >= 20 & A < 80 then A = 0F? Shift In / X-Off

BRANCH_9EF0: ; Branched to from 9EE2, A = 0E or A = 0F 9A0A, 9A2D
    SJP	    CHAR2COM                        ; Sends charecter in A to RS232 Port
    BCS     BRANCH_9F03                     ; If error sending
    LDA	    (BRK_TOP_H)                     ; BREAK TOP (H)
    EAI	    $20                             ; A = A ^ 20. Toggle Bit 5
    STA	    (BRK_TOP_H)                     ; BREAK TOP (H)

BRANCH_9EFD: ; Branched to from 9ED4, 9EDE, 9EEC 
    LDA	    (IN_BUF + $28)                  ; INPUT BUFFER Byte 40
    JMP	    JMP_90B1                        ; Drops into SUB_PRINT_NUM_ALT_X1


BRANCH_9F03: ; Branched to from 9EF3
    JMP	    SUB_PRINT_NUM_ALT_X1            ;



;------------------------------------------------------------------------------------------------------------
; JMP_9F06 - Jumped to from JUMP_TBL_915F
; Arguments: 
; Output: 
; RegMod: X
JMP_9F06:
    AND     (ERR_LINE_H)                    ; A = A & (ERR_LINE_H)
    BZS     BRANCH_9F18                     ; If (ERR_LINE_H) = 0
    LDI	    XL,$0E                          ;
    LDI	    XH,$00                          ; X = 000E
    VMJ	    ($24)                           ; Sends address from X-Reg as CSI, format "D0 XH XL length" to AR-X 
    RIE                                     ; Disable Interrupts
    SJP	    UNKNOWN_8A07                    ; Something to do with UART config
    SIE                                     ; Enable interrupts

BRANCH_9F18: ; Branched to from 9F09, 9F1E
    JMP	    SUB_PRINT_NUM_ALT_E1            ;



;------------------------------------------------------------------------------------------------------------
; JMP_9F1B - Jumped to from JUMP_TBL_915F
; Arguments: 
; Output: 
; RegMod: A
JMP_9F1B:
    AND	    (ERR_LINE_H)                    ; %=10110100
    BZS     BRANCH_9F18                     ; Branch if any bits left set, exit
    LDI	    A,$03                           ;

BRANCH_9F22: ; Branched to from 9F2A, 9F2E
    JMP	    UNKNOWN_JMP_9072                ; Changes LCD annunciators branches to SUB_PRINT_NUM_ALT_X1



;------------------------------------------------------------------------------------------------------------
; JMP_9F25 - Jumped to from 9049
; Arguments: 
; Output: 
; RegMod: A,X, UL
JMP_9F25:
    LDA	    (USINGM)                        ; USING M integer part
    CPI     A,$80                           ;
    BCR     BRANCH_9F22                     ; If A < 80 branch back to exit
    CPI     A,$A0                           ;
    BCS     BRANCH_9F22                     ; If A >= A0
    ANI	    A,$7F                           ; Clear bit 7
    JMP	    JUMP_91BC                       ; Jumps to JUMP_91BC and then 

                  
JMP_9F35: ; Jumped to from JUMP_91BC:9206                        
    LDA	    (CURVARADD_L)                   ; JUMP_91BC jumps back to here
    CPI     A,$07                           ;
    BZR     BRANCH_9F68                     ; If A != 07
    BII	    (ERR_LINE_H),$04                ;
    BZS     BRANCH_9F68                     ; If Bit 2 not set
    SJP	    STRNG_2COM_ALT_E1               ; Sends string to RS232. X is source table address?
    LDI	    UL,$21                          ;
    LDA	    (BAS_PENOP_STK_L)               ; BASIC PENDING OP STACK pointer (L)
    STA     XH                              ;
    LDA	    (STR_BUF_PTR_L)                 ; String buffer pointer (L)
    STA	    XL                              ; X=?
    LDI	    A,$E7                           ;
    BII	    (GOSB_STK_PTR_L),$FF            ; Set flags from GOSUB pointer
    BZS     BRANCH_9F5B                     ; If (GOSB_STK_PTR_L) not zero
    LDA	    (BAS_DATA_STK_L)                ; Data pointer
    INC     A                               ;

BRANCH_9F5B: ; Branched to from 9F55
    STA	    (BAS_DATA_STK_L)                ; Data pointer
    REC                                     ; Reset Carry Flag
    SBI	    A,$E6                           ; A = A - E6
    ADR	    X                               ; X = X + A
    LDA	    UL                              ;
    STA	    (X)                             ; (X) = A
    JMP	    JMP_90E1                        ;


BRANCH_9F68: ; Branched to from 9F3A, 9F40
    LDA	    (ERR_ADD_H)                     ; ERROR ADDRESS (H)
    JMP	    JMP_9209                        ; SUB_911E:JMP_9209



#IFNDEF CE158V2
;------------------------------------------------------------------------------------------------------------
UNKNOWN_9F6E:
; ************ Modified >
    .BYTE   $92,$05,$BA,$8D,$00,$FF,$00
; ************
#ENDIF



;------------------------------------------------------------------------------------------------------------
; SUB_9F75 - Called from 8AD9
; Arguments: U = D056, X = 83B8 = CE158_IO_REG_INIT2 00 0D 18 00 00 
; Does some initialization of the CE-158 registers
; Arguments: 
; Output: 
; RegMod: U, X, A
SUB_9F75:
    BII	    (TRACE),$01                     ; Test Bit0
    BZR     BRANCH_9F8E                     ; If Bit 0 was set, skip ahead
    LDI	    UH,HB(ZONE_REG)                 ; U = 7856 = ZONE_REG. 
    ANI	    (U),$60                         ; Keep Bits 6-5
    LIN	     X                              ; A = (83B8) = 0, then X=83B9
    ORA	    (U)                             ; A = A | (ZONE_REG) 
    BCH     BRANCH_9F84                     ; Branch fwd unconditional


; This section indexs through ; X 83B8 -> 83BC, U 7856 -> 7851. Inits:
; 7852-Console 1 (//), 7853-Undefined, 7854-Undefined, 7855-(MAIN_ENTRY), 7856-ZONE
BRANCH_9F83:                                            
    LIN	    X                               ; A = (83B9) = 0D then X=83BA

BRANCH_9F84: ; X = 83B9 U = 7856 on first entering
    STA	    (U)                             ; U = X read above
    DEC	    UL                              ; DEC pointer.
    CPI	    UL,$51                          ; 
    BCS     BRANCH_9F83                     ; If UL > 51 branch back
    ANI	    (U),$0F                         ; (U) = (U) & 0F, here U = 7851 = Console 1 (RS232C)
    ORI	    (U),$03                         ; (U) = (U) | 03

BRANCH_9F8E: ; X = 83B8 U = D056 on entering
#IFNDEF CE158V2
; ************ Modified >
    LDA	    #(CE158_PRT_A)                  ; CE-158 (ME1)
#ENDIF
#IFDEF CE158V2
    LDA	    #(CE158_UART_SCR0)              ; CE-158 (Scratch register)
; <************
#ENDIF

    ANI	    A,$C0                           ; Keep bits 6-7 (part of BAUD rate select)
    CPI	    A,$80                           ; 
    BZR     BRANCH_9F9A                     ; If A != 80 branch fwd
    LDI	    A,$A0                           ; 

BRANCH_9F9A:
    BII	    (TRACE),$01                     ; 
    BZS     BRANCH_9FA7                     ; If bit 0 not set branch fwd
    ANI	    (SETDEV_REG),$1F                ; Clear bits 7-5
    ORA	    (SETDEV_REG)                    ; A = A | (SETDEV_REG)
                                            ; KI = 01, DO = 02, PO = 04, CI = 08, CO = 10

BRANCH_9FA7:
    STA	    (SETDEV_REG)                    ; (SETDEV_REG) = A
#IFNDEF CE158V2
; ************ Modified >                   ; KI = 01, DO = 02, PO = 04, CI = 08, CO = 10
    ORI	    #(CE158_PRT_A_DIR),$C0          ; CE-158 - Set bit 7-6 to write. (part of BAUD rate select) (ME1)
    BII	    (TRACE),$80                     ; 
    BZR     BRANCH_9FCF                     ; If bit 7 was set branch fwd 
    LDA	    #(CE158_PRT_A)                  ; A = (CE158_PRT_A) (ME1)
#ELSE
    BII	    (TRACE),$80                     ; 
    BZR     BRANCH_9FCF                     ; If bit 7 was set branch fwd 
    LDA	    #(CE158_UART_MSR0)              ; A = (CE158_UART_MSR0) (ME1)
; <************
#ENDIF

    LDI	    UL,$28                          ; setting up a time delay?
    LDI	    UH,$0A                          ; U = 0A28

BRANCH_9FBD:
    LOP	    UL,BRANCH_9FBD                  ; DEC UL, if borrow flag not set loop back.
    DEC	    UH                              ; DEC UH
    BCS     BRANCH_9FBD                     ; Branch back if have passed zero?
#IFNDEF CE158V2
; ************ Modified >                                            ; KI = 01, DO = 02, PO = 04, CI = 08, CO = 10
    AND	    #(CE158_PRT_A)                  ; A = A & (CE158_PRT_A) (ME1), waiting to see what has changed?
    BII	    A,$20                           ; FLAGS = A & 20 (Low Battery)
#ELSE
    AND	    #(CE158_UART_MSR0)              ; A = A & (CE158_UART_MSR0) (ME1), waiting to see what has changed?
    BII	    A,$40                           ; FLAGS = A & 40 (Low Battery) in TI Chip, Hope the A reg is not checked elsewhere
; <************
#ENDIF

    BZS     BRANCH_9FCF                     ; If Bit 5 not set branch fwd
    ORI	    (ARV + $02),$01                 ; Set Bit 0

BRANCH_9FCF:
    RTN                                     ; Return, done



;------------------------------------------------------------------------------------------------------------
; SET_DTR_RTS - Called from 8D10, 8AA0
; Sets DTR/RTS based on OUTSTAT_REG
; Arguments: 
; Output: 
; RegMod:
SET_DTR_RTS: ; 9FD0
    PSH	    A                               ; #(CE158_PRT_A) Bit 0 = DTR, Bit 1 = RTS
#IFNDEF CE158V2
; ************ Modified >
    LDA	    #(CE158_PRT_A)                  ; A = #(CE158_PRT_A)
    ANI	    A,$FC                           ; A = #(CE158_UART_MCR0) & FC. Mask off Bits 0,1

; #IFDEF CE158V2
; 	LDI     A,0                             ; A = 0, MCR0 register is empty except for DSR/RTS
; ; <************
;  #ENDIF

    BII	    (OUTSTAT_REG),$01               ; 
    BZS     BRANCH_9FDF                     ; If Bit 0 not set skip
    INC	    A                               ; If ((OUTSTAT_REG) & 01) A = A + 1

BRANCH_9FDF:
    BII	    (OUTSTAT_REG),$02               ; Mask off all but Bit 1
    BZS     BRANCH_9FE7                     ; If Bit 1 not set skip
    INC	    A                               ;
    INC	    A                               ; If ((OUTSTAT_REG) & 02) A = A + 2

BRANCH_9FE7:
    STA     #(CE158_PRT_A)                  ; We cleared Bits 0-1, then set them based on (OUTSTAT_REG)
    POP	    A                               ; Get original A back
    RTN         

UNKNOWN_9FEE:
    .BYTE   $79
#ENDIF

#IFDEF CE158V2
  	LDA (OUTSTAT_REG)
 	ANI A,$3 
 	EAI $3
 	
 	ANI #(CE158_UART_MCR0),$FC
 
 	ORA #(CE158_UART_MCR0)
 	STA #(CE158_UART_MCR0)    
 	POP	    A                               ; Get original A back
    RTN          
; <************
#ENDIF



;------------------------------------------------------------------------------------------------------------
; SUB_9FEF - Called from 96ED, 96B7, 8D28
; CE-150 - Clears Pen Descending signal, and applies it again if safe.
; Arguments: 
; Output: 
; RegMod:
SUB_9FEF:
    ANI	    #(CE150_MSK_REG),$FD            ; Clear Bit 1, Pen descending?
    BII	    (PRNT_DISABLE),$FF              ; Set flags based on regsiter
    BZR     BRANCH_9FFF                     ; If any bit was set (Pen ascending, Low battery, Paper feed btn)
    ORI	    #(CE150_MSK_REG),$02            ; Set Bit 1.

BRANCH_9FFF:
    RTN                                     ; Return, DONE

#IFDEF CE158V2
.FILL ($A000 - $)
#ENDIF

.END

