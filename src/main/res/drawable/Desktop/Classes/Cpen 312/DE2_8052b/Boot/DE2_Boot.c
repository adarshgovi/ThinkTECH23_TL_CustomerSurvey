/*  DEx-8052 bootloader

	Copyright (C) 2009-2013  Jesus Calvino-Fraga, jesusc (at) ece.ubc.ca
	   
	This program is free software; you can redistribute it and/or modify it
	under the terms of the GNU General Public License as published by the
	Free Software Foundation; either version 2, or (at your option) any
	later version.
	
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*/

//  ~C51~  --code-loc 0xf000

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <DE2_8052.h>

#define EQ(A,B) !strcmp((A),(B))

#define FLASHSECTOR 0x01 // Use Flash sector SA8 which is 64k.  Note: sectors 0 to 7 are 8k only!

code unsigned char counter_prog[] = { 
	0x02, 0x00, 0x10, 0x7A, 0x3B, 0x79, 0xFA, 0x78, 0xFA, 0xD8, 0xFE, 0xD9, 0xFA, 0xDA, 0xF6, 0x22,
	0x75, 0x81, 0x7F, 0x7B, 0x00, 0x7C, 0x00, 0xEC, 0x54, 0x0F, 0x90, 0x00, 0x4C, 0x93, 0xF5, 0x91,
	0xEC, 0xC4, 0x54, 0x0F, 0x90, 0x00, 0x4C, 0x93, 0xF5, 0x92, 0xEB, 0x54, 0x0F, 0x90, 0x00, 0x4C,
	0x93, 0xF5, 0x93, 0xEB, 0xC4, 0x54, 0x0F, 0x90, 0x00, 0x4C, 0x93, 0xF5, 0x94, 0x12, 0x00, 0x03,
	0xEC, 0x24, 0x01, 0xD4, 0xFC, 0xEB, 0x34, 0x00, 0xD4, 0xFB, 0x80, 0xCB, 0xC0, 0xF9, 0xA4, 0xB0,
	0x99, 0x92, 0x82, 0xF8, 0x80, 0x90, 0x88, 0x83, 0xC6, 0xA1, 0x86, 0x8E, 0x00, 0x00, 0x00, 0x00 };

code unsigned char hexval[] = "0123456789ABCDEF";

#define CLK 33333333L
#define BAUD 115200L
#define TIMER_2_RELOAD (0x10000L-(CLK/(32L*BAUD)))
#define LOW(X)  (X%0x100)
#define HIGH(X) (X/0x100)

#define MAXBUFF 64
idata unsigned char buff[MAXBUFF];
bit serialmode=0; //1: JTAG, 0:uart
bit testbit, getchar_echo=0;

void inituart (void)
{
	RCAP2H=HIGH(TIMER_2_RELOAD);
	RCAP2L=LOW(TIMER_2_RELOAD);
	T2CON=0x34; // #00110100B
	SCON=0x52; // Serial port in mode 1, ren, txrdy, rxempty
}

void putchar (char c)
{
	if(serialmode==0)
	{
		if (c=='\n')
		{
			while (!TI);
			TI=0;
			SBUF='\r';
		}
		while (!TI);
		TI=0;
		SBUF=c;
	}
	else
	{
		JBUF=c; // Load transmit FIFO with value
	}
}

char getchar (void)
{
	char c;
	
	testbit=0;
	if(serialmode==0)
	{
		while (!RI);
		RI=0;
		c=SBUF;
		if (getchar_echo==1) putchar(c);
	}
	else
	{
		while(!JRXRDY); // Wait for data to arrive
		
		c=JBUF; // Read receive FIFO
		
		if(SWB & 0x02) testbit=1;// {while (!TI); TI=0; SBUF=c;} // For debug purposes
	}
	return c;
}

char getchare (void)
{
	char c;
	
	c=getchar();
	putchar(c);
	return c;
}

void sends (unsigned char * c)
{
	unsigned char n;
	while(n=*c)
	{
		putchar(n);
		c++;
	}
}

unsigned char chartohex(char c)
{
	if(c & 0x40) c+=9; //  a to f or A to F
	return (c & 0xf);
}

// Get a byte from the serial port without echo
unsigned char getbyte (void)
{
	volatile unsigned char j; // volatile variable eliminates some push/pop instrutions

	j=chartohex(getchare())*0x10;
	j|=chartohex(getchare());

	return j;
}

