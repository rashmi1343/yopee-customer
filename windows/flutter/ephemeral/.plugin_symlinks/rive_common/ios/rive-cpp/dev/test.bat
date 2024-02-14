@echo off
call ..\dependencies\windows\config_directories.bat

if not exist "%DEPENDENCIES%\bin\premake5.exe" (
    pushd "%DEPENDENCIES_SCRIPTS%"
    call .\get_premake5.bat || goto :error
    popd
)

set "PREMAKE=%DEPENDENCIES%\bin\premake5.exe"
pushd test
%PREMAKE% --scripts=..\..\build vs2022

MSBuild.exe /?  2> NUL
if not %ERRORLEVEL%==9009 (
    set "MSBuild=MSBuild.exe"
) else (
    set "MSBuild=%ProgramFiles%\Microsoft Visual Studio\2022\Community\Msbuild\Current\Bin\MSBuild.exe"
)
call "%MSBuild%" rive.sln
build\bin\debug\tests.exe