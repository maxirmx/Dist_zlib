@echo off
rem --------------------------------------------------------------------
rem Test script to validate some steps of the build procedures locally
rem Usage test.cmd <platform> <configuration>
rem        platform: either 'amd64' or 'X64' or 'x86'
rem        configuration: either 'debug' or 'release'
rem --------------------------------------------------------------------
@echo on

cd ..

SET ZLib_repo="https://github.com/madler/zlib"

git clone -q --branch=master %ZLib_repo% zlib

@echo off
IF "%1"=="x86" (
  SET NMake_options=OBJA="inffas32.obj match686.obj"
) ELSE (
IF "%1"=="X64" (
  SET NMake_options=AS=ml64 OBJA="inffasx64.obj gvmat64.obj inffas8664.obj"
) ELSE (
IF "%1"=="amd64" (
  SET NMake_options=AS=ml64 OBJA="inffasx64.obj gvmat64.obj inffas8664.obj"
) ELSE (
  echo Platform "%1" was not recognized
  exit -1 
)
)
)

IF "%2"=="release" (
  SET NMake_options=%NMake_options% LOC="-DASMV -DASMINF -I. -MD"
) ELSE (
IF "%2"=="debug" (
  SET NMake_options=%NMake_options% LOC="-DASMV -DASMINF -MDd -I. -Od"
) ELSE (
  echo Configuration "%2" was not recognized
  exit -1 
)
)

echo NMake_options: ^<%NMake_options%^>
@echo on

cd zlib
nmake -f ../Makefile %NMake_options%
cd ../local
