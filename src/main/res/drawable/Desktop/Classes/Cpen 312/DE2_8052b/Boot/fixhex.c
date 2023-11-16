/*  fixhex.c: makes a hex file without any data holes

    Copyright (C) 2011 Jesus Calvino-Fraga, jesusc (at) ece.ubc.ca
	   
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

#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <string.h>

#define FALSE 0
#define TRUE 1

#define LINESIZE 32
char buf[0x100];

#define MEMSIZE 0x2000
unsigned char FlashBuff[MEMSIZE];

#define EQ(A,B) !strcmp((A),(B))
#define NEQ(A,B) strcmp((A),(B))

#define version "1.0"

#define MAXLINE 254
char FLine[MAXLINE+1];
char ModName[MAXLINE+1];

char ProgName[_MAX_PATH];
char PortName[_MAX_PATH];
char IhxName[_MAX_PATH];
char HexName[_MAX_PATH];

void GetNameFromPath(char * path, char * name)
{
	int i, j;

	for(i=0; path[i]!=0; i++);
	for(; (path[i]!='\\')&&(path[i]!='/')&&(i>=0); i--);
	for(j=0, i++; (path[i]!='.')&&(path[i]!=0); i++, j++) name[j]=path[i];
	name[j]=0;
}

int set_options (char * opt)
{
	int rvalue=0, unknown=0;
	
	static char Help[] =
	"Usage: %s [-options] ihx_file\n\n"
	"available options:\n"
	"v - Displays program version.\n"
	"h - This help.\n\n"
	;

	switch (opt[0])
	{
		default:
		    unknown=1;
		case 'h':
		case '?':
		case 'v':
		    printf("%s: ihx to mif version %s\n", ProgName, version);
		    printf("by Jesus Calvino-Fraga, Copyright (c) 2008\n\n");
			if (unknown) printf("Unknown option: %c\n", opt[0]);
		    if (opt[0]=='v') exit(0);
			printf(Help, ProgName);
			exit(1);
		break;

	}
	return (rvalue);
}

void ProcLineOptions (int argc, char **argv)
{
	int cont_par=0;
	int i, j;

	/*Get the program name*/
    GetNameFromPath(argv[0], ProgName);

	for (j=1; j<argc; j++)
	{
		if(argv[j][0]=='-')
		{
			for(i=1; argv[j][i]!=0 ; i++)
				if (set_options(&argv[j][i])) break;
		}
		else
		{
			switch(cont_par)
			{
				case 0:
 				   cont_par++;
                   strcpy(IhxName, argv[j]);
				break;

				default:
					cont_par++;
				break;
			}
		}
	}

	if (cont_par!=1)
	{
		printf("ERROR: Incorrect number of arguments.\n");
		set_options("h"); /*Show help and exit*/
	}
}

int  ihx2dec (char  ihx_digit)
{
   int j;
   j=toupper( ihx_digit)-'0';
   if (j>9) j -= 7;
   return j;
}

unsigned char GetByte(char * buffer)
{
	return  ihx2dec(buffer[0])*0x10+ ihx2dec(buffer[1]);
}

unsigned short GetWord(char * buffer)
{
	return	 ihx2dec(buffer[0])*0x1000+
			 ihx2dec(buffer[1])*0x100+
			 ihx2dec(buffer[2])*0x10+
			 ihx2dec(buffer[3]);
}

long filesize(FILE *stream)
{
   long curpos, length;

   curpos = ftell(stream);
   fseek(stream, 0L, SEEK_END);
   length = ftell(stream);
   fseek(stream, curpos, SEEK_SET);
   return length;
}

