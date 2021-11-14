
B_TBL_8000:
8000	55 


B_TBL_8000_TNUM:
8001	08 


B_TBL_8000_NAME:
8002	"COM\0D\0D\0D\0D\0D"


B_TBL_8000_INIT:
800A	BA 82 B8          JP	COM_TBL_INIT


B_TBL_8000_INPUT#:
800D	BA 82 C5          JP	INPUT#


B_TBL_8000_PRINT#:
8010	BA 82 C9          JP	PRINT#


B_TBL_8000_JMPS:
8013	BA 79 FA 9A 9A 9A 9A 9A   9A 9A 


B_TBL_8000_TRACE:
801D	C4 AF FF          JNE	AF,811F


B_TBL_8000_A_KW:
8020	00 00 


B_TBL_8000_B_KW:
8022	80 56 


B_TBL_8000_C_KW:
8024	80 60 


B_TBL_8000_D_KW:
8026	80 89 


B_TBL_8000_E_KW:
8028	80 9A 


B_TBL_8000_F_KW:
802A	80 AA 


B_TBL_8000_G_KW:
802C	00 00 


B_TBL_8000_H_KW:
802E	00 00 


B_TBL_8000_I_KW:
8030	80 B3 


B_TBL_8000_J_KW:
8032	00 00 


B_TBL_8000_K_KW:
8034	00 00 


B_TBL_8000_L_KW:
8036	80 C8 


B_TBL_8000_M_KW:
8038	80 DD 


B_TBL_8000_N_KW:
803A	00 00 


B_TBL_8000_O_KW:
803C	80 E7 


B_TBL_8000_P_KW:
803E	80 F3 


B_TBL_8000_Q_KW:
8040	00 00 


B_TBL_8000_R_KW:
8042	81 0A 


B_TBL_8000_S_KW:
8044	81 16 


B_TBL_8000_T_KW:
8046	81 37 


B_TBL_8000_U_KW:
8048	00 00 


B_TBL_8000_V_KW:
804A	00 00 


B_TBL_8000_W_KW:
804C	00 00 


B_TBL_8000_X_KW:
804E	00 00 


B_TBL_8000_Y_KW:
8050	00 00 

8052	81 59 


B_TBL_8000_CMD_LST:
8054	B5 "BREAK"        F0B3 CD89 
805E	B5 "CLOAD"        F089 82EC 
8068	C5 "CSAVE"        F095 82DD 
8072	C4 "COM$"         E858 82D3 
807B	C7 "CONSOLE"      F0B1 82DE 
8087	D4 "DEV$"         E857 82D4 
8090	C3 "DTE"          E884 82D1 
8098	D3 "ERN"          F052 82DF 
80A0	C3 "ERL"          F053 82E0 
80A8	D4 "FEED"         F0B0 82E1 
80B1	D5 "INPUT"        F091 82E2 
80BB	C6 "INSTAT"       E859 82E3 
80C6	D6 "LPRINT"       F0B9 82E4 
80D1	C5 "LLIST"        F0B8 82E5 
80DB	D5 "MERGE"        F08F 82C0 
80E5	97 "OUTSTAT"      E880 82E6 
80F1	C5 "PRINT"        F097 82E7 
80FB	C8 "PROTOCOL"     E881 82E8 
8108	D7 "RINKEY$"      E85A 82E9 
8114	D6 "SETCOM"       E882 82D6 
811F	C6 "SETDEV"       E886 82D5 
812A	C6 "SPACE$"       F061 82EA 
8135	B8 "TERMINAL"     E883 82D2 
8142	C8 "TRANSMIT"     E885 82D7 
814F	C3 "TAB"          F0BB 880D 
8157	D4 "ZONE"         F0B4 82EB 


B_TBL_8800_END:
8160	D0 


SEPARATOR_8161:
8161	FF 00 FF 00 FF 00 FF 00   


SUB_8169:
8169	FD C8             PUSH	A
816B	B5 7F             LDA	7F
816D	FD AE D0 0D       STA#	(CE158_PRT_B_DIR)
8171	FD A5 D0 0E       LDA#	(CE158_PRT_A)
8175	FD A9 D0 0E       AND#	(CE158_PRT_A)
8179	D9                SL
817A	D9                SL
817B	D9                SL
817C	FD 8A             POP	A
817E	83 38             JR	C,BRANCH_81B8
8180	FD ED D0 0F 80    BIT#	(CE158_PRT_B),80
8185	8B A5             JR	Z,BRANCH_822C
8187	FD E9 D0 08 9F    AND#	(CE158_PRT_C),9F
818C	BD FF             XOR	FF
818E	D5                SR
818F	81 05             JR	NC,BRANCH_8196
8191	FD EB D0 08 20    OR#	(CE158_PRT_C),20

BRANCH_8196:
8196	FD AE D0 0F       STA#	(CE158_PRT_B)
819A	B5 80             LDA	80

BRANCH_819C:
819C	DF                DEC	A
819D	93 03             JR	C,BRANCH_819C
819F	FD BE             DI
81A1	FD EB D0 08 40    OR#	(CE158_PRT_C),40
81A6	B5 80             LDA	80

BRANCH_81A8:
81A8	DF                DEC	A
81A9	93 03             JR	C,BRANCH_81A8
81AB	FD E9 D0 08 BF    AND#	(CE158_PRT_C),BF
81B0	FD 81             EI
81B2	B5 80             LDA	80

BRANCH_81B4:
81B4	DF                DEC	A
81B5	93 03             JR	C,BRANCH_81B4
81B7	9A                RET

BRANCH_81B8:
81B8	B5 20             LDA	20
81BA	FB                SCF
81BB	9A                RET


SUB_81BC:
81BC	FB                SCF
81BD	FD A8             PUSH	HL
81BF	2A                STA	L
81C0	FD A5 D0 0E       LDA#	(CE158_PRT_A)
81C4	FD A9 D0 0E       AND#	(CE158_PRT_A)
81C8	B9 3C             AND	3C
81CA	89 17             JR	NZ,BRANCH_81E3
81CC	A5 78 57          LDA	(SETDEV_VAL)
81CF	B9 C0             AND	C0
81D1	D9                SL
81D2	83 02             JR	C,BRANCH_81D6
81D4	B5 04             LDA	04

BRANCH_81D6:
81D6	FD A9 D2 03       AND#	(UART_REG_R)
81DA	FB                SCF
81DB	8B 06             JR	Z,BRANCH_81E3
81DD	24                LDA	L
81DE	FD AE D2 00       STA#	(UART_DATA_W)
81E2	F9                RCF

BRANCH_81E3:
81E3	FD 2A             POP	HL
81E5	9A                RET


SUB_81E6:
81E6	FD A5 D0 0E       LDA#	(CE158_PRT_A)
81EA	FD A9 D0 0E       AND#	(CE158_PRT_A)
81EE	B9 3C             AND	3C
81F0	89 3E             JR	NZ,BRANCH_8230
81F2	FD A5 D2 03       LDA#	(UART_REG_R)
81F6	ED 78 57 40       BIT	(SETDEV_VAL),40
81FA	8B 01             JR	Z,BRANCH_81FD
81FC	D9                SL

BRANCH_81FD:
81FD	BF 02             BIT	02
81FF	8B 2B             JR	Z,BRANCH_822C
8201	ED 78 57 80       BIT	(SETDEV_VAL),80
8205	8B 01             JR	Z,BRANCH_8208
8207	D9                SL

BRANCH_8208:
8208	BF 70             BIT	70
820A	8B 1A             JR	Z,BRANCH_8226
820C	FD A5 D2 02       LDA#	(UART_DATA_R)
8210	ED 78 57 20       BIT	(SETDEV_VAL),20
8214	8B 0C             JR	Z,BRANCH_8222
8216	B5 15             LDA	15
8218	FD AE D2 01       STA#	(UART_REG_W)
821C	B5 05             LDA	05
821E	FD AE D2 01       STA#	(UART_REG_W)

BRANCH_8222:
8222	B5 40             LDA	40
8224	FB                SCF
8225	9A                RET

BRANCH_8226:
8226	FD A5 D2 02       LDA#	(UART_DATA_R)
822A	F9                RCF
822B	9A                RET

BRANCH_822C:
822C	B5 00             LDA	00
822E	FB                SCF
822F	9A                RET

BRANCH_8230:
8230	FD C8             PUSH	A
8232	FD A5 D2 02       LDA#	(UART_DATA_R)
8236	FB                SCF

BRANCH_8237:
8237	FD 8A             POP	A
8239	9A                RET


UNKNOWN_823A:
823A	E9 78 50 0F       AND	(OUTSTAT_REG),0F

BRANCH_823E:
823E	FD ED F0 0B 02    BIT#	(PC1500_IF_REG),02
8243	89 6E             JR	NZ,BRANCH_82B3
8245	FD C8             PUSH	A
8247	BE 81 BC          CALL	SUB_81BC
824A	91 15             JR	NC,BRANCH_8237
824C	D5                SR
824D	D5                SR
824E	FD 8A             POP	A
8250	95 14             JR	NH,BRANCH_823E
8252	EF 78 50 10       ADD	(OUTSTAT_REG),10
8256	91 1A             JR	NC,BRANCH_823E
8258	68 32             LD	H,32

BRANCH_825A:
825A	9A                RET
825B	E9 78 50 0F       AND	(OUTSTAT_REG),0F

BRANCH_825F:
825F	FD A8             PUSH	HL
8261	6A FF             LD	L,FF
8263	68 00             LD	H,00

BRANCH_8265:
8265	FD ED F0 0B 02    BIT#	(PC1500_IF_REG),02
826A	89 45             JR	NZ,BRANCH_82B1
826C	FD C8             PUSH	A
826E	BE 81 69          CALL	SUB_8169
8271	89 0D             JR	NZ,BRANCH_8280
8273	FD 8A             POP	A
8275	88 12             DJC	BRANCH_8265
8277	FD 60             INC	H
8279	91 16             JR	NC,BRANCH_8265
827B	FD 2A             POP	HL
827D	68 45             LD	H,45
827F	9A                RET

BRANCH_8280:
8280	FD 8A             POP	A
8282	FD 2A             POP	HL
8284	91 2C             JR	NC,BRANCH_825A
8286	EF 78 50 10       ADD	(OUTSTAT_REG),10
828A	91 2D             JR	NC,BRANCH_825F
828C	9E 36             JR	8258
828E	E9 78 50 0F       AND	(OUTSTAT_REG),0F

BRANCH_8292:
8292	FD ED F0 0B 02    BIT#	(PC1500_IF_REG),02
8297	89 1A             JR	NZ,BRANCH_82B3
8299	BE 81 E6          CALL	SUB_81E6
829C	81 12             JR	NC,BRANCH_82B0
829E	B9 60             AND	60
82A0	9B 10             JR	Z,BRANCH_8292
82A2	D9                SL
82A3	8F 08             JR	V,BRANCH_82AD
82A5	EF 78 50 10       ADD	(OUTSTAT_REG),10
82A9	91 19             JR	NC,BRANCH_8292
82AB	9E 55             JR	8258

BRANCH_82AD:
82AD	68 3A             LD	H,3A
82AF	FB                SCF

BRANCH_82B0:
82B0	9A                RET

BRANCH_82B1:
82B1	FD 2A             POP	HL

BRANCH_82B3:
82B3	68 00             LD	H,00
82B5	FB                SCF
82B6	9A                RET
82B7	8E 4A             JR	8303


COM_TBL_INIT:
82B8	4A D0             LD	C,D0
82BA	E9 79 DE EF       AND	(UNDEF_REG_79DE),EF
82BE	8E 2C             JR	MAIN_ENTRY/CLOAD


MERGE:
82C0	60                INC	L
82C1	4A F0             LD	C,F0
82C3	8E 27             JR	MAIN_ENTRY/CLOAD


INPUT#:
82C5	4A ED             LD	C,ED
82C7	8E 23             JR	MAIN_ENTRY/CLOAD


PRINT#:
82C9	4A EE             LD	C,EE
82CB	8E 1F             JR	MAIN_ENTRY/CLOAD

PRINT#2:
82CD	4A EF             LD	C,EF
82CF	8E 1B             JR	MAIN_ENTRY/CLOAD


DTE:
82D1	F9                RCF


TERMINAL:
82D2	F9                RCF


COM$:
82D3	F9                RCF


DEV$:
82D4	F9                RCF


SETDEV:
82D5	F9                RCF


SETCOM:
82D6	F9                RCF


TRANSMIT:
82D7	F9                RCF


82D8	[F0B1],N   "CONSOLE"

CONSOLE_2:
82D8	F9                RCF


82D9	[F0B0],N   "FEED"

FEED_2:
82D9	F9                RCF


82DA	[F0B9],N   "LPRINT"

LPRINT_2:
82DA	F9                RCF


82DB	[F0B8],N   "LLIST"

LLIST_2:
82DB	F9                RCF
82DC	F9                RCF


CSAVE:
82DD	F9                RCF


CONSOLE:
82DE	F9                RCF


ERN:
82DF	F9                RCF


ERL:
82E0	F9                RCF


FEED:
82E1	F9                RCF


INPUT:
82E2	F9                RCF


INSTAT:
82E3	F9                RCF


LPRINT:
82E4	F9                RCF


LLIST:
82E5	F9                RCF


OUTSTAT:
82E6	F9                RCF


PRINT:
82E7	F9                RCF


PROTOCOL:
82E8	F9                RCF


RINKEY$:
82E9	F9                RCF


SPACE$:
82EA	F9                RCF


ZONE:
82EB	F9                RCF


MAIN_ENTRY/CLOAD:
82EC	EB 78 50 08       OR	(OUTSTAT_REG),08

ME_FRM_LOW_BANK:
82F0	EB 78 55 08       OR	(CR/LF_REG),08
82F4	FD 81             EI
82F6	FD 88             PUSH	BC
82F8	BE 8A 2A          CALL	MAIN_ENTRY_2
82FB	FD 2A             POP	HL
82FD	68 83             LD	H,83
82FF	FB                SCF
8300	B5 D7             LDA	D7
8302	20                SBC	L
8303	6A 63             LD	L,63
8305	83 08             JR	C,BRANCH_830F
8307	FD 62             DEC	H
8309	FD BE             DI
830B	E9 78 55 F7       AND	(CR/LF_REG),F7

BRANCH_830F:
830F	D9                SL
8310	FD EA             ADD	HL
8312	65                LDI	(HL)
8313	08                STA	B
8314	25                LDA	(HL)
8315	0A                STA	C
8316	ED 78 55 08       BIT	(CR/LF_REG),08
831A	8B 02             JR	Z,BRANCH_831E
831C	FD 5E             LD	PC,BC

BRANCH_831E:
831E	68 7A             LD	H,7A
8320	6A 28             LD	L,28
8322	B5 E3             LDA	E3
8324	61                STI	(HL)
8325	B5 BA             LDA	BA
8327	61                STI	(HL)
8328	B5 83             LDA	83
832A	61                STI	(HL)
832B	B5 05             LDA	05
832D	2E                STA	(HL)
832E	BA 7A 28          JP	MATH_REG_Wa_B1


UNKNOWN_VECTOR_8331:
8331	90 1C 


UNKNOWN_VECTOR_8333:
8333	93 D4 


PRINT#_VECTOR:
8335	93 D0 


INPUT#_VECTOR:
8337	96 60 


UNKNOWN_VECTOR_8339:
8339	90 1B 


UNKNOWN_VECTOR_833B:
833B	98 70 


UNKNOWN_VECTOR_833D:
833D	83 D8 


UNKNOWN_VECTOR_833F:
833F	83 57 


UNKNOWN_VECTOR_8341:
8341	83 17 


UNKNOWN_VECTOR_8343:
8343	90 0D 


UNKNOWN_VECTOR_8345:
8345	83 34 


UNKNOWN_VECTOR_8347:
8347	90 1D 


UNKNOWN_VECTOR_8349:
8349	90 56 


UNKNOWN_VECTOR_834B:
834B	83 2A 


UNKNOWN_VECTOR_834D:
834D	8F FF 


UNKNOWN_VECTOR_834F:
834F	98 20 


UNKNOWN_VECTOR_8351:
8351	83 09 


UNKNOWN_VECTOR_8353:
8353	83 12 


UNKNOWN_VECTOR_8355:
8355	83 65 


UNKNOWN_VECTOR_8357:
8357	90 1A 


UNKNOWN_VECTOR_8359:
8359	98 70 


UNKNOWN_VECTOR_835B:
835B	93 50 


UNKNOWN_VECTOR_835D:
835D	93 D8 


UNKNOWN_VECTOR_835F:
835F	98 20 


UNKNOWN_VECTOR_8361:
8361	83 65 


UNKNOWN_VECTOR_8363:
8363	89 F5 


UNKNOWN_VECTOR_8365:
8365	89 07 


UNKNOWN_VECTOR_8367:
8367	89 68 


UNKNOWN_VECTOR_8369:
8369	88 99 


UNKNOWN_VECTOR_836B:
836B	88 93 


UNKNOWN_VECTOR_836D:
836D	8C 88 


UNKNOWN_VECTOR_836F:
836F	8C 8E 


INIT_VECTOR:
8371	88 0A 


SEPARATOR_8373:
8373	FF 00 FF 00 FF 00 FF 00   FF 00 FF 00 FF 


JMP_8380:
8380	ED 78 55 80       BIT	(CR/LF_REG),80
8384	8B 17             JR	Z,BRANCH_839D
8386	FD ED F0 0F 08    BIT#	(PC1500_PRT_B),08
838B	89 10             JR	NZ,BRANCH_839D
838D	A5 78 BE          LDA	(78BE)
8390	89 0B             JR	NZ,BRANCH_839D
8392	A5 78 58          LDA	(SETCOM_REG)
8395	B9 18             AND	18
8397	B7 10             CPA	10
8399	89 02             JR	NZ,BRANCH_839D
839B	6A 0A             LD	L,0A

BRANCH_839D:
839D	24                LDA	L
839E	AE 78 B0          STA	(78B0)
83A1	BA 8E 55          JP	JMP_8E55


SEPARATOR_83A4:
83A4	00 FF 00 FF 00 FF 00 FF   00 FF 00 FF 


CE-158_IO-REG_INIT:
83B0	FF FF 7F 03 00 00 00 A0   


CE-158_IO-REG_INIT2:
83B8	00 0D 18 00 00 


UNKNOWN_83BD:
83BD	4F 00 7F 


TBL_BAUD:
83C0	00 32 00 64 00 6E 00 C8   01 2C 02 58 04 B0 09 60 


TBL_CDP1854ACE_BAUD:
83D0	70 58 56 4C 48 44 42 41   


TBL_SETDEV_TEXT:
83D8	4B 49 01 44 4F 02 50 4F   04 43 49 08 43 4F 10 


TBL_CDP1854ACE_CFG:
83E7	42 52 62 72 82 92 A2 B2   46 56 66 76 C6 D6 E6 F6 
83F7	4A 5A 6A 7A CA DA EA FA   4E 5E 6E 7E CE DE EE FE 
8407	89 8D 89 89 81 85 81 81   89 8D 89 89 81 85 81 81 
8417	89 8D 89 89 81 8D 81 81   95 9D 95 99 91 91 91 

8426	91 12 09 49 52 61 71 C1   03 62 56 C2 03 09 DC 01 
8436	42 56 E2 02 56 2A 4A FA   01 09 5A 4A 2A C4 0B 59 
8446	52 41 71 E1 04 61 59 52   61 41 52 49 C1 02 52 12 
8456	D2 41 49 52 41 61 52 59   E1 44 56 64 76 03 49 11 
8466	6A 21 4B 11 6C 11 4C 11   6C 11 4B 21 6A 11 C9 


TBL_8475:
8475	00                SBC	C
8476	0B                OR	(BC)
8477	07                CPA	(BC)
8478	00                SBC	C
8479	00                SBC	C

847A	00                SBC	C
847B	7F 41             ADD	(MN),41
847D	41                STI	(BC)
847E	00                SBC	C

847F	02 04 08 10 20 00 41 41   7F 00 04 02 7F 02 04 08 
848F	1C 2A 08 08 00 00 07 0B   00 06 27 03 2E 02 32 03 
849F	35 04 39 05 3E 05 44 08   4A 03 53 07 57 15 5F 00 
84AF	FF 

84B0	19 85 7F 17 85 3F 0A 85   67 0C 85 72 0D 85 B8 04 
84C0	84 EF 05 84 F4 08 85 57   0A 85 A6 06 85 B1 0C 85 
84D0	99 0D 85 0A 09 85 18 0B   85 29 06 85 22 09 85 35 
84E0	0F 84 FA 17 85 C6 18 85   DE 14 85 F7 17 86 0C 


TEXT_84EF:
84EF	45 43 48 4F 20 54 52 41   43 45 20 43 48 41 4E 47 
84FF	45 20 41 55 54 4F 20 53   49 47 4E 42 55 46 46 45 
850F	52 20 4C 45 4E 47 54 48   3D 42 41 55 44 20 52 41 
851F	54 45 3D 50 41 52 49 54   59 3D 57 4F 52 44 20 4C 
852F	45 4E 47 54 48 3D 53 54   4F 50 20 42 49 54 53 3D 
853F	53 65 74 75 70 3A 20 20   20 20 20 20 20 41 75 74 
854F	20 46 6E 63 20 43 6F 6D   58 4F 4E 2F 58 4F 46 46 
855F	20 20 3F 28 59 2F 4E 29   4C 4F 57 20 42 41 54 54 
856F	45 52 59 53 45 54 54 49   4E 47 20 45 52 52 4F 52 
857F	2D 2D 2D 45 4E 54 45 52   20 4D 45 4E 55 20 53 45 
858F	4C 45 43 54 49 4F 4E 20   2E 2E 45 58 54 2E 20 50 
859F	52 49 4E 54 45 52 20 43   4C 45 41 4E 20 54 45 58 
85AF	54 20 43 4C 3D 45 54 58   20 4C 50 52 49 4E 54 45 
85BF	52 20 45 52 52 30 52 4F   70 65 72 61 74 65 3A 20 
85CF	20 20 20 20 4E 72 6D 20   41 2F 50 20 41 2F 4C 54 
85DF	65 72 6D 69 6E 61 6C 3A   20 20 20 20 45 6E 74 20 
85EF	41 75 74 20 51 75 69 74   50 72 6F 74 6F 63 6F 6C 
85FF	3A 20 20 20 58 4F 2F 4F   20 45 63 68 6F 4F 75 74 
860F	70 75 74 3A 20 20 45 78   74 20 54 72 63 20 44 73 
861F	70 20 

