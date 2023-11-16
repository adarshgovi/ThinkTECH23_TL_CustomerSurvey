/*
	sterm.c: Console ANSI terminal

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

#define BANNER "Console ANSI terminal by Jesus Calvino-Fraga\n"

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

int OpenSerialPort (int Port, DWORD baud, BYTE parity, BYTE bits, BYTE stop);
int CloseSerialPort (void);
int SendString (char * s);
int SendStringNoDot (char * s);
int GetString (char * s, int n);
void term (void);

HANDLE hComm=INVALID_HANDLE_VALUE;
HANDLE hConsole=INVALID_HANDLE_VALUE;
int SerialPort=1;

int ScrollScreen (int init)
{
	static int linecounter=0;
	int returnvalue=0;
	char c;
	CONSOLE_SCREEN_BUFFER_INFO Info;
	HANDLE hConOut;

	hConOut = GetStdHandle(STD_OUTPUT_HANDLE);
	GetConsoleScreenBufferInfo(hConOut, &Info);
	
	if(init==0) linecounter=0;
	else
	{
		linecounter++;
		if(linecounter==(Info.dwSize.Y-1))
		{
			printf("<Space>=line <Enter>=page <ESC>=stop\r");
			while(1)
			{
				c=_getch();
				if(c==' ')
				{
					linecounter--;
					break;
				}
				else if ((c=='\n') || (c=='\r'))
				{
					linecounter=0;
					break;
				}
				else if (c==0x1b)
				{
					returnvalue=1;
					break;
				}
			}
			printf("                                    \r");
		}
	}
	return returnvalue;
}

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

int OpenSerialPort (int Port, DWORD baud, BYTE parity, BYTE bits, BYTE stop)
{
	char sPort[16];
	DCB dcb;
	COMMTIMEOUTS Timeouts;

	sprintf(sPort, "\\\\.\\COM%d", Port);
	
	hComm = CreateFile(sPort, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, 0, NULL);
	if (hComm == INVALID_HANDLE_VALUE)
	{
		//printf("Failed to open up the comunication port COM%d\n", Port);
		return -1;
	}
	
	if (!GetCommState(hComm, &dcb))
	{
		printf("Failed in call to GetCommState()\n");
		return -1;
	}

	dcb.fAbortOnError=FALSE;
	dcb.BaudRate = baud; 
	dcb.Parity = parity;
	dcb.ByteSize = bits;
	dcb.StopBits = stop;
	dcb.fDsrSensitivity = FALSE;
	dcb.fOutxCtsFlow = FALSE;
	dcb.fOutxDsrFlow = FALSE;
	dcb.fOutX = FALSE;
	dcb.fInX = FALSE;

	//Now that we have all the settings in place, make the changes
	if (!SetCommState(hComm, &dcb))
	{
		printf("Failed in call to SetCommState()\n");
		return -1;
	}	

	//The always important timeouts.  May need to increase them for
	//USB to rs-232 adapters.

	ZeroMemory(&Timeouts, sizeof(COMMTIMEOUTS));
	Timeouts.ReadIntervalTimeout = 250;
	Timeouts.ReadTotalTimeoutMultiplier = 10;
	Timeouts.ReadTotalTimeoutConstant = 250;
	Timeouts.WriteTotalTimeoutMultiplier = 10;
	Timeouts.WriteTotalTimeoutConstant = 250;
	if (!SetCommTimeouts(hComm, &Timeouts))
	{
		printf("Failed in call to SetCommTimeouts\n");
		return -1;
	}

	return 0;
}

int CloseSerialPort (void)
{
	BOOL bSuccess;
	bSuccess = CloseHandle(hComm);
    hComm = INVALID_HANDLE_VALUE;
    if (!bSuccess)
    {
		printf("Failed to close serial port, GetLastError:%d\n", GetLastError());
		return -1;
	}
	return 0;
}


int SendString (char * s)
{
	char answer[MAXBUFF];
	DWORD j;

	if (!WriteFile(hComm, s, strlen(s), &j, NULL))
	{
		printf("Failed in call to WriteFile()\n");
		return -1;
	}

	//Get the echo
	j=0;
	if (!ReadFile(hComm, answer, strlen(s)+1, &j, NULL))
	{
		printf("Failed in call to ReadFile()\n");
		return -1;
	}
	answer[j]=0; //ASCIIZ the string
	//printf("%s\n", buff);
	
	if(j>0)
	{
		if(answer[j-1]!='.') //Resynchronize the receive buffer
		{
			ReadFile(hComm, answer, MAXBUFF, &j, NULL);
		}
	}
	
	if (j==0) return -2;
	else return 0;
}

int SendStringNoDot (char * s)
{
	char answer[0x200];
	DWORD j;

	if (!WriteFile(hComm, s, strlen(s), &j, NULL))
	{
		printf("Failed in call to WriteFile()\n");
		return -1;
	}

	//Get the echo
	j=0;
	if (!ReadFile(hComm, answer, strlen(s), &j, NULL))
	{
		printf("Failed in call to ReadFile()\n");
		return -1;
	}
	answer[j]=0; //ASCIIZ the string
	
	return 0;
}

int GetString (char * s, int n)
{
	DWORD j=0;

	if (!ReadFile(hComm, s, n, &j, NULL))
	{
		printf("Failed in call to ReadFile()\n");
		return -1;
	}
	if(j!=(DWORD)n)
	{
		//printf("Communication with target timed out!\n");
		//exit(-1);
	}
	s[j]=0; //ASCIIZ the string
	//printf("%s\n", s);

	return 0;
}

void term (void)
{
	int Intelk=0;
	char IntelBuff[MAXBUFF];
	int ANSIk=0;
	char ANSIBuff[MAXBUFF];
	COMMTIMEOUTS Timeouts;
	COMMTIMEOUTS SavedTimeouts;

	char c;
	DWORD j=0;
	
	GetCommTimeouts(hComm, &SavedTimeouts);
	ZeroMemory(&Timeouts, sizeof(COMMTIMEOUTS));
	Timeouts.ReadIntervalTimeout = 1;
	Timeouts.ReadTotalTimeoutMultiplier = 1;
	Timeouts.ReadTotalTimeoutConstant = 1;
	Timeouts.WriteTotalTimeoutMultiplier = 1;
	Timeouts.WriteTotalTimeoutConstant = 1;
	SetCommTimeouts(hComm, &Timeouts);

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
						printf( "\n\n%s\n"
								"F1  - This help\n"
								"F2  - Clear screen\n"
								"F10 - Exit\n",
								BANNER);
					break ;
					case F2:
						system("cls");
					break ;
					case F10:
						printf("\n");
						SetCommTimeouts(hComm, &SavedTimeouts);
						return;
					break ;

					default:
					break;
				}
			}
			else
			{
				WriteFile(hComm, &c, 1, &j, NULL);
				FlushFileBuffers(hComm);
			}
		}

		if (ReadFile(hComm, &c, 1, &j, NULL))
		{
			if(j==1)
			{
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
						if(j!=0) _putch(c);
					}
				}
			}
		}
	}
}

int main(int argc, char **argv)
{
	hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	SetConsoleTextAttribute(hConsole, FOREGROUND_BLUE|FOREGROUND_GREEN|FOREGROUND_RED);
	SetConsoleTitle("STerm");
	printf(BANNER);
			
	if(argc>1)
	{
		SerialPort=atoi(argv[1]);
	}
	
	if(OpenSerialPort(SerialPort, 115200, NOPARITY, 8, ONESTOPBIT)!=0)
	{
		printf("Couldn't open serial port COM%d\n", SerialPort);
		exit(-1);
	}
	else
	{
		printf("Using COM%d\r\n", SerialPort);
	}

	term();

	SetConsoleTextAttribute(hConsole, FOREGROUND_BLUE|FOREGROUND_GREEN|FOREGROUND_RED);
	CloseSerialPort();
	
	return 0;
}
