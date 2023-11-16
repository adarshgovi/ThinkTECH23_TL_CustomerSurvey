;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1034 (Dec 12 2012) (MSVC)
; This file was generated Fri Oct 18 13:22:40 2013
;--------------------------------------------------------
$name DE2_Boot
$optc51 --model-small
	R_DSEG    segment data
	R_CSEG    segment code
	R_BSEG    segment bit
	R_XSEG    segment xdata
	R_PSEG    segment xdata
	R_ISEG    segment idata
	R_OSEG    segment data overlay
	BIT_BANK  segment data overlay
	R_HOME    segment code
	R_GSINIT  segment code
	R_IXSEG   segment xdata
	R_CONST   segment code
	R_XINIT   segment code
	R_DINIT   segment code

;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	public _Write_XRAM_PARM_2
	public _Out_Byte_Flash_PARM_2
	public _seven_seg
	public _hexval
	public _counter_prog
	public _dummy_switch
	public _main
	public _Manual_Load
	public _read_hex_in
	public _OutWord
	public _OutByte
	public _str2hex
	public _loadintelhex
	public _Load_Ram_Fast
	public _FlashByte
	public _Read_XRAM
	public _Write_XRAM
	public _EraseSector
	public _In_Byte_Flash
	public _Out_Byte_Flash
	public _getbyte
	public _chartohex
	public _sends
	public _getchare
	public _inituart
	public _de2_8052_crt0
	public _getchar_echo
	public _testbit
	public _serialmode
	public _buff
	public _FlashByte_PARM_2
	public _putchar
	public _getchar
;--------------------------------------------------------
; Special Function Registers
;--------------------------------------------------------
_P0             DATA 0x80
_SP             DATA 0x81
_DPL            DATA 0x82
_DPH            DATA 0x83
_PCON           DATA 0x87
_TCON           DATA 0x88
_TMOD           DATA 0x89
_TL0            DATA 0x8a
_TL1            DATA 0x8b
_TH0            DATA 0x8c
_TH1            DATA 0x8d
_P1             DATA 0x90
_SCON           DATA 0x98
_SBUF           DATA 0x99
_P2             DATA 0xa0
_IE             DATA 0xa8
_P3             DATA 0xb0
_IP             DATA 0xb8
_PSW            DATA 0xd0
_ACC            DATA 0xe0
_B              DATA 0xf0
_T2CON          DATA 0xc8
_RCAP2L         DATA 0xca
_RCAP2H         DATA 0xcb
_TL2            DATA 0xcc
_TH2            DATA 0xcd
_DPS            DATA 0x86
_DPH1           DATA 0x85
_DPL1           DATA 0x84
_HEX0           DATA 0x91
_HEX1           DATA 0x92
_HEX2           DATA 0x93
_HEX3           DATA 0x94
_HEX4           DATA 0x8e
_HEX5           DATA 0x8f
_HEX6           DATA 0x96
_HEX7           DATA 0x97
_LEDRA          DATA 0xe8
_LEDRB          DATA 0x95
_LEDRC          DATA 0x9e
_LEDG           DATA 0xf8
_SWA            DATA 0xe8
_SWB            DATA 0x95
_SWC            DATA 0x9e
_KEY            DATA 0xf8
_P0MOD          DATA 0x9a
_P1MOD          DATA 0x9b
_P2MOD          DATA 0x9c
_P3MOD          DATA 0x9d
_LCD_CMD        DATA 0xd8
_LCD_DATA       DATA 0xd9
_LCD_MOD        DATA 0xda
_JCMD           DATA 0xc0
_JBUF           DATA 0xc1
_JCNT           DATA 0xc2
_REP_ADD_L      DATA 0xf1
_REP_ADD_H      DATA 0xf2
_REP_VALUE      DATA 0xf3
_DEBUG_CALL_L   DATA 0xfa
_DEBUG_CALL_H   DATA 0xfb
_BPC            DATA 0xfc
_BPS            DATA 0xfd
_BPAL           DATA 0xfe
_BPAH           DATA 0xff
_LBPAL          DATA 0xfa
_LBPAH          DATA 0xfb
_XRAMUSEDAS     DATA 0xc3
_FLASH_CMD      DATA 0xdb
_FLASH_DATA     DATA 0xdc
_FLASH_MOD      DATA 0xdd
_FLASH_ADD0     DATA 0xe1
_FLASH_ADD1     DATA 0xe2
_FLASH_ADD2     DATA 0xe3
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
_P0_0           BIT 0x80
_P0_1           BIT 0x81
_P0_2           BIT 0x82
_P0_3           BIT 0x83
_P0_4           BIT 0x84
_P0_5           BIT 0x85
_P0_6           BIT 0x86
_P0_7           BIT 0x87
_IT0            BIT 0x88
_IE0            BIT 0x89
_IT1            BIT 0x8a
_IE1            BIT 0x8b
_TR0            BIT 0x8c
_TF0            BIT 0x8d
_TR1            BIT 0x8e
_TF1            BIT 0x8f
_P1_0           BIT 0x90
_P1_1           BIT 0x91
_P1_2           BIT 0x92
_P1_3           BIT 0x93
_P1_4           BIT 0x94
_P1_5           BIT 0x95
_P1_6           BIT 0x96
_P1_7           BIT 0x97
_RI             BIT 0x98
_TI             BIT 0x99
_RB8            BIT 0x9a
_TB8            BIT 0x9b
_REN            BIT 0x9c
_SM2            BIT 0x9d
_SM1            BIT 0x9e
_SM0            BIT 0x9f
_P2_0           BIT 0xa0
_P2_1           BIT 0xa1
_P2_2           BIT 0xa2
_P2_3           BIT 0xa3
_P2_4           BIT 0xa4
_P2_5           BIT 0xa5
_P2_6           BIT 0xa6
_P2_7           BIT 0xa7
_EX0            BIT 0xa8
_ET0            BIT 0xa9
_EX1            BIT 0xaa
_ET1            BIT 0xab
_ES             BIT 0xac
_ET2            BIT 0xad
_EA             BIT 0xaf
_P3_0           BIT 0xb0
_P3_1           BIT 0xb1
_P3_2           BIT 0xb2
_P3_3           BIT 0xb3
_P3_4           BIT 0xb4
_P3_5           BIT 0xb5
_P3_6           BIT 0xb6
_P3_7           BIT 0xb7
_RXD            BIT 0xb0
_TXD            BIT 0xb1
_INT0           BIT 0xb2
_INT1           BIT 0xb3
_T0             BIT 0xb4
_T1             BIT 0xb5
_WR             BIT 0xb6
_RD             BIT 0xb7
_PX0            BIT 0xb8
_PT0            BIT 0xb9
_PX1            BIT 0xba
_PT1            BIT 0xbb
_PS             BIT 0xbc
_PT2            BIT 0xbd
_P              BIT 0xd0
_F1             BIT 0xd1
_OV             BIT 0xd2
_RS0            BIT 0xd3
_RS1            BIT 0xd4
_F0             BIT 0xd5
_AC             BIT 0xd6
_CY             BIT 0xd7
_T2CON_0        BIT 0xc8
_T2CON_1        BIT 0xc9
_T2CON_2        BIT 0xca
_T2CON_3        BIT 0xcb
_T2CON_4        BIT 0xcc
_T2CON_5        BIT 0xcd
_T2CON_6        BIT 0xce
_T2CON_7        BIT 0xcf
_CP_RL2         BIT 0xc8
_C_T2           BIT 0xc9
_TR2            BIT 0xca
_EXEN2          BIT 0xcb
_TCLK           BIT 0xcc
_RCLK           BIT 0xcd
_EXF2           BIT 0xce
_TF2            BIT 0xcf
_LEDRA_0        BIT 0xe8
_LEDRA_1        BIT 0xe9
_LEDRA_2        BIT 0xea
_LEDRA_3        BIT 0xeb
_LEDRA_4        BIT 0xec
_LEDRA_5        BIT 0xed
_LEDRA_6        BIT 0xee
_LEDRA_7        BIT 0xef
_SWA_0          BIT 0xe8
_SWA_1          BIT 0xe9
_SWA_2          BIT 0xea
_SWA_3          BIT 0xeb
_SWA_4          BIT 0xec
_SWA_5          BIT 0xed
_SWA_6          BIT 0xee
_SWA_7          BIT 0xef
_LEDG_0         BIT 0xf8
_LEDG_1         BIT 0xf9
_LEDG_2         BIT 0xfa
_LEDG_3         BIT 0xfb
_LEDG_4         BIT 0xfc
_LEDG_5         BIT 0xfd
_LEDG_6         BIT 0xfe
_LEDG_7         BIT 0xff
_KEY_1          BIT 0xf9
_KEY_2          BIT 0xfa
_KEY_3          BIT 0xfb
_LCD_RW         BIT 0xd8
_LCD_EN         BIT 0xd9
_LCD_RS         BIT 0xda
_LCD_ON         BIT 0xdb
_LCD_BLON       BIT 0xdc
_JRXRDY         BIT 0xc0
_JTXRDY         BIT 0xc1
_JRXEN          BIT 0xc2
_JTXEN          BIT 0xc3
_JTXFULL        BIT 0xc4
_JRXFULL        BIT 0xc5
_JTXEMPTY       BIT 0xc6
_JTDI           BIT 0xc7
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	rbank0 segment data overlay
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_getbyte_j_1_82:
	ds 1
