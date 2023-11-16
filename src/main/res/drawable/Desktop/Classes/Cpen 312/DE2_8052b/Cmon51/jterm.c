/*
	jterm.c: USB-Blaster ANSI terminal for the DE1-8052/DE2-8052
	
	Copyright (C) 2009-2011  Jesus Calvino-Fraga, jesusc (at) ece.ubc.ca
	   
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

#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <windows.h>
#include "FTD2XX.h"

#pragma comment (lib, ".\\FTD2XX.lib")

#define BANNER "USB-Blaster ANSI terminal by Jesus Calvino-Fraga (c) 2009-2011"

#define F1  59
#define F2  60
#define F3  61
#define F4  62
#define F5  63
#define F6  64
#define F7  65
#define F8  66
#define F9  67
#define F10 68

#define CODEMEMORYSIZE 0x10000
#define DATAMEMORYSIZE 0x100
#define XDATAMEMORYSIZE 0x100
#define MAXBUFF 0x200
#define EQ(X,Y) (_stricmp(X, Y)==0)
#define NEQ(X,Y) (_stricmp(X, Y)!=0)

#define TCK			(1 << 0)
#define TMS			(1 << 1)
#define NCE			(1 << 2)
#define NCS			(1 << 3)
#define TDI			(1 << 4)
#define LED			(1 << 5)
#define READ		(1 << 6)
#define SHMODE		(1 << 7)

void term (void);

HANDLE hComm=INVALID_HANDLE_VALUE;
HANDLE hConsole=INVALID_HANDLE_VALUE;
int SerialPort=1;
FT_HANDLE FTDIHandle = 0;
#define DEVICE_NAME "USB-Blaster"  

// Almost all this ANSI code taken from:
// http://cpansearch.perl.org/src/JLMOREL/Win32-Console-ANSI-1.00/ANSI.xs

HANDLE hConOut;

#define MAX_ARG 16    // max number of args in an escape sequence
char suffix;          // escape sequence suffix
int es_argc;          // escape sequence args count
int es_argv[MAX_ARG]; // escape sequence args

// color constants

#define FOREGROUND_BLACK 0
#define FOREGROUND_WHITE FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_BLUE

#define BACKGROUND_BLACK 0
#define BACKGROUND_WHITE BACKGROUND_RED|BACKGROUND_GREEN|BACKGROUND_BLUE

WORD foregroundcolor[8] = {
  FOREGROUND_BLACK,                   // black foreground
  FOREGROUND_RED,                     // red foreground
  FOREGROUND_GREEN,                   // green foreground
  FOREGROUND_RED|FOREGROUND_GREEN,    // yellow foreground
  FOREGROUND_BLUE,                    // blue foreground
  FOREGROUND_BLUE|FOREGROUND_RED,     // magenta foreground
  FOREGROUND_BLUE|FOREGROUND_GREEN,   // cyan foreground
  FOREGROUND_WHITE                    // white foreground
};

WORD backgroundcolor[8] = {
  BACKGROUND_BLACK,                   // black background
  BACKGROUND_RED,                     // red background
  BACKGROUND_GREEN,                   // green background
  BACKGROUND_RED|BACKGROUND_GREEN,    // yellow background
  BACKGROUND_BLUE,                    // blue background
  BACKGROUND_BLUE|BACKGROUND_RED,     // magenta background
  BACKGROUND_BLUE|BACKGROUND_GREEN,   // cyan background
  BACKGROUND_WHITE,                   // white background
};

// screen attributes
WORD foreground = FOREGROUND_WHITE;
WORD background = BACKGROUND_BLACK;
WORD bold       = 0;
WORD underline  = 0;
WORD rvideo     = 0;
WORD concealed  = 0;

// saved cursor position
COORD SavePos = {0, 0};

void InterpretANSIEscSeq (char * buff)
{
	int state=0;
	int i;
	WORD attribut;
	CONSOLE_SCREEN_BUFFER_INFO Info;
	DWORD NumberOfCharsWritten;
	COORD Pos;
	SMALL_RECT Rect;
	CHAR_INFO CharInfo;
	char * s;

	hConOut = GetStdHandle(STD_OUTPUT_HANDLE);

	for(s=buff; *s!=0; s++)
	{
		switch (state)
		{
			case 0: //Scan for '['
				if (*s == '[')
				{
					state=1;
				}
			break;

			case 1:
				if ( isdigit(*s))
				{
					es_argc = 0;
					es_argv[0] = *s-'0';
					state = 2;
				}
				else if ( *s == ';' )
				{
					es_argc = 1;
					es_argv[0] = 0;
					es_argv[es_argc] = 0;
					state = 2;
				}
				else
				{
					es_argc = 0;
					suffix = *s;
					state = 3;
				}
			break;

			case 2:
				if ( isdigit(*s) )
				{
					es_argv[es_argc] = 10*es_argv[es_argc]+(*s-'0');
				}
				else if ( *s == ';' )
				{
					if (es_argc < MAX_ARG-1) es_argc++;
					es_argv[es_argc] = 0;
				}
				else
				{
					if (es_argc < MAX_ARG-1) es_argc++;
					suffix = *s;
					state = 3;
				}
			break;

			case 3:
				//Done: just finish the string until a terminator is found
			break;

			default:
			break;
		}
	}

	// es_argc            escape sequence args count
	// es_argv[]          escape sequence args array
	// suffix             escape sequence suffix
	//
	// for instance, with \e[33;45;1m we have
	// prefix = '[',
	// es_argc = 3, es_argv[0] = 33, es_argv[1] = 45, es_argv[2] = 1
	// suffix = 'm'

	GetConsoleScreenBufferInfo(hConOut, &Info);

	switch (suffix)
	{
		case 'm':
			if ( es_argc == 0 ) es_argv[es_argc++] = 0;
			
			for(i=0; i<es_argc; i++)
			{
				switch (es_argv[i])
				{
					case 0 :
						foreground = FOREGROUND_WHITE;
						background = BACKGROUND_BLACK;
						bold = 0;
						underline = 0;
						rvideo = 0;
						concealed = 0;
					break;

					case 1  : bold = 1;      break;
					case 21 : bold = 0;      break;
					case 4  : underline = 1; break;
					case 24 : underline = 0; break;
					case 7  : rvideo = 1;    break;
					case 27 : rvideo = 0;    break;
					case 8  : concealed = 1; break;
					case 28 : concealed = 0; break;
				}
				if ( (30 <= es_argv[i]) && (es_argv[i] <= 37) )
					foreground = es_argv[i]-30;
				if ( (40 <= es_argv[i]) && (es_argv[i] <= 47) )
					background = es_argv[i]-40;
			}
			
			if (rvideo)
				attribut = foregroundcolor[background] | backgroundcolor[foreground];
			else
				attribut = foregroundcolor[foreground] | backgroundcolor[background];
			
			if (bold)
				attribut |= FOREGROUND_INTENSITY;
			
			if (underline)
				attribut |= BACKGROUND_INTENSITY;
			
			SetConsoleTextAttribute(hConOut, attribut);
			return;

		case 'J':
			if ( es_argc == 0 ) es_argv[es_argc++] = 0;   // ESC[J == ESC[0J
			if ( es_argc != 1 ) return;
			switch (es_argv[0])
			{
				case 0 : // ESC[0J erase from cursor to end of display
					FillConsoleOutputCharacter(
						hConOut,
						' ', 
						(Info.dwSize.Y-Info.dwCursorPosition.Y-1)
						*Info.dwSize.X+Info.dwSize.X-Info.dwCursorPosition.X-1,
						Info.dwCursorPosition,
						&NumberOfCharsWritten);

					FillConsoleOutputAttribute(
						hConOut,
						Info.wAttributes,
						(Info.dwSize.Y-Info.dwCursorPosition.Y-1)
						*Info.dwSize.X+Info.dwSize.X-Info.dwCursorPosition.X-1,
						Info.dwCursorPosition,
						&NumberOfCharsWritten);
					
					return;

				case 1 : // ESC[1J erase from start to cursor.
					Pos.X = 0;
					Pos.Y = 0;
					FillConsoleOutputCharacter(
						hConOut,
						' ',
						Info.dwCursorPosition.Y*Info.dwSize.X+Info.dwCursorPosition.X+1,
						Pos,
						&NumberOfCharsWritten);

					FillConsoleOutputAttribute(
						hConOut,
						Info.wAttributes,
						Info.dwCursorPosition.Y*Info.dwSize.X+Info.dwCursorPosition.X+1,
						Pos,
						&NumberOfCharsWritten);
					
					return;

				case 2 : // ESC[2J Clear screen and home cursor
					Pos.X = 0;
					Pos.Y = 0;
					FillConsoleOutputCharacter(
						hConOut,
						' ',
						Info.dwSize.X*Info.dwSize.Y,
						Pos,
						&NumberOfCharsWritten);

					FillConsoleOutputAttribute(
						hConOut,
						Info.wAttributes,
						Info.dwSize.X*Info.dwSize.Y,
						Pos,
						&NumberOfCharsWritten);
						SetConsoleCursorPosition(hConOut, Pos);
					
					return;

				default :
					return;
			}

		case 'K':
			if ( es_argc == 0 ) es_argv[es_argc++] = 0;   // ESC[K == ESC[0K
			if ( es_argc != 1 ) return;
		
			switch (es_argv[0])
			{
				case 0 : // ESC[0K Clear to end of line
					FillConsoleOutputCharacter(
						hConOut,
						' ',
						Info.srWindow.Right-Info.dwCursorPosition.X+1,
						Info.dwCursorPosition,
						&NumberOfCharsWritten);

					FillConsoleOutputAttribute(
						hConOut,
						Info.wAttributes,
						Info.srWindow.Right-Info.dwCursorPosition.X+1,
						Info.dwCursorPosition,
						&NumberOfCharsWritten);
					
					return;

				case 1 : // ESC[1K Clear from start of line to cursor
					Pos.X = 0;
					Pos.Y = Info.dwCursorPosition.Y;
					
					FillConsoleOutputCharacter(
						hConOut,
						' ',
						Info.dwCursorPosition.X+1,
						Pos,
						&NumberOfCharsWritten);

					FillConsoleOutputAttribute(
						hConOut,
						Info.wAttributes,
						Info.dwCursorPosition.X+1,
						Pos,
						&NumberOfCharsWritten);
					
					return;

				case 2 : // ESC[2K Clear whole line.
					Pos.X = 0;
					Pos.Y = Info.dwCursorPosition.Y;
					
					FillConsoleOutputCharacter(
						hConOut,
						' ',
						Info.dwSize.X,
						Pos,
						&NumberOfCharsWritten);

					FillConsoleOutputAttribute(
						hConOut,
						Info.wAttributes,
						Info.dwSize.X,
						Pos,
						&NumberOfCharsWritten);

					return;

				default :
					return;
		}

		case 'L': // ESC[#L Insert # blank lines.
			if ( es_argc == 0 ) es_argv[es_argc++] = 1;   // ESC[L == ESC[1L
			if ( es_argc != 1 ) return;
			
			Rect.Left   = 0;
			Rect.Top    = Info.dwCursorPosition.Y;
			Rect.Right  = Info.dwSize.X-1;
			Rect.Bottom = Info.dwSize.Y-1;
			Pos.X = 0;
			Pos.Y = Info.dwCursorPosition.Y+es_argv[0];
			CharInfo.Char.AsciiChar = ' ';
			CharInfo.Attributes = Info.wAttributes;
			ScrollConsoleScreenBuffer(
				hConOut,
				&Rect,
				NULL,
				Pos,
				&CharInfo);
			Pos.X = 0;
			Pos.Y = Info.dwCursorPosition.Y;
			FillConsoleOutputCharacter(
				hConOut,
				' ',
				Info.dwSize.X*es_argv[0],
				Pos,
				&NumberOfCharsWritten);
			FillConsoleOutputAttribute(
				hConOut,
				Info.wAttributes,
				Info.dwSize.X*es_argv[0],
				Pos,
				&NumberOfCharsWritten);
			return;

		case 'M': // ESC[#M Delete # line.
			if ( es_argc == 0 ) es_argv[es_argc++] = 1;   // ESC[M == ESC[1M
			if ( es_argc != 1 ) return;
			if ( es_argv[0] > Info.dwSize.Y - Info.dwCursorPosition.Y )
				es_argv[0] = Info.dwSize.Y - Info.dwCursorPosition.Y;
			
			Rect.Left   = 0;
			Rect.Top    = Info.dwCursorPosition.Y+es_argv[0];
			Rect.Right  = Info.dwSize.X-1;
			Rect.Bottom = Info.dwSize.Y-1;
			Pos.X = 0;
			Pos.Y = Info.dwCursorPosition.Y;
			CharInfo.Char.AsciiChar = ' ';
			CharInfo.Attributes = Info.wAttributes;
			ScrollConsoleScreenBuffer(
				hConOut,
				&Rect,
				NULL,
				Pos,
				&CharInfo);
				Pos.Y = Info.dwSize.Y - es_argv[0];
			FillConsoleOutputCharacter(
				hConOut,
				' ',
				Info.dwSize.X * es_argv[0],
				Pos,
				&NumberOfCharsWritten);
			FillConsoleOutputAttribute(
				hConOut,
				Info.wAttributes,
				Info.dwSize.X * es_argv[0],
				Pos,
				&NumberOfCharsWritten);
			return;

		case 'P': // ESC[#P Delete # characters.
			if ( es_argc == 0 ) es_argv[es_argc++] = 1;   // ESC[P == ESC[1P
			if ( es_argc != 1 ) return;
			if (Info.dwCursorPosition.X + es_argv[0] > Info.dwSize.X - 1)
				es_argv[0] = Info.dwSize.X - Info.dwCursorPosition.X;
			
			Rect.Left   = Info.dwCursorPosition.X + es_argv[0];
			Rect.Top    = Info.dwCursorPosition.Y;
			Rect.Right  = Info.dwSize.X-1;
			Rect.Bottom = Info.dwCursorPosition.Y;
			CharInfo.Char.AsciiChar = ' ';
			CharInfo.Attributes = Info.wAttributes;
			ScrollConsoleScreenBuffer(
				hConOut,
				&Rect,
				NULL,
				Info.dwCursorPosition,
				&CharInfo);
			Pos.X = Info.dwSize.X - es_argv[0];
			Pos.Y = Info.dwCursorPosition.Y;
			FillConsoleOutputCharacter(
				hConOut,
				' ',
				es_argv[0],
				Pos,
				&NumberOfCharsWritten);
			return;

		case '@': // ESC[#@ Insert # blank characters.
			if ( es_argc == 0 ) es_argv[es_argc++] = 1;   // ESC[@ == ESC[1@
			if ( es_argc != 1 ) return;
			if (Info.dwCursorPosition.X + es_argv[0] > Info.dwSize.X - 1)
				es_argv[0] = Info.dwSize.X - Info.dwCursorPosition.X;
			
			Rect.Left   = Info.dwCursorPosition.X;
			Rect.Top    = Info.dwCursorPosition.Y;
			Rect.Right  = Info.dwSize.X-1-es_argv[0];
			Rect.Bottom = Info.dwCursorPosition.Y;
			Pos.X = Info.dwCursorPosition.X+es_argv[0];
			Pos.Y = Info.dwCursorPosition.Y;
			CharInfo.Char.AsciiChar = ' ';
			CharInfo.Attributes = Info.wAttributes;
			ScrollConsoleScreenBuffer(
				hConOut,
				&Rect,
				NULL,
				Pos,
				&CharInfo);
			FillConsoleOutputCharacter(
				hConOut,
				' ',
				es_argv[0],
				Info.dwCursorPosition,
				&NumberOfCharsWritten);
				FillConsoleOutputAttribute(
				hConOut,
				Info.wAttributes,
				es_argv[0],
				Info.dwCursorPosition,
				&NumberOfCharsWritten);
			return;

		case 'A' : // ESC[#A Moves cursor up # lines
			if ( es_argc == 0 ) es_argv[es_argc++] = 1; // ESC[A == ESC[1A
			if ( es_argc != 1 ) return;
			Pos.X = Info.dwCursorPosition.X;
			Pos.Y = Info.dwCursorPosition.Y-es_argv[0];
			if (Pos.Y < 0) Pos.Y = 0;
			SetConsoleCursorPosition(hConOut, Pos);
			return;

		case 'B' : // ESC[#B Moves cursor down # lines
			if ( es_argc == 0 ) es_argv[es_argc++] = 1;   // ESC[B == ESC[1B
			if ( es_argc != 1 ) return;
			Pos.X = Info.dwCursorPosition.X;
			Pos.Y = Info.dwCursorPosition.Y+es_argv[0];
			if (Pos.Y >= Info.dwSize.Y) Pos.Y = Info.dwSize.Y-1;
			SetConsoleCursorPosition(hConOut, Pos);
			return;

		case 'C' : // ESC[#C Moves cursor forward # spaces
			if ( es_argc == 0 ) es_argv[es_argc++] = 1;   // ESC[C == ESC[1C
			if ( es_argc != 1 ) return;
			Pos.X = Info.dwCursorPosition.X+es_argv[0];
			if ( Pos.X >= Info.dwSize.X ) Pos.X = Info.dwSize.X-1;
			Pos.Y = Info.dwCursorPosition.Y;
			SetConsoleCursorPosition(hConOut, Pos);
			return;

		case 'D' : // ESC[#D Moves cursor back # spaces
			if ( es_argc == 0 ) es_argv[es_argc++] = 1;   // ESC[D == ESC[1D
			if ( es_argc != 1 ) return;
			Pos.X = Info.dwCursorPosition.X-es_argv[0];
			if ( Pos.X < 0 ) Pos.X = 0;
			Pos.Y = Info.dwCursorPosition.Y;
			SetConsoleCursorPosition(hConOut, Pos);
			return;

		case 'E' : // ESC[#E Moves cursor down # lines, column 1.
			if ( es_argc == 0 ) es_argv[es_argc++] = 1;   // ESC[E == ESC[1E
			if ( es_argc != 1 ) return;
			Pos.X = 0;
			Pos.Y = Info.dwCursorPosition.Y+es_argv[0];
			if (Pos.Y >= Info.dwSize.Y) Pos.Y = Info.dwSize.Y-1;
			SetConsoleCursorPosition(hConOut, Pos);
			return;

		case 'F' : // ESC[#F Moves cursor up # lines, column 1.
			if ( es_argc == 0 ) es_argv[es_argc++] = 1;   // ESC[F == ESC[1F
			if ( es_argc != 1 ) return;
			Pos.X = 0;
			Pos.Y = Info.dwCursorPosition.Y-es_argv[0];
			if ( Pos.Y < 0 ) Pos.Y = 0;
			SetConsoleCursorPosition(hConOut, Pos);
			return;

		case 'G' : // ESC[#G Moves cursor column # in current row.
			if ( es_argc == 0 ) es_argv[es_argc++] = 1;   // ESC[G == ESC[1G
			if ( es_argc != 1 ) return;
			Pos.X = es_argv[0] - 1;
			if ( Pos.X >= Info.dwSize.X ) Pos.X = Info.dwSize.X-1;
			if ( Pos.X < 0) Pos.X = 0;
			Pos.Y = Info.dwCursorPosition.Y;
			SetConsoleCursorPosition(hConOut, Pos);
			return;

		case 'f' :
		case 'H' : // ESC[#;#H or ESC[#;#f Moves cursor to line #, column #
			if ( es_argc == 0 )
			{
				es_argv[es_argc++] = 1; // ESC[H == ESC[1;1H
				es_argv[es_argc++] = 1;
			}
			if ( es_argc == 1 )
			{
				es_argv[es_argc++] = 1; // ESC[nH == ESC[n;1H
			}
			if ( es_argc > 2 ) return;
			Pos.X = es_argv[1] - 1;
			if ( Pos.X < 0) Pos.X = 0;
			if ( Pos.X >= Info.dwSize.X ) Pos.X = Info.dwSize.X-1;
			Pos.Y = es_argv[0] - 1;
			if ( Pos.Y < 0) Pos.Y = 0;
			if (Pos.Y >= Info.dwSize.Y) Pos.Y = Info.dwSize.Y-1;
			SetConsoleCursorPosition(hConOut, Pos);
			return;

		case 's' : // ESC[s Saves cursor position for recall later
			if ( es_argc != 0 ) return;
			SavePos.X = Info.dwCursorPosition.X;
			SavePos.Y = Info.dwCursorPosition.Y;
			return;

		case 'u' : // ESC[u Return to saved cursor position
			if ( es_argc != 0 ) return;
			SetConsoleCursorPosition(hConOut, SavePos);
			return;

		default :
			return;

	}
}

// Read up to 60 bytes in one shot
void GetBytes (unsigned char * buf)
{
	HRESULT status;
	unsigned long dw_bytes_written, dw_bytes_read;
	int j;

	for(j=0; j<60 ; j++) buf[j+1]=0; //must be zero
	
	buf[0]=SHMODE|READ|60;

	status = FT_Write(FTDIHandle, buf, 61, &dw_bytes_written);
	if (status != FT_OK) printf("Error writing to device: %lu\n", status);
	
	status = FT_Read(FTDIHandle, buf, 60, &dw_bytes_read);
	if (status != FT_OK) printf("Error reading from device: %lu\n", status);
}

void PutByte (unsigned char c)
{
	HRESULT status;
	unsigned char buf[2];
	unsigned long dw_bytes_written, dw_bytes_read;
	
	buf[0]=SHMODE|1;
	buf[1]=c;
	status = FT_Write(FTDIHandle, buf, 2, &dw_bytes_written);
	if (status != FT_OK) printf("Error writing to device: %lu\n", status);
	if ( (c=='\r') || (c=='\n') ) Sleep(100);
}

void print_info (void)
{
	printf( "%s\n"
			"Available console commands:\n"
			"  F1  - This help\n"
			"  F2  - Clear screen\n"
			"  F3  - Cmon51 help\n"
			"  F10 - Exit\n",
			BANNER);
}

void cmon51_help (void)
{
	printf( 
			"\nCmon51 commands:\n\n"
			"  R: show registers\n"
			"  G: go, run program\n"
			"  S: step into instruction\n"
			"  PCR: retore program counter to default\n"
			"  T: trace program execution\n"
			"  BRON add: set breakpoint at 'add'\n"
			"  BROFF add: clear breakpoint at 'add'\n"
			"  BRL: list breakpoints\n"
			"  BRC: clear all breakpoints\n"
			"  D add len: display 'len' bytes of DATA memory starting at 'add'\n"
			"  C add len: display 'len' bytes of CODE memory starting at 'add'\n"
			"  I add len: display 'len' bytes of IDATA memory starting at 'add'\n"
			"  X add len: display 'len' bytes of XDATA memory starting at 'add'\n"
			"  MD add: modify DATA memory at 'add'\n"
			"  MI add: modify IDATA memory at 'add'\n"
			"  MX add: modify XDATA memory at 'add'\n"
			"  FD add len value: set 'len' bytes of  DATA to 'value' starting at 'add'\n"
			"  FI add len value: set 'len' bytes of IDATA to 'value' starting at 'add'\n"
			"  FX add len value: set 'len' bytes of XDATA to 'value' starting at 'add'\n"
			"  U add len: dissasemble 'len' lines of code starting at 'add'\n" 
			);
}

void term (void)
{
	int ANSIk=0;
	char ANSIBuff[MAXBUFF];
	char buff[0x100];
	char c;
	int j;
	
	while(1)
	{
		if (kbhit())
		{
			c=_getch();
			if (c==0)
			{
				c=_getch()&0xFF;
				switch(c)
				{
					case F1:
						print_info();
					break ;
					case F2:
						system("cls");
					break ;
					case F3:
						cmon51_help();
					break;
					case F10:
						printf("\n");
						return;
					break ;

					default:
					break;
				}
			}
			else
			{
				PutByte(c);
			}
		}

		GetBytes(buff);
		for(j=0; buff[j]!=0; j++)
		{
			c=buff[j];
			//Reading ANSI escape sequence?
			if(ANSIk>0)
			{
				ANSIBuff[ANSIk]=c;
				ANSIk++;
				if((c=='@') || isalpha(c))
				{
					ANSIBuff[ANSIk]=0;
					ANSIk=0;
					InterpretANSIEscSeq(ANSIBuff);
				}
			}
			else
			{
				if(c==0x1b) 
				{
					ANSIBuff[0]=c;
					ANSIk=1;
				}
				else
				{
					if(c=='\a') Beep(440, 200);
					else _putch(c);
				}
			}
		}
	}
}

int CloseDevice(void)
{
	HRESULT res, status;
	unsigned char buf[10];
	unsigned int size;
	unsigned long dw_bytes_written;
	
	if (!DeviceOpen()) return -1;
	
	buf[0]=0; // turn off everything
	status = FT_Write(FTDIHandle, buf, 1, &dw_bytes_written);
		
	res = FT_Close(FTDIHandle);
	FTDIHandle = 0;
	printf("'%s' is closed\n", DEVICE_NAME); 
	return res;
}

int DeviceOpen(void)
{
	int res;
	
	res = 1;
	if (FTDIHandle == 0) res = 0;
	return res;
}

int OpenDevice(void)
{
	HRESULT res, status;
	unsigned char buf[10];
	unsigned int size;
	unsigned long dw_bytes_written;
	int j;
	
	if (DeviceOpen()) CloseDevice();	// close currently open device
	
	res = FT_OpenEx (DEVICE_NAME, FT_OPEN_BY_DESCRIPTION, &FTDIHandle);
	if (res!=FT_OK )
	{
		printf("Error opening USB Device '%s', error code %d\n", DEVICE_NAME, res);
	}
	else
	{
		printf("'%s' is open\n", DEVICE_NAME); //A bit anoying for repeated testing
		
		status = FT_SetBitMode(FTDIHandle, 0x00, FT_BITMODE_SYNC_FIFO);
		if (status != FT_OK) printf("unable to set bit i/o mode: %lu\n", status);
		
		//Configure JTAG access
		for(j=0; j<10; j++)
		{
			buf[0]=0;  // Turn off everything
			status = FT_Write(FTDIHandle, buf, 1, &dw_bytes_written);
			if (status != FT_OK) printf("Error writing to device: %lu\n", status);
		
			buf[0]=LED;  // Without LED there is no clock.  For the Altera DE1, NCS=0 and NCE=0 .
			status = FT_Write(FTDIHandle, buf, 1, &dw_bytes_written);
			if (status != FT_OK) printf("Error writing to device: %lu\n", status);
		}

	}
	return res;
}

int main(int argc, char **argv)
{
	hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	SetConsoleTextAttribute(hConsole, FOREGROUND_BLUE|FOREGROUND_GREEN|FOREGROUND_RED);
	SetConsoleTitle("JTerm");
	print_info();
			
	OpenDevice();

	term();

	SetConsoleTextAttribute(hConsole, FOREGROUND_BLUE|FOREGROUND_GREEN|FOREGROUND_RED);
	CloseDevice();
	
	return 0;
}
