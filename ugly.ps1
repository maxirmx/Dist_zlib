# Ugly patching to clean annoying 'cl : Command line warning D9025'
# This is not critical, the build will succeed with the makefile taken as is
# (Get-Content zlib\win32\Makefile.msc) -replace '-MD -W3 -O2 -Oy- -Zi', '-W3 -Oy- -Zi' | Out-File -encoding ASCII zlib\win32\Makefile.msc

# Ugly patching to remove duplicate build targets 
# This is not critical, the build will succeed with the makefile taken as is
(Get-Content zlib\win32\Makefile.msc) -replace 'example.exe minigzip.exe example_d.exe minigzip_d.exe', 'example.exe minigzip.exe' | Out-File -encoding ASCII zlib\win32\Makefile.msc

