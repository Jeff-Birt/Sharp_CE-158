; CE-158_ROM_LOW.lh5801.asm
; Low Bank of Sharp CE-158 RS232/LPT interface
;

#INCLUDE    "lib/PC-1500.lib"
#INCLUDE    "lib/CE-158.lib"
#INCLUDE    "lib/CE-158N.lib"
#INCLUDE    "lib/CE-150.lib"
#INCLUDE    "lib/PC-1500_Macros.lib"

#INCLUDE    CE-158_ROM_HIGH.exp             ; Export table from high bank

; Modifications enabled by uncommenting #DEFINEs. Not all defines used in both banks.
; BUGFIX    - (HB)    Fixed 'off by one bug' found in original ROM
; CE158_48  - (HB,LB) Original HW build 4800bps (not finished yet)
; CE158V2   - (HB,LB) Build for new hardware CE-158X. Max 2400bps for compatibility.
; CE158V2_F - (HB)    Build for new hardware CE-158X. Max 38400bps
; ENBPD     - (HB,LB) Extends SETDEV, DEV$ to support BP adds higher baud rates for CE-158X
;                     Fixes bug in HB_CFG_URT_LPT at $8BAC
; HANDSHAKE - (HB,LB) Adds CTS handshake for ASCII files
; LPTIN     - (HB,LB) Enables LPT input mode
; 
; Build recipies
; ORG       - Original ROM: select no options
; PJA       - Plain Jane A, minimal new hardware 2400bps: BUGFIX, CE158V2
; PJB       - Plain Jane B, minimal new hardware 38400bps: BUGFIX, CE158V2, CE158V2_F
; BPA       - Includes new features except hanshaking: BUGFIX, CE158V2, CE158V2_F, ENBPD, LPTIN
; BPA       - Includes new features with hanshaking: BUGFIX, CE158V2, CE158V2_F, ENBPD, HANDSHAKE, LPTIN
#DEFINE BUGFIX                              ; Bug fixes in original ROM
;#DEFINE CE158_48                            ; Make top baud rate 4800bps, eliminate 50bps
#DEFINE CE158V2                             ; Build for new hardware CE-158X, 2400bps
#DEFINE CE158V2_F                           ; Build for new hardware CE-158X, 38400bps (use only/w CE158V2)
#DEFINE ENBPD                               ; Extends SETDEV, DEV$ to support BP 38400bps
;#DEFINE HANDSHAKE                           ; Adds CTS handshake for ASCII files
;#DEFINE LPTIN                               ; Enables LPT input mode

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

 #IFDEF ENBPD
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
; Symbols to export to CE-158_ROM_LOW.exp to be imported into high bank
.EXPORT LB_CHAR2LPT, LB_TXLPT, LB_RTN_FRM_HB, LB_COM_STR_V, LB_CONSOL_V, LB_DEV_STR_V, LB_FEED_V
.EXPORT LB_LPRINT_V, LB_LLIST_V,LB_CONSOLE_2V, LB_FEED_2V, LB_LPRINT_2V, LB_LLIST_2V

.ORG $8000


;------------------------------------------------------------------------------------------------------------
; BASIC Command Table 8000
;------------------------------------------------------------------------------------------------------------
;% B_TBL_8000 START
B_TBL_8000: 
    .BYTE   $55                                         ; Marker that BASIC Table follows 

B_TBL_8000_TNUM:
    .BYTE   $08                                         ; Table number

B_TBL_8000_NAME:
    .TEXT   "COM\r\r\r\r\r"                             ; Table name
                   
B_TBL_8000_INIT:
    JMP	    COM_TBL_INIT                                ; 82B8 - Table initilization vector

B_TBL_8000_INPUT_NUM:
    JMP	    COM_TBL_INPUT_NUM                           ; 82C5 - Table INPUT# vector

B_TBL_8000_PRINT_NUM:
    JMP	    COM_TBL_PRINT_NUM                           ; 82C9 - Table PRINT# vector

B_TBL_8000_JMPS:
    .BYTE $9A,$9A,$9A,$9A,$9A,$9A,$9A,$9A,$9A,$9A       ; Unused jumps                 

B_TBL_8000_TRACE:
    VEJ (C4) \                                          ; is correct per the book
            ABYT($AF) \                                 ;
            ABRF($811F)                                 ; Forward branch to label   

B_TBL_8000_A_KW:
    .WORD   $0000                                       ;

B_TBL_8000_B_KW:
    .WORD   LET_B                                       ; 

B_TBL_8000_C_KW:
    .WORD   LET_C                                       ; $8060

B_TBL_8000_D_KW:
    .WORD   LET_D                                       ; $8089

B_TBL_8000_E_KW:
    .WORD   LET_E                                       ; $809A

B_TBL_8000_F_KW:
    .WORD   LET_F                                       ; $80AA

B_TBL_8000_G_KW:
    .WORD   $0000                                       ;

B_TBL_8000_H_KW:
    .WORD   $0000                                       ;

B_TBL_8000_I_KW:
    .WORD   LET_I                                       ; $80B3

B_TBL_8000_J_KW:
    .WORD   $0000                                       ;

B_TBL_8000_K_KW:
    .WORD   $0000                                       ;

B_TBL_8000_L_KW:
    .WORD   LET_L                                       ; $80C8

B_TBL_8000_M_KW:
    .WORD   LET_M                                       ; $80DD

B_TBL_8000_N_KW:
    .WORD   $0000                                       ;

B_TBL_8000_O_KW:
    .WORD   LET_O                                       ; $80E7

B_TBL_8000_P_KW:
    .WORD   LET_P                                       ; $80F3

B_TBL_8000_Q_KW:
    .WORD   $0000                                       ;

B_TBL_8000_R_KW:
    .WORD   LET_R                                       ; $810A

B_TBL_8000_S_KW:
    .WORD   LET_S                                       ; $8116

B_TBL_8000_T_KW:
    .WORD   LET_T                                       ; $8137

B_TBL_8000_U_KW:
    .WORD   LET_U                                       ;

B_TBL_8000_V_KW:
    .WORD   $0000                                       ;

B_TBL_8000_W_KW:
    .WORD   $0000                                       ;

B_TBL_8000_X_KW:
    .WORD   $0000                                       ;

B_TBL_8000_Y_KW:
    .WORD   $0000                                       ;

B_TBL_8000_Z_KW:
    .WORD   LET_Z                                       ; $8159

B_TBL_8000_CMD_LST:     ;Token LB < 80 command is function, else is proceedure
;Ctrl nibble    Ctrl nib calc            Name              Token  Vector
LET_B:  EQU ($ + 2) ; First keyword starting with 'B'. LET_B = Address of 'R' in BREAK
CN1:    EQU $B5 \ CNIB($B5,CN1)     \ .TEXT "BREAK"    \ .WORD $F0B3, ERR1          ; $CD89 - Basic command P

LET_C:  EQU ($ + 2) ; First keyword starting with 'C'. LET_C = Address of 'L' in BREAK
CN2:    EQU $C5 \ CNIB(CN1,CN2)     \ .TEXT "CLOAD"    \ .WORD $F089, MAIN_ENTRY    ; $82EC - MAIN_ENTRY
CN3:    EQU $C5 \ CNIB(CN2,CN3)     \ .TEXT "CSAVE"    \ .WORD $F095, CSAVE_V       ; $82DD - Drops through to MAIN_ENTRY
CN4:    EQU $C4 \ CNIB(CN3,CN4)     \ .TEXT "COM$"     \ .WORD $E858, LB_COM_STR_V  ; $82D3 - Drops through to MAIN_ENTRY
CN5:    EQU $D7 \ CNIB(CN4,CN5)     \ .TEXT "CONSOLE"  \ .WORD $F0B1, LB_CONSOL_V   ; $82DE - Drops through to MAIN_ENTRY

LET_D:  EQU ($ + 2) ; First keyword starting with 'D'. LET_D = Address of 'E' in DEV$
CN6:    EQU $C4 \ CNIB(CN5,CN6)     \ .TEXT "DEV$"     \ .WORD $E857, LB_DEV_STR_V  ; $82D4 - Drops through to MAIN_ENTRY
CN7:    EQU $D3 \ CNIB(CN6,CN7)     \ .TEXT "DTE"      \ .WORD $E884, DTE_V         ; $82D1 - Drops through to MAIN_ENTRY

LET_E:  EQU ($ + 2) ; First keyword starting with 'E'. LET_E = Address of 'R' in ERN
CN8:    EQU $C3 \ CNIB(CN7,CN8)     \ .TEXT "ERN"      \ .WORD $F052, ERN_V         ; $82DF - Drops through to MAIN_ENTRY
CN9:    EQU $D3 \ CNIB(CN8,CN9)     \ .TEXT "ERL"      \ .WORD $F053, ERL_V         ; $82E0 - Drops through to MAIN_ENTRY

LET_F:  EQU ($ + 2) ; First keyword starting with 'F'. LET_F = Address of 'E' in FEED
CN10:   EQU $D4 \ CNIB(CN9,CN10)    \ .TEXT "FEED"     \ .WORD $F0B0, LB_FEED_V     ; $82E1 - Drops through to MAIN_ENTRY

LET_I:  EQU ($ + 2) ; First keyword starting with 'I'. LET_I = Address of 'N' in INPUT
CN11:   EQU $C5 \ CNIB(CN10,CN11)   \ .TEXT "INPUT"    \ .WORD $F091, INPUT_V       ; $82E2 - Drops through to MAIN_ENTRY
CN12:   EQU $D6 \ CNIB(CN11,CN12)   \ .TEXT "INSTAT"   \ .WORD $E859, INSTAT_V      ; $82E3 - Drops through to MAIN_ENTRY

LET_L:  EQU ($ + 2) ; First keyword starting with 'L'. LET_L = Address of 'P' in LPRINT
CN13:   EQU $C6 \ CNIB(CN12,CN13)   \ .TEXT "LPRINT"   \ .WORD $F0B9, LB_LPRINT_V   ; $82E4 - Drops through to MAIN_ENTRY
CN14:   EQU $D5 \ CNIB(CN13,CN14)   \ .TEXT "LLIST"    \ .WORD $F0B8, LB_LLIST_V    ; $82E5 - Drops through to MAIN_ENTRY

LET_M:  EQU ($ + 2) ; First keyword starting with 'M'. LET_M = Address of 'E' in MERGE
CN15:   EQU $95 \ CNIB(CN14,CN15)   \ .TEXT "MERGE"    \ .WORD $F08F, MERGE_V       ; $82C0 - Sets XL=F0, branches to MAIN_ENTRY

LET_O:  EQU ($ + 2) ; First keyword starting with 'O'. LET_O = Address of 'U' in OUTSTAT
CN16:   EQU $C7 \ CNIB(CN15,CN16)   \ .TEXT "OUTSTAT"  \ .WORD $E880, OUTSTAT_V     ; $82E6 - Drops through to MAIN_ENTRY

LET_P:  EQU ($ + 2) ; First keyword starting with 'P'. LET_P = Address of 'R' in PRINT
CN17:   EQU $C5 \ CNIB(CN16,CN17)   \ .TEXT "PRINT"    \ .WORD $F097, PRINT_V       ; $82E7 - Drops through to MAIN_ENTRY
CN18:   EQU $D8 \ CNIB(CN17,CN18)   \ .TEXT "PROTOCOL" \ .WORD $E881, PROTOCOL_V    ; $82E8 - Drops through to MAIN_ENTRY

LET_R:  EQU ($ + 2) ; First keyword starting with 'R'. LET_R = Address of 'I' in RINKY$
CN19:   EQU $D7 \ CNIB(CN18,CN19)   \ .TEXT "RINKEY$"  \ .WORD $E85A, RINKEY_STR_V  ; $82E9 - Drops through to MAIN_ENTRY

LET_S:  EQU ($ + 2) ; First keyword starting with 'S'. LET_S = Address of 'E' in SETCOM
CN20:   EQU $C6 \ CNIB(CN19,CN20)   \ .TEXT "SETCOM"   \ .WORD $E882, SETCOM_V      ; $82D6 - Drops through to MAIN_ENTRY
CN21:   EQU $C6 \ CNIB(CN20,CN21)   \ .TEXT "SETDEV"   \ .WORD $E886, SETDEV_V      ; $82D5 - Drops through to MAIN_ENTRY
CN22:   EQU $B6 \ CNIB(CN21,CN22)   \ .TEXT "SPACE$"   \ .WORD $F061, SPACE_STR_V   ; $82EA - Drops through to MAIN_ENTRY

LET_T:  EQU ($ + 2) ; First keyword starting with 'T'. LET_T = Address of 'E' in TERMINAL
CN23:   EQU $C8 \ CNIB(CN22,CN23)   \ .TEXT "TERMINAL" \ .WORD $E883, TERMINAL_V    ; $82D2 - Drops through to MAIN_ENTRY
CN24:   EQU $C8 \ CNIB(CN23,CN24)   \ .TEXT "TRANSMIT" \ .WORD $E885, TRANSMIT_V    ; $82D7 - Drops through to MAIN_ENTRY
CN25:   EQU $D3 \ CNIB(CN24,CN25)   \ .TEXT "TAB"      \ .WORD $F0BB, B_TBL_8800_INPUT_NUM  ; $880D - Uses 8800 BASIC Table TAB/INPUT# vector

LET_U:  EQU $00
LET_Z:  EQU ($ + 2) ; First keyword starting with 'Z'. LET_Z = Address of 'O' in ZONE
CN26:   EQU $D4 \ CNIB(CN25,CN26)   \ .TEXT "ZONE"     \ .WORD $F0B4, ZONE_V        ; $82EB - Drops through to MAIN_ENTRY

CN27:  EQU $D0 \ .BYTE CN27

B_TBL_8000_END:
;% B_TBL_8000 END


;------------------------------------------------------------------------------------------------------------
; Unused address range 8161-8168 in original ROM
; USED for UR$ command in modified ROM
;% SEPARATOR_8161 START
SEPARATOR_8161:
     .BYTE   $DF,$00,$FF,$00,$FF,$00,$CB,$00 ; - Used as seperator / space filler

;% SEPARATOR_8161 END


;------------------------------------------------------------------------------------------------------------
; CHAR2LPT - Sends charecter in A to LPT
; Same as High Bank
; Called from 826E, 9307, 956D
; Arguments: A: ASCII charecter >=20, i.e. printable
; Outputs: REC = Success, A = 20 Low Battery
; RegMod: A
;% LB_CHAR2LPT START
LB_CHAR2LPT: ; 8169
#IFNDEF CE158V2
; ************ Modified >
    PSH     A                               ; A is the ASCII charecter from input buffer?
    LDI	    A,$7F                           ; 
    STA     #(CE158_PRT_B_DIR)              ; Bit 7 Read (BUSY), (ME1)
    LDA     #(CE158_PRT_A)                  ; Read CE-158 Port A,  (ME1)
    AND     #(CE158_PRT_A)                  ; Filter out input changes? (ME1)
    SHL  
#ELSE
    PSH     A                               ; A is the ASCII charecter from input buffer?
    LDA     #(CE158_UART_MSR0)              ; Read CE-158 Port MSR0,  (ME1)
    AND     #(CE158_UART_MSR0)              ; Filter out input changes? (ME1)
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
    ;ORI     #(CE158_LPT_CTL_WRITE),$01      ; SET LPT_STROBE LOW (ME1) 
    ANI     #(CE158_LPT_CTL_WRITE),~$01     ; Make sure LPT_STROBE HI (ME1) 

BRANCH_8196: ; Branched to from 818F

    STA     #(CE158_LPT_DATA_WRITE)         ; #(CE158_LPT_DATA_WRITE) = A (ME1).
                                            ; Shift in 818C aligns Bits 2-8 to PORTB.
    LDI	    A,$80                           ; Set up time delay

BRANCH_819C: ; Branched to from 81D9
    DEC	    A                               ; Carry set by first DEC, count 80->0
    BCS     BRANCH_819C                     ; If Carry set repeat, carry clear after hitting 0
    RIE                                     ; Disable interrupts 
    ;ANI     #(CE158_LPT_CTL_WRITE),$FE      ; CLR strobe bit HI (ME1) 
    ORI     #(CE158_LPT_CTL_WRITE),$01      ; CLR strobe bit HIGH (ME1)
    LDI	    A,$80                           ; Set up time delay

BRANCH_81A8: ; Branched to from 81A9
    DEC	    A                               ; Carry set by first DEC, count 80->0
    BCS     BRANCH_81A8                     ; If Carry set repeat, Carry clear after hitting 0

    ;ORI     #(CE158_LPT_CTL_WRITE),$01      ; SET LPT_STROBE LOW (ME1) 
    ANI     #(CE158_LPT_CTL_WRITE),~$01     ; Set LPT_STROBE HI (ME1)
    SIE                                     ; Enable Interrupts
    LDI	    A,$80                           ; Set up time delay
; <************
#ELSE
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

;% LB_CHAR2LPT END


#IFDEF ENBPD
; ************ Modified >
.FILL ($81AC - $)
.ORG $81AC 
 ; <************
 #ELSE
 .FILL ($81BC - $)
.ORG $81BC 
 #ENDIF
; -----------------------------------------------------------------------------------------------------------
; CHAR2COM - Sends charecter in A to RS232 Port
; Same as High Bank
; Called from 875B, 87EA, 90B1, 9EF0, 8247
; Arguments: A charecter to send
; Outputs: REC = Success, A = #(CE158_PRT_A) Bits 5-2  on failure
; RegMod: A
;% CHAR2COM START
CHAR2COM: ; 81BC
    SEC                                     ; Set Carry Flag
    PSH     U                               ; Save U.
    STA	    UL                              ; A is character to send

#IFDEF ENBPD
    BII     (CE158_REG_79DD),$20            ; Bit6 set = U1
	BZS     CONTTX                          ; Intecept the CHAR2COM routine and 
	JMP     U1CHAR2COM                      ;  redirect to UART1 if enabled
CONTTX:
#ENDIF

#IFNDEF CE158V2 
; ************ Modified >
    LDA	    #(CE158_PRT_A)                  ; #(CE158_PRT_A) is LPT/RS232 I/F Ctrl (ME1)
    AND	    #(CE158_PRT_A)                  ; Filter out changes (ME1)
    ANI	    A,$3C                           ; Keep Bits 2->CTS, 3->CD, 4->DSR, 5->Low Battery
    BZR     BRANCH_81E3                     ; Branch fwd if any bit 5-2 is set MODIFIED BRANCH ADDRESS
#ELSE
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
#ELSE
  	ROR
    AND	    #(CE158_UART_LSR0)              ; A = A & UART_STATUS. A=Bit6 of SETDEV_REG or $04
    SEC                                     ; Set carry flag = failure
    BZS     BRANCH_81E3                     ; Branch fwd if Bit7 (THRE) or Bit2 (PE) not set
    LDA	    UL                              ; Our original A is in UL. Charecter to send.

    STA	    #(CE158_UART_THR0)              ; Writes A to UART (ME1)
    REC                                     ; Reset Carry Flag = Success
    BCH     BRANCH_81E3

BRANCH_81E3A:
	SJP     DSRCTSFIX                       ; A = #(PORTA_IO) & 3C (Bits 5-2), failure type?
; <************
#ENDIF

BRANCH_81E3: ; Branched to from 81CA, 81DB 
    POP	    U                               ; Get original U back, affectes Z only
    RTN                                     ; A contains #(CE158_PRT_A) Bits 5-2 on failure

;% CHAR2COM END


;-------------------------------------------------------------------------------------------------------------
; RXCOM - Manipulates LPT/UART registers
; Same as High Bank
; called from 8CBD, 99BC.  Alt entry at 822C, 8CBD
; Arguments: None
; Outputs: REC = Success, A = Failure type or UART data read
; RegMod: A
;% RXCOM START
RXCOM: ; 81E6 ***!!!

#IFDEF ENBPD
;;    JMP     RXTYPE                            ; Figures out if RX should be from COM0, COM1, or LPT
;     BII     (CE158_REG_79DD),$40            ; (4) PN, 40 = LPT port to input
;     BZS     RXCOM_1                         ; (2) If we are not in LPT input mode keep going
;     REC                                     ; (1) Success flag
;     RTN                                     ; (1) Return, this path only used to simualte RXCOM flush

; RXCOM_1:
;     BII     (CE158_REG_79DD),$20            ; (4) Bit6 set = U1
; 	BZS     CONTRX                          ; (2) Intecept the RXCOM routine 
; 	JMP     U1RXCOM                         ; (3) and redirect to UART1 if enabled

#IFDEF LPTIN 
    BII     (CE158_REG_79DD),$40            ; (4) PN, 40 = LPT port to input
    BZS     RXCOM_1                         ; (2) If we are not in LPT input mode keep going
    JMP     RXLPT                           ; (3) Call LPT input
#ENDIF

RXCOM_1:
    BII     (CE158_REG_79DD),$20            ; (4) Bit6 set = U1
	BZS     RXCOM_00                        ; (2) Intecept the RXCOM routine 
	JMP     U1RXCOM                         ; (3) and redirect to UART1 if enabled

CONTRX:
#ENDIF

#IFDEF HANDSHAKE
    CALL    SET_RTS                         ; Sets RTS if it should be set
    NOP                                     ; ***probably can remove NOPs
    NOP
    NOP
#ENDIF  

RXCOM_00:
#IFNDEF CE158V2
; ************ Modified >
    LDA	    #(CE158_PRT_A)                  ; #(CE158_PRT_A) is LPT/RS232 I/F Ctrl (ME1)
    AND	    #(CE158_PRT_A)                  ; Filter out changes (ME1)
    ANI     A,$3C                           ; Keep Bits 2->CTS, 3->CD, 4->DSR, 5->Low Battery
    BZR     BRANCH_8230                     ; Branch fwd if any bits 5-2 were set, failure exit
    LDA     #(CE158_UART_REGR)              ; UART status register
#ELSE
; ************ Modified > 
    LDA	    #(CE158_UART_MSR0)              ; #(CE158_UART_MSR0) is RS232 I/F Ctrl (ME1)
    ;AND	    #(CE158_UART_MSR0)              ; Filter out changes (ME1)

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
#ELSE
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

#ELSE
 #IFDEF HANDSHAKE
    JMP     CLEAR_RTS                       ; ***!!! Reads byte into A and does HS test
    NOP                                     ; *** can we remove NOPS?
    NOP
 #ELSE
    LDA     #(CE158_UART_RBR0)              ; Read data byte 
    REC                                     ; REC = Success
    RTN                                     ; Carry flag indicates return state
 #ENDIF

BRANCH_822C: ; Branched to from 8185, 81FF ; OE Error
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
    ;NOP
;% RXCOM END


;------------------------------------------------------------------------------------------------------------
; TXCOM - not sure how this is called ***
; Checks that COM port ready and then calls CHAR2COM to TX char in A
; Arguments: A charecter to send
; Outputs:
; RegMod: UH
;% TXCOM START
TXCOM: ; 823A
    ANI	    (OUTSTAT_REG),$0F               ; Keep only low nibble Bit0 DTR, Bit1 RTS

BRANCH_823E: ; Branched to from 8250, 8256
    BII	    #(PC1500_IF_REG),$02            ; PC-1500 - IF Register Bit1 PB7 (ON Key)
    BZR     BRANCH_82B3                     ; If Bit 1 was set branch fwd to an exit (reset)
    PSH	    A                               ; Save character to TX
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

;% TXCOM END

;------------------------------------------------------------------------------------------------------------
; TXLPT - Called from 9893, 9899, 98AB, 98B1
; Sends data to LPT output function, same as in high bank
; Arguments: A = character to send
; Outputs: A = Error code, 20 = Low Battery, 00 = Could not send?, UH: 45 = success
; RegMod: UH
;% LB_TXLPT START
LB_TXLPT: ; 825B
    ANI	    (OUTSTAT_REG),$0F               ; Keep only low nibble Bit0 DTR, Bit1 RTS

BRANCH_825F: ; Branched to from 828A
    PSH     U                               ;
    LDI	    UL,$FF                          ; try to send FF times?
    LDI	    UH,$00                          ; U = 00FF

BRANCH_8265: ; Branched to from 8275, 8279
    BII	    #(PC1500_IF_REG),$02            ; PC-1500 - IF Register Bit1 PB7 (ON Key)
    BZR     BRANCH_82B1                     ; If Bit 1 was set branch fwd to an exit (reset)
    PSH	    A                               ; Save cahracter to TX
    SJP     LB_CHAR2LPT                     ; Sends character in A to LPT, Returns A as failure type
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
    
BRANCH_828E:    
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

;% LB_TXLPT END


; -----------------------------------------------------------------------------------------------------------
; Unused
;% UNUSED_82B7 START 
#IFNDEF CE158V2
UNUSED_82B7:
    .BYTE   $8E
#ENDIF

;% UNUSED_82B7 


.FILL ($82B8 - $)
.ORG $82B8
;------------------------------------------------------------------------------------------------------------
; COM_TBL_INIT - Called from BASIC table init vector 800A
; Called from BASIC Table 8000 INIT, changes XL which is used to calc index into vector table
; Arguments:
; Outputs:
; RegMod: XL
;% COM_TBL_INIT START 
COM_TBL_INIT:
    LDI	    XL,$D0                          ; D0 is command code for INIT
    ANI	    (CE158_REG_79DE),$EF            ; ***What is this a flag for? Clear bit to to signal start of INIT?
    BCH     MAIN_ENTRY                      ; Branch fwd unconditional

;% COM_TBL_INIT END


;------------------------------------------------------------------------------------------------------------
; Following called via BASIC Table 8000 Command List vectors
; X-REG contains address of function below. Some stubs below change XL. Most drop through.
; XL used to calculate index into vector table
; Arguments:
; Outputs:
; RegMod: UL, XL
;% MERGE_V START
MERGE_V: ;82C0
    INC	    UL                              ; Line number counter?
    LDI	    XL,$F0                          ; F0 a command code, used in MAIN_ENTRY
    BCH 	MAIN_ENTRY                      ; Branch fwd unconditional

COM_TBL_INPUT_NUM:
    LDI	    XL,$ED                          ; ED a command code, used in MAIN_ENTRY
    BCH 	MAIN_ENTRY                      ; Branch fwd unconditional

COM_TBL_PRINT_NUM:
    LDI	    XL,$EE                          ; EE a command code, used in MAIN_ENTRY
    BCH 	MAIN_ENTRY                      ; Branch fwd unconditional

LPTR_TBL_PRINT_NUM:
    LDI	    XL,$EF                          ; EF a command code, used in MAIN_ENTRY
    BCH 	MAIN_ENTRY                      ; Branch fwd unconditional

DTE_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

TERMINAL_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

LB_COM_STR_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

LB_DEV_STR_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

SETDEV_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

SETCOM_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

TRANSMIT_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

LB_CONSOLE_2V:
    REC                                     ; Reset Carry Flag, does nothing drop through

LB_FEED_2V:
    REC                                     ; Reset Carry Flag, does nothing drop through

LB_LPRINT_2V:
    REC                                     ; Reset Carry Flag, does nothing drop through

LB_LLIST_2V:
    REC                                     ; Reset Carry Flag, does nothing drop through
    REC                                     ; Reset Carry Flag, does nothing drop through

CSAVE_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

LB_CONSOL_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

ERN_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

ERL_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

LB_FEED_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

INPUT_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

INSTAT_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

LB_LPRINT_V:
    REC                                     ; Reset Carry Flag, does nothing drop through

LB_LLIST_V:
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

;% MERGE_V END


;------------------------------------------------------------------------------------------------------------
; MAIN_ENTRY - Called from 82BE, 82C3, 82C7, 82CB, 82CF ***JMP : Uses a calculated jump
; Arguments: X=Vector of address of BASIC table vector, XL=INIT=D0, INPUT#=ED,PRINT#=EE, PRINT#2=EF, MERGE=F0
; Outputs:
; RegMod: U, A, X
;% MAIN_ENTRY START 
MAIN_ENTRY: ;82EC
    RIE                                     ; Disable interrupts
    ANI     (OUTSTAT_REG),$F7               ; Clear Bit 3 = DCD (opposite of high bank)
    LDI	    UH,HB(ARW)                      ; Point U to ARW
    LDI	    UL,LB(ARW)                      ; U = 7A28 = ARW
    LDI	    A,$E1                           ; Intialize $7A28-$7A31 to: 
    SIN     U                               ; $E1 $BA $82 $F0 ->
    LDI	    A,$BA                           ; SPU, JMP $82F0
    SIN     U                               ; This code segment sets PU to 
    LDI	    A,HB(HB_JMP_FRM_LB)             ; bank in upper half of
    SIN     U                               ; the CE-158 ROM
    LDI	    A,LB(HB_JMP_FRM_LB)             ; 
    STA     (U)                             ; Jumps to $7A28, runs code segment

BRANCH_8302:
    JMP	    ARW                             ; POKED in above, swtiches to HI bank.

;% MAIN_ENTRY END


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
;% LB_RTN_FRM_HB START
LB_RTN_FRM_HB: ; 8305                   ; High bank jumps back here for the above commands
    SIE                                     ; X = new address passed from high bank
    STX     P                               ; Jump to address by poking program counter ***JMP

;% LB_RTN_FRM_HB END


;------------------------------------------------------------------------------------------------------------
; ERL - Jumped to from 8307 via High Bank
; 0=No error, >0=Line at which error occured
; Arguments:
; Outputs:
; RegMod:
;% ERL_F START
ERL_F:
    VEJ     (F4)                            ; Loads U-Reg with 16-bit value from address of ($78B4)
                AWRD(ERR_LINE_H)            ; 
    LDI     XL,LBO(BCMD_MEM,$0F)            ; X = DA6C? Inside BASIC command MEM
    LDI     XH,HBO(BCMD_MEM,$0F)            ; 
    BCH 	BRANCH_8363                     ; Borrows exit of SPACE_STR__ZONE

;% ERL_F END


;------------------------------------------------------------------------------------------------------------
; ERN - Jumped to from 8307 via High Bank
; Error code 0-255
; Arguments:
; Outputs:
; RegMod:
; Branched to via High Bank
;% ERN START
ERN:
    LDA     (ERL)                           ; Load error #, if any, into Accumulator
    BCH 	BRANCH_8330                     ; Borrows exit of SPACE_STR__ZONE (eventually)

