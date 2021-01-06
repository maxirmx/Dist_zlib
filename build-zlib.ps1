Param (
#  platform: either 'amd64' or 'x86'
#            'X64' is accepted as well and converted to 'amd64'
   [parameter(Mandatory=$false)][string]$platform="amd64",
#  platform: either 'debug' or 'release'
   [parameter(Mandatory=$false)][string]$configuration="debug",
# configure switch implies running vcvarsall.bat through CmdScript to inherit environment variables (local build)
   [parameter()][switch]$configure
)

 switch($platform) {
   "X64"   { $platform = "amd64"; break;  } 
   "x86"   { break; } 
   "amd64" { break; } 
   default { "build-zlib.ps1: platform <" + $platform + "> was not recognized"; exit (-1);  } 
 }


 $env:ASFLAGS = '-Zi'

 if ($platform -eq "x86") {
  $env:OBJA = 'inffas32.obj match686.obj'
  $env:ASFLAGS = $env:ASFLAGS + ' -coff'
 } else {
  $env:AS   = 'ml64'
  $env:OBJA = 'inffasx64.obj gvmat64.obj inffas8664.obj'
 }

 $env:CFLAGS = '-nologo -W3 -Oy- -Zi -Fd"zlib" -DASMV -DASMINF'
 switch($configuration) {
   "release" { 
     $env:CFLAGS = $env:CFLAGS + ' -MD -I. -O2'
     break; 
   } 
   "debug"   { 
     $env:CFLAGS = $env:CFLAGS + ' -MDd -I. -Od'
     break; 
   } 
   default   { "build-zlib.ps1: configuration <" + $configuration + "> was not recognized"; exit (-1);  } 
 }

 if ($configure) {
  .\EZTools\use-environment.ps1 "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" $platform
 } 

 "CFLAGS:        " + $env:CFLAGS
 "AS:            " + $env:AS
 "ASFLAGS:       " + $env:ASFLAGS
 "OBJA:          " + $env:OBJA


 $dname = Get-Location

 $bp =  @("-e", "-x -",
          "-f", "win32\Makefile.msc",  
          "zlib.lib", "zlib1.dll", "zdll.lib",
          "example.exe", "minigzip.exe" ) 

 Set-Location "zlib"
 & nmake $bp
 Set-Location $dname
