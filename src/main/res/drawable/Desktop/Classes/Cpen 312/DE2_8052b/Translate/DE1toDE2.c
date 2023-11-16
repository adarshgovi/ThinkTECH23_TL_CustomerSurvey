/*
DE1toDE2: Change pin assigments from a DE1 board to a DE2 board.

Copyright (C) 2011 Jesus Calvino-Fraga / jesusc at ece.ubc.ca

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct _pin
{
   char * Name;
   char * DE1pin;
   char * DE2pin;
};

struct _pin * pin=NULL;
char * Not_Found="NOT FOUND";
int max_pin=0;

char * AllocateString (int sz)
{
	char * s;
	s=malloc(sz+1);
	if(s==NULL)
	{
		fprintf(stderr, "ERROR: Not enough memory to allocate string.\n");
		exit(2);
	}
	return s;
}

int main (int argc, char **argv)
{
	FILE * de1qsf=NULL;
	FILE * de2qsf=NULL;
	FILE * userqsf=NULL;
	FILE * outqsf=stdout;
	char buffer[0x100];
	char s1[0x100];
	char s2[0x100];
	char s3[0x100];
	char s4[0x100];
	int j;
	
	if(argc<2)
	{
		fprintf(stderr, "Use: %s myfile.qsf [outfile.qsf]\n", argv[0]);
		return 2;
	}
	
	de2qsf=fopen("DE2.qsf", "r");
	if(de2qsf==NULL)
	{
		fprintf(stderr, "ERROR: Can't open file DE2.qsf\n");
		return 1;
	}

	de1qsf=fopen("DE1.qsf", "r");
	if(de1qsf==NULL)
	{
		fclose(de2qsf);
		fprintf(stderr, "ERROR: Can't open file DE1.qsf\n");
		return 1;
	}
	
	userqsf=fopen(argv[1], "r");
	if(userqsf==NULL)
	{
		fclose(de2qsf);
		fclose(de1qsf);
		fprintf(stderr, "ERROR: Can't open file %s\n", argv[1]);
		return 1;
	}
	
	if(argc>2)
	{
		outqsf=fopen(argv[2], "w");
		if(outqsf==NULL)
		{
			fclose(de2qsf);
			fclose(de1qsf);
			fclose(userqsf);
			fprintf(stderr, "ERROR: Can't open file %s\n", argv[2]);
			return 1;
		}
	}
	
	// Read all DE2 default pin names and locations
	j=0;
    while(fgets(buffer, sizeof(buffer), de2qsf)!=NULL)
    {
    	if(strncmp(buffer, "set_location_assignment", strlen("set_location_assignment"))==0)
    	{
	    	sscanf(buffer, "%s %s %s %s", s1, s2, s3, s4);
    		pin=realloc(pin, sizeof(struct _pin)*(j+1));
    		if(pin==NULL)
    		{
    			fprintf(stderr, "ERROR: Not enough memory to allocate pin information structure.\n");
    			return 2;
    		}
    		
    		pin[j].Name=AllocateString(strlen(s4)+1);
	    	strcpy(pin[j].Name, s4);
	    	
    		pin[j].DE2pin=AllocateString(strlen(s2)+1);
        	strcpy(pin[j].DE2pin, s2);
	    	
	    	pin[j].DE1pin=Not_Found;
	    	j++;
    	}
    }
    max_pin=j;
    
	// Read and match the DE1 pins
    while(fgets(buffer, sizeof(buffer), de1qsf)!=NULL)
    {
    	if(strncmp(buffer, "set_location_assignment", strlen("set_location_assignment"))==0)
    	{
	    	sscanf(buffer, "%s %s %s %s", s1, s2, s3, s4);
	    	for(j=0; j<max_pin; j++)
	    	{
	    		if(strcmp(pin[j].Name, s4)==0)
	    		{
		    		pin[j].DE1pin=AllocateString(strlen(s2)+1);
	    			strcpy(pin[j].DE1pin, s2);
					break;	
	    		}
	    	}
    	}
    }

	// Read the user QSF file and translate DE1 pins to DE2 pins    
    while(fgets(buffer, sizeof(buffer), userqsf)!=NULL)
    {
    	if(strncmp(buffer, "set_location_assignment", strlen("set_location_assignment"))==0)
    	{
	    	sscanf(buffer, "%s %s %s %s", s1, s2, s3, s4);
	    	for(j=0; j<max_pin; j++)
	    	{
	    		if(strcmp(pin[j].DE1pin, s2)==0)
	    		{
	    			fprintf(outqsf, "%s %s %s %s\n", s1, pin[j].DE2pin, s3, s4);
					break;	
	    		}
	    	}
	    	if(j==max_pin)
	    	{
	    		fprintf(stderr, "# WARNING: Could not find an equivalent DE2 pin for signal %s assigned to DE1 pin %s\n", s4, s2);
	    	}
    	}
    	else if (strncmp(buffer, "set_global_assignment -name DEVICE EP2C20F484C7",
    	                 strlen("set_global_assignment -name DEVICE EP2C20F484C7" ))==0)
    	{
    		fprintf(outqsf, "set_global_assignment -name DEVICE EP2C35F672C6\n");
    	}
    	else
    	{
    		fprintf(outqsf, "%s", buffer);
    	}
	}    
    
    //Check the assigments. (Testing only!)
    //for(j=0; j<max_pin; j++)
    //{
    //	printf("%s, %s, %s\n", pin[j].Name, pin[j].DE2pin, pin[j].DE1pin);
    //}
	
	// Free all allocated memory.
	for(j=0; j<max_pin; j++)
	{
		free(pin[j].Name);
		free(pin[j].DE2pin);
		if(strcmp(pin[j].DE1pin, Not_Found)!=0)	free(pin[j].DE1pin);
	}
	free(pin);
	
	fclose(de1qsf);
	fclose(de2qsf);
	fclose(userqsf);
	if(argc>2) fclose(outqsf);
	
	return 0;
}