;% ERN END


;------------------------------------------------------------------------------------------------------------
; PROTOCOL - Jumped to from 8307 via High Bank
; Protocol used in Terminal, XON/XOFF, ECHO
; Arguments:
; Outputs:
; RegMod:
;% PROTOCOL START
PROTOCOL:
    VEJ     (C2)                            ; If next char not token 'ON' (F1 9C) branch fwd 5, $8320
                AWRD(TOK_ON)                ; 'ON' Token
                ABRF(BRANCH_8320)           ; Forward branch to label
    ANI	    (ZONE_REG),$7F                  ; AND ZONE_REG (&7856) with $7F
    VEJ     (E2)                            ; Start of Basic Interpreter

BRANCH_8320: ;branched to from 8317
    VEJ     (C4)                            ; If next char not token 'OFF' (F1 9E) branch fwd 5, $8329
                AWRD(TOK_OFF)               ; 'OFF' Token
                ABRF(BRANCH_8329)           ; Forward branch to label   
    ANI	    (ZONE_REG),$7F                  ; AND ZONE_REG (&7856) with $7F
    VEJ     (E2)                            ; Start of Basic Interpreter

BRANCH_8329: ;branched to from 8320
    VEJ     (E4)                            ; Output error 1 and return to the editor

;% PROTOCOL END


;------------------------------------------------------------------------------------------------------------
; INSTAT - Jumped to from 8307 to via High Bank
; Returns state of RS232 hansshaking signals (0-31)
; Bit4 = DSR, Bit3 = CD, Bit2 = CTS. Bit1 = RTS, Bit0 = DTR
; Arguments:
; Outputs:
; RegMod:
;% INSTAT START 
INSTAT:
#IFDEF CE158V2
; ************ Modified >
    SJP     INSTAT_FIX                      ;
#ELSE
    LDA     #(CE158_PRT_A)                  ; 
; <************
#ENDIF
    ANI     A,$1F                           ; Clear bits 5-7, Low Battery / 2 of Baud Rate Select Bits

BRANCH_8330: ;branched to from 8315
    LDI     XL,$E4                          ;
    BCH 	BRANCH_8360                     ; Branch forward unconditional

;% INSTAT END


.FILL ($8334 - $),$FF
.ORG $8334
;------------------------------------------------------------------------------------------------------------
; OUTSTAT - Jumped to from 8307 via High Bank
; Sets state of RS232 hansshaking signals (0-31)
; Bit4 = DSR, Bit3 = CD, Bit2 = CTS. Bit1 = RTS, Bit0 = DTR 
; Arguments:
; Outputs:
; RegMod:
;% OUTSTAT START
OUTSTAT:
    VEJ     (DE)                            ; Calc formula Y-reg points to, result to AR-X, Branch fwd to 8356 on error
                ABRF(BRANCH_8356)           ; Forward branch to label
    VEJ     (D0)                            ; Convert AR-X to INT send to U, range of 4, branch fwd to 8356 on error
                ABYT($04)                   ; Low byte of address
                ABRF(BRANCH_8356)           ; Forward branch to label
    ANI	    (ARX + $06),$03                 ; keep bits 0-1 of argument
    LDA	    (OUTSTAT_REG)                   ;
    ANI     A,$FC                           ; clear bits 0-1, DTR, RTS
    ORA     (ARX + $06)                     ; 
    STA 	(OUTSTAT_REG)                   ; Sets DTR and RTS from calc in 8334?

#IFNDEF CE158V2
; ************ Modified >
    LDA     #(CE158_PRT_A)                  ; 
    ANI     A,$FC                           ; clear bits 0-1, DTR, RTS
    ORA 	(ARX + $06)
    STA     #(CE158_PRT_A)                  ; Also set DTR/RTS bits on CE-158

#ELSE

    SJP     OUTSTAT_FIX
; <************
#ENDIF

    VEJ     (E2)                            ; Start of Basic Interpreter

BRANCH_8356: ; branched to from 8334, 8336
    VEJ     (E0)                            ; Indicates if UH is not "00" error message

;% OUTSTAT END


.FILL ($8357 - $),$FF
.ORG $8357
;------------------------------------------------------------------------------------------------------------
; RINKEY_STR - Branched to from 8307 via High Bank
; Returns last byte RXd on COM, UART version of INKEY$
; Arguments: 
; Outputs: ASCII code from UART, $00 = no input
; RegMod:
;% RINKY_STR START 
RINKY_STR:
    SJP 	RXCOM                           ; Manipulates LPT/UART registers
    BCR     BRANCH_835E                     ; REC = Success, A = Failure type or UART data read
    LDI	    A,$00                           ; 

BRANCH_835E: ; branched to from 835A
    LDI     XL,LBO(BCMD_INKY,$03)           ;

BRANCH_8360: ; branched to from 8332
    LDI     XH,HBO(BCMD_INKY,$03)           ; X = D9AD, inside INKEY$
    STA     UL                              ;

BRANCH_8363: ;branched to from 8310
    BCH 	BRANCH_83FC                     ; Branch forward unconditional

;% RINKY_STR END


;------------------------------------------------------------------------------------------------------------
; CONSOLE - Branched to from 8307 via High Bank
; Specifies #digits per line. Specifies EOL char TXd (default is CR)
; Arguments:
; Outputs:
; RegMod:
;% CONSOLE START 
CONSOLE:
    VEJ     (C8)                            ; Syntax check: Jump fwd 5F (83C6) if not end of line/sequence 
                ABRF(BRANCH_83C6)           ; Forward branch to label
    LDI     UL,$00                          ;
    DEC     Y                               ;

BRANCH_836A: ;branched to from 83CD, 83DF, 83D4
    LDA	    (OPN)                           ; Which BASIC extension table is searched first
    CPI     A,$C4                           ; $60=COM, $C4=LPRT
    BZS     BRANCH_8377                     ; Branch fwd if A = C4
    LDA     UL                              ;
    STA	    (RS232C)                        ; Console 1 RS232C
    BCH 	BRANCH_837B                     ; Branch unconditional to 837B

BRANCH_8377:  ;branched to from 836F
    LDA     UL                              ;
    STA	    (CONSOLE2)                      ; Console 1 (//)

BRANCH_837B: ;branched to from 8375
    VEJ     (C8)                            ; Syntax check: Jump fwd 02 (837F) if not end of line/sequence
                ABRF(BRANCH_837F)           ; Forward branch to label
    DEC     Y                               ; what is Y counting?
    VEJ     (E2)                            ; Start of Basic Interpreter

BRANCH_837F: ;branched to from 837B
    VEJ     (C4)                            ; If U-Reg != ',' branch fwd 55 (83D7)
                ACHR(COMMA)                 ; Character
                ABRF(BRANCH_83D7)           ; Forward branch to label
    VEJ     (DE)                            ; Calc formula Y-reg points to, res to AR-X, Branch fwd 52 to 83D6 on error
                ABRF(BRANCH_83D6)           ; Forward branch to label
    VEJ     (D0)                            ; Convert AR-X to INT send to U, range of 8, branch fwd 4F to 83D6 on error
                ABYT($08)                   ; Low byte of address
                ABRF(BRANCH_83D6)           ; Forward branch to label
    LDI     UH,$13                          ;
    CPI     A,$02                           ; What sets A?
    VCS     ($E0)                           ; If A >= 02 do VEJ (E0) 'Is UH "00" error message'
    PSH     U                               ;
    VEJ     (C8)                            ; Jump fwd 06 (8397) if not end of line/sequence
                ABRF(BRANCH_8397)           ; Forward branch to label    

    LDA     UH                              ;
    DEC     Y                               ;
    POP     U                               ;
    BCH     BRANCH_83A6                     ; Unconditional forward branch

BRANCH_8397: ;branched to from 838F
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not ',' branch fwd 3D (83D7)
                ACHR(COMMA)                 ; Character
                ABRF(BRANCH_83D7)           ; Forward branch to label
    VEJ     (DE)                            ; Calc formula Y-reg points to, res to AR-X, Branch fwd 3A to 83D6 on error
                ABRF(BRANCH_83D6)           ; Forward branch to label
    VEJ     (D0)                            ; Convert AR-X to INT send to U, range of 8, branch fwd 37 to 83D6 on error
                ABYT($08)                   ; Low byte of address
                ABRF(BRANCH_83D6)           ; Forward branch to label    
    POP     U                               ;
    CPI     A,$02                           ;
    VCS     ($E0)                           ; If A >= 02 do VEJ (E0) 'Is UH "00" error message'
    INC	    A                               ;

BRANCH_83A6: ;branched to from 8395
    SHL                                     ; Shift A left, A = A * 2
    ADC	    UL                              ; A = A + UL
    STA	    UL                              ;
    LDA	    (OPN)                           ; Which BASIC extension table is searched first
    CPI     A,$C4                           ; $60=COM, $C4=LPRT
    BZS     BRANCH_83B1                     ; If A=(79D1)=C4 branch fwd to 83B1
    REC                                     ; Reset carry flag

BRANCH_83B1: ;branched to from 83AE
    LDA     UL                              ; Branched to if 79D1=C4, carry set if branched
    BCS     BRANCH_83BA                     ; Branch fwd if 79D1=C4
    ANI     (CRLF_REG),$F8                  ; Clear bits 0-2
    BCH 	BRANCH_83BF                     ; Branch unconditional fwd

BRANCH_83BA: ;branched to from 83B2
    ANI	    (CRLF_REG),$8F                  ; clear bits 4,5,6 -           7 x x x 3 2 1 0
    AEX                                     ; Swap high/low nibbles of A - 3 2 1 0 7 x x x

BRANCH_83BF: ;branched to from 83B8         ; if dropped thru from 83BE 3 2 1 0 7 x x x 
    ORA	    (CRLF_REG)                      ;                 OR'd with 7 6 5 4 3 2 1 0 
    STA	    (CRLF_REG)                      ; why?
    VEJ     (E2)                            ; Start of Basic Interpreter

BRANCH_83C6: ;branched to from 8365 
    VEJ     (C6)                            ; DEC Y by 2 for tokens or 1 for characters in U reg
    VEJ     (DE)                            ; Calc formula Y-reg points to, res to AR-X, Branch fwd 0D to 83D6 on error
                ABRF(BRANCH_83D6)           ; Forward branch to label
    VEJ     (D0)                            ; Convert AR-X to INT send to U, range of 8, branch fwd 0A to 83D6 on error
                ABYT($08)                   ; Low byte of address
                ABRF(BRANCH_83D6)           ; Forward branch to label    
    
    LDA     UL                              ;
    BZS     BRANCH_836A                     ; If A=UL=0 branch back
    DEC	    UL                              ; If not zero DEC
    CPI	    UL,$0F                          ; 
    LDI	    UH,$13                          ; 
    BCS     BRANCH_836A                     ; If UL >=0f Branch back

BRANCH_83D6: ;branched to from 8382, 8384, 839A, 839C, 83C7, 83C9
    VEJ     (E0)                            ; Indicates if UH is not "00" error message

BRANCH_83D7: ;branched to from 837F, 8397
    VEJ     (E4)                            ; Output error 1 and return to the editor

;% CONSOLE END


;------------------------------------------------------------------------------------------------------------
; SPACE_STR__ZONE - Branched to from 8307 via High Bank, ***JMP : Uses a calculated jump
; SPACE$ arg : (0-32d) Number of spaces
; ZONE arg   : (1-31d) Determine the block length of comma seperate data sent over COM with LPRINT
; Arguments  : XREG = Address, YREG = Token, AR-X is argument after command
; Outputs:
; RegMod:
;% CSPACE_STR__ZONE START 
SPACE_STR__ZONE:
    VEJ     (D0)                            ; Convert AR-X to INT send to U, range of 8, branch fwd 83F8 on error
                ABYT($08)                   ; Low byte of address
                ABRF(BRANCH_83F8)           ; Forward branch to label    
    
    CPI	    UL,$21                          ;
    LDI	    UH,$19                          ; U = 1921
    BCS     BRANCH_83F8                     ; If UL >= 33d branch fwd, out of range
    LDI	    XL,LB(ARZ)                      ;
    LDI	    XH,HB(ARZ)                      ; X=7A08, ARZ
    LDA     UL                              ; UL is command's argument
    BZS     BRANCH_83F2                     ; If argument=0 branch fwd
    STA	    UH                              ; UH = argument (1-31d)
    DEC	    UL                              ; UL = argument - 1 (0-30d)
    LDI	    A,$20                           ; ASCII for space

BRANCH_83EC: ;branched to from 83ED         ; Fills AR-Z with arg# of spaces
    SIN     X                               ; (X) = A. Then X = X + 1. Copies A to (X) to (X + UL)
    LOP 	UL,BRANCH_83EC                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set
    LDI	    XL,$08                          ; X = 7A08
    LDA 	UH                              ; A = UH = argument

BRANCH_83F2: ;branched to from 83E6         ; Branch here if is argument = 0
    SJP	    XREG2STRBUF                     ; X points to string to insert into String buffer. UL = #of chars
                ABRF(BRANCH_83F8)           ; Jump if overflow
    LDI	    UH,$00                          ;

BRANCH_83F8: ;branched to from 83D8, 83DF, 83F2 ; Branched to if argument out of range
    LDI	    XH,HB(B_TBL_8000_JMPS)          ; Setting the destination address for 840A
    LDI	    XL,LB(B_TBL_8000_JMPS)          ; X=8013

BRANCH_83FC: ;branched to from 8363 RINKY$
    LDI 	A,$38                           ; Is this finding if this is OUTSTAT or CR/LF command?
    BII	    (OUTSTAT_REG),$08               ; Keep Bit3, DCD
    BZS     BRANCH_840A                     ; If Bit3 was not set
    LDI 	A,$E1                           ; 
    ORI	    (CRLF_REG),$08                  ; Set Bit3 in (CR/LF)

BRANCH_840A:
    STA	    (ARS)                           ; Store A, (38) NOP or (E1) SPU to ARS
    LDI	    A,$24                           ; SPU swtiches to High Bank of ROM
    STA	    (ARS + $01)                     ; next opcode, UL is argument of command
    LDI     A,$FD                           ; then: (24)      LDA UL
    STA	    (ARS + $02)                     ;       (FD 5E)   STX P ***JMP
    LDI	    A,$5E                           ; Which saves X-Reg (8013) to PC (X set in 83F8)
    STA	    (ARS + $03)                     ; i.e. this is destination address
    JMP	    ARS                             ; X = 8013 == B_TBL_8000_JMPS, low ROM is just (9A) RET
    VEJ     (F8)                            ; High ROM has: (BA 79 FA 9A) JMP 79FA, RET

;% CSPACE_STR__ZONE END


;------------------------------------------------------------------------------------------------------------
; TABLE_8420
; Seems like nonsense, does not appear to be used
;% TABLE_8420 START
TABLE_8420:
    .BYTE	$40,$7F,$00,$FF,$00,$FF,$40,$77,$00,$7F,$00,$FF,$00,$FF,$0B,$F7 
    .BYTE	$4A,$7D,$00,$FF,$00,$FF,$43,$DF,$02,$27,$00,$FF,$00,$FF,$06,$F7 
    .BYTE	$26,$FD,$00,$FF,$00,$FF,$08,$BF,$45,$EA,$00,$FF,$00,$FF,$11,$FF 
    .BYTE	$12,$FF,$00,$FF,$00,$FF,$01,$DE,$10,$5A,$00,$FF,$00,$FF,$11,$F2 
    .BYTE	$80,$FD,$00,$FF,$00,$FF,$22,$7D,$92,$EB,$00,$FF,$00,$FF,$00,$4F 
    .BYTE	$94,$3D,$00,$FF,$00,$FF,$03,$D6,$42,$AE,$00,$FF,$00,$FF,$46,$FE 
    .BYTE	$38,$EF,$00,$FF,$00,$FF,$86,$DF,$A0,$BF,$00,$FF,$00,$FF,$00,$FF 
    .BYTE	$42,$FF,$00,$FF,$00,$FF,$00,$8B,$03,$F5,$00,$FF,$00,$FF,$10,$FF 
    .BYTE	$17,$B2,$00,$FF,$00,$FF,$08,$FF,$48,$9D,$00,$FF,$00,$FF,$03,$FD 
    .BYTE	$12,$F7,$00,$FF,$00,$FF,$D0,$DF,$00,$AF,$00,$FF,$00,$FF,$08,$DD 
    .BYTE	$80,$7D,$00,$FF,$00,$FF,$04,$7F,$0A,$BB,$00,$FF,$00,$FF,$00,$EF 
    .BYTE	$40,$FE,$00,$FF,$00,$FF,$14,$7B,$00,$E6,$00,$FF,$00,$FF,$04,$4F 
    .BYTE	$22,$39,$00,$FF,$00,$FF,$00,$7D,$55,$6D,$00,$FF,$00,$FF,$34,$9D 
    .BYTE	$10,$DF,$00,$FF,$00,$FF,$65,$AD,$60,$DF,$00,$FF,$00,$FF,$02,$DF 
    .BYTE	$28,$FF,$00,$FF,$00,$FF,$42,$D6,$01,$EE,$00,$FF,$00,$FF,$94,$F4 
    .BYTE	$82,$FC,$00,$FF,$00,$FF,$27,$7C,$08,$BF,$00,$FF,$00,$FF,$46,$DF 
    .BYTE	$0D,$33,$00,$FF,$00,$FF,$02,$CF,$19,$FC,$00,$FF,$00,$FF,$10,$FD 
    .BYTE	$00,$E9,$00,$FF,$00,$FF,$58,$DB,$1A,$FF,$00,$FF,$00,$FF,$44,$FB 
    .BYTE	$31,$EF,$00,$FF,$00,$FF,$80,$E7,$00,$7C,$00,$FF,$00,$FF,$80,$EF 
    .BYTE	$C8,$DF,$00,$FF,$00,$FF,$00,$7F,$58,$FB,$00,$FF,$00,$FF,$01,$77 
    .BYTE	$22,$78,$00,$FF,$00,$FF,$28,$FF,$84,$F3,$00,$FF,$00,$FF,$90,$F2 
    .BYTE	$64,$FF,$00,$FF,$00,$FF,$91,$FF,$16,$FF,$00,$FF,$00,$FF,$F0,$BF 
    .BYTE	$58,$B5,$00,$FF,$00,$FF,$14,$7A,$21,$7F,$00,$FF,$00,$FF,$00,$DF 
    .BYTE	$12,$FF,$00,$FF,$00,$FF,$30,$FB,$11,$AF,$00,$FF,$00,$FF,$32,$FE 
    .BYTE	$C4,$FE,$00,$FF,$00,$FF,$39,$DF,$CA,$FF,$00,$FF,$00,$FF,$C4,$DD 
    .BYTE	$91,$BF,$00,$FF,$00,$FF,$02,$FC,$62,$BB,$00,$FF,$00,$FF,$21,$FF 
    .BYTE	$00,$CF,$00,$FF,$00,$FF,$10,$96,$00,$CF,$00,$FF,$00,$FF,$00,$F7 
    .BYTE	$44,$F5,$00,$FF,$00,$FF,$04,$FC,$5C,$ED,$00,$FF,$00,$FF,$18,$7F 
    .BYTE	$00,$BD,$00,$FF,$00,$FF,$88,$FF,$61,$DE,$00,$FF,$00,$FF,$00,$DD 
    .BYTE	$B8,$B6,$00,$FF,$00,$FF,$02,$EF,$4A,$FF,$00,$FF,$00,$FF,$0A,$AE 
    .BYTE	$E1,$B8,$00,$FF,$00,$FF,$22,$AB,$10,$3F,$00,$FF,$00,$FF,$2A,$F6 
    .BYTE	$48,$FF,$00,$FF,$00,$FF,$2D,$EF,$86,$E3,$00,$FB,$00,$FF,$0A,$FB 
    .BYTE	$59,$73,$00,$FF,$00,$FF,$31,$8B,$90,$D5,$00,$FF,$00,$FF,$49,$BD 
    .BYTE	$01,$FA,$00,$FF,$00,$FF,$90,$9E,$80,$5F,$00,$FF,$00,$FF,$04,$F5 
    .BYTE	$00,$7F,$00,$FF,$00,$FF,$30,$B6,$10,$FB,$00,$FF,$00,$FF,$38,$F7 
    .BYTE	$01,$A7,$00,$FF,$00,$FF,$81,$5F,$01,$EA,$00,$FF,$00,$FF,$03,$F6 
    .BYTE	$60,$ED,$00,$FF,$00,$FF,$04,$FB,$21,$F7,$00,$FF,$00,$FF,$84,$FF 
    .BYTE	$10,$DF,$00,$FF,$00,$FF,$20,$F3,$08,$BF,$00,$FF,$00,$FF,$32,$7D 
    .BYTE	$04,$FF,$00,$FF,$00,$FF,$29,$ED,$E5,$5E,$00,$FF,$00,$FF,$2D,$DF 
    .BYTE	$29,$EE,$00,$FF,$00,$FF,$30,$5F,$20,$BF,$00,$FF,$00,$FF,$00,$EB 
    .BYTE	$00,$ED,$00,$FF,$00,$FF,$A0,$FF,$00,$7F,$00,$FF,$00,$FF,$42,$FF 
    .BYTE	$3A,$7E,$00,$FF,$00,$FF,$22,$7F,$50,$FD,$00,$FF,$00,$FF,$04,$7A 
    .BYTE	$20,$FE,$00,$FF,$00,$FF,$51,$DF,$86,$FF,$00,$FF,$00,$FF,$10,$FF 
    .BYTE	$05,$37,$00,$FF,$00,$FF,$04,$87,$D0,$BF,$00,$FF,$00,$FF,$08,$85 
    .BYTE	$28,$5E,$00,$FF,$00,$FF,$41,$DF,$94,$57,$00,$FF,$00,$FF,$00,$E7 
    .BYTE	$4A,$EF,$00,$FF,$00,$FF,$02,$7F,$05,$FD,$00,$FF,$00,$FF,$00,$E7 
    .BYTE	$10,$00,$00,$D3,$00,$7F,$02,$00,$10,$00,$00,$F9,$00,$EF,$12,$00 
    .BYTE	$D8,$00,$00,$5B,$00,$7F,$A4,$00,$80,$00,$00,$7F,$00,$B5,$09,$00 
    .BYTE	$08,$00,$00,$EC,$00,$87,$8C,$00,$05,$00,$00,$FD,$00,$F5,$01,$00 
    .BYTE	$D8,$00,$00,$5D,$00,$7B,$16,$00,$00,$12,$00,$26,$00,$4F,$80,$00 
    .BYTE	$00,$00,$00,$F7,$00,$FF,$D1,$00,$85,$00,$00,$BF,$00,$3F,$22,$40 
    .BYTE	$02,$00,$00,$FD,$00,$C9,$84,$00,$C0,$00,$00,$BF,$00,$74,$00,$00 
    .BYTE	$80,$00,$00,$E6,$00,$FF,$30,$00,$A0,$20,$00,$B5,$00,$E2,$38,$00 
    .BYTE	$C0,$00,$00,$FB,$00,$EE,$20,$00,$B0,$00,$00,$FC,$00,$FC,$10,$24 
    .BYTE	$A0,$00,$00,$3F,$00,$FD,$00,$00,$01,$02,$00,$FD,$00,$79,$E0,$00 
    .BYTE	$C8,$00,$00,$93,$00,$23,$E0,$00,$1D,$00,$00,$F7,$00,$6B,$00,$00 
    .BYTE	$80,$00,$00,$FD,$00,$FF,$98,$00,$18,$00,$00,$EB,$00,$4E,$42,$00 
    .BYTE	$08,$00,$00,$FE,$00,$EF,$05,$00,$11,$00,$00,$6B,$00,$FB,$08,$00 
    .BYTE	$41,$00,$00,$FB,$00,$FC,$00,$04,$10,$04,$00,$FE,$00,$FF,$22,$00 
    .BYTE	$80,$20,$00,$EF,$00,$E7,$02,$80,$10,$00,$00,$FC,$00,$FB,$C0,$40 
    .BYTE	$20,$00,$00,$AF,$00,$2F,$4A,$00,$C0,$00,$00,$FF,$00,$B1,$00,$00 
    .BYTE	$20,$40,$00,$BF,$00,$BF,$61,$00,$04,$00,$00,$77,$00,$FF,$0C,$00 

;% TABLE_8420 END


;------------------------------------------------------------------------------------------------------------
; BASIC Command Table 8800
;------------------------------------------------------------------------------------------------------------
;% B_TBL_8800 START 
B_TBL_8800:
    .BYTE   $55                             ; Marker that BASIC Table follows  

B_TBL_8800_TNUM:
    .BYTE   $09                             ; Table number 

B_TBL_8800_NAME:
    .TEXT   "LPRT\r\r\r\r"                  ; Table name

B_TBL_8800_INIT:
    LDI     UH,$01                          ; Table initilization vector
    RTN

B_TBL_8800_INPUT_NUM:
    LDI	    UH,$1B                          ; Table INPUT# vector (Jumps to MERGE)
    VEJ     (E0)                            ; Is UH "00" error message

B_TBL_8800_PRINT_NUM:
    JMP	    $82CD                           ; Table PRINT# vector (Jumps to MERGE)

B_TBL_8800_JMPS:
    .BYTE $9A,$9A,$9A,$9A,$9A,$9A,$9A,$9A,$9A,$BA   ; 

B_TBL_8800_TRACE:
    VEJ     (C4) \                          ; Correct per book. Not used?
                ABYT($AF) \                 ; Low byte of address
                ABRF($811F)                 ; Forward branch to label

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
    .WORD   LET_L2                          ; 886B

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
    .WORD   LET_T2                          ; 8880

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

B_TBL_8800_CMD_LST:                      
;                                        Token LB < 80 command is function, else is proceedure
;Ctrl nibble    Ctrl nib calc            Name               Token  Vector
LET_C2: EQU ($ + 2) ; First keyword starting with 'C'. LET_C2 = Address of 'O' in CONSOLE
CN28:   EQU $D7 \ CNIB($D7,CN28)    \ .TEXT "CONSOLE" \ .WORD $F0B1, LB_CONSOLE_2V ; 82D8

LET_F2: EQU ($ + 2) ; ($ + 2) ; First keyword starting with 'F'. LET_F2= Address of 'E' in FEED
CN29:   EQU $D4 \ CNIB(CN28,CN29)   \ .TEXT "FEED"    \ .WORD $F0B0, LB_FEED_2V    ; 82D9

LET_L2: EQU ($ + 2) ; First keyword starting with 'L'. LET_L2= Address of 'P' in LPRINT
CN30:   EQU $C6 \ CNIB(CN29,CN30)   \ .TEXT "LPRINT"  \ .WORD $F0B9, LB_LPRINT_2V  ; 82DA
CN31:   EQU $D5 \ CNIB(CN30,CN31)   \ .TEXT "LLIST"   \ .WORD $F0B8, LB_LLIST_2V   ; 82DB 

LET_S2: EQU $00
LET_T2: EQU ($ + 2) ; First keyword starting with 'T'. LET_T2= Address of 'A' in TAB
CN32:   EQU $D3 \ CNIB(CN31,CN32)   \ .TEXT "TAB"     \ .WORD $F0BB, B_TBL_8800_INPUT_NUM  ; 880D

CN33:   EQU $D0 \ .BYTE CN33 

B_TBL_8800_CMD_LST_END:
.BYTE $D0

;% B_TBL_8800 END


#IFDEF ENBPD
;------------------------------------------------------------------------------------------------------------
; BPD_CMD - CLOAD, CSAVE, MEREGE are intercepted and here we inject PRINT#"L)filename" or PRINT#"S)filename" 
;           to signal Backpack of upcoming file use. Then it proceeded with the CLOAD/CSAVE/MERGE
; We are using the unused space in TBL_8888 for BPD code
; On entering Y points to first " and A=00=CSAVE, A=01=CLOAD or MERGE
;% BPD_CMD START
BPD_CMD:
INJCMD:     EQU (IN_BUF + $30)              ; $7BE0 Start address of injected command
INJFLAG:    EQU (IN_BUF + $4F)              ; $7BFF Address of flag used to signal injected command

    PSH     Y                               ; On entering Y points to first " after command
    PSH     A                               ; A=00=CSAVE, A=01=CLOAD or MERGE

    ; Step #1 - configure UART - Set values for BPD use
    LDI     A,BPSBP                         ; SETCOM to 2400/4800/19200 depending on config
    STA     (SETCOM_REG)                    ; 

    ;LDA     (SETDEV_REG)                    ;
    ;ANI     A,$E0                           ; clears bits 4-0
    ORI     (SETDEV_REG),(CI | CO)          ; Set both CI and CO bits, make sure we stay in BPD mode
    ;STA     (SETDEV_REG)                    ;

    LDI     A,$C0                           ; Set OPN to point to CE-158 Basic Tables
    STA     (OPN)                           ; 

    ; Copy high bank calling code into RAM
    LDI     XH,HB(ORIGPC)                   ; Copy high bank calling code into RAM
    LDI     XL,LB(ORIGPC)                   ; Set up pointers to copy code into RAM
    LDI     YH,HB(ARW)                      ; which calls functions in High Bank
    LDI     YL,LB(ARW)                      ; $7A28 = AR-W

CLOOP:
    TIN                                     ; (Y) = (X) then X = X + 1, Y = Y + 1
    CPI     YL,LB(ARW + $09)                ; Stop if now at $7A31
    BZR     CLOOP                           ; If XL < $90 keep copying

    ; Now call code just POKED in
    SJP     ARW                             ; Call code we just POKED into RAM

    ; We do OUTSTAT CFG here as it is simple
    LDA	    (OUTSTAT_REG)                   ; Configure OUTSTAT
    ANI     A,$FC                           ; clear bits 0-1, DTR, RTS (OUTSTAT 0)
    STA     (OUTSTAT_REG)                   ; Sets DTR and RTS from calc in 8334? OUTSTAT 7850

#IFNDEF CE158V2
    LDA     #(CE158_PRT_A)                  ; 
    ANI     A,$FC                           ; clear bits 0-1, DTR, RTS (OUTSTAT 0)
    STA     #(CE158_PRT_A)                  ; Also set DTR/RTS bits on CE-158
#ELSE
    EAI     $03                             ; Invert the bits. The TI chip inverts these bits.
    ANI     #(CE158_UART_MCR0),$FC          ; Clear RTS/DTR bits
    ORA     #(CE158_UART_MCR0)              ; Set the RTS/DTR bits
    STA     #(CE158_UART_MCR0)              ;
#ENDIF

    ; Step #2 - Send $20, $0D (space/cr) to wake BPD+ up
    LDI     A,$20                           ; ASCII SPACE character
    SJP     TXCOM                           ; Send one space character
    LDI     A,$0D                           ; ASCII CR character
    SJP     TXCOM                           ; Send one space character
    LDI     A,$D0                           ; Delay 2*15.6ms for BPD+ to wake up
    SJP     DELAY_A_MS                      ; about 3 seconds


    ; Step #3 - Inject PRINT#"L)filename", this is done by poking code into RAM
    ; First copy PRINT#"L)  then POP A to derive mode char. A=0 char=S, A=1 char=L
    ; Then POKE in " and $0D
    ; POP Y / PSH to get pointer to filename and still preserve it for CLOAD/CSAVE/MERGE
    LDI XH,HB(PRNUM_DAT)                    ; Set up pointers to program line to inject
    LDI XL,LB(PRNUM_DAT)                    ;
    LDI YH,HB(INJCMD)                       ; Set up pointer to location to copy line to
    LDI YL,LB(INJCMD)                       ;    

CLOOP1:
    TIN                                     ; (Y) = (X) then X = X + 1, Y = Y + 1
    CPI YL,LBO(INJCMD,$00)                  ; $00
    BZR CLOOP1                              ; If XL < $00 keep copying

    POP A                                   ; $00=CSAVE (char=S), $01=CLOAD or MERGE (char=L)
    BZR PRFIN                               ; If A = 1 skip ahead
    LDI A,'S'                               ; If A = 0 POKE in the S character, for SAVE
    STA (INJCMD + $04)                      ;

PRFIN:
    LDI YH,HBO(INJCMD,$06)                  ; Set up pointer to next byte past )
    LDI YL,LBO(INJCMD,$06)                  ; 

    POP X                                   ; X=Y from original CLOAD/CSAVE/MERGE call
    PSH X                                   ; Points to first ", save it again for CLOAD/CSAVE/MERGE use later
    INC X                                   ; Now X points to first character of file name
    LDA (X)                                 ;
    CPI A,$22                               ; If ASCII or ML load we will be at first " 
    BZR CLOOP2                              ;  we want to be at first letter of filename so,
    INC X                                   ;  INC one more time to get to file name

