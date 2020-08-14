# Dist_zlib

This is a script to build <a href="http://www.zlib.net"> zlib </a> Windows binaries using <a href="https://www.appveyor.com">AppVeyor</a><br />

[![Build status](https://ci.appveyor.com/api/projects/status/av2jl6wrvxxvcgry/branch/master?svg=true)](https://ci.appveyor.com/project/maxirmx/dist-zlib/branch/master)

Artifacts (built with Microsoft Visual Studio 14.0 multithreaded DLL RTL) are available through release area.


>Note.  This script includes some ugly patching of MSVC makefile:
>   * to clean annoying 'cl : Command line warning D9025'
>   * to remove duplicate build targets 
>   
>This is not critical, the build will succeed with the makefile taken as is.
>Sure, there is an option to make solid fixes and ask to merge them to zlib project but I am too lazy and shy to go for it without any request

