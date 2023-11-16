;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1034 (Dec 12 2012) (MSVC)
; This file was generated Fri May 17 14:24:01 2013
;--------------------------------------------------------
$name cmon51
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
	public _fillmem_PARM_3
	public _fillmem_PARM_2
	public _cnw
	public _cnr
	public _nba
	public _maskbit
	public _hexval
	public _cmdlst
	public _breakorstep
	public _nlist
	public _outwordnl
	public _disp_regs
	public _showreg
	public _getwordn
	public _cleanbuff
	public _dispmem
	public _modifymem
	public _getbyte
	public _getsn
	public _clearline
	public _go_pending
	public _trace_type
	public _break_address
	public _gostep
	public _saved_int
	public _saved_jmp
	public _step_start
	public _gotbreak
	public _PC_save
	public _LEDRC_save
	public _LEDRB_save
	public _LEDRA_save
	public _LEDG_save
	public _SP_save
	public _DPH_save
	public _DPL_save
	public _IE_save
	public _B_save
	public _PSW_save
	public _A_save
	public _br
	public _iram_save
	public _breakpoint
	public _buff_hasdot
	public _buff_haseq
	public _keepediting
	public _validbyte
	public _showreg_PARM_2
	public _dispmem_PARM_3
	public _dispmem_PARM_2
	public _modifymem_PARM_2
	public _cursor
	public _buff
	public _putsp
	public _chartohex
	public _outbyte
	public _outword
	public _fillmem
	public _getbytene
	public _hitanykey
	public _do_cmd
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
_buff:
	ds 32
_cursor:
	ds 1
_modifymem_PARM_2:
	ds 1
_hitanykey_c_1_124:
	ds 1
_dispmem_PARM_2:
	ds 2
_dispmem_PARM_3:
	ds 1
_dispmem_begin_1_125:
	ds 3
_dispmem_j_1_126:
	ds 2
_dispmem_k_1_126:
	ds 1
_showreg_PARM_2:
	ds 1
_do_cmd_i_1_172:
	ds 2
_do_cmd_j_1_172:
	ds 2
_do_cmd_n_1_172:
	ds 2
_do_cmd_q_1_172:
	ds 2
_do_cmd_y_1_172:
	ds 1
_do_cmd_cmd_1_172:
	ds 1
_do_cmd_sloc0_1_0:
	ds 2
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
_fillmem_PARM_2:
	ds 2
_fillmem_PARM_3:
	ds 1
	rseg	R_OSEG
_nlist_q_1_157:
	ds 1
_nlist_sloc0_1_0:
	ds 3
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	rseg R_ISEG
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	DSEG
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	rseg R_BSEG
_validbyte:
	DBIT	1
_keepediting:
	DBIT	1
_buff_haseq:
	DBIT	1
_buff_hasdot:
	DBIT	1
_breakpoint:
	DBIT	1
_do_cmd_p_bit_1_172:
	DBIT	1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_PSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
_iram_save:
	ds 128
_br:
	ds 8
_A_save:
	ds 1
_PSW_save:
	ds 1
_B_save:
	ds 1
_IE_save:
	ds 1
_DPL_save:
	ds 2
_DPH_save:
	ds 2
_SP_save:
	ds 1
_LEDG_save:
	ds 1
_LEDRA_save:
	ds 1
_LEDRB_save:
	ds 1
_LEDRC_save:
	ds 1
_PC_save:
	ds 2
_gotbreak:
	ds 1
_step_start:
	ds 2
_saved_jmp:
	ds 3
_saved_int:
	ds 3
_gostep:
	ds 1
_break_address:
	ds 2
_trace_type:
	ds 1
_go_pending:
	ds 1
_getsn_buff2_1_82:
	ds 32
_getsn_count2_1_82:
	ds 1
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
; Interrupt vectors
;--------------------------------------------------------
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
;------------------------------------------------------------
;Allocation info for local variables in function 'getsn'
;------------------------------------------------------------
;c                         Allocated to registers r3 
;count                     Allocated to registers r2 
;buff2                     Allocated with name '_getsn_buff2_1_82'
;count2                    Allocated with name '_getsn_count2_1_82'
;------------------------------------------------------------
;	.\cmon51.c:94: static volatile xdata unsigned char count2=0;
	mov	dptr,#_getsn_count2_1_82
	clr	a
	movx	@dptr,a
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function 'putsp'
;------------------------------------------------------------
;x                         Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;	.\cmon51.c:68: void putsp(unsigned char * x)
;	-----------------------------------------
;	 function putsp
;	-----------------------------------------
_putsp:
	using	0
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	.\cmon51.c:70: while( ((*x)>0) && ((*x)<0x80) )
L002010?:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r5,a
	jz	L002013?
	cjne	r5,#0x80,L002024?
L002024?:
	jnc	L002013?
;	.\cmon51.c:72: if(*x==(unsigned char)'\n') putc((unsigned char)'\r');
	cjne	r5,#0x0A,L002006?
L002001?:
	jb	_JTXFULL,L002001?
	mov	_JBUF,#0x0D
;	.\cmon51.c:73: putc(*x);
L002006?:
	jb	_JTXFULL,L002006?
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	_JBUF,a
	inc	dptr
	mov	r2,dpl
	mov	r3,dph
;	.\cmon51.c:74: x++;
	sjmp	L002010?
L002013?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'clearline'
;------------------------------------------------------------
;j                         Allocated to registers r2 
;------------------------------------------------------------
;	.\cmon51.c:78: void clearline (void)
;	-----------------------------------------
;	 function clearline
;	-----------------------------------------
_clearline:
;	.\cmon51.c:81: putc('\r');
L003001?:
	jb	_JTXFULL,L003001?
	mov	_JBUF,#0x0D
;	.\cmon51.c:82: for(j=0; j<79; j++) putc(' ');
	mov	r2,#0x00
L003010?:
	cjne	r2,#0x4F,L003025?
L003025?:
	jnc	L003007?
L003004?:
	jb	_JTXFULL,L003004?
	mov	_JBUF,#0x20
	inc	r2
;	.\cmon51.c:83: putc('\r');
	sjmp	L003010?
L003007?:
	jb	_JTXFULL,L003007?
	mov	_JBUF,#0x0D
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getsn'
;------------------------------------------------------------
;c                         Allocated to registers r3 
;count                     Allocated to registers r2 
;buff2                     Allocated with name '_getsn_buff2_1_82'
;count2                    Allocated with name '_getsn_count2_1_82'
;------------------------------------------------------------
;	.\cmon51.c:89: void getsn (void)
;	-----------------------------------------
;	 function getsn
;	-----------------------------------------
_getsn:
;	.\cmon51.c:92: unsigned char count=0;
	mov	r2,#0x00
;	.\cmon51.c:96: while (1)
L004024?:
;	.\cmon51.c:98: c=getchar();
	push	ar2
	lcall	_getchar
	mov	r3,dpl
	pop	ar2
;	.\cmon51.c:100: switch(c)
	cjne	r3,#0x08,L004055?
	sjmp	L004001?
L004055?:
	cjne	r3,#0x0A,L004056?
	sjmp	L004005?
L004056?:
	cjne	r3,#0x0D,L004057?
	sjmp	L004005?
L004057?:
	cjne	r3,#0x16,L004058?
	sjmp	L004008?
L004058?:
	ljmp	L004012?
;	.\cmon51.c:102: case '\b': // backspace
L004001?:
;	.\cmon51.c:103: if (count)
	mov	a,r2
	jz	L004024?
;	.\cmon51.c:105: putsp("\b \b");
	mov	dptr,#__str_0
	mov	b,#0x80
	push	ar2
	lcall	_putsp
	pop	ar2
;	.\cmon51.c:106: buff[count--]=0;
	mov	ar4,r2
	dec	r2
	mov	a,r4
	add	a,#_buff
	mov	r0,a
	mov	@r0,#0x00
;	.\cmon51.c:108: break;
;	.\cmon51.c:110: case '\r': // CR or LF
	sjmp	L004024?
L004005?:
;	.\cmon51.c:111: putnl();
	push	ar2
	lcall	_putnl
	pop	ar2
;	.\cmon51.c:112: buff[count]=0;
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	@r0,#0x00
;	.\cmon51.c:113: if(count)
	mov	a,r2
	jz	L004007?
;	.\cmon51.c:115: count2=count;
	mov	dptr,#_getsn_count2_1_82
	mov	a,r2
	movx	@dptr,a
;	.\cmon51.c:116: for(c=0; c<=count; c++) buff2[c]=buff[c];
	mov	r4,#0x00
L004026?:
	clr	c
	mov	a,r2
	subb	a,r4
	jc	L004007?
	mov	a,r4
	add	a,#_getsn_buff2_1_82
	mov	dpl,a
	clr	a
	addc	a,#(_getsn_buff2_1_82 >> 8)
	mov	dph,a
	mov	a,r4
	add	a,#_buff
	mov	r0,a
	mov	a,@r0
	mov	r5,a
	movx	@dptr,a
	inc	r4
	sjmp	L004026?
L004007?:
;	.\cmon51.c:118: return;
;	.\cmon51.c:119: case 0x16: // <CTRL>+V
	ret
L004008?:
;	.\cmon51.c:120: clearline();
	lcall	_clearline
;	.\cmon51.c:121: count=count2;
	mov	dptr,#_getsn_count2_1_82
	movx	a,@dptr
	mov	r2,a
;	.\cmon51.c:122: putsp("> ");
	mov	dptr,#__str_1
	mov	b,#0x80
	push	ar2
	lcall	_putsp
	pop	ar2
;	.\cmon51.c:123: for(c=0; c<=count; c++) {buff[c]=buff2[c]; putc(buff[c]);}
	mov	r4,#0x00
L004030?:
	clr	c
	mov	a,r2
	subb	a,r4
	jnc	L004062?
	ljmp	L004024?
L004062?:
	mov	a,r4
	add	a,#_buff
	mov	r0,a
	mov	a,r4
	add	a,#_getsn_buff2_1_82
	mov	dpl,a
	clr	a
	addc	a,#(_getsn_buff2_1_82 >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	r5,a
	mov	@r0,a
L004009?:
	jb	_JTXFULL,L004009?
	mov	a,r4
	add	a,#_buff
	mov	r0,a
	mov	_JBUF,@r0
	inc	r4
;	.\cmon51.c:125: default:
	sjmp	L004030?
L004012?:
;	.\cmon51.c:126: if(count<(BUFFSIZE-1))
	cjne	r2,#0x1F,L004064?
L004064?:
	jnc	L004016?
;	.\cmon51.c:128: buff[count++]=c;
	mov	ar4,r2
	inc	r2
	mov	a,r4
	add	a,#_buff
	mov	r0,a
	mov	@r0,ar3
;	.\cmon51.c:129: putc(c);
L004013?:
	jb	_JTXFULL,L004013?
	mov	_JBUF,r3
	ljmp	L004024?
;	.\cmon51.c:131: else putc('\a'); //Ding!
L004016?:
	jb	_JTXFULL,L004016?
	mov	_JBUF,#0x07
;	.\cmon51.c:133: }
	ljmp	L004024?
;------------------------------------------------------------
;Allocation info for local variables in function 'chartohex'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;i                         Allocated to registers r2 
;------------------------------------------------------------
;	.\cmon51.c:137: unsigned char chartohex(char c)
;	-----------------------------------------
;	 function chartohex
;	-----------------------------------------
_chartohex:
;	.\cmon51.c:140: i=toupper(c)-'0';
	mov  r2,dpl
	push	ar2
	lcall	_islower
	mov	a,dpl
	pop	ar2
	jz	L005005?
	mov	a,#0xDF
	anl	a,r2
	mov	r3,a
	sjmp	L005006?
L005005?:
	mov	ar3,r2
L005006?:
	mov	a,r3
	add	a,#0xd0
;	.\cmon51.c:141: if(i>9) i-=7; //letter from A to F
	mov  r2,a
	add	a,#0xff - 0x09
	jnc	L005002?
	mov	a,r2
	add	a,#0xf9
	mov	r2,a
L005002?:
;	.\cmon51.c:142: return i;
	mov	dpl,r2
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'outbyte'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	.\cmon51.c:145: void outbyte(unsigned char x)
;	-----------------------------------------
;	 function outbyte
;	-----------------------------------------
_outbyte:
	mov	r2,dpl
;	.\cmon51.c:147: putc(hexval[x/0x10]);
L006001?:
	jb	_JTXFULL,L006001?
	mov	a,r2
	swap	a
	anl	a,#0x0f
	mov	r3,a
	mov	dptr,#_hexval
	movc	a,@a+dptr
	mov	_JBUF,a
;	.\cmon51.c:148: putc(hexval[x&0xf]);	
L006004?:
	jb	_JTXFULL,L006004?
	mov	a,#0x0F
	anl	a,r2
	mov	dptr,#_hexval
	movc	a,@a+dptr
	mov	_JBUF,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'outword'
;------------------------------------------------------------
;x                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	.\cmon51.c:151: void outword(unsigned int x)
;	-----------------------------------------
;	 function outword
;	-----------------------------------------
_outword:
	mov	r2,dpl
	mov	r3,dph
;	.\cmon51.c:153: outbyte(highof(x));
	mov	ar4,r3
	mov	dpl,r4
	push	ar2
	push	ar3
	lcall	_outbyte
	pop	ar3
	pop	ar2