CLOOP2:
    LDA (X)                                 ; A = (X) get char from file name
    INC X                                   ; INC X
    SIN Y                                   ; Y=A, Y=Y+1
    CPI A,$22                               ; Did we just copy trailing " 
    BZR CLOOP2                              ; If not keep copying    


    LDI YH,HBO(INJCMD,$03)                  ; Set up pointer to next byte past )
    LDI YL,LBO(INJCMD,$03)                  ; 

    SJP PRINT_NUM_HANDLER                   ; Call Print#""


    ANI (INJFLAG),$00                       ; Clear marker byte so CLOAD/CSAVE/MERGE will exit as normal
    POP Y                                   ; Get back original Y used for CLOAD/CSAVE/MERGE
    RET                                     ; Return to _REDIRECT which sets A properly and jumps back to CLOAD/CSAVE/MERGE

;% BPD_CMD END



ORIGPC:     EQU $                           ; Save current PC
.ORG INJCMD                                 ; Set new PC to where this code will be POKE into RAM
;------------------------------------------------------------------------------------------------------------
; UART CFG code POKE into ARW-ARS in Step #1. Calls routines in High Bank (9 bytes)
;%  BPD_ARW START
BPD_ARW:
    SPU                                     ; ($E1) High bank: SPV SPU 
    
    SJP     HB_CFG_URT_BD                   ; ($BE,$8B,$3D) CALL CFG_UART_BAUD (&8B3D)
    SJP     HB_CFG_URT_LPT                  ; ($BE,$8B,$72) CALL CFG_UART_LPT (&8B72)
    
    RPU                                     ; ($E3) Low bank: SPV RPU
    RTN                                     ; ($9A) Back to RAM routine

.ORG (ORIGPC + ($-INJCMD))                  ; Set PC back to original range

PRNUM_DAT: ; used by Step #2
    ;     PRINT   #    "   L   $24=$ provides 5 second delay, $29=) provides 30 second delay"
    .BYTE $F0,$97,$23,$22,$4C,$24,$0D,$0D, $0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D ; 7B80-7B8F PRINT#"$)file"
    .BYTE $0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D, $0D,$0D,$0D,$0D,$0D,$0D,$0D,$A5 ; $A5 is injected command marker

;%  BPD_ARW END


;------------------------------------------------------------------------------------------------------------    
; We intercept the CSAVE, MERGE and CLOAD entries to here
; If in BPD mode run BPD set up code first, then jump back to normal command handler
;%  CSAVE_INTERCEPT START
CSAVE_INTERCEPT: ;  Intercept CSAVE, CLOAD, MERGE
    BII     (CE158_REG_79DD),$80            ; BPD mode flag
    BZS     CSI_EXIT                        ;
    LDI     A,$00                           ; A=$00=CSAVE was called (for BPD code)
    SJP     BPD_CMD                         ; Configure for BPD use

CSI_EXIT:                                   ; Returns to here and back to CSAVE
    LDI     A,$20                           ; $9081 - CSAVE entry
    BCH     INTERCEPT_EXIT                  ; 


MERGE_INTERCEPT:
    BII     (CE158_REG_79DD),$80            ; BPD mode flag
    BZS     MRI_EXIT                        ;
    LDI     A,$01                           ; A=$01=CLOAD or MERGE was called (for BPD code)
    SJP     BPD_CMD                         ; Configure for BPD use

MRI_EXIT:                                   ; Returns to here and back to MERGE
    LDI     A,$10                           ; $90BF - MERGE entry
    BCH     INTERCEPT_EXIT                  ; 


CLOAD_INTERCEPT:
    BII     (CE158_REG_79DD),$80            ; BPD mode flag
    BZS     CLI_EXIT                        ;
    LDI     A,$01                           ; A=$01=CLOAD or MERGE was called (for BPD code)
    SJP     BPD_CMD                         ; Configure for BPD use

CLI_EXIT:                                   ; Returns to here and back to CLOAD
    LDI     A,$00                           ; $90C3 - CLOAD entry
    BCH     INTERCEPT_EXIT                  ; 


INTERCEPT_EXIT:
    AND     (RND_VAL),$00                   ; Zero main BUSY blink counter
    AND     (RND_VAL + $01),$00             ; Zero /8 BUSY blink counter
    STA     (OUT_BUF + $41)                 ;
    JMP     BRANCH_90C8                     ;

#ENDIF

;%  CSAVE_INTERCEPT END


;------------------------------------------------------------------------------------------------------------
; ************ Modified >
; Using space to create INSTAT Fix
; The control lines are split across two registers
;   ORIGINAL 2->CTS, 3->CD, 4->DSR, 5->Low Battery
;   NEW                     4->CTS, 5->DSR, 6->Low Battery
#IFDEF CE158V2
;%  INSTAT_FIX START
INSTAT_FIX:
    LDA     #(CE158_UART_MSR0)              ; #(CE158_UART_MSR0) is RS232 I/F Ctrl (ME1)
    SJP     DSRCTSFIX                       ; Fix CTS/DSR/LBI so they match the existing code base

    ; SHR
    ; ANI    A,$10                            ; Keep the DSR bit
    ; BHR    DSR_CLR_INSTAT                   ; Check Bit 4. If not set skip otherwise set a CTS
	; ORI    A,$04

DSR_CLR_INSTAT:
    ORA     #(CE158_UART_MCR0)              ; Get RTS and DTR bits relies on other bit in MCR being cleared by reset
    ANI     A,$17                           ; Bit 3 is Interrupt Enable bit, cleared out
    EAI     $17                             ; Invert the bits
    RTN	


;INVERT THE DSR/RTS LINES
OUTSTAT_FIX:
	LDI     A,0
    ORA 	(ARX + $06)
    EAI     $03                            ; Invert the bits. The TI chip inverts these bits.
    ANI     #(CE158_UART_MCR0),$FC         ; Clear RTS/DTR bits
    ORA     #(CE158_UART_MCR0)             ; Set the RTS/DTR bits
    STA     #(CE158_UART_MCR0)             ;
    RTN 

    ; LDA     #(CE158_UART_MCR0)              ; 
    ; ANI     A,$FC                           ; clear bits 0-1, DTR, RTS
    ; ORA 	(ARX + $06)
    ; EAI     $03                             ; Invert the bits. The TI chip inverts these bits.
    ; STA     #(CE158_UART_MCR0)              ;
    ; RTN 

;%  INSTAT_FIX END


;------------------------------------------------------------------------------------------------------------
; Sets bits correctly for CTS/DSR/LBI
;   ORIGINAL 2->CTS, 3->CD, 4->DSR, 5->Low Battery
;   NEW                     4->CTS, 5->DSR, 6->Low Battery
; Fix CTS/DSR/LBI so they match the existing code base
;%  DSRCTSFIX START 
DSRCTSFIX:
    SHR
    ANI    A,$30                            ; Keep the LBI and DSR bits
    BHR    DSR_CLR_RXCOM                    ; Check Bit 4. If not set skip otherwise set a CTS
	ORI    A,$04                            ;

DSR_CLR_RXCOM:
	RTN                                     ;
#ENDIF

;%  DSRCTSFIX END


#IFDEF ENBPD
;------------------------------------------------------------------------------------------------------------
; UART1 Support - NEW ROUTINES TO SUPPORT UART1
;    
; CHAR2COM FOR UART 1
; SEC is set on entry
;%  U1CHAR2COM START
U1CHAR2COM:
    LDI	    A,$40                           ; TX Empty                 
    AND	    #(CE158_UART_LSR1)              ;
    BZS     EXITTX                          ;
    LDA	    UL                              ; Our original A is in UL. Charecter to send.
    STA	    #(CE158_UART_THR1)              ;
	REC	                                    ;
EXITTX:
    POP	    U                               ; Get original U back, affects Z only
	RTN                                     ;
	
;%  U1CHAR2COM END


;------------------------------------------------------------------------------------------------------------    
; RXCOM FOR UART 1
;    
;%  U1RXCOM START 
U1RXCOM:
    LDA     #(CE158_UART_LSR1)              ; UART status register
	SEC                                     ;
	BII	    A,$01                           ; Test Bit1 of A (Bit0 of CE158_UART_LSR1) DR
    BZS     NOCHAR                          ; If NOT set NO CHAR failure exit
	BII	    A,$0E                           ; Test A for errors (Bit0 of CE158_UART_REGR)
    BZS     READCHAR                        ; If set we had an error, take failure exit
FAIL:
    LDA     #(CE158_UART_RBR1)              ; Read UART Data Register to clear it
    LDI	    A,$40                           ; Failure type
	RTN
READCHAR:
    LDA     #(CE158_UART_RBR1)              ; Read data byte
    REC                                     ; REC = Success
    RTN                                     ; Carry flag indicates return state
NOCHAR:
    LDI	    A,$00                           ; Failure type
	RTN                                     ;
#ENDIF

;%  U1RXCOM END


#IFDEF LPTIN
;------------------------------------------------------------------------------------------------------------    
; RXLPT - 
;   *NOTES: CE158_LPT_CTL_WRITE has inverted outputs. SETDEV KI,PN to redirect input from LPT
;   Device will need to pull BUSY (P10) low to enable LPT output, i.e. accept data
;   Set DTR1 to set TI chip data bus to input
;   If device sets /PE (P12) data is available (device can pull down if not needed)
;       CE-158X sets SLIN high (P17) to signal LPT device that CE-158X LPT is in read mode
;       CE-158X sets /STROBE low (Pin1) as an output enable of LPT device
;       Read LPT, save to buffer, DEC index, if =0 done
;   Else, done
;   Reset pins
;%  RXLPT START 
RXLPT:
    ANI     #(CE158_UART_MCR1),$FE          ; Set DTR1 = 0 (HI) to enable LPT input
    ANI     #(CE158_LPT_CTL_WRITE),~$08     ; Set /SLIN HI to set LPT device to write mode

RXLPT_WAIT:
    BII	    #(PC1500_IF_REG),$02            ; PC-1500 - IF Register Bit1 PB7 (ON Key)
    BZR     RXLPT_BRK                       ; If Bit 1 was set branch fwd to an exit (reset) Failure.

    LDA     #(CE158_LPT_STATUS_READ)        ; (ME1) Read LPT control bits
    ANI     A,$20                           ; If PE is low we have data to read
    BZR     RXLPT_WAIT                      ; If no data ready loop back and keep trying

RXLPT_READ:
    SJP     RXLPT_CHAR                      ; Read in a char

    ; Numeric var (7885 == $88) convert to ASCII, save to IN_BUF, set IN_BUF pointer.
    ; String var  (7885 == $10) return unaltered 
    ; Array var   (7885 == $01) return unaltered
    BII     (CURVARTYPE),$88                ;                 
    BZS     RXLPT_EXIT                      ;

    PSH     X                               ; Save state before making calls below
    PSH     Y                               ;
    PSH     U                               ;
    PSH     A                               ; 

    SJP	    INBUF_CLR                       ; Overwrite Input Buffer w/0D 

    LDI     YH,HB(IN_BUF)                   ; Set address of Input buffer in Y
    LDI     YL,LB(IN_BUF)                   ;
    LDI     UH,$00                          ;
    POP     A                               ; Get our A value back
    STA     UL                              ; Load U with value read in

    CALL    $DD2D                           ; Convert INT value in U to ASCII
                ABYT($40)                   ; Store to address pointed to by Y

    POP     U                               ;
    POP     Y                               ;
    POP     X                               ; X is the IN_BUF pointer
    LDI     XL,$03                          ; Point to address past last character
    LDI     A,$0D                           ; Return a /CR in A to signal EOL

    REC                                     ; Set success flag

RXLPT_EXIT:
    ANI     #(CE158_LPT_CTL_WRITE),~$01     ; SET STROBE/SLIN to default
    ORI     #(CE158_LPT_CTL_WRITE),$08      ; SLIN to LOW (default)
    ORI     #(CE158_UART_MCR1),$01          ; Set DTR1 = 1 to disable LPT input
    RTN                                     ; Value from port is in A

RXLPT_BRK:
    LDI	    UH,$00                          ; Return $00 for BRK key pressed failure
    SEC                                     ; Set Carry Flag
    BCH     RXLPT_EXIT                      ;

;%  RXLPT END


;------------------------------------------------------------------------------------------------------------    
; RXLPT_CHAR - Read a single char from LPT and toggle strobe
;    
;%  RXLPT_CHAR START 
RXLPT_CHAR:
    RIE                                     ; Disable interrupts   
    ORI     #(CE158_LPT_CTL_WRITE),$01      ; CLR strobe bit HIGH (ME1)
    LDI	    A,$20                           ; Set up time delay, set up time for device

RXLPT_CHAR1:   
    DEC	    A                               ; Carry set by first DEC, count 80->0
    BCS     RXLPT_CHAR1                     ; If Carry set repeat, Carry clear after hitting 0

    LDA     #(CE158_LPT_DATA_READ)          ; Read data from parallel port
    PSH     A                               ; Save what we read in

    ANI     #(CE158_LPT_CTL_WRITE),$FE      ; CLR strobe bit (ME1), disable tri-state
    LDI	    A,$20                           ; Set up time delay

RXLPT_CHAR2: ; Branched to from 81B5
    DEC	    A                               ; Carry set by first DEC, count 80->0
    BCS     RXLPT_CHAR2                     ; If Carry set repeat, Carry clear after hitting 0
    SIE                                     ; Enable Interrupts
    POP     A                               ; Get back what we read in
    RTN                                     ; 
#ENDIF

;%  RXLPT_CHAR END

#IFDEF ENBPD
;------------------------------------------------------------------------------------------------------------
; RX_FLUSH - Figure out which port to RX from
;%  RX_FLUSH START
RX_FLUSH:
#IFDEF LPTIN 
    BII     (CE158_REG_79DD),$40            ; (4) PN, 40 = LPT port to input
    BZS     RXCOM_1                         ; (2) If we are not in LPT input mode keep going
    RTN                                     ; (1) This path only used to simualte RXCOM flush for RXLPT
#ENDIF

;%  RX_FLUSH END


;------------------------------------------------------------------------------------------------------------
; RXTYPE - Figure out which port to RX from
;%  RXTYPE START 
; RXTYPE:
; #IFDEF LPTIN 
;     BII     (CE158_REG_79DD),$40            ; (4) PN, 40 = LPT port to input
;     BZS     RXCOM_1                         ; (2) If we are not in LPT input mode keep going
;     JMP     RXLPT                           ; (3) Call LPT input
; #ENDIF

; RXCOM_1:
;     BII     (CE158_REG_79DD),$20            ; (4) Bit6 set = U1
; 	BZS     RXCOM_0                         ; (2) Intecept the RXCOM routine 
; 	JMP     U1RXCOM                         ; (3) and redirect to UART1 if enabled

; RXCOM_0:

;     JMP     CONTRX                          ; We want COM0 after all

  #ENDIF ;ENBPD

;%  RXTYPE START 


;------------------------------------------------------------------------------------------------------------
; TABLE_8888
; Seems like nonsense that is not used, so we use it for BPD
;%  TABLE_8888 START 
TABLE_8888:

#IFNDEF ENBPD ; If we have neither option selected use original table
 #IFNDEF CE158V2
    .BYTE $00,$FF,$00,$FF,$00,$FF,$04,$FD,$90,$FD,$00,$FF,$00,$FF,$00,$FD 
    .BYTE $82,$FF,$00,$FF,$00,$FF,$A0,$EF,$10,$6F,$00,$FF,$00,$FF,$00,$DF
    .BYTE $04,$FF,$00,$FF,$00,$FF,$82,$FE,$82,$F7,$00,$FF,$00,$FF,$04,$FF
    .BYTE $20,$FF,$00,$FF,$00,$FF,$00,$BF,$23,$C7,$00,$FF,$00,$FF,$00,$FB 
    .BYTE $12,$EE,$00,$FF,$00,$FF,$28,$FB,$00,$AA,$00,$FF,$00,$FF,$00,$77 
    .BYTE $A8,$9F,$00,$FF,$00,$FF,$40,$D9,$14,$FF,$00,$FF,$00,$FF,$60,$FF
    .BYTE $00,$EF,$00,$FF,$00,$FF,$08,$BF,$E0,$FF,$00,$FF,$00,$FF,$20,$FF
    .BYTE $04,$FF,$00,$FF,$00,$FF,$0C,$EF,$41,$EF,$00,$FF,$00,$FF,$42,$F7
    .BYTE $4D,$FF,$00,$FF,$00,$FF,$24,$B7,$04,$FE,$00,$FF,$00,$FF,$00,$FF
    .BYTE $A3,$7E,$00,$FF,$00,$FF,$80,$EE,$04,$D6,$00,$FF,$00,$FF,$98,$DF
    .BYTE $81,$FB,$00,$FF,$00,$FF,$04,$43,$10,$7C,$00,$FF,$00,$FF,$0A,$FF
    .BYTE $16,$E6,$00,$FF,$00,$FF,$06,$FB,$80,$BF,$00,$FF,$00,$FF,$2A,$27
    .BYTE $44,$BF,$00,$FF,$00,$FF,$02,$DA,$32,$7F,$00,$FF,$00,$FF,$01,$7A
    .BYTE $5C,$FF,$00,$FF,$00,$FF,$2C,$3E,$80,$83,$00,$FF,$00,$FF,$80,$FC
    .BYTE $21,$EB,$00,$FF,$00,$FF,$05,$DF,$40,$4B,$00,$FF,$00,$FF,$00,$DF
    .BYTE $11,$7F,$00,$FF,$00,$FF,$47,$EF,$14,$BF,$00,$FF,$00,$FF,$01,$5B
    .BYTE $A4,$1B,$00,$FF,$00,$FF,$02,$FE,$C0,$EE,$00,$FF,$00,$FF,$01,$6F
    .BYTE $18,$BB,$00,$FF,$00,$FF,$A8,$7E,$00,$67,$00,$FF,$00,$FF,$00       
    .BYTE $EF,$00,$FE,$00,$FF,$00,$FF,$00,$BB,$08,$FF,$00,$FF,$00,$FF,$25 
    .BYTE $EF,$08,$DE,$00,$FF,$00,$FF,$41,$FF,$80,$D7,$00,$FF,$00,$FF,$0E 
    .BYTE $DB,$08,$FE,$00,$FF,$00,$FF,$00,$F3,$28,$7F,$00,$FF,$00,$FF,$51 
    .BYTE $FF,$00,$BB,$00,$FF,$00,$FF,$90,$F7,$C1,$B7,$00,$FF,$00,$FF,$A1 
    .BYTE $CF,$12,$E6,$00,$FF,$00,$FF,$40,$77,$00,$FF,$00,$FF,$00,$FF,$29 
    .BYTE $BB,$10,$EB,$00,$FF,$00,$FF,$46,$F7,$08,$1B,$00,$FF,$00,$FF,$09
    .BYTE $7E,$9C,$7A,$00,$FF,$00,$FF,$83,$BE,$92,$FF,$00,$FF,$00,$FF,$0A 
    .BYTE $DF,$05,$F7,$00,$FF,$00,$FF,$A1,$B9,$46,$F9,$00,$FF,$00,$FF,$07 
    .BYTE $DD,$11,$FF,$00,$FF,$00,$FF,$4B,$F7,$C1,$FF,$00,$FF,$00,$FF,$04 
    .BYTE $25,$02,$FF,$00,$FF,$00,$FF,$A0,$FF,$41,$F7,$00,$FF,$00,$FF,$84 
    .BYTE $FA,$4A,$9C,$00,$FF,$00,$FF,$48,$BF,$10,$AF,$00,$FF,$00,$FF,$06 
    .BYTE $FF,$00,$EB,$00,$FF,$00,$FF,$02,$FE,$A1,$DB,$00,$FF,$00,$FF,$2A 
    .BYTE $BF,$82,$FE,$00,$FF,$00,$FF,$00,$F7,$80,$1F,$00,$FF,$00,$FF,$20 
    .BYTE $FF,$18,$76,$00,$FF,$00,$FF,$05,$CD,$00,$9E,$00,$FF,$00,$FF,$01 
    .BYTE $E9,$D0,$FF,$00,$FF,$00,$FF,$80,$FF,$28,$9D,$00,$FF,$00,$FF,$04 
    .BYTE $EE,$C0,$DF,$00,$FF,$00,$FF,$2D,$F7,$5C,$1D,$00,$FF,$00,$FF,$01 
    .BYTE $DA,$70,$E3,$00,$FF,$00,$FF,$42,$EF,$80,$AF,$00,$FF,$00,$FF,$00 
    .BYTE $8B,$00,$FF,$00,$FF,$00,$FF,$00,$FD,$A9,$F7,$00,$FF,$00,$FF,$02 
    .BYTE $BE,$8D,$BF,$00,$FF,$00,$FF,$09,$FF,$43,$FF,$00,$FF,$00,$FF,$00 
    .BYTE $FF,$84,$FF,$00,$FF,$00,$FF,$40,$E6,$10,$D7,$00,$FF,$00,$FF,$70 
    .BYTE $BD,$60,$4F,$00,$FF,$00,$FF,$0A,$33,$07,$FF,$00,$FF,$00,$FF,$09 
    .BYTE $FA,$82,$FD,$00,$FF,$00,$FF,$00,$1F,$80,$FF,$00,$FF,$00,$FF,$12 
    .BYTE $FD,$39,$B5,$00,$FF,$00,$FF,$00,$17,$BB,$FC,$00,$FF,$00,$FF,$09 
    .BYTE $F7,$00,$CE,$00,$FF,$00,$FF,$EA,$69,$1C,$66,$00,$FF,$00,$FF,$00 
    .BYTE $9E,$83,$CB,$00,$FF,$00,$FF,$A0,$F7,$01,$1F,$00,$FF,$00,$FF,$29 
    .BYTE $FD,$84,$BF,$00,$FF,$00,$FF,$80,$F3,$84,$FA,$00,$FF,$00,$FF,$00 
    .BYTE $FF,$84,$7B,$00,$FF,$00,$FF,$0C,$ED,$E0,$F7,$00,$FF,$00,$FF,$A2 
    .BYTE $AF,$AC,$EB,$00,$FF,$00,$FF,$81,$F4,$8A,$4E,$00,$FF,$00,$FF,$00 
    .BYTE $FF,$00,$FA,$00,$FF,$00,$FF,$03,$CE,$A0,$FF,$00,$FF,$00,$FF,$14 
    .BYTE $FD,$C2,$7D,$00,$FF,$00,$FF,$04,$FD,$00,$FF,$00,$FF,$00,$FF,$C0 
    .BYTE $FE,$04,$E4,$00,$FF,$00,$FF,$B8,$BF,$14,$EF,$00,$FF,$00,$FF,$40 
    .BYTE $FF,$81,$FF,$00,$FF,$00,$FF,$08,$FE,$22,$BF,$00,$FF,$00,$FF,$04 
    .BYTE $79,$A1,$F7,$00,$FF,$00,$FF,$00,$ED,$55,$F1,$00,$FF,$00,$FF,$C8 
    .BYTE $BF,$88,$CD,$00,$FF,$00,$FF,$00,$FF,$04,$7F,$00,$FF,$00,$FF,$10 
    .BYTE $FF,$04,$BB,$00,$FF,$00,$FF,$21,$87,$00,$FF,$00,$FF,$00,$FF,$00 
    .BYTE $EF,$00,$FB,$00,$FF,$00,$FF,$80,$F7,$28,$EB,$00,$FF,$00,$FF,$20 
    .BYTE $3F,$18,$B3,$00,$FF,$00,$FF,$48,$67,$08,$FF,$00,$FF,$00,$FF,$0E 
    .BYTE $D9,$8B,$7D,$00,$FF,$00,$FF,$08,$F7,$44,$FE,$00,$FF,$00,$FF,$18 
    .BYTE $8C,$8C,$F5,$00,$FF,$00,$FF,$90,$DD,$80,$F1,$00,$FF,$00,$FF,$41 
    .BYTE $FF,$20,$F7,$00,$FF,$00,$FF,$00,$EB,$C2,$CF,$00,$FF,$00,$FF,$00 
    .BYTE $B7,$03,$CF,$00,$FF,$00,$FF,$48,$FD,$80,$FF,$00,$FF,$00,$FF,$20 
    .BYTE $FD,$68,$E7,$00,$FF,$00,$FF,$03,$77,$46,$D7,$00,$FF,$00,$FF,$07 
    .BYTE $ED,$30,$F8,$00,$FF,$00,$FF,$18,$EE,$04,$3F,$00,$FF,$00,$FF,$24 
    .BYTE $E6,$01,$F5,$00,$FF,$00,$FF,$20,$7D,$01,$FD,$00,$FF,$00,$FF,$00 
    .BYTE $E3,$00,$F7,$00,$FF,$00,$FF,$10,$FF,$41,$5F,$00,$FF,$00,$FF,$09 
    .BYTE $9B,$1E,$66,$00,$FF,$00,$FF,$02,$C7,$02,$13,$00,$FF,$00,$FF,$02 
    .BYTE $FE,$80,$67,$00,$FF,$00,$FF,$11,$1B,$C0,$FC,$00,$FF,$00,$FF,$08 
    .BYTE $BE,$20,$E6,$00,$FF,$00,$FF,$00,$FF,$21,$F7,$00,$FF,$00,$FF,$28 
    .BYTE $FF,$14,$BB,$00,$FF,$00,$FF,$40,$FF,$13,$ED,$00,$FF,$00,$FF,$80 
    .BYTE $C6,$60,$FF,$00,$FF,$00,$FF,$01,$FE,$16,$FF,$00,$FF,$00,$FF,$00 
    .BYTE $7F,$40,$F8,$00,$FF,$00,$FF,$01,$BA,$00,$DF,$00,$FF,$00,$FF,$04 
    .BYTE $FE,$C9,$6B,$00,$FF,$00,$FF,$A0,$EF,$09,$9E,$00,$FF,$00,$FF,$C0 
    .BYTE $FF,$0A,$FF,$00,$FF,$00,$FF,$08,$5B,$02,$3F,$00,$FF,$00,$FF,$8C 
    .BYTE $FD,$20,$75,$00,$FF,$00,$FF,$0E,$F7,$50,$FF,$00,$FF,$00,$FF,$74 
    .BYTE $F5,$10,$66,$00,$FF,$00,$FF,$80,$B6,$48,$DF,$00,$FF,$00,$FF,$30 
    .BYTE $FD,$48,$BF,$00,$FF,$00,$FF,$14,$FA,$02,$86,$00,$FF,$00,$FF,$05 
    .BYTE $7B,$00,$5F,$00,$FF,$00,$FF,$A4,$FF,$20,$FB,$00,$FF,$00,$FF,$61 
    .BYTE $FF,$95,$76,$00,$FF,$00,$FF,$00,$3F,$06,$FA,$00,$FF,$00,$FF,$04 
    .BYTE $BF,$00,$F7,$00,$FF,$00,$FF,$40,$FF,$92,$F7,$00,$FF,$00,$FF,$04 
    .BYTE $EF,$80,$FD,$00,$FF,$00,$FF,$02,$FD,$05,$FE,$00,$FF,$00,$FF,$08 
    .BYTE $FF,$80,$76,$00,$FF,$00,$FF,$05,$F7,$30,$2F,$00,$FF,$00,$FF,$08 
    .BYTE $FF,$01,$EE,$00,$FF,$00,$FF,$52,$FF,$02,$C7,$00,$FF,$00,$FF,$91 
    .BYTE $E7,$00,$FD,$00,$FF,$00,$FF,$44,$77,$40,$FF,$00,$FF,$00,$FF,$00 
    .BYTE $FD,$B8,$FF,$00,$FF,$00,$FF,$00,$DF,$5A,$FF,$00,$FF,$00,$FF,$84 
    .BYTE $FA,$43,$EF,$00,$FF,$00,$FF,$94,$96,$00,$FE,$00,$FF,$00,$FF,$50 
    .BYTE $FB,$04,$FF,$00,$FF,$00,$FF,$26,$BF,$C9,$FC,$00,$FF,$00,$FF,$00 
    .BYTE $FF,$80,$BF,$00,$FF,$00,$FF,$80,$FF,$A0,$BB,$00,$FF,$00,$FF,$0C 
    .BYTE $B9,$04,$FB,$00,$FF,$00,$FF,$05,$B9,$44,$EF,$00,$FF,$00,$FF,$00 
    .BYTE $FF,$00,$7D,$00,$FF,$00,$FF,$00,$BE,$41,$BB,$00,$FF,$00,$FF,$10 
    .BYTE $FF,$00,$7D,$00,$FF,$00,$FF,$14,$EF,$AA,$7F,$00,$FF,$00,$FF,$C0 
    .BYTE $66,$0C,$F2,$00,$FF,$00,$FF,$40,$FF,$28,$3D,$00,$FF,$00,$FF,$40 
    .BYTE $FD,$48,$FF,$00,$FF,$00,$FF,$47,$F7,$08,$FF,$00,$FF,$00,$FF,$00 
    .BYTE $FF,$2A,$FE,$00,$FF,$00,$FF,$41,$A7,$15,$7E,$00,$FF,$00,$FF,$62 
    .BYTE $BF,$C0,$FD,$00,$FF,$00,$FF,$00,$FD,$26,$5F,$00,$FF,$00,$FF,$00 
    .BYTE $FE,$80,$FC,$00,$FF,$00,$FF,$28,$BF,$08,$FF,$00,$FF,$00,$FF,$46 
    .BYTE $1E,$20,$CB,$00,$FF,$00,$FF,$22,$EF,$20,$B5,$00,$FF,$00,$FF,$03 
    .BYTE $E3,$08,$1E,$00,$FF,$00,$FF,$0A,$FB,$07,$FE,$00,$FF,$00,$FF,$25 
    .BYTE $F7,$07,$DF,$00,$FF,$00,$FF,$04,$6F,$02,$FE,$00,$FF,$00,$FF,$18 
    .BYTE $FF,$CC,$BF,$00,$FF,$00,$FF,$23,$7D,$18,$FF,$00,$FF,$00,$FF,$18 
    .BYTE $9E,$02,$3F,$00,$FF,$00,$FF,$C0,$FD,$50,$7A,$00,$FF,$00,$FF,$00 
    .BYTE $BD,$18,$FF,$00,$FF,$00,$FF,$08,$FD,$04,$FE,$00,$FF,$00,$FF,$20 
    .BYTE $DF,$44,$FE,$00,$FF,$00,$FF,$02,$FF,$02,$FD,$00,$FF,$00,$FF,$00 
    .BYTE $FF,$00,$DD,$00,$FF,$00,$FF,$9C,$BF,$4C,$5F,$00,$FF,$00,$FF,$00 
    .BYTE $EF,$18,$FB,$00,$FF,$00,$FF,$A0,$53,$A0,$DF,$00,$FF,$00,$FF,$34 
    .BYTE $77,$80,$F3,$00,$FF,$00,$FF,$04,$EF,$13,$FD,$00,$FF,$00,$FF,$05 
    .BYTE $BF,$82,$FE,$00,$FF,$00,$FF,$00,$7E,$87,$00,$00,$FF,$00,$DD,$4B 
    .BYTE $00,$00,$00,$00,$BF,$00,$7F,$81,$00,$11,$80,$00,$FF,$00,$EF,$00 
    .BYTE $40,$21,$04,$00,$FF,$00,$FF,$0E,$00,$21,$00,$00,$FF,$00,$FF,$09 
    .BYTE $00,$80,$00,$00,$F7,$00,$DF,$18,$00,$41,$00,$00,$FF,$00,$F7,$25 
    .BYTE $00,$31,$00,$00,$BB,$00,$DF,$82,$00,$A8,$00,$00,$FF,$00,$FF,$01 
    .BYTE $00,$10,$00,$00,$BF,$00,$FF,$40,$00,$24,$10,$00,$FF,$00,$6F,$84 
    .BYTE $00,$80,$00,$00,$7F,$00,$EF,$C4,$00,$18,$00,$00,$FF,$00,$FB,$28 
    .BYTE $00,$40,$00,$00,$FF,$00,$B7,$24,$00,$10,$00,$00,$D7,$00,$FF,$B0
    .BYTE $00,$26,$00,$00,$EF,$00,$3F,$00,$00,$10,$00,$00,$FF,$00,$FF,$10 
    .BYTE $00,$18,$00,$00,$FF,$00,$A3,$04,$00,$06,$08,$00,$FF,$00,$FF,$80 
    .BYTE $00,$80,$00,$00,$E5,$00,$7B,$20,$00,$82,$00,$00,$7F,$00,$7F,$00 
    .BYTE $00,$04,$00,$00,$FF,$00,$FF,$80,$00,$C0,$00,$00,$A7,$00,$FF,$30 
    .BYTE $00,$2A,$02,$00,$FF,$00,$7F,$90,$00,$00,$02,$00,$B7,$00,$FF,$42 
    .BYTE $04,$26,$00,$00,$F7,$00,$FF,$24,$00,$28,$04,$00,$7F,$00,$FF,$10 
    .BYTE $00,$03,$00,$00,$FF,$00,$FD,$00,$00,$18,$00,$00,$FE,$00,$9B,$03 
    .BYTE $00,$00,$00,$00,$67,$00,$EF,$44,$00,$0B,$00,$00,$FF,$00,$DF,$C0 
    .BYTE $00,$00,$00,$00,$3F,$00,$F9,$C5
 #ENDIF