8621	45 74 78 


SEPARATOR_8624:
8624	00 FF 00 FF 00 FF 00 FF   00 FF 00 FF 00 FF 00 FF 
8634	00 


TEXT_8635:
8635	58 4F 2F 4F 20 42 6B 73   20 50 72 74 20 53 70 63 
8645	6C 20 45 73 63 20 43 74   6C 20 20 20 20 20 20 20 
8655	20 20 20 20 20 20 20 4E   72 6D 20 41 2F 50 20 41 
8665	2F 4C 20 20 


USING_M_INT_TBL_8669:
8669	30 41 42 43 7F 1E 7C 7E   7B 5D 7D 60 5C 4D 4E 5E 
8679	5F 1C 1F 53 27 5B 56 1D   58 59 5A 

8684	19                AND	(DE)
8685	88 43             DJC	8644
8687	A2                ADC	H
8688	FD BE             DI
868A	B8                SPV
868B	A4                LDA	H
868C	BE EE 48          CALL	EE48
868F	FD 18             LD	BC,DE
8691	5A 00             LD	E,00
8693	58 7A             LD	D,7A
8695	F5                LDI
8696	F5                LDI
8697	F5                LDI
8698	F5                LDI
8699	F5                LDI
869A	A8                RPV
869B	FD 81             EI
869D	59 00             AND	(DE),00
869F	FD 18             LD	BC,DE
86A1	9A                RET


SUB_7A50_2:
86A2	B8                SPV
86A3	FD BE             DI
86A5	89 16             JR	NZ,BRANCH_86DB
86A7	ED 78 56 40       BIT	(ZONE_REG),40
86AB	89 0B             JR	NZ,BRANCH_86B8
86AD	ED 78 56 20       BIT	(ZONE_REG),20

BRANCH_86D8:
86B1	8B 25             JR	Z,86D8
86B3	BE A9 CB          CALL	A9CB
86B6	8E 14             JR	BRANCH_86CC

BRANCH_86B8:
86B8	BE A9 F1          CALL	A9F1
86BB	8E 17             JR	BRANCH_86D4

BRANCH_86DB:
86BD	ED 78 56 40       BIT	(ZONE_REG),40
86C1	89 0E             JR	NZ,BRANCH_86D1
86C3	ED 78 56 20       BIT	(ZONE_REG),20
86C7	8B 0F             JR	Z,86D8
86C9	BE A7 5B          CALL	A75B

BRANCH_86CC:
86CC	BE A7 47          CALL	A747
86CF	8E 06             JR	BRANCH_86D7

BRANCH_86D1:
86D1	BE A7 81          CALL	A781

BRANCH_86D4:
86D4	BE A7 69          CALL	A769

BRANCH_86D7:
86D7	A8                RPV
86D8	ED 76 4E 01       BIT	(HIGHLCDFLAG),01
86DC	89 05             JR	NZ,BRANCH_86E3
86DE	FD E9 B0 0A FD    AND#	(CE150_MSK_REG),FD

BRANCH_86E3:
86E3	FD 81             EI
86E5	9A                RET

86E6	5E 30 2B 19 11 09 05 03   00 FF 


SUB_86F0:
86F0	A5 78 B6          LDA	(ERROR_TOP_H)
86F3	FB                SCF
86F4	B1 0A             SBC	0A


SUB_86F0_ALT_E1:
86F6	D5                SR
86F7	FD 2A             POP	HL
86F9	FD C8             PUSH	A
86FB	65                LDI	(HL)
86FC	FD 28             LD	BC,HL
86FE	FD EA             ADD	HL
8700	FD 8A             POP	A
8702	FD A8             PUSH	HL
8704	FD CA             ADD	BC
8706	45                LDI	(BC)
8707	FD CA             ADD	BC
8709	FD 5E             LD	PC,BC

SUB_870B:
870B	5A B0             LD	E,B0
870D	58 7B             LD	D,7B
870F	4A B0             LD	C,B0
8711	48 84             LD	B,84
8713	B7 22             CPA	22
8715	81 0C             JR	NC,BRANCH_8723
8717	B7 2E             CPA	2E
8719	83 06             JR	C,BRANCH_8721
871B	4A FA             LD	C,FA
871D	6A 06             LD	L,06
871F	8E 11             JR	BRANCH_8732

BRANCH_8721:
8721	B1 0C             SBC	0C

BRANCH_8723:
8723	FD CA             ADD	BC
8725	D5                SR
8726	FD CA             ADD	BC
8728	45                LDI	(BC)
8729	2A                STA	L
872A	45                LDI	(BC)
872B	FD C8             PUSH	A
872D	05                LDA	(BC)
872E	0A                STA	C
872F	FD 8A             POP	A
8731	08                STA	B

BRANCH_8732:
8732	F5                LDI
8733	88 03             DJC	BRANCH_8732
8735	9A                RET

SUB_8736:
8736	E9 78 80 00       AND	(7880),00
873A	BE 87 0B          CALL	SUB_870B
873D	FD C1             SDP
873F	BA E8 CA          JP	PRGMDISP
8742	F5                LDI
8743	88 44             DJC	8701


BRANCH_8744:
8744	44                INC	BC

SUB_8745:
8745	FD BE             DI
8747	6A 1F             LD	L,1F

BRANCH_8749:
8749	05                LDA	(BC)
874A	BF E0             BIT	E0
874C	8B 1A             JR	Z,BRANCH_8768
874E	B7 40             CPA	40
8750	89 02             JR	NZ,BRANCH_8754
8752	B5 0D             LDA	0D

BRANCH_8754:
8754	FD ED F0 0B 02    BIT#	(PC1500_IF_REG),02
8759	89 0D             JR	NZ,BRANCH_8768
875B	BE 81 BC          CALL	SUB_81BC
875E	91 1C             JR	NC,BRANCH_8744
8760	9B 19             JR	Z,BRANCH_8749
8762	BF 20             BIT	20
8764	89 02             JR	NZ,BRANCH_8768
8766	88 1F             DJC	BRANCH_8749

BRANCH_8768:
8768	F9                RCF
8769	FD 81             EI
876B	9A                RET


SUB_876C:
876C	FD EB D0 0A 01    OR#	(CE158_MSK_REG),01
8771	FD E9 B0 0A FD    AND#	(CE150_MSK_REG),FD
8776	FD EB B0 0A 01    OR#	(CE150_MSK_REG),01
877B	FD EB F0 0A 01    OR#	(PC1500_MSK_REG),01


SUB_876C_ALT_E1:
8780	FD E9 D0 0E FC    AND#	(CE158_PRT_A),FC
8785	9A                RET


UNKNOWN_SUB_8786:
8786	F0                SXY
8787	0A                STA	C
8788	01                SBC	(BC)
8789	FD E9 D0 0E FC    AND#	(CE158_PRT_A),FC
878E	9A                RET
878F	BF 6A             BIT	6A


JMP_8790:
8790	6A 50             LD	L,50
8792	BE D1 4F          CALL	SUB39
8795	42                DEC	C
8796	8E 02             JR	BRANCH_879A

BRANCH_8798:
8798	DE 3E             EVAL	BRANCH_87D8

BRANCH_879A:
879A	D0 03 3B          INTG	03,BRANCH_87D8
879D	6C 02             CP	H,02
879F	81 35             JR	NC,BRANCH_87D6
87A1	C8 37             LJNES	BRANCH_87DA

SUB_87A3:
87A3	F4 78 99          LDU	(VAR/ARR_PTR_H)
87A6	CC 67             LDS	(67)
87A8	BE DF E2          CALL	SUB85
87AB	81 29             JR	NC,BRANCH_87D6
87AD	4A 3A             LD	C,3A
87AF	48 00             LD	B,00
87B1	BE DF E2          CALL	SUB85
87B4	81 20             JR	NC,BRANCH_87D6
87B6	FD 28             LD	BC,HL
87B8	F4 7A 05          LDU	(MATH_REG_Xa_B6)
87BB	BE DF E2          CALL	SUB85
87BE	83 16             JR	C,BRANCH_87D6
87C0	CC 67             LDS	(67)
87C2	44                INC	BC
87C3	CA A0             STS	(A0)
87C5	F4 7A 05          LDU	(MATH_REG_Xa_B6)
87C8	F6 78 A2          STU	(PREV_LINE_H)
87CB	CC 67             LDS	(67)
87CD	24                LDA	L
87CE	02                ADC	C
87CF	0A                STA	C
87D0	A4                LDA	H
87D1	82                ADC	B
87D2	08                STA	B
87D3	CA A4             STS	(A4)
87D5	9A                RET

BRANCH_87D6:
87D6	68 33             LD	H,33

BRANCH_87D8:
87D8	FB                SCF
87D9	9A                RET

BRANCH_87DA:
87DA	68 01             LD	H,01
87DC	FB                SCF
87DD	9A                RET


JMP_87DE:
87DE	ED 78 57 40       BIT	(SETDEV_VAL),40
87E2	8B 0D             JR	Z,BRANCH_87F1
87E4	6A 0F             LD	L,0F
87E6	FD BE             DI

BRANCH_87E8:
87E8	B5 00             LDA	00
87EA	BE 81 BC          CALL	SUB_81BC
87ED	81 02             JR	NC,BRANCH_87F1
87EF	88 09             DJC	BRANCH_87E8

BRANCH_87F1:
87F1	FD 81             EI
87F3	9A                RET


SEPARATOR_87F4:
87F4	00 FF 00 FF 00 FB 00 FF   00 FF 00 DF 


B_TBL_8800:
8800	55 


B_TBL_8800_TNUM:
8801	09 


B_TBL_8800_NAME:
8802	"LPRT\0D\0D\0D\0D"


B_TBL_8800_INIT:
880A	68 01             LD	H,01
880C	9A                RET


880D	[F0BB],N   "TAB"

B_TBL_8800_INPUT#:
880D	68 1B             LD	H,1B
880F	E0                ERRH


B_TBL_8800_PRINT#:
8810	BA 82 CD          JP	PRINT#2


B_TBL_8800_JMPS:
8813	9A 9A 9A 9A 9A 9A 9A 9A   9A BA 


B_TBL_8800_TRACE:
881D	C4 AF FF          JNE	AF,891F


B_TBL_8800_A_KW:
8820	00 00 


B_TBL_8800_B_KW:
8822	00 00 


B_TBL_8800_C_KW:
8824	88 56 


B_TBL_8800_D_KW:
8826	00 00 


B_TBL_8800_E_KW:
8828	00 00 


B_TBL_8800_F_KW:
882A	88 62 


B_TBL_8800_G_KW:
882C	00 00 


B_TBL_8800_H_KW:
882E	00 00 


B_TBL_8800_I_KW:
8830	00 00 


B_TBL_8800_J_KW:
8832	00 00 


B_TBL_8800_K_KW:
8834	00 00 


B_TBL_8800_L_KW:
8836	88 6B 


B_TBL_8800_M_KW:
8838	00 00 


B_TBL_8800_N_KW:
883A	00 00 


B_TBL_8800_O_KW:
883C	00 00 


B_TBL_8800_P_KW:
883E	00 00 


B_TBL_8800_Q_KW:
8840	00 00 


B_TBL_8800_R_KW:
8842	00 00 


B_TBL_8800_S_KW:
8844	00 00 


B_TBL_8800_T_KW:
8846	88 80 


B_TBL_8800_U_KW:
8848	00 00 


B_TBL_8800_V_KW:
884A	00 00 


B_TBL_8800_W_KW:
884C	00 00 


B_TBL_8800_X_KW:
884E	00 00 


B_TBL_8800_Y_KW:
8850	00 00 


B_TBL_8800_Z_KW:
8852	00 00 


B_TBL_8800_CMD_LST:
8854	D7 "CONSOLE"      F0B1 82D8 
8860	D4 "FEED"         F0B0 82D9 
8869	D6 "LPRINT"       F0B9 82DA 
8874	C5 "LLIST"        F0B8 82DB 
887E	D3 "TAB"          F0BB 880D 


B_TBL_8800_CMD_LST_END:
8886	D0 


SEPARATOR_8887:
8887	D0 00 FF 00 FF 00 FF 00   FF 00 FF 00 


UNKNOWN_CMD_8893:
8893	E9 78 82 00       AND	(STK_PTR_SBR-06/32),00
8897	8E 04             JR	BRANCH_889D


CMD_8899:
8899	EB 78 82 FF       OR	(STK_PTR_SBR-06/32),FF

BRANCH_889D:
889D	5A 2E             LD	E,2E
889F	58 7A             LD	D,7A
88A1	6A 15             LD	L,15
88A3	B5 2C             LDA	2C

BRANCH_88A5:
88A5	53                STD	(DE)
88A6	88 03             DJC	BRANCH_88A5
88A8	A5 78 82          LDA	(STK_PTR_SBR-06/32)
88AB	89 11             JR	NZ,BRANCH_88BE
88AD	BE 8C 4B          CALL	SUB_8C4B
88B0	54                INC	DE
88B1	BE 8C 71          CALL	SUB_8C71
88B4	54                INC	DE
88B5	BE 8C 5F          CALL	SUB_8C5F
88B8	54                INC	DE
88B9	BE 8C 7D          CALL	SUB_8C7D
88BC	8E 25             JR	BRANCH_88E3

BRANCH_88BE:
88BE	A5 78 57          LDA	(SETDEV_VAL)
88C1	2A                STA	L
88C2	A5 79 D1          LDA	(79D1)
88C5	B7 C0             CPA	C0
88C7	8B 02             JR	Z,BRANCH_88CB
88C9	6A 00             LD	L,00

BRANCH_88CB:
88CB	24                LDA	L
88CC	4A D8             LD	C,D8
88CE	48 83             LD	B,83
88D0	6A 04             LD	L,04

BRANCH_88D2:
88D2	F5                LDI
88D3	F5                LDI
88D4	54                INC	DE
88D5	D5                SR
88D6	83 03             JR	C,BRANCH_88DB
88D8	56                DEC	DE
88D9	56                DEC	DE
88DA	56                DEC	DE

BRANCH_88DB:
88DB	44                INC	BC
88DC	88 0C             DJC	BRANCH_88D2
88DE	5E 19             CP	E,19
88E0	81 01             JR	NC,BRANCH_88E3
88E2	56                DEC	DE

BRANCH_88E3:
88E3	14                LDA	E
88E4	FB                SCF
88E5	4A 18             LD	C,18
88E7	00                SBC	C
88E8	48 7A             LD	B,7A
88EA	BE DF A1          CALL	DFA1
88ED	02                ADC	C
88EE	68 00             LD	H,00
88F0	B5 9A             LDA	9A
88F2	ED 78 50 80       BIT	(OUTSTAT_REG),80
88F6	89 09             JR	NZ,BRANCH_8901
88F8	AE 7A 31          STA	(7A31)
88FB	E9 78 55 F7       AND	(CR/LF_REG),F7
88FF	B5 E3             LDA	E3

BRANCH_8901:
8901	AE 7A 30          STA	(SREG)
8904	BA 7A 30          JP	SREG


UNKNOWN_CMD_8907:
8907	BE 89 CB          CALL	UNKNOWN_CMD_8968_ALT_ENTRY
890A	81 02             JR	NC,BRANCH_890E
890C	FD 88             PUSH	BC

BRANCH_890E:
890E	C8 05             LJNES	BRANCH_8915
8910	BE 8A A9          CALL	MAIN_ENTRY_2_ALT_E1
8913	8E 49             JR	BRANCH_895E

BRANCH_8915:
8915	C4 3D 01          JNE	3D,BRANCH_8919
8918	C0                LDW

BRANCH_8919:
8919	C4 2C 04          JNE	2C,BRANCH_8920
891C	C8 10             LJNES	BRANCH_892E
891E	8E 3E             JR	BRANCH_895E

BRANCH_8920:
8920	C6                BKW
8921	BE 8A CF          CALL	MAIN_ENTRY_2_ALT_E3
8924	83 96             JR	C,BRANCH_89BC
8926	C8 02             LJNES	BRANCH_892A
8928	8E 34             JR	BRANCH_895E

BRANCH_892A:
892A	C4 2C 93          JNE	2C,BRANCH_89C0
892D	C0                LDW

BRANCH_892E:
892E	C4 2C 04          JNE	2C,BRANCH_8935
8931	C8 10             LJNES	BRANCH_8943
8933	8E 29             JR	BRANCH_895E

BRANCH_8935:
8935	C6                BKW
8936	BE 8B 02          CALL	SUB_8B02
8939	83 81             JR	C,BRANCH_89BC
893B	C8 02             LJNES	BRANCH_893F
893D	8E 1F             JR	BRANCH_895E

BRANCH_893F:
893F	C4 2C 7E          JNE	2C,BRANCH_89C0
8942	C0                LDW

BRANCH_8943:
8943	C4 2C 05          JNE	2C,894B
8946	C8 6E             LJNES	BRANCH_89B6

BRANCH_894B:
8948	38                NOP
8949	8E 13             JR	BRANCH_895E
894B	C6                BKW
894C	BE 8B 1F          CALL	MAIN_ENTRY_2_ALT_E4
894F	83 6B             JR	C,BRANCH_89BC
8951	C8 02             LJNES	BRANCH_8955
8953	8E 09             JR	BRANCH_895E

BRANCH_8955:
8955	C4 2C 68          JNE	2C,BRANCH_89C0
8958	C8 5C             LJNES	BRANCH_89B6
895A	8E 02             JR	BRANCH_895E

BRANCH_895C:
895C	C8 62             LJNES	BRANCH_89C0

BRANCH_895E:
895E	56                DEC	DE
895F	A5 78 8E          LDA	(TRACE_ON)
8962	CB E2             SBR	Z,(E2)
8964	FD 1A             POP	DE
8966	E2                RST


SEPARATOR_8967:
8967	FF 


UNKNOWN_CMD_8968:
8968	BE 89 CB          CALL	UNKNOWN_CMD_8968_ALT_ENTRY
896B	E9 78 57 E0       AND	(SETDEV_VAL),E0
896F	81 02             JR	NC,BRANCH_8973
8971	FD 88             PUSH	BC

BRANCH_8973:
8973	C8 07             LJNES	BRANCH_897C
8975	B5 60             LDA	60
8977	AE 79 D1          STA	(79D1)
897A	9E 1E             JR	BRANCH_895E

BRANCH_897C:
897C	C4 3D 01          JNE	3D,BRANCH_8980
897F	C0                LDW

BRANCH_8980:
8980	C6                BKW

BRANCH_8981:
8981	4A D8             LD	C,D8
8983	48 83             LD	B,83
8985	C0                LDW
8986	83 34             JR	C,BRANCH_89BC
8988	24                LDA	L
8989	FD C8             PUSH	A
898B	C0                LDW
898C	FD 8A             POP	A
898E	83 2C             JR	C,BRANCH_89BC
8990	28                STA	H

BRANCH_8991:
8991	A4                LDA	H
8992	F7                CPI
8993	89 19             JR	NZ,BRANCH_89AE
8995	24                LDA	L
8996	F7                CPI
8997	89 16             JR	NZ,BRANCH_89AF
8999	05                LDA	(BC)
899A	AB 78 57          OR	(SETDEV_VAL)
899D	AE 78 57          STA	(SETDEV_VAL)
89A0	B5 C0             LDA	C0
89A2	AE 79 D1          STA	(79D1)
89A5	C8 02             LJNES	BRANCH_89A9
89A7	9E 4B             JR	BRANCH_895E

BRANCH_89A9:
89A9	C4 2C 14          JNE	2C,BRANCH_89C0
89AC	9E 2D             JR	BRANCH_8981

BRANCH_89AE:
89AE	44                INC	BC

BRANCH_89AF:
89AF	44                INC	BC
89B0	4E E7             CP	C,E7
89B2	91 23             JR	NC,BRANCH_8991
89B4	8E 06             JR	BRANCH_89BC

BRANCH_89B6:
89B6	C6                BKW
89B7	BE 8B 11          CALL	SUB_8B11
89BA	91 60             JR	NC,BRANCH_895C

BRANCH_89BC:
89BC	68 33             LD	H,33
89BE	8E 02             JR	BRANCH_89C2

BRANCH_89C0:
89C0	68 01             LD	H,01

BRANCH_89C2:
89C2	56                DEC	DE
89C3	A5 78 8E          LDA	(TRACE_ON)
89C6	CB E0             SBR	Z,(E0)
89C8	FD 1A             POP	DE
89CA	E0                ERRH

UNKNOWN_CMD_8968_ALT_ENTRY:
89CB	CD 36             SBR	(36)
89CD	E9 78 8E 00       AND	(TRACE_ON),00
89D1	81 1B             JR	NC,BRANCH_89EE
89D3	FD 98             PUSH	DE
89D5	EB 78 8E FF       OR	(TRACE_ON),FF
89D9	DC                LDPT
89DA	5A 10             LD	E,10
89DC	58 7B             LD	D,7B
89DE	8B 05             JR	Z,BRANCH_89E5
89E0	DF                DEC	A
89E1	2A                STA	L
89E2	F5                LDI
89E3	88 03             DJC	89E2

BRANCH_89E5:
89E5	B5 0D             LDA	0D
89E7	1E                STA	(DE)
89E8	5A 10             LD	E,10
89EA	FD 0A             POP	BC
89EC	FB                SCF
89ED	9A                RET

BRANCH_89EE:
89EE	FD 5A             LD	DE,BC
89F0	9A                RET