_FlashByte_PARM_2:
	ds 1
_loadintelhex_address_1_98:
	ds 2
_loadintelhex_j_1_98:
	ds 1
_loadintelhex_size_1_98:
	ds 1
_loadintelhex_type_1_98:
	ds 1
_loadintelhex_checksum_1_98:
	ds 1
_loadintelhex_n_1_98:
	ds 1
_loadintelhex_echo_1_98:
	ds 1
_main_i_1_129:
	ds 2
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
_Out_Byte_Flash_PARM_2:
	ds 1
	rseg	R_OSEG
	rseg	R_OSEG
_Write_XRAM_PARM_2:
	ds 1
	rseg	R_OSEG
	rseg	R_OSEG
_str2hex_sloc0_1_0:
	ds 2
	rseg	R_OSEG
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	rseg R_ISEG
_buff:
	ds 64
_main_ascii_1_129:
	ds 17
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	DSEG
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	rseg R_BSEG
_serialmode:
	DBIT	1
_testbit:
	DBIT	1
_getchar_echo:
	DBIT	1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_PSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	XSEG
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	rseg R_IXSEG
	rseg R_HOME
	rseg R_GSINIT
	rseg R_CSEG
;--------------------------------------------------------
; Reset entry point and interrupt vectors
;--------------------------------------------------------
	CSEG at 0xf000
	ljmp	_crt0
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	rseg R_HOME
	rseg R_GSINIT
	rseg R_GSINIT
;--------------------------------------------------------
; data variables initialization
;--------------------------------------------------------
	rseg R_DINIT
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:49: bit serialmode=0; //1: JTAG, 0:uart
	clr	_serialmode
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:50: bit testbit, getchar_echo=0;
	clr	_getchar_echo
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function 'de2_8052_crt0'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:/Source/call51/Bin/../include/mcs51/DE2_8052.h:317: void de2_8052_crt0 (void) _naked
;	-----------------------------------------
;	 function de2_8052_crt0
;	-----------------------------------------
_de2_8052_crt0:
;	naked function: no prologue.
;	C:/Source/call51/Bin/../include/mcs51/DE2_8052.h:386: _endasm;
	
	
	 rseg R_GSINIT
	 public _crt0
	_crt0:
	 mov sp,#_stack_start-1
	 lcall __c51_external_startup
	 mov a,dpl
	 jz __c51_init_data
	 ljmp __c51_program_startup
	__c51_init_data:
	
; Initialize xdata variables
	
	 mov dpl, #_R_XINIT_start
	 mov dph, #(_R_XINIT_start>>8)
	 mov _DPL1, #_R_IXSEG_start
	 mov _DPH1, #(_R_IXSEG_start>>8)
	 mov r0, #_R_IXSEG_size
	 mov r1, #(_R_IXSEG_size>>8)
	
	XInitLoop?repeat?:
	 mov a, r0
	 orl a, r1
	 jz XInitLoop?done?
	 clr a
	 mov _DPS, #0 ; Using dpl, dph
	 movc a,@a+dptr
	 inc dptr
	 mov _DPS, #1 ; Using DPL1, DPH1
	 movx @dptr, a
	 inc dptr
	 dec r0
	 cjne r0, #0xff, XInitLoop?repeat?
	 dec r1
	 sjmp XInitLoop?repeat?
	
	XInitLoop?done?:
	
; Clear xdata variables
	 mov _DPS, #0 ; Make sure we are using dpl, dph
	 mov dpl, #_R_XSEG_start
	 mov dph, #(_R_XSEG_start>>8)
	 mov r4, #_R_XSEG_size
	 mov r5, #(_R_XSEG_size>>8)
	
	XClearLoop?repeat?:
	 mov a, r4
	 orl a, r5
	 jz XClearLoop?done?
	 clr a
	 movx @dptr, a
	 inc dptr
	 dec r4
	 cjne r4, #0xff, XClearLoop?repeat?
	 dec r5
	 sjmp XClearLoop?repeat?
	
	XClearLoop?done?:
	 lcall _R_DINIT_start ; Initialize data/idata variables
	
	__c51_program_startup:
	 lcall _main
	
	forever?home?:
	 sjmp forever?home?
	
	 
;	naked function: no epilogue.
;------------------------------------------------------------
;Allocation info for local variables in function 'inituart'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:52: void inituart (void)
;	-----------------------------------------
;	 function inituart
;	-----------------------------------------
_inituart:
	using	0
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:54: RCAP2H=HIGH(TIMER_2_RELOAD);
	mov	_RCAP2H,#0xFF
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:55: RCAP2L=LOW(TIMER_2_RELOAD);
	mov	_RCAP2L,#0xF7
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:56: T2CON=0x34; // #00110100B
	mov	_T2CON,#0x34
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:57: SCON=0x52; // Serial port in mode 1, ren, txrdy, rxempty
	mov	_SCON,#0x52
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'putchar'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:60: void putchar (char c)
;	-----------------------------------------
;	 function putchar
;	-----------------------------------------
_putchar:
	mov	r2,dpl
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:62: if(serialmode==0)
	jb	_serialmode,L004010?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:64: if (c=='\n')
	cjne	r2,#0x0A,L004006?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:66: while (!TI);
L004001?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:67: TI=0;
	jbc	_TI,L004022?
	sjmp	L004001?
L004022?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:68: SBUF='\r';
	mov	_SBUF,#0x0D
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:70: while (!TI);
L004006?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:71: TI=0;
	jbc	_TI,L004023?
	sjmp	L004006?
L004023?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:72: SBUF=c;
	mov	_SBUF,r2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:76: JBUF=c; // Load transmit FIFO with value
	ret
L004010?:
	mov	_JBUF,r2
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getchar'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:80: char getchar (void)
;	-----------------------------------------
;	 function getchar
;	-----------------------------------------
_getchar:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:84: testbit=0;
	clr	_testbit
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:85: if(serialmode==0)
	jb	_serialmode,L005006?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:87: while (!RI);
L005001?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:88: RI=0;
	jbc	_RI,L005023?
	sjmp	L005001?
L005023?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:89: c=SBUF;
	mov	r2,_SBUF
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:90: if (getchar_echo==1) putchar(c);
	jnb	_getchar_echo,L005013?
	mov	dpl,r2
	push	ar2
	lcall	_putchar
	pop	ar2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:94: while(!JRXRDY); // Wait for data to arrive
	sjmp	L005013?
L005006?:
	jnb	_JRXRDY,L005006?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:96: c=JBUF; // Read receive FIFO
	mov	r2,_JBUF
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:98: if(SWB & 0x02) testbit=1;// {while (!TI); TI=0; SBUF=c;} // For debug purposes
	mov	a,_SWB
	jnb	acc.1,L005013?
	setb	_testbit
L005013?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:100: return c;
	mov	dpl,r2
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getchare'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:103: char getchare (void)
;	-----------------------------------------
;	 function getchare
;	-----------------------------------------
_getchare:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:107: c=getchar();
	lcall	_getchar
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:108: putchar(c);
	mov  r2,dpl
	push	ar2
	lcall	_putchar
	pop	ar2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:109: return c;
	mov	dpl,r2
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'sends'
;------------------------------------------------------------
;c                         Allocated to registers r2 r3 r4 
;n                         Allocated to registers r6 
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:112: void sends (unsigned char * c)
;	-----------------------------------------
;	 function sends
;	-----------------------------------------
_sends:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:115: while(n=*c)
L007001?:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r5,a
	mov	r6,a
	jz	L007004?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:117: putchar(n);
	mov	dpl,r6
	push	ar2
	push	ar3
	push	ar4
	lcall	_putchar
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:118: c++;
	inc	r2
	cjne	r2,#0x00,L007001?
	inc	r3
	sjmp	L007001?
L007004?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'chartohex'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:122: unsigned char chartohex(char c)
;	-----------------------------------------
;	 function chartohex
;	-----------------------------------------
_chartohex:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:124: if(c & 0x40) c+=9; //  a to f or A to F
	mov	a,dpl
	mov	r2,a
	jnb	acc.6,L008002?
	mov	a,#0x09
	add	a,r2
	mov	r2,a
L008002?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:125: return (c & 0xf);
	mov	a,#0x0F
	anl	a,r2
	mov	dpl,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getbyte'