#ENDIF

;%  TABLE_8888 END


#IFDEF CE158V2
.FILL ($8FFF - $),$FF
.ORG $8FFF
#ENDIF
;------------------------------------------------------------------------------------------------------------
; INPUT - Jumped to from 8307 via High Bank
; Arguments: X-REG address of function, Y-REG Token
; Output:
; RegMod:
;%  INPUT START 
INPUT: ;8FFF
    VEJ     (C2)                            ; If not an INPUT# skip ahead
                ACHR(HASH)                  ; Character
                ABRF(BRANCH_9025)           ; Forward branch to label     

    LDI     A,$84                           ;
    STA     (CASS_FLAG)                     ;
    VEJ     (C2)                            ; If not '-' skip ahead
                ACHR(DASH)                  ; Character
                ABRF(BRANCH_9024)           ; Forward branch to label

BRANCH_900A:
    JMP     (BCMD_PRINT + $0B)              ; Inside BASIC PRINT command

;%  INPUT END


;------------------------------------------------------------------------------------------------------------
; PRINT - Jumped to from 8307 via High Bank
; Arguments: X-REG address of function, Y-REG Token
; Outputs:
; RegMod:
;%  PRINT START 
PRINT: ;900D
    VEJ     (C2)                            ; If not a PRINT# skip ahead
                ACHR(HASH)                  ; Character
                ABRF(BRANCH_9022)           ; Forward branch to label 

    LDI	    A,$04                           ;
    STA	    (CASS_FLAG)                     ;
    VEJ     (C2)                            ; If not '-' skip ahead
                ACHR(DASH)                  ; Character
                ABRF(BRANCH_9023)           ; Forward branch to label

    BCH 	BRANCH_900A                     ;

;%  PRINT END


;------------------------------------------------------------------------------------------------------------
; CSAVE - Branched to from 8307 via High Bank
; Arguments: X-REG address of function, Y-REG Token
; Outputs:
; RegMod:
;%  CSAVE START
CSAVE: ; 901A
    REC                                     ; Reset Carry


;------------------------------------------------------------------------------------------------------------
; CLOAD - Jumpedto from 8307 via High Bank
; Arguments: X-REG address of function, Y-REG Token
; Outputs:
; RegMod:
;%  CLOAD START
CLOAD: ; 901B
    REC                                     ; Reset Carry


;------------------------------------------------------------------------------------------------------------
; MERGE - Jumped to from 8307 via High Bank
; Arguments: X-REG address of function, Y-REG Token
; Outputs:
; RegMod:
;% MERGE START
MERGE: ; 901C
    REC                                     ; Reset Carry



;------------------------------------------------------------------------------------------------------------
; CLD_CSV_LPR - Jumped to from 8307 via High Bank ***JMP - Does a calcualted jump
; Arguments: X-REG address of function, Y-REG Token
; Outputs:
; RegMod:
;% CLD_CSV_LPR START
CLD_CSV_LPR: ; 901D branched to from 905C, 905F (LPRINT X=9056, LLIST X=901D)
    VEJ     (C0)                            ; Load next character/token to U-Reg
    LDI	    A,$04                           ; X = X + A + Carry
    ADR	    X                               ; LLIST=901D+04=9021, LPRINT=9018+04=901C, LPRINT=9019+04=901D
                                            ; CSAVE=901A+04=901E,  CLOAD=901B+04=901F,  MERGE=901C+04=9020

BRANCH_9022: ; branched to from 900D (PRINT X=9010)
    REC                                     ; Reset Carry

BRANCH_9023: ; branched to from 9015 (PRINT X=9018)
    REC                                     ; Reset Carry

BRANCH_9024: ; branched to from 9007 (INPUT X=900A)
    REC                                     ; Reset Carry

BRANCH_9025: ; branched to from 8FFF (INPUT X=9002)
    VEJ     (C6)                            ; DEC Y-Reg by 2 for tokens or 1 for chars in U-Reg
    LDA	    XL                              ; XL is low byte of Command address
    PSH	    A                               ; Original LB of X-REG
    LDI	    UL,LBO(ARZ,$01)                 ; Loop counter
    LDI	    UH,HBO(ARZ,$01)                 ; U = 7A09 (ARZ + $01)
    LDI	    XL,LBO(TABLE_9061,$09)          ; XH = HB of command, XL=6A 
                                                                
BRANCH_902F: ; branched to from 9031        ; POKES in code from TABLE_906B
                                            ; LLIST 906A=5E FD E0 C9 1B 68 28 FD 3C CD
                                            ; CLOAD CD 3C      FD 28   68 1B        C9 E0      FD 5E   4F 41 44
                                            ; 7A00  VMJ (3C) : LDX U : LDI UH,$1B : VZR (E0) : STX P :
                                            ; copied backwards 7A00-7A08, LPRINT 906A, **PRINT 906A, INPUT 8F6A**
    LDE	    X                               ; A = (X) then X = X - 1
    STA	    (U)                             ;
    LOP	    UL,BRANCH_902F                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set

                                            ; POKES in code from TABLE_906B
    POP	    A                               ; A = original low byte of command before $902F
    SEC                                     ; Set carry flag
    SBI	    A,$1C                           ; LLIST  21-1C=05 C=1 -> LLIST  05<<3=28 C=0, MERGE  20-1C=## C=# -> MERGE  ##<<3=## C=#
    SHL                                     ; LPRINT 1C-1C=00 C=1 -> LPRINT 00<<3=00 C=0, LPRINT 1D-1C=01 C=1 -> LPRINT 01<<3=08 C=0
    SHL                                     ; CSAVE  1E-1C=## C=# -> CSAVE  ##<<3=#  C=#, CLOAD  1F-1C=## C=# -> CLOAD  ##<<3=# C=#
    SHL                                     ; PRINT  10-1C=## C=# -> PRINT  ##<<3=#  C=#, PRINT  18-1C=## C=# -> PRINT  ##<<3=# C=#
    LDI	    XL,$6B                          ; INPUT  0A-1C=## C=# -> INPUT  ##<<3=#  C=#, INPUT  02-1C=## C=# -> INPUT  ##<<3=# C=#
    ADR	    X                               ; LLIST 9093 C=0, LPRINT(1C) 906B C=0, LPRINT(1D) 9073 C=0
    LIN	    X                               ; LLIST A=4 -> X=9094, A = (X) then INC X. Uses TABLE_906B 
    AND	    (SETDEV_REG)                    ; Clear bits based on A. A = A & X
                                            ; KI = 01, DO = 02, PO = 04, CI = 08, CO = 10

    BZS     BRANCH_904E                     ; 1st byte in table does not match SETDEV mode
    SJP	    BRANCH_93CB                     ; Compares C0 to (OPN)
    STA	    (OUT_BUF + $3E)                 ; A=C0, set in BRANCH_93CB, (79BE) in OUTPUT_BUFFER
    INC	    X                               ; skip three bytes in table if in SETDEV mode
    INC	    X                               ; use 1st three bytes if mode does not match
    INC	    X                               ; yse 2nd three bytes if mode does match

BRANCH_904E: ; branched to from 9043
    LIN	    X                               ; A = (X) then INC X
    STA	    UH                              ; Uses TABLE_906B
    LIN	    X                               ; A = (X) then INC X
    STA	    UL                              ; LLIST U=B754, CE-150 LLIST function
    LDA	    (X)                             ; A = 58
    JMP	    ARX                             ; (9053) ***JMP to what was POKED in to ARX by $902F

;% CLD_CSV_LPR END


;------------------------------------------------------------------------------------------------------------
; LPRINT - Jumped to from 8307 via High Bank
; Arguments: XREG = Address = 9056, YREG = Token,
; Outputs:
; RegMod:
;% LPRINT START
LPRINT: ;9056
    LDI	    XL,LB($9018)                    ; X=$9018
    BII	    (ZONE_REG),$40                  ; Test for bit 6 set
    BZS     CLD_CSV_LPR                     ; If Bit 6 not set branch to LLIST, bit indicates?
    INC	    XL                              ; XL = $19, X=$9019
    BCH     CLD_CSV_LPR                     ; Unconditional Branch to LLIST

;% LPRINT END


;-----------------------------------------------------------------------------------------------------------
; TABLE_9061 - Used by $902F
; Code copied reverse order to 7A09->00 
;   Keyword What winds up in RAM
;   CLOAD:  CD 3C FD 28 68 1B C9 E0 FD 5E 4F 41 44
;   CSAVE:  CD 3C FD 28 68 1B C9 E0 FD 5E 41 56 45
;   MERGE:  CD 3C FD 28 68 1B C9 E0 FD 5E 52 47 45
;   PRINT:  CD 3C FD 28 68 1B C9 E0 FD 5E 49 4E 54
;   LPRINT: CD 3C FD 28 68 1B C9 E0 FD 5E 52 49 4E 54
;   LLIST:  CD 3C FD 28 68 1B C9 E0 FD 5E 49 53 54
;% TABLE_9061 START
TABLE_9061:
ORIGPC1:     EQU $                          ; Save current PC
.ORG $7A09                                  ; Set new PC to where this code will be POKE into RAM
TABLE9061:
    VMJ ($3C)                               ; CD 3C  Checks whether token table exists
    LDX U                                   ; FD 28  
    LDI UH,$1B                              ; 68 1B  Error type to report
    VZR ($E0)                               ; C9 E0  Output error from UH, Return to editor
    STX P                                   ; FD 5E  Change program counter to what is in X

.ORG (ORIGPC1 + ($-TABLE9061))              ; Set PC back to original range

;% TABLE_9061 END


;-----------------------------------------------------------------------------------------------------------
; TABLE_906B - Used by 903F
;% TABLE_906B START
TABLE_906B:
        ; ?             CE-150   ?                           CE-158                    OPN EOL
    .BYTE $04 \ .WORD (LPRINT_150 + $08) \ .BYTE $58 \ .WORD JMP_93DE          \ .BYTE $C0,$00   ; Byte 0 is SETDEV mode mask
    .BYTE $04 \ .WORD  LPRINT_150        \ .BYTE $58 \ .WORD JMP_93DE          \ .BYTE $C0,$00   ; Byte 1 -> UH
    .BYTE $10 \ .WORD  CSAVE_150         \ .BYTE $5C \ .WORD CSAVE_ENTRY       \ .BYTE $C0,$00   ; Byte 2 -> UL
    .BYTE $08 \ .WORD  CLOAD_150         \ .BYTE $5C \ .WORD CLOAD_ENTRY       \ .BYTE $C0,$00   ; Byte 3 -> A   if SETDEV mode does not match mask
    .BYTE $08 \ .WORD (MERGE_150 + $01)  \ .BYTE $5C \ .WORD MERGE_ENTRY       \ .BYTE $C0,$00   ; Byte 4 -> UH
    .BYTE $04 \ .WORD  LLIST_150         \ .BYTE $58 \ .WORD JMP_9356          \ .BYTE $C0,$00   ; Byte 5 -> UL
    .BYTE $02 \ .WORD (BCMD_PAUSE + $11) \ .BYTE $60 \ .WORD JMP_936A          \ .BYTE $C0,$00   ; Byte 6 -> A   if SETDEV mode does match mask
    .BYTE $10 \ .WORD (BCMD_PRINT + $08) \ .BYTE $5C \ .WORD PRINT_NUM_HANDLER \ .BYTE $C0,$00   ; Byte 7 -> 00 delimiter
    .BYTE $08 \ .WORD (BCMD_PRINT + $08) \ .BYTE $5C \ .WORD PRINT_NUM_HANDLER \ .BYTE $C0,$00   ;
    .BYTE $01 \ .WORD BCMD_INPUT         \ .BYTE $60 \ .WORD INPUT_NUM         \ .BYTE $C0,$00   ;

;% TABLE_906B END


;------------------------------------------------------------------------------------------------------------
; CLOAD_SAVE_MERGE - Jumped to from 
; Handles CLOAD, CSAVE and \MERGE
; Arguments: 
; Outputs:
; RegMod:
;% CLOAD_SAVE_MERGE START
CLOAD_SAVE_MERGE: ; $90BB

#IFNDEF ENBPD

CSAVE_ENTRY:
    LDI     A,$20                           ; $90BB - CSAVE entry
    BCH     BRANCH_90C5                     ;
    
MERGE_ENTRY:   
    LDI     A,$10                           ; $90BF - MERGE entry
    BCH     BRANCH_90C5                     ; 
    
CLOAD_ENTRY:    
    LDI     A,$00                           ; $90C3 - CLOAD entry

BRANCH_90C5:
    STA     (OUT_BUF + $41)                 ;

#ELSE

CSAVE_ENTRY:
    JMP     CSAVE_INTERCEPT                 ; $90BB - CSAVE entry intercept
    NOP                                     ; Take up extra bytes
    
MERGE_ENTRY:   
    JMP     MERGE_INTERCEPT                 ; $90BF - MERGE entry intercept
    NOP                                     ; Take up extra bytes
    
CLOAD_ENTRY:   
    JMP     CLOAD_INTERCEPT                 ; $90C3 - CLOAD entry intercept
    NOP                                     ;
    NOP                                     ;

#ENDIF

BRANCH_90C8:
    LIN     Y                               ; Load char in Input Buffer after first " 
    CPI     A,$E0                           ;
    BCS     BRANCH_90F0                     ; iF >= E0
    STA     UL                              ;
    LDI     A,$01                           ;
    CPI     UL,$72                          ;
    BZS     BRANCH_90E8                     ; If < 72
    SHL                                     ;
    CPI     UL,$4D                          ;
    BZS     BRANCH_90E8                     ; If < 4D
    SHL                                     ;
    CPI     UL,$61                          ;
    BZR     BRANCH_90F0                     ;
    LDI     UH,$1A                          ;
    BII     (DISP_BUFF + $4F),$10           ;

BRANCH_90E4:
    VZR     ($E0)                           ;
    BCH     BRANCH_90FA                     ;

BRANCH_90E8:
    BII     (OUT_BUF + $41),$10             ;
    LDI     UH,$01                          ;
    BCH     BRANCH_90E4                     ;

BRANCH_90F0:
    DEC     Y                               ;
    LDI     A,$00                           ;
    BII     (DISP_BUFF + $4F),$10           ;
    BZS     BRANCH_90FA                     ;
    INC     A                               ;

BRANCH_90FA:
    ORA     (OUT_BUF + $41)                 ;
    STA     (OUT_BUF + $41)                 ;
    BII     A,$30                           ;
    BZR     BRANCH_910D                     ;
    BII     A,$02                           ;
    BZR     BRANCH_910D                     ;
    LDI     UH,$1A                          ;
    VEJ     (D8)                            ; Checks calculator mode
    VZR     ($E0)                           ; Output error from UH

BRANCH_910D:
    SJP     SUB_9DF1                        ; Original ROM has 
    VCR     ($E4)                           ; Output Error 1 and return to the editor
    LDA     (OUT_BUF + $41)                 ;
    SHR                                     ;
    BCR     BRANCH_9129                     ;
    VMJ     ($38)                           ; Determines reserve memory start address +8
    BCS     BRANCH_9124                     ;
    LDI     UH,$18                          ;
    ANI     (OUT_BUF + $41),$20             ;
    VZR     ($E0)                           ; Output error from UH

BRANCH_9124:
    SJP     SUB_9A32                        ;
    BCH     BRANCH_9150                     ;

BRANCH_9129:
    BHR     BRANCH_913E                     ;
    SJP     PRGST2XREG                      ; X-Reg = Program Start Address. U-Reg = STATUS 1-2
    BCR     BRANCH_9135                     ;
    SJP     SUB_9A2D                        ;
    BCH     BRANCH_9150                     ;

BRANCH_9135:
    ANI     (OUT_BUF + $41),$EF             ;

BRANCH_9139:
    SJP     SUB_9A38                        ;
    BCH     BRANCH_9150                     ;

BRANCH_913E:
    SHR
    BCS     BRANCH_914D                     ;
    BHR     BRANCH_9139                     ;
    SJP     PRGST2XREG                      ; X-Reg = Program Start Address. U-Reg = STATUS 1-2
    VCR     ($42)                           ; Editor Warm Start
    SJP     SUB_9949                        ;
    BCH     BRANCH_9150                     ;

BRANCH_914D:
    SJP     SUB_99EF                        ;

BRANCH_9150:
    VCR     ($E0)                           ; Display error from UH or carry out 'ON-ERROR routine'.
    SJP     SUB_98BD                        ; Used in KI to call RXCOM for virtual keypresses
    BCR     BRANCH_915A                     ;

BRANCH_9157:
    JMP     BRANCH_962B                     ;

BRANCH_915A:
    BII     (OUT_BUF + $41),$20             ; 
    BZS     BRANCH_916D                     ; 
    BII     (OUT_BUF + $41),$04             ;
    BZR     BRANCH_917D                     ;
    SJP     SUB_9CEC                        ;
    BCS     BRANCH_9157                     ;
    BCH     BRANCH_916F                     ;

BRANCH_916D:
    BCH       SUB_9250                      ; 


BRANCH_916F:
    VEJ     (F4)                            ; Loads U-Reg with a 16-bit value from the address of the data bytes (D1 D2).
                AWRD(OUT_BUF + $15)         ; Address
    LDX     U                               ;
    VEJ     (F4)                            ; Loads U-Reg with a 16-bit value from the address of the data bytes (D1 D2).
                AWRD(OUT_BUF + $17)         ; Address
    
    SJP      BRANCH_9AA7                    ;
    JMP      JMP_9607                       ;


BRANCH_917D:
    PSH     Y                               ;
    VEJ     (F4)                            ; Loads U-Reg with a 16-bit value from the address of the data bytes (D1 D2).
                AWRD(OUT_BUF + $15)         ; Address
    LDX     U                               ;
    
BRANCH_9184:   
    SJP     SUB_9BE1                        ;
    
BRANCH_9187:    
    BCS     BRANCH_9241                     ;
    LIN     X                               ;
    STA     UH                              ;
    LIN     X                               ;
    STA     UL                              ;
    INC     X                               ;
    PSH     X                               ;
    LDI     YL,LB(ARV)                      ;
    LDI     YH,HB(ARV)                      ; Y = $7A20 = ARV
    VMJ     ($10)                           ; Convert U-Reg according to data bytes, $40 = Save to (Y-Reg) in ASCII
                ABYT($40)                   ; n1
    LDI     XL,LBO(ARU,$07)                 ; ARU + 7
    LDI     XH,HBO(ARU,$07)                 ; X = $7A1F ARU 7A18
    LDA     YL                              ;
    SEC                                     ;
    SBI     A,$21                           ;
    BII     (OUT_BUF + $41),$80             ;
    BZR     BRANCH_91B5                     ;
    LDI     A,$25                           ;
    SBC     YL                              ;
    STA     UL                              ;
    LDI     A,$20                           ;
    SIN     Y                               ;    

BRANCH_91AC:
    DEC     UL                              ;
    BCR     BRANCH_91B2                     ;
    SDE     X                               ;
    BCH     BRANCH_91AC                     ;

BRANCH_91B2:
    INC     X                               ;
    LDA     YL                              ;
    SBC     XL                              ;

BRANCH_91B5:
    STA     UL                              ;
    POP     Y                               ;
    SJP     SUB_9ACF                        ;
    BCS     BRANCH_9241                     ;
    VEJ     (C2)                            ; If not CR skip ahead
                ABYT($0D)                   ; n1
                ABRF(BRANCH_91C2 )          ; Forward branch to label
    BCH     BRANCH_9209                     ; 

BRANCH_91C2:
    LDI     XL,LB(ARZ)                      ; 
    LDI     XH,HB(ARZ)                      ; X = $7A08 = ARZ
    PSH     Y                               ; 
    STX     Y                               ; 
    LDA     UH                              ; 
    BZR     BRANCH_91DA                     ; 
    CPI     UL,$5D                          ;
    BZS     BRANCH_91D7                     ;
    CPI     UL,$5B                          ;
    BZR     BRANCH_91DB                     ;
    LDI     UL,$6B                          ;

BRANCH_91D7:
    LDI     A,$F1                           ;
    STA     UH                              ;

BRANCH_91DA:
    SIN     X                               ;

BRANCH_91DB:
    LDA     UL                              ;
    SIN     X                               ;
    CPI     UH,$E0                          ;
    BCR     BRANCH_9201                     ;
    VMJ     ($1C)                           ; Basic command whose token is in U-Reg, transferred from the token table in plain text from (Y-Reg).
                ABYT($02)                   ; n1
    BZR     BRANCH_91F6                     ;
    LDI     YL,$0A                          ;
    LDI     A,$64                           ;
    CPA     (OUT_BUF + $41)                 ;
    BZR     BRANCH_91FF                     ;
    LDI     YL,$08                          ;
    LDI     A,$7E                           ;
    SIN     Y                               ;
    BCH     BRANCH_91FF                     ;


BRANCH_91F6: ; branched to from 91E4
    BII	    (OUT_BUF + $41),$80             ;
    BZR     BRANCH_91FF                     ;
    LDI	    A,$20                           ;
    SIN     Y                               ; (Y) = A. Then Y = Y + 1

BRANCH_91FF: ; branched to from 91ED, 91F4, 91FA
    LDX	    Y                               ; X = Y

BRANCH_9201: ; branched to from 91DF
    SEC                                     ; Set Carry
    LDA	    XL                              ;
    SBI	    A,$09                           ;
    LDI	    XL,$08                          ;
    BCH 	BRANCH_91B5                     ;


BRANCH_9209: ; branched to from 91C0
    SJP	    SUB_9B41                        ;
    BCS     BRANCH_9241                     ;
    SJP	    SUB_9BC1                        ; Manipulates OUT_BUF
    BCS     BRANCH_9241                     ;
    SJP	    SUB_9B76                        ;
    BCS     BRANCH_9241                     ;
    VEJ	    (F4)                            ; Loads U-Reg with 16-bit value from address of (pp)
                AWRD(OUT_BUF + $19)         ; Address
    LDX	    Y                               ; X = Y
    SJP	    (U_MINUS_X - 1)                 ; DEC U then U-Reg = U-Reg - X-Reg (with overflow C=1)
    BCR     BRANCH_9233                     ;

BRANCH_9222: ; branched to from 922D, 9231
    LDA	    (X)                             ;
    INC	    A                               ;
    BZR     BRANCH_9184                     ;
    BII	    (OUT_BUF  + $41),$40            ;
    BZS     BRANCH_9233                     ;
    INC	    X                               ;
    LOP	    UL,BRANCH_9222                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set
    DEC	    UH                              ;
    BCS     BRANCH_9222                     ;

BRANCH_9233: ; branched to from 9220, 922A
    BII	    (OUT_BUF + $41),$40             ;
    BZR     BRANCH_923C                     ;
    SJP	    SUB_9B41                        ;

BRANCH_923C: ; branched to from 9237
    POP	    Y                               ;
    JMP	    JMP_9607                        ;


BRANCH_9241: ; branched to from 9187, 91BB, 920C, 9211, 9216
    SJP	    SUB_9B5E                        ; REC if UH == 3C, 34, 40, 3A
    BCS     BRANCH_924B                     ;
    SJP	    SUB_9C32                        ; Pulls some valuse out of OUT_BUF and saves to XH, XL, UH, UL, A
    BCH  	BRANCH_9187                     ;


BRANCH_924B: ; branched to from 9244
    POP	    Y                               ;

BRANCH_924D: ; branched to from 9259
    JMP	    BRANCH_962B                     ; Maybe exit if not arg used, i.e. CLOAD not CLOAD "file"

;% CLOAD_SAVE_MERGE END


;------------------------------------------------------------------------------------------------------------
; SUB_9250 - Called from 916D ***JMP
; 
; Arguments:
; Output:
; RegMod:
;% SUB_9250 START
SUB_9250:
    BII     (OUT_BUF + $41),$04             ; Is Bit3 set? In Output Buffer
    BZR     BRANCH_92BB                     ; If bit set branch
    SJP     SUB_9D65                        ; Does CLOAD UART output
    BCS     BRANCH_924D                     ; Jumps to BRANCH_962B, looks at (OUT_BUF  + 41) and ??
    SJP     BRANCH_9AA7                     ; Does UART Rx
    BCS     BRANCH_9263                     ;
    SJP     SUB_9E3E                        ; No idea

BRANCH_9263: ; branched to from 925E
    LDA	    (OUT_BUF + $41)                 ; In Output Buffer, does not affect C
    BCS     BRANCH_928F                     ;
    SHR                                     ; C=0 -> Right shift -> C=B0
    BCR     BRANCH_926F                     ;
    ANI	    (X),$00                         ; Clear what XREG points to
    BCH     BRANCH_928C                     ;