void Out_Byte_Flash (unsigned int address, unsigned char val)
{
	FLASH_MOD=0xff; // Set data port for output
	FLASH_ADD0=address%0x100;
	FLASH_ADD1=address/0x100;
	FLASH_ADD2=FLASHSECTOR;
	FLASH_DATA=val;
//	bit 0: FL_RST_N  Set to 1 for normal operation
//	bit 1: FL_WE_N
//	bit 2: FL_OE_N
//	bit 3: FL_CE_N
	FLASH_CMD=0b_0000_0111; // FL_CE_N=0, FL_WE_N=1
	FLASH_CMD=0b_0000_0101; // FL_CE_N=0, FL_WE_N=0
	FLASH_CMD=0b_0000_0111; // FL_CE_N=0, FL_WE_N=1
	FLASH_CMD=0b_0000_1111; // FL_CE_N=1, FL_WE_N=1
}

unsigned char In_Byte_Flash (unsigned int address)
{
	unsigned char j;
	
	FLASH_MOD=0x00; // Set data port for input
	FLASH_ADD0=address%0x100;
	FLASH_ADD1=address/0x100;
	FLASH_ADD2=FLASHSECTOR;
	FLASH_CMD=0b_0000_0111; // FL_CE_N=0, FL_OE_N=1
	FLASH_CMD=0b_0000_0011; // FL_CE_N=0, FL_OE_N=0
	j=FLASH_DATA;
	FLASH_CMD=0b_0000_0111; // FL_CE_N=0, FL_OE_N=1
	FLASH_CMD=0b_0000_1111; // FL_CE_N=1, FL_OE_N=1
	return j;
}

void EraseSector (void)
{
	Out_Byte_Flash(0x0AAA, 0xAA);
	Out_Byte_Flash(0x0555, 0x55);
	Out_Byte_Flash(0x0AAA, 0x80);
	Out_Byte_Flash(0x0AAA, 0xAA);
	Out_Byte_Flash(0x0555, 0x55);
	Out_Byte_Flash(0x0000, 0x30);
	//Check using DQ7 Data# Polling to find out when the erasing is done
	while(In_Byte_Flash(0)!=0xff);
}

void Write_XRAM (unsigned int Address, unsigned char Value)
{
	*((unsigned char xdata *) Address)=Value;
}

unsigned char Read_XRAM (unsigned int Address)
{
	return *((unsigned char xdata *) Address);
}

void FlashByte (unsigned int Address, unsigned char Value)
{
	Out_Byte_Flash(0x0AAA, 0xAA);
	Out_Byte_Flash(0x0555, 0x55);
	Out_Byte_Flash(0x0AAA, 0xA0);
	Out_Byte_Flash(Address, Value);
	//Check using DQ7 Data# Polling to find out when the operation is done
	while(In_Byte_Flash(Address)!=Value);
}

void Load_Ram_Fast (void)
{
	XRAMUSEDAS=0x01; // 32k RAM accessed as xdata
	FLASH_ADD2=FLASHSECTOR;
	FLASH_MOD=0x00; // Set data port for input
	_asm
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
		; RAM is loaded with user code.  Run it.
		mov sp, #7
		ljmp 0x0000
	_endasm;
}

void loadintelhex (void)
{
	volatile unsigned int address;
	volatile unsigned char j, size, type, checksum, n;
	volatile char echo;
	unsigned char savedcs;

	while(1)
	{
		n=getchare();

		if(n==(unsigned char)':')
		{
			echo='.'; // If everything works ok, send a period...
			size=getbyte();
			checksum=size;
			
			address=getbyte();
			checksum+=address;
			address*=0x100;
			n=getbyte();
			checksum+=n;
			address+=n;
			
			type=getbyte();
			checksum+=type;

			for(j=0; j<size; j++)
			{
				n=getbyte();
				if(j<MAXBUFF) buff[j]=n; // Don't overrun the buffer
				checksum+=n;
			}
			
			savedcs=getbyte();
			checksum+=savedcs;
			if(size>MAXBUFF) checksum=1; // Force a checksum error
	
			if(checksum==0) switch(type)
			{
				case 4: // Erase command.
					EraseSector();
					LEDG_1=1; // Flash erased
				break;

				case 0: // Write to flash command.
					for(j=0; j<size; j++)
					{
						FlashByte(address, buff[j]);
						if (In_Byte_Flash(address)!=buff[j]) // Verify last write.
						{
							echo='!';
							LEDRA_0=1;
						}
						address++;
					}
				break;
				
				case 3: // Send ID number command.
					sends("DE1");
				break;
				
				case 1: // End record
					LEDG_2=1; // Flash loaded
				break;
				
				default: // Unknown command;
					echo='?';
					LEDRA_2=1;
				break;
			}
			else
			{
				echo='X'; // Checksum error
				LEDRA_1=1;
			}
			putchar(echo);
		}
		else if(n==(unsigned char)'`') return; // Go to interactive mode using serial port.
		else if(n==(unsigned char)'U')
		{
			LEDRA=0;
			LEDRB=0;
			LEDG=1; // Bootloader running
		}
	}
}