;------------------------------------------------------------
;j                         Allocated with name '_getbyte_j_1_82'
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:129: unsigned char getbyte (void)
;	-----------------------------------------
;	 function getbyte
;	-----------------------------------------
_getbyte:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:133: j=chartohex(getchare())*0x10;
	lcall	_getchare
	lcall	_chartohex
	mov	a,dpl
	swap	a
	anl	a,#0xf0
	mov	_getbyte_j_1_82,a
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:134: j|=chartohex(getchare());
	lcall	_getchare
	lcall	_chartohex
	mov	a,dpl
	orl	_getbyte_j_1_82,a
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:136: return j;
	mov	dpl,_getbyte_j_1_82
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Out_Byte_Flash'
;------------------------------------------------------------
;val                       Allocated with name '_Out_Byte_Flash_PARM_2'
;address                   Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:139: void Out_Byte_Flash (unsigned int address, unsigned char val)
;	-----------------------------------------
;	 function Out_Byte_Flash
;	-----------------------------------------
_Out_Byte_Flash:
	mov	r2,dpl
	mov	r3,dph
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:141: FLASH_MOD=0xff; // Set data port for output
	mov	_FLASH_MOD,#0xFF
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:142: FLASH_ADD0=address%0x100;
	mov	ar4,r2
	mov	_FLASH_ADD0,r4
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:143: FLASH_ADD1=address/0x100;
	mov	ar2,r3
	mov	_FLASH_ADD1,r2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:144: FLASH_ADD2=FLASHSECTOR;
	mov	_FLASH_ADD2,#0x01
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:145: FLASH_DATA=val;
	mov	_FLASH_DATA,_Out_Byte_Flash_PARM_2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:150: FLASH_CMD=0b_0000_0111; // FL_CE_N=0, FL_WE_N=1
	mov	_FLASH_CMD,#0x07
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:151: FLASH_CMD=0b_0000_0101; // FL_CE_N=0, FL_WE_N=0
	mov	_FLASH_CMD,#0x05
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:152: FLASH_CMD=0b_0000_0111; // FL_CE_N=0, FL_WE_N=1
	mov	_FLASH_CMD,#0x07
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:153: FLASH_CMD=0b_0000_1111; // FL_CE_N=1, FL_WE_N=1
	mov	_FLASH_CMD,#0x0F
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'In_Byte_Flash'
;------------------------------------------------------------
;address                   Allocated to registers r2 r3 
;j                         Allocated to registers 
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:156: unsigned char In_Byte_Flash (unsigned int address)
;	-----------------------------------------
;	 function In_Byte_Flash
;	-----------------------------------------
_In_Byte_Flash:
	mov	r2,dpl
	mov	r3,dph
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:160: FLASH_MOD=0x00; // Set data port for input
	mov	_FLASH_MOD,#0x00
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:161: FLASH_ADD0=address%0x100;
	mov	ar4,r2
	mov	_FLASH_ADD0,r4
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:162: FLASH_ADD1=address/0x100;
	mov	ar2,r3
	mov	_FLASH_ADD1,r2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:163: FLASH_ADD2=FLASHSECTOR;
	mov	_FLASH_ADD2,#0x01
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:164: FLASH_CMD=0b_0000_0111; // FL_CE_N=0, FL_OE_N=1
	mov	_FLASH_CMD,#0x07
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:165: FLASH_CMD=0b_0000_0011; // FL_CE_N=0, FL_OE_N=0
	mov	_FLASH_CMD,#0x03
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:166: j=FLASH_DATA;
	mov	dpl,_FLASH_DATA
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:167: FLASH_CMD=0b_0000_0111; // FL_CE_N=0, FL_OE_N=1
	mov	_FLASH_CMD,#0x07
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:168: FLASH_CMD=0b_0000_1111; // FL_CE_N=1, FL_OE_N=1
	mov	_FLASH_CMD,#0x0F
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:169: return j;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'EraseSector'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:172: void EraseSector (void)
;	-----------------------------------------
;	 function EraseSector
;	-----------------------------------------
_EraseSector:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:174: Out_Byte_Flash(0x0AAA, 0xAA);
	mov	_Out_Byte_Flash_PARM_2,#0xAA
	mov	dptr,#0x0AAA
	lcall	_Out_Byte_Flash
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:175: Out_Byte_Flash(0x0555, 0x55);
	mov	_Out_Byte_Flash_PARM_2,#0x55
	mov	dptr,#0x0555
	lcall	_Out_Byte_Flash
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:176: Out_Byte_Flash(0x0AAA, 0x80);
	mov	_Out_Byte_Flash_PARM_2,#0x80
	mov	dptr,#0x0AAA
	lcall	_Out_Byte_Flash
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:177: Out_Byte_Flash(0x0AAA, 0xAA);
	mov	_Out_Byte_Flash_PARM_2,#0xAA
	mov	dptr,#0x0AAA
	lcall	_Out_Byte_Flash
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:178: Out_Byte_Flash(0x0555, 0x55);
	mov	_Out_Byte_Flash_PARM_2,#0x55
	mov	dptr,#0x0555
	lcall	_Out_Byte_Flash
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:179: Out_Byte_Flash(0x0000, 0x30);
	mov	_Out_Byte_Flash_PARM_2,#0x30
	mov	dptr,#0x0000
	lcall	_Out_Byte_Flash
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:181: while(In_Byte_Flash(0)!=0xff);
L012001?:
	mov	dptr,#0x0000
	lcall	_In_Byte_Flash
	mov	r2,dpl
	cjne	r2,#0xFF,L012001?
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Write_XRAM'
;------------------------------------------------------------
;Value                     Allocated with name '_Write_XRAM_PARM_2'
;Address                   Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:184: void Write_XRAM (unsigned int Address, unsigned char Value)
;	-----------------------------------------
;	 function Write_XRAM
;	-----------------------------------------
_Write_XRAM:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:186: *((unsigned char xdata *) Address)=Value;
	mov	a,_Write_XRAM_PARM_2
	movx	@dptr,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Read_XRAM'
;------------------------------------------------------------
;Address                   Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:189: unsigned char Read_XRAM (unsigned int Address)
;	-----------------------------------------
;	 function Read_XRAM
;	-----------------------------------------
_Read_XRAM:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:191: return *((unsigned char xdata *) Address);
	movx	a,@dptr
	mov	dpl,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'FlashByte'
;------------------------------------------------------------
;Value                     Allocated with name '_FlashByte_PARM_2'
;Address                   Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:194: void FlashByte (unsigned int Address, unsigned char Value)
;	-----------------------------------------
;	 function FlashByte
;	-----------------------------------------
_FlashByte:
	mov	r2,dpl
	mov	r3,dph
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:196: Out_Byte_Flash(0x0AAA, 0xAA);
	mov	_Out_Byte_Flash_PARM_2,#0xAA
	mov	dptr,#0x0AAA
	push	ar2
	push	ar3
	lcall	_Out_Byte_Flash
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:197: Out_Byte_Flash(0x0555, 0x55);
	mov	_Out_Byte_Flash_PARM_2,#0x55
	mov	dptr,#0x0555
	lcall	_Out_Byte_Flash
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:198: Out_Byte_Flash(0x0AAA, 0xA0);
	mov	_Out_Byte_Flash_PARM_2,#0xA0
	mov	dptr,#0x0AAA
	lcall	_Out_Byte_Flash
	pop	ar3
	pop	ar2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:199: Out_Byte_Flash(Address, Value);
	mov	_Out_Byte_Flash_PARM_2,_FlashByte_PARM_2
	mov	dpl,r2
	mov	dph,r3
	push	ar2
	push	ar3
	lcall	_Out_Byte_Flash
	pop	ar3
	pop	ar2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:201: while(In_Byte_Flash(Address)!=Value);
L015001?:
	mov	dpl,r2
	mov	dph,r3
	push	ar2
	push	ar3
	lcall	_In_Byte_Flash
	mov	r4,dpl
	pop	ar3
	pop	ar2
	mov	a,r4
	cjne	a,_FlashByte_PARM_2,L015001?
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Load_Ram_Fast'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:204: void Load_Ram_Fast (void)
;	-----------------------------------------
;	 function Load_Ram_Fast
;	-----------------------------------------
_Load_Ram_Fast:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:206: XRAMUSEDAS=0x01; // 32k RAM accessed as xdata
	mov	_XRAMUSEDAS,#0x01
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:207: FLASH_ADD2=FLASHSECTOR;
	mov	_FLASH_ADD2,#0x01
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:208: FLASH_MOD=0x00; // Set data port for input
	mov	_FLASH_MOD,#0x00
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:229: _endasm;
	
	  mov dptr, #0
	  mov _FLASH_CMD, #0FH
	
	 Load_Ram_Loop:
	  mov _FLASH_ADD0, dpl
	  mov _FLASH_ADD1, dph
	  mov _FLASH_CMD, #00000111B
	  mov _FLASH_CMD, #00000011B
	  mov a, _FLASH_DATA
	  mov _FLASH_CMD, #00001111B
	  movx @dptr, a
	  inc dptr
	  mov a, dph
	  jnb acc.7, Load_Ram_Loop
	
	  mov _XRAMUSEDAS, #0 ; 32k RAM accessed as code
  ; RAM is loaded with user code. Run it.
	  mov sp, #7
	  ljmp 0x0000
	 
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'loadintelhex'
;------------------------------------------------------------
;address                   Allocated with name '_loadintelhex_address_1_98'
;j                         Allocated with name '_loadintelhex_j_1_98'
;size                      Allocated with name '_loadintelhex_size_1_98'
;type                      Allocated with name '_loadintelhex_type_1_98'
;checksum                  Allocated with name '_loadintelhex_checksum_1_98'
;n                         Allocated with name '_loadintelhex_n_1_98'
;echo                      Allocated with name '_loadintelhex_echo_1_98'
;savedcs                   Allocated to registers r2 
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:232: void loadintelhex (void)
;	-----------------------------------------
;	 function loadintelhex
;	-----------------------------------------
_loadintelhex:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:239: while(1)
L017025?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:241: n=getchare();
	lcall	_getchare
	mov	_loadintelhex_n_1_98,dpl
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:243: if(n==(unsigned char)':')
	mov	a,#0x3A
	cjne	a,_loadintelhex_n_1_98,L017053?
	sjmp	L017054?