;	.\cmon51.c:154: outbyte(lowof(x));
	mov	dpl,r2
	ljmp	_outbyte
;------------------------------------------------------------
;Allocation info for local variables in function 'fillmem'
;------------------------------------------------------------
;len                       Allocated with name '_fillmem_PARM_2'
;val                       Allocated with name '_fillmem_PARM_3'
;begin                     Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;	.\cmon51.c:158: void fillmem(unsigned char * begin,  unsigned int len, unsigned char val)
;	-----------------------------------------
;	 function fillmem
;	-----------------------------------------
_fillmem:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	.\cmon51.c:160: while(len)
	mov	r5,_fillmem_PARM_2
	mov	r6,(_fillmem_PARM_2 + 1)
L008001?:
	mov	a,r5
	orl	a,r6
	jz	L008004?
;	.\cmon51.c:162: *begin=val;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,_fillmem_PARM_3
	lcall	__gptrput
	inc	dptr
	mov	r2,dpl
	mov	r3,dph
;	.\cmon51.c:163: begin++;
;	.\cmon51.c:164: len--;
	dec	r5
	cjne	r5,#0xff,L008001?
	dec	r6
	sjmp	L008001?
L008004?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getbytene'
;------------------------------------------------------------
;j                         Allocated to registers r2 
;------------------------------------------------------------
;	.\cmon51.c:169: unsigned char getbytene (void)
;	-----------------------------------------
;	 function getbytene
;	-----------------------------------------
_getbytene:
;	.\cmon51.c:173: j=chartohex(getchar());
	lcall	_getchar
	lcall	_chartohex
;	.\cmon51.c:174: return (j*0x10+chartohex(getchar()));
	mov	a,dpl
	swap	a
	anl	a,#0xf0
	mov	r2,a
	push	ar2
	lcall	_getchar
	lcall	_chartohex
	mov	r3,dpl
	pop	ar2
	mov	a,r3
	add	a,r2
	mov	dpl,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getbyte'
;------------------------------------------------------------
;i                         Allocated to registers r5 
;j                         Allocated to registers r2 
;k                         Allocated to registers r3 
;------------------------------------------------------------
;	.\cmon51.c:178: unsigned char getbyte (void)
;	-----------------------------------------
;	 function getbyte
;	-----------------------------------------
_getbyte:
;	.\cmon51.c:180: unsigned char i, j=0, k;
	mov	r2,#0x00
;	.\cmon51.c:182: for (k=0; k<2; k++)
	mov	r3,#0x00
	mov	r4,#0x00
L010014?:
	cjne	r4,#0x02,L010031?
L010031?:
	jc	L010032?
	ljmp	L010017?
L010032?:
;	.\cmon51.c:184: i=getchar();
	push	ar2
	push	ar3
	push	ar4
	lcall	_getchar
	mov	r5,dpl
	pop	ar4
	pop	ar3
	pop	ar2
;	.\cmon51.c:185: putc(i==(unsigned char)' '?'x':i);
L010001?:
	jb	_JTXFULL,L010001?
	clr	a
	cjne	r5,#0x20,L010034?
	inc	a
L010034?:
	mov	r6,a
	jz	L010020?
	mov	r7,#0x78
	sjmp	L010021?
L010020?:
	mov	ar7,r5
L010021?:
	mov	_JBUF,r7
;	.\cmon51.c:186: if(!isxdigit(i))
	mov	dpl,r5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_isxdigit
	mov	a,dpl
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	jnz	L010013?
;	.\cmon51.c:188: validbyte=0;
	clr	_validbyte
;	.\cmon51.c:189: if(i==(unsigned char)' ')
	mov	a,r6
	jz	L010010?
;	.\cmon51.c:191: keepediting=1;
	setb	_keepediting
;	.\cmon51.c:192: if(k==0) putc('x');
	mov	a,r3
	jnz	L010011?
L010004?:
	jb	_JTXFULL,L010004?
	mov	_JBUF,#0x78
	sjmp	L010011?
L010010?:
;	.\cmon51.c:194: else keepediting=0;
	clr	_keepediting
L010011?:
;	.\cmon51.c:195: return j;
	mov	dpl,r2
	ret
L010013?:
;	.\cmon51.c:197: j=j*0x10+chartohex(i);
	mov	a,r2
	swap	a
	anl	a,#0xf0
	mov	r6,a
	mov	dpl,r5
	push	ar4
	push	ar6
	lcall	_chartohex
	mov	r5,dpl
	pop	ar6
	pop	ar4
	mov	a,r5
	add	a,r6
	mov	r2,a
;	.\cmon51.c:182: for (k=0; k<2; k++)
	inc	r4
	mov	ar3,r4
	ljmp	L010014?
L010017?:
;	.\cmon51.c:199: keepediting=1;
	setb	_keepediting
;	.\cmon51.c:200: validbyte=1;
	setb	_validbyte
;	.\cmon51.c:201: return j;
	mov	dpl,r2
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'modifymem'
;------------------------------------------------------------
;loc                       Allocated with name '_modifymem_PARM_2'
;ptr                       Allocated to registers r2 r3 r4 
;j                         Allocated to registers r6 
;k                         Allocated to registers r5 
;------------------------------------------------------------
;	.\cmon51.c:205: void modifymem(unsigned char * ptr,  char loc)
;	-----------------------------------------
;	 function modifymem
;	-----------------------------------------
_modifymem:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	.\cmon51.c:207: unsigned char j, k=0;
	mov	r5,#0x00
;	.\cmon51.c:209: while(1)
L011034?:
;	.\cmon51.c:211: if(k==0)
	mov	a,r5
	jnz	L011016?
;	.\cmon51.c:213: putnl();
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_putnl
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	.\cmon51.c:214: putc(loc);
L011001?:
	jb	_JTXFULL,L011001?
	mov	r6,_modifymem_PARM_2
	mov	_JBUF,r6
;	.\cmon51.c:215: putc(':');
L011004?:
	jb	_JTXFULL,L011004?
	mov	_JBUF,#0x3A
;	.\cmon51.c:216: if((loc=='D')||(loc=='I'))
	cjne	r6,#0x44,L011061?
	sjmp	L011007?
L011061?:
	cjne	r6,#0x49,L011008?
L011007?:
;	.\cmon51.c:217: outbyte((unsigned char)ptr);
	mov	dpl,r2
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_outbyte
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	sjmp	L011011?
L011008?:
;	.\cmon51.c:219: outword((unsigned int)ptr);
	mov	dpl,r2
	mov	dph,r3
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_outword
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	.\cmon51.c:220: putc(':');
L011011?:
	jb	_JTXFULL,L011011?
	mov	_JBUF,#0x3A
;	.\cmon51.c:222: putc(' ');
L011016?:
	jb	_JTXFULL,L011016?
	mov	_JBUF,#0x20
;	.\cmon51.c:223: outbyte(*ptr);
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	dpl,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_outbyte
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	.\cmon51.c:224: putc('.');
L011019?:
	jb	_JTXFULL,L011019?
	mov	_JBUF,#0x2E
;	.\cmon51.c:225: j=getbyte();
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_getbyte
	mov	r6,dpl
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	.\cmon51.c:226: if((!validbyte)&&(!keepediting)) break;
	jb	_validbyte,L011023?
	jnb	_keepediting,L011035?
L011023?:
;	.\cmon51.c:227: if(validbyte) *ptr=j;
	jnb	_validbyte,L011027?
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r6
	lcall	__gptrput
;	.\cmon51.c:228: putc('\b');
L011027?:
	jb	_JTXFULL,L011027?
	mov	_JBUF,#0x08
;	.\cmon51.c:229: putc('\b');
L011030?:
	jb	_JTXFULL,L011030?
	mov	_JBUF,#0x08
;	.\cmon51.c:230: outbyte(*ptr);
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r6,a
	inc	dptr
	mov	r2,dpl
	mov	r3,dph
	mov	dpl,r6
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_outbyte
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	.\cmon51.c:231: ptr++;
;	.\cmon51.c:232: ++k;
	inc	r5
;	.\cmon51.c:233: k&=7;
	anl	ar5,#0x07
	ljmp	L011034?
L011035?:
;	.\cmon51.c:235: putnl();
	ljmp	_putnl
;------------------------------------------------------------
;Allocation info for local variables in function 'hitanykey'
;------------------------------------------------------------
;c                         Allocated with name '_hitanykey_c_1_124'
;------------------------------------------------------------
;	.\cmon51.c:238: unsigned char hitanykey (void)
;	-----------------------------------------
;	 function hitanykey
;	-----------------------------------------
_hitanykey:
;	.\cmon51.c:242: putsp("<Space>=line <Enter>=page <ESC>=stop\r");
	mov	dptr,#__str_2
	mov	b,#0x80
	lcall	_putsp
;	.\cmon51.c:243: c=getchar();
	lcall	_getchar
	mov	_hitanykey_c_1_124,dpl
;	.\cmon51.c:244: clearline();
	lcall	_clearline
;	.\cmon51.c:245: return (c);
	mov	dpl,_hitanykey_c_1_124
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'dispmem'
;------------------------------------------------------------
;len                       Allocated with name '_dispmem_PARM_2'
;loc                       Allocated with name '_dispmem_PARM_3'
;begin                     Allocated with name '_dispmem_begin_1_125'
;j                         Allocated with name '_dispmem_j_1_126'
;n                         Allocated to registers r2 
;i                         Allocated to registers r3 
;k                         Allocated with name '_dispmem_k_1_126'
;------------------------------------------------------------
;	.\cmon51.c:249: void dispmem(unsigned char * begin,  unsigned int len, char loc)
;	-----------------------------------------
;	 function dispmem
;	-----------------------------------------
_dispmem:
	mov	_dispmem_begin_1_125,dpl
	mov	(_dispmem_begin_1_125 + 1),dph
	mov	(_dispmem_begin_1_125 + 2),b
;	.\cmon51.c:252: unsigned char n, i, k=0;
	mov	_dispmem_k_1_126,#0x00
;	.\cmon51.c:254: if(len==0) len=0x80;
	mov	a,_dispmem_PARM_2
	orl	a,(_dispmem_PARM_2 + 1)
	jnz	L013002?
	mov	_dispmem_PARM_2,#0x80
	clr	a
	mov	(_dispmem_PARM_2 + 1),a
L013002?:
;	.\cmon51.c:256: buff[16]=0;
	mov	(_buff + 0x0010),#0x00
;	.\cmon51.c:258: for(j=0; j<len; j++)
	mov	a,#0x49
	cjne	a,_dispmem_PARM_3,L013065?
	mov	a,#0x01
	sjmp	L013066?
L013065?:
	clr	a
L013066?:
	mov	r6,a
	clr	a
	mov	_dispmem_j_1_126,a
	mov	(_dispmem_j_1_126 + 1),a
L013036?:
	clr	c
	mov	a,_dispmem_j_1_126
	subb	a,_dispmem_PARM_2
	mov	a,(_dispmem_j_1_126 + 1)
	subb	a,(_dispmem_PARM_2 + 1)
	jc	L013067?
	ret
L013067?:
;	.\cmon51.c:260: if(loc=='I')
	mov	a,r6
	jz	L013004?
;	.\cmon51.c:262: n=*(idata unsigned char *)((unsigned char)begin+j);
	mov	r2,_dispmem_begin_1_125
	mov	r3,#0x00
	mov	a,_dispmem_j_1_126
	add	a,r2
	mov	r2,a
	mov	a,(_dispmem_j_1_126 + 1)
	addc	a,r3
	mov	r3,a
	mov	ar0,r2
	mov	ar2,@r0
	sjmp	L013005?
L013004?:
;	.\cmon51.c:266: n=begin[j];
	mov	a,_dispmem_j_1_126
	add	a,_dispmem_begin_1_125
	mov	r3,a
	mov	a,(_dispmem_j_1_126 + 1)
	addc	a,(_dispmem_begin_1_125 + 1)
	mov	r4,a
	mov	r5,(_dispmem_begin_1_125 + 2)
	mov	dpl,r3
	mov	dph,r4
	mov	b,r5
	lcall	__gptrget
	mov	r2,a
L013005?:
;	.\cmon51.c:268: i=j&0xf;
	mov	a,#0x0F
	anl	a,_dispmem_j_1_126
;	.\cmon51.c:270: if(i==0) 
	mov	r3,a
	mov	r4,#0x00
	jnz	L013017?
;	.\cmon51.c:272: putc(loc);  //A letter to indicate Data, Xram, Code, Idata
L013006?:
	jb	_JTXFULL,L013006?
	mov	r4,_dispmem_PARM_3
	mov	_JBUF,r4
;	.\cmon51.c:273: putc(':');
L013009?:
	jb	_JTXFULL,L013009?
	mov	_JBUF,#0x3A
;	.\cmon51.c:274: if((loc=='D')||(loc=='I'))
	cjne	r4,#0x44,L013072?
	sjmp	L013012?
L013072?:
	cjne	r4,#0x49,L013013?
L013012?:
;	.\cmon51.c:275: outbyte((unsigned char)begin+j);
	mov	r4,_dispmem_begin_1_125
	mov	a,_dispmem_j_1_126
	add	a,r4
	mov	dpl,a
	push	ar2
	push	ar3
	push	ar6
	lcall	_outbyte
	pop	ar6
	pop	ar3
	pop	ar2
	sjmp	L013014?
