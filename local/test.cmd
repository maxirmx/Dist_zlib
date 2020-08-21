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
SET ZLib_version="v1.2.11"
IF NOT EXIST zlib (git clone -q --branch=%ZLib_version% %ZLib_repo% zlib)
powershell -ExecutionPolicy Bypass ./ugly.ps1
cmd.exe /c build.cmd %1 %2                                                                             
cd cd %~dp0