L017053?:
	ljmp	L017022?
L017054?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:245: echo='.'; // If everything works ok, send a period...
	mov	_loadintelhex_echo_1_98,#0x2E
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:246: size=getbyte();
	lcall	_getbyte
	mov	_loadintelhex_size_1_98,dpl
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:247: checksum=size;
	mov	_loadintelhex_checksum_1_98,_loadintelhex_size_1_98
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:249: address=getbyte();
	lcall	_getbyte
	mov	r2,dpl
	mov	_loadintelhex_address_1_98,r2
	mov	(_loadintelhex_address_1_98 + 1),#0x00
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:250: checksum+=address;
	mov	r2,_loadintelhex_address_1_98
	mov	a,r2
	add	a,_loadintelhex_checksum_1_98
	mov	_loadintelhex_checksum_1_98,a
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:251: address*=0x100;
	mov	(_loadintelhex_address_1_98 + 1),_loadintelhex_address_1_98
	mov	_loadintelhex_address_1_98,#0x00
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:252: n=getbyte();
	lcall	_getbyte
	mov	_loadintelhex_n_1_98,dpl
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:253: checksum+=n;
	mov	a,_loadintelhex_n_1_98
	add	a,_loadintelhex_checksum_1_98
	mov	_loadintelhex_checksum_1_98,a
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:254: address+=n;
	mov	r2,_loadintelhex_n_1_98
	mov	r3,#0x00
	mov	a,r2
	add	a,_loadintelhex_address_1_98
	mov	_loadintelhex_address_1_98,a
	mov	a,r3
	addc	a,(_loadintelhex_address_1_98 + 1)
	mov	(_loadintelhex_address_1_98 + 1),a
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:256: type=getbyte();
	lcall	_getbyte
	mov	_loadintelhex_type_1_98,dpl
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:257: checksum+=type;
	mov	a,_loadintelhex_type_1_98
	add	a,_loadintelhex_checksum_1_98
	mov	_loadintelhex_checksum_1_98,a
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:259: for(j=0; j<size; j++)
	mov	_loadintelhex_j_1_98,#0x00
L017027?:
	clr	c
	mov	a,_loadintelhex_j_1_98
	subb	a,_loadintelhex_size_1_98
	jnc	L017030?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:261: n=getbyte();
	lcall	_getbyte
	mov	_loadintelhex_n_1_98,dpl
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:262: if(j<MAXBUFF) buff[j]=n; // Don't overrun the buffer
	mov	a,#0x100 - 0x40
	add	a,_loadintelhex_j_1_98
	jc	L017002?
	mov	a,_loadintelhex_j_1_98
	add	a,#_buff
	mov	r0,a
	mov	@r0,_loadintelhex_n_1_98
L017002?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:263: checksum+=n;
	mov	a,_loadintelhex_n_1_98
	add	a,_loadintelhex_checksum_1_98
	mov	_loadintelhex_checksum_1_98,a
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:259: for(j=0; j<size; j++)
	inc	_loadintelhex_j_1_98
	sjmp	L017027?
L017030?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:266: savedcs=getbyte();
	lcall	_getbyte
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:267: checksum+=savedcs;
	mov	a,dpl
	mov	r2,a
	add	a,_loadintelhex_checksum_1_98
	mov	_loadintelhex_checksum_1_98,a
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:268: if(size>MAXBUFF) checksum=1; // Force a checksum error
	mov	a,_loadintelhex_size_1_98
	add	a,#0xff - 0x40
	jnc	L017004?
	mov	_loadintelhex_checksum_1_98,#0x01
L017004?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:270: if(checksum==0) switch(type)
	mov	a,_loadintelhex_checksum_1_98
	jz	L017058?
	ljmp	L017014?
L017058?:
	mov	r2,_loadintelhex_type_1_98
	cjne	r2,#0x00,L017059?
	sjmp	L017006?
L017059?:
	cjne	r2,#0x01,L017060?
	sjmp	L017010?
L017060?:
	cjne	r2,#0x03,L017061?
	sjmp	L017009?
L017061?:
	cjne	r2,#0x04,L017011?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:273: EraseSector();
	lcall	_EraseSector
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:274: LEDG_1=1; // Flash erased
	setb	_LEDG_1
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:275: break;
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:277: case 0: // Write to flash command.
	sjmp	L017015?
L017006?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:278: for(j=0; j<size; j++)
	mov	_loadintelhex_j_1_98,#0x00
L017031?:
	clr	c
	mov	a,_loadintelhex_j_1_98
	subb	a,_loadintelhex_size_1_98
	jnc	L017015?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:280: FlashByte(address, buff[j]);
	mov	a,_loadintelhex_j_1_98
	add	a,#_buff
	mov	r0,a
	mov	_FlashByte_PARM_2,@r0
	mov	dpl,_loadintelhex_address_1_98
	mov	dph,(_loadintelhex_address_1_98 + 1)
	lcall	_FlashByte
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:281: if (In_Byte_Flash(address)!=buff[j]) // Verify last write.
	mov	dpl,_loadintelhex_address_1_98
	mov	dph,(_loadintelhex_address_1_98 + 1)
	lcall	_In_Byte_Flash
	mov	r2,dpl
	mov	a,_loadintelhex_j_1_98
	add	a,#_buff
	mov	r0,a
	mov	ar3,@r0
	mov	a,r2
	cjne	a,ar3,L017065?
	sjmp	L017008?
L017065?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:283: echo='!';
	mov	_loadintelhex_echo_1_98,#0x21
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:284: LEDRA_0=1;
	setb	_LEDRA_0
L017008?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:286: address++;
	mov	a,#0x01
	add	a,_loadintelhex_address_1_98
	mov	_loadintelhex_address_1_98,a
	clr	a
	addc	a,(_loadintelhex_address_1_98 + 1)
	mov	(_loadintelhex_address_1_98 + 1),a
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:278: for(j=0; j<size; j++)
	inc	_loadintelhex_j_1_98
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:290: case 3: // Send ID number command.
	sjmp	L017031?
L017009?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:291: sends("DE1");
	mov	dptr,#__str_0
	mov	b,#0x80
	lcall	_sends
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:292: break;
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:294: case 1: // End record
	sjmp	L017015?
L017010?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:295: LEDG_2=1; // Flash loaded
	setb	_LEDG_2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:296: break;
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:298: default: // Unknown command;
	sjmp	L017015?
L017011?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:299: echo='?';
	mov	_loadintelhex_echo_1_98,#0x3F
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:300: LEDRA_2=1;
	setb	_LEDRA_2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:302: }
	sjmp	L017015?
L017014?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:305: echo='X'; // Checksum error
	mov	_loadintelhex_echo_1_98,#0x58
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:306: LEDRA_1=1;
	setb	_LEDRA_1
L017015?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:308: putchar(echo);
	mov	dpl,_loadintelhex_echo_1_98
	lcall	_putchar
	ljmp	L017025?
L017022?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:310: else if(n==(unsigned char)'`') return; // Go to interactive mode using serial port.
	mov	a,#0x60
	cjne	a,_loadintelhex_n_1_98,L017019?
	ret
L017019?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:311: else if(n==(unsigned char)'U')
	mov	a,#0x55
	cjne	a,_loadintelhex_n_1_98,L017068?
	sjmp	L017069?
L017068?:
	ljmp	L017025?
L017069?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:313: LEDRA=0;
	mov	_LEDRA,#0x00
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:314: LEDRB=0;
	mov	_LEDRB,#0x00
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:315: LEDG=1; // Bootloader running
	mov	_LEDG,#0x01
	ljmp	L017025?
;------------------------------------------------------------
;Allocation info for local variables in function 'str2hex'
;------------------------------------------------------------
;s                         Allocated to registers r2 r3 r4 
;x                         Allocated to registers r5 r6 
;i                         Allocated to registers r7 
;sloc0                     Allocated with name '_str2hex_sloc0_1_0'
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:320: unsigned int str2hex (char * s)
;	-----------------------------------------
;	 function str2hex
;	-----------------------------------------
_str2hex:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:322: unsigned int x=0;
	mov	r5,#0x00
	mov	r6,#0x00
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:324: while(*s)
L018013?:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r7,a
	jnz	L018027?
	ljmp	L018015?