L013013?:
;	.\cmon51.c:277: outword((unsigned int)begin+j);
	mov	r4,_dispmem_begin_1_125
	mov	r5,(_dispmem_begin_1_125 + 1)
	mov	a,_dispmem_j_1_126
	add	a,r4
	mov	dpl,a
	mov	a,(_dispmem_j_1_126 + 1)
	addc	a,r5
	mov	dph,a
	push	ar2
	push	ar3
	push	ar6
	lcall	_outword
	pop	ar6
	pop	ar3
	pop	ar2
L013014?:
;	.\cmon51.c:278: putsp(":  ");
	mov	dptr,#__str_3
	mov	b,#0x80
	push	ar2
	push	ar3
	push	ar6
	lcall	_putsp
	pop	ar6
	pop	ar3
	pop	ar2
L013017?:
;	.\cmon51.c:280: outbyte(n);
	mov	dpl,r2
	push	ar2
	push	ar3
	push	ar6
	lcall	_outbyte
	pop	ar6
	pop	ar3
	pop	ar2
;	.\cmon51.c:281: putc(i==7?'-':' '); //A middle separator like the old good DOS debug
L013018?:
	jb	_JTXFULL,L013018?
	cjne	r3,#0x07,L013042?
	mov	r4,#0x2D
	sjmp	L013043?
L013042?:
	mov	r4,#0x20
L013043?:
	mov	_JBUF,r4
;	.\cmon51.c:283: if((n>0x20)&&(n<0x7f))
	mov	a,r2
	add	a,#0xff - 0x20
	jnc	L013022?
	cjne	r2,#0x7F,L013079?
L013079?:
	jnc	L013022?
;	.\cmon51.c:284: buff[i]=n;
	mov	a,r3
	add	a,#_buff
	mov	r0,a
	mov	@r0,ar2
	sjmp	L013023?
L013022?:
;	.\cmon51.c:286: buff[i]='.';
	mov	a,r3
	add	a,#_buff
	mov	r0,a
	mov	@r0,#0x2E
L013023?:
;	.\cmon51.c:288: if(i==0xf)
	cjne	r3,#0x0F,L013038?
;	.\cmon51.c:290: putsp("   ");
	mov	dptr,#__str_4
	mov	b,#0x80
	push	ar6
	lcall	_putsp
;	.\cmon51.c:291: putsp(buff);
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_putsp
;	.\cmon51.c:292: putnl();
	lcall	_putnl
	pop	ar6
;	.\cmon51.c:293: if((++k==23) && (j<len)) 
	inc	_dispmem_k_1_126
	mov	a,#0x17
	cjne	a,_dispmem_k_1_126,L013038?
	clr	c
	mov	a,_dispmem_j_1_126
	subb	a,_dispmem_PARM_2
	mov	a,(_dispmem_j_1_126 + 1)
	subb	a,(_dispmem_PARM_2 + 1)
	jnc	L013038?
;	.\cmon51.c:295: n=hitanykey();
	push	ar6
	lcall	_hitanykey
	mov	r2,dpl
	pop	ar6
;	.\cmon51.c:296: if (n==0x1b) break;
	cjne	r2,#0x1B,L013086?
	ret
L013086?:
;	.\cmon51.c:297: else if (n==(unsigned char)' ') k--;
	cjne	r2,#0x20,L013026?
	dec	_dispmem_k_1_126
	sjmp	L013038?
L013026?:
;	.\cmon51.c:298: else k=0;
	mov	_dispmem_k_1_126,#0x00
L013038?:
;	.\cmon51.c:258: for(j=0; j<len; j++)
	inc	_dispmem_j_1_126
	clr	a
	cjne	a,_dispmem_j_1_126,L013089?
	inc	(_dispmem_j_1_126 + 1)
L013089?:
	ljmp	L013036?
;------------------------------------------------------------
;Allocation info for local variables in function 'cleanbuff'
;------------------------------------------------------------
;j                         Allocated to registers r2 
;k                         Allocated to registers r2 
;------------------------------------------------------------
;	.\cmon51.c:305: void cleanbuff (void)
;	-----------------------------------------
;	 function cleanbuff
;	-----------------------------------------
_cleanbuff:
;	.\cmon51.c:309: buff_haseq=0;
	clr	_buff_haseq
;	.\cmon51.c:310: buff_hasdot=0;
	clr	_buff_hasdot
;	.\cmon51.c:313: for(j=0; j<BUFFSIZE; j++)
	mov	r2,#0x00
L014013?:
	cjne	r2,#0x20,L014044?
L014044?:
	jnc	L014016?
;	.\cmon51.c:315: buff[j]=toupper(buff[j]);
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	dpl,@r0
	push	ar2
	push	ar0
	lcall	_islower
	mov	a,dpl
	pop	ar0
	pop	ar2
	jz	L014027?
	mov	a,r2
	add	a,#_buff
	mov	r1,a
	mov	ar3,@r1
	anl	ar3,#0xDF
	sjmp	L014028?
L014027?:
	mov	a,r2
	add	a,#_buff
	mov	r1,a
	mov	ar3,@r1
L014028?:
	mov	@r0,ar3
;	.\cmon51.c:316: if(isspace(buff[j])) buff[j]=0;
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	dpl,@r0
	push	ar2
	lcall	_isspace
	mov	a,dpl
	pop	ar2
	jz	L014002?
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	@r0,#0x00
L014002?:
;	.\cmon51.c:317: if(buff[j]=='=')
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	ar3,@r0
	cjne	r3,#0x3D,L014007?
;	.\cmon51.c:319: buff[j]=0;
	mov	@r0,#0x00
;	.\cmon51.c:320: buff_haseq=1;
	setb	_buff_haseq
	sjmp	L014015?
L014007?:
;	.\cmon51.c:322: else if((buff[j]=='.')||(buff[j]=='_'))
	mov	ar3,@r0
	cjne	r3,#0x2E,L014050?
	sjmp	L014003?
L014050?:
	cjne	r3,#0x5F,L014015?
L014003?:
;	.\cmon51.c:324: buff[j]=0;
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	@r0,#0x00
;	.\cmon51.c:325: buff_hasdot=1;
	setb	_buff_hasdot
L014015?:
;	.\cmon51.c:313: for(j=0; j<BUFFSIZE; j++)
	inc	r2
	sjmp	L014013?
L014016?:
;	.\cmon51.c:330: for(j=0, k=0; j<BUFFSIZE; j++)
	mov	r2,#0x00
	mov	r3,#0x00
L014017?:
	cjne	r3,#0x20,L014053?
L014053?:
	jnc	L014040?
;	.\cmon51.c:332: buff[k]=buff[j];
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	a,r3
	add	a,#_buff
	mov	r1,a
	mov	ar4,@r1
	mov	@r0,ar4
;	.\cmon51.c:333: if( ((buff[j]!=0)||(buff[j+1]!=0)) && buff[0]!=0) k++;
	mov	a,r4
	jnz	L014012?
	mov	a,r3
	inc	a
	add	a,#_buff
	mov	r0,a
	mov	a,@r0
	jz	L014019?
L014012?:
	mov	a,_buff
	jz	L014019?
	inc	r2
L014019?:
;	.\cmon51.c:330: for(j=0, k=0; j<BUFFSIZE; j++)
	inc	r3
	sjmp	L014017?
L014040?:
L014021?:
;	.\cmon51.c:335: for(; k<BUFFSIZE; k++) buff[k]=0;
	cjne	r2,#0x20,L014058?
L014058?:
	jnc	L014025?
	mov	a,r2
	add	a,#_buff
	mov	r0,a
	mov	@r0,#0x00
	inc	r2
	sjmp	L014021?
L014025?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getwordn'
;------------------------------------------------------------
;word                      Allocated to registers r2 r3 
;------------------------------------------------------------
;	.\cmon51.c:339: unsigned int getwordn(void)
;	-----------------------------------------
;	 function getwordn
;	-----------------------------------------
_getwordn:
;	.\cmon51.c:341: unsigned int word=0;
	mov	r2,#0x00
	mov	r3,#0x00
;	.\cmon51.c:348: cursor++;
L015003?:
;	.\cmon51.c:343: for( ; buff[cursor]!=0; cursor++)
	mov	a,_cursor
	add	a,#_buff
	mov	r0,a
	mov	ar4,@r0
	cjne	r4,#0x00,L015012?
	sjmp	L015006?
L015012?:
;	.\cmon51.c:345: if(isxdigit(buff[cursor]))
	mov	dpl,r4
	push	ar2
	push	ar3
	lcall	_isxdigit
	mov	a,dpl
	pop	ar3
	pop	ar2
	jz	L015005?
;	.\cmon51.c:346: word=(word*0x10)+chartohex(buff[cursor]);
	mov	ar4,r2
	mov	a,r3
	swap	a
	anl	a,#0xf0
	xch	a,r4
	swap	a
	xch	a,r4
	xrl	a,r4
	xch	a,r4
	anl	a,#0xf0
	xch	a,r4
	xrl	a,r4
	mov	r5,a
	mov	a,_cursor
	add	a,#_buff
	mov	r0,a
	mov	dpl,@r0
	push	ar4
	push	ar5
	lcall	_chartohex
	mov	r6,dpl
	pop	ar5
	pop	ar4
	mov	r7,#0x00
	mov	a,r6
	add	a,r4
	mov	r2,a
	mov	a,r7
	addc	a,r5
	mov	r3,a
L015005?:
;	.\cmon51.c:343: for( ; buff[cursor]!=0; cursor++)
	inc	_cursor
	sjmp	L015003?
L015006?:
;	.\cmon51.c:348: cursor++;
	inc	_cursor
;	.\cmon51.c:349: return word;
	mov	dpl,r2
	mov	dph,r3
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'showreg'
;------------------------------------------------------------
;val                       Allocated with name '_showreg_PARM_2'
;name                      Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;	.\cmon51.c:352: void showreg(char * name, unsigned char val)
;	-----------------------------------------
;	 function showreg
;	-----------------------------------------
_showreg:
;	.\cmon51.c:354: putsp(name);
	lcall	_putsp
;	.\cmon51.c:355: putc('=');
L016001?:
	jb	_JTXFULL,L016001?
	mov	_JBUF,#0x3D
;	.\cmon51.c:356: outbyte(val);
	mov	dpl,_showreg_PARM_2
	lcall	_outbyte
;	.\cmon51.c:357: putc(' ');
L016004?:
	jb	_JTXFULL,L016004?
	mov	_JBUF,#0x20
;	.\cmon51.c:358: putc(' ');
L016007?:
	jb	_JTXFULL,L016007?
	mov	_JBUF,#0x20
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'disp_regs'
;------------------------------------------------------------
;j                         Allocated to registers r4 
;bank                      Allocated to registers r2 
;------------------------------------------------------------
;	.\cmon51.c:361: void disp_regs(void)
;	-----------------------------------------
;	 function disp_regs
;	-----------------------------------------
_disp_regs:
;	.\cmon51.c:365: putnl();
	lcall	_putnl
;	.\cmon51.c:366: showreg("A ", A_save);
	mov	dptr,#_A_save
	movx	a,@dptr
	mov	_showreg_PARM_2,a
	mov	dptr,#__str_5
	mov	b,#0x80
	lcall	_showreg
;	.\cmon51.c:367: showreg("B ", B_save);
	mov	dptr,#_B_save
	movx	a,@dptr
	mov	_showreg_PARM_2,a
	mov	dptr,#__str_6
	mov	b,#0x80
	lcall	_showreg
;	.\cmon51.c:368: showreg("SP", SP_save);
	mov	dptr,#_SP_save
	movx	a,@dptr
	mov	_showreg_PARM_2,a
	mov	dptr,#__str_7
	mov	b,#0x80
	lcall	_showreg
;	.\cmon51.c:369: showreg("IE", IE_save);
	mov	dptr,#_IE_save
	movx	a,@dptr
	mov	_showreg_PARM_2,a
	mov	dptr,#__str_8
	mov	b,#0x80
	lcall	_showreg
;	.\cmon51.c:370: showreg("DPH", DPH_save);
	mov	dptr,#_DPH_save
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	_showreg_PARM_2,r2
	mov	dptr,#__str_9
	mov	b,#0x80
	lcall	_showreg
;	.\cmon51.c:371: showreg("DPL", DPL_save);
	mov	dptr,#_DPL_save
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	_showreg_PARM_2,r2
	mov	dptr,#__str_10
	mov	b,#0x80
	lcall	_showreg
;	.\cmon51.c:372: showreg("PSW", PSW_save);
	mov	dptr,#_PSW_save
	movx	a,@dptr
	mov	_showreg_PARM_2,a
	mov	dptr,#__str_11
	mov	b,#0x80
	lcall	_showreg
;	.\cmon51.c:373: putsp("PC=");
	mov	dptr,#__str_12
	mov	b,#0x80
	lcall	_putsp
;	.\cmon51.c:374: outword(PC_save);
	mov	dptr,#_PC_save
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dpl,r2
	mov	dph,r3
	lcall	_outword
;	.\cmon51.c:375: putnl();
	lcall	_putnl
;	.\cmon51.c:377: bank=(PSW_save/0x8)&0x3;
	mov	dptr,#_PSW_save
	movx	a,@dptr
	swap	a
	rl	a
	anl	a,#0x1f
	mov	r2,a
	anl	ar2,#0x03