SEPARATOR_89F1:
89F1	FF 00 FF 00 


UNKNOWN_CMD_89F5:
89F5	C2 F0 B3 0C       LJNE	F0B3,BRANCH_8A05
89F9	C2 2C 09          LJNE	2C,BRANCH_8A05
89FC	DE 08             EVAL	BRANCH_8A06
89FE	D0 09 05          INTG	09,BRANCH_8A06
8A01	BE 8A 07          CALL	UNKNOWN_CMD_89F5_ALT_E1
8A04	E2                RST

BRANCH_8A05:
8A05	E4                ERR1

BRANCH_8A06:
8A06	E0                ERRH

UNKNOWN_CMD_89F5_ALT_E1:
8A07	B5 0D             LDA	0D
8A09	AE 78 82          STA	(STK_PTR_SBR-06/32)
8A0C	BE 8B 72          CALL	SUB_8B72
8A0F	F4 7A 05          LDU	(MATH_REG_Xa_B6)
8A12	BE E8 8C          CALL	SBRAC
8A15	E9 78 82 00       AND	(STK_PTR_SBR-06/32),00
8A19	BE 8B 72          CALL	SUB_8B72
8A1C	BA 87 DE          JP	JMP_87DE


SEPARATOR_8A1F:
8A1F	FF 


RELOC_CODE_8A20:
8A20	FD BE             DI
8A22	B8                SPV
8A23	A5 A2 97          LDA	(A297)
8A26	A8                RPV
8A27	FD 81             EI
8A29	9A                RET


MAIN_ENTRY_2:
8A2A	B5 9A             LDA	9A
8A2C	AE 79 FA          STA	(UNDEF_REG_79FA)
8A2F	FD EB D0 08 80    OR#	(CE158_PRT_C),80
8A34	FD 88             PUSH	BC
8A36	4A 29             LD	C,29
8A38	48 8A             LD	B,8A
8A3A	6A 2F             LD	L,2F
8A3C	68 7A             LD	H,7A

BRANCH_8A3E:
8A3E	47                LDD	(BC)
8A3F	2E                STA	(HL)
8A40	62                DEC	L
8A41	6E 26             CP	L,26
8A43	93 07             JR	C,BRANCH_8A3E
8A45	4A 56             LD	C,56
8A47	48 78             LD	B,78
8A49	49 1F             AND	(BC),1F
8A4B	BE 7A 26          CALL	MATH_REG_Va_B7
8A4E	89 02             JR	NZ,BRANCH_8A52
8A50	4B 20             OR	(BC),20

BRANCH_8A52:
8A52	B7 6D             CPA	6D
8A54	89 02             JR	NZ,BRANCH_8A58
8A56	4B 40             OR	(BC),40

BRANCH_8A58:
8A58	FD 2A             POP	HL
8A5A	68 D0             LD	H,D0
8A5C	ED 79 DE 10       BIT	(UNDEF_REG_79DE),10
8A60	8B 19             JR	Z,BRANCH_8A7B
8A62	4D 20             BIT	(BC),20
8A64	8B 83             JR	Z,BRANCH_8AE9
8A66	6A 0D             LD	L,0D
8A68	B5 7F             LDA	7F
8A6A	FD 2E             STA#	(HL)
8A6C	66                DEC	HL
8A6D	B5 C3             LDA	C3
8A6F	FD 2E             STA#	(HL)
8A71	66                DEC	HL
8A72	66                DEC	HL
8A73	FD 69 00          AND#	(HL),00
8A76	AE 78 8E          STA	(TRACE_ON)
8A79	8E 25             JR	BRANCH_8AA0

BRANCH_8A7B:
8A7B	EB 79 DE 10       OR	(UNDEF_REG_79DE),10
8A7F	B5 FE             LDA	FE
8A81	6E D0             CP	L,D0
8A83	89 05             JR	NZ,BRANCH_8A8A
8A85	A5 7A 20          LDA	(VREG)
8A88	B9 01             AND	01

BRANCH_8A8A:
8A8A	AE 78 8E          STA	(TRACE_ON)
8A8D	4A B0             LD	C,B0
8A8F	48 83             LD	B,83
8A91	6A 0F             LD	L,0F

BRANCH_8A93:
8A93	45                LDI	(BC)
8A94	FD 2E             STA#	(HL)
8A96	62                DEC	L
8A97	6E 07             CP	L,07
8A99	93 08             JR	C,BRANCH_8A93
8A9B	6A 56             LD	L,56
8A9D	BE 9F 75          CALL	SUB_9F75

BRANCH_8AA0:
8AA0	BE 9F D0          CALL	SUB_9FD0
8AA3	ED 78 8E 01       BIT	(TRACE_ON),01
8AA7	89 94             JR	NZ,BRANCH_8B3D

MAIN_ENTRY_2_ALT_E1:
8AA9	B5 99             LDA	99
8AAB	8E 8D             JR	BRANCH_8B3A

MAIN_ENTRY_2_ALT_E2:
8AAD	A5 78 B6          LDA	(ERROR_TOP_H)
8AB0	FB                SCF
8AB1	B1 16             SBC	16
8AB3	81 0D             JR	NC,BRANCH_8AC2
8AB5	B7 0A             CPA	0A
8AB7	83 0D             JR	C,BRANCH_8AC6
8AB9	BE 86 F6          CALL	SUB_86F0_ALT_E1
8ABC	05                LDA	(BC)
8ABD	05                LDA	(BC)
8ABE	10                SBC	E
8ABF	42                DEC	C
8AC0	5E 4F             CP	E,4F

BRANCH_8AC2:
8AC2	9A                RET
8AC3	BA 87 90          JP	JMP_8790

BRANCH_8AC6:
8AC6	04                LDA	C
8AC7	10                SBC	E
8AC8	FD 18             LD	BC,DE
8ACA	CD 24             SBR	(24)
8ACC	BA CE D0          JP	TXFR_RSV_KEY

MAIN_ENTRY_2_ALT_E3:
8ACF	6A 50             LD	L,50
8AD1	BE D1 4F          CALL	SUB39
8AD4	56                DEC	DE
8AD5	D0 06 53          INTG	06,BRANCH_8B2B
8AD8	4A C0             LD	C,C0
8ADA	48 83             LD	B,83

BRANCH_8ADC:
8ADC	45                LDI	(BC)
8ADD	A6                CPA	H
8ADE	89 04             JR	NZ,BRANCH_8AE4
8AE0	05                LDA	(BC)
8AE1	26                CPA	L
8AE2	8B 06             JR	Z,BRANCH_8AEA

BRANCH_8AE4:
8AE4	44                INC	BC
8AE5	4E D0             CP	C,D0
8AE7	91 0D             JR	NC,BRANCH_8ADC

BRANCH_8AE9:
8AE9	9A                RET

BRANCH_8AEA:
8AEA	04                LDA	C
8AEB	B1 C1             SBC	C1
8AED	F1                AEX
8AEE	E9 78 58 1F       AND	(SETCOM_REG),1F
8AF2	8E 43             JR	BRANCH_8B37
8AF4	6A 50             LD	L,50
8AF6	BE D1 4F          CALL	SUB39
8AF9	31                SBC	(MN)
8AFA	D0 08 2E          INTG	08,BRANCH_8B2B
8AFD	AE 78 B9          STA	(ON_ERR_ADD_H)
8B00	F9                RCF
8B01	9A                RET

SUB_8B02:
8B02	CD 02 35 39 24    SBR	(02),35,39,BRANCH_8B2B
8B07	B1 34             SBC	34
8B09	F1                AEX
8B0A	D5                SR
8B0B	E9 78 58 E7       AND	(SETCOM_REG),E7
8B0F	8E 26             JR	BRANCH_8B37

SUB_8B11:
8B11	CD 02 31 33 15    SBR	(02),31,33,BRANCH_8B2B
8B16	B9 02             AND	02
8B18	D9                SL
8B19	E9 78 58 FB       AND	(SETCOM_REG),FB
8B1D	8E 18             JR	BRANCH_8B37

MAIN_ENTRY_2_ALT_E4:
8B1F	C0                LDW
8B20	83 09             JR	C,BRANCH_8B2B
8B22	CD 34 02 4E 07    SBR	(34),02,4E,BRANCH_8B2E,45,BRANCH_8B2F,4F,BRANCH_8B2D
	45 06 4F 02 

BRANCH_8B2B:
8B2B	FB                SCF
8B2C	9A                RET


BRANCH_8B2D:
8B2D	F9                RCF

BRANCH_8B2E:
8B2E	F9                RCF

BRANCH_8B2F:
8B2F	FB                SCF
8B30	04                LDA	C
8B31	B1 2D             SBC	2D
8B33	E9 78 58 FC       AND	(SETCOM_REG),FC


BRANCH_8B37:
8B37	AB 78 58          OR	(SETCOM_REG)

BRANCH_8B3A:
8B3A	AE 78 58          STA	(SETCOM_REG)

BRANCH_8B3D:
8B3D	E9 78 82 00       AND	(STK_PTR_SBR-06/32),00
8B41	BE 8B 72          CALL	SUB_8B72
8B44	A5 78 58          LDA	(SETCOM_REG)
8B47	F1                AEX
8B48	B9 0E             AND	0E
8B4A	D5                SR
8B4B	4A D0             LD	C,D0
8B4D	48 83             LD	B,83
8B4F	FD CA             ADD	BC
8B51	05                LDA	(BC)
8B52	FD EB D0 0C C0    OR#	(CE158_PRT_A_DIR),C0
8B57	FB                SCF
8B58	D1                RR
8B59	83 07             JR	C,BRANCH_8B62
8B5B	FD E9 D0 0E 7F    AND#	(CE158_PRT_A),7F
8B60	8E 05             JR	BRANCH_8B67

BRANCH_8B62:
8B62	FD EB D0 0E 80    OR#	(CE158_PRT_A),80

BRANCH_8B67:
8B67	FD AE D0 08       STA#	(CE158_PRT_C)
8B6B	FD E9 D0 0E BF    AND#	(CE158_PRT_A),BF
8B70	F9                RCF
8B71	9A                RET


SUB_8B72:
8B72	6A 01             LD	L,01
8B74	FD BE             DI
8B76	68 D2             LD	H,D2
8B78	A5 78 57          LDA	(SETDEV_VAL)
8B7B	D9                SL
8B7C	DB                RL
8B7D	83 3C             JR	C,BRANCH_8BBB
8B7F	D1                RR
8B80	A5 78 58          LDA	(SETCOM_REG)
8B83	B9 1F             AND	1F
8B85	48 83             LD	B,83
8B87	81 23             JR	NC,BRANCH_8BAC
8B89	ED 78 82 0D       BIT	(STK_PTR_SBR-06/32),0D
8B8D	8B 05             JR	Z,BRANCH_8B94
8B8F	A5 78 82          LDA	(STK_PTR_SBR-06/32)
8B92	8E 13             JR	BRANCH_8BA7

BRANCH_8B94:
8B94	FD EB D0 08 80    OR#	(CE158_PRT_C),80
8B99	4A E7             LD	C,E7
8B9B	FD E9 D0 08 7F    AND#	(CE158_PRT_C),7F
8BA0	FD CA             ADD	BC
8BA2	05                LDA	(BC)
8BA3	FD 2E             STA#	(HL)
8BA5	B5 50             LDA	50

BRANCH_8BA7:
8BA7	FD 2E             STA#	(HL)
8BA9	FD 81             EI
8BAB	9A                RET

BRANCH_8BAC:
8BAC	4A 07             LD	C,07
8BAE	FD CA             ADD	BC
8BB0	05                LDA	(BC)
8BB1	ED 78 82 08       BIT	(STK_PTR_SBR-06/32),08
8BB5	99 10             JR	NZ,BRANCH_8BA7
8BB7	BB 60             OR	60
8BB9	9E 14             JR	BRANCH_8BA7

BRANCH_8BBB:
8BBB	A5 78 58          LDA	(SETCOM_REG)
8BBE	B9 1F             AND	1F
8BC0	ED 78 82 0D       BIT	(STK_PTR_SBR-06/32),0D
8BC4	8B 02             JR	Z,BRANCH_8BC8
8BC6	BB 40             OR	40

BRANCH_8BC8:
8BC8	FD 2E             STA#	(HL)
8BCA	BB 80             OR	80
8BCC	9E 27             JR	BRANCH_8BA7


SUB_8BCE:
8BCE	A5 78 B6          LDA	(ERROR_TOP_H)
8BD1	BE 87 0B          CALL	SUB_870B
8BD4	BE 86 F0          CALL	SUB_86F0
8BD7	12                ADC	E
8BD8	1C                DSBC	(DE)
8BD9	1E                STA	(DE)
8BDA	1B                OR	(DE)
8BDB	18                STA	D
8BDC	1A                STA	E
8BDD	1B                OR	(DE)
8BDE	67                LDD	(HL)
8BDF	6B 90             OR	(HL),90
8BE1	7D 9A             BIT	(MN),9A
8BE3	2D                XOR	(HL)
8BE4	3C                DSBC	(MN)
8BE5	3B                OR	(MN)
8BE6	3A                STA	N
8BE7	39                AND	(MN)
8BE8	38                NOP
8BE9	2D                XOR	(HL)
8BEA	48 85             LD	B,85
8BEC	4A 60             LD	C,60
8BEE	6A 06             LD	L,06

BRANCH_8BF0:
8BF0	F5                LDI
8BF1	88 03             DJC	BRANCH_8BF0
8BF3	9A                RET

8BF4	F9                RCF
8BF5	F9                RCF
8BF6	F9                RCF
8BF7	F9                RCF
8BF8	F9                RCF
8BF9	FB                SCF
8BFA	04                LDA	C
8BFB	B1 F4             SBC	F4
8BFD	2A                STA	L
8BFE	A5 78 B4          LDA	(ERRORLINE)
8C01	F1                AEX
8C02	D9                SL
8C03	88 03             DJC	8C02
8C05	B5 4F             LDA	4F
8C07	51                STI	(DE)
8C08	B5 4E             LDA	4E
8C0A	83 03             JR	C,8C0F
8C0C	B5 46             LDA	46
8C0E	51                STI	(DE)
8C0F	51                STI	(DE)
8C10	9A                RET
8C11	B5 08             LDA	08
8C13	AE 78 84          STA	(CUR_VAR_ADD_L)
8C16	9A                RET
8C17	B5 46             LDA	46
8C19	51                STI	(DE)
8C1A	B5 36             LDA	36
8C1C	51                STI	(DE)
8C1D	B5 07             LDA	07
8C1F	9E 0E             JR	8C13
8C21	B5 46             LDA	46
8C23	51                STI	(DE)
8C24	A5 78 B6          LDA	(ERROR_TOP_H)
8C27	D5                SR
8C28	FB                SCF
8C29	B1 10             SBC	10
8C2B	AE 78 84          STA	(CUR_VAR_ADD_L)
8C2E	BB 30             OR	30
8C30	51                STI	(DE)
8C31	B5 3D             LDA	3D
8C33	51                STI	(DE)
8C34	CD 38             SBR	(38)
8C36	BE CE C4          CALL	SUB12
8C39	91 25             JR	NC,8C16
8C3B	45                LDI	(BC)
8C3C	BF E0             BIT	E0
8C3E	9B 2A             JR	Z,8C16
8C40	51                STI	(DE)
8C41	5E FD             CP	E,FD
8C43	91 0A             JR	NC,8C3B
8C45	9A                RET
8C46	F4 78 A2          LDU	(PREV_LINE_H)
8C49	8E 10             JR	8C5B


SUB_8C4B:
8C4B	A5 78 58          LDA	(SETCOM_REG)
8C4E	B9 E0             AND	E0
8C50	F1                AEX
8C51	4A C0             LD	C,C0
8C53	48 83             LD	B,83
8C55	FD CA             ADD	BC
8C57	45                LDI	(BC)
8C58	28                STA	H
8C59	05                LDA	(BC)
8C5A	2A                STA	L
8C5B	CD 10 40          SBR	(10),40
8C5E	9A                RET


SUB_8C5F:
8C5F	A5 78 58          LDA	(SETCOM_REG)
8C62	6A 4E             LD	L,4E
8C64	D5                SR
8C65	83 07             JR	C,BRANCH_8C6E
8C67	6A 45             LD	L,45
8C69	D5                SR
8C6A	83 02             JR	C,BRANCH_8C6E
8C6C	6A 4F             LD	L,4F

BRANCH_8C6E:
8C6E	24                LDA	L
8C6F	51                STI	(DE)
8C70	9A                RET


SUB_8C71:
8C71	A5 78 58          LDA	(SETCOM_REG)
8C74	B9 18             AND	18
8C76	F1                AEX
8C77	D9                SL
8C78	6A 35             LD	L,35
8C7A	22                ADC	L
8C7B	51                STI	(DE)
8C7C	9A                RET


SUB_8C7D:
8C7D	B5 31             LDA	31
8C7F	ED 78 58 04       BIT	(SETCOM_REG),04
8C83	8B 01             JR	Z,BRANCH_8C86
8C85	DD                INC	A

BRANCH_8C86:
8C86	51                STI	(DE)
8C87	9A                RET


UNKNOWN_CMD_8C88:
8C88	E9 78 55 7F       AND	(CR/LF_REG),7F
8C8C	8E 09             JR	BRANCH_8C97

UNKNOWN_CMD_8C8E:
8C8E	EB 78 55 80       OR	(CR/LF_REG),80
8C92	B5 92             LDA	92
8C94	BE 8B 3A          CALL	BRANCH_8B3A

BRANCH_8C97:
8C97	C8 63             LJNES	BRANCH_8CFC
8C99	F4 78 99          LDU	(VAR/ARR_PTR_H)
8C9C	CC 67             LDS	(67)
8C9E	BE DF E1          CALL	DFE1
8CA1	81 56             JR	NC,BRANCH_8CF9
8CA3	4A 3A             LD	C,3A
8CA5	48 00             LD	B,00
8CA7	BE DF E2          CALL	SUB85
8CAA	81 4D             JR	NC,BRANCH_8CF9
8CAC	6C 02             CP	H,02
8CAE	81 49             JR	NC,BRANCH_8CF9
8CB0	F6 7A 05          STU	(MATH_REG_Xa_B6)
8CB3	BE 87 A3          CALL	SUB_87A3
8CB6	C3 E0             SBR	C,(E0)
8CB8	FD E9 F0 0A 00    AND#	(PC1500_MSK_REG),00
8CBD	BE 81 E6          CALL	SUB_81E6
8CC0	B5 04             LDA	04
8CC2	AE 78 95          STA	(USING_F/F)
8CC5	CC 5D             LDS	(5D)
8CC7	CA BE             STS	(BE)
8CC9	6A 40             LD	L,40
8CCB	68 11             LD	H,11
8CCD	F6 76 4E          STU	(HIGHLCDFLAG)
8CD0	CC 99             LDS	(99)
8CD2	B5 C6             LDA	C6
8CD4	FD CA             ADD	BC
8CD6	FD 42             DEC	B
8CD8	CA 93             STS	(93)
8CDA	BE 8F C1          CALL	SUB_8FC1
8CDD	A5 78 56          LDA	(ZONE_REG)
8CE0	B9 60             AND	60
8CE2	D5                SR
8CE3	BB 0A             OR	0A
8CE5	ED 78 55 80       BIT	(CR/LF_REG),80
8CE9	8B 02             JR	Z,BRANCH_8CED
8CEB	B3 03             ADC	03

BRANCH_8CED:
8CED	AE 78 B4          STA	(ERRORLINE)
8CF0	68 99             LD	H,99
8CF2	6A AA             LD	L,AA
8CF4	F6 79 FB          STU	(UNDEF_REG_79FB)
8CF7	8E 10             JR	BRANCH_8D09

BRANCH_8CF9:
8CF9	68 33             LD	H,33
8CFB	E0                ERRH

BRANCH_8CFC:
8CFC	E4                ERR1


JMP_8CFD:
8CFD	B5 04             LDA	04
8CFF	8E 0A             JR	SUB_8D04_ALT_E1
8D01	A4                LDA	H
8D02	99 07             JR	NZ,JMP_8CFD


SUB_8D04:
8D04	FD E9 F0 0B FD    AND#	(PC1500_IF_REG),FD

BRANCH_8D09:
8D09	B5 00             LDA	00

SUB_8D04_ALT_E1:
8D0B	FD E9 F0 0A FC    AND#	(PC1500_MSK_REG),FC
8D10	BE 9F D0          CALL	SUB_9FD0
8D13	FD C8             PUSH	A
8D15	B5 9A             LDA	9A
8D17	AE 79 FA          STA	(UNDEF_REG_79FA)
8D1A	FB                SCF
8D1B	BE 8F C2          CALL	8FC2
8D1E	FD E9 B0 0F BF    AND#	(CE150_PRT_B),BF
8D23	FD EB B0 0D 40    OR#	(CE150_PRT_B_DIR),40
8D28	BE 9F EF          CALL	SUB_9FEF
8D2B	FD E9 D0 0A FD    AND#	(CE158_MSK_REG),FD
8D30	FD EB F0 0A 01    OR#	(PC1500_MSK_REG),01
8D35	6A 4E             LD	L,4E
8D37	68 76             LD	H,76
8D39	6B 01             OR	(HL),01
8D3B	69 7D             AND	(HL),7D
8D3D	64                INC	HL
8D3E	69 70             AND	(HL),70
8D40	BE D0 34          CALL	SUB25
8D43	FD 8A             POP	A
8D45	BE 87 36          CALL	SUB_8736
8D48	6A 3F             LD	L,3F
8D4A	68 00             LD	H,00
8D4C	BE E8 8C          CALL	SBRAC

BRANCH_8D4F:
8D4F	FD C1             SDP
8D51	BE D0 34          CALL	SUB25
8D54	A5 78 95          LDA	(USING_F/F)
8D57	6A 17             LD	L,17
8D59	D5                SR
8D5A	83 0F             JR	C,BRANCH_8D6B
8D5C	6A 01             LD	L,01
8D5E	D5                SR
8D5F	83 0A             JR	C,BRANCH_8D6B
8D61	6A 18             LD	L,18
8D63	D5                SR
8D64	83 05             JR	C,BRANCH_8D6B
8D66	60                INC	L
8D67	D5                SR
8D68	83 01             JR	C,BRANCH_8D6B
8D6A	60                INC	L