L018027?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:326: if((*s>='0')&&(*s<='9')) i=*s-'0';
	clr	c
	mov	a,r7
	xrl	a,#0x80
	subb	a,#0xb0
	jc	L018010?
	mov	a,#(0x39 ^ 0x80)
	mov	b,r7
	xrl	b,#0x80
	subb	a,b
	jc	L018010?
	mov	a,r7
	add	a,#0xd0
	mov	r7,a
	sjmp	L018011?
L018010?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:327: else if ( (*s>='A') && (*s<='F') ) i=*s-'A'+10;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r0,a
	clr	c
	xrl	a,#0x80
	subb	a,#0xc1
	jc	L018006?
	mov	a,#(0x46 ^ 0x80)
	mov	b,r0
	xrl	b,#0x80
	subb	a,b
	jc	L018006?
	mov	a,#0xC9
	add	a,r0
	mov	r7,a
	sjmp	L018011?
L018006?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:328: else if ( (*s>='a') && (*s<='f') ) i=*s-'a'+10;
	clr	c
	mov	a,r0
	xrl	a,#0x80
	subb	a,#0xe1
	jc	L018015?
	mov	a,#(0x66 ^ 0x80)
	mov	b,r0
	xrl	b,#0x80
	subb	a,b
	jc	L018015?
	mov	a,#0xA9
	add	a,r0
	mov	r7,a
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:329: else break;
L018011?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:330: x=(x*0x10)+i;
	mov	_str2hex_sloc0_1_0,r5
	mov	a,r6
	swap	a
	anl	a,#0xf0
	xch	a,_str2hex_sloc0_1_0
	swap	a
	xch	a,_str2hex_sloc0_1_0
	xrl	a,_str2hex_sloc0_1_0
	xch	a,_str2hex_sloc0_1_0
	anl	a,#0xf0
	xch	a,_str2hex_sloc0_1_0
	xrl	a,_str2hex_sloc0_1_0
	mov	(_str2hex_sloc0_1_0 + 1),a
	mov	r0,#0x00
	mov	a,r7
	add	a,_str2hex_sloc0_1_0
	mov	r5,a
	mov	a,r0
	addc	a,(_str2hex_sloc0_1_0 + 1)
	mov	r6,a
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:331: s++;
	inc	r2
	cjne	r2,#0x00,L018034?
	inc	r3
L018034?:
	ljmp	L018013?
L018015?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:333: return x;
	mov	dpl,r5
	mov	dph,r6
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'OutByte'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:336: void OutByte (unsigned char x)
;	-----------------------------------------
;	 function OutByte
;	-----------------------------------------
_OutByte:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:338: putchar(hexval[x/0x10]);
	mov	a,dpl
	mov	r2,a
	swap	a
	anl	a,#0x0f
	mov	dptr,#_hexval
	movc	a,@a+dptr
	mov	dpl,a
	push	ar2
	lcall	_putchar
	pop	ar2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:339: putchar(hexval[x%0x10]);
	mov	a,#0x0F
	anl	a,r2
	mov	dptr,#_hexval
	movc	a,@a+dptr
	mov	dpl,a
	ljmp	_putchar
;------------------------------------------------------------
;Allocation info for local variables in function 'OutWord'
;------------------------------------------------------------
;x                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:342: void OutWord (unsigned int x)
;	-----------------------------------------
;	 function OutWord
;	-----------------------------------------
_OutWord:
	mov	r2,dpl
	mov	r3,dph
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:344: OutByte(x/0x100);
	mov	ar4,r3
	mov	dpl,r4
	push	ar2
	push	ar3
	lcall	_OutByte
	pop	ar3
	pop	ar2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:345: OutByte(x%0x100);
	mov	dpl,r2
	ljmp	_OutByte
;------------------------------------------------------------
;Allocation info for local variables in function 'read_hex_in'
;------------------------------------------------------------
;swa                       Allocated to registers r3 
;swb                       Allocated to registers r4 
;toret                     Allocated to registers r2 
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:348: unsigned char read_hex_in(void)
;	-----------------------------------------
;	 function read_hex_in
;	-----------------------------------------
_read_hex_in:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:353: toret=0xff;
	mov	r2,#0xFF
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:355: swa=SWA;
	mov	r3,_SWA
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:356: swb=SWB;
	mov	r4,_SWB
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:358: LEDRA=swa;
	mov	_LEDRA,r3
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:359: LEDRB=swb;
	mov	_LEDRB,r4
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:361: if(swa!=0)
	mov	a,r3
	jz	L021056?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:363: if(swa&0x01) toret=0x0;
	mov	a,r3
	jnb	acc.0,L021022?
	mov	r2,#0x00
	sjmp	L021024?
L021022?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:364: else if(swa&0x02) toret=0x1;
	mov	a,r3
	jnb	acc.1,L021019?
	mov	r2,#0x01
	sjmp	L021024?
L021019?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:365: else if(swa&0x04) toret=0x2;
	mov	a,r3
	jnb	acc.2,L021016?
	mov	r2,#0x02
	sjmp	L021024?
L021016?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:366: else if(swa&0x08) toret=0x3;
	mov	a,r3
	jnb	acc.3,L021013?
	mov	r2,#0x03
	sjmp	L021024?
L021013?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:367: else if(swa&0x10) toret=0x4;
	mov	a,r3
	jnb	acc.4,L021010?
	mov	r2,#0x04
	sjmp	L021024?
L021010?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:368: else if(swa&0x20) toret=0x5;
	mov	a,r3
	jnb	acc.5,L021007?
	mov	r2,#0x05
	sjmp	L021024?
L021007?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:369: else if(swa&0x40) toret=0x6;
	mov	a,r3
	jnb	acc.6,L021004?
	mov	r2,#0x06
	sjmp	L021024?
L021004?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:370: else if(swa&0x80) toret=0x7;
	mov	a,r3
	jnb	acc.7,L021024?
	mov	r2,#0x07
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:371: while (SWA!=0);
L021024?:
	mov	a,_SWA
	jz	L021057?
	sjmp	L021024?
L021056?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:373: else if(swb!=0)
	mov	a,r4
	jz	L021057?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:375: if(swb&0x01) toret=0x8;
	mov	a,r4
	jnb	acc.0,L021048?
	mov	r2,#0x08
	sjmp	L021050?
L021048?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:376: else if(swb&0x02) toret=0x9;
	mov	a,r4
	jnb	acc.1,L021045?
	mov	r2,#0x09
	sjmp	L021050?
L021045?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:377: else if(swb&0x04) toret=0xa;
	mov	a,r4
	jnb	acc.2,L021042?
	mov	r2,#0x0A
	sjmp	L021050?
L021042?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:378: else if(swb&0x08) toret=0xb;
	mov	a,r4
	jnb	acc.3,L021039?
	mov	r2,#0x0B
	sjmp	L021050?
L021039?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:379: else if(swb&0x10) toret=0xc;
	mov	a,r4
	jnb	acc.4,L021036?
	mov	r2,#0x0C
	sjmp	L021050?
L021036?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:380: else if(swb&0x20) toret=0xd;
	mov	a,r4
	jnb	acc.5,L021033?
	mov	r2,#0x0D
	sjmp	L021050?
L021033?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:381: else if(swb&0x40) toret=0xe;
	mov	a,r4
	jnb	acc.6,L021030?
	mov	r2,#0x0E
	sjmp	L021050?
L021030?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:382: else if(swb&0x80) toret=0xf;
	mov	a,r4
	jnb	acc.7,L021050?
	mov	r2,#0x0F
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:383: while (SWB!=0);
L021050?:
	mov	a,_SWB
	jnz	L021050?
L021057?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:386: return toret;
	mov	dpl,r2
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Manual_Load'
;------------------------------------------------------------
;add                       Allocated to registers r2 r3 
;j                         Allocated to registers r4 r5 
;x                         Allocated to registers r5 
;val                       Allocated to registers r4 
;h_add                     Allocated to registers r4 
;l_add                     Allocated to registers r5 
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:392: void Manual_Load (void)
;	-----------------------------------------
;	 function Manual_Load
;	-----------------------------------------
_Manual_Load:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:398: while(KEY_3==0);
L022001?:
	jnb	_KEY_3,L022001?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:399: while(KEY_2==0);