;	.\cmon51.c:378: buff[0]='R';
	mov	_buff,#0x52
;	.\cmon51.c:379: buff[2]=0;
	mov	(_buff + 0x0002),#0x00
;	.\cmon51.c:380: for(j=0; j<8; j++)
	mov	a,r2
	swap	a
	rr	a
	anl	a,#0xf8
	mov	r3,a
	mov	r4,#0x00
L017004?:
	cjne	r4,#0x08,L017015?
L017015?:
	jnc	L017007?
;	.\cmon51.c:382: buff[1]='0'+j;
	mov	a,#0x30
	add	a,r4
	mov	(_buff + 0x0001),a
;	.\cmon51.c:383: showreg(buff, iram_save[j+bank*8]);
	mov	a,r3
	add	a,r4
	add	a,#_iram_save
	mov	dpl,a
	clr	a
	addc	a,#(_iram_save >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	_showreg_PARM_2,a
	mov	dptr,#_buff
	mov	b,#0x40
	push	ar2
	push	ar3
	push	ar4
	lcall	_showreg
	pop	ar4
	pop	ar3
	pop	ar2
;	.\cmon51.c:380: for(j=0; j<8; j++)
	inc	r4
	sjmp	L017004?
L017007?:
;	.\cmon51.c:385: putsp("BANK ");
	mov	dptr,#__str_13
	mov	b,#0x80
	push	ar2
	lcall	_putsp
	pop	ar2
;	.\cmon51.c:386: putc('0'+bank);
L017001?:
	jb	_JTXFULL,L017001?
	mov	a,#0x30
	add	a,r2
	mov	_JBUF,a
;	.\cmon51.c:387: putnl();
	ljmp	_putnl
;------------------------------------------------------------
;Allocation info for local variables in function 'outwordnl'
;------------------------------------------------------------
;val                       Allocated to registers r2 r3 
;------------------------------------------------------------
;	.\cmon51.c:390: void outwordnl (unsigned int val)
;	-----------------------------------------
;	 function outwordnl
;	-----------------------------------------
_outwordnl:
;	.\cmon51.c:392: outword(val);
	lcall	_outword
;	.\cmon51.c:393: putnl();
	ljmp	_putnl
;------------------------------------------------------------
;Allocation info for local variables in function 'nlist'
;------------------------------------------------------------
;slist                     Allocated to registers r2 r3 r4 
;x                         Allocated to registers r5 
;q                         Allocated with name '_nlist_q_1_157'
;sloc0                     Allocated with name '_nlist_sloc0_1_0'
;------------------------------------------------------------
;	.\cmon51.c:396: unsigned char nlist (unsigned char * slist)
;	-----------------------------------------
;	 function nlist
;	-----------------------------------------
_nlist:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	.\cmon51.c:398: unsigned char x=0xff, q;
	mov	r5,#0xFF
;	.\cmon51.c:400: while(*slist)
L019006?:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r6,a
	jz	L019008?
;	.\cmon51.c:402: if((*slist)>0x7f)
	mov	a,r6
	add	a,#0xff - 0x7F
	jnc	L019005?
;	.\cmon51.c:404: x=*(slist++);
	mov	ar5,r6
	inc	r2
	cjne	r2,#0x00,L019029?
	inc	r3
L019029?:
;	.\cmon51.c:405: for(q=0; (*slist<=0x7f) && (*slist==(unsigned char)buff[q]) ; q++) slist++;
	mov	_nlist_sloc0_1_0,r2
	mov	(_nlist_sloc0_1_0 + 1),r3
	mov	(_nlist_sloc0_1_0 + 2),r4
	mov	_nlist_q_1_157,#0x00
L019012?:
	mov	dpl,_nlist_sloc0_1_0
	mov	dph,(_nlist_sloc0_1_0 + 1)
	mov	b,(_nlist_sloc0_1_0 + 2)
	lcall	__gptrget
	mov  r7,a
	add	a,#0xff - 0x7F
	jc	L019026?
	mov	a,_nlist_q_1_157
	add	a,#_buff
	mov	r0,a
	mov	ar6,@r0
	mov	a,r7
	cjne	a,ar6,L019026?
	inc	_nlist_sloc0_1_0
	clr	a
	cjne	a,_nlist_sloc0_1_0,L019033?
	inc	(_nlist_sloc0_1_0 + 1)
L019033?:
	inc	_nlist_q_1_157
	sjmp	L019012?
L019026?:
	mov	r2,_nlist_sloc0_1_0
	mov	r3,(_nlist_sloc0_1_0 + 1)
	mov	r4,(_nlist_sloc0_1_0 + 2)
;	.\cmon51.c:406: if((*slist>0x7f)&&(buff[q]==0)) break;
	mov	dpl,_nlist_sloc0_1_0
	mov	dph,(_nlist_sloc0_1_0 + 1)
	mov	b,(_nlist_sloc0_1_0 + 2)
	lcall	__gptrget
	mov  r6,a
	add	a,#0xff - 0x7F
	jnc	L019005?
	mov	a,_nlist_q_1_157
	add	a,#_buff
	mov	r0,a
	mov	a,@r0
	jz	L019008?
L019005?:
;	.\cmon51.c:408: slist++;
	inc	r2
	cjne	r2,#0x00,L019006?
	inc	r3
	sjmp	L019006?
L019008?:
;	.\cmon51.c:410: if(*slist) return x;//Found one!
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	jz	L019010?
	mov	dpl,r5
;	.\cmon51.c:411: return 0xff; //What if a sfr is located at 0xff?
	ret
L019010?:
	mov	dpl,#0xFF
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'breakorstep'
;------------------------------------------------------------
;n                         Allocated to registers r2 
;------------------------------------------------------------
;	.\cmon51.c:414: void breakorstep (void)
;	-----------------------------------------
;	 function breakorstep
;	-----------------------------------------
_breakorstep:
;	.\cmon51.c:418: gotbreak=0;
	mov	dptr,#_gotbreak
	clr	a
	movx	@dptr,a
;	.\cmon51.c:419: breakpoint=0;
	clr	_breakpoint
;	.\cmon51.c:421: if(go_pending==0x55)
	mov	dptr,#_go_pending
	movx	a,@dptr
	mov	r2,a
	cjne	r2,#0x55,L020002?
;	.\cmon51.c:423: go_pending=0xaa;
	mov	dptr,#_go_pending
	mov	a,#0xAA
	movx	@dptr,a
;	.\cmon51.c:424: step_start=PC_save; //Next instruction to be executed
	mov	dptr,#_PC_save
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dptr,#_step_start
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	.\cmon51.c:425: gotbreak=0; //If changes to 1, the single step function worked!
	mov	dptr,#_gotbreak
	clr	a
	movx	@dptr,a
;	.\cmon51.c:426: gostep=1;
	mov	dptr,#_gostep
	mov	a,#0x01
	movx	@dptr,a
;	.\cmon51.c:427: dostep();
	lcall	_dostep
L020002?:
;	.\cmon51.c:429: go_pending=0xaa;	
	mov	dptr,#_go_pending
	mov	a,#0xAA
	movx	@dptr,a
;	.\cmon51.c:431: if (trace_type)
	mov	dptr,#_trace_type
	movx	a,@dptr
	mov	r2,a
	jnz	L020043?
	ljmp	L020017?
L020043?:
;	.\cmon51.c:433: if(trace_type==1) //Run in trace mode until a breapoint is hit
	mov	dptr,#_trace_type
	movx	a,@dptr
	mov	r2,a
	cjne	r2,#0x01,L020006?
;	.\cmon51.c:435: for (n=0; n<4; n++)
	mov	r2,#0x00
L020021?:
	cjne	r2,#0x04,L020046?
L020046?:
	jnc	L020006?
;	.\cmon51.c:437: if(br[n]==PC_save)
	mov	a,r2
	add	a,r2
	add	a,#_br
	mov	dpl,a
	clr	a
	addc	a,#(_br >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	mov	dptr,#_PC_save
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	mov	a,r3
	cjne	a,ar5,L020023?
	mov	a,r4
	cjne	a,ar6,L020023?
;	.\cmon51.c:439: breakpoint=1;
	setb	_breakpoint
L020023?:
;	.\cmon51.c:435: for (n=0; n<4; n++)
	inc	r2
	sjmp	L020021?
L020006?:
;	.\cmon51.c:443: if ((break_address!=PC_save))
	mov	dptr,#_break_address
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dptr,#_PC_save
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	mov	a,r2
	cjne	a,ar4,L020050?
	mov	a,r3
	cjne	a,ar5,L020050?
	sjmp	L020017?
L020050?:
;	.\cmon51.c:445: if (trace_type>=2)
	mov	dptr,#_trace_type
	movx	a,@dptr
	mov	r2,a
	cjne	r2,#0x02,L020051?
L020051?:
	jc	L020008?
;	.\cmon51.c:447: discnt=1;
	mov	_discnt,#0x01
	clr	a
	mov	(_discnt + 1),a
;	.\cmon51.c:448: unassemble(step_start); //The executed assembly instruction...
	mov	dptr,#_step_start
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dpl,r2
	mov	dph,r3
	lcall	_unassemble
L020008?:
;	.\cmon51.c:450: if((JRXRDY==0)&&(breakpoint==0))
	jb	_JRXRDY,L020017?
	jb	_breakpoint,L020017?
;	.\cmon51.c:452: if(trace_type==3) disp_regs();
	mov	dptr,#_trace_type
	movx	a,@dptr
	mov	r2,a
	cjne	r2,#0x03,L020010?
	lcall	_disp_regs
L020010?:
;	.\cmon51.c:453: step_start=PC_save;
	mov	dptr,#_PC_save
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dptr,#_step_start
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	.\cmon51.c:454: dostep();
	lcall	_dostep
L020017?:
;	.\cmon51.c:458: if((trace_type>=2) && (RI==0))
	mov	dptr,#_trace_type
	movx	a,@dptr
	mov	r2,a
	cjne	r2,#0x02,L020057?
L020057?:
	jc	L020019?
	jb	_RI,L020019?
;	.\cmon51.c:460: discnt=1;
	mov	_discnt,#0x01
	clr	a
	mov	(_discnt + 1),a
;	.\cmon51.c:461: unassemble(step_start); //The executed assembly instruction...
	mov	dptr,#_step_start
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dpl,r2
	mov	dph,r3
	lcall	_unassemble
L020019?:
;	.\cmon51.c:465: disp_regs();
	lcall	_disp_regs
;	.\cmon51.c:466: discnt=1;
	mov	_discnt,#0x01
	clr	a
	mov	(_discnt + 1),a
;	.\cmon51.c:467: unassemble(PC_save); //The next assembly instruction...
	mov	dptr,#_PC_save
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dpl,r2
	mov	dph,r3
	ljmp	_unassemble
;------------------------------------------------------------
;Allocation info for local variables in function 'do_cmd'
;------------------------------------------------------------
;i                         Allocated with name '_do_cmd_i_1_172'
;j                         Allocated with name '_do_cmd_j_1_172'
;n                         Allocated with name '_do_cmd_n_1_172'
;p                         Allocated to registers r4 r5 
;q                         Allocated with name '_do_cmd_q_1_172'
;c                         Allocated to registers r6 
;d                         Allocated to registers r2 
;x                         Allocated to registers r7 
;y                         Allocated with name '_do_cmd_y_1_172'
;cmd                       Allocated with name '_do_cmd_cmd_1_172'
;sloc0                     Allocated with name '_do_cmd_sloc0_1_0'
;------------------------------------------------------------
;	.\cmon51.c:470: void do_cmd (void)
;	-----------------------------------------
;	 function do_cmd
;	-----------------------------------------
_do_cmd:
;	.\cmon51.c:478: if (gotbreak!=1) //Power-on reset
	mov	dptr,#_gotbreak
	movx	a,@dptr
	mov	r2,a
	cjne	r2,#0x01,L021373?
	sjmp	L021002?
L021373?:
;	.\cmon51.c:480: putsp(BANNER);
	mov	dptr,#__str_14
	mov	b,#0x80
	lcall	_putsp
;	.\cmon51.c:481: cpuid();
	lcall	_cpuid
;	.\cmon51.c:482: SP_save=7; //Default user stack location
	mov	dptr,#_SP_save
	mov	a,#0x07
	movx	@dptr,a
;	.\cmon51.c:483: LEDG_save=0xff;
	mov	dptr,#_LEDG_save
	mov	a,#0xFF
	movx	@dptr,a
;	.\cmon51.c:484: LEDRA_save=0xff;
	mov	dptr,#_LEDRA_save
	mov	a,#0xFF
	movx	@dptr,a
;	.\cmon51.c:485: LEDRB_save=0xff;
	mov	dptr,#_LEDRB_save
	mov	a,#0xFF
	movx	@dptr,a
;	.\cmon51.c:486: LEDRC_save=0xff;
	mov	dptr,#_LEDRC_save
	mov	a,#0xFF
	movx	@dptr,a
;	.\cmon51.c:487: restorePC();
	lcall	_restorePC
;	.\cmon51.c:488: cmd=0;
	mov	_do_cmd_cmd_1_172,#0x00
;	.\cmon51.c:489: read_sfr(0x80); //Dummy read
	mov	dpl,#0x80
	lcall	_read_sfr
	sjmp	L021256?
L021002?:
;	.\cmon51.c:491: else breakorstep(); //Got here from the beak/step interrupt
	lcall	_breakorstep