int ReadHexFile(char * filename)
{
	char buffer[1024];
	FILE * filein;
	int j, numbytes;
	unsigned char linesize, recordtype, rchksum, value;
	unsigned short address;
	int MaxAddress=0;
	int chksum;
	int line_counter=0;
	int numread=0;

	//Set the buffer to its default value
	for(j=0; j<MEMSIZE; j++) FlashBuff[j]=0x00;

    if ( (filein=fopen(filename, "r")) == NULL )
    {
       printf("Error: Can't open file `%s`.\r\n", filename);
       return -1;
    }
    
	numbytes=filesize(filein);

    while(fgets(buffer, sizeof(buffer), filein)!=NULL)
    {
    	numread+=(strlen(buffer)+1);

    	line_counter++;
    	if(buffer[0]==':')
    	{
			linesize = GetByte(&buffer[1]);
			address = GetWord(&buffer[3]);
			recordtype = GetByte(&buffer[7]);
			rchksum = GetByte(&buffer[9]+(linesize*2));
			chksum=linesize+(address/0x100)+(address%0x100)+recordtype+rchksum;

			if (recordtype==1) break; /*End of record*/

			for(j=0; j<linesize; j++)
			{
				value=GetByte(&buffer[9]+(j*2));
				chksum+=value;
				if((address+j)<MEMSIZE) FlashBuff[address+j]=value;
			}
			if(MaxAddress<(address+linesize-1)) MaxAddress=(address+linesize-1);

			if((chksum%0x100)!=0)
			{
				printf("ERROR: Bad checksum in file '%' at line %d\r\n", filename, line_counter);
				return -1;
			}
		}
    }
    fclose(filein);

    return MaxAddress;
}

void printbin(unsigned char x)
{
	if(x&0x80) printf("1"); else printf("0");
	if(x&0x40) printf("1"); else printf("0");
	if(x&0x20) printf("1"); else printf("0");
	if(x&0x10) printf("1"); else printf("0");
	if(x&0x08) printf("1"); else printf("0");
	if(x&0x04) printf("1"); else printf("0");
	if(x&0x02) printf("1"); else printf("0");
	if(x&0x01) printf("1"); else printf("0");
}

int PrepareIntelLine(char * x, int address, int len) 
{
	int j;
	unsigned char chk_sum;
	char buff[0x300];
	int toret=0;

	if((address+len)>0xffff)
	{
		len=0x10000-address;
	}

	sprintf(x, ":%02X%04X00", len, address);
	chk_sum= (unsigned char) (len + (address%0x100) + (address/0x100));

	for (j=0; j<len; j++)
	{
		sprintf(buff, "%02X", FlashBuff[address+j]);
		chk_sum += (unsigned char) FlashBuff[address+j];
		strcat(x, buff);
		if (FlashBuff[address+j]!=0xff) toret=1; //Don't send empty lines
	}
	sprintf(buff,"%02X\n", (unsigned char)(0x100-chk_sum));
	strcat(x, buff);
	return toret;
}


int main(int argc, char **argv)
{
	int MaxAddress, j, k;
	FILE * fileout;
	char buff[0x300];
	
	ProcLineOptions (argc, argv);
	strcpy(HexName, IhxName);
	
	k=strlen(HexName);
	for(j=k-1; j>0; j--) if(HexName[j]=='.') break;
	if(j>0)
	{
		HexName[j]=0;
		strcat(HexName, ".hex");	
	}
	else
	{
		printf("\nERROR: Invalid filename.");
		return -1;
	}
	
	printf("Converting '%s' to '%s'...", HexName, HexName);

	
    if ( (fileout=fopen(HexName, "w")) == NULL )
    {
       printf("\nError: Can't create file `%s`.\n", HexName);
       return -1;
    }
	
	MaxAddress=ReadHexFile(IhxName);
	if(MaxAddress<0)
	{
		printf("\nERROR: Could not load ihx file.");
		return -1;
	}
	
	for(j=0; j<MEMSIZE; j+=16)
	{
		PrepareIntelLine(buff, j, 16);
		fprintf(fileout, "%s", buff);
	}
	
	printf(" Done!\n");
	fclose(fileout);

	return 0;
}