BRANCH_926F: ; branched to from 9269
    SHR                                     ; Right shift
    BCR     BRANCH_927F                     ; C=B1
    VEJ	    (F4)                            ; Loads U-Reg with 16-bit value from address in Output Buffer
                AWRD(OUT_BUF + $34)         ; Address
    CPA	    UL                              ;
    BZR     BRANCH_927B                     ; If A != UL branch
    INC	    A                               ;
    BZS     BRANCH_928C                     ; $FF + $01 = $00?

BRANCH_927B: ; branched to from 9276
    LDX     U                               ; X=U, U was from output buffer?
    STX     P                               ; X to Program Counter ***JMP


BRANCH_927F: ; branched to from 9270
    ORI	    (X),$FF                         ; Set all bits 
    VEJ	    (CA)                            ; Transfers X to 78(pp), 78(pp+1) BASPRG_END_H 
                ABYT($67)                   ; n1
    SJP     (DEL_DIM_VARS + $02)            ; Deletes dim variables. If program and variable memory overlap C=1
    VEJ	    (F4)                            ; Loads U-Reg with 16-bit value from address of (pp)
                AWRD(OUT_BUF + $15)         ; Address
    VEJ	    (F6)                            ; Transfers U to pp, pp+1
                AWRD(BASPRG_EDT_H)          ; Address

BRANCH_928C: ; branched to from 926D, 9279
    JMP	    JMP_960C                        ;


BRANCH_928F: ; branched to from 9266
    PSH     U                               ;
    SHR                                     ;
    BCR     BRANCH_929F                     ; C = B1
    LDI	    XL,$08                          ; No idea what X is here ***
    LDI	    UL,$4E                          ; No idea what X is here ***
    LDI	    A,$00                           ;

BRANCH_929A: ; branched to from 929B
    SIN	    X                               ; (X) = A. Then X = X + 1. No idea what X is here
    LOP	    UL,BRANCH_929A                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set
    BCH     BRANCH_92B3                     ;

BRANCH_929F: ; branched to from 9292
    SHR                                     ;
    BCS     BRANCH_92B3                     ;
    SJP     (DEL_DIM_VARS + $02)            ; Deletes dim variables. If program and variable memory overlap C=1
    ANI	    (OUT_BUF + $41),$10             ;
    BZR     BRANCH_92B3                     ;
    VEJ	    (CC)                            ; Loads X-Reg with address at 78(pp) 78(pp+1) BASPRG_ST_H
                ABYT($65)                   ; n1
    ORI	    (X),$FF                         ; Set all bits
    VEJ	    (CA)                            ; Transfers X to 78(pp), 78(pp+1) BASPRG_END_H
                ABYT($67)                   ; n1
    VEJ	    (CA)                            ; Transfers X to 78(pp), 78(pp+1) BASPRG_EDT_H
                ABYT($69)                   ; n1

BRANCH_92B3: ; branched to from 929D, 92A0, 92A9
    POP	     U                              ;
    JMP	     JMP_9641                       ; no idea


BRANCH_92BB: ; branched to from 9254
    SJP      INIT_SRCH_PTR                  ; 
    VEJ	     (CC)                           ; Loads X-Reg with address at 78(pp) 78(pp+1) BASPRG_END_H
                ABYT($67)                   ; n1
    INC	     X                              ;
    BII	     (OUT_BUF + $41),$10            ;
    BZR      BRANCH_92C6                    ;
    VEJ	     (CC)                           ; Loads X-Reg with address at 78(pp) 78(pp+1) BASPRG_ST_H
                ABYT($65)                   ; n1

BRANCH_92C6: ; branched to from 92C2
    VEJ	    (CA)                            ; Transfers X to 78(pp), 78(pp+1) BASPRG_END_H
                ABYT($67)                   ; n1
    VEJ	    (CA)                            ; Transfers X to 78(pp), 78(pp+1) BASPRG_EDT_H
                ABYT($69)                   ; n1
    ORI	    (X),$FF                         ; Set all bits
    PSH	    Y                               ;

BRANCH_92CE: ; branched to from 9317
    LDI	    XL,LB(STR_BUF)                  ;
    LDI	    XH,HB(STR_BUF)                  ; X= 7B10 = STR_BUF
    LDI	    UL,$4F                          ;
    SJP     SUB_9AA5                        ; No idea
    BCS     SUB_934A                        ;
    DEC	    X                               ;
    LDA	    (X)                             ;
    CPI	    A,$0D                           ; CR
    BZR     BRANCH_9319                     ;
    LDI	    A,$60                           ;
    STA	    (INBUFPTR_L)                    ; Input Buffer pointer (L)
    SJP     SUB_9337                        ;
    SJP     TOKENIZE_INBUF                  ;
    BZS     BRANCH_931B                     ;
    REC                                     ; Reset Carry
    LDA	    XL                              ;
    SBI	    A,$60                           ;
    BCS     BRANCH_92FC                     ;
    SJP     SUB_9337                        ;

BRANCH_92F5: ; branched to from 934E
    ORI     #(PC1500_MSK_REG),01            ; Set interrupt mask for PC-1500 ON Key
    VMJ	    ($42)                           ; Editor warm start 


BRANCH_92FC: ; branched to from 92F0
    CPI	    A,$4F                           ;
    BCS     BRANCH_9319                     ;
    PSH	    X                               ;
    LDI	    YL,$60                          ;
    SJP     DEC2HEX                         ; Conversion from decimal to hexadecimal.
    POP	    X                               ;
    BZS     BRANCH_9319                     ;
    BCS     BRANCH_931B                     ;
    SJP     (PRGLINE_TDI + $13)             ; Transfer, delete, insert row from Input buffer
    STA	    XH                              ;
    AND	    (X)                             ;
    CPA	    XL                              ;
    SBC	    XL                              ;
    SJP     SUB_9337                        ;
    BCH     BRANCH_92CE                     ;

BRANCH_9319: ; branched to from 92DD, 92FE, 9309
    LDI	    UH,$43                          ;

BRANCH_931B: ; branched to from 92EA, 930B
    PSH	    U                               ;
    SJP     SUB_9337                        ;
    POP	    U                               ;

BRANCH_9322: ; branched to from 934C
    POP	    Y                               ;
    LDI	    YH,$00                          ;

JMP_9326: ; jumped to from 969D, 976E
    ORI     #(PC1500_MSK_REG),$01           ; Set interrupt mask for PC-1500 ON Key
    LDA	    UH                              ;
    VZR     ($E0)                           ; Indicates if UH is not "00" error message
    VEJ     (D8)                            ; Checks calculator mode
    BZS     BRANCH_9334                     ;
    JMP	    BCMD_DATA                       ; Basic Command RADIAN

BRANCH_9334: ; branched to from 932F
    JMP	    (BCMD_STOP + $10)               ; BASIC command STOP

;% SUB_9250 END


.FILL ($9337 - $)
.ORG $9337
;------------------------------------------------------------------------------------------------------------
; SUB_9337 - Called from 92E4, 92F2, 9314, 931D
; 
; Arguments:
; Output:
; RegMod:
;% SUB_9337 START
SUB_9337:
    LDI	    XL,LB(STR_BUF)                  ;
    LDI	    XH,HB(STR_BUF)                  ; X = 7B10 = STR_BUF
    LDI	    YL,LB(OUT_BUF)                  ;
    LDI	    YH,HB(OUT_BUF)                  ; Y = 7B60 = OUT_BUF
    LDI	    UL,$4F                          ;

BRANCH_9341: ; branched to from 9347
    LDA	    (X)                             ;
    STA	    UH                              ;
    LDA	    (Y)                             ;
    SIN	    X                               ; (X) = A. Then X = X + 1 
    LDA	    UH                              ;
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1
    LOP	    UL,BRANCH_9341                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set
    RTN                                     ;

;% SUB_9337 END


;------------------------------------------------------------------------------------------------------------
; SUB_934A - Called from 92D7
; 
; Arguments: UH
; Output:
; RegMod:
;% SUB_934A START
SUB_934A:
    CPI	    UH,$42                          ; '*'?
    BZR     BRANCH_9322                     ; UH != 42
    BCH    	BRANCH_92F5                     ;

;% SUB_934A END


;------------------------------------------------------------------------------------------------------------
; SUB_9350 - Called from 
; 
; Arguments:
; Output:
; RegMod:
;% SUB_9350 START
SUB_9350:
    SJP	    BRANCH_93C1                     ;
    STA	    (OUT_BUF + $3E)                 ;
    
JMP_9356:    
    SJP	    PRGST2XREG                      ; X-Reg = Program Start Address. U-Reg = STATUS 1-2
    VCR	    ($42)                           ; If Carry, Editor warm start
    SJP	    SUB_9949                        ;
    VCR     ($E0)                           ; If Carry, Indicates if UH is not "00" error message
    LDI	    A,$64                           ;
    SJP	    SUB_98B7                        ;
    BCS     BRANCH_93BE                     ;  
    JMP	    BRANCH_917D                     ;

JMP_936A:
    LDI	    A,$6C                           ;
    SJP	    SUB_98C0                        ;
    BCS     BRANCH_937A                     ;  
    SJP	    SUB_9BDF                        ;

BRANCH_9374: ; branched to from 9384
    BCS     BRANCH_937A                     ;  
    VEJ	    (C8)                            ; Jump fwd (p) if following character doesn’t represent end to command sequence or line. 
                ABRF(BRANCH_9386)           ; Forward branch to label
    BCH 	BRANCH_93AC                     ;

BRANCH_937A: ; branched to from 936F, 93A8
    SJP	    SUB_9B5E                        ; REC if UH == 3C, 34, 40, 3A
    BCS     BRANCH_93BE                     ;              
    SJP	    SUB_9C32                        ; Pulls some valuse out of OUT_BUF and saves to XH, XL, UH, UL, A
    STX     Y                               ; Y = X
    BCH     BRANCH_9374                     ;

BRANCH_9386: ; branched to from 9376, 93B5
    VEJ     (C6)                            ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg

BRANCH_9387: ; branched to from 93BA, 
    VEJ	    (DE)                            ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
                ABRF(BRANCH_93BE)           ; Forward branch to label
    VEJ     (D2)                            ; If AR-X contains integer value, reseed it with (10)(DD2D) according to D2. If AR-X contains CSI further at distance address corresponding to D1
                ABRF(BRANCH_9393)           ; Forward branch to label
                ABYT($80)                   ; n1
    PSH	    Y                               ;
    SJP	    ARX2STRNG                       ; Convert AR-X to string
    POP	    Y                               ;

BRANCH_9393: ; branched to from 9389
    VEJ     (DC)                            ; Loads CSI from AR-X: Address by X-Reg length by UL & A 
    DEC	    A                               ;
    BCS     BRANCH_93A2                     ;   
    LDA	    (ARX + $04)                     ;
    SBI	    A,$C0                           ; A = A - n
    BZR     BRANCH_93AA                     ;
    STA	    XL                              ;
    LDI	    XH,$7A                          ;
    STA	    (X)                             ;

BRANCH_93A2: ; branched to from 9395
    STA	    UL                              ;
    LDI	    UH,$00                          ;
    SJP	    SUB_9ACF                        ; Copies some stuff in OUT_BUF
    BCS     BRANCH_937A                     ;

BRANCH_93AA: ; branched to from 939C
    VEJ	    (C8)                            ; Jump fwd (p) if following character doesn’t represent end to command sequence or line. 
                ABRF(BRANCH_93AE)           ; Forward branch to label

BRANCH_93AC: ; branched to from 9378
    BCH 	BRANCH_9468                     ;

BRANCH_93AE: ; branched to from 93AA
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not ';' branch fwd n
                ACHR(SEMI)                  ; Character
                ABRF(BRANCH_93B7)           ;
    VEJ	    (C8)                            ; Jump fwd if following character doesn’t represent end to command sequence or line. 
                ABRF(BRANCH_93B5)           ;
    BCH 	BRANCH_947A                     ;


BRANCH_93B5: ; branched to from 93B1
    BCH 	BRANCH_9386                     ;


BRANCH_93B7: ; branched to from 93AE
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not ',' branch fwd n
                ACHR(COMMA)                 ; Character
                ABRF(BRANCH_93BC)           ;

    BCH 	BRANCH_9387                     ;


BRANCH_93BC: ; branched to from 93B7
    LDI	    UH,$01                          ;

BRANCH_93BE: ; branched to from 9365, 937D, 9387
    JMP	    BRANCH_962B                     ;


BRANCH_93C1: ; branched to from 9350
    LDI	    A,$C4                           ;   

BRANCH_93C3: ; branched to from 93CD
    LDI	    UH,$1B                          ;
    CPA	    (OPN)                           ; This table might be some sort of mode mask
    VZR	    ($E0)                           ; If Z=0 output error code in UH
    RTN                                     ;


BRANCH_93CB: ; branched to from 9045
    LDI	    A,$C0                           ;
    BCH 	BRANCH_93C3                     ;

;% SUB_9350 END


;------------------------------------------------------------------------------------------------------------
; Seperator byte 93CF
;% SEPERATOR_93CF START 
SEPERATOR_93CF:
    .BYTE $FF                               ; unused byte

;% SEPERATOR_93CF END


;------------------------------------------------------------------------------------------------------------
; PRINT# Jumped to from 8307 via High Bank
; Handles PRINT#-8
; Arguments:
; Output:
; RegMod:
;% PRINT_NUM START 
PRINT_NUM:
    LDI	    A,$C0                           ; 
    BCH 	BRANCH_93DB                     ;

;% PRINT_NUM END


;------------------------------------------------------------------------------------------------------------
; PRINT#2 Jumped to from 8307 via High Bank
; Does not actually handle PRINT # commands!
; Arguments:
; Output:
; RegMod:
;% PRINT_NUM_2 START
PRINT_NUM_2: ;Jumped to from 8307 
    LDI	    A,$C4                           ; Not reached?
    BCH 	BRANCH_93DB                     ;

    SJP     BRANCH_93C1                     ; Not reached?

BRANCH_93DB: ; branched to from 93D2, 93D6  ; Entry for PRINT#-8
    STA	    (OUT_BUF + $3E)                 ;

JMP_93DE: ; Jumped to from by way of TABLE_906B
    LDI	    A,$6C                           ;
    SJP     SUB_98B7                        ;
    BCS     BRANCH_9464                     ;
    SJP     SUB_9BDF                        ;

BRANCH_93E8: ; branched to from 949D
    BCS     BRANCH_9464                     ;
    VEJ	    (C8)                            ; Jump fwd if following character doesn’t represent end to command sequence or line. 
                ABRF(BRANCH_93EE)           ;
    BCH 	BRANCH_9468                     ;

BRANCH_93EE: ; branched to from 93EA
    VEJ     (C6)                            ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg

BRANCH_93EF: ; branched to from 948F
    ANI	    (OUT_BUF + $40),$00             ; OUT_BUF + 40

BRANCH_93F3: ; branched to from 9425
    BII	    (OUT_BUF + $40),$80             ;
    BZR     BRANCH_9405                     ; Not a valid address?
    VEJ	    (C2)                            ;
                AWRD(TOK_USING)             ; Token
                ABRF(BRANCH_9406)           ; Forward branch to label

    ORI	    (OUT_BUF + $40),$80             ;
    SJP     EVAL_USING                      ; Evaluation of USING paramters from Y-Reg. Not sure about $5F
                ABYT($5F)

BRANCH_9405:
    VEJ     (C0)                            ; Load next character/token to U-Reg

BRANCH_9406: ; branched to from 93F9
    BII	    (OUT_BUF + $40),$40             ;
    BZR     BRANCH_9427                     ;
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not TAB branch fwd n
                AWRD(TOK_TAB)               ; Token
                ABRF(BRANCH_9427)           ; Forward branch to label    
    ORI	    (OUT_BUF + $40),$40             ;
    VEJ	    (DE)                            ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
                ABRF(BRANCH_9464)           ; Forward branch to label
    VEJ	    (D0)                            ; Convert AR-X to integer & load to U-Reg. p specifies the range. If range exceeded: Branch fwd n
                ABYT($08)                   ; Token
                ABRF(BRANCH_9464)           ; Forward branch to label
    SJP     SUB_9A78                        ;
    BCS     BRANCH_9464                     ;
    VEJ	    (C8)                            ; Jump fwd if following character doesn’t represent end to command sequence or line. 
                ABRF(BRANCH_9422)           ; Forward branch to label
    BCH     BRANCH_947A                     ;

BRANCH_9422: ; branched to from 941E
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not ';' branch fwd n
                ACHR(SEMI)                  ; Token
                ABRF(BRANCH_9491)           ; Forward branch to label
    BCH     BRANCH_93F3                     ;

BRANCH_9427: ; branched to from 94A0, 940C
    VEJ     (C6)                            ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
    VEJ	    (DE)                            ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
                ABRF(BRANCH_9464)           ; Forward branch to label
    VEJ     (D2)                            ; If AR-X contains integer value, reseed it with (10)(DD2D) according to D2. If AR-X contains CSI further at distance address corresponding to D1
                ABRF(BRANCH_943B)           ; Forward branch to label
                ABYT($80)                   ;
    PSH	    Y                               ;
    LDI	    A,$01                           ;
    SJP     USING_FRMT                      ;
    POP	    Y                               ;
    BCS     BRANCH_9464                     ;
    STA	    UL                              ;
    BCH     BRANCH_945C                     ;

BRANCH_943B: ; branched to from 942A
    VEJ     (DC)                            ; Loads CSI from AR-X: Address by X-Reg length by UL & A 
    BZR     BRANCH_944D                     ;
    LDA	    (ARX + $04)                     ;
    CPI	    A,$C1                           ;
    BZR     BRANCH_9466                     ;
    LDI	    A,$00                           ;
    LDI	    XH,HB(ARX)                      ;
    STA	    XL                              ; X = 7A00 = ARX
    STA	    (X)                             ;
    LDI	    UL,$01                          ;

BRANCH_944D: ; branched to from 943C
    LDA	    (USING_CHR)                     ;
    BZS     BRANCH_945C                     ;
    SEC                                     ; Set Carry
    STA	    UH                              ;
    SBC	    UL                              ;
    BCR     BRANCH_945A                     ;
    STA	    UH                              ;
    BCH 	BRANCH_945E                     ;


BRANCH_945A: ; branched to from 9455
    LDA	    UH                              ;
    STA	    UL                              ;

BRANCH_945C: ; branched to from 9439, 9450
    LDI	    UH,$00                          ;

BRANCH_945E: ; branched to from 9458
    DEC	    UL                              ;
    SJP     BRANCH_9A9D                     ; Outputs text
    BCR     BRANCH_9466                     ;

BRANCH_9464: ; branched to from 93E3, 93E8, 9414, 9416, 941C, 9428, 9436
    BCH 	BRANCH_9493                     ;


BRANCH_9466: ; branched to 9443, 9462
    VEJ	    (C8)                            ; Jump fwd if following character doesn’t represent end to command sequence or line. 
                ABRF(BRANCH_9475)           ;

BRANCH_9468: ; branched to from 93AC
    SJP	    SUB_9B41                        ; This seems to send the /CR after last char sent to LPT
    BCS     BRANCH_9493                     ;
    SJP	    SUB_9BC1                        ; Manipulates OUT_BUF
    BCS     BRANCH_9493                     ;
    JMP	    JMP_9607                        ;


BRANCH_9475:
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not ';' branch fwd n
                ACHR(SEMI)                  ;
                ABRF(BRANCH_9482)           ;
    VEJ	    (C8)                            ; Jump fwd if following character doesn’t represent end to command sequence or line. 
                ABRF(BRANCH_948E)           ;

BRANCH_947A: ; branched to from 93B3, 9420, 948C
    SJP	    SUB_9BC1                        ; Manipulates OUT_BUF
    BCS     BRANCH_9493                     ;
    JMP	    JMP_960C                        ;


BRANCH_9482:
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not ',' branch fwd n
                ACHR(COMMA)                 ;
                ABRF(BRANCH_9491)           ;
    SJP	    SUB_9A50                        ;
    BCS     BRANCH_9493                     ;
    VEJ	    (C8)                            ; Jump fwd if following character doesn’t represent end to command sequence or line. 
                ABRF(BRANCH_948E)           ;
    BCH     BRANCH_947A                     ;


BRANCH_948E: ; branched to from 9478, 948A
    VEJ      (C6)                           ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
    BCH 	 BRANCH_93EF                    ;


BRANCH_9491: ; branched to from 9422, 9482
    LDI	     UH,$01                         ;

BRANCH_9493: ; branched to from 9464, 946B, 9470, 947D, 9488
    SJP	     SUB_9B5E                       ; REC if UH == 3C, 34, 40, 3A
    BCS      BRANCH_94A0                    ;
    SJP	     SUB_9C32                       ; Pulls some valuse out of OUT_BUF and saves to XH, XL, UH, UL, A
    STX      Y                              ; Y = X
    JMP	     BRANCH_93E8                    ;


BRANCH_94A0: ; branched to from 9518, 9544
    JMP	     BRANCH_962B                    ;

;% PRINT_NUM_2 END


;--------------------------------------------------------------------------------------------------
; 94A3 ~ 94DF Byte array
; Used by BRANCH_955C: ; branched to from 9521, 9525, 9529, 9540
;% TBL_94A3 START
TBL_94A3:
    .BYTE $00,$0B,$00,$00,$88,$00,$00,$00,  $00,$13,$00,$00,$10,$00,$00,$00 
    .BYTE $00,$D3,$19,$00,$88,$00,$00,$00,  $01,$A3,$19,$00,$10,$00,$FF,$00                     
    .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00,  $FF,$00,$FF,$00,$FF,$00,$FF,$00
    .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00,  $FF,$00,$FF,$20,$FF
 
;% TBL_94A3 END


;--------------------------------------------------------------------------------------------------
; PRINT_NUM_HANDLER 94E0
; Called from 8307 (calc jump)->900D->9053(calc jump)->7A00
;% PRINT_NUM_HANDLER START 
PRINT_NUM_HANDLER: ; Called for PRINT#
    LDI	    A,$C0                           ;
    STA	    (OUT_BUF + $3E)                 ;
    LDI	    A,$28                           ;
    BII	    (CASS_FLAG),$80                 ;
    BZS     BRANCH_94EF                     ;
    LDI	    A,$08                           ;

BRANCH_94EF: ; jumped to from 94EB          ; Token and arg at 7BB0
    SJP	    SUB_98C0                        ; 94EF - Poke two JMPs into 7BA0-7BAF
    SJP	    SUB_9DF1                        ; 94F2 - HCOMT & text to 7B60
    BCR     BRANCH_94A0                     ;
    BII	    (OUT_BUF + $41),$20             ;
    BZR     BRANCH_9502                     ;
    SJP	    SUB_9D65                        ;
    BCH 	BRANCH_9518                     ;


BRANCH_9502: ; jumped to from 
    SJP	    SUB_9CEC                        ; Outputs 27 byte header
    BCS     BRANCH_94A0                     ;

JMP_9507: ; jumped to from 9626
    BII	    (OUT_BUF + $41),$20             ;
    BZS     BRANCH_951A                     ;
    BII	    (OUT_BUF + $41),$80             ;
    BZR     BRANCH_9518                     ;
    LDI	    A,$FF                           ;
    SJP	    DELAY_A_MS                      ; Time delay of A * 15.625ms

BRANCH_9518: ; branched to from 9511
    BCS     BRANCH_94A0                     ;

BRANCH_951A: ; branched to from 950B
    VEJ 	(CE)                            ; Determines variable 'F1' address all variable types allowed, if errors continue at P+n2
                ABYT($F1)                   ;
                ABRF(BRANCH_9542)           ; no variable argument so skip ahead
    BII	    (OUT_BUF + $41),$20             ;
    BZR     BRANCH_955C                     ;
    BII	    A,$01                           ;
    BZS     BRANCH_955C                     ;
    BII	    A,$20                           ;
    BZR     BRANCH_955C                     ;
    PSH	    A                               ;
    DEC	    U                               ;
    DEC	    U                               ;
    DEC	    U                               ;
    DEC	    U                               ;
    VEJ     (CC)                            ; Loads X-Reg with address at 78(pp) 78(pp+1) VAR_START_H
                ABYT($99)                   ;
    CPA	    UH                              ;
    BZR     BRANCH_953A                     ;
    LDA	    XL                              ;
    CPA	    UL                              ;
    BZS     BRANCH_953C                     ;

BRANCH_953A: ; branched to from 9534
    INC	    U                               ;
    INC	    U                               ;

BRANCH_953C: ; branched to from 9538
    INC	    U                               ;
    INC	    U                               ;
    POP	    A                               ;
    BCH 	BRANCH_955C                     ;

BRANCH_9542: ; branched to from 951A
    CPI	    UH,$15                          ;
    BZR     BRANCH_94A0                     ;
    LDA	    UL                              ;
    AEX                                     ; Accumulator High nibble & low nibble swapped
    SHR                                     ;
    SHR                                     ;
    LDI	    A,$00                           ;
    LDI	    XL,LBO(ARU,$07)                 ;
    LDI	    XH,HBO(ARU,$07)                 ; X = 7A1F = ARU
    LDI	    UL,$0F                          ;

BRANCH_9552: ; branched to from 9553
    SDE	    X                               ; (X) = A. X = X - 1
    LOP 	UL,BRANCH_9552                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set
    BCR     BRANCH_9559                     ;
    LDI	    A,$08                           ;

BRANCH_9559: ; branched to from 9555
    INC	    X                               ;
    STX     U                               ; U = X

BRANCH_955C: ; branched to from 9521, 9525, 9529, 9540
    STA	    (CASS_FLAG)                     ;
    LDI	    XH,HBO(TBL_94A3,$04)            ; TBL_94A3 94A7
    LDI	    XL,LBO(TBL_94A3,$04)            ; X = 94A7
    ADR	    X                               ; X = X + A + Carry
    SHR                                     ;
    LDI	    A,$05                           ;
    BCR     BRANCH_956F                     ;
    ADR	    U                               ; U = U + A + Carry
    LDX	    U                               ; X = U
    DEC	    X                               ;

BRANCH_956F: ; branched to from 9568
    VEJ     (DA)                            ; Cache/remember variable address from U-Reg and length from AR-X (7A07)
    LDI	    UH,HBO(ARX,$04)                 ;
    LDI	    UL,LBO(ARX,$04)                 ; U = ARX + $04 = $7A04

BRANCH_9574: ; branched to from 9576
    LDE     X                               ; A = (X) then X = X - 1
    STA	    (U)                             ;
    LOP     UL,BRANCH_9574                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set
    LDX	    U                               ; X = U
    BII	    (OUT_BUF + $41),$20             ;
    BZR     BRANCH_9582                     ;
    LDI	    XL,$07                          ;

BRANCH_9582: ; branched to from 957E
    INC	    XL                              ;
    LDI	    UL,$04                          ;
    LDI	    UH,$00                          ;
    SJP	    SUB_9BE1                        ; Manipulates OUT_BUF

BRANCH_958A: ; branched to from 9603
    BCS     BRANCH_95FB                     ;
    SJP	    SUB_9ACF                        ; Outputs 00 0B 00 00 88
    BCS     BRANCH_95FB                     ;
    BII	    (OUT_BUF + $41),$20             ;
    BZR     BRANCH_95A2                     ;
    LDI	    UH,HBO(ARX,$04)                 ;
    LDI	    UL,LBO(ARX,$04)                 ; U = $7A04 = (ARX + 4)

BRANCH_959B: ; branched to from 95A0
    DEC	    X                               ;
    LDA	    (U)                             ;
    CPA	    (X)                             ;
    BZR     BRANCH_95C2                     ;
    LOP     UL,BRANCH_959B                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set

BRANCH_95A2: ; branched to from 9595
    VEJ     (CC)                            ; Loads X-Reg with address at 78(pp) 78(pp+1) CURVARADD_H
                ABYT($83)                   ;
    LDA	    (CASS_FLAG)                     ;
    CPI	    A,$18                           ;
    BZS     BRANCH_95C7                     ;
    VEJ	    (F4)                            ;
                AWRD(ARX)                   ;
    LDI	    A,$FC                           ;
    ADR	    U                               ; U = U + A + Carry
    LDA	    UH                              ;
    DEC	    A                               ;

BRANCH_95B4: ; branched to from 95BE, 95F9
    PSH	    A                               ;
    SJP	    SUB_9ACF                        ; Outputs 00 00 00 00 00 00 00 00
    POP	    A                               ;
    BCS     BRANCH_95FB                     ;
    DEC	    A                               ;
    BCS     BRANCH_95B4                     ;
    BCH 	BRANCH_9605                     ;


BRANCH_95C2: ; branched to from 959E
    LDI	    UH,$42                          ;

BRANCH_95C4: ; branched to from 95FE
    JMP	    BRANCH_962B                     ;


BRANCH_95C7: ; branched to from 95A9
    LDI	    UL,$3F                          ;
    SJP	    SUB_9ACF                        ; Copies some stuff in OUT_BUF
    BCS     BRANCH_95FB                     ;
    BII	    (OUT_BUF + $41),$20             ;
    BZS     BRANCH_95DB                     ;
    LDI	    A,$FF                           ;
    SJP	    DELAY_A_MS                      ; Time delay of A * 15.625ms
    BCS     BRANCH_95FB                     ;

BRANCH_95DB: ; branched to from 95D2
    LDI	    XL,LB(STRING_VARS)              ;
    LDI	    XH,HB(STRING_VARS)              ; X = 7650 = STRING_VARS
    LDI	    UL,$AF                          ;
    SJP	    SUB_9ACF                        ; Copies some stuff in OUT_BUF
    BCS     BRANCH_95FB                     ;
    BII	    (OUT_BUF + $41),$20             ;
    BZS     BRANCH_95F3                     ;
    LDI	    A,$FF                           ;
    SJP	    DELAY_A_MS                      ; Time delay of A * 15.625ms
    BCS     BRANCH_95FB                     ;