;	.\cmon51.c:493: while(1)
L021256?:
;	.\cmon51.c:495: putsp("> ");
	mov	dptr,#__str_1
	mov	b,#0x80
	lcall	_putsp
;	.\cmon51.c:496: fillmem(buff, BUFFSIZE, 0);;
	mov	_fillmem_PARM_2,#0x20
	clr	a
	mov	(_fillmem_PARM_2 + 1),a
	mov	_fillmem_PARM_3,#0x00
	mov	dptr,#_buff
	mov	b,#0x40
	lcall	_fillmem
;	.\cmon51.c:497: getsn();
	lcall	_getsn
;	.\cmon51.c:498: cleanbuff();
	lcall	_cleanbuff
;	.\cmon51.c:499: break_address=0;
	mov	dptr,#_break_address
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
;	.\cmon51.c:500: trace_type=0;
	mov	dptr,#_trace_type
	clr	a
	movx	@dptr,a
;	.\cmon51.c:503: cursor=0;
	mov	_cursor,#0x00
;	.\cmon51.c:504: getwordn();   //skip the command name
	lcall	_getwordn
;	.\cmon51.c:505: n=getwordn(); //n is the first parameter/number
	lcall	_getwordn
	mov	_do_cmd_n_1_172,dpl
	mov	(_do_cmd_n_1_172 + 1),dph
;	.\cmon51.c:506: p=getwordn(); //p is the second parameter/number
	lcall	_getwordn
	mov	r4,dpl
	mov	r5,dph
;	.\cmon51.c:507: q=getwordn(); //q is the third parameter/number
	push	ar4
	push	ar5
	lcall	_getwordn
	mov	_do_cmd_q_1_172,dpl
	mov	(_do_cmd_q_1_172 + 1),dph
	pop	ar5
	pop	ar4
;	.\cmon51.c:508: i=n&0xfff0;
	mov	a,#0xF0
	anl	a,_do_cmd_n_1_172
	mov	_do_cmd_i_1_172,a
	mov	(_do_cmd_i_1_172 + 1),(_do_cmd_n_1_172 + 1)
;	.\cmon51.c:509: j=(p+15)&0xfff0;
	mov	a,#0x0F
	add	a,r4
	mov	r6,a
	clr	a
	addc	a,r5
	mov	r7,a
	mov	a,#0xF0
	anl	a,r6
	mov	_do_cmd_j_1_172,a
	mov	(_do_cmd_j_1_172 + 1),r7
;	.\cmon51.c:510: c=n; // Sometimes for the first parameter we need an unsigned char
	mov	r6,_do_cmd_n_1_172
;	.\cmon51.c:511: p_bit=(p==0?0:1);
	mov	a,r4
	orl	a,r5
	add	a,#0xff
	mov	_do_cmd_p_bit_1_172,c
;	.\cmon51.c:513: cmd=nlist(cmdlst)&0x7f;
	mov	dptr,#_cmdlst
	mov	b,#0x80
	push	ar4
	push	ar5
	push	ar6
	lcall	_nlist
	mov	a,dpl
	pop	ar6
	pop	ar5
	pop	ar4
	anl	a,#0x7F
	mov	_do_cmd_cmd_1_172,a
;	.\cmon51.c:515: switch(cmd)
	mov	a,_do_cmd_cmd_1_172
	mov	r7,a
	add	a,#0xff - 0x2C
	jnc	L021374?
	ljmp	L021189?
L021374?:
	mov	a,r7
L021377?:
	add	a,#(L021375?-3-L021377?)
	movc	a,@a+pc
	push	acc
	mov	a,r7
L021378?:
	add	a,#(L021376?-3-L021378?)
	movc	a,@a+pc
	push	acc
	ret
L021375?:
	db	L021005?
	db	L021006?
	db	L021007?
	db	L021008?
	db	L021009?
	db	L021010?
	db	L021011?
	db	L021012?
	db	L021013?
	db	L021014?
	db	L021015?
	db	L021021?
	db	L021022?
	db	L021023?
	db	L021024?
	db	L021025?
	db	L021029?
	db	L021017?
	db	L021033?
	db	L021034?
	db	L021035?
	db	L021036?
	db	L021037?
	db	L021038?
	db	L021039?
	db	L021040?
	db	L021016?
	db	L021020?
	db	L021044?
	db	L021047?
	db	L021048?
	db	L021049?
	db	L021053?
	db	L021054?
	db	L021055?
	db	L021057?
	db	L021056?
	db	L021116?
	db	L021117?
	db	L021127?
	db	L021128?
	db	L021172?
	db	L021173?
	db	L021180?
	db	L021004?
L021376?:
	db	L021005?>>8
	db	L021006?>>8
	db	L021007?>>8
	db	L021008?>>8
	db	L021009?>>8
	db	L021010?>>8
	db	L021011?>>8
	db	L021012?>>8
	db	L021013?>>8
	db	L021014?>>8
	db	L021015?>>8
	db	L021021?>>8
	db	L021022?>>8
	db	L021023?>>8
	db	L021024?>>8
	db	L021025?>>8
	db	L021029?>>8
	db	L021017?>>8
	db	L021033?>>8
	db	L021034?>>8
	db	L021035?>>8
	db	L021036?>>8
	db	L021037?>>8
	db	L021038?>>8
	db	L021039?>>8
	db	L021040?>>8
	db	L021016?>>8
	db	L021020?>>8
	db	L021044?>>8
	db	L021047?>>8
	db	L021048?>>8
	db	L021049?>>8
	db	L021053?>>8
	db	L021054?>>8
	db	L021055?>>8
	db	L021057?>>8
	db	L021056?>>8
	db	L021116?>>8
	db	L021117?>>8
	db	L021127?>>8
	db	L021128?>>8
	db	L021172?>>8
	db	L021173?>>8
	db	L021180?>>8
	db	L021004?>>8
;	.\cmon51.c:517: case ID_nothing:
L021004?:
;	.\cmon51.c:518: break;
	ljmp	L021256?
;	.\cmon51.c:520: case ID_display_data:
L021005?:
;	.\cmon51.c:521: dispmem(iram_save, 0, 'D');
	clr	a
	mov	_dispmem_PARM_2,a
	mov	(_dispmem_PARM_2 + 1),a
	mov	_dispmem_PARM_3,#0x44
	mov	dptr,#_iram_save
	mov	b,#0x00
	lcall	_dispmem
;	.\cmon51.c:522: break;
	ljmp	L021256?
;	.\cmon51.c:524: case ID_modify_data:
L021006?:
;	.\cmon51.c:525: modifymem(&iram_save[n&0x7f], 'D');
	mov	a,#0x7F
	anl	a,_do_cmd_n_1_172
	mov	r2,#0x00
	add	a,#_iram_save
	mov	r7,a
	mov	a,r2
	addc	a,#(_iram_save >> 8)
	mov	r2,a
	mov	r3,#0x00
	mov	_modifymem_PARM_2,#0x44
	mov	dpl,r7
	mov	dph,r2
	mov	b,r3
	lcall	_modifymem
;	.\cmon51.c:526: break;
	ljmp	L021256?
;	.\cmon51.c:528: case ID_fill_data:
L021007?:
;	.\cmon51.c:529: fillmem(&iram_save[n&0x7f], (p>0x80)?0x80:p, (unsigned char) q);
	mov	a,#0x7F
	anl	a,_do_cmd_n_1_172
	mov	r3,#0x00
	add	a,#_iram_save
	mov	r2,a
	mov	a,r3
	addc	a,#(_iram_save >> 8)
	mov	r3,a
	mov	r7,#0x00
	clr	c
	mov	a,#0x80
	subb	a,r4
	clr	a
	subb	a,r5
	jnc	L021268?
	mov	_do_cmd_sloc0_1_0,#0x80
	clr	a
	mov	(_do_cmd_sloc0_1_0 + 1),a
	sjmp	L021269?
L021268?:
	mov	_do_cmd_sloc0_1_0,r4
	mov	(_do_cmd_sloc0_1_0 + 1),r5
L021269?:
	mov	_fillmem_PARM_3,_do_cmd_q_1_172
	mov	_fillmem_PARM_2,_do_cmd_sloc0_1_0
	mov	(_fillmem_PARM_2 + 1),(_do_cmd_sloc0_1_0 + 1)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r7
	lcall	_fillmem
;	.\cmon51.c:530: break;
	ljmp	L021256?
;	.\cmon51.c:532: case ID_display_idata:
L021008?:
;	.\cmon51.c:533: dispmem((unsigned char data *)(0x80), 0, 'I');
	clr	a
	mov	_dispmem_PARM_2,a
	mov	(_dispmem_PARM_2 + 1),a
	mov	_dispmem_PARM_3,#0x49
	mov	dptr,#0x4080
	mov	b,#0x00
	lcall	_dispmem
;	.\cmon51.c:534: break;
	ljmp	L021256?
;	.\cmon51.c:536: case ID_modify_idata:
L021009?:
;	.\cmon51.c:537: modifymem((unsigned char data *)((n&0x7f)|0x80), 'I');
	mov	a,#0x7F
	anl	a,_do_cmd_n_1_172
	mov	r2,a
	orl	ar2,#0x80
	mov	r3,#0x00
	mov	r7,#0x40
	mov	_modifymem_PARM_2,#0x49
	mov	dpl,r2
	mov	dph,r3
	mov	b,r7
	lcall	_modifymem
;	.\cmon51.c:538: break;
	ljmp	L021256?
;	.\cmon51.c:540: case ID_fill_idata:
L021010?:
;	.\cmon51.c:541: fillmem((unsigned char data *)((n&0x7f)|0x80), p>0x80?0x80:p, (unsigned char) q);
	mov	a,#0x7F
	anl	a,_do_cmd_n_1_172
	mov	r2,a
	orl	ar2,#0x80
	mov	r3,#0x00
	mov	r7,#0x40
	clr	c
	mov	a,#0x80
	subb	a,r4
	clr	a
	subb	a,r5
	jnc	L021270?
	mov	_do_cmd_sloc0_1_0,#0x80
	clr	a
	mov	(_do_cmd_sloc0_1_0 + 1),a
	sjmp	L021271?
L021270?:
	mov	_do_cmd_sloc0_1_0,r4
	mov	(_do_cmd_sloc0_1_0 + 1),r5
L021271?:
	mov	_fillmem_PARM_3,_do_cmd_q_1_172
	mov	_fillmem_PARM_2,_do_cmd_sloc0_1_0
	mov	(_fillmem_PARM_2 + 1),(_do_cmd_sloc0_1_0 + 1)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r7
	lcall	_fillmem
;	.\cmon51.c:542: break;
	ljmp	L021256?
;	.\cmon51.c:544: case ID_display_xdata:
L021011?:
;	.\cmon51.c:545: dispmem((unsigned char xdata *)i, j, 'X');
	mov	r2,_do_cmd_i_1_172
	mov	r3,(_do_cmd_i_1_172 + 1)
	mov	r7,#0x00
	mov	_dispmem_PARM_2,_do_cmd_j_1_172
	mov	(_dispmem_PARM_2 + 1),(_do_cmd_j_1_172 + 1)
	mov	_dispmem_PARM_3,#0x58
	mov	dpl,r2
	mov	dph,r3
	mov	b,r7
	lcall	_dispmem
;	.\cmon51.c:546: break;
	ljmp	L021256?
;	.\cmon51.c:548: case ID_modify_xdata:
L021012?:
;	.\cmon51.c:549: modifymem((unsigned char xdata *)n, 'X');
	mov	r2,_do_cmd_n_1_172
	mov	r3,(_do_cmd_n_1_172 + 1)
	mov	r7,#0x00
	mov	_modifymem_PARM_2,#0x58
	mov	dpl,r2
	mov	dph,r3
	mov	b,r7
	lcall	_modifymem
;	.\cmon51.c:550: break;
	ljmp	L021256?
;	.\cmon51.c:552: case ID_fill_xdata:
L021013?:
;	.\cmon51.c:553: fillmem((unsigned char xdata *)n, p, (unsigned char)q);
	mov	r2,_do_cmd_n_1_172
	mov	r3,(_do_cmd_n_1_172 + 1)
	mov	r7,#0x00
	mov	_fillmem_PARM_3,_do_cmd_q_1_172
	mov	_fillmem_PARM_2,r4
	mov	(_fillmem_PARM_2 + 1),r5
	mov	dpl,r2
	mov	dph,r3
	mov	b,r7
	lcall	_fillmem
;	.\cmon51.c:554: break;
	ljmp	L021256?
;	.\cmon51.c:556: case ID_display_code:
L021014?:
;	.\cmon51.c:557: dispmem((unsigned char code *)i, j, 'C');
	mov	r2,_do_cmd_i_1_172
	mov	r3,(_do_cmd_i_1_172 + 1)
	mov	r7,#0x80
	mov	_dispmem_PARM_2,_do_cmd_j_1_172
	mov	(_dispmem_PARM_2 + 1),(_do_cmd_j_1_172 + 1)
	mov	_dispmem_PARM_3,#0x43
	mov	dpl,r2
	mov	dph,r3
	mov	b,r7
	lcall	_dispmem
;	.\cmon51.c:558: break;
	ljmp	L021256?
;	.\cmon51.c:560: case ID_unassemble:
L021015?:
;	.\cmon51.c:561: discnt=p;
	mov	_discnt,r4
	mov	(_discnt + 1),r5