BRANCH_8D6B:
8D6B	24                LDA	L
8D6C	D9                SL
8D6D	BE 87 36          CALL	SUB_8736

BRANCH_8D70:
8D70	BE 99 8D          CALL	SUB_998D
8D73	AA 78 4F          LD	SP,SYSTEMSTACKBASE
8D76	B7 14             CPA	14
8D78	81 22             JR	NC,BRANCH_8D9C
8D7A	B7 17             CPA	17
8D7C	83 1E             JR	C,BRANCH_8D9C
8D7E	B1 16             SBC	16
8D80	2A                STA	L
8D81	A5 78 95          LDA	(USING_F/F)
8D84	B9 1F             AND	1F

BRANCH_8D86:
8D86	60                INC	L
8D87	60                INC	L
8D88	60                INC	L
8D89	D5                SR
8D8A	83 02             JR	C,BRANCH_8D8E
8D8C	99 08             JR	NZ,BRANCH_8D86

BRANCH_8D8E:
8D8E	24                LDA	L
8D8F	6A D9             LD	L,D9
8D91	68 8D             LD	H,8D
8D93	D9                SL
8D94	FD EA             ADD	HL
8D96	65                LDI	(HL)
8D97	08                STA	B
8D98	25                LDA	(HL)
8D99	0A                STA	C
8D9A	FD 5E             LD	PC,BC

BRANCH_8D9C:
8D9C	CD 34 06 09 EB    SBR	(34),06,09,BRANCH_8E8C,0A,8DBB,0B,BRANCH_8DCA,0E,BRANCH_8DB9,13,BRANCH_8DAF,19,BRANCH_8E91,5B,BRANCH_8DD5
	0A 18 0B 25 0E 
	12 13 06 19 E6 
	5B 28 
8DAD	9E 3F             JR	BRANCH_8D70


BRANCH_8DAF:
8DAF	B5 14             LDA	14
8DB1	ED 78 95 10       BIT	(USING_F/F),10
8DB5	9B 47             JR	Z,BRANCH_8D70
8DB7	8E 6A             JR	BRANCH_8E23

BRANCH_8DB9:
8DB9	9E B7             JR	SUB_8D04
8DBB	A5 78 95          LDA	(USING_F/F)
8DBE	B9 0F             AND	0F
8DC0	D5                SR
8DC1	89 02             JR	NZ,BRANCH_8DC5
8DC3	B5 08             LDA	08

BRANCH_8DC5:
8DC5	AE 78 95          STA	(USING_F/F)
8DC8	9E 7B             JR	BRANCH_8D4F

BRANCH_8DCA:
8DCA	A5 78 95          LDA	(USING_F/F)
8DCD	D9                SL
8DCE	B9 0F             AND	0F
8DD0	99 0D             JR	NZ,BRANCH_8DC5
8DD2	DD                INC	A
8DD3	9E 10             JR	BRANCH_8DC5

BRANCH_8DD5:
8DD5	B5 10             LDA	10
8DD7	9E 14             JR	BRANCH_8DC5


BRANCH_TBL_8DD9:
8DD9	8E 97 8E 9B 8E A8 8E 1A   8E 1C 8E 1E 8E 31 8E 32 
8DE9	8D F7 8E 1D 8E 17 8D 70   8E 1B 8E 18 8E 19 


BRANCH_8DF7:
8DF7	6A 43             LD	L,43
8DF9	68 40             LD	H,40
8DFB	F6 76 4E          STU	(HIGHLCDFLAG)
8DFE	CC BE             LDS	(BE)
8E00	CA 5D             STS	(5D)
8E02	BE 8A 2A          CALL	MAIN_ENTRY_2
8E05	FD E9 B0 0D BF    AND#	(CE150_PRT_B_DIR),BF
8E0A	FD EB F0 0A 01    OR#	(PC1500_MSK_REG),01
8E0F	FD EB B0 0A 03    OR#	(CE150_MSK_REG),03
8E14	BA CA 55          JP	CA55

BRANCH_8E17:
8E17	F9                RCF

BRANCH_8E18:
8E18	F9                RCF

BRANCH_8E19:
8E19	F9                RCF

BRANCH_8E1A:
8E1A	F9                RCF

BRANCH_8E1B:
8E1B	F9                RCF

BRANCH_8E1C:
8E1C	F9                RCF

BRANCH_8E1D:
8E1D	F9                RCF

BRANCH_8E1E:
8E1E	B5 12             LDA	12
8E20	FD CA             ADD	BC
8E22	05                LDA	(BC)

BRANCH_8E23:
8E23	AE 78 B6          STA	(ERROR_TOP_H)
8E26	BA 8E EF          JP	BRANCH_8EEF


TBL_8E29:
8E29	0A 10 12 20 0C 22 0E 16   


BRANCH_8E31:
8E31	F9                RCF

BRANCH_8E32:
8E32	FD 88             PUSH	BC
8E34	BE 8A 2A          CALL	MAIN_ENTRY_2
8E37	BE 8F C1          CALL	SUB_8FC1
8E3A	B5 02             LDA	02
8E3C	AE 79 F4          STA	(79F4)
8E3F	B5 00             LDA	00
8E41	AE 79 EA          STA	(79EA)
8E44	AE 79 F2          STA	(79F2)
8E47	BE 9C 92          CALL	SUB_9C92
8E4A	48 D8             LD	B,D8
8E4C	4A B0             LD	C,B0
8E4E	CA B2             STS	(B2)
8E50	6A 02             LD	L,02
8E52	BA 83 80          JP	JMP_8380

JMP_8E55:
8E55	CC A0             LDS	(A0)
8E57	CA A6             STS	(A6)
8E59	EB 78 A8 80       OR	(78A8),80
8E5D	F4 78 A2          LDU	(PREV_LINE_H)
8E60	66                DEC	HL
8E61	BE D3 C5          CALL	D3C5
8E64	BE 98 E8          CALL	SUB_98E8
8E67	FD 0A             POP	BC
8E69	4E 32             CP	C,32
8E6B	89 56             JR	NZ,BRANCH_8EC3
8E6D	B5 08             LDA	08
8E6F	AE 78 84          STA	(CUR_VAR_ADD_L)

BRANCH_8E72:
8E72	CD 38             SBR	(38)
8E74	BE CE C4          CALL	SUB12
8E77	81 4A             JR	NC,BRANCH_8EC3
8E79	FD 88             PUSH	BC
8E7B	BE 87 80          CALL	SUB_876C_ALT_E1
8E7E	6A 40             LD	L,40
8E80	68 00             LD	H,00
8E82	BE E8 8C          CALL	SBRAC
8E85	FD 0A             POP	BC
8E87	BE 87 45          CALL	SUB_8745
8E8A	8E 37             JR	BRANCH_8EC3

BRANCH_8E8C:
8E8C	BE 96 00          CALL	SUB_9600
8E8F	8E 03             JR	BRANCH_8E94

BRANCH_8E91:
8E91	BE 95 C6          CALL	SUB_95C6

BRANCH_8E94:
8E94	BA 8D 70          JP	BRANCH_8D70

BRANCH_8E97:
8E97	6A 40             LD	L,40
8E99	8E 0F             JR	BRANCH_8EAA

BRANCH_8E9B:
8E9B	6A 20             LD	L,20
8E9D	B5 FE             LDA	FE
8E9F	AE 78 AE          STA	(78AE)
8EA2	E9 78 AF 00       AND	(78AF),00
8EA6	8E 02             JR	BRANCH_8EAA

BRANCH_8EA8:
8EA8	6A 10             LD	L,10

BRANCH_8EAA:
8EAA	24                LDA	L
8EAB	AE 76 4F          STA	(LOWLCDFLAG)
8EAE	9E 1C             JR	BRANCH_8E94
8EB0	B5 80             LDA	80
8EB2	AD 78 B4          XOR	(ERRORLINE)
8EB5	BF 80             BIT	80
8EB7	8B 04             JR	Z,BRANCH_8EBD
8EB9	BF 40             BIT	40
8EBB	9B 29             JR	Z,BRANCH_8E94

BRANCH_8EBD:
8EBD	AE 78 B4          STA	(ERRORLINE)
8EC0	BA 8D 70          JP	BRANCH_8D70

BRANCH_8EC3:
8EC3	BE 87 6C          CALL	SUB_876C
8EC6	E9 78 B1 00       AND	(78B1),00
8ECA	BE 98 02          CALL	SUB_9802
8ECD	FD EB F0 0A 01    OR#	(PC1500_MSK_REG),01
8ED2	B5 BA             LDA	BA
8ED4	AE 79 FA          STA	(UNDEF_REG_79FA)
8ED7	BA 96 87          JP	SUB_INPUT#_ALT_E1

BRANCH_8EDA:
8EDA	BE 8A AD          CALL	MAIN_ENTRY_2_ALT_E2
8EDD	B5 06             LDA	06
8EDF	81 03             JR	NC,BRANCH_8EE4

BRANCH_8EE1:
8EE1	BA 8D 0B          JP	SUB_8D04_ALT_E1

BRANCH_8EE4:
8EE4	E9 78 B6 FE       AND	(ERROR_TOP_H),FE
8EE8	A5 78 B6          LDA	(ERROR_TOP_H)
8EEB	B7 20             CPA	20
8EED	9B 0E             JR	Z,BRANCH_8EE1

BRANCH_8EEF:
8EEF	BE 8B CE          CALL	SUB_8BCE

BRANCH_8EF2:
8EF2	14                LDA	E
8EF3	AE 78 8B          STA	(788B)
8EF6	B5 40             LDA	40
8EF8	AE 78 80          STA	(7880)
8EFB	BE D0 21          CALL	D021

BRANCH_8EFE:
8EFE	BE E8 CA          CALL	PRGMDISP
8F01	BE 99 8D          CALL	SUB_998D
8F04	AA 78 4F          LD	SP,SYSTEMSTACKBASE
8F07	B7 20             CPA	20
8F09	81 07             JR	NC,BRANCH_8F12

BRANCH_8F0B:
8F0B	1E                STA	(DE)
8F0C	50                INC	E
8F0D	91 11             JR	NC,BRANCH_8EFE
8F0F	52                DEC	E
8F10	9E 14             JR	BRANCH_8EFE

BRANCH_8F12:
8F12	CD 34 03 0D 26    SBR	(34),03,0D,BRANCH_8F3D,0A,BRANCH_8F32,0E,BRANCH_8F1F,08,BRANCH_8F22
	0A 19 0E 04 08 
	05 
8F1D	9E 21             JR	BRANCH_8EFE

BRANCH_8F1F:
8F1F	BA 8D 04          JP	SUB_8D04

BRANCH_8F22:
8F22	A5 78 8B          LDA	(788B)
8F25	16                CPA	E
8F26	9B 2A             JR	Z,BRANCH_8EFE
8F28	52                DEC	E
8F29	B5 0D             LDA	0D
8F2B	1E                STA	(DE)
8F2C	EB 7B 0E 40       OR	(7B0E),40
8F30	9E 34             JR	BRANCH_8EFE

BRANCH_8F32:
8F32	B5 21             LDA	21
8F34	A7 78 B6          CPA	(ERROR_TOP_H)
8F37	89 04             JR	NZ,BRANCH_8F3D
8F39	B5 40             LDA	40
8F3B	9E 32             JR	BRANCH_8F0B

BRANCH_8F3D:
8F3D	14                LDA	E
8F3E	0A                STA	C
8F3F	A5 78 8B          LDA	(788B)
8F42	1A                STA	E
8F43	15                LDA	(DE)
8F44	B7 0D             CPA	0D
8F46	89 1E             JR	NZ,BRANCH_8F66

BRANCH_8F48:
8F48	A5 78 B6          LDA	(ERROR_TOP_H)
8F4B	DD                INC	A
8F4C	BF 01             BIT	01
8F4E	8B 01             JR	Z,BRANCH_8F51
8F50	DD                INC	A

BRANCH_8F51:
8F51	AE 78 B6          STA	(ERROR_TOP_H)
8F54	B7 18             CPA	18
8F56	81 2E             JR	NC,BRANCH_8F86
8F58	B7 20             CPA	20
8F5A	8B 2A             JR	Z,BRANCH_8F86
8F5C	B7 22             CPA	22
8F5E	8B 26             JR	Z,BRANCH_8F86
8F60	B7 2E             CPA	2E
8F62	83 22             JR	C,BRANCH_8F86
8F64	9E 77             JR	BRANCH_8EEF

BRANCH_8F66:
8F66	ED 78 B6 01       BIT	(ERROR_TOP_H),01
8F6A	99 92             JR	NZ,BRANCH_8EDA
8F6C	55                LDI	(DE)
8F6D	B7 59             CPA	59
8F6F	8B 18             JR	Z,BRANCH_8F89
8F71	B7 4E             CPA	4E
8F73	89 11             JR	NZ,BRANCH_8F86
8F75	A5 78 B6          LDA	(ERROR_TOP_H)
8F78	B7 16             CPA	16
8F7A	83 37             JR	C,BRANCH_8FB3
8F7C	BE 86 F0          CALL	SUB_86F0
8F7F	06                CPA	C
8F80	21                SBC	(HL)
8F81	24                LDA	L
8F82	27                CPA	(HL)
8F83	16                CPA	E
8F84	19                AND	(DE)
8F85	10                SBC	E

BRANCH_8F86:
8F86	BA 8D 4F          JP	BRANCH_8D4F

BRANCH_8F89:
8F89	A5 78 B6          LDA	(ERROR_TOP_H)
8F8C	B7 16             CPA	16
8F8E	91 0A             JR	NC,BRANCH_8F86
8F90	B7 20             CPA	20
8F92	83 23             JR	C,BRANCH_8FB7
8F94	9E 4E             JR	BRANCH_8F48
8F96	B5 40             LDA	40
8F98	8E 12             JR	BRANCH_8FAC
8F9A	B5 08             LDA	08
8F9C	8E 0E             JR	BRANCH_8FAC
8F9E	B5 01             LDA	01
8FA0	8E 0A             JR	BRANCH_8FAC
8FA2	B5 04             LDA	04
8FA4	8E 06             JR	BRANCH_8FAC
8FA6	B5 80             LDA	80
8FA8	8E 02             JR	BRANCH_8FAC
8FAA	B5 02             LDA	02

BRANCH_8FAC:
8FAC	AD 78 B4          XOR	(ERRORLINE)
8FAF	AE 78 B4          STA	(ERRORLINE)
8FB2	9A                RET


BRANCH_8FB3:
8FB3	B7 20             CPA	20
8FB5	93 31             JR	C,BRANCH_8F86

BRANCH_8FB7:
8FB7	EF 78 B6 01       ADD	(ERROR_TOP_H),01
8FBB	B5 20             LDA	20
8FBD	51                STI	(DE)
8FBE	BA 8E F2          JP	BRANCH_8EF2

SUB_8FC1:
8FC1	F9                RCF
8FC2	CC 93             LDS	(93)
8FC4	B5 1A             LDA	1A
8FC6	FD CA             ADD	BC
8FC8	83 08             JR	C,BRANCH_8FD2
8FCA	FD 5A             LD	DE,BC
8FCC	4A 50             LD	C,50
8FCE	48 77             LD	B,77
8FD0	8E 04             JR	BRANCH_8FD6

BRANCH_8FD2:
8FD2	5A 50             LD	E,50
8FD4	58 77             LD	D,77

BRANCH_8FD6:
8FD6	6A 1F             LD	L,1F

BRANCH_8FD8:
8FD8	F5                LDI
8FD9	88 03             DJC	BRANCH_8FD8
8FDB	9A                RET

8FDC	5A 50             LD	E,50
8FDE	58 FD             LD	D,FD


JMP_8FE0:
8FE0	FD C1             SDP
8FE2	AA 78 4F          LD	SP,SYSTEMSTACKBASE
8FE5	BE 97 BA          CALL	SUB_97BA
8FE8	81 4F             JR	NC,BRANCH_9039
8FEA	BA 92 3E          JP	SUB_PRINT#_ALT_E1

SUB_8FED:
8FED	6E 0E             CP	L,0E
8FEF	89 03             JR	NZ,BRANCH_8FF4
8FF1	BA 8D 04          JP	SUB_8D04

BRANCH_8FF4:
8FF4	E9 76 4E 7F       AND	(HIGHLCDFLAG),7F
8FF8	B5 02             LDA	02
8FFA	68 7F             LD	H,7F
8FFC	6E 01             CP	L,01
8FFE	8B 27             JR	Z,BRANCH_9027
9000	B5 00             LDA	00
9002	6E 1B             CP	L,1B
9004	8B 21             JR	Z,BRANCH_9027
9006	6E 02             CP	L,02
9008	89 2E             JR	NZ,BRANCH_9038
900A	FD E9 F0 0D F7    AND#	(PC1500_PRT_B_DIR),F7
900F	6A 08             LD	L,08
9011	68 79             LD	H,79
9013	FD ED F0 0F 08    BIT#	(PC1500_PRT_B),08
9018	89 0E             JR	NZ,BRANCH_9028
901A	A5 78 BE          LDA	(78BE)
901D	6A 04             LD	L,04
901F	68 75             LD	H,75
9021	8B 05             JR	Z,BRANCH_9028
9023	B5 00             LDA	00
9025	68 71             LD	H,71

BRANCH_9027:
9027	2A                STA	L

BRANCH_9028:
9028	24                LDA	L
9029	AD 76 4E          XOR	(HIGHLCDFLAG)
902C	AE 76 4E          STA	(HIGHLCDFLAG)
902F	A4                LDA	H
9030	A9 76 4E          AND	(HIGHLCDFLAG)
9033	AE 76 4E          STA	(HIGHLCDFLAG)
9036	B5 00             LDA	00

BRANCH_9038:
9038	9A                RET


BRANCH_9039:
9039	BE 8F ED          CALL	SUB_8FED
903C	89 05             JR	NZ,9043
903E	BE 98 02          CALL	SUB_9802
9041	8E 40             JR	UNKNOWN_JMP_9083
9043	ED 7B 09 02       BIT	(7B09),02
9047	8B 03             JR	Z,BRANCH_904C
9049	BA 9F 25          JP	JMP_9F25

BRANCH_904C:
904C	ED 76 4E 0E       BIT	(HIGHLCDFLAG),0E
9050	89 EC             JR	NZ,BRANCH_913E
9052	ED 76 4F 07       BIT	(LOWLCDFLAG),07
9056	8B E6             JR	Z,BRANCH_913E
9058	6E 5B             CP	L,5B
905A	83 E2             JR	C,BRANCH_913E
905C	24                LDA	L
905D	B1 40             SBC	40
905F	81 D9             JR	NC,BRANCH_913A
9061	DD                INC	A

BRANCH_9062:
9062	ED 76 4F 04       BIT	(LOWLCDFLAG),04
9066	89 07             JR	NZ,BRANCH_906F
9068	68 86             LD	H,86
906A	6A 69             LD	L,69
906C	FD EA             ADD	HL
906E	25                LDA	(HL)

BRANCH_906F:
906F	AE 78 96          STA	(7896)


UNKNOWN_JMP_9072:
9072	2A                STA	L

UNKNOWN_JMP_9073:
9073	A5 78 B2          LDA	(78B2)
9076	0A                STA	C
9077	48 7B             LD	B,7B
9079	B7 D8             CPA	D8
907B	81 06             JR	NC,UNKNOWN_JMP_9083
907D	24                LDA	L
907E	41                STI	(BC)
907F	04                LDA	C

UNKNOWN_JMP_9080:
9080	AE 78 B2          STA	(78B2)


UNKNOWN_JMP_9083:
9083	E9 76 4F F0       AND	(LOWLCDFLAG),F0


UNKNOWN_JMP_9087:
9087	E9 76 4E 7F       AND	(HIGHLCDFLAG),7F

JMP_908B:
908B	A5 78 B2          LDA	(78B2)
908E	B7 D8             CPA	D8
9090	8B 5A             JR	Z,SUB_PRINT#_ALT_X1
9092	ED 78 B4 02       BIT	(ERRORLINE),02
9096	8B 06             JR	Z,BRANCH_909E
9098	ED 78 B0 40       BIT	(78B0),40
909C	89 4E             JR	NZ,SUB_PRINT#_ALT_X1

BRANCH_909E:
909E	ED 78 B4 04       BIT	(ERRORLINE),04
90A2	8B 07             JR	Z,BRANCH_90AB
90A4	A5 78 B3          LDA	(78B3)
90A7	B7 D8             CPA	D8
90A9	83 41             JR	C,SUB_PRINT#_ALT_X1

BRANCH_90AB:
90AB	A5 7B D8          LDA	(7BD8)
90AE	BA 9E D0          JP	JMP_9ED0


JMP_90B1:
90B1	BE 81 BC          CALL	SUB_81BC
90B4	83 36             JR	C,SUB_PRINT#_ALT_X1
90B6	4A D8             LD	C,D8
90B8	BE 98 45          CALL	SUB_9845
90BB	EF 78 B2 FF       ADD	(78B2),FF
90BF	ED 78 B4 04       BIT	(ERRORLINE),04
90C3	8B 10             JR	Z,BRANCH_90D5
90C5	FD BE             DI
90C7	A5 78 B3          LDA	(78B3)
90CA	1A                STA	E
90CB	58 7B             LD	D,7B
90CD	A4                LDA	H
90CE	1E                STA	(DE)
90CF	EF 78 B3 01       ADD	(78B3),01
90D3	FD 81             EI

BRANCH_90D5:
90D5	A5 78 91          LDA	(7891)
90D8	8B 12             JR	Z,SUB_PRINT#_ALT_X1
90DA	A5 78 92          LDA	(7892)
90DD	B7 E6             CPA	E6
90DF	8B 07             JR	Z,BRANCH_90E8