unsigned int str2hex (char * s)
{
	unsigned int x=0;
	unsigned char i;
	while(*s)
	{
		if((*s>='0')&&(*s<='9')) i=*s-'0';
		else if ( (*s>='A') && (*s<='F') ) i=*s-'A'+10;
		else if ( (*s>='a') && (*s<='f') ) i=*s-'a'+10;
		else break;
		x=(x*0x10)+i;
		s++;
	}
	return x;
}

void OutByte (unsigned char x)
{
	putchar(hexval[x/0x10]);
	putchar(hexval[x%0x10]);
}

void OutWord (unsigned int x)
{
	OutByte(x/0x100);
	OutByte(x%0x100);
}

unsigned char read_hex_in(void)
{
	unsigned char swa, swb;
	unsigned char toret;
	
	toret=0xff;
	
	swa=SWA;
	swb=SWB;
	
	LEDRA=swa;
	LEDRB=swb;
	
	if(swa!=0)
	{
		     if(swa&0x01) toret=0x0;
		else if(swa&0x02) toret=0x1;
		else if(swa&0x04) toret=0x2;
		else if(swa&0x08) toret=0x3;
		else if(swa&0x10) toret=0x4;
		else if(swa&0x20) toret=0x5;
		else if(swa&0x40) toret=0x6;
		else if(swa&0x80) toret=0x7;
		while (SWA!=0);
	}
	else if(swb!=0)
	{
		     if(swb&0x01) toret=0x8;
		else if(swb&0x02) toret=0x9;
		else if(swb&0x04) toret=0xa;
		else if(swb&0x08) toret=0xb;
		else if(swb&0x10) toret=0xc;
		else if(swb&0x20) toret=0xd;
		else if(swb&0x40) toret=0xe;
		else if(swb&0x80) toret=0xf;
		while (SWB!=0);
	}
	
	return toret;
}

code unsigned char seven_seg[] = { 0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8,
                                   0x80, 0x90, 0x88, 0x83, 0xC6, 0xA1, 0x86, 0x8E };

void Manual_Load (void)
{
	unsigned int add, j;
	unsigned char x, val, h_add, l_add;
	
	// Wait for the activation keys release
	while(KEY_3==0);
	while(KEY_2==0);
	
	// Load RAM with the program in flash for manual edition
	XRAMUSEDAS=0x01; // 32k RAM accessed as xdata
	FLASH_ADD2=FLASHSECTOR;
	FLASH_MOD=0x00; // Set data port for input
	_asm
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
	_endasm;
	
	add=0;
	
	while(1)
	{
		// Display address
		h_add=add/0x100;
		l_add=add%0x100;
		HEX3=seven_seg[h_add/0x10];
		HEX2=seven_seg[h_add%0x10];
		HEX1=seven_seg[l_add/0x10];
		HEX0=seven_seg[l_add%0x10];
		// Display the data at the address above
		val=Read_XRAM(add);
		HEX4=seven_seg[val%0x10];
		HEX5=seven_seg[val/0x10];

		x=read_hex_in();
		if(x<0x10)
		{
			if(SWC&0x01) // Reading address
			{
				add<<=4;
				add&=0x7ff0;
				add|=x;	
			}
			else // Reading data
			{
				val<<=4;
				val&=0xf0;
				val|=x;
				Write_XRAM(add, val);
			}
		}
		
		if(KEY_3==0) // Increment address
		{
			while(KEY_3==0); // Wait for key release
			LEDG_1=0;
			LEDG_2=0;
			add++;
			if (add>0x7fff) add=0;
		}
		else if (KEY_2==0) // Decrement address
		{
			while(KEY_2==0); // Wait for key release
			LEDG_1=0;
			LEDG_2=0;
			add--;
			if (add>0x7fff) add=0x7fff;
		}
		else if (KEY_1==0) // Save RAM to flash
		{
			while(KEY_1==0); // Wait for key release
			EraseSector();
			LEDG_1=1;
			for(j=0; j<0x8000; j++)
			{
				val=Read_XRAM(j);
				FlashByte(j, val);
			}
			LEDG_2=1;
		}
	}
}