;	.\cmon51.c:562: unassemble(n);
	mov	dpl,_do_cmd_n_1_172
	mov	dph,(_do_cmd_n_1_172 + 1)
	lcall	_unassemble
;	.\cmon51.c:563: break;
	ljmp	L021256?
;	.\cmon51.c:565: case ID_trace_reg:
L021016?:
;	.\cmon51.c:566: trace_type++;
	mov	dptr,#_trace_type
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
;	.\cmon51.c:568: case ID_trace:
L021017?:
;	.\cmon51.c:569: trace_type++;
	mov	dptr,#_trace_type
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
;	.\cmon51.c:570: if(n==0) break;
	mov	a,_do_cmd_n_1_172
	orl	a,(_do_cmd_n_1_172 + 1)
	jnz	L021381?
	ljmp	L021256?
L021381?:
;	.\cmon51.c:571: break_address=n;
	mov	dptr,#_break_address
	mov	a,_do_cmd_n_1_172
	movx	@dptr,a
	inc	dptr
	mov	a,(_do_cmd_n_1_172 + 1)
	movx	@dptr,a
;	.\cmon51.c:572: n=0;
	clr	a
	mov	_do_cmd_n_1_172,a
	mov	(_do_cmd_n_1_172 + 1),a
;	.\cmon51.c:574: case ID_go_breaks:
L021020?:
;	.\cmon51.c:575: trace_type++;
	mov	dptr,#_trace_type
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
;	.\cmon51.c:576: step_start=(n==0)?PC_save:n; //Next instruction to be executed
	mov	a,_do_cmd_n_1_172
	orl	a,(_do_cmd_n_1_172 + 1)
	cjne	a,#0x01,L021382?
L021382?:
	clr	a
	rlc	a
	mov	r2,a
	jz	L021272?
	mov	dptr,#_PC_save
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	sjmp	L021273?
L021272?:
	mov	r2,_do_cmd_n_1_172
	mov	r3,(_do_cmd_n_1_172 + 1)
L021273?:
	mov	dptr,#_step_start
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	.\cmon51.c:577: gotbreak=0; //If changes to 1, the single step function worked!
	mov	dptr,#_gotbreak
;	.\cmon51.c:578: gostep=0;
	clr	a
	movx	@dptr,a
	mov	dptr,#_gostep
	movx	@dptr,a
;	.\cmon51.c:579: dostep();
	lcall	_dostep
;	.\cmon51.c:581: case ID_go:
L021021?:
;	.\cmon51.c:582: go_pending=0x55;
	mov	dptr,#_go_pending
	mov	a,#0x55
	movx	@dptr,a
;	.\cmon51.c:583: case ID_step:
L021022?:
;	.\cmon51.c:584: step_start=(n==0)?PC_save:n; //Next instruction to be executed
	mov	a,_do_cmd_n_1_172
	orl	a,(_do_cmd_n_1_172 + 1)
	cjne	a,#0x01,L021384?
L021384?:
	clr	a
	rlc	a
	mov	r2,a
	jz	L021274?
	mov	dptr,#_PC_save
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	sjmp	L021275?
L021274?:
	mov	r2,_do_cmd_n_1_172
	mov	r3,(_do_cmd_n_1_172 + 1)
L021275?:
	mov	dptr,#_step_start
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	.\cmon51.c:585: gotbreak=0; //If changes to 1, the single step function worked!
	mov	dptr,#_gotbreak
;	.\cmon51.c:586: gostep=0;
	clr	a
	movx	@dptr,a
	mov	dptr,#_gostep
	movx	@dptr,a
;	.\cmon51.c:587: dostep();
	lcall	_dostep
;	.\cmon51.c:588: break;
	ljmp	L021256?
;	.\cmon51.c:590: case ID_registers:
L021023?:
;	.\cmon51.c:591: disp_regs();
	lcall	_disp_regs
;	.\cmon51.c:592: break;
	ljmp	L021256?
;	.\cmon51.c:594: case ID_load:
L021024?:
;	.\cmon51.c:596: break;
	ljmp	L021256?
;	.\cmon51.c:598: case ID_reg_dptr:
L021025?:
;	.\cmon51.c:599: if(buff_haseq)
	jnb	_buff_haseq,L021027?
;	.\cmon51.c:601: DPL_save=c;
	mov	dptr,#_DPL_save
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
;	.\cmon51.c:602: DPH_save=highof(n);
	mov	r2,(_do_cmd_n_1_172 + 1)
	mov	r3,#0x00
	mov	dptr,#_DPH_save
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	ljmp	L021256?
L021027?:
;	.\cmon51.c:604: else outwordnl((DPH_save*0x100)+DPL_save);
	mov	dptr,#_DPH_save
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	(_do_cmd_sloc0_1_0 + 1),r2
	mov	_do_cmd_sloc0_1_0,#0x00
	mov	dptr,#_DPL_save
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r2,a
	mov	a,r7
	add	a,_do_cmd_sloc0_1_0
	mov	dpl,a
	mov	a,r2
	addc	a,(_do_cmd_sloc0_1_0 + 1)
	mov	dph,a
	lcall	_outwordnl
;	.\cmon51.c:605: break;
	ljmp	L021256?
;	.\cmon51.c:607: case ID_reg_pc:
L021029?:
;	.\cmon51.c:608: if(buff_haseq) PC_save=n;
	jnb	_buff_haseq,L021031?
	mov	dptr,#_PC_save
	mov	a,_do_cmd_n_1_172
	movx	@dptr,a
	inc	dptr
	mov	a,(_do_cmd_n_1_172 + 1)
	movx	@dptr,a
	ljmp	L021256?
L021031?:
;	.\cmon51.c:609: else outwordnl(PC_save);
	mov	dptr,#_PC_save
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dpl,r2
	mov	dph,r3
	lcall	_outwordnl
;	.\cmon51.c:610: break;
	ljmp	L021256?
;	.\cmon51.c:612: case ID_reg_r0:
L021033?:
;	.\cmon51.c:613: case ID_reg_r1:
L021034?:
;	.\cmon51.c:614: case ID_reg_r2:
L021035?:
;	.\cmon51.c:615: case ID_reg_r3:
L021036?:
;	.\cmon51.c:616: case ID_reg_r4:
L021037?:
;	.\cmon51.c:617: case ID_reg_r5:
L021038?:
;	.\cmon51.c:618: case ID_reg_r6:
L021039?:
;	.\cmon51.c:619: case ID_reg_r7:
L021040?:
;	.\cmon51.c:620: d=(PSW_save&0x18)+buff[1]-'0';
	mov	dptr,#_PSW_save
	movx	a,@dptr
	mov	r2,a
	anl	ar2,#0x18
	mov	a,(_buff + 0x0001)
	add	a,r2
	add	a,#0xd0
	mov	r2,a
;	.\cmon51.c:621: if(buff_haseq) iram_save[d]=c;
	jnb	_buff_haseq,L021042?
	mov	a,r2
	add	a,#_iram_save
	mov	dpl,a
	clr	a
	addc	a,#(_iram_save >> 8)
	mov	dph,a
	mov	a,r6
	movx	@dptr,a
	ljmp	L021256?
L021042?:
;	.\cmon51.c:622: else { outbyte (iram_save[d]); putnl(); };
	mov	a,r2
	add	a,#_iram_save
	mov	dpl,a
	clr	a
	addc	a,#(_iram_save >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	dpl,a
	lcall	_outbyte
	lcall	_putnl
;	.\cmon51.c:623: break;
	ljmp	L021256?
;	.\cmon51.c:625: case ID_brl:
L021044?:
;	.\cmon51.c:627: BPC=0x40;
	mov	_BPC,#0x40
;	.\cmon51.c:628: for(n=0; n<0x8000; n++)
	clr	a
	mov	_do_cmd_n_1_172,a
	mov	(_do_cmd_n_1_172 + 1),a
L021258?:
	mov	a,#0x100 - 0x80
	add	a,(_do_cmd_n_1_172 + 1)
	jnc	L021389?
	ljmp	L021261?
L021389?:
;	.\cmon51.c:630: BPAH=n/0x100;
	mov	r3,(_do_cmd_n_1_172 + 1)
	mov	_BPAH,r3
;	.\cmon51.c:631: BPAL=n%0x100;
	mov	r3,_do_cmd_n_1_172
	mov	r7,#0x00
	mov	_BPAL,r3
;	.\cmon51.c:634: _endasm; //We need to clock-in the value before reading it
	
	     nop
	     
;	.\cmon51.c:635: if(BPS&0x01)
	mov	a,_BPS
	jnb	acc.0,L021260?
;	.\cmon51.c:637: outwordnl(n);
	mov	dpl,_do_cmd_n_1_172
	mov	dph,(_do_cmd_n_1_172 + 1)
	lcall	_outwordnl
L021260?:
;	.\cmon51.c:628: for(n=0; n<0x8000; n++)
	inc	_do_cmd_n_1_172
	clr	a
	cjne	a,_do_cmd_n_1_172,L021391?
	inc	(_do_cmd_n_1_172 + 1)
L021391?:
	ljmp	L021258?
L021261?:
;	.\cmon51.c:640: BPC=0x00;
	mov	_BPC,#0x00
;	.\cmon51.c:642: BPAL=0;
	mov	_BPAL,#0x00
;	.\cmon51.c:643: BPAH=0;
	mov	_BPAH,#0x00
;	.\cmon51.c:644: break;
	ljmp	L021256?
;	.\cmon51.c:646: case ID_brc:
L021047?:
;	.\cmon51.c:648: BPC=0x02;
	mov	_BPC,#0x02
;	.\cmon51.c:649: for(n=0; n<0x8000; n++)
	clr	a
	mov	_do_cmd_n_1_172,a
	mov	(_do_cmd_n_1_172 + 1),a
L021262?:
	mov	a,#0x100 - 0x80
	add	a,(_do_cmd_n_1_172 + 1)
	jc	L021265?
;	.\cmon51.c:651: BPAH=n/0x100;
	mov	r3,(_do_cmd_n_1_172 + 1)
	mov	_BPAH,r3
;	.\cmon51.c:652: BPAL=n%0x100;
	mov	r3,_do_cmd_n_1_172
	mov	r7,#0x00
	mov	_BPAL,r3
;	.\cmon51.c:649: for(n=0; n<0x8000; n++)
	inc	_do_cmd_n_1_172
	clr	a
	cjne	a,_do_cmd_n_1_172,L021262?
	inc	(_do_cmd_n_1_172 + 1)
	sjmp	L021262?
L021265?:
;	.\cmon51.c:654: BPAL=0xff;
	mov	_BPAL,#0xFF
;	.\cmon51.c:655: BPC=0x00;
	mov	_BPC,#0x00
;	.\cmon51.c:657: BPAL=0;
	mov	_BPAL,#0x00
;	.\cmon51.c:658: BPAH=0;
	mov	_BPAH,#0x00
;	.\cmon51.c:659: break;
	ljmp	L021256?
;	.\cmon51.c:661: case ID_br2:
L021048?:
;	.\cmon51.c:662: case ID_br3:
L021049?:
;	.\cmon51.c:663: d=buff[2]-'0';
	mov	a,(_buff + 0x0002)
	add	a,#0xd0
	mov	r2,a
;	.\cmon51.c:664: if(buff_haseq) br[d]=n;
	jnb	_buff_haseq,L021051?
	mov	a,r2
	add	a,r2
	mov	r3,a
	add	a,#_br
	mov	dpl,a
	clr	a
	addc	a,#(_br >> 8)
	mov	dph,a
	mov	a,_do_cmd_n_1_172
	movx	@dptr,a
	inc	dptr
	mov	a,(_do_cmd_n_1_172 + 1)
	movx	@dptr,a
	ljmp	L021256?
L021051?:
;	.\cmon51.c:665: else outwordnl(br[d]);
	mov	a,r2
	add	a,r2
	add	a,#_br
	mov	dpl,a
	clr	a
	addc	a,#(_br >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	mov	dpl,r3
	mov	dph,r7
	lcall	_outwordnl
;	.\cmon51.c:666: break;
	ljmp	L021256?
;	.\cmon51.c:668: case ID_broff:
L021053?:
;	.\cmon51.c:670: BPAL=n%0x100;
	mov	r3,_do_cmd_n_1_172
	mov	_BPAL,r3
;	.\cmon51.c:671: BPAH=n/0x100;
	mov	r3,(_do_cmd_n_1_172 + 1)
	mov	r7,#0x00
	mov	_BPAH,r3
;	.\cmon51.c:673: BPC=0x00;
	mov	_BPC,#0x00
;	.\cmon51.c:674: BPC=0x02;
	mov	_BPC,#0x02
;	.\cmon51.c:675: BPC=0x00;
	mov	_BPC,#0x00
;	.\cmon51.c:677: BPAL=0;
	mov	_BPAL,#0x00
;	.\cmon51.c:678: BPAH=0;
	mov	_BPAH,#0x00
;	.\cmon51.c:679: break;
	ljmp	L021256?
;	.\cmon51.c:681: case ID_bron:
L021054?:
;	.\cmon51.c:683: BPAL=n%0x100;
	mov	r3,_do_cmd_n_1_172
	mov	_BPAL,r3
;	.\cmon51.c:684: BPAH=n/0x100;
	mov	r3,(_do_cmd_n_1_172 + 1)
	mov	r7,#0x00
	mov	_BPAH,r3