JMP_90E1:
90E1	EB 78 91 FF       OR	(7891),FF
90E5	BA 93 6E          JP	JMP_936E

BRANCH_90E8:
90E8	E9 78 91 00       AND	(7891),00


SUB_PRINT#_ALT_X1:
90EC	FD C1             SDP
90EE	FD ED F0 0B 02    BIT#	(PC1500_IF_REG),02
90F3	8B 03             JR	Z,BRANCH_90F8
90F5	BA 8D 04          JP	SUB_8D04

BRANCH_90F8:
90F8	FD A5 D0 0E       LDA#	(CE158_PRT_A)
90FC	FD A9 D0 0E       AND#	(CE158_PRT_A)
9100	BF 20             BIT	20
9102	8B 09             JR	Z,BRANCH_910D
9104	EF 78 50 40       ADD	(OUTSTAT_REG),40
9108	81 07             JR	NC,BRANCH_9111
910A	BA 8C FD          JP	JMP_8CFD

BRANCH_910D:
910D	E9 78 50 0F       AND	(OUTSTAT_REG),0F

BRANCH_9111:
9111	BE 99 AA          CALL	SUB_99E6_ALT_E1
9114	EF 7B 0E 10       ADD	(7B0E),10
9118	BE 91 1E          CALL	SUB_911E
911B	BA 8F E0          JP	JMP_8FE0

SUB_911E:
911E	81 19             JR	NC,BRANCH_9139
9120	EF 78 97 01       ADD	(7897),01
9124	81 0F             JR	NC,BRANCH_9135
9126	6A 3C             LD	L,3C
9128	FD BE             DI
912A	FD C0             RDP
912C	FD ED F0 0B 03    BIT#	(PC1500_IF_REG),03
9131	89 02             JR	NZ,BRANCH_9135
9133	88 09             DJC	912C

BRANCH_9135:
9135	FD 81             EI
9137	FD C1             SDP

BRANCH_9139:
9139	9A                RET

BRANCH_913A:
913A	B1 EE             SBC	EE
913C	9B DC             JR	Z,BRANCH_9062

BRANCH_913E:
913E	24                LDA	L
913F	BE E3 66          CALL	E366

BRANCH_9142:
9142	AE 78 96          STA	(7896)
9145	B7 20             CPA	20
9147	81 73             JR	NC,JMP_91BC
9149	B7 61             CPA	61
914B	93 DB             JR	C,UNKNOWN_JMP_9072
914D	B7 5B             CPA	5B
914F	91 DF             JR	NC,UNKNOWN_JMP_9072
9151	8B 05             JR	Z,BRANCH_9158
9153	B7 5D             CPA	5D
9155	89 05             JR	NZ,BRANCH_915C
9157	DD                INC	A

BRANCH_9158:
9158	B9 1F             AND	1F
915A	9E 1A             JR	BRANCH_9142

BRANCH_915C:
915C	BA 90 3E          JP	903E


TBL_915F:
915F	92 3E 40 

9162	92 3E 80 

9165	96 47 80 

9168	96 42 40 

916B	96 30 20 

916E	96 42 10 

9171	92 3E 00 

9174	96 C8 01 

9177	96 16 00 

917A	96 C8 01 

917D	96 C8 01 

9180	96 C8 01 

9183	90 72 0D 

9186	8D 04 00 

9189	92 3E 00 

918C	92 3E 00 

918F	96 7B 01 

9192	90 72 08 

9195	96 57 01 

9198	96 1B 03 

919B	90 72 1B 

919E	96 1B 04 

91A1	92 3E 00 

91A4	9F 1B 01 

91A7	96 10 01 

91AA	9F 06 01 

91AD	96 C8 01 

91B0	92 3E 00 

91B3	92 3E 00 

91B6	96 C8 01 

91B9	92 3E 00 


JMP_91BC:
91BC	6A 5C             LD	L,5C
91BE	EB 78 96 80       OR	(7896),80
91C2	68 91             LD	H,91
91C4	BF 08             BIT	08
91C6	89 0E             JR	NZ,BRANCH_91D6
91C8	ED 76 4E 10       BIT	(HIGHLCDFLAG),10
91CC	89 02             JR	NZ,BRANCH_91D0
91CE	B9 EF             AND	EF

BRANCH_91D0:
91D0	ED 76 4E 40       BIT	(HIGHLCDFLAG),40
91D4	89 20             JR	NZ,BRANCH_91F6

BRANCH_91D6:
91D6	FD EA             ADD	HL
91D8	D9                SL
91D9	FD EA             ADD	HL
91DB	65                LDI	(HL)
91DC	08                STA	B
91DD	65                LDI	(HL)
91DE	0A                STA	C
91DF	A5 7B 0F          LDA	(7B0F)
91E2	B7 08             CPA	08
91E4	81 0A             JR	NC,BRANCH_91F0
91E6	B7 0D             CPA	0D
91E8	8B 09             JR	Z,BRANCH_91F3
91EA	83 04             JR	C,BRANCH_91F0
91EC	B7 09             CPA	09
91EE	89 03             JR	NZ,BRANCH_91F3

BRANCH_91F0:
91F0	BE 98 02          CALL	SUB_9802

BRANCH_91F3:
91F3	25                LDA	(HL)
91F4	FD 5E             LD	PC,BC

BRANCH_91F6:
91F6	B7 06             CPA	06
91F8	81 02             JR	NC,BRANCH_91FC
91FA	B5 07             LDA	07

BRANCH_91FC:
91FC	AE 78 84          STA	(CUR_VAR_ADD_L)
91FF	CD 38             SBR	(38)
9201	BE CE C4          CALL	SUB12
9204	81 1F             JR	NC,BRANCH_9225
9206	BA 9F 35          JP	JMP_9F35

JMP_9209:
9209	2A                STA	L
920A	68 7B             LD	H,7B
920C	45                LDI	(BC)
920D	B7 26             CPA	26
920F	89 1B             JR	NZ,BRANCH_922C
9211	6A 00             LD	L,00
9213	BE 9E 3B          CALL	SUB_9E3B
9216	83 0A             JR	C,9222
9218	2A                STA	L
9219	BE 9E 3B          CALL	SUB_9E3B
921C	83 04             JR	C,9222
921E	F1                AEX
921F	22                ADC	L
9220	F1                AEX
9221	2A                STA	L
9222	BA 90 73          JP	UNKNOWN_JMP_9073

BRANCH_9225:
9225	BA 90 83          JP	UNKNOWN_JMP_9083

BRANCH_9228:
9228	24                LDA	L
9229	BA 90 80          JP	UNKNOWN_JMP_9080

BRANCH_922C:
922C	BF E0             BIT	E0
922E	9B 08             JR	Z,BRANCH_9228
9230	6E D8             CP	L,D8
9232	91 12             JR	NC,9222
9234	B7 40             CPA	40
9236	89 02             JR	NZ,BRANCH_923A
9238	B5 0D             LDA	0D

BRANCH_923A:
923A	61                STI	(HL)
923B	45                LDI	(BC)
923C	9E 12             JR	BRANCH_922C


SUB_PRINT#_ALT_E1:
923E	A5 78 B3          LDA	(78B3)
9241	B7 B1             CPA	B1
9243	83 03             JR	C,BRANCH_9248
9245	BE 99 E6          CALL	SUB_99E6

BRANCH_9248:
9248	ED 76 4E 01       BIT	(HIGHLCDFLAG),01
924C	89 07             JR	NZ,BRANCH_9255
924E	A5 78 B3          LDA	(78B3)
9251	B7 B1             CPA	B1
9253	83 09             JR	C,BRANCH_925E

BRANCH_9255:
9255	BA 90 8B          JP	JMP_908B


TBL_9258:
9258	23 50 43 32 40 0D 


BRANCH_925E:
925E	A5 7B B0          LDA	(INPUTBUF)
9261	2A                STA	L
9262	B7 20             CPA	20
9264	81 2D             JR	NC,BRANCH_9293
9266	8B 1B             JR	Z,BRANCH_9283
9268	ED 78 B0 01       BIT	(78B0),01
926C	8B 1F             JR	Z,BRANCH_928D
926E	B7 41             CPA	41
9270	81 1B             JR	NC,BRANCH_928D
9272	B7 5B             CPA	5B
9274	83 17             JR	C,BRANCH_928D
9276	B7 49             CPA	49
9278	89 50             JR	NZ,BRANCH_92CA
927A	4A 58             LD	C,58
927C	48 92             LD	B,92
927E	BE 87 45          CALL	SUB_8745
9281	8E 47             JR	BRANCH_92CA

BRANCH_9283:
9283	ED 78 B0 02       BIT	(78B0),02
9287	8B 59             JR	Z,BRANCH_92E2
9289	6A 0C             LD	L,0C
928B	8E 55             JR	BRANCH_92E2

BRANCH_928D:
928D	E9 78 B0 FD       AND	(78B0),FD
9291	8E 4F             JR	BRANCH_92E2

BRANCH_9293:
9293	B1 0C             SBC	0C
9295	8B 24             JR	Z,BRANCH_92BB
9297	DD                INC	A
9298	8B 34             JR	Z,BRANCH_92CE
929A	B3 04             ADC	04
929C	89 09             JR	NZ,BRANCH_92A7
929E	ED 78 B0 01       BIT	(78B0),01
92A2	89 2A             JR	NZ,BRANCH_92CE
92A4	BA 94 F4          JP	JMP_94F4

BRANCH_92A7:
92A7	DD                INC	A
92A8	89 03             JR	NZ,BRANCH_92AD
92AA	BA 94 BA          JP	JMP_94BA

BRANCH_92AD:
92AD	B7 14             CPA	14
92AF	89 1D             JR	NZ,BRANCH_92CE
92B1	A5 78 B0          LDA	(78B0)
92B4	BD 01             XOR	01
92B6	AE 78 B0          STA	(78B0)
92B9	8E 17             JR	BRANCH_92D2

BRANCH_92BB:
92BB	ED 78 B0 02       BIT	(78B0),02
92BF	89 0D             JR	NZ,BRANCH_92CE
92C1	EB 78 B0 02       OR	(78B0),02
92C5	8E 1B             JR	BRANCH_92E2
92C7	BE 98 E8          CALL	SUB_98E8

BRANCH_92CA:
92CA	E9 78 B0 FD       AND	(78B0),FD

BRANCH_92CE:
92CE	E9 78 B0 FE       AND	(78B0),FE

BRANCH_92D2:
92D2	FD BE             DI
92D4	4A B0             LD	C,B0
92D6	BE 98 45          CALL	SUB_9845
92D9	EF 78 B3 FF       ADD	(78B3),FF
92DD	FD 81             EI

BRANCH_92DF:
92DF	BA 90 EC          JP	SUB_PRINT#_ALT_X1

BRANCH_92E2:
92E2	E9 78 B0 FE       AND	(78B0),FE
92E6	A5 78 B4          LDA	(ERRORLINE)
92E9	AE 78 B5          STA	(78B5)
92EC	D9                SL
92ED	81 1F             JR	NC,BRANCH_930E
92EF	D9                SL
92F0	81 1C             JR	NC,BRANCH_930E
92F2	6E 20             CP	L,20
92F4	83 10             JR	C,BRANCH_9306
92F6	6E 0D             CP	L,0D
92F8	6A 20             LD	L,20
92FA	89 0A             JR	NZ,BRANCH_9306
92FC	6A 0D             LD	L,0D
92FE	ED 78 55 10       BIT	(CR/LF_REG),10
9302	8B 02             JR	Z,BRANCH_9306
9304	6A 0A             LD	L,0A

BRANCH_9306:
9306	24                LDA	L
9307	BE 81 69          CALL	SUB_8169
930A	93 2D             JR	C,BRANCH_92DF
930C	8E 23             JR	BRANCH_9331

BRANCH_930E:
930E	E9 78 90 00       AND	(7890),00


BRANCH_9312:
9312	FD C1             SDP
9314	24                LDA	L
9315	AE 7A 08          STA	(ZREG)
9318	BE 9A 9E          CALL	SUB_9A9E
931B	18                STA	D
931C	12                ADC	E
931D	11                SBC	(DE)
931E	1A                STA	E
931F	08                STA	B
9320	18                STA	D
9321	01                SBC	(BC)
9322	16                CPA	E
9323	BE 9B 2C          CALL	SUB_9B2C
9326	8E 1A             JR	BRANCH_9342
9328	4A 00             LD	C,00
932A	48 7A             LD	B,7A
932C	41                STI	(BC)
932D	8E 13             JR	BRANCH_9342
932F	68 01             LD	H,01

BRANCH_9331:
9331	BA 94 72          JP	BRANCH_9472
9334	B5 20             LDA	20
9336	AE 7A 08          STA	(ZREG)
9339	28                STA	H
933A	B5 00             LDA	00
933C	BE 99 76          CALL	SUB_9976
933F	BE 7A 50          CALL	7A50

BRANCH_9342:
9342	44                INC	BC
9343	A5 78 90          LDA	(7890)
9346	89 48             JR	NZ,BRANCH_9390
9348	A5 78 91          LDA	(7891)
934B	8B 43             JR	Z,BRANCH_9390
934D	A5 78 93          LDA	(7893)
9350	08                STA	B
9351	A5 78 94          LDA	(7894)
9354	0A                STA	C
9355	A5 78 92          LDA	(7892)
9358	FB                SCF
9359	B1 E6             SBC	E6
935B	FD CA             ADD	BC
935D	A5 7A 08          LDA	(ZREG)
9360	0E                STA	(BC)
9361	EF 78 92 01       ADD	(7892),01
9365	83 04             JR	C,BRANCH_936B
9367	B7 20             CPA	20
9369	99 3A             JR	NZ,BRANCH_9331

BRANCH_936B:
936B	BE 98 E8          CALL	SUB_98E8

JMP_936E:
936E	A5 78 92          LDA	(7892)
9371	FB                SCF
9372	B1 E6             SBC	E6
9374	AE 78 90          STA	(7890)
9377	E9 78 92 00       AND	(7892),00


BRANCH_937B:
937B	A5 78 93          LDA	(7893)
937E	08                STA	B
937F	A5 78 94          LDA	(7894)
9382	0A                STA	C
9383	A5 78 92          LDA	(7892)
9386	EF 78 92 01       ADD	(7892),01
938A	FD CA             ADD	BC
938C	05                LDA	(BC)
938D	2A                STA	L
938E	9E 7E             JR	BRANCH_9312

BRANCH_9390:
9390	A5 78 7E          LDA	(787E)
9393	B7 77             CPA	77
9395	81 A5             JR	NC,BRANCH_943C
9397	ED 78 B4 08       BIT	(ERRORLINE),08
939B	8B 1B             JR	Z,BRANCH_93B8
939D	A5 78 91          LDA	(7891)
93A0	89 16             JR	NZ,BRANCH_93B8
93A2	A5 78 7F          LDA	(787F)
93A5	B7 06             CPA	06
93A7	81 0F             JR	NC,BRANCH_93B8
93A9	A5 7A 08          LDA	(ZREG)
93AC	B7 20             CPA	20
93AE	89 08             JR	NZ,BRANCH_93B8
93B0	B5 E6             LDA	E6
93B2	AE 78 92          STA	(7892)
93B5	AE 78 91          STA	(7891)

BRANCH_93B8:
93B8	B5 42             LDA	42
93BA	FB                SCF
93BB	00                SBC	C
93BC	00                SBC	C
93BD	A1 78 7F          SBC	(787F)
93C0	83 7A             JR	C,BRANCH_943C
93C2	28                STA	H
93C3	6A FF             LD	L,FF
93C5	A5 78 AB          LDA	(78AB)
93C8	0A                STA	C
93C9	A5 78 AA          LDA	(78AA)
93CC	08                STA	B


BRANCH_93CD:
93CD	45                LDI	(BC)
93CE	FD C8             PUSH	A


SUB_PRINT#:
93D0	BE 99 1E          CALL	SUB_9912_ALT2
93D3	FD 8A             POP	A
93D5	D9                SL
93D6	81 11             JR	NC,93E9
93D8	A5 78 BE          LDA	(78BE)
93DB	8B 0C             JR	Z,93E9
93DD	EF 78 7F FE       ADD	(787F),FE
93E1	60                INC	L
93E2	60                INC	L
93E3	FD 60             INC	H
93E5	91 1A             JR	NC,BRANCH_93CD
93E7	8E 08             JR	93F1
93E9	EF 78 7F F4       ADD	(787F),F4
93ED	B5 0B             LDA	0B
93EF	22                ADC	L
93F0	2A                STA	L
93F1	04                LDA	C
93F2	AE 78 AB          STA	(78AB)
93F5	84                LDA	B
93F6	AE 78 AA          STA	(78AA)
93F9	24                LDA	L
93FA	FD C8             PUSH	A
93FC	68 76             LD	H,76
93FE	4A 4E             LD	C,4E
9400	48 77             LD	B,77
9402	FD CA             ADD	BC

BRANCH_9404:
9404	25                LDA	(HL)
9405	B9 F0             AND	F0
9407	F1                AEX
9408	43                STD	(BC)
9409	88 07             DJC	BRANCH_9404
940B	FD 8A             POP	A
940D	28                STA	H
940E	0A                STA	C
940F	48 76             LD	B,76
9411	40                INC	C
9412	B5 4E             LDA	4E
9414	00                SBC	C
9415	2A                STA	L
9416	5A 00             LD	E,00
9418	58 76             LD	D,76

BRANCH_941A:
941A	F5                LDI
941B	88 03             DJC	BRANCH_941A
941D	A4                LDA	H
941E	2A                STA	L
941F	FD C8             PUSH	A
9421	68 77             LD	H,77
9423	4A 4D             LD	C,4D
9425	48 76             LD	B,76

BRANCH_9427:
9427	25                LDA	(HL)
9428	43                STD	(BC)
9429	88 04             DJC	BRANCH_9427
942B	FD 8A             POP	A
942D	0A                STA	C
942E	40                INC	C
942F	48 77             LD	B,77
9431	6A 4D             LD	L,4D
9433	5A 00             LD	E,00
9435	58 77             LD	D,77

BRANCH_9437:
9437	F5                LDI
9438	88 03             DJC	BRANCH_9437
943A	68 00             LD	H,00

BRANCH_943C:
943C	6A 05             LD	L,05
943E	ED 7A 08 80       BIT	(ZREG),80
9442	8B 07             JR	Z,BRANCH_944B
9444	A5 78 BE          LDA	(78BE)
9447	8B 02             JR	Z,BRANCH_944B
9449	6A 00             LD	L,00

BRANCH_944B:
944B	BE 98 C3          CALL	SUB_98C3
944E	04                LDA	C
944F	AE 78 7F          STA	(787F)
9452	84                LDA	B
9453	AE 78 7E          STA	(787E)
9456	BE 99 00          CALL	SUB_9900
9459	A5 78 90          LDA	(7890)
945C	8B 14             JR	Z,BRANCH_9472
945E	EF 78 90 FF       ADD	(7890),FF
9462	8B 02             JR	Z,BRANCH_9466
9464	9E EB             JR	BRANCH_937B

BRANCH_9466:
9466	A5 78 91          LDA	(7891)
9469	E9 78 91 00       AND	(7891),00
946D	DD                INC	A
946E	89 02             JR	NZ,BRANCH_9472
9470	8E 36             JR	BRANCH_94A8

BRANCH_9472:
9472	FD BE             DI
9474	4A B0             LD	C,B0
9476	BE 98 45          CALL	SUB_9845
9479	EF 78 B3 FF       ADD	(78B3),FF
947D	FD 81             EI
947F	BE 99 33          CALL	SUB_9933
9482	A4                LDA	H
9483	B7 20             CPA	20
9485	81 08             JR	NC,BRANCH_948F
9487	ED 78 B0 02       BIT	(78B0),02
948B	8B 02             JR	Z,BRANCH_948F
948D	B5 0C             LDA	0C

BRANCH_948F:
948F	0E                STA	(BC)
9490	ED 76 4F 10       BIT	(LOWLCDFLAG),10
9494	89 15             JR	NZ,BRANCH_94AB
9496	ED 76 4F 20       BIT	(LOWLCDFLAG),20
949A	8B 0C             JR	Z,BRANCH_94A8
949C	EF 78 AF 01       ADD	(78AF),01
94A0	81 06             JR	NC,BRANCH_94A8
94A2	EF 78 AE 01       ADD	(78AE),01
94A6	83 0C             JR	C,BRANCH_94B4

BRANCH_94A8:
94A8	BA 90 EC          JP	SUB_PRINT#_ALT_X1

BRANCH_94AB:
94AB	B7 0D             CPA	0D
94AD	99 07             JR	NZ,BRANCH_94A8

BRANCH_94AF:
94AF	B5 01             LDA	01
94B1	BA 96 7B          JP	JMP_967B

BRANCH_94B4:
94B4	EB 78 AE FE       OR	(78AE),FE
94B8	9E 0B             JR	BRANCH_94AF

JMP_94BA:
94BA	6A 11             LD	L,11
94BC	B5 5B             LDA	5B
94BE	FD BE             DI
94C0	FD AE F0 07       STA#	(PC1500_F_REG_LD/DIV)

BRANCH_94C4:
94C4	FD ED F0 0F 20    BIT#	(PC1500_PRT_B),20
94C9	8B 09             JR	Z,BRANCH_94D4
94CB	FD ED F0 0B 03    BIT#	(PC1500_IF_REG),03
94D0	89 13             JR	NZ,BRANCH_94E5
94D2	9E 10             JR	BRANCH_94C4

BRANCH_94D4:
94D4	62                DEC	L
94D5	81 0E             JR	NC,BRANCH_94E5

BRANCH_94D7:
94D7	FD ED F0 0F 20    BIT#	(PC1500_PRT_B),20
94DC	89 12             JR	NZ,BRANCH_94F0
94DE	FD ED F0 0B 03    BIT#	(PC1500_IF_REG),03
94E3	9B 0E             JR	Z,BRANCH_94D7