BRANCH_95F3: ; branched to from 95EA
    LDI	    XL,$50                          ;
    LDI	    UL,$AF                          ;
    LDI	    A,$00                           ;
    BCH 	BRANCH_95B4                     ;

BRANCH_95FB: ; branched to from 958A, 958F, 95BB, 95CC, 95D6, 95D6, 95E4, 95F1
    SJP	    SUB_9B5E                        ; REC if UH == 3C, 34, 40, 3A
    BCS     BRANCH_95C4                     ;
    SJP	    SUB_9C32                        ; Pulls some valuse out of OUT_BUF and saves to XH, XL, UH, UL, A
    BCH 	BRANCH_958A                     ;


BRANCH_9605: ; branched to from 95C0
    VEJ	    (C8)                            ; If following char not end of command sequence or line. 
                ABRF(BRANCH_9616)           ; Jump fwd (p). Handles compound statement?
JMP_9607: ; jumped from from 923E, 917A     ; PRINT#-8 uses this exit
    SJP	    SUB_9E3E                        ;
    BCS     BRANCH_962B                     ;

JMP_960C: ; jumped to from 928C, 9859
    SJP	    SUB_9BAA                        ; Checks some things in OUTPUT BUFFER, pokes values in CE-158 registers
    ORI     #(PC1500_MSK_REG),$01           ; PC-1500 - Set interrupt mask for ON Key

#IFNDEF ENBPD                               ; If we are not redirecting exit for CLOAD/CSAVE/MERGE/PRINT#
    DEC	    Y                               ;
    VEJ     (E2)                            ; Start of Basic Interpreter
#ELSE                                       ; If we are redirecting exit for CLOAD/CSAVE/MERGE/PRINT#
    BCH     PRNT_NUM8                       ; A hack to handle ML calling PRINT#-8
#ENDIF


BRANCH_9616:                                ; Handles compound statement?
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not ',' branch fwd n
                ACHR(COMMA)                 ;
                ABRF(BRANCH_9629)           ;
    LDI	    A,$84                           ;
    BII	    (OUT_BUF + $41),$20             ; In OUT_BUF
    BZS     BRANCH_9623                     ;
    LDI	    A,$04                           ;

BRANCH_9623: ; branched to from 961F
    STA	    (CASS_FLAG)                     ;
    JMP	    JMP_9507                        ; Unknown


BRANCH_9629: ; branched to from 9616
    LDI	    UH,$01                          ;

BRANCH_962B: ; branched to from 9157, jumped to from 985E
    LDA	    (OUT_BUF  + $41)                ; In OUT_BUF
    CPI	    A,$A0                           ;
    BCR     BRANCH_963E                     ;
    LDX	    U                               ; X = U
    ANI     #(PC1500_MSK_REG),$FC           ; Clear IRQ and ON Key interrupt mask for PC-1500
    SJP	    SUB_9E47                        ; Unknown
    STX     U                               ; U = X


BRANCH_963E: ; branched to from 9630
    SJP     SUB_9BAA                        ; Checks some things in OUTPUT BUFFER, pokes values in CE-158 registers

JMP_9641: ; Jumped to from 92B5
    ORI     #(PC1500_MSK_REG),$01           ; Set interrupt mask for PC-1500 ON Key
    LDA	    UH                              ;
    VZR     ($E0)                           ; If Z=0 output error code in UH
    ORI     #(PC1500_IF_REG),$02            ;
    JMP	    BCMD_DATA                       ; Basic Command DATA / ARUN / AREAD

;% PRINT_NUM_HANDLER END


;--------------------------------------------------------------------------------------------------
; 9651 ~ 965F - Unused space in original ROM
; Used for enabling direct ML call of PRINT,CLOAD,CSAVE,MERGE
; Set $7BFF, (IN_BUF+$4F) to $A5 before call as flag of direct ML call, i.e. not called by BASIC
;% SEPARATOR_9651 START 
SEPARATOR_9651:
#IFNDEF ENBPD
    .BYTE $FF,$00,$FF,$00,$FF,$00,$FF,$00, $FF,$00,$FF,$00,$FF,$00,$FF 
#ELSE

PRNT_NUM8:                                  ; Hack to allow a ML routine to call PRINT#-8
    DEC	    Y                               ; Part of original exit code
    LDA     (IN_BUF + $4F)                  ; We sat last byte of IN_BUF to $A5
    CPI     A,$A5                           ; to designate that a ML routine called PRINT#-8
    BZS     PRNT_NUM8_ML                    ; If = then PRINT#-8 wsa called by a ML routine
    VEJ     (E2)                            ; Was BASIC call so jump to start of Basic Interpreter

PRNT_NUM8_ML:
    RTN                                     ; Was ML call so return directly

    .BYTE $FF,$00,$FF,$00,$FF               ; Remaining filler bytes
#ENDIF

;% SEPARATOR_9651 END


; .FILL ($9660 - $)
; .ORG $9660
;--------------------------------------------------------------------------------------------------
; INPUT# - Jumped to from 8307 via High Bank
; Arguments: XREG = Address, YREG = Token,
; Output:
; RegMod:
;% INPUT_NUM START
INPUT_NUM: ; 9660
    LDI	    A,$C0                           ;
    STA	    (OUT_BUF + $3E)                 ; In OUTPUT_BUFFER
    VEJ	    (C2)                            ; If next character is not '%', branch fwd 'n'.
                ACHR(PERCENT)               ;
                ABRF(BRANCH_96AE)           ;

    ; This section handleS "%" array inputs
    VEJ	    (CE)                            ; Determines variable pointed to by Y-REG if errors branch fwd
                ABYT($F1)                   ;
                ABRF(BRANCH_96E3)           ;
    LDX     U                               ; X = U. U returned from (CE) as start address of variable
    LDI	    UH,$44                          ;    
    CPI	    A,$29                           ; A must have been changed in (CE) call
    VZR     ($E0)                           ; If UH != 00 reset Set Output ERROR 1
    DEC	    X                               ;
    BII	    (X),$20                         ; Look for a space before variable?
    VZS     ($E0)                           ; If Z Set Output ERROR 1 if UH != 00
    INC	    X                               ; X is back to address of variable
    LIN	    X                               ; A = (X) then INC X
    STA	    UH                              ;
    LIN	    X                               ; A = (X) then INC X
    STA     UL                              ; What is U-REG pointing to?
    INC	    X                               ;
    INC	    X                               ;
    INC	    X                               ;
    DEC	    U                               ;
    DEC	    U                               ;
    DEC	    U                               ;
    DEC	    U                               ;
    PSH 	X                               ;
    PSH	    U                               ;
    SJP	    (DELU_FROMX + 1)                ; Deletes U+2 bytes? from X-REG
    LDI	    A,$0C                           ;
    SJP	    SUB_98C0                        ; polls RXCOM, perhaps gathers whole array?
    POP	    U                               ;
    POP	    X                               ;
    SJP	    BRANCH_9AA7                     ; polls RXCOM
    BCR     BRANCH_96A0                     ;
    CPI	    UH,$42                          ;
    BZS     BRANCH_96A8                     ; No idea
    JMP	    JMP_9326                        ; Exits through BASIC command RADIAN


BRANCH_96A0: ; branched to from 9697
    DEC	    X                               ; X is still in variable?
    LDA	    (X)                             ;
    CPI	    A,$0D                           ; Looking for CR, end of COM input line?
    BZR     BRANCH_96A8                     ;
    ANI	    (X),$00                         ; Clear address (X)

BRANCH_96A8: ; branched to from 969B, 96A4
    ORI     #(PC1500_MSK_REG),$01           ; Set interrupt mask for PC-1500 ON Key
    VEJ     (E2)                            ; Start of Basic Interpreter


BRANCH_96AE: ; branched to from 9665 if not a "%" array input
    VEJ     (C6)                            ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
    LDI	    UH,$1A                          ;
    VEJ     (D8)                            ; Checks if program ends. If so:Z=0
    VZS     ($E0)                           ; If Z=1 CALL (E0). If Z Set Output ERROR 1 if UH != 00
    ANI	    (OUT_BUF + $3F),$00             ;
    VEJ	    (C2)                            ; If next character is not '$', (string variable) branch fwd 'n'. 
                ACHR(DOLLAR)                ; This path is used for INPUT$
                ABRF(BRANCH_96C0)           ;
    VEJ     (C0)                            ; Load next character/token to U-Reg
    ORI	    (OUT_BUF + $3F),$01             ; In output buffer

BRANCH_96C0: ; branched to from 96B8
    VEJ     (C6)                            ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
    SJP	    INBUF_CLR                       ; Inside delete Input_Buffer w/0D
    VEJ	    (C2)                            ; If next character is not quote mark, branch fwd 'n'. 
                ACHR(QUOTE)                 ; From here to 96E4 is only if displaying a message 
                ABRF(BRANCH_96E4)           ;
    VMJ	    (0C)                            ; Determine string length, create CSI in AR-X
    PSH	    Y                               ; Y-REG contains end address marker
    LDI	    YL,LB(IN_BUF)                   ;
    LDI	    YH,HB(IN_BUF)                   ; Y = 7BB0, IN_BUF
    LDA	    (ARX + $07)                     ; last byte of AR-X
    STA	    UL                              ;
    SJP	    XREG2YREG                       ; Transfers UL bytes from X-Reg to Y-Reg
    LDA	    YL                              ;
    STA	    (INBUFPTR_L)                    ;
    POP	    Y                               ;
    VEJ	    (C2)                            ;  If next character is not ';', branch fwd 'n'. If 'p' is Fn then 3 args, if not 2 args
                ACHR(SEMI)                  ;
                ABRF(BRANCH_96EC)           ;    
    LDI	    A,$40                           ;
    BCH     BRANCH_96F6                     ; Must have been ';' so keep parsing?


BRANCH_96E3: ; branched to from 9668
    VEJ     (E0)                            ; Indicates if UH is not "00" error message, error exit.


BRANCH_96E4: ; branched to from 96C4
    VEJ     (C6)                            ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
    LDI	    A,$3F                           ; '?'. Start of the data input section
    STA	    (IN_BUF)                        ;
    BCH 	BRANCH_96EF                     ;

BRANCH_96EC: ; branched to from 96DC
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not ',' branch fwd n
                ACHR(COMMA)                 ; Makes sure there is a , preceeding variable?
                ABRF(BRANCH_9767)           ; Error exit
BRANCH_96EF: ; branched to from 96EA
    LDI	    A,$B0                           ;
    STA	    (INBUFPTR_L)                    ;
    LDI	    A,$00                           ;

BRANCH_96F6: ; branched to from 96E1
    STA	    (DISPARAM)                      ;
    ORI	    (BREAKPARAM),$10                ;
    SJP	    PREPLCDOUT                      ; Prepare the LCD output if C=1
    LDI	    UH,$20                          ;
    ANI	    (BREAKPARAM),$00                ;
    VCS     ($E0)                           ; If Carry Set Indicates if UH is not "00" error message
    LDI	    A,$0C                           ;
    SJP	    SUB_98C0                        ; A bunch of bit twiddling based on command calls RXCOM once to flush?
    BCS     BRANCH_976E                     ; Exit through BASIC command RADIAN
    PSH	    Y                               ;      
    LDI	    YH,$7B                          ;
    LDA	    (INBUFPTR_L)                    ;
    STA	    YL                              ; Y now points to current position in input buffer?
    SJP	    PRGMDISP                        ; Displays input buffer on LCD, i.e. INPUT "TEXT ON LCD"

BRANCH_971A: ; branched to from 97FA
    POP	    Y                               ;
    VEJ	    (CE)                            ; Determines variable 'n1' address all variable types allowed, if errors continue at P+n2
                ABYT($58)                   ;
                ABRF(BRANCH_976E)           ; Exit through BASIC command RADIAN
    VEJ     (F6)                            ; Copy U-REG to 7886-87
                AWRD(LASTVARADD_H)          ;
    INC	    X                               ;
    LDA	    (ARX + $07)                     ;
    STA	    (X)                             ;
    PSH	    Y                               ; 
    LDI	    YH,$7B                          ;
    SJP	    INBUF_CLRRST                    ;
    LDA	    (INBUFPTR_L)                    ;
    STA	    XL                              ;
    LDI	    XH,$7B                          ;
    LDI	    A,$FF                           ;
    SEC                                     ; Set Carry
    SBC	    XL                              ;
    STA	    UL                              ;
    SJP	    SUB_9AA5                        ; KI, gets input from RXCOM
    BCS     BRANCH_9768                     ; KI in loop processing input?
    DEC	    X                               ;
    LDI	    UH,$43                          ;
    LDA	    (X)                             ;
    CPI	    A,$0D                           ; Look for CR?
    BZR     BRANCH_976C                     ;
    BII	    (OUT_BUF + $3F),$01             ; In IN_BUF
    BZR     BRANCH_9757                     ;
    BII	    (LASTVARTYPE),$80               ;
    BZS     BRANCH_9757                     ;
    SJP	    TOKENIZE_INBUF                  ;
    BZS     BRANCH_976C                     ;

BRANCH_9757: ; branched to from 974A, 9750
    LDA	    (INBUFPTR_L)                    ;
    CPA	    XL                              ;
    BCR     BRANCH_9771                     ;

BRANCH_975D: ; branched to from 976A
    ORI     #(PC1500_MSK_REG),$01           ; Set interrupt mask for PC-1500 ON Key
    POP	    Y                               ;
    JMP	    BCMD_REM                        ; Basic command REM


BRANCH_9767: ; branched to from 96EC
    VEJ     (E4)                            ; Output error 1 and return to the editor


BRANCH_9768: ; branched to from 973C
    CPI	    UH,$42                          ;
    BZS     BRANCH_975D                     ;

BRANCH_976C: ; branched to from 9744, 9755, 97AA, 9819
    POP	    Y                               ;

BRANCH_976E: ; branched to from 970D, 971C, 97D0, 9817
    JMP	    JMP_9326                        ; Exit through BASIC command RADIAN


BRANCH_9771: ; branched to from 975B
    STA	    YL                              ;
    LDI	    YH,$7B                          ;

BRANCH_9774: ; branched to from 9811
    VEJ	    (C2)                            ; If next character is not ',', branch fwd 'n'. 
                ACHR(COMMA)                 ; If there is not another variable after this one
                ABRF(BRANCH_9786)           ;
    VEJ     (EC)                            ; Clears arithmetic register X
    LDI	    A,$D0                           ;
    BII	    (LASTVARTYPE),$80               ;
    BZR     BRANCH_9783                     ;
    STA	    (ARX + $04)                     ;

BRANCH_9783: ; branched to from 977E
    DEC	    Y                               ;
    BCH 	BRANCH_97B6                     ;

BRANCH_9786: ; branched to from 9774
    VEJ     (C6)                            ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
    BII	    (LASTVARTYPE),$80               ;
    BZR     BRANCH_97B4                     ;
    VEJ	    (C2)                            ; If next character is not ' " ', branch fwd 'n'. 
                ACHR(QUOTE)                 ;
                ABRF(BRANCH_9794)           ;
    VMJ	    (0C)                            ; Determine string length, create CSI in AR-X
    BCH 	BRANCH_97B6                     ;

BRANCH_9794: ; branched to from 978D
    VEJ     (C6)                            ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
    LDX	    Y                               ; X = Y
    LDI	    UL,$4F                          ;

BRANCH_9799: ; branched to from 97A6
    LIN	    Y                               ; A = (Y) then INC Y
    CPI	    A,$E0                           ;
    BCS     BRANCH_97A8                     ;
    CPI	    A,$2C                           ; ","
    BZS     BRANCH_97AC                     ;
    CPI	    A,$0D                           ; CR
    BZS     BRANCH_97AC                     ;
    LOP	    UL,BRANCH_9799                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set

BRANCH_97A8: ; branched to from 979C, 97F8
    LDI	    UH,$1C                          ;
    BCH     BRANCH_976C                     ;

BRANCH_97AC: ; branched to from 97A0, 97A4
    DEC	    Y                               ;
    LDA	    YL                              ;
    SEC                                     ;
    SBC	    XL                              ;
    VMJ	    ($24)                           ; Creates CSI in AR-X. X-Reg start address, A length
    BCH 	BRANCH_97B6                     ;

BRANCH_97B4: ; branched to from 978B
    VEJ     (DE)                            ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
                ABRF(BRANCH_9919)

BRANCH_97B6: ; branched to from 9784, 9792, 97B2
    VEJ     (F4)                            ; Loads U-Reg with last variable address
                AWRD(LASTVARADD_H)          ;
    VEJ	    (CC)                            ; Loads X-Reg with address at 78(pp) 78(pp+1), LASTVARTYPE
                ABYT($88)                   ;
    SJP	    SAVEVARPTR_A                    ; Store address from U-Reg and Accumulator.
    VMJ	    (08)                            ; Transfers the result from AR-X to a fixed variable or clock module
                ABRF(BRANCH_9919)           ;
    LDX	    Y                               ; X = Y
    POP	    Y                               ;
    PSH	    X                               ;
    VEJ	    (C8)                            ; Syntax check: Jump fwd (p) if following character doesn’t represent end to command sequence or line. 
                ABRF(BRANCH_97EA)           ;
    POP	    X                               ;
    LDA	    (X)                             ;
    CPI	    A,$0D                           ; CR?
    LDI	    UH,$41                          ;
    BZR     BRANCH_976E                     ;
    ORI     #(PC1500_MSK_REG),$01           ; Set interrupt mask for PC-1500 ON Key
    DEC	    Y                               ;
    PSH	    Y                               ;    
    LDI	    YH,$7B                          ;
    LDA	    (INBUFPTR_L)                    ;
    STA	    YL                              ;
    ANI	    (DISPARAM),$00                  ; Clear Display Parameter flags
    SJP	    PRGMDISP                        ; Displays input buffer on LCD
    POP	    Y                               ;
    VEJ     (E2)                            ; Start of Basic Interpreter


BRANCH_97EA: ; branched to from 97C7
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not ',' branch fwd n
                ACHR(COMMA)                 ;
                ABRF(BRANCH_9813)           ;
    POP	    X                               ;
    PSH	    Y                               ; 
    LIN	    X                               ; A = (X) then INC X
    CPI	    A,$2C                           ;
    BZS     BRANCH_97FC                     ;
    CPI	    A,$0D                           ; CR?
    BZR     BRANCH_97A8                     ;
    BCH     BRANCH_971A                     ;

BRANCH_97FC: ; branched to from 97F4
    POP	    Y                               ;
    PSH	    X                               ;
    VEJ	    (CE)                            ; Determines variable 'n1' address all variable types allowed, if errors continue at P+n2
                ABYT($58)                   ;
                ABRF(BRANCH_9815)           ;
    VEJ     (F6)                            ; Copy U-REG to 7886-87
                AWRD(LASTVARADD_H)          ;
    INC	    X                               ;
    LDA	    (ARX + $07)                     ;
    STA	    (X)                             ;
    POP	    X                               ;
    PSH	    Y                               ;    
    STX     Y                               ; Y = X
    BCH     BRANCH_9774                     ;
    
BRANCH_9813:    
    LDI	    UH,$01                          ;

BRANCH_9815: ; branched to from 9800
    POP	    X                               ;
    BCH     BRANCH_976E                     ;

BRANCH_9819: ; branched to from 97B4, 97BE
    BCH     BRANCH_976C                     ;

;% INPUT_NUM END


;------------------------------------------------------------------------------------------------------------
; 981B ~ 981E seperator bytes
;% SEPARATOR_981B START 
SEPARATOR_981B:
    .BYTE $FF,$00,$FF,$01,$BF

;% SEPARATOR_981B END


;------------------------------------------------------------------------------------------------------------
; FEED - Jumped to from 8307 via High Bank
; Arguments: XREG = Address, YREG = Token,
; Outputs:
; RegMod:
;% FEED START
FEED:
    LDA     (OPN)                           ; This table might be some sort of mode mask
    STA     (OUT_BUF + $3E)                 ; In OUTPUT_BUFFER
    LDI     A,$6C                           ;
    SJP     SUB_98B7                        ;
    VEJ     (C8)                            ; Syntax check: Jump fwd (p) if following character doesn’t represent end to command sequence or line. 
                ABRF(BRANCH_9831)           ;
    LDI     UL,$00                          ;
    BCH     BRANCH_983D                     ;

BRANCH_9831:
    VEJ     (C6)                            ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
    VEJ     (DE)                            ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
                ABRF(BRANCH_985E)           ;
    VEJ     (D0)                            ; Convert AR-X to integer & load to U-Reg. p specifies the range. If range exceeded: Branch fwd n
                ABYT($01)                   ;
                ABRF(BRANCH_985E)           ;
    VEJ     (C8)                            ; Syntax check: Jump fwd (p) if following character doesn’t represent end to command sequence or line. 
                ABRF(BRANCH_985C)           ;
    VEJ     (F4)                            ; Loads U-Reg with $7A05
                AWRD(ARX + $05)             ;
    DEC     U

BRANCH_983D:
    LDA    (OUT_BUF + $46)                  ; In OUT_BUF
    BZS    BRANCH_9847                      ;
    INC    A                                ;
    CPI    A,$A7                            ;
    BZS    BRANCH_984E                      ;

BRANCH_9847:
    LDI     A,$20                           ;
    SJP     OUT_BUF + $4A                   ; In OUT_BUF what code has been poked in here?
    BCS     BRANCH_985E                     ;

BRANCH_984E:
    SJP     SUB_9B41                        ; No idea  
    BCS     BRANCH_985E                     ;
    LOP     UL,BRANCH_9847                  ;
    DEC     UH                              ;
    BCS     BRANCH_9847                     ;
    JMP     JMP_960C                        ;

BRANCH_985C:
    LDI     UH,$01                          ;

BRANCH_985E:
    JMP     BRANCH_962B                     ;

;% FEED END


;------------------------------------------------------------------------------
;% SEPARATOR_9862 START 
SEPARATOR_9862:
    .BYTE $FA,$00,$FF,$00,$FF,$45,$F7,$00,  $FF,$00,$FF,$00,$FF,$02,$FF

;% SEPARATOR_9862 END


;-------------------------------------------------------------------------------
; *** What calls this ***
;% UNKNOWN_9870 START
UNKNOWN_9870:
    VEJ     (DE)                            ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
                ABRF(BRANCH_9886)           ;
    VEJ     (D0)                            ; Convert AR-X to integer & load to U-Reg. p specifies the range. If range exceeded: Branch fwd n
                ABYT($09)                   ;
                ABRF(BRANCH_9886)           ;
    LDI     UH,$35                          ;
    BII     A,$E0                           ;
    VZR     ($E0)                           ; If Z Reset do Indexed Vectored Call. HB = $FF, LB = n ($00-$F6)
    ANI     (ZONE_REG),$E0                  ;
    ORA     (ZONE_REG)                      ;
    STA     (ZONE_REG)                      ;
    VEJ     (E2)                            ; Start of Basic Interpreter

BRANCH_9886: ; branched to from 9870, 9872
    VEJ     (E0)                            ; Indicates if UH is not "00" error message

;% UNKNOWN_9870 END


;-------------------------------------------------------------------------------------
; TBL_9887 - Used by BRANCH_9924
; 
;% TBL_9887 START 
TBL_9887:
    JMP	    BRANCH_828E                     ; Sends data to LPT output
    JMP	    SUB_9B1C                        ;
    JMP	    TXCOM                           ; Sends charecter in A to RS232 Port.
    JMP	    SUB_9B31                        ;
    JMP	    LB_TXLPT                        ;
    JMP	    SUB_9B31                        ;
    JMP	    LB_TXLPT                        ;
    JMP	    SUB_9B31                        ;
    JMP	    JMP_9C99                        ;
    JMP	    SUB_9B1C                        ;
    JMP	    JMP_9C60                        ;
    JMP	    SUB_9B31                        ;
    JMP	    LB_TXLPT                        ;
    JMP	    SUB_9B31                        ;
    JMP	    LB_TXLPT                        ;
    JMP	    SUB_9B31                        ;

;% TBL_9887 END


;------------------------------------------------------------------------------------------------------------
; SUB_98B7 - Called from 9828 Feed, 93E0 PRINT#2, 9362 SUB_9350
; 
; Arguments:
; Output:
; RegMod:
;% TBL_98B7 START
SUB_98B7:
    PSH     A                               ; Why PUSH then POP?
    POP	    A                               ;
    BCH 	BRANCH_98C1                     ;

;% TBL_98B7 END


;------------------------------------------------------------------------------------------------------------
; SUB_98BD - Called from 9152
; Seems to be used in KI mode to poll RXCOM
; Arguments:
; Output:
; RegMod:
;% TBL_98BD START
SUB_98BD: 
    LDA	    (OUT_BUF + $41)                 ; 

SUB_98C0: ; called from 936C, 94EF PRINT#, 970A, 968D
    NOP                                     ; PRINT# A=&08

BRANCH_98C1: ; branched to from 98BB 
    ANI     A,$7F                           ;
    STA	    (OUT_BUF + $41)                 ; PRINT# A=&08
    ANI     #(PC1500_MSK_REG),$FC           ; Clear IRQ and ON Key interrupt mask for PC-1500
    LDI	    XL,LB(TBL_9887)                 ; X = Pointer to JMP in TBL_9887 X, used in 9924
    LDI	    XH,HB(TBL_9887)                 ; Seems to be a table of function or return addresses
    PSH	    Y                               ; Y is pointer to location in program line
    LDI	    YL,LBO(OUT_BUF,$46)             ;
    LDI	    YH,HBO(OUT_BUF,$46)             ; Y = $7BA6
    ANI     A,$40                           ; PRINT# A=&00
    BZS     BRANCH_98F8                     ;
    LDA	    (OUT_BUF + $3E)                 ; in OUT_BUF
    CPI	    A,$C4                           ;
    BZS     BRANCH_98E1                     ;
    REC                                     ; Reset Carry

BRANCH_98E1: ; branched to from 98DE
    LDA	    (RS232C)                        ; *** need to figure out what this is
    BCR     BRANCH_98E9                     ;
    LDA	    (CONSOLE2)                      ; *** need to figure out what this is

BRANCH_98E9: ; branched to from 98E4
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1. OUT_BUF + 46 + 1 = 7AB7
    LDA	    (CE158_UNDEF1)                  ; *** need to figure out what this is
    BCR     BRANCH_98F2                     ;
    LDA	    (CE158_UNDEF2)                  ; *** need to figure out what this is

BRANCH_98F2: ; branched to from 98ED
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1. OUT_BUF + 47 + 1 = 7AB8
    LDA	    (CRLF_REG)                      ; *** need to figure out what this is
    BCH 	BRANCH_98FA                     ;

BRANCH_98F8: ; branched to from 98D7        ; A = $00 for PRINT#, Y = &7BA6 (OUT_BUF + $46)
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1. 7BA6+1=7BA7 (OUT_BUF + $47)
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1. 7BA7+1=7BA8 (OUT_BUF + $48)

BRANCH_98FA: ; branched to from 98F6
    BCR     BRANCH_98FD                     ; PRINT# C=1
    AEX                                     ; Accumulator High nibble & low nibble swapped

BRANCH_98FD: ; branched to from 98FA
    LDI	    UL,$0D                          ; PRINT# U=1B0D
    ANI     A,$07                           ; PRINT# A=0
    SHR                                     ; PRINT# A=0
    BCR     BRANCH_9906                     ; PRINT# C=0
    LDI	    UL,$0A                          ; 

BRANCH_9906: ; branched to from 9902
    BZS     BRANCH_990F                     ; PRINT# Z=1
    SHR                                     ;
    LDI	    A,$0D                           ;
    BCS     BRANCH_990F                     ;
    LDI	    A,$0A                           ;

BRANCH_990F: ; branched to from 9906, 990B
    SIN	    Y                               ; PRINT# Y=7BA8. (Y)=A=00. Then Y=Y+1=7BA9
    LDA	    UL                              ; PRINT# A=0D
    SIN	    Y                               ; PRINT# A=7BA9. (Y)=A=0D. Then Y=Y+1=7BAA
    LDA	    (OUT_BUF + $3E)                 ; PRINT# A=C0
    CPI	    A,$C4                           ;
    BZS     BRANCH_991A                     ; PRINT# Z=0
    
BRANCH_9919:    
    REC                                     ; Reset Carry

BRANCH_991A: ; branched to from 9917
    LDA	    (OUT_BUF + $41)                 ; PRINT# A=28
    AEX                                     ; PRINT# A=82
    ANI     A,$0A                           ; PRINT# A=02
    BCR     BRANCH_9924                     ; PRINT# C=0
    LDI	    A,$06                           ;

BRANCH_9924: ; branched to from 9920        ; PRINT# X=9887, Y=7BAA, A=02
    ADR	    X                               ; PRINT# X=9889
    SHL                                     ; PRINT# A=04
    ADR	    X                               ; PRINT# X=988D, Y=7BAA 
    TIN                                     ; (BA) PRINT# X=988E, Y=7BAB (Y)=(X) then X=X+1, Y=Y+1.
    TIN                                     ; (82) PRINT# X=988F, Y=7BAC
    TIN                                     ; (3A) PRINT# X=9890, Y=7BAD [JMP TXCOM]
    TIN                                     ; (BA) PRINT# X=9891, Y=7BAE
    TIN                                     ; (93) PRINT# X=9892, Y=7BAF
    TIN                                     ; (B1) PRINT# X=9893, Y=7BB0 [JMP SUB_9B31]
    POP	    Y                               ; Retrieve original pointer to program line
    BII	    A,$04                           ; PRINT# A=4
    BZS     BRANCH_9944                     ; PRINT# Z=0
    BII	    A,$10                           ;
    BZS     BRANCH_9943                     ; PRINT# Z=1

BRANCH_9939: ; branched to from 9940
    SJP	    SUB_9CFD                        ;
    BCR     BRANCH_9943                     ;
    CPI	    UH,$38                          ;
    BZS     BRANCH_9939                     ;
    SEC                                     ; Set Carry

BRANCH_9943: ; branched to from 9937, 993C
    RTN                                     ; PRINT# return

BRANCH_9944: ; branched to from 9933 
#IFDEF LPTIN
    SJP     RX_FLUSH                        ; Skips RXCOM flush if in KI,PN mode
#ELSE
    SJP	    RXCOM                           ; Reads COM port. Flush port
