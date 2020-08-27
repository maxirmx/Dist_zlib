@echo off
rem --------------------------------------------------------------------
rem A script to generate NMake command line and execute it 
rem Usage build.cmd <platform> <configuration>
rem        platform: either 'amd64' or 'X64' or 'x86'
rem        configuration: either 'debug' or 'release'
rem --------------------------------------------------------------------

SET ASFLAGS=-Zi

IF "%1"=="x86" (
  SET OBJA=inffas32.obj match686.obj
  SET ASFLAGS=%ASFLAGS% -coff
) ELSE (
IF "%1"=="X64" (
  SET AS=ml64 
  SET OBJA=inffasx64.obj gvmat64.obj inffas8664.obj
) ELSE (
IF "%1"=="amd64" (
  SET AS=ml64 
  SET OBJA=inffasx64.obj gvmat64.obj inffas8664.obj
) ELSE (
  echo Platform "%1" was not recognized
  exit -1 
)
)
)

SET CFLAGS=-nologo -W3 -Oy- -Zi -Fd"zlib" -DASMV -DASMINF

IF "%2"=="release" (
  SET CFLAGS=%CFLAGS% -MD -I. -O2
) ELSE (
IF "%2"=="debug" (
  SET CFLAGS=%CFLAGS% -MDd -I. -Od
) ELSE (
  echo Configuration "%2" was not recognized
  exit -1 
)
)

echo CFLAGS:        ^<%CFLAGS%^>
echo AS:            ^<%AS%^>
echo ASFLAGS:       ^<%ASFLAGS%^>
echo OBJA:          ^<%OBJA%^>


@echo on
cd zlib
nmake -e -f win32\Makefile.msc zlib.lib zlib1.dll zdll.lib example.exe minigzip.exe
cd ..