BRANCH_94E5:
94E5	B5 00             LDA	00
94E7	FD AE F0 07       STA#	(PC1500_F_REG_LD/DIV)
94EB	FD 81             EI

BRANCH_94ED:
94ED	BA 92 CE          JP	BRANCH_92CE

BRANCH_94F0:
94F0	88 2E             DJC	BRANCH_94C4
94F2	9E 0F             JR	BRANCH_94E5

JMP_94F4:
94F4	A5 78 91          LDA	(7891)
94F7	8B 11             JR	Z,BRANCH_950A
94F9	B5 E6             LDA	E6
94FB	A7 78 92          CPA	(7892)
94FE	83 06             JR	C,BRANCH_9506
9500	EF 78 92 FF       ADD	(7892),FF
9504	8E 04             JR	BRANCH_950A

BRANCH_9506:
9506	E9 78 91 00       AND	(7891),00

BRANCH_950A:
950A	A5 78 A8          LDA	(78A8)
950D	08                STA	B
950E	D9                SL
950F	93 24             JR	C,BRANCH_94ED
9511	A5 78 A9          LDA	(78A9)
9514	0A                STA	C
9515	FD 5A             LD	DE,BC
9517	47                LDD	(BC)
9518	9B 2D             JR	Z,BRANCH_94ED
951A	FB                SCF
951B	04                LDA	C
951C	A1 78 A1          SBC	(78A1)
951F	84                LDA	B
9520	A1 78 A0          SBC	(78A0)
9523	83 08             JR	C,BRANCH_952D
9525	A5 78 A5          LDA	(78A5)
9528	0A                STA	C
9529	A5 78 A4          LDA	(78A4)
952C	08                STA	B

BRANCH_952D:
952D	05                LDA	(BC)
952E	89 14             JR	NZ,BRANCH_9544
9530	EB 78 A8 80       OR	(78A8),80
9534	14                LDA	E
9535	AE 78 BB          STA	(78BB)
9538	AE 78 A7          STA	(78A7)
953B	94                LDA	D
953C	AE 78 BA          STA	(78BA)
953F	AE 78 A6          STA	(78A6)
9542	8E 1C             JR	BRANCH_9560

BRANCH_9544:
9544	14                LDA	E
9545	A7 78 BB          CPA	(78BB)
9548	89 0E             JR	NZ,BRANCH_9558
954A	94                LDA	D
954B	A7 78 BA          CPA	(78BA)
954E	89 08             JR	NZ,BRANCH_9558
9550	04                LDA	C
9551	AE 78 BB          STA	(78BB)
9554	84                LDA	B
9555	AE 78 BA          STA	(78BA)

BRANCH_9558:
9558	04                LDA	C
9559	AE 78 A9          STA	(78A9)
955C	84                LDA	B
955D	AE 78 A8          STA	(78A8)

BRANCH_9560:
9560	15                LDA	(DE)
9561	59 00             AND	(DE),00
9563	2A                STA	L
9564	A5 78 B4          LDA	(ERRORLINE)
9567	D9                SL
9568	81 1A             JR	NC,BRANCH_9584
956A	6A 5C             LD	L,5C
956C	24                LDA	L
956D	BE 81 69          CALL	SUB_8169
9570	81 4B             JR	NC,BRANCH_95BD
9572	89 07             JR	NZ,BRANCH_957B
9574	BE 9B 47          CALL	SUB_9B47
9577	9E 0D             JR	956C
9579	8E 42             JR	BRANCH_95BD

BRANCH_957B:
957B	EF 78 50 10       ADD	(OUTSTAT_REG),10
957F	91 15             JR	NC,956C
9581	BA 8C FD          JP	JMP_8CFD

BRANCH_9584:
9584	B5 F4             LDA	F4
9586	6E 80             CP	L,80
9588	81 09             JR	NC,BRANCH_9593
958A	F9                RCF
958B	ED 78 BE FF       BIT	(78BE),FF
958F	8B 02             JR	Z,BRANCH_9593
9591	B5 FE             LDA	FE

BRANCH_9593:
9593	A3 78 7F          ADC	(787F)
9596	0A                STA	C
9597	A5 78 7E          LDA	(787E)
959A	08                STA	B
959B	83 0A             JR	C,BRANCH_95A7
959D	B5 4E             LDA	4E
959F	02                ADC	C
95A0	0A                STA	C
95A1	FD 42             DEC	B
95A3	4C 74             CP	B,74
95A5	81 19             JR	NC,BRANCH_95C0

BRANCH_95A7:
95A7	FD 88             PUSH	BC
95A9	BE 99 0C          CALL	SUB_990C
95AC	B5 00             LDA	00
95AE	CD 88             SBR	(88)
95B0	BE 99 0C          CALL	SUB_990C
95B3	FD 0A             POP	BC
95B5	04                LDA	C
95B6	AE 78 7F          STA	(787F)
95B9	84                LDA	B
95BA	BE 98 FD          CALL	SUB_98FD

BRANCH_95BD:
95BD	BA 92 CA          JP	BRANCH_92CA

BRANCH_95C0:
95C0	BE 98 E8          CALL	SUB_98E8
95C3	9E 08             JR	BRANCH_95BD

95C5	9E 


SUB_95C6:
95C6	ED 76 4E 01       BIT	(HIGHLCDFLAG),01
95CA	8B 43             JR	Z,BRANCH_960F
95CC	B5 01             LDA	01
95CE	AD 78 80          XOR	(7880)
95D1	AE 78 80          STA	(7880)
95D4	D5                SR
95D5	81 26             JR	NC,BRANCH_95FD
95D7	BE EE 80          CALL	EE80


BRANCH_95DA:
95DA	A5 76 4E          LDA	(HIGHLCDFLAG)
95DD	D5                SR
95DE	48 86             LD	B,86
95E0	4A 35             LD	C,35
95E2	87 09             JR	H,BRANCH_95ED
95E4	D5                SR
95E5	B5 1A             LDA	1A
95E7	FD CA             ADD	BC
95E9	87 02             JR	H,BRANCH_95ED
95EB	CD 38             SBR	(38)

BRANCH_95ED:
95ED	6A 19             LD	L,19
95EF	5A 10             LD	E,10
95F1	58 7A             LD	D,7A

BRANCH_95F3:
95F3	F5                LDI
95F4	88 03             DJC	BRANCH_95F3
95F6	FD 18             LD	BC,DE
95F8	49 00             AND	(BC),00
95FA	BA EF 5B          JP	EF5B

BRANCH_95FD:
95FD	BA EE 99          JP	EE99

SUB_9600:
9600	BE 9E 20          CALL	SUB_9E20
9603	ED 76 4E 01       BIT	(HIGHLCDFLAG),01
9607	8B 06             JR	Z,BRANCH_960F
9609	ED 78 80 01       BIT	(7880),01
960D	99 35             JR	NZ,BRANCH_95DA

BRANCH_960F:
960F	9A                RET


JMP_9610:
9610	BE 95 C6          CALL	SUB_95C6

BRANCH_9613:
9613	BA 90 83          JP	UNKNOWN_JMP_9083

JMP_9616:
9616	BE 96 00          CALL	SUB_9600
9619	9E 08             JR	BRANCH_9613
961B	2A                STA	L
961C	B9 0F             AND	0F
961E	AD 76 4F          XOR	(LOWLCDFLAG)
9621	AE 76 4F          STA	(LOWLCDFLAG)
9624	24                LDA	L
9625	BB 70             OR	70
9627	A9 76 4F          AND	(LOWLCDFLAG)
962A	AE 76 4F          STA	(LOWLCDFLAG)
962D	BA 90 87          JP	UNKNOWN_JMP_9087

JMP_9630:
9630	ED 76 4F 20       BIT	(LOWLCDFLAG),20
9634	89 0C             JR	NZ,BRANCH_9642
9636	E9 78 AF 00       AND	(78AF),00
963A	E9 78 AE 00       AND	(78AE),00
963E	EB 78 AE FE       OR	(78AE),FE

BRANCH_9642:
9642	AE 76 4F          STA	(LOWLCDFLAG)
9645	9E 34             JR	BRANCH_9613

JMP_9647:
9647	AD 78 B4          XOR	(ERRORLINE)
964A	D9                SL
964B	81 04             JR	NC,BRANCH_9651
964D	BF 80             BIT	80
964F	9B 3E             JR	Z,BRANCH_9613

BRANCH_9651:
9651	D1                RR
9652	AE 78 B4          STA	(ERRORLINE)
9655	9E 44             JR	BRANCH_9613
9657	A9 76 4E          AND	(HIGHLCDFLAG)
965A	9B 49             JR	Z,BRANCH_9613
965C	A5 78 B4          LDA	(ERRORLINE)
965F	BF 70             BIT	70


SUB_INPUT#:
9660	70                INC	N
9661	9B 50             JR	Z,BRANCH_9613
9663	BB 80             OR	80
9665	AE 78 B5          STA	(78B5)
9668	F4 78 A8          LDU	(78A8)
966B	CC AA             LDS	(AA)
966D	ED 78 80 80       BIT	(7880),80
9671	89 02             JR	NZ,BRANCH_9675
9673	CC A0             LDS	(A0)

BRANCH_9675:
9675	BE 9B D0          CALL	SUB_9B95_ALT_E1
9678	9E 67             JR	BRANCH_9613
967A	00                SBC	C

JMP_967B:
967B	AD 76 4E          XOR	(HIGHLCDFLAG)
967E	AE 76 4E          STA	(HIGHLCDFLAG)
9681	D5                SR
9682	83 2D             JR	C,BRANCH_96B1
9684	BE 9D 39          CALL	SUB_9D39

SUB_INPUT#_ALT_E1:
9687	CD 8C             SBR	(8C)
9689	CA 7E             STS	(7E)
968B	FD E9 B0 0A FD    AND#	(CE150_MSK_REG),FD
9690	BE 99 00          CALL	SUB_9900
9693	BE 99 12          CALL	SUB_9912
9696	CA BA             STS	(BA)
9698	A5 78 B3          LDA	(78B3)
969B	B7 B1             CPA	B1
969D	83 03             JR	C,BRANCH_96A2
969F	BE 99 EC          CALL	SUB_99EC

BRANCH_96A2:
96A2	E9 76 4E FE       AND	(HIGHLCDFLAG),FE
96A6	E9 78 80 00       AND	(7880),00
96AA	E9 78 91 00       AND	(7891),00
96AE	BA 92 3E          JP	SUB_PRINT#_ALT_E1

BRANCH_96B1:
96B1	BE 9B 95          CALL	SUB_9B95
96B4	BE 98 52          CALL	SUB_9852
96B7	BE 9F EF          CALL	SUB_9FEF
96BA	E9 78 80 00       AND	(7880),00
96BE	EB 76 4E 01       OR	(HIGHLCDFLAG),01

BRANCH_96C2:
96C2	BE 9D 39          CALL	SUB_9D39

BRANCH_96C5:
96C5	BA 90 83          JP	UNKNOWN_JMP_9083

JMP_96C8:
96C8	A9 76 4E          AND	(HIGHLCDFLAG)
96CB	89 2F             JR	NZ,BRANCH_96FC
96CD	E9 78 80 00       AND	(7880),00
96D1	A5 78 B4          LDA	(ERRORLINE)
96D4	B7 C0             CPA	C0
96D6	93 13             JR	C,BRANCH_96C5
96D8	ED 76 4F 10       BIT	(LOWLCDFLAG),10
96DC	99 19             JR	NZ,BRANCH_96C5
96DE	BE 9B 95          CALL	SUB_9B95
96E1	BE 98 52          CALL	SUB_9852
96E4	EB 76 4E 01       OR	(HIGHLCDFLAG),01

BRANCH_96E8:
96E8	CC A0             LDS	(A0)
96EA	F4 78 A8          LDU	(78A8)
96ED	BE 9F EF          CALL	SUB_9FEF
96F0	BE DF E2          CALL	SUB85
96F3	91 30             JR	NC,BRANCH_96C5
96F5	B5 80             LDA	80
96F7	AE 78 80          STA	(7880)
96FA	8E 97             JR	BRANCH_9793

BRANCH_96FC:
96FC	A5 78 80          LDA	(7880)
96FF	9B 19             JR	Z,BRANCH_96E8
9701	D5                SR
9702	81 07             JR	NC,970B
9704	BE EE 99          CALL	EE99
9707	E9 78 80 FE       AND	(7880),FE
970B	9B 25             JR	Z,BRANCH_96E8
970D	A5 78 96          LDA	(7896)
9710	B7 9B             CPA	9B
9712	81 09             JR	NC,BRANCH_971D
9714	9B 2E             JR	Z,BRANCH_96E8
9716	B5 80             LDA	80
9718	AE 78 80          STA	(7880)
971B	9E 5B             JR	BRANCH_96C2

BRANCH_971D:
971D	D5                SR
971E	83 06             JR	C,BRANCH_9726
9720	D5                SR
9721	83 4B             JR	C,BRANCH_976E
9723	D5                SR
9724	83 48             JR	C,BRANCH_976E

BRANCH_9726:
9726	F4 78 AA          LDU	(78AA)
9729	CC A0             LDS	(A0)
972B	BE DF E1          CALL	DFE1
972E	81 1A             JR	NC,BRANCH_974A
9730	CC AA             LDS	(AA)
9732	46                DEC	BC
9733	ED 7B 0F 01       BIT	(7B0F),01
9737	89 24             JR	NZ,BRANCH_975D
9739	05                LDA	(BC)
973A	B7 0D             CPA	0D
973C	8B 1F             JR	Z,BRANCH_975D
973E	B7 20             CPA	20
9740	8B 1B             JR	Z,BRANCH_975D
9742	E9 78 B1 00       AND	(78B1),00
9746	FB                SCF
9747	BE 9D 4B          CALL	SUB_9D4B

BRANCH_974A:
974A	BA 90 83          JP	UNKNOWN_JMP_9083

BRANCH_974D:
974D	46                DEC	BC
974E	05                LDA	(BC)
974F	B7 0D             CPA	0D
9751	8B 12             JR	Z,BRANCH_9765
9753	ED 7B 0F 01       BIT	(7B0F),01
9757	89 04             JR	NZ,BRANCH_975D
9759	B7 20             CPA	20
975B	8B 08             JR	Z,BRANCH_9765

BRANCH_975D:
975D	88 12             DJC	BRANCH_974D
975F	FD 62             DEC	H
9761	93 16             JR	C,BRANCH_974D
9763	8E 01             JR	BRANCH_9766

BRANCH_9765:
9765	44                INC	BC

BRANCH_9766:
9766	F4 78 A8          LDU	(78A8)
9769	BE DF E2          CALL	SUB85
976C	8E 25             JR	BRANCH_9793

BRANCH_976E:
976E	F4 78 A8          LDU	(78A8)
9771	CC AC             LDS	(AC)
9773	BE DF E1          CALL	DFE1
9776	91 2E             JR	NC,BRANCH_974A
9778	ED 7B 0F 02       BIT	(7B0F),02
977C	89 1A             JR	NZ,BRANCH_9798
977E	CC AC             LDS	(AC)
9780	45                LDI	(BC)
9781	B7 0D             CPA	0D
9783	8B 04             JR	Z,BRANCH_9789
9785	B7 20             CPA	20
9787	89 0A             JR	NZ,BRANCH_9793

BRANCH_9789:
9789	CC AA             LDS	(AA)
978B	F4 78 A8          LDU	(78A8)
978E	BE DF E2          CALL	SUB85
9791	8E 05             JR	BRANCH_9798

BRANCH_9793:
9793	BE 9D 2A          CALL	SUB_9D2A
9796	9E 4E             JR	BRANCH_974A

BRANCH_9798:
9798	45                LDI	(BC)
9799	B7 0D             CPA	0D
979B	9B 0A             JR	Z,BRANCH_9793
979D	ED 7B 0F 02       BIT	(7B0F),02
97A1	89 04             JR	NZ,97A7
97A3	B7 20             CPA	20
97A5	9B 14             JR	Z,BRANCH_9793
97A7	88 11             DJC	BRANCH_9798
97A9	FD 62             DEC	H
97AB	93 15             JR	C,BRANCH_9798
97AD	9E 65             JR	BRANCH_974A

97AF	20 00 40 00 FF 00 FF 00   00 00 00 


SUB_97BA:
97BA	BE 79 FA          CALL	UNDEF_REG_79FA
97BD	BE 98 11          CALL	SUB_9811
97C0	2A                STA	L
97C1	A7 7B 0F          CPA	(7B0F)
97C4	89 1C             JR	NZ,BRANCH_97E2
97C6	EF 7B 08 01       ADD	(7B08),01
97CA	89 43             JR	NZ,BRANCH_980F
97CC	EF 7B 09 01       ADD	(7B09),01
97D0	89 3D             JR	NZ,BRANCH_980F
97D2	24                LDA	L
97D3	8B 08             JR	Z,BRANCH_97DD
97D5	EB 7B 09 FF       OR	(7B09),FF
97D9	B5 C0             LDA	C0
97DB	8E 20             JR	BRANCH_97FD

BRANCH_97DD:
97DD	EB 7B 0F FF       OR	(7B0F),FF
97E1	9A                RET

BRANCH_97E2:
97E2	A5 7B 0F          LDA	(7B0F)
97E5	DD                INC	A
97E6	89 1A             JR	NZ,SUB_9802
97E8	24                LDA	L
97E9	8B 24             JR	Z,BRANCH_980F
97EB	AE 7B 0F          STA	(7B0F)
97EE	BE 98 11          CALL	SUB_9811
97F1	A7 7B 0F          CPA	(7B0F)
97F4	89 0C             JR	NZ,SUB_9802
97F6	B5 FD             LDA	FD
97F8	AE 7B 09          STA	(7B09)
97FB	B5 00             LDA	00

BRANCH_97FD:
97FD	AE 7B 08          STA	(7B08)
9800	F9                RCF
9801	9A                RET


SUB_9802:
9802	E9 7B 0F 00       AND	(7B0F),00
9806	B5 E0             LDA	E0
9808	AE 7B 08          STA	(7B08)
980B	EB 7B 09 FF       OR	(7B09),FF

BRANCH_980F:
980F	FB                SCF
9810	9A                RET


SUB_9811:
9811	4A 77             LD	C,77
9813	FD E9 F0 0D 7F    AND#	(PC1500_PRT_B_DIR),7F
9818	B5 01             LDA	01

BRANCH_981A:
981A	FD AE F0 0C       STA#	(PC1500_PRT_A_DIR)
981E	FD E9 F0 0E 00    AND#	(PC1500_PRT_A),00
9823	08                STA	B
9824	B5 08             LDA	08
9826	FD CA             ADD	BC
9828	FD BA             INA
982A	DD                INC	A
982B	89 06             JR	NZ,BRANCH_9833
982D	84                LDA	B
982E	D9                SL
982F	91 17             JR	NC,BRANCH_981A
9831	8E 08             JR	BRANCH_983B

BRANCH_9833:
9833	DF                DEC	A

BRANCH_9834:
9834	40                INC	C
9835	D9                SL
9836	93 04             JR	C,BRANCH_9834
9838	48 FE             LD	B,FE
983A	05                LDA	(BC)

BRANCH_983B:
983B	FD ED F0 0F 80    BIT#	(PC1500_PRT_B),80
9840	8B 02             JR	Z,BRANCH_9844
9842	B5 0E             LDA	0E

BRANCH_9844:
9844	9A                RET


SUB_9845:
9845	48 7B             LD	B,7B
9847	FD 5A             LD	DE,BC
9849	45                LDI	(BC)
984A	28                STA	H
984B	6A 26             LD	L,26

BRANCH_984D:
984D	F5                LDI
984E	88 03             DJC	BRANCH_984D
9850	A4                LDA	H
9851	9A                RET

SUB_9852:
9852	F4 78 A6          LDU	(78A6)
9855	CC A0             LDS	(A0)
9857	BE DF E2          CALL	SUB85
985A	18                STA	D
985B	24                LDA	L
985C	1A                STA	E
985D	CA A6             STS	(A6)
985F	F4 78 A2          LDU	(PREV_LINE_H)
9862	46                DEC	BC

BRANCH_9863:
9863	44                INC	BC
9864	84                LDA	B
9865	AE 78 7C          STA	(787C)
9868	04                LDA	C
9869	AE 78 7D          STA	(787D)
986C	05                LDA	(BC)
986D	AE 78 BD          STA	(78BD)
9870	8E 1B             JR	BRANCH_988D

BRANCH_9872:
9872	BE 98 A5          CALL	SUB_98A5
9875	05                LDA	(BC)
9876	FD C8             PUSH	A
9878	A5 78 BD          LDA	(78BD)
987B	0E                STA	(BC)
987C	FD 8A             POP	A
987E	AE 78 BD          STA	(78BD)
9881	04                LDA	C
9882	A7 78 7D          CPA	(787D)
9885	89 06             JR	NZ,BRANCH_988D
9887	84                LDA	B
9888	A7 78 7C          CPA	(787C)
988B	9B 2A             JR	Z,BRANCH_9863

BRANCH_988D:
988D	88 1D             DJC	BRANCH_9872
988F	FD 62             DEC	H
9891	93 21             JR	C,BRANCH_9872
9893	CC A8             LDS	(A8)
9895	D9                SL
9896	83 0C             JR	C,BRANCH_98A4
9898	BE 98 A5          CALL	SUB_98A5
989B	CA A8             STS	(A8)
989D	CC BA             LDS	(BA)
989F	BE 98 A5          CALL	SUB_98A5
98A2	CA BA             STS	(BA)

BRANCH_98A4:
98A4	9A                RET


SUB_98A5:
98A5	FB                SCF
98A6	04                LDA	C
98A7	10                SBC	E
98A8	0A                STA	C
98A9	84                LDA	B
98AA	90                SBC	D
98AB	08                STA	B
98AC	81 0A             JR	NC,BRANCH_98B8
98AE	04                LDA	C
98AF	A1 78 A1          SBC	(78A1)
98B2	84                LDA	B
98B3	A1 78 A0          SBC	(78A0)
98B6	83 0A             JR	C,98C2