L022004?:
	jnb	_KEY_2,L022004?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:402: XRAMUSEDAS=0x01; // 32k RAM accessed as xdata
	mov	_XRAMUSEDAS,#0x01
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:403: FLASH_ADD2=FLASHSECTOR;
	mov	_FLASH_ADD2,#0x01
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:404: FLASH_MOD=0x00; // Set data port for input
	mov	_FLASH_MOD,#0x00
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:419: _endasm;
	
	  mov dptr, #0
	  mov _FLASH_CMD, #0FH
	 Load_Ram_Loop2:
	  mov _FLASH_ADD0, dpl
	  mov _FLASH_ADD1, dph
	  mov _FLASH_CMD, #00000111B
	  mov _FLASH_CMD, #00000011B
	  mov a, _FLASH_DATA
	  mov _FLASH_CMD, #00001111B
	  movx @dptr, a
	  inc dptr
	  mov a, dph
	  jnb acc.7, Load_Ram_Loop2
	 
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:421: add=0;
	mov	r2,#0x00
	mov	r3,#0x00
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:423: while(1)
L022034?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:426: h_add=add/0x100;
	mov	ar4,r3
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:427: l_add=add%0x100;
	mov	ar5,r2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:428: HEX3=seven_seg[h_add/0x10];
	mov	a,r4
	swap	a
	anl	a,#0x0f
	mov	dptr,#_seven_seg
	movc	a,@a+dptr
	mov	_HEX3,a
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:429: HEX2=seven_seg[h_add%0x10];
	mov	a,#0x0F
	anl	a,r4
	mov	dptr,#_seven_seg
	movc	a,@a+dptr
	mov	_HEX2,a
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:430: HEX1=seven_seg[l_add/0x10];
	mov	a,r5
	swap	a
	anl	a,#0x0f
	mov	dptr,#_seven_seg
	movc	a,@a+dptr
	mov	_HEX1,a
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:431: HEX0=seven_seg[l_add%0x10];
	mov	a,#0x0F
	anl	a,r5
	mov	dptr,#_seven_seg
	movc	a,@a+dptr
	mov	_HEX0,a
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:433: val=Read_XRAM(add);
	mov	dpl,r2
	mov	dph,r3
	push	ar2
	push	ar3
	lcall	_Read_XRAM
	mov	r4,dpl
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:434: HEX4=seven_seg[val%0x10];
	mov	a,#0x0F
	anl	a,r4
	mov	dptr,#_seven_seg
	movc	a,@a+dptr
	mov	_HEX4,a
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:435: HEX5=seven_seg[val/0x10];
	mov	a,r4
	swap	a
	anl	a,#0x0f
	mov	dptr,#_seven_seg
	movc	a,@a+dptr
	mov	_HEX5,a
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:437: x=read_hex_in();
	push	ar4
	lcall	_read_hex_in
	mov	r5,dpl
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:438: if(x<0x10)
	cjne	r5,#0x10,L022061?
L022061?:
	jnc	L022011?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:440: if(SWC&0x01) // Reading address
	mov	a,_SWC
	jnb	acc.0,L022008?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:442: add<<=4;
	mov	a,r3
	swap	a
	anl	a,#0xf0
	xch	a,r2
	swap	a
	xch	a,r2
	xrl	a,r2
	xch	a,r2
	anl	a,#0xf0
	xch	a,r2
	xrl	a,r2
	mov	r3,a
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:443: add&=0x7ff0;
	anl	ar2,#0xF0
	anl	ar3,#0x7F
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:444: add|=x;	
	mov	ar6,r5
	mov	r7,#0x00
	mov	a,r6
	orl	ar2,a
	mov	a,r7
	orl	ar3,a
	sjmp	L022011?
L022008?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:448: val<<=4;
	mov	a,r4
	swap	a
	anl	a,#0xf0
	mov	r4,a
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:449: val&=0xf0;
	anl	ar4,#0xF0
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:450: val|=x;
	mov	a,r5
	orl	ar4,a
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:451: Write_XRAM(add, val);
	mov	_Write_XRAM_PARM_2,r4
	mov	dpl,r2
	mov	dph,r3
	push	ar2
	push	ar3
	lcall	_Write_XRAM
	pop	ar3
	pop	ar2
L022011?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:455: if(KEY_3==0) // Increment address
	jb	_KEY_3,L022031?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:457: while(KEY_3==0); // Wait for key release
L022012?:
	jnb	_KEY_3,L022012?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:458: LEDG_1=0;
	clr	_LEDG_1
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:459: LEDG_2=0;
	clr	_LEDG_2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:460: add++;
	inc	r2
	cjne	r2,#0x00,L022066?
	inc	r3
L022066?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:461: if (add>0x7fff) add=0;
	clr	c
	mov	a,#0xFF
	subb	a,r2
	mov	a,#0x7F
	subb	a,r3
	jc	L022067?
	ljmp	L022034?
L022067?:
	mov	r2,#0x00
	mov	r3,#0x00
	ljmp	L022034?
L022031?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:463: else if (KEY_2==0) // Decrement address
	jb	_KEY_2,L022028?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:465: while(KEY_2==0); // Wait for key release
L022017?:
	jnb	_KEY_2,L022017?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:466: LEDG_1=0;
	clr	_LEDG_1
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:467: LEDG_2=0;
	clr	_LEDG_2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:468: add--;
	dec	r2
	cjne	r2,#0xff,L022070?
	dec	r3
L022070?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:469: if (add>0x7fff) add=0x7fff;
	clr	c
	mov	a,#0xFF
	subb	a,r2
	mov	a,#0x7F
	subb	a,r3
	jc	L022071?
	ljmp	L022034?
L022071?:
	mov	r2,#0xFF
	mov	r3,#0x7F
	ljmp	L022034?
L022028?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:471: else if (KEY_1==0) // Save RAM to flash
	jnb	_KEY_1,L022072?
	ljmp	L022034?
L022072?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:473: while(KEY_1==0); // Wait for key release
L022022?:
	jnb	_KEY_1,L022022?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:474: EraseSector();
	push	ar2
	push	ar3
	lcall	_EraseSector
	pop	ar3
	pop	ar2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:475: LEDG_1=1;
	setb	_LEDG_1
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:476: for(j=0; j<0x8000; j++)
	mov	r4,#0x00
	mov	r5,#0x00
L022036?:
	mov	a,#0x100 - 0x80
	add	a,r5
	jc	L022039?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:478: val=Read_XRAM(j);
	mov	dpl,r4
	mov	dph,r5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_Read_XRAM
	mov	_FlashByte_PARM_2,dpl
	pop	ar5
	pop	ar4
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:479: FlashByte(j, val);
	mov	dpl,r4
	mov	dph,r5
	push	ar4
	push	ar5
	lcall	_FlashByte
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:476: for(j=0; j<0x8000; j++)
	inc	r4
	cjne	r4,#0x00,L022036?
	inc	r5
	sjmp	L022036?