#ENDIF   
    REC                                     ; Reset Carry
    RTN                                     ;

;% TBL_98BD END


;-------------------------------------------------------------------------------------------------------------
; SUB_9949 - Called from 935B SUB_9350, 9148 SUB_90AE
; 
; Arguments:
; Output:
; RegMod:
;% TBL_9949 START
SUB_9949: 
    STX     U                               ; U = X
    VEJ     (F6)                            ; Transfers U to pp, pp+1 in OUT_BUF 
                AWRD(OUT_BUF + $15)         ;
    VEJ     (C8)                            ; Jump fwd (p) if following character doesn’t represent end to command sequence or line. 
                ABRF(BRANCH_9952)           ;
    BCH 	BRANCH_9980                     ;

BRANCH_9952: ; branched to from 994E
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not ',' branch fwd n
                ACHR(COMMA)                 ;
                ABRF(BRANCH_9957)           ;
    BCH 	BRANCH_997E                     ;

BRANCH_9957: ; branched to from 9952
    VEJ     (C6)                            ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
    VEJ     (DE)                            ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
                ABRF(BRANCH_9979)           ;
    VEJ     (D0)                            ; Convert AR-X to integer & load to U-Reg. p specifies the range. If range exceeded: Branch fwd n
                ABYT($83)                   ;
                ABRF(BRANCH_9979)           ;
    SJP	    LINESEARCH                      ; Search for line # from adddress in U-Reg; update program pointer. If not found, jump to Distance Address.
                ABRF(BRANCH_9973 )

BRANCH_9961: ; branched to from 9977
    VEJ 	(F4)                            ; Loads U-Reg with Address of linefound during search (H)
                AWRD(SRCH_ADD_H)
    DEC	    U                               ;
    DEC	    U                               ;
    DEC	    U                               ; The backs up three spots?
    VEJ     (F6)                            ; Transfers U to pp, pp+1
                AWRD(OUT_BUF + $15)         ;
    VEJ     (C8)                            ; Jump fwd (p) if following character doesn’t represent end to command sequence or line. 
                ABRF(BRANCH_997B)           ;
    VEJ     (F4)                            ; Loads U-Reg with 16-bit value from address of (pp)
                AWRD(OUT_BUF + $15)         ;
    INC	    U                               ;
    INC	    U                               ;
    BCH 	BRANCH_999E                     ;

BRANCH_9973:
    BCR     BRANCH_9979                     ;
    CPI	    UH,$0B                          ;
    BZS     BRANCH_9961                     ;

BRANCH_9979: ; branched to from 9958, 995A, 9973
    REC                                     ; Reset Carry
    RTN                                     ;


BRANCH_997B: ; branched to from 9958, 996A
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not ',' branch fwd n (branch borrows exit)
                ACHR(COMMA)                 ;
                ABRF(BRANCH_9A4C)           ;

BRANCH_997E: ; branched to from 9955
    VEJ     (C8)                            ; Jump fwd (p) if following character doesn’t represent end to command sequence or line. 
                ABRF(BRANCH_9985)

BRANCH_9980: ; branched to from 9950
    VEJ 	(F4)                            ; Loads U-Reg with End of Basic program in RAM (H)
                AWRD(BASPRG_END_H)
    
    BCH     BRANCH_99A1                     ;

BRANCH_9985: ; branched to from 997E
    VEJ     (C6)                            ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
    VEJ     (DE)                            ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
                ABRF(BRANCH_99EB)           ;
    VEJ     (D0)                            ; Convert AR-X to integer & load to U-Reg. p specifies the range. If range exceeded: Branch fwd n
                ABYT($83)                   ;
                ABRF(BRANCH_99EB)           ;
    PSH	    U                               ;
    VEJ 	(F4)                            ; Loads U-Reg with 16-bit value from address of (pp)
                AWRD(OUT_BUF + $15)         ;
    LDX	    U                               ; X = U
    POP	    U                               ;
    SJP	    SRCHPRGLINE                     ; Search for program line, jump if not found
                ABYT($4D)
    VEJ     (C8)                            ; Syntax check: Jump fwd (n1) if following character doesn’t represent end to command sequence or line. C=1 if ":"
                ABYT($53)                   ;
    VEJ     (F4)                            ; Address of linefound during search (H)
                AWRD(SRCH_ADD_H)            ;
    DEC	    U                               ;

BRANCH_999E: ; branched to from 9971
    LIN	    U                               ; A = (U) then INC U
    ADR	    U                               ; U = U + A + Carry

BRANCH_99A1: ; branched to from 9983
    VEJ     (F6)                            ; Transfers U to pp, pp+1
                AWRD(OUT_BUF + $19)         ;
    VEJ     (F4)                            ; Loads U-Reg with 16-bit value from address of (pp)
                AWRD(OUT_BUF + $15)         ;
    LDX	    U                               ; X = U
    VEJ 	(F4)                            ; Loads U-Reg with 16-bit value from address of (pp)
                AWRD(OUT_BUF + $19)         ;
    SEC                                     ; Set Carry
    LDA	    (BASPRG_END_L)                  ; End of Basic program in RAM (L)
    SBC	    UL                              ; A = A - UL. Subtract with Carry
    LDA	    (BASPRG_END_H)                  ; End of Basic program in RAM (H)
    SBC	    UH                              ; A = A - UH. Subtract with Carry
    BCR     BRANCH_99E1                     ;
    LDA	    UH                              ;
    CPA	    (RAM_END_H)                     ; End of RAM pointer (H)
    BCS     BRANCH_99E1                     ;
    SJP	    (U_MINUS_X - 1)                 ; DEC U then U-Reg = U-Reg - X-Reg (with overflow C=1)
    VEJ     (F6)                            ; Transfers U to pp, pp+1
                AWRD(OUT_BUF + $17)         ;
    VEJ     (F4)                            ; Loads U-Reg with 16-bit value from address of (pp)
                AWRD(OUT_BUF + $15)         ;
    CPA	    (BASPRG_ST_H)                   ; Compare A and Start of Basic program in RAM (H)
    BCR     BRANCH_99D0                     ;
    CPA	    (RAM_ST_H)                      ; Compare A and Start of RAM pointer
    BCS     BRANCH_99E0                     ;

BRANCH_99D0: ; branched to from 99C9
    VEJ     (CC)                            ; Loads X-Reg with address at 78(pp) 78(pp+1) 7860 - Start of ROM in module
                ABYT($60)                   ;
    LDI	    UH,$1F                          ;
    LDI	    XL,$00                          ;
    LDA	    (X)                             ;
    CPI	    A,$55                           ;
    REC                                     ; Reset Carry
    BZR     BRANCH_99E0                     ;
    LDI	    XL,$07                          ;
    LDA	    (X)                             ;
    SHL                                     ;

BRANCH_99E0: ; branched to from 99CE
    RTN                                     ;


BRANCH_99E1: ; branched to from 99B5, 99BB
    LDI	    UH,$1F                          ;
    REC                                     ; Reset Carry
    RTN                                     ;

;99E5 ***
    ;BCR     BRANCH_99EB                     ; These three line bogus?
    ;CPI	 UH,0B                           ; These three line bogus?
    ;BZS     9998                            ; These three line bogus?
    .BYTE $81,$04,$6C,$0B,$9B,$53 

BRANCH_99EB: ; branched to from 9986, 9988, 99E5
    REC                                     ; Reset Carry
    RTN                                     ;

;% TBL_9949 END


;------------------------------------------------------------------------------------------------------------
; SUB_99ED, 99EF - Called from 
; 
; Arguments:
; Output:
; RegMod:
;% SUB_99EF START
    BCH 	BRANCH_9A4C                     ; is this reached