BRANCH_98B8:
98B8	A5 78 A3          LDA	(78A3)
98BB	02                ADC	C
98BC	0A                STA	C
98BD	A5 78 A2          LDA	(PREV_LINE_H)
98C0	82                ADC	B
98C1	08                STA	B
98C2	9A                RET


SUB_98C3:
98C3	A5 78 7F          LDA	(787F)
98C6	0A                STA	C
98C7	A5 78 7E          LDA	(787E)
98CA	08                STA	B
98CB	5A 00             LD	E,00
98CD	58 7A             LD	D,7A
98CF	8E 35             JR	BRANCH_9906


SEPARATOR_98D1:
98D1	FF 00 FF 00 FF 00 FF 00   FF 00 FF 00 FF 00 FF 00 
98E1	FF 00 FF 00 FF 00 FF 


SUB_98E8:
98E8	BE 99 12          CALL	SUB_9912
98EB	AE 78 AA          STA	(78AA)
98EE	04                LDA	C
98EF	AE 78 AB          STA	(78AB)
98F2	F2                CLS
98F3	AE 78 75          STA	(7875)
98F6	0A                STA	C
98F7	AE 78 7F          STA	(787F)
98FA	B5 74             LDA	74
98FC	08                STA	B

SUB_98FD:
98FD	AE 78 7E          STA	(787E)

SUB_9900:
9900	5A DB             LD	E,DB
9902	58 FD             LD	D,FD

BRANCH_9904:
9904	6A 04             LD	L,04


BRANCH_9906:
9906	55                LDI	(DE)
9907	CD 88             SBR	(88)
9909	88 05             DJC	BRANCH_9906
990B	9A                RET


SUB_990C:
990C	5A A0             LD	E,A0
990E	58 FC             LD	D,FC
9910	9E 0E             JR	BRANCH_9904


SUB_9912:
9912	A5 78 A9          LDA	(78A9)
9915	0A                STA	C
9916	A5 78 A8          LDA	(78A8)
9919	08                STA	B
991A	D9                SL
991B	83 0D             JR	C,BRANCH_992A

SUB_9912_ALT1:
991D	44                INC	BC


SUB_9912_ALT2:
991E	04                LDA	C
991F	A1 78 A5          SBC	(78A5)
9922	84                LDA	B
9923	A1 78 A4          SBC	(78A4)
9926	84                LDA	B
9927	81 09             JR	NC,BRANCH_9932
9929	F9                RCF

BRANCH_992A:
992A	A5 78 A1          LDA	(78A1)
992D	0A                STA	C
992E	A5 78 A0          LDA	(78A0)
9931	08                STA	B

BRANCH_9932:
9932	9A                RET


SUB_9933:
9933	BE 99 12          CALL	SUB_9912
9936	04                LDA	C
9937	AE 78 A9          STA	(78A9)
993A	84                LDA	B
993B	AE 78 A8          STA	(78A8)
993E	83 34             JR	C,BRANCH_9974
9940	FD A8             PUSH	HL
9942	FD 6A             LD	HL,BC
9944	A5 78 A7          LDA	(78A7)
9947	0A                STA	C
9948	A5 78 A6          LDA	(78A6)
994B	08                STA	B
994C	A6                CPA	H
994D	89 20             JR	NZ,BRANCH_996F
994F	04                LDA	C
9950	26                CPA	L
9951	89 1C             JR	NZ,BRANCH_996F
9953	F9                RCF
9954	BE 99 1D          CALL	SUB_9912_ALT1
9957	AE 78 A6          STA	(78A6)
995A	04                LDA	C
995B	AE 78 A7          STA	(78A7)
995E	26                CPA	L
995F	89 0E             JR	NZ,BRANCH_996F
9961	A5 78 BA          LDA	(78BA)
9964	A6                CPA	H
9965	89 08             JR	NZ,BRANCH_996F
9967	04                LDA	C
9968	AE 78 BB          STA	(78BB)
996B	84                LDA	B
996C	AE 78 BA          STA	(78BA)

BRANCH_996F:
996F	FD 28             LD	BC,HL
9971	FD 2A             POP	HL
9973	9A                RET

BRANCH_9974:
9974	F9                RCF
9975	9A                RET


SUB_9976:
9976	FD 98             PUSH	DE
9978	5A 50             LD	E,50
997A	58 7A             LD	D,7A
997C	4A 84             LD	C,84
997E	48 86             LD	B,86
9980	FD CA             ADD	BC
9982	45                LDI	(BC)
9983	2A                STA	L
9984	05                LDA	(BC)
9985	0A                STA	C

BRANCH_9986:
9986	F5                LDI
9987	88 03             DJC	BRANCH_9986
9989	FD 1A             POP	DE
998B	9A                RET

998C	00 


SUB_998D:
998D	BE 98 02          CALL	SUB_9802

BRANCH_9990:
9990	EF 7B 0E 08       ADD	(7B0E),08
9994	BE 91 1E          CALL	SUB_911E
9997	BE 97 BA          CALL	SUB_97BA

BRANCH_999A:
999A	93 0C             JR	C,BRANCH_9990
999C	BE 8F ED          CALL	SUB_8FED
999F	9B 14             JR	Z,SUB_998D
99A1	24                LDA	L
99A2	BE E3 66          CALL	E366
99A5	E9 76 4E 7D       AND	(HIGHLCDFLAG),7D
99A9	9A                RET


SUB_99E6_ALT_E1:
99AA	FD E9 D0 0B FE    AND#	(CE158_IF_REG),FE
99AF	FD E9 B0 0B FE    AND#	(CE150_IF_REG),FE
99B4	A5 78 B3          LDA	(78B3)
99B7	1A                STA	E
99B8	58 7B             LD	D,7B
99BA	FD BE             DI
99BC	BE 81 E6          CALL	SUB_81E6
99BF	FD 81             EI
99C1	81 91             JR	NC,BRANCH_9A54
99C3	BF 40             BIT	40
99C5	8B B5             JR	Z,BRANCH_9A7C
99C7	B5 3F             LDA	3F

BRANCH_99C9:
99C9	5E D8             CP	E,D8
99CB	83 33             JR	C,BRANCH_9A00
99CD	51                STI	(DE)
99CE	EF 78 B3 01       ADD	(78B3),01
99D2	5E D3             CP	E,D3
99D4	89 2A             JR	NZ,BRANCH_9A00

SUB_99D6:
99D6	ED 78 B0 80       BIT	(78B0),80
99DA	8B 24             JR	Z,BRANCH_9A00
99DC	ED 78 B4 02       BIT	(ERRORLINE),02
99E0	8B 1E             JR	Z,BRANCH_9A00
99E2	B5 13             LDA	13
99E4	8E 14             JR	BRANCH_99FA


SUB_99E6:
99E6	ED 76 4E 01       BIT	(HIGHLCDFLAG),01
99EA	89 14             JR	NZ,BRANCH_9A00

SUB_99EC:
99EC	ED 78 B4 02       BIT	(ERRORLINE),02
99F0	8B 0E             JR	Z,BRANCH_9A00
99F2	ED 78 B0 80       BIT	(78B0),80
99F6	89 08             JR	NZ,BRANCH_9A00
99F8	B5 11             LDA	11

BRANCH_99FA:
99FA	FD A8             PUSH	HL
99FC	68 1F             LD	H,1F
99FE	8E 05             JR	BRANCH_9A05

BRANCH_9A00:
9A00	9A                RET
9A01	FD A8             PUSH	HL
9A03	68 00             LD	H,00

BRANCH_9A05:
9A05	2A                STA	L
9A06	ED 78 B4 02       BIT	(ERRORLINE),02
9A0A	8B 06             JR	Z,BRANCH_9A12
9A0C	ED 78 B0 40       BIT	(78B0),40
9A10	89 1D             JR	NZ,BRANCH_9A2F

BRANCH_9A12:
9A12	24                LDA	L
9A13	BE 81 BC          CALL	SUB_81BC
9A16	81 1A             JR	NC,BRANCH_9A32
9A18	BF 20             BIT	20
9A1A	89 2F             JR	NZ,BRANCH_9A4B
9A1C	6C 00             CP	H,00
9A1E	8B 0F             JR	Z,BRANCH_9A2F
9A20	BF 1C             BIT	1C
9A22	8B 04             JR	Z,BRANCH_9A28
9A24	FD 62             DEC	H
9A26	81 07             JR	NC,BRANCH_9A2F

BRANCH_9A28:
9A28	FD ED F0 0B 02    BIT#	(PC1500_IF_REG),02
9A2D	9B 1D             JR	Z,BRANCH_9A12

BRANCH_9A2F:
9A2F	FD 2A             POP	HL
9A31	9A                RET

BRANCH_9A32:
9A32	24                LDA	L
9A33	FD 2A             POP	HL
9A35	B7 13             CPA	13
9A37	89 05             JR	NZ,BRANCH_9A3E
9A39	E9 78 B0 7F       AND	(78B0),7F
9A3D	9A                RET

BRANCH_9A3E:
9A3E	B7 11             CPA	11
9A40	89 06             JR	NZ,9A48
9A42	EB 78 B0 80       OR	(78B0),80
9A46	9E 9E             JR	SUB_99E6_ALT_E1
9A48	B5 00             LDA	00
9A4A	9A                RET

BRANCH_9A4B:
9A4B	EF 78 50 80       ADD	(OUTSTAT_REG),80
9A4F	91 3F             JR	NC,BRANCH_9A12
9A51	BA 8C FD          JP	JMP_8CFD

BRANCH_9A54:
9A54	B7 20             CPA	20
9A56	81 16             JR	NC,BRANCH_9A6E
9A58	9B 91             JR	Z,BRANCH_99C9
9A5A	B7 7F             CPA	7F
9A5C	9B 95             JR	Z,BRANCH_99C9
9A5E	ED 78 B0 08       BIT	(78B0),08
9A62	9B 9B             JR	Z,BRANCH_99C9
9A64	ED 78 B0 10       BIT	(78B0),10
9A68	9B A1             JR	Z,BRANCH_99C9
9A6A	BB 80             OR	80
9A6C	9E A5             JR	BRANCH_99C9

BRANCH_9A6E:
9A6E	B7 13             CPA	13
9A70	89 0B             JR	NZ,BRANCH_9A7D
9A72	ED 78 B4 02       BIT	(ERRORLINE),02
9A76	8B 09             JR	Z,BRANCH_9A81
9A78	EB 78 B0 40       OR	(78B0),40

BRANCH_9A7C:
9A7C	9A                RET

BRANCH_9A7D:
9A7D	B7 11             CPA	11
9A7F	89 05             JR	NZ,BRANCH_9A86

BRANCH_9A81:
9A81	E9 78 B0 BF       AND	(78B0),BF
9A85	9A                RET

BRANCH_9A86:
9A86	ED 78 B0 08       BIT	(78B0),08
9A8A	9B C3             JR	Z,BRANCH_99C9
9A8C	B7 0E             CPA	0E
9A8E	89 05             JR	NZ,BRANCH_9A95
9A90	EB 78 B0 10       OR	(78B0),10
9A94	9A                RET

BRANCH_9A95:
9A95	B7 0F             CPA	0F
9A97	99 D0             JR	NZ,BRANCH_99C9
9A99	E9 78 B0 EF       AND	(78B0),EF
9A9D	9A                RET


SUB_9A9E:
9A9E	68 00             LD	H,00
9AA0	2A                STA	L
9AA1	B7 20             CPA	20
9AA3	81 5B             JR	NC,BRANCH_9B00
9AA5	8B 21             JR	Z,BRANCH_9AC8
9AA7	B7 80             CPA	80
9AA9	81 21             JR	NC,BRANCH_9ACC
9AAB	B5 04             LDA	04
9AAD	ED 78 BE FF       BIT	(78BE),FF
9AB1	89 09             JR	NZ,BRANCH_9ABC
9AB3	6E A1             CP	L,A1
9AB5	81 0F             JR	NC,BRANCH_9AC6
9AB7	6E E0             CP	L,E0
9AB9	83 0B             JR	C,BRANCH_9AC6

BRANCH_9ABB:
9ABB	DD                INC	A

BRANCH_9ABC:
9ABC	FD 0A             POP	BC
9ABE	FD CA             ADD	BC
9AC0	45                LDI	(BC)
9AC1	FD CA             ADD	BC
9AC3	24                LDA	L
9AC4	FD 5E             LD	PC,BC

BRANCH_9AC6:
9AC6	6A 20             LD	L,20

BRANCH_9AC8:
9AC8	B5 07             LDA	07
9ACA	9E 10             JR	BRANCH_9ABC

BRANCH_9ACC:
9ACC	A5 78 B5          LDA	(78B5)
9ACF	B7 C0             CPA	C0
9AD1	24                LDA	L
9AD2	83 28             JR	C,BRANCH_9AFC
9AD4	B1 5A             SBC	5A
9AD6	81 20             JR	NC,BRANCH_9AF8
9AD8	B7 06             CPA	06
9ADA	83 03             JR	C,BRANCH_9ADF
9ADC	DD                INC	A
9ADD	8E 14             JR	BRANCH_9AF3

BRANCH_9ADF:
9ADF	ED 78 B5 80       BIT	(78B5),80
9AE3	8B 17             JR	Z,BRANCH_9AFC
9AE5	B1 20             SBC	20
9AE7	81 13             JR	NC,BRANCH_9AFC
9AE9	B3 06             ADC	06
9AEB	B7 0A             CPA	0A
9AED	8B 0D             JR	Z,BRANCH_9AFC
9AEF	81 02             JR	NC,BRANCH_9AF3
9AF1	B5 0A             LDA	0A

BRANCH_9AF3:
9AF3	28                STA	H
9AF4	B5 06             LDA	06
9AF6	9E 3C             JR	BRANCH_9ABC

BRANCH_9AF8:
9AF8	B1 CB             SBC	CB
9AFA	9B 09             JR	Z,BRANCH_9AF3

BRANCH_9AFC:
9AFC	B5 03             LDA	03
9AFE	9E 44             JR	BRANCH_9ABC

BRANCH_9B00:
9B00	B1 0C             SBC	0C
9B02	9B 48             JR	Z,BRANCH_9ABC
9B04	B5 01             LDA	01
9B06	6E 0C             CP	L,0C
9B08	9B 4E             JR	Z,BRANCH_9ABC
9B0A	9E 51             JR	BRANCH_9ABB
9B0C	FD 98             PUSH	DE
9B0E	A4                LDA	H
9B0F	D9                SL
9B10	48 84             LD	B,84
9B12	4A 98             LD	C,98
9B14	FD CA             ADD	BC
9B16	5A 00             LD	E,00
9B18	58 7A             LD	D,7A
9B1A	B5 7A             LDA	7A
9B1C	51                STI	(DE)
9B1D	B5 02             LDA	02
9B1F	51                STI	(DE)
9B20	B5 7A             LDA	7A
9B22	51                STI	(DE)
9B23	B5 04             LDA	04
9B25	51                STI	(DE)
9B26	45                LDI	(BC)
9B27	2A                STA	L
9B28	45                LDI	(BC)
9B29	0A                STA	C
9B2A	8E 13             JR	BRANCH_9B3F

SUB_9B2C:
9B2C	A4                LDA	H
9B2D	4A 75             LD	C,75
9B2F	48 84             LD	B,84
9B31	FD CA             ADD	BC
9B33	D9                SL
9B34	D9                SL
9B35	6A 04             LD	L,04
9B37	FD CA             ADD	BC
9B39	FD 98             PUSH	DE
9B3B	5A 00             LD	E,00
9B3D	58 7A             LD	D,7A

BRANCH_9B3F:
9B3F	F5                LDI
9B40	88 03             DJC	BRANCH_9B3F
9B42	FD 18             LD	BC,DE
9B44	FD 1A             POP	DE
9B46	9A                RET


SUB_9B47:
9B47	FD A8             PUSH	HL
9B49	B5 FF             LDA	FF
9B4B	A7 7B 0F          CPA	(7B0F)
9B4E	8B 04             JR	Z,BRANCH_9B54
9B50	E9 7B 0F 00       AND	(7B0F),00

BRANCH_9B54:
9B54	AE 7B 08          STA	(7B08)
9B57	FD 98             PUSH	DE
9B59	BE 97 BA          CALL	SUB_97BA
9B5C	FD 1A             POP	DE
9B5E	83 0F             JR	C,BRANCH_9B6F
9B60	BE 98 02          CALL	SUB_9802
9B63	24                LDA	L
9B64	CD 34 03 09 09    SBR	(34),03,09,BRANCH_9B72,0E,BRANCH_9B77,11,BRANCH_9B7C,13,BRANCH_9B7D
	0E 0C 11 0F 13 
	0E 

BRANCH_9B6F:
9B6F	FD 2A             POP	HL
9B71	9A                RET

BRANCH_9B72:
9B72	BE 9E 20          CALL	SUB_9E20
9B75	9E 08             JR	BRANCH_9B6F

BRANCH_9B77:
9B77	FD 2A             POP	HL
9B79	BA 8D 04          JP	SUB_8D04

BRANCH_9B7C:
9B7C	F9                RCF

BRANCH_9B7D:
9B7D	04                LDA	C
9B7E	FB                SCF
9B7F	B1 7C             SBC	7C
9B81	AD 76 4E          XOR	(HIGHLCDFLAG)
9B84	D5                SR
9B85	93 18             JR	C,BRANCH_9B6F
9B87	ED 76 4E 10       BIT	(HIGHLCDFLAG),10
9B8B	9B 1E             JR	Z,BRANCH_9B6F
9B8D	FD 2A             POP	HL
9B8F	FD 0A             POP	BC
9B91	44                INC	BC
9B92	44                INC	BC
9B93	FD 5E             LD	PC,BC

SUB_9B95:
9B95	BE 99 D6          CALL	SUB_99D6
9B98	A5 78 58          LDA	(SETCOM_REG)
9B9B	B9 E0             AND	E0
9B9D	F1                AEX
9B9E	D5                SR
9B9F	4A 96             LD	C,96
9BA1	48 86             LD	B,86
9BA3	FD CA             ADD	BC
9BA5	05                LDA	(BC)
9BA6	2A                STA	L


BRANCH_9BA7:
9BA7	BE 9B 47          CALL	SUB_9B47
9BAA	8E 02             JR	BRANCH_9BAE
9BAC	FB                SCF
9BAD	9A                RET

BRANCH_9BAE:
9BAE	FD ED F0 0F 20    BIT#	(PC1500_PRT_B),20
9BB3	9B 0E             JR	Z,BRANCH_9BA7

BRANCH_9BB5:
9BB5	62                DEC	L
9BB6	81 06             JR	NC,BRANCH_9BBE

BRANCH_9BB8:
9BB8	BE 9B 47          CALL	SUB_9B47
9BBB	8E 02             JR	BRANCH_9BBF
9BBD	FB                SCF


BRANCH_9BBE:
9BBE	9A                RET

BRANCH_9BBF:
9BBF	FD ED F0 0F 20    BIT#	(PC1500_PRT_B),20
9BC4	99 0E             JR	NZ,BRANCH_9BB8
9BC6	88 21             DJC	BRANCH_9BA7
9BC8	F9                RCF
9BC9	9A                RET
9BCA	A5 78 B9          LDA	(ON_ERR_ADD_H)
9BCD	2A                STA	L
9BCE	9E 1B             JR	BRANCH_9BB5


SUB_9B95_ALT_E1:
9BD0	FD C1             SDP
9BD2	ED 78 A8 80       BIT	(78A8),80
9BD6	99 1A             JR	NZ,BRANCH_9BBE
9BD8	BE DF E2          CALL	SUB85
9BDB	81 29             JR	NC,BRANCH_9C06
9BDD	FD 5A             LD	DE,BC

BRANCH_9BDF:
9BDF	FD A8             PUSH	HL
9BE1	15                LDA	(DE)
9BE2	BE 9C 0A          CALL	BRANCH_9CA0
9BE5	8E 03             JR	9BEA
9BE7	FD 2A             POP	HL
9BE9	9A                RET
9BEA	FD 2A             POP	HL
9BEC	62                DEC	L
9BED	83 04             JR	C,BRANCH_9BF3
9BEF	FD 62             DEC	H
9BF1	81 13             JR	NC,BRANCH_9C06

BRANCH_9BF3:
9BF3	A5 78 B5          LDA	(78B5)
9BF6	D9                SL
9BF7	81 0E             JR	NC,BRANCH_9C07
9BF9	D9                SL
9BFA	81 05             JR	NC,BRANCH_9C01
9BFC	15                LDA	(DE)
9BFD	B7 0D             CPA	0D
9BFF	89 06             JR	NZ,BRANCH_9C07

BRANCH_9C01:
9C01	BE 9B 47          CALL	SUB_9B47
9C04	8E 01             JR	BRANCH_9C07

BRANCH_9C06:
9C06	9A                RET

BRANCH_9C07:
9C07	54                INC	DE
9C08	9E 2B             JR	BRANCH_9BDF


BRANCH_9CA0:
9C0A	BE 9A 9E          CALL	SUB_9A9E
9C0D	0E                STA	(BC)
9C0E	0C                DSBC	(BC)
9C0F	0A                STA	C
9C10	08                STA	B
9C11	06                CPA	C
9C12	04                LDA	C
9C13	02                ADC	C
9C14	00                SBC	C
9C15	F9                RCF
9C16	F9                RCF
9C17	F9                RCF
9C18	F9                RCF
9C19	F9                RCF
9C1A	F9                RCF
9C1B	F9                RCF
9C1C	B5 21             LDA	21
9C1E	ED 78 B5 80       BIT	(78B5),80
9C22	8B 0A             JR	Z,BRANCH_9C2E
9C24	B5 29             LDA	29
9C26	ED 78 B5 40       BIT	(78B5),40
9C2A	8B 02             JR	Z,BRANCH_9C2E
9C2C	B5 31             LDA	31