;	.\cmon51.c:686: BPC=0x01;
	mov	_BPC,#0x01
;	.\cmon51.c:687: BPC=0x03;
	mov	_BPC,#0x03
;	.\cmon51.c:688: BPC=0x01;
	mov	_BPC,#0x01
;	.\cmon51.c:690: BPAL=0;
	mov	_BPAL,#0x00
;	.\cmon51.c:691: BPAH=0;
	mov	_BPAH,#0x00
;	.\cmon51.c:692: break;
	ljmp	L021256?
;	.\cmon51.c:694: case ID_pcr:  //Restore the PC
L021055?:
;	.\cmon51.c:695: restorePC();
	lcall	_restorePC
;	.\cmon51.c:696: break;
	ljmp	L021256?
;	.\cmon51.c:698: case ID_LEDRA:
L021056?:
;	.\cmon51.c:699: case ID_LEDG:
L021057?:
;	.\cmon51.c:700: if(buff_haseq)
	jb	_buff_haseq,L021395?
	ljmp	L021114?
L021395?:
;	.\cmon51.c:702: if(buff_hasdot)
	jb	_buff_hasdot,L021396?
	ljmp	L021111?
L021396?:
;	.\cmon51.c:704: if(cmd==ID_LEDG)
	mov	a,#0x23
	cjne	a,_do_cmd_cmd_1_172,L021105?
;	.\cmon51.c:706: if     (c==0) LEDG_0=p_bit;
	mov	a,r6
	jnz	L021079?
	mov	c,_do_cmd_p_bit_1_172
	mov	_LEDG_0,c
	ljmp	L021256?
L021079?:
;	.\cmon51.c:707: else if(c==1) LEDG_1=p_bit;
	cjne	r6,#0x01,L021076?
	mov	c,_do_cmd_p_bit_1_172
	mov	_LEDG_1,c
	ljmp	L021256?
L021076?:
;	.\cmon51.c:708: else if(c==2) LEDG_2=p_bit;
	cjne	r6,#0x02,L021073?
	mov	c,_do_cmd_p_bit_1_172
	mov	_LEDG_2,c
	ljmp	L021256?
L021073?:
;	.\cmon51.c:709: else if(c==3) LEDG_3=p_bit;
	cjne	r6,#0x03,L021070?
	mov	c,_do_cmd_p_bit_1_172
	mov	_LEDG_3,c
	ljmp	L021256?
L021070?:
;	.\cmon51.c:710: else if(c==4) LEDG_4=p_bit;
	cjne	r6,#0x04,L021067?
	mov	c,_do_cmd_p_bit_1_172
	mov	_LEDG_4,c
	ljmp	L021256?
L021067?:
;	.\cmon51.c:711: else if(c==5) LEDG_5=p_bit;
	cjne	r6,#0x05,L021064?
	mov	c,_do_cmd_p_bit_1_172
	mov	_LEDG_5,c
	ljmp	L021256?
L021064?:
;	.\cmon51.c:712: else if(c==6) LEDG_6=p_bit;
	cjne	r6,#0x06,L021061?
	mov	c,_do_cmd_p_bit_1_172
	mov	_LEDG_6,c
	ljmp	L021256?
L021061?:
;	.\cmon51.c:713: else if(c==7) LEDG_7=p_bit;
	cjne	r6,#0x07,L021412?
	sjmp	L021413?
L021412?:
	ljmp	L021256?
L021413?:
	mov	c,_do_cmd_p_bit_1_172
	mov	_LEDG_7,c
	ljmp	L021256?
L021105?:
;	.\cmon51.c:717: if     (c==0) LEDRA_0=p_bit;
	mov	a,r6
	jnz	L021102?
	mov	c,_do_cmd_p_bit_1_172
	mov	_LEDRA_0,c
	ljmp	L021256?
L021102?:
;	.\cmon51.c:718: else if(c==1) LEDRA_1=p_bit;
	cjne	r6,#0x01,L021099?
	mov	c,_do_cmd_p_bit_1_172
	mov	_LEDRA_1,c
	ljmp	L021256?
L021099?:
;	.\cmon51.c:719: else if(c==2) LEDRA_2=p_bit;
	cjne	r6,#0x02,L021096?
	mov	c,_do_cmd_p_bit_1_172
	mov	_LEDRA_2,c
	ljmp	L021256?
L021096?:
;	.\cmon51.c:720: else if(c==3) LEDRA_3=p_bit;
	cjne	r6,#0x03,L021093?
	mov	c,_do_cmd_p_bit_1_172
	mov	_LEDRA_3,c
	ljmp	L021256?
L021093?:
;	.\cmon51.c:721: else if(c==4) LEDRA_4=p_bit;
	cjne	r6,#0x04,L021090?
	mov	c,_do_cmd_p_bit_1_172
	mov	_LEDRA_4,c
	ljmp	L021256?
L021090?:
;	.\cmon51.c:722: else if(c==5) LEDRA_5=p_bit;
	cjne	r6,#0x05,L021087?
	mov	c,_do_cmd_p_bit_1_172
	mov	_LEDRA_5,c
	ljmp	L021256?
L021087?:
;	.\cmon51.c:723: else if(c==6) LEDRA_6=p_bit;
	cjne	r6,#0x06,L021084?
	mov	c,_do_cmd_p_bit_1_172
	mov	_LEDRA_6,c
	ljmp	L021256?
L021084?:
;	.\cmon51.c:724: else if(c==7) LEDRA_7=p_bit;
	cjne	r6,#0x07,L021427?
	sjmp	L021428?
L021427?:
	ljmp	L021256?
L021428?:
	mov	c,_do_cmd_p_bit_1_172
	mov	_LEDRA_7,c
	ljmp	L021256?
L021111?:
;	.\cmon51.c:729: if(cmd==ID_LEDG) LEDG=c;
	mov	a,#0x23
	cjne	a,_do_cmd_cmd_1_172,L021108?
	mov	_LEDG,r6
	ljmp	L021256?
L021108?:
;	.\cmon51.c:730: else LEDRA=c;
	mov	_LEDRA,r6
	ljmp	L021256?
L021114?:
;	.\cmon51.c:733: else putsp(cnr);
	mov	dptr,#_cnr
	mov	b,#0x80
	lcall	_putsp
;	.\cmon51.c:734: break;
	ljmp	L021256?
;	.\cmon51.c:736: case ID_LEDRB:
L021116?:
;	.\cmon51.c:737: case ID_LEDRC:
L021117?:
;	.\cmon51.c:738: if(buff_haseq)
	jnb	_buff_haseq,L021125?
;	.\cmon51.c:740: if(buff_hasdot)
	jnb	_buff_hasdot,L021122?
;	.\cmon51.c:742: putsp(nba);
	mov	dptr,#_nba
	mov	b,#0x80
	lcall	_putsp
	ljmp	L021256?
L021122?:
;	.\cmon51.c:746: if(cmd==ID_LEDRB) LEDRB=c;
	mov	a,#0x25
	cjne	a,_do_cmd_cmd_1_172,L021119?
	mov	_LEDRB,r6
	ljmp	L021256?
L021119?:
;	.\cmon51.c:747: else LEDRC=c;
	mov	_LEDRC,r6
	ljmp	L021256?
L021125?:
;	.\cmon51.c:750: else putsp(cnr);
	mov	dptr,#_cnr
	mov	b,#0x80
	lcall	_putsp
;	.\cmon51.c:751: break;
	ljmp	L021256?
;	.\cmon51.c:753: case ID_KEY:
L021127?:
;	.\cmon51.c:754: case ID_SWA:
L021128?:
;	.\cmon51.c:755: if(buff_haseq==0)
	jnb	_buff_haseq,L021435?
	ljmp	L021170?
L021435?:
;	.\cmon51.c:757: if(buff_hasdot)
	jnb	_buff_hasdot,L021167?
;	.\cmon51.c:759: if(cmd==ID_SWA)
	mov	a,#0x28
	cjne	a,_do_cmd_cmd_1_172,L021161?
;	.\cmon51.c:761: if     (c==0) p_bit=SWA_0;
	mov	a,r6
	jnz	L021150?
	mov	c,_SWA_0
	mov	_do_cmd_p_bit_1_172,c
	sjmp	L021163?
L021150?:
;	.\cmon51.c:762: else if(c==1) p_bit=SWA_1;
	cjne	r6,#0x01,L021147?
	mov	c,_SWA_1
	mov	_do_cmd_p_bit_1_172,c
	sjmp	L021163?
L021147?:
;	.\cmon51.c:763: else if(c==2) p_bit=SWA_2;
	cjne	r6,#0x02,L021144?
	mov	c,_SWA_2
	mov	_do_cmd_p_bit_1_172,c
	sjmp	L021163?
L021144?:
;	.\cmon51.c:764: else if(c==3) p_bit=SWA_3;
	cjne	r6,#0x03,L021141?
	mov	c,_SWA_3
	mov	_do_cmd_p_bit_1_172,c
	sjmp	L021163?
L021141?:
;	.\cmon51.c:765: else if(c==4) p_bit=SWA_4;
	cjne	r6,#0x04,L021138?
	mov	c,_SWA_4
	mov	_do_cmd_p_bit_1_172,c
	sjmp	L021163?
L021138?:
;	.\cmon51.c:766: else if(c==5) p_bit=SWA_5;
	cjne	r6,#0x05,L021135?
	mov	c,_SWA_5
	mov	_do_cmd_p_bit_1_172,c
	sjmp	L021163?
L021135?:
;	.\cmon51.c:767: else if(c==6) p_bit=SWA_6;
	cjne	r6,#0x06,L021132?
	mov	c,_SWA_6
	mov	_do_cmd_p_bit_1_172,c
	sjmp	L021163?
L021132?:
;	.\cmon51.c:768: else if(c==7) p_bit=SWA_7;
	cjne	r6,#0x07,L021163?
	mov	c,_SWA_7
	mov	_do_cmd_p_bit_1_172,c
	sjmp	L021163?
L021161?:
;	.\cmon51.c:772: if     (c==1) p_bit=KEY_1;
	cjne	r6,#0x01,L021158?
	mov	c,_KEY_1
	mov	_do_cmd_p_bit_1_172,c
	sjmp	L021163?
L021158?:
;	.\cmon51.c:773: else if(c==2) p_bit=KEY_2;
	cjne	r6,#0x02,L021155?
	mov	c,_KEY_2
	mov	_do_cmd_p_bit_1_172,c
	sjmp	L021163?
L021155?:
;	.\cmon51.c:774: else if(c==3) p_bit=KEY_3;
	cjne	r6,#0x03,L021163?
	mov	c,_KEY_3
	mov	_do_cmd_p_bit_1_172,c
;	.\cmon51.c:776: putc(p_bit?'1':'0');
L021163?:
	jb	_JTXFULL,L021163?
	jnb	_do_cmd_p_bit_1_172,L021276?
	mov	r3,#0x31
	sjmp	L021277?
L021276?:
	mov	r3,#0x30
L021277?:
	mov	_JBUF,r3
	sjmp	L021168?
L021167?:
;	.\cmon51.c:780: outbyte(cmd==ID_SWA?SWA:KEY);
	mov	a,#0x28
	cjne	a,_do_cmd_cmd_1_172,L021278?
	mov	r3,_SWA
	sjmp	L021279?
L021278?:
	mov	r3,_KEY
L021279?:
	mov	dpl,r3
	lcall	_outbyte
L021168?:
;	.\cmon51.c:782: putnl();
	lcall	_putnl
	ljmp	L021256?
L021170?:
;	.\cmon51.c:784: else putsp(cnw);
	mov	dptr,#_cnw
	mov	b,#0x80
	lcall	_putsp
;	.\cmon51.c:785: break;
	ljmp	L021256?
;	.\cmon51.c:787: case ID_SWB:
L021172?:
;	.\cmon51.c:788: case ID_SWC:
L021173?:
;	.\cmon51.c:789: if(buff_haseq==0)
	jb	_buff_haseq,L021178?
;	.\cmon51.c:791: if(buff_hasdot)
	jnb	_buff_hasdot,L021175?
;	.\cmon51.c:793: putsp(nba);
	mov	dptr,#_nba
	mov	b,#0x80
	lcall	_putsp
;	.\cmon51.c:794: break;
	ljmp	L021256?
L021175?:
;	.\cmon51.c:798: outbyte(cmd==ID_SWB?SWB:SWC);
	mov	a,#0x29
	cjne	a,_do_cmd_cmd_1_172,L021280?
	mov	r3,_SWB
	sjmp	L021281?
L021280?:
	mov	r3,_SWC
L021281?:
	mov	dpl,r3
	lcall	_outbyte
;	.\cmon51.c:799: putnl();
	lcall	_putnl
	ljmp	L021256?
L021178?:
;	.\cmon51.c:802: else putsp(cnw);
	mov	dptr,#_cnw
	mov	b,#0x80
	lcall	_putsp
;	.\cmon51.c:803: break;
	ljmp	L021256?
;	.\cmon51.c:805: case ID_BANK:
L021180?:
;	.\cmon51.c:806: if(buff_haseq)
	jnb	_buff_haseq,L021187?
;	.\cmon51.c:808: PSW_save&=0b_1110_0111;
	mov	dptr,#_PSW_save
	movx	a,@dptr
	mov	r3,a
	anl	a,#0xE7
	movx	@dptr,a