SUB_99EF: ; called from 914D SUB_90AE
    BHR     BRANCH_9A1A                     ;
    VEJ     (DE)                            ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
                    ABRF(BRANCH_9A4E)       ;
    VEJ     (D0)                            ; Convert AR-X to integer & load to U-Reg. p specifies the range. If range exceeded: Branch fwd n
                    ABYT($00)               ;
                    ABRF(BRANCH_9A4E)       ;
    VEJ     (F6)                            ; Transfers U to pp, pp+1
                    AWRD(OUT_BUF + $15)     ;
    VEJ   	(C2)                            ; If next character is not ''', branch fwd 'n'. If 'p' is Fn then 3 args, if not 2 args
                    ACHR(COMMA)             ;
                    ABRF(BRANCH_9A4C)       ;
    VEJ     (DE)                            ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
                    ABRF(BRANCH_9A4E)
    VEJ     (D0)                            ; Convert AR-X to integer & load to U-Reg. p specifies the range. If range exceeded: Branch fwd n
                    ABYT($01)               ;
                    ABRF(BRANCH_9A4E)       ;
    LDA	    (OUT_BUF + $15)                 ;
    STA	    XH                              ;
    LDA	    (OUT_BUF + $16)                 ;
    STA	    XL                              ;
    SJP	    U_MINUS_X                       ; U-Reg= U-Reg - X-Reg (with overflow C=1)
    BCR     BRANCH_9A4F                     ;
    VEJ     (F6)                            ; Transfers U to pp, pp+1
                AWRD(OUT_BUF + $17)         ;
    VEJ     (C8)                            ; Jump fwd (p) if following character doesn’t represent end to command sequence or line. 
                ABRF(BRANCH_9A1E)           ;

BRANCH_9A13: ; branched to from 9A1C
    LDI	    UH,$FF                          ;
    LDI	    UL,$FF                          ;
    DEC	    Y                               ;
    BCH 	BRANCH_9A28                     ;


BRANCH_9A1A: ; branched to from 99EF
    VEJ     (C8)                            ; Jump fwd (p) if following character doesn’t represent end to command sequence or line. 
                ABRF(BRANCH_9A22)           ;
    BCH 	BRANCH_9A13                     ;


BRANCH_9A1E: ; branched to from 9A11
    VEJ     (C4)                            ; Check tokens/char in U-Reg if not ',' branch fwd n
                ACHR(COMMA)                 ;
                ABRF(BRANCH_9A4C)           ;
    VEJ     (C0)                            ; Load next character/token to U-Reg

BRANCH_9A22: ; branched to from 9A1A
    VEJ     (C6)                            ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
    VEJ     (DE)                            ; Calculates formula to which Y-Reg points and passes result to AR-X. Jump FWD (n) if error
                ABRF(BRANCH_9A4E)           ;
    VEJ     (D0)                            ; Convert AR-X to integer & load to U-Reg. p specifies the range. If range exceeded: Branch fwd n
                ABYT($00)                   ;
                ABRF(BRANCH_9A4E)           ;

BRANCH_9A28: ; branched to from 9A18
    VEJ     (F6)                            ; Transfers U to pp, pp+1
                AWRD(OUT_BUF + $19)         ;
    BCH     BRANCH_9A48                     ;

;% SUB_99EF END


;------------------------------------------------------------------------------------------------------------
; SUB_9A32 - Called from 9130
; 
; Arguments:
; Output:
; RegMod:
;% SUB_9A2D START 
SUB_9A2D:
    SJP	    MEM_IN_UREG                     ; Calculates the available memory space (MEM) in U-Reg.
    BCH 	BRANCH_9A3B                     ;


SUB_9A32: ; called from 9124
    LDI	    UL,$BB                          ;
    LDI	    UH,$00                          ; U = 00BB
    BCH 	BRANCH_9A3D                     ;

SUB_9A38: ; called from 9139
    SJP	    (ARX2STRBUF + $15)              ; Inside: Save String buffer pointers to X-Reg and AR-X. Updating pointer with YL

BRANCH_9A3B: ; branched to from 9A30
    BCR     BRANCH_9A4F                     ;

BRANCH_9A3D: ; branched to from 9A36
    LDA	    XH                              ;
    STA	    (OUT_BUF + $15)                 ;
    LDA	    XL                              ;
    STA	    (OUT_BUF + $16)                 ;
    VEJ	    (F6)                            ; Transfers U to pp, pp+1
                AWRD(OUT_BUF + $17)         ;
    
BRANCH_9A48:    
    VEJ     (C8)                            ; Jump fwd (p) if following character doesn’t represent end to command sequence or line. 
                ABRF(BRANCH_9A4C)           ;

BRANCH_9A4A: ; branched to from 9A81
    SEC                                     ; Set Carry
    RTN                                     ;


BRANCH_9A4C: ; branched to from 9A48, 997B
    LDI	    UH,$01                          ;
   
BRANCH_9A4E:   
    REC                                     ; Reset carry

BRANCH_9A4F: ; branched to 9A3B
    RTN                                     ;

;% SUB_9A2D END


;------------------------------------------------------------------------------------------------------------
; SUB_9A50 - Called from 9419
; 
; Arguments:
; Output:
; RegMod:
;% SUB_9A50 START 
SUB_9A50:
    LDI	    A,$00                           ;

BRANCH_9A52: ; branched to from 9A5F
    STA	    UL                              ;
    SEC                                     ;
    SBC	    (OUT_BUF + $47)                 ;
    BCS     BRANCH_9A6C                     ;
    LDA	    (ZONE_REG)                      ; 
    ANI	    A,$1F                           ;
    ADC	    UL                              ;
    BCR     BRANCH_9A52                     ;
    SBC	    (OUT_BUF + $47)                 ;
    STA	    UL                              ;
    LDA	    (OUT_BUF + $46)                 ;
    BZR     BRANCH_9A75                     ;
    BCH     BRANCH_9A90                     ;

BRANCH_9A6C: ; branched to from 9A57
    STA	    UL                              ;
    LDA	    (OUT_BUF + $46)                 ;
    BZS     BRANCH_9A90                     ;
    CPA	    UL                              ;
    BCS     BRANCH_9A90                     ;

BRANCH_9A75: ; branched to from 9A68
    JMP	    SUB_9B41                        ;

;% SUB_9A50 END


;------------------------------------------------------------------------------------------------------------
; SUB_9A78 - Called from 9419
; 
; Arguments:
; Output:
; RegMod:
;% SUB_9A78 START
SUB_9A78:
    SEC                                     ;
    LDI	    UH,$35                          ;
    LDA	    (OUT_BUF + $46)                 ;
    BZS     BRANCH_9A83                     ;
    SBC	    UL                              ; A = A - UL
    BCR     BRANCH_9A4A                     ;

BRANCH_9A83: ; branched to from 9A7E
    LDA	    UL                              ;
    SBC	    (OUT_BUF + $47)                 ;  
    BCS     BRANCH_9A8F                     ;
    SJP	    SUB_9B41                        ; No idea, seems to manipualte OUT_BUF
    BCS     BRANCH_9A9C                     ;
    LDA	    UL                              ;

BRANCH_9A8F: ; branched to from 9A87, 9AA3
    STA	    UL                              ;

BRANCH_9A90: ; branched to from 9A6A, 9A70, 9A73
    DEC	    UL                              ;
    BCR     BRANCH_9A9C                     ;

BRANCH_9A93: ; branched to from 9A93
    LDI	    A,$20                           ;
    SJP	    SUB_9B32                        ; No idea, seems to manipualte OUT_BUF
    BCS     BRANCH_9A9C                     ;
    LOP	    UL,BRANCH_9A93                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set

BRANCH_9A9C: ; branched to from9A8C, 9A91, 9A98, 9AA0
    RTN                                     ;


BRANCH_9A9D:
    SJP	    SUB_9ACF                        ; Copies some stuff in OUT_BUF
    BCS     BRANCH_9A9C                     ;   
    LDA	    UH                              ;
    BCH 	BRANCH_9A8F                     ;

;% SUB_9A78 END


;------------------------------------------------------------------------------------------------------------
; SUB_9AA5 - Called from 92D4, 9739, 9CF1, 9D76, 9AC1
; 
; Arguments:
; Output:
; RegMod:
;% SUB_9AA5 START
SUB_9AA5:
    LDI	    UH,$00                          ;

BRANCH_9AA7: ; Jmped to from 9177
    SJP	    SUB_9BE1                        ; Manipulates OUT_BUF

BRANCH_9AAA: ; branched to from 9AC9
    BCS     SUB_9AC1                        ; Checks and manipulates OUT_BUF
    SJP	    SUB_9ACF                        ; KI, calls RXCOM polling routine
    SJP	    SUB_9AE6                        ; More manipulation of 
    BCS     SUB_9AC1                        ; Checks and manipulates OUT_BUF
    LDA	    (OUT_BUF + $39)                 ;
    STA	    UL                              ;
    LDA	    (OUT_BUF + $38)                 ;
    STA	    UH                              ;
    DEC	    UH                              ;
    BCS     BRANCH_9AA7                     ;

BRANCH_9AC0: ; branched to from
    RTN                                     ;

;% SUB_9AA5 END


;------------------------------------------------------------------------------------------------------------
; SUB_9AC1 - Called from 9AAA 9AB2
; 
; Arguments:
; Output:
; RegMod:
;% SUB_9AC1 START
SUB_9AC1:
    SJP     SUB_9B5E                        ; Checks if ((OUT_BUF + $41) < 1) == 3C, 34, 40, 3A
    BCS     BRANCH_9AC0                     ; If no match, borrow a return
    SJP     SUB_9C32                        ; Pulls some values out of OUT_BUF and saves to XH, XL, UH, UL, A
    BCH 	BRANCH_9AAA                     ; Jumps back to line after caller

;% SUB_9AC1 END


;------------------------------------------------------------------------------------------------------------
; SUB_9ACB - Called from 9AAC
; Copies some stuff in OUT_BUF
; Arguments:
; Output:
; RegMod:
;% SUB_9ACB START
BRANCH_9ACB: ; branched to from 9AE2
    LDI	    XL,$B0                          ;
    LDI	    UL,$4F                          ;

SUB_9ACF: ; Called from 91B8, 95B6, 95C9, 95E1, 9A9D, 9AAC   branched to from 9AD4
    SJP     (OUT_BUF + $4D)                 ; $7BAD. Called for each char rxd except CR. Calls 9B1C, checks of /CE (&0D)
    BCS     BRANCH_9AE5                     ;
    LOP     UL,SUB_9ACF                     ; UL = UL - 1, loop back 'e' if Borrow Flag not set
    BII	    (OUT_BUF + $41),$20             ;
    BZR     BRANCH_9AE5                     ;
    CPI	    XH,HB(OUT_BUF)                  ;
    BZR     BRANCH_9AE4                     ;
    CPI	    XL,LB(OUT_BUF)                  ; X = 7B60
    BZS     BRANCH_9ACB                     ;

BRANCH_9AE4: ; branched to from 9ADE
    REC                                     ; Reset Carry

BRANCH_9AE5: ; branched to from 9AD2, 9ADA
    RTN                                     ;

;% SUB_9ACB END


;------------------------------------------------------------------------------------------------------------
; SUB_9AE6 - 
; 
; Arguments:
; Output:
; RegMod:
;% SUB_9AE6 START
SUB_9AE6:
    BII	    (OUT_BUF + $41),$80             ;
    BZS     BRANCH_9B10                     ;
    BCR     BRANCH_9AF8                     ;
    CPI	    UH,$3F                          ;
    BZS     BRANCH_9B08                     ;
    CPI	    UH,$3E                          ;
    BZS     BRANCH_9B03                     ;

BRANCH_9AF6: ; called from 9B14
    SEC                                     ;

BRANCH_9AF7: ; called from 9B01, 9B06, 9B0B, 9B10
    RTN                                     ;


BRANCH_9AF8: ; called from 9AEC
    BII	    (OUT_BUF + $41),$20             ;
    BZS     BRANCH_9B03                     ;
    SJP	    SUB_9BC1                        ; Manipulates OUT_BUF
    BCH 	BRANCH_9AF7                     ;

BRANCH_9B03: ; called from 9AF4, 9AFC
    SJP	    SUB_9E54                        ; No idea
    BCS     BRANCH_9AF7                     ;

BRANCH_9B08: ; called from 9AF0
    SJP	    SUB_9C94                        ; No idea
    BCS     BRANCH_9AF7                     ;
    JMP	    SUB_9C48                        ;

BRANCH_9B10: 
    BCR     BRANCH_9AF7                     ;
    CPI	    UH,$3E                          ;
    BZR     BRANCH_9AF6                     ;
    ANI	    (OUT_BUF + $38),$00             ;
    REC                                     ;
    RTN                                     ;

;% SUB_9AE6 END


;------------------------------------------------------------------------------------------------------------
; SUB_9B1C - Called from 988A, 98A2
; 
; Arguments:
; Output:
; RegMod:
; 
; CLOAD: BA 82 8E                           BA 9B 1C F0 89 -> 
; 7BAA   JMP $828E -> Branch to MAIN_ENTRY: JMP $9B1C 
;
; All CLOAD operations go through here after the first three bytes.
; The CPI A,$0D seems to look for EOL marker, perhaps to know when to tokenize an ASCII load?
;% SUB_9B1C START 
SUB_9B1C:                                   
#IFNDEF ENBPD
    SJP	    (OUT_BUF + $4A)                 ; $7BAA in OUT_BUF JMP 828F to RXCOM, returns here after char RXd
#ELSE
    SJP	    (BUSY_BLINK)                    ; Does BUSY annuciator blink then above line
#ENDIF
    
    BCS     BRANCH_9B2F                     ; Error exit?
    CPI	    A,$0D                           ; Detects EOL for CLOAD, INPUT#
                                            ; RXLPT can load the whole ASCII value into IN_BUF and then return $0D
                                            ; What is pointing to next spot in IN_BUF?
    REC                                     ;
    BZR     BRANCH_9B2F                     ;

    BII	    (OUT_BUF + $41),$04             ; Drops through here for EOL could blink here?
    BZS     BRANCH_9B2F                     ;
    SEC                                     ;
    LDI	    UH,$3E                          ;

BRANCH_9B2F: ; called from 9B1F, 9B24, 9B2A
    SIN     X                               ; Stores value in A from RXCOM into IN_BUF, INC pointer
    RTN                                     ;

;% SUB_9B1C END


;------------------------------------------------------------------------------------------------------------
; SUB_9B31 - 9890, 9896, 989C, 98A8, 98B4
; 
; Arguments:
; Output:
; RegMod:
;
; All CSAVE variations go through here. The (OUT_BUF + $4A) calls TXCOM from RAM (I think).
;% SUB_9B31 START 
SUB_9B31:
    LIN	    X                               ; A = (X), X = X + 1

SUB_9B32: ; called from 9A95
#IFNDEF ENBPD
    SJP     (OUT_BUF + $4A)                 ; $7BAA in OUT_BUF which is manipualted everywhere!
#ELSE
    SJP     (BUSY_BLINK)                    ; Jumps to BUSY annunciator blink routine
#ENDIF
    
    BCS     BRANCH_9B57                     ; ***
    LDA	    (OUT_BUF + $46)                 ;
    BZS     BRANCH_9B58                     ;
    SBC	    (OUT_BUF + $47)                 ; A = A - (pp)
    BCS     BRANCH_9B58                     ;

SUB_9B41: ; called from  9209, 9239         ; Sends trailing /LF for LPT?
    LDA	    (OUT_BUF + $49)                 ;
    SJP     (OUT_BUF + $4A)                 ; Great, this is calling a sub poked into OUT_BUF which is manipualted everywhere!
    BCS     BRANCH_9B57                     ;
    LDA	    (OUT_BUF + $48)                 ;
    BZS     BRANCH_9B53                     ;
    SJP     (OUT_BUF + $4A)                 ; Great, this is calling a sub poked into OUT_BUF which is manipualted everywhere!
    BCS     BRANCH_9B57                     ;

BRANCH_9B53: ; branched to from 9B4C
    ANI	    (OUT_BUF + $47),$00             ;

BRANCH_9B57: ; branched to from 9B35, 9B47, 9B51
    RTN                                     ;


BRANCH_9B58: ; branched to from 9B3A, 9B3F
    ADI	    (OUT_BUF + $47),$01             ;

BRANCH_9B5C: ; branched to from 9B66, 9B6A, 9B72
    REC                                     ; Rest Carry
    RTN                                     ; 

;% SUB_9B31 END


;------------------------------------------------------------------------------------------------------------
; SUB_9B5E - 
; If (OUT_BUF  + 41) * 2 does not overflow then comapre UH to multiple values
; Arguments:
; Output: SEC if (OUT_BUF  + 41) * 2 does not overflow or no match
;         REC if UH == 3C, 34, 40, 3A
; RegMod:
;% SUB_9B5E START
SUB_9B5E: ; Called from 
    LDA	    (OUT_BUF + $41)                 ;
    SHL                                     ; (OUT_BUF  + 41) * 2
    BCR     BRANCH_9B74                     ;
    CPI	    UH,$3C                          ; < 
    BZS     BRANCH_9B5C                     ; Borrows return
    CPI	    UH,$34                          ; 4
    BZS     BRANCH_9B5C                     ; Borrows return
    CPI	    UH,$40                          ; &
    BZS     BRANCH_9B5C                     ; Borrows return
    CPI	    UH,$3A                          ; :
    BZS     BRANCH_9B5C                     ; Borrows return

BRANCH_9B74: ; branched to from 9B62
    SEC                                     ; Set Carry
    RTN                                     ;

;% SUB_9B5E END


;------------------------------------------------------------------------------------------------------------
; SUB_9B76 - Called from 
; 
; Arguments:
; Output:
; RegMod:
;% SUB_9B76 START
SUB_9B76:
    LDA	    (OUT_BUF + $41)                 ;
    LDI	    UH,$7F                          ;
    CPI	    A,$24                           ;
    BZS     BRANCH_9B87                     ;
    LDI	    UH,$3F                          ;
    CPI	    A,$A4                           ;
    BZS     BRANCH_9B87                     ;
    REC                                     ; Reset Carry
    RTN                                     ;

BRANCH_9B87: ; called from 9B7D, 9B83
    LDA	    UH                              ;
    BCH 	DELAY_A_MS                      ; Time delay of A * 15.625ms

;% SUB_9B76 END


;------------------------------------------------------------------------------------------------------------
; DELAY500MS - Time delay of 500ms, default. 
; DELAY_A_MS - Time delay of A * 15.625ms
; 
; Arguments: A
; Output:
; RegMod: A, UH
;% DELAY500MS START
DELAY500MS: ; called from 9D38, 
    LDI	    A,$32                           ;

;% DELAY_A_MS START
DELAY_A_MS: ; called from 9515, 95D6, 95EE
    LDI	    UH,$00                          ;
    PSH	    U                               ;
    STA	    UL                              ;
    SJP     TIMEDELAY                       ; Time delay by 15.625 ms* U-Reg 32*15.625ms=500ms
    POP	    U                               ;
    LDI	    UH,$00                          ;
    RTN                                     ;

;% DELAY_A_MS END


;------------------------------------------------------------------------------------------------------------
; SUB_9B99 - Seems to work like end of line detection for PRINT#
; 
; Arguments: A
; Output:
; RegMod: A, UH
;% SUB_9B99 START
SUB_9B99: ; Jumped to from 9E1A
    VEJ	    (C2)                            ; If next character is not ';', branch fwd 'n'.
                ACHR(SEMI)                  ;
                ABRF(BRANCH_9B9D)           ; 
    RTN                                     ; 

BRANCH_9B9D: ; branched to from 9B99
    VEJ     (C6)                            ; Decrements Y-Reg by 2- for tokens in U-Reg/ 1 byte for characters in U-Reg
    SEC                                     ; Set Carry
    LDA	    (OUT_BUF + $05)                 ;
    BZS     BRANCH_9BA9                     ;
    VEJ	    (C4)                            ; Check tokens/char in U-Reg if not CR branch fwd n
                ABYT($0D)                   ;
                ABRF(BRANCH_9BA8)           ;
    RTN                                     ;


BRANCH_9BA8: ; branched to from 9BA4
    REC                                     ; Reset Carry

BRANCH_9BA9: ; branched to from 9BA2
    RTN                                     ;

;% SUB_9B99  END


;------------------------------------------------------------------------------------------------------------
; SUB_9BAA - Called from 
; Checks some things in OUTPUT BUFFER, pokes values in CE-158 registers
; Arguments:
; Output:
; RegMod:
;% SUB_9BAA START
SUB_9BAA:
    BII	    (OUT_BUF + $41),$40             ;
    BZS     BRANCH_9BC0                     ;
    LDA	    (OUT_BUF + $47)                 ;
    BII	    (OUT_BUF + $3E),$04             ;
    BZR     BRANCH_9BBD                     ;   
    STA	    (CE158_UNDEF1)                  ; UnkNown CE-158 register
    RTN                                     ;


BRANCH_9BBD: ; branched to from 9BB7
    STA	    (CE158_UNDEF2)                  ; Unkown CE-158 register

BRANCH_9BC0: ; branched to from 9BAE, 9BCC, 9BD7
    RTN                                     ;

;% SUB_9BAA END


;------------------------------------------------------------------------------------------------------------
; SUB_9BC1 - Called from 9AFE, 947A, 946D, 920E
; Manipulates OUT_BUF
; Arguments:
; Output:
; RegMod:
;% SUB_9BC1 START
SUB_9BC1:
    BII	    (OUT_BUF + $41),$80             ;
    BZS     BRANCH_9BA8                     ;
    LDI	    A,$03                           ;
    SJP     BRANCH_9C5C                     ;
    BCS     BRANCH_9BC0                     ; Borrows return
    SJP     RXCOM                           ; Manipulates LPT/UART registers
    LDA	    (OUT_BUF + $42)                 ;
    SJP     BRANCH_9C57                     ; no idea
    BCS     BRANCH_9BC0                     ; Borrows return
    SEC                                     ; Set Carry
    LDI	    A,$F2                           ;
    JMP	    SUB_9CFD                        ; no idea

;% SUB_9BC1 END


;------------------------------------------------------------------------------------------------------------
; SUB_9BDF - called from 93E5, 9371
; SUB_9BE1 - called from 9AA7, 9587, 9184
; Manipulates OUT_BUF
; Arguments:
; Output:
; RegMod:
;% SUB_9BDF START
SUB_9BDF:
    LDX     Y                               ; X = Y              

;% SUB_9BE1 START
SUB_9BE1: ; Jumped to from 9184
    ANI	    (OUT_BUF + $45),$7F             ;
    LDI	    A,$FD                           ;
    STA	    (OUT_BUF + $44)                 ;
    LDA	    XL                              ;
    STA	    (OUT_BUF + $37)                 ;
    LDA	    XH                              ;
    STA	    (OUT_BUF + $36)                 ;
    LDA	    UL                              ;
    STA	    (OUT_BUF + $39)                 ;
    LDA	    UH                              ;
    STA	    (OUT_BUF + $38)                 ;

BRANCH_9BFA: ; branched to from 9C46
    BZS     BRANCH_9BFE                     ;
    LDI	    UL,$FF                          ;

BRANCH_9BFE: ; branched to from 9BFA
    LDA	    (OUT_BUF + $41)                 ;
    SHL                                     ;
    BCR     BRANCH_9C31                     ;
    ANI	    (OUT_BUF + $42),$00             ;
    SHL                                     ;
    LDA	    (OUT_BUF + $45)                 ;
    ANI	    (OUT_BUF + $45),$00             ;
    BVS     BRANCH_9C4C                     ;
    SHL                                     ;
    BCR     BRANCH_9C1A                     ;
    LDI	    A,$3D                           ;
    SJP     BRANCH_9C31                     ;

BRANCH_9C1A: ; branched to from 9C13
    SJP     SUB_9C94                        ; No idea
    BCS     BRANCH_9C31                     ;
    CPI	    A,$02                           ;
    REC                                     ; Reset Carry
    BZS     BRANCH_9C31                     ;
    CPI	    A,$2D                           ;
    BZS     SUB_9C48                        ; no idea
    LDI	    UH,$42                          ;
    CPI	    A,$37                           ;
    BZS     BRANCH_9C31                     ;
    SEC                                     ; Set Carry
    LDI	    UH,$3A                          ;

BRANCH_9C31: ; branched to from 9C4E, 9C53, 9C02, 9C17, 9C1D, 9C22, 9C2C
    RTN                                     ;

;% SUB_9BDF END


;------------------------------------------------------------------------------------------------------------
; SUB_9C32 - called from 9AC6
; Pulls some values out of OUT_BUF and saves to XH, XL, UH, UL, A
; Arguments:
; Output:
; RegMod:
;% SUB_9C32 START
SUB_9C32: 
    ORI	    (OUT_BUF + $45),$80             ;
    LDA	    (OUT_BUF + $37)                 ;
    STA	    XL                              ;
    LDA	    (OUT_BUF + $36)                 ;
    STA	    XH                              ;    
    LDA	    (OUT_BUF + $39)                 ;
    STA	    UL                              ;
    LDA	    (OUT_BUF + $38)                 ;
    STA	    UH                              ;
    BCH     BRANCH_9BFA                     ;

;% SUB_9C32 END


;--------- ---------------------------------------------------------------------------------------------------
; SUB_9C48 - Called from    branched to from 9CEA
; 
; Arguments:
; Output:
; RegMod:
;% SUB_9C48 START
SUB_9C48:
    LDI	    A,$70                           ;
    BCH 	BRANCH_9C57                     ;


BRANCH_9C4C: ; branched to from 9C10
    BII	    A,$C0                           ;
    BZS     BRANCH_9C31                     ; Borrowing Return
    SJP     SUB_9CFD                        ; no idea
    BCS     BRANCH_9C31                     ;
    LDI	    A,$02                           ; Borrowing Return

BRANCH_9C57: ; branched to from 9C4A, 9BD4
    PSH	    U                               ;
    STA	    UL                              ;
    BCH 	BRANCH_9C72                     ;


BRANCH_9C5C: ; branched to from 9BC9
    PSH	    U                               ;
    BCH 	BRANCH_9C69                     ;


JMP_9C60: ; branched to from TBL_9887->9895
    PSH	    U                               ;
    STA	    UL                              ;
    CPI	    A,$40                           ;
    BCS     BRANCH_9C69                     ;
    ADI	    A,$40                           ;

BRANCH_9C69: ; branched to from 9C5E, 9C65
    STA     UH                              ; X = U
    SJP     BRANCH_9C89                     ;
    LDA	    UH                              ;
    CPI	    A,$40                           ;
    BCR     BRANCH_9C84                     ;

BRANCH_9C72: ; branched to from 9C5A
    LDA	    UL                              ;
    CPI	    A,$40                           ;
    BCS     BRANCH_9C84                     ;
    LDI	    A,$10                           ;
    SJP     TXCOM                           ; Sends charecter in A to RS232 Port.
    BCR     BRANCH_9C81                     ;
    POP	    X                               ;
    RTN                                     ;


BRANCH_9C81: ; branched to from 9C7C
    LDA	    UL                              ;
    ADI	    A,$40                           ;

BRANCH_9C84: ; branched to from 9C70, 9C75
    POP	    U                               ;   
    JMP	    TXCOM                           ; Sends charecter in A to RS232 Port.


BRANCH_9C89: ; branched to from 9C6A, called from 9CBA, 9CD9
    LDA	    (OUT_BUF + $42)                 ;
    SHL                                     ;
    ADC	    UH                              ;
    ADI	    A,$00                           ;
    STA	    (OUT_BUF + $42)                 ;
    RTN                                     ;

;% SUB_9C48 END


;------------------------------------------------------------------------------------------------------------
; SUB_9C94 - Called from
; 
; Arguments:
; Output:
; RegMod:
;% SUB_9C94 START
SUB_9C94:
    LDA	    UL                              ;
    LDI	    UL,$00                          ;
    BCH     BRANCH_9C9C                     ;

JMP_9C99: ; jumped to from 989F
    LDA	    UL                              ;
    LDI	    UL,$02                          ;

BRANCH_9C9C: ; branched to from 9C97
    PSH	    A                               ;
    SJP     BRANCH_828E                     ; Sends data to LPT output
    BCS     BRANCH_9CC1                     ;
    STA	    UH                              ;
    CPI	    A,$40                           ;
    BCS     BRANCH_9CB6                     ;
    CPI	    A,$10                           ;
    BZR     BRANCH_9CC6                     ;
    SJP     BRANCH_828E                     ; Sends data to LPT output
    BCS     BRANCH_9CC1                     ;
    STA	    UH                              ;
    SBI	    A,$3F                           ; A = A - N
    BCR     BRANCH_9CCD                     ;

BRANCH_9CB6: ; branched to from 9CA6
    DEC	    UL                              ;
    BCR     BRANCH_9CE1                     ;
    STA	    UL                              ;
    SJP     BRANCH_9C89                     ;
    LDA	    (OUT_BUF + $42)                 ;
    STA	    UH                              ;

BRANCH_9CC1: ; branched to from 9CA1, 9CAF, 9CD1, 9CD6, 9CDF
    POP	    A                               ;
    STA	    UL                              ;
    LDA	    UH                              ;
    RTN                                     ;


BRANCH_9CC6: ; branched to from 9CAA
    DEC	    UL                              ;
    BCR     BRANCH_9CCD                     ;
    CPI	    A,$03                           ;
    BZS     BRANCH_9CD8                     ;

BRANCH_9CCD: ; branched to from 9CB4, 9CC7
    LDI	    UH,$3B                          ;
    CPI	    A,$37                           ;
    BZS     BRANCH_9CC1                     ;
    LDI	    UH,$3A                          ;

BRANCH_9CD5: ; branched to from 9CE5
    SEC                                     ; Set Carry
    BCH     BRANCH_9CC1                     ;


BRANCH_9CD8: ; branched to from 9CCB
    STA	    UH                              ;
    SJP     BRANCH_9C89                     ;
    LDI	    UH,$3F                          ;
    SEC                                     ; Set Carry
    BCH     BRANCH_9CC1                     ;


BRANCH_9CE1: ; branched to from 9CB7
    LDI	    UH,$3C                          ;
    CPI	    A,$A2                           ;
    BZR     BRANCH_9CD5                     ;
    POP	    A                               ;
    STA	    UL                              ;
    BCH     SUB_9C48                        ; no idea

SUB_9CEC: ; Jumped to from 9166
    LDI	    XL,LB(OUT_BUF)                  ;
    LDI	    XH,HB(OUT_BUF)                  ; X = 7B60 = OUT_BUF
    LDI	    UL,$1A                          ;
    BII	    (OUT_BUF + $41),$80             ;
    BZS     BRANCH_9CFA                     ; Exit
    INC	    X                               ;
    DEC	    UL                              ;

BRANCH_9CFA:
    JMP	    SUB_9AA5                        ; No idea

;% SUB_9C94 END


;------------------------------------------------------------------------------------------------------------
; SUB_9CFD - Called from
; 
; Arguments:
; Output:
; RegMod:
;% SUB_9CFD START
SUB_9CFD:
    CALL	RXCOM                           ; Manipulates LPT/UART registers
    SEC                                     ; Set Carry
    ORI	    (OUT_BUF + $45),$40             ;
    LDI	    A,$F2                           ;
    ANI	    (OUT_BUF + $45),$DF             ;
    STA	    (OUT_BUF + $43)                 ;
    LDI	    UH,$00                          ;
    BCS     BRANCH_9D2B                     ;

BRANCH_9D12: ; branched to from 9D26
    LDI	    A,$2D                           ;
    SJP	    CHAR2COM                        ; Sends charecter in A to RS232 Port
    BCR     BRANCH_9D2A                     ;
    BII     A,$20                           ;
    BZR     BRANCH_9D2A                     ;

BRANCH_9D1D: ; branched to from 9D54
    SJP	    DELAY500MS                      ; 500ms delay
    BCS     BRANCH_9D2A                     ;
    ADI	    (OUT_BUF + $43),$01             ;
    BCR     BRANCH_9D12                     ;

BRANCH_9D28: ; branched to from 9D41
    LDI	    UH,$38                          ;

BRANCH_9D2A: ; branched to from 9D17, 9D1B, 9D20, 9D32
    RTN                                     ;


BRANCH_9D2B: ; branched to from 9D10, 9D43, 9D5C
    SJP	    RXCOM                           ; Manipulates LPT/UART registers
    BCR     BRANCH_9D45                     ;
    BII     A,$40                           ;
    BZR     BRANCH_9D2A                     ;
    BII     A,$1C                           ;
    BZR     BRANCH_9D50                     ;
    SJP	    DELAY500MS                      ; 500ms delay
    BCS     BRANCH_9D64                     ;
    ADI	    (OUT_BUF + $43),$01             ;
    BCS     BRANCH_9D28                     ;
    BCH     BRANCH_9D2B                     ;


BRANCH_9D45: ; branched to from 9D2E
    BII	    (OUT_BUF + $45),$20             ;
    BZS     BRANCH_9D56                     ;
    CPI	    A,$70                           ;
    REC                                     ; Reset Carry
    BZS     BRANCH_9D64                     ;

BRANCH_9D50: ; branched to from 9D36, 9D60
    ANI	    (OUT_BUF + $45),$DF             ;
    BCH     BRANCH_9D1D                     ;


BRANCH_9D56: ; branched to from 9D49
    ORI	    (OUT_BUF + $45),$20             ;
    CPI	    A,$10                           ;
    BZS     BRANCH_9D2B                     ;
    CPI	    A,$3D                           ;
    BZR     BRANCH_9D50                     ;
    LDI	    UH,$39                          ;

BRANCH_9D64: ; branched to from 9D3B, 9D4E
    RET                                     ;

;% SUB_9CFD END


;------------------------------------------------------------------------------------------------------------
; SUB9D65 - Called from 9256
; 
; Arguments:
; Output:
; RegMod:
;% SUB_9D65 START
SUB_9D65:                                   ; We wind up here are RX one byte on CLOAD
    SJP	    RXCOM                           ; Manipulates LPT/UART registers
    LDI	    XL,$7B                          ;
    LDI	    UL,$1A                          ;
    BII	    (OUT_BUF  + $41),$80            ;
    BZS     BRANCH_9D74                     ;
    INC	    XL                              ;
    DEC	    UL                              ;

BRANCH_9D74: ; branched to from 9D70
    LDI	    XH,$7B                          ;
    SJP	    SUB_9AA5                        ; No idea
    BCS     BRANCH_9DF0                     ;
    LDI	    XL,LB(OUT_BUF)                  ; X = 7B60 = OUT_BUF
    LDI	    UL,$04                          ;
    PSH	    Y                               ;
    LDA	    (OUT_BUF + $41)                 ;
    SHL                                     ;
    LDI	    YL,$7B                          ;
    BCR     BRANCH_9D8C                     ;
    INC	    XL                              ;
    INC	    YL                              ;
    DEC	    UL                              ;

BRANCH_9D8C: ; branched to from 9D87
    LDI	    XH,$7B                          ;
    LDI	    YH,$7B                          ;
    LDI	    UH,$3D                          ;

BRANCH_9D92: ; branched to from 9D96
    LIN	    Y                               ; A = (Y) then INC Y
    CIN                                     ; FLAGS = A compared to (X) register, then INC X.
    BZR     BRANCH_9DED                     ;
    LOP	    UL,BRANCH_9D92                  ;
    LDA	    (X)                             ;
    BZS     BRANCH_9DA3                     ;
    LDI	    UL,$0F                          ;

BRANCH_9D9D: ; branched to from 9DA1
    LIN	    Y                               ; A = (Y) then INC Y
    CIN                                     ; FLAGS = A compared to (X) register, then INC X.
    BZR     BRANCH_9DED                     ;
    LOP	    UL,BRANCH_9D9D                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set

BRANCH_9DA3: ; branched to from 9D99
    POP	    Y                               ;
    LDA	    (OUT_BUF + $41)                 ;
    SHL                                     ;
    BHS     BRANCH_9DEB                     ;
    SHL                                     ;
    BHS     BRANCH_9DE0                     ;
    SHL                                     ;
    BHS     BRANCH_9DC8                     ;
    VEJ	    (F4)                            ; Loads U-Reg with 16-bit value from address of (pp)
                AWRD(OUT_BUF + $32)         ;
    LDX     U                               ; X = U
    VEJ	    (F4)                            ; Loads U-Reg with 16-bit value from address of (pp)
                AWRD(OUT_BUF + $17)         ;    
    SJP	    U_MINUS_X                       ;
    BCR     BRANCH_9DEF                     ;
    VEJ	    (F4)                            ; Loads U-Reg with 16-bit value from address of (pp)
                AWRD(OUT_BUF + $15)

BRANCH_9DC1: ; branched to from 9DD4, 9DDE
    LDX     U                               ; X = U
    VEJ	    (F4)                            ; Loads U-Reg with 16-bit value from address of (pp)
                AWRD(OUT_BUF + $32)         ;
    REC                                     ; Reset Carry
    RTN                                     ;


BRANCH_9DC8: ; branched to from 9DAF
    VEJ	    (F4)                            ; Loads U-Reg with 16-bit value from address of (pp)
                AWRD(OUT_BUF + $19)         ;
    CPA	    UL                              ;
    BZR     BRANCH_9DD6                     ;
    INC	    A                               ;
    BCR     BRANCH_9DD6                     ;
    VEJ	    (F4)                            ; Loads U-Reg with 16-bit value from address of (pp)
                AWRD(OUT_BUF + $30)         ;
    BCH 	BRANCH_9DC1                     ;


BRANCH_9DD6: ; branched to from 9DCC, 9DCF
    ORI	    (OUT_BUF + $34),$FF             ;
    ORI	    (OUT_BUF + $35),$FF             ;
    BCH 	BRANCH_9DC1                     ;


BRANCH_9DE0: ; branched to from 9DAC
    VEJ	    (F4)                            ; Loads U-Reg with 16-bit value from address of (pp)
                AWRD(OUT_BUF + $15)         ;
    VEJ	    (F6)                            ; Transfers U to Start of Basic program edit (H)
                AWRD(BASPRG_EDT_H)          ;
    VEJ	    (F6)                            ; Transfers U to End of Basic program in RAM (H)
                AWRD(BASPRG_END_H)          ;
    ORI	    (U),$FF                         ;

BRANCH_9DEB: ; branched to from 9DA9
    REC                                     ; Reset Carry
    RTN                                     ;


BRANCH_9DED: ; branched to from 9D94, 9D9F
    POP	    Y                               ;

BRANCH_9DEF: ; branched to from 9DBC
    SEC                                     ; Set Carry

BRANCH_9DF0: ; branched to from 9D79
    RTN                                     ;

;% SUB_9D65 END


;------------------------------------------------------------------------------------------------------------
; SUB_9DF1 - Called from 9452, 910D
; 
; Arguments:
; Output:
; RegMod:
;% SUB_9DF1 START
SUB_9DF1:
    VMJ	    ($36)                           ; Stores CSI of a text/text var in AR-X (C=1). If no string in Y-Reg, C=0.
    BCS     BRANCH_9E1D                     ; PRINT# C=1
    PSH	    X                               ;
    LDI	    YL,LBO(OUT_BUF,$02)             ;
    LDI	    YH,HBO(OUT_BUF,$02)             ; Y = 7B62, (OUT_BUF + 2)
    LDI	    UL,$15                          ;

BRANCH_9DFD: ; called from 9E38, 9E3E
    LDI	    A,00                            ; PRINT# A=0, X=7BB9, Y=7B6A, U=7A10

BRANCH_9DFF: ; called from 9E00
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1. Zeros out 7B6A to 7B7A
    LOP	    UL,BRANCH_9DFF                  ; UL = UL - 1, loop back 'e' if Borrow Flag not set
    LDI	    YL,LB(OUT_BUF)                  ; Y=7B60 = OUT_BUF
    LDI	    A,$01                           ;
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1
    LDA	    (OUT_BUF + $41)                 ;
    ANI	    A,$4F                           ;
    ORI	    A,$40                           ;
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1
    LDI	    A,$43                           ;
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1
    LDI	    A,$4F                           ;
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1
    LDI	    A,$4D                           ;   
    SIN	    Y                               ; (Y) = A. Then Y = Y + 1
    POP	    Y                               ;
    JMP	    SUB_9B99                        ; no idea


BRANCH_9E1D: ; branched to from 9DF3 PRINT#     
    PSH	    Y                               ; Pointer to position in BASIC line
    LDI	    YL,LBO(OUT_BUF,$05)             ; Y = (OUT_BUF + 5)
    LDI	    YH,HBO(OUT_BUF,$05)             ; First character of argument
    VEJ     (DC)                            ; Loads CSI from AR-X: Address by X-Reg length by UL & A 
    CPI	    A,$10                           ; PRINT# A=05
    BCR     BRANCH_9E2A                     ; PRINT# C=0
    LDI	    A,$10                           ;

BRANCH_9E2A: ; branched to from 9E26
    STA	    UL                              ;
    BCH 	BRANCH_9E2E                     ;


BRANCH_9E2D: ; branched to from 9E2E
    TIN                                     ; (Y) = (X) then X = X + 1, Y = Y + 1
                                            ; Y points to ARX, X points to Input Buffer

BRANCH_9E2E: ; branched to from 9E28
    LOP	    UL,BRANCH_9E2D                  ; PRINT# X=7BB4, Y=7A04, UL=04. UL= UL-1, loop back 'e' if Borrow Flag not set
    LDI	    UL,$05                          ;
    LDI	    A,$0F                           ;
    SEC                                     ;
    SBC	    (ARX + $07)                     ; (ARX + $07) = Length of string
    BCR     BRANCH_9DFD                     ;
    ADC	    UL                              ;
    STA	    UL                              ;
    BCH 	BRANCH_9DFD                     ;

;% SUB_9DF1 END


;------------------------------------------------------------------------------------------------------------
; SUB_9E3E - Called from 9607
; SUB_9E47 - Called from called from 9639
; Arguments:
; Output:
; RegMod:
;% SUB_9E3E START
SUB_9E3E:
    LDA	    (OUT_BUF + $41)                 ;
    SHL                                     ;
    BCR     BRANCH_9E73                     ;
    SHL                                     ;
    BVR     BRANCH_9E4C                     ;

SUB_9E47: 
    LDI	    A,$37                           ;
    JMP	    TXCOM                           ; Sends charecter in A to RS232 Port.


BRANCH_9E4C: ; called from 9E45
    LDI	    UH,$37                          ;
    BCH  	BRANCH_9E5A                     ;


    LDI	    UH,$2D                          ;
    BCH  	BRANCH_9E5A                     ;

;% SUB_9E3E END


;------------------------------------------------------------------------------------------------------------
; SUB_9E54 - called from 9B03
; Arguments:
; Output:
; RegMod:
;% SUB_9E54 START
SUB_9E54: 
    LDI	    UH,$03                          ;
    BCH  	BRANCH_9E5A                     ;

    LDI	    UH,$02                          ;

BRANCH_9E5A: ; branched to from 9E4E, 9E52, 9E56
    SJP	    BRANCH_828E                     ; Sends data to LPT output
    BCS     BRANCH_9E73                     ;
    CPA	    UH                              ;
    BZR     BRANCH_9E6A                     ;
    CPI	    A,$2D                           ;
    REC                                     ; Reset Carry
    BZS     BRANCH_9E73                     ;
    JMP	    SUB_9C48                        ; no idea


BRANCH_9E6A: ; branched to from 9E60
    LDI	    UH,$3B                          ;
    CPI	    A,$37                           ;
    BZS     BRANCH_9E73                     ;
    LDI	    UH,$3A                          ;
    SEC                                     ; Set Carry

BRANCH_9E73: ; branched to from 9E5D, 9E65, 9E6E
    RTN                                     ;

;% SUB_9E54 END


#IFDEF ENBPD
;------------------------------------------------------------------------------------------------------------
; BUSY BLINK LOAD- Blinks the BUSY annunciator while loading
;
; For higher buad rates we need a secondary /N counter
;% BUSY_BLINK START 
DIVN EQU $04
BUSY_BLINK: ; 9E74
    PSH     A                               ; Save original A
    PSH     X                               ; Save current value in X

    LDA     (RND_VAL)                       ; Main counter value in $7B00
    INC     A                               ; INC main counter
    STA     (RND_VAL)                       ; Update main counter
    CPI     A,DIVN                          ; Did we reach /N?
    BCR     BLINK_SKIP                      ; Skip over if != DIVN

    AND     (RND_VAL),$00                   ; We did reach DIVN so Zero main counter
    LDA     (RND_VAL + $01)                 ; grab DIVN counter value
    INC     A                               ; INC DIVN counter
    STA     (RND_VAL + $01)                 ; store DIVN counter value

    LDI     A,$E0                           ;
    AND     (SETCOM_REG)                    ; Keep only bits 7-5 (BAUD)
    AEX                                     ; Swap nibbles, now we have index into TBL_BUSY
    SHR                                     ; 

    LDI     XH, HB(TBL_BUSY)                ; Set X to TBL_BUSY start address
    LDI     XL, LB(TBL_BUSY)                ;
    ADR     X                               ; Add A to X, X now points to correct table entry

    LDA     (RND_VAL + $01)                 ; /8 counter
    CPA     (X)                             ; Compare /8 counter and /8 toggle setting for this BAUD
    BCR     BLINK_SKIP                      ; Skip if /8 counter < /8 toggle setting for this BAUD

    LDI     A,$01                           ; B0 is BUSY annunciator
    EOR     (DISP_BUFF + $4E)               ; Toggle B0
    STA     (DISP_BUFF + $4E)               ; Write it back
    ANI     (RND_VAL + $01),$00             ; zero /8 counter

BLINK_SKIP:
    POP     X                               ; Get original X back
    POP     A                               ; Get original A back

    SJP	    (OUT_BUF + $4A)                 ; Now do the CLOAD, CSAVE, etc.
    RTN                                     ; 

;% BUSY_BLINK END


;------------------------------------------------------------------------------------------------------------
; CLEAR_RTS - Clears RTS when EO, $0D, was recieved. Allows time to parse a line of ASCII code
; Called by RXCOM
;% CLEAR_RTS START
CLEAR_RTS:
#IFDEF HANDSHAKE
    LDA     #(CE158_UART_RBR0)              ; Read data byte 
    CPI	    A,$0D                           ; Detects EOL for CLOAD handshaking
    BZR     CLEARRTS_SKIP                   ;
    ANI     #(CE158_UART_MCR0),~$02         ; Clear RTS, TI part is inverted
    
CLEARRTS_SKIP:
    REC                                     ; REC = Success
    RTN                                     ;
#ENDIF

;% CLEAR_RTS END


;------------------------------------------------------------------------------------------------------------
; SET_RTS - Sets RTS if it should be set and is not set
; Called by RXCOM
;% SET_RTS START
SET_RTS:
#IFDEF HANDSHAKE    
    BII 	(OUTSTAT_REG),$02	            ; (20) Should RTS be set?
    BZR     SETRTS_SKIP                     ; (10) No, so skip past
    BII     #(CE158_UART_MCR0),$02          ; (23) Is RTS actually set
    BZR     SETRTS_SKIP                     ; Already set, skip past
    ORI     #(CE158_UART_MCR0),$02          ; (23) Set RTS (inverted in TI part)

SETRTS_SKIP:
    RTN                                     ;
    ;JMP     CONTRX                          ; We want COM0 after all
#ENDIF  

;% SET_RTS END


;------------------------------------------------------------------------------------------------------------
; TBL_BUSY - ; Delay after N bytes counts for various baud rates
; Used to blink BUSY annunciator when using COM port.
;% TBL_BUSY START
TBL_BUSY: 
#IFDEF CE158V2   
 #IFDEF ENBPD ; New 158X HW, 38400 BAUD
    ;      4800, 9600,19200,38400,  300,  600, 1200, 2400
    .BYTE   $12,  $25,  $4B,  $96,  $02,  $09,  $25,  $09 
 #ELSE            ; New 158X HW, 2400 BAUD
           ; 50,  100,  110,  200,  300,  600, 1200, 2400 
    .BYTE   $01,  $01,  $02,  $02,  $04,  $09,  $12,  $25 
 #ENDIF
#ELSE
 #IFDEF CE158_48 ; Original 158 HW, 4800 BAUD
           ;100,  110,  200,  300,  600, 1200, 2400, 4800
    .BYTE   $02,  $02,  $03,  $05,  $09,  $12,  $25,  $4B
 #ELSE           ; Original 158 HW, 2400 BAUD
           ; 50,  100,  110,  200,  300,  600, 1200, 2400
    .BYTE   $01,  $01,  $02,  $02,  $04,  $09,  $12,  $25
 #ENDIF
#ENDIF

#ENDIF ;ENBPD

;% TBL_BUSY END


;------------------------------------------------------------------------------------------------------------
; SEPARATOR_9E74 - Unused
;% SEPARATOR_9E74 START
SEPARATOR_9E74:
#IFNDEF ENBPD
    .BYTE $00,$FF,$03,$D7,$26,$F7,$00,$FF,  $00,$FF,$00,$BF,$04,$EE,$00,$FF
    .BYTE $00,$FF,$82,$FF,$06,$FE,$00,$FF,  $00,$FF,$09,$FE,$00,$FF,$00,$FF
    .BYTE $00,$FF,$80,$FF,$05,$FE,$00,$FF,  $00,$FF,$00,$FF,$00,$3F,$00,$FF
    .BYTE $00,$FF,$40,$FF,$04,$FF,$00,$FF,  $00,$FF,$00,$FF,$80,$FF,$00,$FF
    .BYTE $00,$FF,$00,$FF,$21,$DF,$00,$FF,  $00,$FF,$00,$FF,$80,$FF,$00,$FF
    .BYTE $00,$FF,$82,$FF,$50,$FD,$00,$FF,  $00,$FF,$00,$FF,$00,$E2,$00,$FF
    .BYTE $00,$FF,$42,$F5,$80,$7F,$00,$FF,  $00,$FF,$0C,$CF,$08,$FF,$00,$FF
    .BYTE $00,$FF,$00,$FE,$08,$FF,$00,$FF,  $00,$FF,$40,$FF,$01,$FF,$00,$FF
    .BYTE $00,$FF,$44,$FD,$82,$FF,$00,$FF,  $00,$FF,$10,$FF,$40,$00,$00,$ED
    .BYTE $00,$FF,$10,$00,$00,$00,$00,$5F,  $00,$FF,$01,$00,$00,$00,$00,$FF
    .BYTE $00,$FD,$22,$00,$00,$00,$00,$FF,  $00,$BF,$01,$00,$00,$00,$00,$DF
    .BYTE $00,$DF,$00,$00,$00,$00,$00,$DD,  $00,$EF,$11,$00,$21,$00,$00,$EF
    .BYTE $00,$CD,$00,$00,$83,$00,$00,$FE,  $00,$7F,$02,$00,$41,$00,$00,$B9
    .BYTE $00,$7F,$48,$00,$01,$00,$00,$9F,  $00,$8D,$00,$00,$40,$00,$00,$FF
    .BYTE $00,$EF,$08,$00,$88,$00,$00,$FB,  $00,$FF,$0A,$00,$10,$00,$00,$DF
    .BYTE $00,$FF,$40,$00,$00,$00,$00,$FE,  $00,$FF,$00,$00,$00,$00,$00,$F7
    .BYTE $00,$FE,$08,$00,$08,$00,$00,$FE,  $00,$7F,$02,$00,$80,$00,$00,$7B
    .BYTE $00,$FF,$00,$00,$00,$00,$00,$F7,  $00,$7F,$00,$04,$20,$08,$00,$FF
    .BYTE $00,$7F,$05,$00,$81,$00,$00,$7F,  $00,$FF,$44,$00,$40,$00,$00,$7F
    .BYTE $00,$DD,$84,$00,$A0,$00,$00,$7F,  $00,$BF,$01,$00,$81,$00,$00,$BF
    .BYTE $00,$7F,$10,$00,$00,$00,$00,$BF,  $00,$FF,$02,$02,$02,$00,$00,$FF
    .BYTE $00,$FE,$00,$00,$21,$00,$00,$EF,  $00,$FC,$10,$00,$02,$00,$00,$DE
    .BYTE $00,$F7,$00,$00,$34,$00,$00,$4F,  $00,$3F,$12,$00,$00,$00,$00,$DF
    .BYTE $00,$7F,$08,$00,$01,$00,$00,$FF,  $00,$FF,$04,$00,$84,$00,$00,$9A
    .BYTE $00,$AF,$00,$00,$80,$00,$00,$7F,  $00,$FF,$04,$00

#ELSE

.FILL ($A000 - $)

#ENDIF
;% SEPARATOR_9E74 END

.END