BRANCH_9C2E:
9C2E	FD CA             ADD	BC
9C30	45                LDI	(BC)
9C31	FD CA             ADD	BC
9C33	24                LDA	L
9C34	FD 5E             LD	PC,BC
9C36	29                AND	(HL)
9C37	16                CPA	E
9C38	27                CPA	(HL)
9C39	33                ADC	(MN)
9C3A	25                LDA	(HL)
9C3B	38                NOP
9C3C	37                CPA	(MN)
9C3D	20                SBC	L
9C3E	55                LDI	(DE)
9C3F	42                DEC	C
9C40	53                STD	(DE)
9C41	AB 51 A9          OR	(51A9)
9C44	39                AND	(MN)
9C45	4C B3             CP	B,B3
9C47	B2                ADC	M
9C48	B1 B0             SBC	B0
9C4A	AF A1 A1          BIT	(A1A1)
9C4D	A4                LDA	H
9C4E	B5 7A             LDA	7A
9C50	AE 78 5E          STA	(785E)
9C53	E9 78 5D 00       AND	(785D),00
9C57	BE 9B 2C          CALL	SUB_9B2C
9C5A	B5 80             LDA	80
9C5C	8E 0A             JR	9C68
9C5E	B5 20             LDA	20
9C60	FD C8             PUSH	A
9C62	CC BE             LDS	(BE)
9C64	CA 5D             STS	(5D)
9C66	FD 8A             POP	A
9C68	BE ED 4D          CALL	CURMOVONECHAR
9C6B	8E 77             JR	9CE4
9C6D	BE ED EF          CALL	GRAPHDISP
9C70	EF 78 75 01       ADD	(7875),01
9C74	9A                RET


SEPARATOR_9C75:
9C75	FF 00 FF 00 FF 00 FF 00   FF 

9C7E	6A 20 8E 12 BE 9B 0C B5   78 AE 78 5E E9 78 5D 00 
9C8E	6A 80 8E 02 


SUB_9C92:
9C92	6A 00             LD	L,00
9C94	A5 79 F1          LDA	(BATT/PEN_FLAG)
9C97	89 50             JR	NZ,BRANCH_9CE9
9C99	ED 78 56 60       BIT	(ZONE_REG),60
9C9D	8B 4E             JR	Z,BRANCH_9CED
9C9F	24                LDA	L
9CA0	E9 78 B8 00       AND	(78B8),00
9CA4	28                STA	H
9CA5	A4                LDA	H
9CA6	8B 0D             JR	Z,BRANCH_9CB5
9CA8	A5 79 E6          LDA	(79E6)
9CAB	B7 D8             CPA	D8
9CAD	81 06             JR	NC,BRANCH_9CB5
9CAF	A4                LDA	H
9CB0	AE 78 B8          STA	(78B8)
9CB3	68 00             LD	H,00

BRANCH_9CB5:
9CB5	FD BE             DI
9CB7	FD E9 B0 0D BF    AND#	(CE150_PRT_B_DIR),BF
9CBC	FD A5 B0 0F       LDA#	(CE150_PRT_B)
9CC0	FD A9 B0 0F       AND#	(CE150_PRT_B)
9CC4	FD A9 B0 0F       AND#	(CE150_PRT_B)
9CC8	BF 40             BIT	40
9CCA	38                NOP
9CCB	38                NOP
9CCC	FD E9 B0 0F BF    AND#	(CE150_PRT_B),BF
9CD1	FD EB B0 0D 40    OR#	(CE150_PRT_B_DIR),40
9CD6	FD 98             PUSH	DE
9CD8	BE 9E 66          CALL	SUB_9E66
9CDB	FD 81             EI
9CDD	FD 1A             POP	DE
9CDF	A5 78 B8          LDA	(78B8)
9CE2	99 44             JR	NZ,9CA0
9CE4	CC BE             LDS	(BE)
9CE6	CA 5D             STS	(5D)
9CE8	9A                RET

BRANCH_9CE9:
9CE9	9A                RET
9CEA	9A                RET
9CEB	9A                RET
9CEC	9A                RET

BRANCH_9CED:
9CED	9A                RET

9CEE	6A 20 8E 08 ED 78 55 10   8B 02 6A 0A 24 6A FF 68 
9CFE	00 FD C8 BE 81 69 81 19   BF 20 89 18 62 83 0E FD 
9D0E	60 83 14 BE 9B 47 8E 05   FD 8A BA 9B 8F FD 8A 9E 
9D1E	20 FD 8A 9A BA 8C FD B5   08 BA 8D 0B 


SUB_9D2A:
9D2A	04                LDA	C
9D2B	AE 78 AB          STA	(78AB)
9D2E	84                LDA	B
9D2F	AE 78 AA          STA	(78AA)
9D32	E9 78 B1 00       AND	(78B1),00
9D36	FB                SCF
9D37	8E 1E             JR	BRANCH_9D57


SUB_9D39:
9D39	E9 78 91 00       AND	(7891),00
9D3D	EB 78 B1 01       OR	(78B1),01
9D41	CC A0             LDS	(A0)
9D43	F4 78 A8          LDU	(78A8)
9D46	BE DF E2          CALL	SUB85
9D49	CC A8             LDS	(A8)

SUB_9D4B:
9D4B	EB 78 B1 02       OR	(78B1),02
9D4F	04                LDA	C
9D50	AE 78 AD          STA	(78AD)
9D53	84                LDA	B
9D54	AE 78 AC          STA	(78AC)

BRANCH_9D57:
9D57	E9 78 B5 7F       AND	(78B5),7F
9D5B	B5 69             LDA	69
9D5D	AE 78 BC          STA	(78BC)
9D60	ED 78 A8 80       BIT	(78A8),80
9D64	89 4E             JR	NZ,BRANCH_9DB4
9D66	58 FF             LD	D,FF
9D68	81 6A             JR	NC,BRANCH_9DD4
9D6A	8E 10             JR	BRANCH_9D7C

BRANCH_9D6C:
9D6C	62                DEC	L
9D6D	83 04             JR	C,BRANCH_9D73
9D6F	FD 62             DEC	H
9D71	81 61             JR	NC,BRANCH_9DD4

BRANCH_9D73:
9D73	44                INC	BC
9D74	ED 78 B1 02       BIT	(78B1),02
9D78	8B 02             JR	Z,BRANCH_9D7C
9D7A	46                DEC	BC
9D7B	46                DEC	BC

BRANCH_9D7C:
9D7C	05                LDA	(BC)
9D7D	B7 80             CPA	80
9D7F	81 0B             JR	NC,BRANCH_9D8C
9D81	A5 78 BE          LDA	(78BE)
9D84	8B 0E             JR	Z,BRANCH_9D94
9D86	EF 78 BC 01       ADD	(78BC),01
9D8A	8E 0C             JR	BRANCH_9D98

BRANCH_9D8C:
9D8C	B7 20             CPA	20
9D8E	81 59             JR	NC,BRANCH_9DE9
9D90	89 02             JR	NZ,BRANCH_9D94

BRANCH_9D92:
9D92	FD 5A             LD	DE,BC

BRANCH_9D94:
9D94	EF 78 BC 06       ADD	(78BC),06

BRANCH_9D98:
9D98	91 2E             JR	NC,BRANCH_9D6C
9D9A	A5 78 B1          LDA	(78B1)
9D9D	89 3C             JR	NZ,BRANCH_9DDB
9D9F	94                LDA	D
9DA0	46                DEC	BC
9DA1	DD                INC	A
9DA2	8B 0E             JR	Z,BRANCH_9DB2
9DA4	FD 18             LD	BC,DE
9DA6	05                LDA	(BC)
9DA7	B7 0D             CPA	0D
9DA9	89 07             JR	NZ,BRANCH_9DB2
9DAB	44                INC	BC
9DAC	05                LDA	(BC)
9DAD	B7 0D             CPA	0D
9DAF	8B 01             JR	Z,BRANCH_9DB2
9DB1	46                DEC	BC

BRANCH_9DB2:
9DB2	CA AC             STS	(AC)

BRANCH_9DB4:
9DB4	A5 78 B4          LDA	(ERRORLINE)
9DB7	AE 78 B4          STA	(ERRORLINE)
9DBA	F2                CLS
9DBB	AE 78 75          STA	(7875)
9DBE	AE 78 7F          STA	(787F)
9DC1	B5 74             LDA	74
9DC3	AE 78 7E          STA	(787E)
9DC6	ED 78 A8 80       BIT	(78A8),80
9DCA	99 DF             JR	NZ,BRANCH_9CED
9DCC	CC AA             LDS	(AA)
9DCE	F4 78 AC          LDU	(78AC)
9DD1	BA 9B D0          JP	SUB_9B95_ALT_E1

BRANCH_9DD4:
9DD4	A5 78 B1          LDA	(78B1)
9DD7	9B 27             JR	Z,BRANCH_9DB2
9DD9	8E 0A             JR	BRANCH_9DE5

BRANCH_9DDB:
9DDB	D5                SR
9DDC	83 06             JR	C,BRANCH_9DE4
9DDE	94                LDA	D
9DDF	DD                INC	A
9DE0	8B 02             JR	Z,BRANCH_9DE4
9DE2	FD 18             LD	BC,DE

BRANCH_9DE4:
9DE4	44                INC	BC

BRANCH_9DE5:
9DE5	CA AA             STS	(AA)
9DE7	9E 35             JR	BRANCH_9DB4

BRANCH_9DE9:
9DE9	B7 0D             CPA	0D
9DEB	99 81             JR	NZ,BRANCH_9D6C
9DED	A5 78 B1          LDA	(78B1)
9DF0	D5                SR
9DF1	93 5F             JR	C,BRANCH_9D94
9DF3	ED 7B 0F 02       BIT	(7B0F),02
9DF7	9B 67             JR	Z,BRANCH_9D92
9DF9	D5                SR
9DFA	91 4A             JR	NC,BRANCH_9DB2
9DFC	9E 1A             JR	BRANCH_9DE4


SEPARATOR_9DFE:
9DFE	00 FF EC 24 00 FF 00 FF   00 FF 00 FF 00 FF 00 FF 
9E0E	00 FF 00 FF 00 FF 00 FF   00 FF 00 FF 00 FF 00 FF 
9E1E	00 FF 


SUB_9E20:
9E20	6A 40             LD	L,40
9E22	A5 76 4E          LDA	(HIGHLCDFLAG)
9E25	D5                SR
9E26	87 07             JR	H,BRANCH_9E2F
9E28	6A 20             LD	L,20
9E2A	D5                SR
9E2B	85 02             JR	NH,BRANCH_9E2F
9E2D	6A 10             LD	L,10

BRANCH_9E2F:
9E2F	E9 76 4E 0F       AND	(HIGHLCDFLAG),0F
9E33	24                LDA	L
9E34	AB 76 4E          OR	(HIGHLCDFLAG)
9E37	AE 76 4E          STA	(HIGHLCDFLAG)
9E3A	9A                RET


SUB_9E3B:
9E3B	45                LDI	(BC)
9E3C	FB                SCF
9E3D	B1 30             SBC	30
9E3F	81 0F             JR	NC,BRANCH_9E50
9E41	B7 17             CPA	17
9E43	83 0A             JR	C,BRANCH_9E4F
9E45	B7 0A             CPA	0A
9E47	81 06             JR	NC,BRANCH_9E4F
9E49	B1 11             SBC	11
9E4B	81 03             JR	NC,BRANCH_9E50
9E4D	B3 09             ADC	09

BRANCH_9E4F:
9E4F	9A                RET

BRANCH_9E50:
9E50	FB                SCF
9E51	9A                RET

9E52	B8                SPV
9E53	F5                LDI
9E54	88 03             DJC	9E53
9E56	A8                RPV
9E57	9A                RET
9E58	B8                SPV
9E59	BE 7A 1C          CALL	7A1C

9E5C	BE A7 47          CALL	A747
9E5F	A8                RPV
9E60	9A                RET

9E61	BE A7 69          CALL	A769
9E64	A8                RPV
9E65	9A                RET


SUB_9E66:
9E66	4A 52             LD	C,52
9E68	48 9E             LD	B,9E
9E6A	5A F1             LD	E,F1
9E6C	58 7A             LD	D,7A
9E6E	6A 09             LD	L,09

BRANCH_9E70:
9E70	F5                LDI
9E71	88 03             DJC	BRANCH_9E70
9E73	6A 04             LD	L,04
9E75	B5 05             LDA	05
9E77	ED 78 56 20       BIT	(ZONE_REG),20
9E7B	89 02             JR	NZ,BRANCH_9E7F
9E7D	FD CA             ADD	BC

BRANCH_9E7F:
9E7F	F5                LDI
9E80	88 03             DJC	BRANCH_9E7F
9E82	A4                LDA	H
9E83	4A 5B             LD	C,5B
9E85	48 A7             LD	B,A7
9E87	8B 0C             JR	Z,BRANCH_9E95
9E89	ED 78 56 20       BIT	(ZONE_REG),20
9E8D	89 02             JR	NZ,BRANCH_9E91
9E8F	4A 81             LD	C,81

BRANCH_9E91:
9E91	6A C3             LD	L,C3
9E93	8E 0E             JR	BRANCH_9EA3

BRANCH_9E95:
9E95	4A CB             LD	C,CB
9E97	48 A9             LD	B,A9
9E99	ED 78 56 20       BIT	(ZONE_REG),20
9E9D	89 02             JR	NZ,BRANCH_9EA1
9E9F	4A F1             LD	C,F1

BRANCH_9EA1:
9EA1	6A 5F             LD	L,5F

BRANCH_9EA3:
9EA3	5A 1C             LD	E,1C
9EA5	58 7A             LD	D,7A
9EA7	BE 7A F1          CALL	7AF1
9EAA	B5 FA             LDA	FA
9EAC	6C 00             CP	H,00
9EAE	89 02             JR	NZ,BRANCH_9EB2
9EB0	B5 F8             LDA	F8

BRANCH_9EB2:
9EB2	FD DA             ADD	DE
9EB4	FD 52             DEC	D
9EB6	B5 38             LDA	38
9EB8	51                STI	(DE)
9EB9	51                STI	(DE)
9EBA	51                STI	(DE)
9EBB	4A EC             LD	C,EC
9EBD	48 7A             LD	B,7A
9EBF	A4                LDA	H
9EC0	0E                STA	(BC)
9EC1	89 0A             JR	NZ,BRANCH_9ECD
9EC3	B5 7A             LDA	7A
9EC5	AE 7A 2A          STA	(7A2A)
9EC8	B5 39             LDA	39
9ECA	AE 7A 2B          STA	(7A2B)

BRANCH_9ECD:
9ECD	BA 7A F7          JP	7AF7


JMP_9ED0:
9ED0	ED 78 B0 08       BIT	(78B0),08
9ED4	8B 27             JR	Z,BRANCH_9EFD
9ED6	B7 80             CPA	80
9ED8	81 0A             JR	NC,BRANCH_9EE4
9EDA	ED 78 B0 20       BIT	(78B0),20
9EDE	89 1D             JR	NZ,BRANCH_9EFD
9EE0	B5 0E             LDA	0E
9EE2	8E 0C             JR	BRANCH_9EF0

BRANCH_9EE4:
9EE4	B7 20             CPA	20
9EE6	81 15             JR	NC,BRANCH_9EFD
9EE8	ED 78 B0 20       BIT	(78B0),20
9EEC	8B 0F             JR	Z,BRANCH_9EFD
9EEE	B5 0F             LDA	0F

BRANCH_9EF0:
9EF0	BE 81 BC          CALL	SUB_81BC
9EF3	83 0E             JR	C,BRANCH_9F03
9EF5	A5 78 B0          LDA	(78B0)
9EF8	BD 20             XOR	20
9EFA	AE 78 B0          STA	(78B0)

BRANCH_9EFD:
9EFD	A5 7B D8          LDA	(7BD8)
9F00	BA 90 B1          JP	JMP_90B1

BRANCH_9F03:
9F03	BA 90 EC          JP	SUB_PRINT#_ALT_X1
9F06	A9 78 B4          AND	(ERRORLINE)
9F09	8B 0D             JR	Z,BRANCH_9F18
9F0B	4A 0E             LD	C,0E
9F0D	48 00             LD	B,00
9F0F	CD 24             SBR	(24)
9F11	FD BE             DI
9F13	BE 8A 07          CALL	UNKNOWN_CMD_89F5_ALT_E1
9F16	FD 81             EI

BRANCH_9F18:
9F18	BA 92 3E          JP	SUB_PRINT#_ALT_E1
9F1B	A9 78 B4          AND	(ERRORLINE)
9F1E	9B 08             JR	Z,BRANCH_9F18
9F20	B5 03             LDA	03

BRANCH_9F22:
9F22	BA 90 72          JP	UNKNOWN_JMP_9072

JMP_9F25:
9F25	A5 78 96          LDA	(7896)
9F28	B7 80             CPA	80
9F2A	91 0A             JR	NC,BRANCH_9F22
9F2C	B7 A0             CPA	A0
9F2E	93 0E             JR	C,BRANCH_9F22
9F30	B9 7F             AND	7F
9F32	BA 91 BC          JP	JMP_91BC

JMP_9F35:
9F35	A5 78 84          LDA	(CUR_VAR_ADD_L)
9F38	B7 07             CPA	07
9F3A	89 2C             JR	NZ,BRANCH_9F68
9F3C	ED 78 B4 04       BIT	(ERRORLINE),04
9F40	8B 26             JR	Z,BRANCH_9F68
9F42	BE 87 45          CALL	SUB_8745
9F45	6A 21             LD	L,21
9F47	A5 78 93          LDA	(7893)
9F4A	08                STA	B
9F4B	A5 78 94          LDA	(7894)
9F4E	0A                STA	C
9F4F	B5 E7             LDA	E7
9F51	ED 78 91 FF       BIT	(7891),FF
9F55	8B 04             JR	Z,BRANCH_9F5B
9F57	A5 78 92          LDA	(7892)
9F5A	DD                INC	A

BRANCH_9F5B:
9F5B	AE 78 92          STA	(7892)
9F5E	F9                RCF
9F5F	B1 E6             SBC	E6
9F61	FD CA             ADD	BC
9F63	24                LDA	L
9F64	0E                STA	(BC)
9F65	BA 90 E1          JP	JMP_90E1

BRANCH_9F68:
9F68	A5 78 B2          LDA	(78B2)
9F6B	BA 92 09          JP	JMP_9209

9F6E	92 05 BA 8D 00 FF 00 


SUB_9F75:
9F75	ED 78 8E 01       BIT	(TRACE_ON),01
9F79	89 13             JR	NZ,BRANCH_9F8E
9F7B	68 78             LD	H,78
9F7D	69 60             AND	(HL),60
9F7F	45                LDI	(BC)
9F80	2B                OR	(HL)
9F81	8E 01             JR	BRANCH_9F84

BRANCH_9F83:
9F83	45                LDI	(BC)

BRANCH_9F84:
9F84	2E                STA	(HL)
9F85	62                DEC	L
9F86	6E 51             CP	L,51
9F88	93 07             JR	C,BRANCH_9F83
9F8A	69 0F             AND	(HL),0F
9F8C	6B 03             OR	(HL),03

BRANCH_9F8E:
9F8E	FD A5 D0 0E       LDA#	(CE158_PRT_A)
9F92	B9 C0             AND	C0
9F94	B7 80             CPA	80
9F96	89 02             JR	NZ,BRANCH_9F9A
9F98	B5 A0             LDA	A0

BRANCH_9F9A:
9F9A	ED 78 8E 01       BIT	(TRACE_ON),01
9F9E	8B 07             JR	Z,BRANCH_9FA7
9FA0	E9 78 57 1F       AND	(SETDEV_VAL),1F
9FA4	AB 78 57          OR	(SETDEV_VAL)

BRANCH_9FA7:
9FA7	AE 78 57          STA	(SETDEV_VAL)
9FAA	FD EB D0 0C C0    OR#	(CE158_PRT_A_DIR),C0
9FAF	ED 78 8E 80       BIT	(TRACE_ON),80
9FB3	89 1A             JR	NZ,BRANCH_9FCF
9FB5	FD A5 D0 0E       LDA#	(CE158_PRT_A)
9FB9	6A 28             LD	L,28
9FBB	68 0A             LD	H,0A

BRANCH_9FBD:
9FBD	88 02             DJC	BRANCH_9FBD
9FBF	FD 62             DEC	H
9FC1	93 06             JR	C,BRANCH_9FBD
9FC3	FD A9 D0 0E       AND#	(CE158_PRT_A)
9FC7	BF 20             BIT	20
9FC9	8B 04             JR	Z,BRANCH_9FCF
9FCB	EB 7A 22 01       OR	(MATH_REG_Va_B3),01

BRANCH_9FCF:
9FCF	9A                RET


SUB_9FD0:
9FD0	FD C8             PUSH	A
9FD2	FD A5 D0 0E       LDA#	(CE158_PRT_A)
9FD6	B9 FC             AND	FC
9FD8	ED 78 50 01       BIT	(OUTSTAT_REG),01
9FDC	8B 01             JR	Z,BRANCH_9FDF
9FDE	DD                INC	A

BRANCH_9FDF:
9FDF	ED 78 50 02       BIT	(OUTSTAT_REG),02
9FE3	8B 02             JR	Z,BRANCH_9FE7
9FE5	DD                INC	A
9FE6	DD                INC	A

BRANCH_9FE7:
9FE7	FD AE D0 0E       STA#	(CE158_PRT_A)
9FEB	FD 8A             POP	A
9FED	9A                RET
9FEE	79 FD             AND	(MN),FD


SUB_9FEF:
9FEF	FD E9 B0 0A FD    AND#	(CE150_MSK_REG),FD
9FF4	ED 79 F1 FF       BIT	(BATT/PEN_FLAG),FF
9FF8	89 05             JR	NZ,BRANCH_9FFF
9FFA	FD EB B0 0A 02    OR#	(CE150_MSK_REG),02

BRANCH_9FFF:
9FFF	9A                RET

A000	.SKIP	0010