;	.\cmon51.c:809: switch(c&3)
	mov	a,#0x03
	anl	a,r6
	mov  r3,a
	add	a,#0xff - 0x03
	jnc	L021469?
	ljmp	L021256?
L021469?:
	mov	a,r3
	add	a,r3
	add	a,r3
	mov	dptr,#L021470?
	jmp	@a+dptr
L021470?:
	ljmp	L021181?
	ljmp	L021182?
	ljmp	L021183?
	ljmp	L021184?
;	.\cmon51.c:811: case 0:
L021181?:
;	.\cmon51.c:812: break;
	ljmp	L021256?
;	.\cmon51.c:813: case 1:
L021182?:
;	.\cmon51.c:814: PSW_save|=0b_0000_1000;
	mov	dptr,#_PSW_save
	movx	a,@dptr
	mov	r3,a
	orl	a,#0x08
	movx	@dptr,a
;	.\cmon51.c:815: break;
	ljmp	L021256?
;	.\cmon51.c:816: case 2:
L021183?:
;	.\cmon51.c:817: PSW_save|=0b_0001_0000;
	mov	dptr,#_PSW_save
	movx	a,@dptr
	mov	r3,a
	orl	a,#0x10
	movx	@dptr,a
;	.\cmon51.c:818: break;
	ljmp	L021256?
;	.\cmon51.c:819: case 3:
L021184?:
;	.\cmon51.c:820: PSW_save|=0b_0001_1000;
	mov	dptr,#_PSW_save
	movx	a,@dptr
	mov	r3,a
	orl	a,#0x18
	movx	@dptr,a
;	.\cmon51.c:822: }
	ljmp	L021256?
L021187?:
;	.\cmon51.c:826: outbyte((PSW_save/0x8)&0x3);
	mov	dptr,#_PSW_save
	movx	a,@dptr
	swap	a
	rl	a
	anl	a,#0x1f
	mov	r3,a
	mov	a,#0x03
	anl	a,r3
	mov	dpl,a
	lcall	_outbyte
;	.\cmon51.c:827: putnl();
	lcall	_putnl
;	.\cmon51.c:829: break;
	ljmp	L021256?
;	.\cmon51.c:831: default:
L021189?:
;	.\cmon51.c:833: y=nlist(bitn); //Search for bit names first
	mov	dptr,#_bitn
	mov	b,#0x80
	push	ar4
	push	ar5
	push	ar6
	lcall	_nlist
	mov	_do_cmd_y_1_172,dpl
	pop	ar6
	pop	ar5
	pop	ar4
;	.\cmon51.c:834: if (y!=0xff)
	mov	a,#0xFF
	cjne	a,_do_cmd_y_1_172,L021471?
	sjmp	L021193?
L021471?:
;	.\cmon51.c:836: x=y&0xf8;
	mov	a,#0xF8
	anl	a,_do_cmd_y_1_172
	mov	r7,a
;	.\cmon51.c:837: y=maskbit[y&0x7];
	mov	a,#0x07
	anl	a,_do_cmd_y_1_172
	mov	dptr,#_maskbit
	movc	a,@a+dptr
	mov	_do_cmd_y_1_172,a
	sjmp	L021194?
L021193?:
;	.\cmon51.c:841: x=nlist(sfrn); //Is not a bit, try a sfr
	mov	dptr,#_sfrn
	mov	b,#0x80
	push	ar4
	push	ar5
	push	ar6
	lcall	_nlist
	mov	r7,dpl
	pop	ar6
	pop	ar5
	pop	ar4
;	.\cmon51.c:842: if(buff_hasdot)
	jnb	_buff_hasdot,L021194?
;	.\cmon51.c:844: y=maskbit[c&0x7];
	mov	a,#0x07
	anl	a,r6
	mov	dptr,#_maskbit
	movc	a,@a+dptr
	mov	_do_cmd_y_1_172,a
;	.\cmon51.c:845: c=p;
	mov	ar6,r4
L021194?:
;	.\cmon51.c:849: if(x!=0xff)
	cjne	r7,#0xFF,L021473?
	ljmp	L021252?
L021473?:
;	.\cmon51.c:852: /**/ if (x==0xd0) d=PSW_save;
	clr	a
	cjne	r7,#0xD0,L021474?
	inc	a
L021474?:
	mov	r4,a
	jz	L021214?
	mov	dptr,#_PSW_save
	movx	a,@dptr
	mov	r2,a
	sjmp	L021215?
L021214?:
;	.\cmon51.c:853: else if (x==0xe0) d=A_save;
	cjne	r7,#0xE0,L021211?
	mov	dptr,#_A_save
	movx	a,@dptr
	mov	r2,a
	sjmp	L021215?
L021211?:
;	.\cmon51.c:854: else if (x==0xf0) d=B_save;
	cjne	r7,#0xF0,L021208?
	mov	dptr,#_B_save
	movx	a,@dptr
	mov	r2,a
	sjmp	L021215?
L021208?:
;	.\cmon51.c:855: else if (x==0xa8) d=IE_save;
	cjne	r7,#0xA8,L021205?
	mov	dptr,#_IE_save
	movx	a,@dptr
	mov	r2,a
	sjmp	L021215?
L021205?:
;	.\cmon51.c:856: else if (x==0x81) d=SP_save;
	cjne	r7,#0x81,L021202?
	mov	dptr,#_SP_save
	movx	a,@dptr
	mov	r2,a
	sjmp	L021215?
L021202?:
;	.\cmon51.c:857: else if (x==0x82) d=DPL_save;
	cjne	r7,#0x82,L021199?
	mov	dptr,#_DPL_save
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	ar2,r5
	sjmp	L021215?
L021199?:
;	.\cmon51.c:858: else if (x==0x83) d=DPH_save;
	cjne	r7,#0x83,L021196?
	mov	dptr,#_DPH_save
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	mov	ar2,r3
	sjmp	L021215?
L021196?:
;	.\cmon51.c:859: else d=read_sfr(x);
	mov	dpl,r7
	push	ar4
	push	ar6
	push	ar7
	lcall	_read_sfr
	mov	r2,dpl
	pop	ar7
	pop	ar6
	pop	ar4
L021215?:
;	.\cmon51.c:862: if(y!=0xff)
	mov	a,#0xFF
	cjne	a,_do_cmd_y_1_172,L021489?
	mov	a,#0x01
	sjmp	L021490?
L021489?:
	clr	a
L021490?:
	mov	r3,a
	jnz	L021220?
;	.\cmon51.c:864: if(c) c=d|y;
	mov	a,r6
	jz	L021217?
	mov	a,_do_cmd_y_1_172
	orl	a,r2
	mov	r6,a
	sjmp	L021220?
L021217?:
;	.\cmon51.c:865: else c=d&(~y);
	mov	a,_do_cmd_y_1_172
	cpl	a
	mov	r5,a
	anl	a,r2
	mov	r6,a
L021220?:
;	.\cmon51.c:869: if(buff_haseq)
	jnb	_buff_haseq,L021249?
;	.\cmon51.c:871: /**/ if (x==0xd0) PSW_save=c;
	mov	a,r4
	jz	L021240?
	mov	dptr,#_PSW_save
	mov	a,r6
	movx	@dptr,a
	ljmp	L021256?
L021240?:
;	.\cmon51.c:872: else if (x==0xe0) A_save=c;
	cjne	r7,#0xE0,L021237?
	mov	dptr,#_A_save
	mov	a,r6
	movx	@dptr,a
	ljmp	L021256?
L021237?:
;	.\cmon51.c:873: else if (x==0xf0) B_save=c;
	cjne	r7,#0xF0,L021234?
	mov	dptr,#_B_save
	mov	a,r6
	movx	@dptr,a
	ljmp	L021256?
L021234?:
;	.\cmon51.c:874: else if (x==0xa8) IE_save=c;
	cjne	r7,#0xA8,L021231?
	mov	dptr,#_IE_save
	mov	a,r6
	movx	@dptr,a
	ljmp	L021256?
L021231?:
;	.\cmon51.c:875: else if (x==0x81) SP_save=c;
	cjne	r7,#0x81,L021228?
	mov	dptr,#_SP_save
	mov	a,r6
	movx	@dptr,a
	ljmp	L021256?
L021228?:
;	.\cmon51.c:876: else if (x==0x82) DPL_save=c;
	cjne	r7,#0x82,L021225?
	mov	dptr,#_DPL_save
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
	ljmp	L021256?
L021225?:
;	.\cmon51.c:877: else if (x==0x83) DPH_save=c;
	cjne	r7,#0x83,L021222?
	mov	dptr,#_DPH_save
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
	ljmp	L021256?
L021222?:
;	.\cmon51.c:878: else write_sfr(x, c);
	mov	_write_sfr_PARM_2,r6
	mov	dpl,r7
	lcall	_write_sfr
	ljmp	L021256?
L021249?:
;	.\cmon51.c:882: if(y==0xff)
	mov	a,r3
	jz	L021242?
;	.\cmon51.c:883: outbyte(d);
	mov	dpl,r2
	lcall	_outbyte
;	.\cmon51.c:885: putc((d&y)?'1':'0');
	sjmp	L021247?
L021242?:
	jb	_JTXFULL,L021242?
	mov	a,_do_cmd_y_1_172
	anl	a,r2
	jz	L021282?
	mov	r2,#0x31
	sjmp	L021283?
L021282?:
	mov	r2,#0x30
L021283?:
	mov	_JBUF,r2
L021247?:
;	.\cmon51.c:886: putnl();
	lcall	_putnl
	ljmp	L021256?
L021252?:
;	.\cmon51.c:889: else putsp("What?\n");
	mov	dptr,#__str_15
	mov	b,#0x80
	lcall	_putsp
;	.\cmon51.c:891: }
	ljmp	L021256?
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
_cmdlst:
	db 0x80
	db 'D'
	db 0x81
	db 'MD'
	db 0x82
	db 'FD'
	db 0x83
	db 'I'
	db 0x84
	db 'MI'
	db 0x85
	db 'FI'
	db 0x86
	db 'X'
	db 0x87
	db 'MX'
	db 0x88
	db 'FX'
	db 0x89
	db 'C'
	db 0x8A
	db 'U'
	db 0x8B
	db 'G'
	db 0x8C
	db 'S'
	db 0x8D
	db 'R'
	db 0x8E
	db 'L'
	db 0x8F
	db 'DPTR'
	db 0x90
	db 'PC'
	db 0x91
	db 'T'
	db 0x92
	db 'R0'
	db 0x93
	db 'R1'
	db 0x94
	db 'R2'
	db 0x95
	db 'R3'
	db 0x96
	db 'R'
	db '4'
	db 0x97
	db 'R5'
	db 0x98
	db 'R6'
	db 0x99
	db 'R7'
	db 0x9A
	db 'TR'
	db 0x9B
	db 'GB'
	db 0x9C
	db 'BRL'
	db 0x9D
	db 'BRC'
	db 0x9E
	db 'BR2'
	db 0x9F
	db 'BR3'
	db 0xA0
	db 'BROFF'
	db 0xA1
	db 'BRON'
	db 0xA2
	db 'PCR'
	db 0xA3
	db 'LEDG'
	db 0xA4
	db 'LEDRA'
	db 0xA5
	db 'L'
	db 'EDRB'
	db 0xA6
	db 'LEDRC'
	db 0xA7
	db 'KEY'
	db 0xA8
	db 'SWA'
	db 0xA9
	db 'SWB'
	db 0xAA
	db 'SWC'
	db 0xAB
	db 'BANK'
	db 0xAC
	db 0xAD
	db 0x00
	db 0x00
_hexval:
	db '0123456789ABCDEF'
	db 0x00
_maskbit:
	db 0x01	; 1 
	db 0x02	; 2 
	db 0x04	; 4 
	db 0x08	; 8 
	db 0x10	; 16 
	db 0x20	; 32 
	db 0x40	; 64 
	db 0x80	; 128 	€
_nba:
	db 'Not bit-addressable!'
	db 0x0A
	db 0x00
_cnr:
	db 'Can'
	db 0x27
	db 't read!'
	db 0x0A
	db 0x00
_cnw:
	db 'Can'
	db 0x27
	db 't write!'
	db 0x0A
	db 0x00
__str_0:
	db 0x08
	db ' '
	db 0x08
	db 0x00
__str_1:
	db '> '
	db 0x00
__str_2:
	db '<Space>=line <Enter>=page <ESC>=stop'
	db 0x0D
	db 0x00
__str_3:
	db ':  '
	db 0x00
__str_4:
	db '   '
	db 0x00
__str_5:
	db 'A '
	db 0x00
__str_6:
	db 'B '
	db 0x00
__str_7:
	db 'SP'
	db 0x00
__str_8:
	db 'IE'
	db 0x00
__str_9:
	db 'DPH'
	db 0x00
__str_10:
	db 'DPL'
	db 0x00
__str_11:
	db 'PSW'
	db 0x00
__str_12:
	db 'PC='
	db 0x00
__str_13:
	db 'BANK '
	db 0x00
__str_14:
	db 0x0A
	db 0x0A
	db 'CMON51 V2.0'
	db 0x0A
	db 'CopyRight (c) 2005-2013 Jesus Calvino-Fraga'
	db 0x0A
	db 0x00
__str_15:
	db 'What?'
	db 0x0A
	db 0x00

	CSEG

end