L022039?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:481: LEDG_2=1;
	setb	_LEDG_2
	ljmp	L022034?
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;i                         Allocated with name '_main_i_1_129'
;j                         Allocated to registers r2 r3 
;d                         Allocated to registers r2 
;ascii                     Allocated with name '_main_ascii_1_129'
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:486: void main (void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:492: FLASH_CMD=0x0f;
	mov	_FLASH_CMD,#0x0F
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:494: if(KEY_1==1) Load_Ram_Fast();
	jnb	_KEY_1,L023002?
	lcall	_Load_Ram_Fast
L023002?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:496: XRAMUSEDAS=1; // 32k RAM accessed as xdata
	mov	_XRAMUSEDAS,#0x01
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:498: while(KEY_1==0); // Wait for key release
L023003?:
	jnb	_KEY_1,L023003?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:500: LEDRA=0;
	mov	_LEDRA,#0x00
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:501: LEDRB=0;
	mov	_LEDRB,#0x00
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:502: LEDRC=0;
	mov	_LEDRC,#0x00
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:503: LEDG=1; // Bootloader running
	mov	_LEDG,#0x01
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:504: HEX0=0xff;
	mov	_HEX0,#0xFF
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:505: HEX1=0xff;
	mov	_HEX1,#0xFF
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:506: HEX2=0xff;
	mov	_HEX2,#0xFF
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:507: HEX3=0xff;
	mov	_HEX3,#0xFF
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:508: HEX4=0xff;
	mov	_HEX4,#0xFF
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:509: HEX5=0xff;
	mov	_HEX5,#0xFF
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:510: HEX6=0xff;
	mov	_HEX6,#0xFF
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:511: HEX7=0xff;
	mov	_HEX7,#0xFF
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:513: inituart();
	lcall	_inituart
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:514: JRXEN=1;
	setb	_JRXEN
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:515: JBUF=0;
	mov	_JBUF,#0x00
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:516: JTXEN=1;
	setb	_JTXEN
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:519: while(1)
L023021?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:521: if (JRXRDY==1)
	jnb	_JRXRDY,L023012?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:523: d=JBUF; // Read fifo value
	mov	r2,_JBUF
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:524: if(d==(unsigned char)'U')
	cjne	r2,#0x55,L023008?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:526: LEDG_7=1;
	setb	_LEDG_7
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:527: serialmode=1; // Use JTAG for communication
	setb	_serialmode
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:528: break;
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:530: while(JTXRDY!=1);
	sjmp	L023022?
L023008?:
	jnb	_JTXRDY,L023008?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:531: JBUF=d; // Echo what was received
	mov	_JBUF,r2
L023012?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:533: if (RI==1)
	jnb	_RI,L023016?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:535: d=SBUF;
	mov	r2,_SBUF
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:536: RI=0;
	clr	_RI
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:537: if(d==(unsigned char)'U')
	cjne	r2,#0x55,L023014?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:539: serialmode=0; // Use serial port for communication
	clr	_serialmode
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:540: break;
	sjmp	L023022?
L023014?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:542: TI=0; // Echo what was received
	clr	_TI
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:543: SBUF=d;
	mov	_SBUF,r2
L023016?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:545: if ((KEY_2==0) && (KEY_3==0)) Manual_Load();
	jb	_KEY_2,L023021?
	jb	_KEY_3,L023021?
	lcall	_Manual_Load
	sjmp	L023021?
L023022?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:548: loadintelhex();
	lcall	_loadintelhex
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:550: serialmode=0; // Use serial port for communication
	clr	_serialmode
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:551: getchar_echo=1;
	setb	_getchar_echo
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:552: sends("\nReady for commands (Dump, Program, Erase, Strin, Testcode)\n");
	mov	dptr,#__str_1
	mov	b,#0x80
	lcall	_sends
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:553: while(1)
L023054?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:555: sends(">");
	mov	dptr,#__str_2
	mov	b,#0x80
	lcall	_sends
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:556: gets(buff);
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_gets
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:557: if(EQ(buff, "D")||EQ(buff, "d"))
	mov	_strcmp_PARM_2,#__str_3
	mov	(_strcmp_PARM_2 + 1),#(__str_3 >> 8)
	mov	(_strcmp_PARM_2 + 2),#0x80
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_strcmp
	mov	a,dpl
	mov	b,dph
	orl	a,b
	jz	L023049?
	mov	_strcmp_PARM_2,#__str_4
	mov	(_strcmp_PARM_2 + 1),#(__str_4 >> 8)
	mov	(_strcmp_PARM_2 + 2),#0x80
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_strcmp
	mov	a,dpl
	mov	b,dph
	orl	a,b
	jz	L023113?
	ljmp	L023050?
L023113?:
L023049?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:559: sends("Address: ");
	mov	dptr,#__str_5
	mov	b,#0x80
	lcall	_sends
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:560: gets(buff);
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_gets
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:561: i=str2hex(buff)&0xfff0;
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_str2hex
	mov	a,dpl
	mov	b,dph
	anl	a,#0xF0
	mov	_main_i_1_129,a
	mov	(_main_i_1_129 + 1),b
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:562: for(j=0; j<0x80; j++)
	mov	r5,#0x00
	mov	r6,#0x00
L023056?:
	clr	c
	mov	a,r5
	subb	a,#0x80
	mov	a,r6
	subb	a,#0x00
	jc	L023114?
	ljmp	L023059?
L023114?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:564: if((j%0x10)==0)
	mov	a,r5
	anl	a,#0x0F
	jnz	L023024?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:566: OutWord(j+i);
	mov	a,_main_i_1_129
	add	a,r5
	mov	dpl,a
	mov	a,(_main_i_1_129 + 1)
	addc	a,r6
	mov	dph,a
	push	ar5
	push	ar6
	lcall	_OutWord
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:567: putchar(':');
	mov	dpl,#0x3A
	lcall	_putchar
	pop	ar6
	pop	ar5
L023024?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:569: d=*((unsigned char xdata *)(j+i));
	mov	a,_main_i_1_129
	add	a,r5
	mov	r7,a
	mov	a,(_main_i_1_129 + 1)
	addc	a,r6
	mov	r3,a
	mov	dpl,r7
	mov	dph,r3
	movx	a,@dptr
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:570: OutByte(d);
	mov	r2,a
	mov	dpl,a
	push	ar2
	push	ar5
	push	ar6
	lcall	_OutByte
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:571: putchar(':');
	mov	dpl,#0x3A
	lcall	_putchar
	pop	ar6
	pop	ar5
	pop	ar2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:572: if((d>0x20)&&(d<0x7f))
	mov	a,r2
	add	a,#0xff - 0x20
	jnc	L023026?
	cjne	r2,#0x7F,L023118?
L023118?:
	jnc	L023026?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:573: ascii[j&0xf]=d;
	mov	a,#0x0F
	anl	a,r5
	mov	r3,a
	mov	r4,#0x00
	add	a,#_main_ascii_1_129
	mov	r0,a
	mov	@r0,ar2
	sjmp	L023027?
L023026?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:575: ascii[j&0xf]='.';
	mov	a,#0x0F
	anl	a,r5
	mov	r2,a
	mov	r3,#0x00
	add	a,#_main_ascii_1_129
	mov	r0,a
	mov	@r0,#0x2E
L023027?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:576: if((j&0xf)==0xf)
	mov	a,#0x0F
	anl	a,r5
	mov	r2,a
	mov	r3,#0x00
	cjne	r2,#0x0F,L023058?
	cjne	r3,#0x00,L023058?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:578: ascii[0x10]=0;
	mov	r0,#(_main_ascii_1_129 + 0x0010)
	mov	@r0,#0x00
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:579: sends("  ");
	mov	dptr,#__str_6
	mov	b,#0x80
	push	ar5
	push	ar6
	lcall	_sends
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:580: sends(ascii);
	mov	dptr,#_main_ascii_1_129
	mov	b,#0x40
	lcall	_sends
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:581: putchar('\n');
	mov	dpl,#0x0A
	lcall	_putchar
	pop	ar6
	pop	ar5
L023058?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:562: for(j=0; j<0x80; j++)
	inc	r5
	cjne	r5,#0x00,L023122?
	inc	r6
L023122?:
	ljmp	L023056?
L023059?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:585: putchar('\n');
	mov	dpl,#0x0A
	lcall	_putchar
	ljmp	L023054?
L023050?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:587: else if(EQ(buff, "P")||EQ(buff, "p"))
	mov	_strcmp_PARM_2,#__str_7
	mov	(_strcmp_PARM_2 + 1),#(__str_7 >> 8)
	mov	(_strcmp_PARM_2 + 2),#0x80
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_strcmp
	mov	a,dpl
	mov	b,dph
	orl	a,b
	jz	L023045?
	mov	_strcmp_PARM_2,#__str_8
	mov	(_strcmp_PARM_2 + 1),#(__str_8 >> 8)
	mov	(_strcmp_PARM_2 + 2),#0x80
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_strcmp
	mov	a,dpl
	mov	b,dph
	orl	a,b
	jnz	L023046?
L023045?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:589: sends("Address: ");
	mov	dptr,#__str_5
	mov	b,#0x80
	lcall	_sends
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:590: gets(buff);
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_gets
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:591: i=str2hex(buff);
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_str2hex
	mov	_main_i_1_129,dpl
	mov	(_main_i_1_129 + 1),dph
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:592: sends("Data: ");
	mov	dptr,#__str_9
	mov	b,#0x80
	lcall	_sends
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:593: gets(buff);
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_gets
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:594: d=str2hex(buff)&0xff;
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_str2hex
	mov	a,dpl
	mov	b,dph
	mov	r2,a
	mov	_FlashByte_PARM_2,r2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:595: FlashByte(i, d);
	mov	dpl,_main_i_1_129
	mov	dph,(_main_i_1_129 + 1)
	lcall	_FlashByte
	ljmp	L023054?
L023046?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:597: else if(EQ(buff, "E")||EQ(buff, "e"))
	mov	_strcmp_PARM_2,#__str_10
	mov	(_strcmp_PARM_2 + 1),#(__str_10 >> 8)
	mov	(_strcmp_PARM_2 + 2),#0x80
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_strcmp
	mov	a,dpl
	mov	b,dph
	orl	a,b
	jz	L023041?
	mov	_strcmp_PARM_2,#__str_11
	mov	(_strcmp_PARM_2 + 1),#(__str_11 >> 8)
	mov	(_strcmp_PARM_2 + 2),#0x80
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_strcmp
	mov	a,dpl
	mov	b,dph
	orl	a,b
	jnz	L023042?
L023041?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:599: sends("Should erase Flash memory? (y/n)");
	mov	dptr,#__str_12
	mov	b,#0x80
	lcall	_sends
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:600: gets(buff);
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_gets
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:601: if(EQ(buff, "y"))
	mov	_strcmp_PARM_2,#__str_13
	mov	(_strcmp_PARM_2 + 1),#(__str_13 >> 8)
	mov	(_strcmp_PARM_2 + 2),#0x80
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_strcmp
	mov	a,dpl
	mov	b,dph
	orl	a,b
	jz	L023127?
	ljmp	L023054?
L023127?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:603: EraseSector();
	lcall	_EraseSector
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:604: sends("Flash erased\n");
	mov	dptr,#__str_14
	mov	b,#0x80
	lcall	_sends
	ljmp	L023054?
L023042?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:607: else if(EQ(buff, "S")||EQ(buff, "s"))
	mov	_strcmp_PARM_2,#__str_15
	mov	(_strcmp_PARM_2 + 1),#(__str_15 >> 8)
	mov	(_strcmp_PARM_2 + 2),#0x80
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_strcmp
	mov	a,dpl
	mov	b,dph
	orl	a,b
	jz	L023037?
	mov	_strcmp_PARM_2,#__str_16
	mov	(_strcmp_PARM_2 + 1),#(__str_16 >> 8)
	mov	(_strcmp_PARM_2 + 2),#0x80
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_strcmp
	mov	a,dpl
	mov	b,dph
	orl	a,b
	jnz	L023038?
L023037?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:609: sends("Address: ");
	mov	dptr,#__str_5
	mov	b,#0x80
	lcall	_sends
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:610: gets(buff);
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_gets
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:611: i=str2hex(buff);
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_str2hex
	mov	_main_i_1_129,dpl
	mov	(_main_i_1_129 + 1),dph
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:612: sends("String: ");
	mov	dptr,#__str_17
	mov	b,#0x80
	lcall	_sends
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:613: gets(buff);
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_gets
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:614: for(j=0; buff[j]!=0; j++)
	mov	r2,_main_i_1_129
	mov	r3,(_main_i_1_129 + 1)
	mov	r4,#0x00
	mov	r5,#0x00
L023060?:
	mov	a,r4
	add	a,#_buff
	mov	r0,a
	mov	ar6,@r0
	cjne	r6,#0x00,L023130?
	ljmp	L023054?
L023130?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:616: FlashByte(i++, buff[j]);	
	mov	dpl,r2
	mov	dph,r3
	inc	r2
	cjne	r2,#0x00,L023131?
	inc	r3
L023131?:
	mov	_FlashByte_PARM_2,r6
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_FlashByte
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:614: for(j=0; buff[j]!=0; j++)
	inc	r4
	cjne	r4,#0x00,L023060?
	inc	r5
	sjmp	L023060?
L023038?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:619: else if(EQ(buff, "T")||EQ(buff, "t"))
	mov	_strcmp_PARM_2,#__str_18
	mov	(_strcmp_PARM_2 + 1),#(__str_18 >> 8)
	mov	(_strcmp_PARM_2 + 2),#0x80
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_strcmp
	mov	a,dpl
	mov	b,dph
	orl	a,b
	jz	L023098?
	mov	_strcmp_PARM_2,#__str_19
	mov	(_strcmp_PARM_2 + 1),#(__str_19 >> 8)
	mov	(_strcmp_PARM_2 + 2),#0x80
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_strcmp
	mov	a,dpl
	mov	b,dph
	orl	a,b
	jnz	L023034?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:621: for(j=0; j<(16*6); j++)
L023098?:
	mov	r2,#0x00
	mov	r3,#0x00
L023064?:
	clr	c
	mov	a,r2
	subb	a,#0x60
	mov	a,r3
	subb	a,#0x00
	jnc	L023067?
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:623: FlashByte(j, counter_prog[j]);	
	mov	a,r2
	add	a,#_counter_prog
	mov	dpl,a
	mov	a,r3
	addc	a,#(_counter_prog >> 8)
	mov	dph,a
	clr	a
	movc	a,@a+dptr
	mov	_FlashByte_PARM_2,a
	mov	dpl,r2
	mov	dph,r3
	push	ar2
	push	ar3
	lcall	_FlashByte
	pop	ar3
	pop	ar2
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:621: for(j=0; j<(16*6); j++)
	inc	r2
	cjne	r2,#0x00,L023064?
	inc	r3
	sjmp	L023064?
L023067?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:625: sends("Test program was flashed\n");
	mov	dptr,#__str_20
	mov	b,#0x80
	lcall	_sends
	ljmp	L023054?
L023034?:
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:629: sends("What?\n");
	mov	dptr,#__str_21
	mov	b,#0x80
	lcall	_sends
	ljmp	L023054?
;------------------------------------------------------------
;Allocation info for local variables in function 'dummy_switch'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:634: void dummy_switch(void) __naked
;	-----------------------------------------
;	 function dummy_switch
;	-----------------------------------------
_dummy_switch:
;	naked function: no prologue.
;	C:\Source\DE2_8052b\Boot\DE2_Boot.c:646: _endasm;
	
	  CSEG at 0xFFE0
	  mov _XRAMUSEDAS, #0x00 ; 32k RAM accessed as code
	  nop
	  ret
	
	  CSEG at 0xffE8
	  mov _XRAMUSEDAS, #0x01 ; 32k RAM accessed as xdata
	  nop
	  ret
	 
;	naked function: no epilogue.
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
_counter_prog:
	db 0x02	; 2 
	db 0x00	; 0 
	db 0x10	; 16 
	db 0x7a	; 122 	z
	db 0x3b	; 59 
	db 0x79	; 121 	y
	db 0xfa	; 250 
	db 0x78	; 120 	x
	db 0xfa	; 250 
	db 0xd8	; 216 	Ø
	db 0xfe	; 254 	þ
	db 0xd9	; 217 	Ù
	db 0xfa	; 250 
	db 0xda	; 218 
	db 0xf6	; 246 	ö
	db 0x22	; 34 
	db 0x75	; 117 	u
	db 0x81	; 129 	
	db 0x7f	; 127 
	db 0x7b	; 123 
	db 0x00	; 0 
	db 0x7c	; 124 
	db 0x00	; 0 
	db 0xec	; 236 	ì
	db 0x54	; 84 	T
	db 0x0f	; 15 
	db 0x90	; 144 
	db 0x00	; 0 
	db 0x4c	; 76 	L
	db 0x93	; 147 	“
	db 0xf5	; 245 	õ
	db 0x91	; 145 	‘
	db 0xec	; 236 	ì
	db 0xc4	; 196 	Ä
	db 0x54	; 84 	T
	db 0x0f	; 15 
	db 0x90	; 144 
	db 0x00	; 0 
	db 0x4c	; 76 	L
	db 0x93	; 147 	“
	db 0xf5	; 245 	õ
	db 0x92	; 146 	’
	db 0xeb	; 235 	ë
	db 0x54	; 84 	T
	db 0x0f	; 15 
	db 0x90	; 144 
	db 0x00	; 0 
	db 0x4c	; 76 	L
	db 0x93	; 147 	“
	db 0xf5	; 245 	õ
	db 0x93	; 147 	“
	db 0xeb	; 235 	ë
	db 0xc4	; 196 	Ä
	db 0x54	; 84 	T
	db 0x0f	; 15 
	db 0x90	; 144 
	db 0x00	; 0 
	db 0x4c	; 76 	L
	db 0x93	; 147 	“
	db 0xf5	; 245 	õ
	db 0x94	; 148 	”
	db 0x12	; 18 
	db 0x00	; 0 
	db 0x03	; 3 
	db 0xec	; 236 	ì
	db 0x24	; 36 
	db 0x01	; 1 
	db 0xd4	; 212 	Ô
	db 0xfc	; 252 	ü
	db 0xeb	; 235 	ë
	db 0x34	; 52 
	db 0x00	; 0 
	db 0xd4	; 212 	Ô
	db 0xfb	; 251 	û
	db 0x80	; 128 	€
	db 0xcb	; 203 	Ë
	db 0xc0	; 192 	À
	db 0xf9	; 249 
	db 0xa4	; 164 	¤
	db 0xb0	; 176 	°
	db 0x99	; 153 	™
	db 0x92	; 146 	’
	db 0x82	; 130 	‚
	db 0xf8	; 248 
	db 0x80	; 128 	€
	db 0x90	; 144 
	db 0x88	; 136 
	db 0x83	; 131 
	db 0xc6	; 198 
	db 0xa1	; 161 	¡
	db 0x86	; 134 	†
	db 0x8e	; 142 	Ž
	db 0x00	; 0 
	db 0x00	; 0 
	db 0x00	; 0 
	db 0x00	; 0 
_hexval:
	db '0123456789ABCDEF'
	db 0x00
__str_0:
	db 'DE1'
	db 0x00
_seven_seg:
	db 0xc0	; 192 	À
	db 0xf9	; 249 
	db 0xa4	; 164 	¤
	db 0xb0	; 176 	°
	db 0x99	; 153 	™
	db 0x92	; 146 	’
	db 0x82	; 130 	‚
	db 0xf8	; 248 
	db 0x80	; 128 	€
	db 0x90	; 144 
	db 0x88	; 136 
	db 0x83	; 131 
	db 0xc6	; 198 
	db 0xa1	; 161 	¡
	db 0x86	; 134 	†
	db 0x8e	; 142 	Ž
__str_1:
	db 0x0A
	db 'Ready for commands (Dump, Program, Erase, Strin, Testcode)'
	db 0x0A
	db 0x00
__str_2:
	db '>'
	db 0x00
__str_3:
	db 'D'
	db 0x00
__str_4:
	db 'd'
	db 0x00
__str_5:
	db 'Address: '
	db 0x00
__str_6:
	db '  '
	db 0x00
__str_7:
	db 'P'
	db 0x00
__str_8:
	db 'p'
	db 0x00
__str_9:
	db 'Data: '
	db 0x00
__str_10:
	db 'E'
	db 0x00
__str_11:
	db 'e'
	db 0x00
__str_12:
	db 'Should erase Flash memory? (y/n)'
	db 0x00
__str_13:
	db 'y'
	db 0x00
__str_14:
	db 'Flash erased'
	db 0x0A
	db 0x00
__str_15:
	db 'S'
	db 0x00
__str_16:
	db 's'
	db 0x00
__str_17:
	db 'String: '
	db 0x00
__str_18:
	db 'T'
	db 0x00
__str_19:
	db 't'
	db 0x00
__str_20:
	db 'Test program was flashed'
	db 0x0A
	db 0x00
__str_21:
	db 'What?'
	db 0x0A
	db 0x00

	CSEG

end