void main (void)
{
	unsigned int i, j;
	unsigned char d;
	idata char ascii[0x10+1];	//Turn off everything!
	
	FLASH_CMD=0x0f;

	if(KEY_1==1) Load_Ram_Fast();
	
	XRAMUSEDAS=1; // 32k RAM accessed as xdata
	
	while(KEY_1==0); // Wait for key release
	
	LEDRA=0;
	LEDRB=0;
	LEDRC=0;
	LEDG=1; // Bootloader running
	HEX0=0xff;
	HEX1=0xff;
	HEX2=0xff;
	HEX3=0xff;
	HEX4=0xff;
	HEX5=0xff;
	HEX6=0xff;
	HEX7=0xff;

	inituart();
	JRXEN=1;
	JBUF=0;
	JTXEN=1;
	
	//Determine which port is being used for communication
	while(1)
	{
		if (JRXRDY==1)
		{
			d=JBUF; // Read fifo value
			if(d==(unsigned char)'U')
			{
				LEDG_7=1;
				serialmode=1; // Use JTAG for communication
				break;
			}
			while(JTXRDY!=1);
			JBUF=d; // Echo what was received
		}
		if (RI==1)
		{
			d=SBUF;
			RI=0;
			if(d==(unsigned char)'U')
			{
				serialmode=0; // Use serial port for communication
				break;
			}
			TI=0; // Echo what was received
			SBUF=d;
		}
		if ((KEY_2==0) && (KEY_3==0)) Manual_Load();
	}

	loadintelhex();

	serialmode=0; // Use serial port for communication
	getchar_echo=1;
	sends("\nReady for commands (Dump, Program, Erase, Strin, Testcode)\n");
	while(1)
	{
		sends(">");
		gets(buff);
		if(EQ(buff, "D")||EQ(buff, "d"))
		{
			sends("Address: ");
			gets(buff);
			i=str2hex(buff)&0xfff0;
			for(j=0; j<0x80; j++)
			{
				if((j%0x10)==0)
				{
					OutWord(j+i);
					putchar(':');
				}
				d=*((unsigned char xdata *)(j+i));
				OutByte(d);
				putchar(':');
				if((d>0x20)&&(d<0x7f))
					ascii[j&0xf]=d;
				else
					ascii[j&0xf]='.';
				if((j&0xf)==0xf)
				{
					ascii[0x10]=0;
					sends("  ");
					sends(ascii);
					putchar('\n');
				}
				
			}
			putchar('\n');
		}
		else if(EQ(buff, "P")||EQ(buff, "p"))
		{
			sends("Address: ");
			gets(buff);
			i=str2hex(buff);
			sends("Data: ");
			gets(buff);
			d=str2hex(buff)&0xff;
			FlashByte(i, d);
		}
		else if(EQ(buff, "E")||EQ(buff, "e"))
		{
			sends("Should erase Flash memory? (y/n)");
			gets(buff);
			if(EQ(buff, "y"))
			{
				EraseSector();
				sends("Flash erased\n");
			}
		}
		else if(EQ(buff, "S")||EQ(buff, "s"))
		{
			sends("Address: ");
			gets(buff);
			i=str2hex(buff);
			sends("String: ");
			gets(buff);
			for(j=0; buff[j]!=0; j++)
			{
				FlashByte(i++, buff[j]);	
			}
		}
		else if(EQ(buff, "T")||EQ(buff, "t"))
		{
			for(j=0; j<(16*6); j++)
			{
				FlashByte(j, counter_prog[j]);	
			}
			sends("Test program was flashed\n");
		}
		else
		{
			sends("What?\n");
		}
	}
}

void dummy_switch(void) __naked
{
	_asm
		CSEG at 0xFFE0
		mov _XRAMUSEDAS, #0x00 ; 32k RAM accessed as code
		nop
		ret
		
		CSEG at 0xffE8
		mov _XRAMUSEDAS, #0x01 ; 32k RAM accessed as xdata
		nop
		ret
	_endasm;
}
