@echo off
rem --------------------------------------------------------------------
rem A script to build zlib locally
rem Usage build.cmd <platform> <configuration>
rem        platform: either 'X64' or 'x86'
rem                  'amd64' is accepted as well and converted to 'X64'
rem                   (load-library) default is 'X64'
rem        configuration: either 'debug' or 'release'
rem                   (load-library) default is 'debug'
rem --------------------------------------------------------------------
@echo on

cd ..
SET ZLib_repo="https://github.com/madler/zlib"
SET ZLib_version="v1.2.11"
IF NOT EXIST zlib (git clone -q --branch=%ZLib_version% %ZLib_repo% zlib)
powershell -ExecutionPolicy Bypass .\build-zlib.ps1 %1 %2 -configure
rem cmd.exe /c build.cmd %1 %2                                                                             
cd %~dp0


