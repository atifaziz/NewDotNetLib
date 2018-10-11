@echo off
setlocal
set THIS_DIR=%~dp0
if "%1"=="-v" (
    shift
    echo on
)
set PROJECT_NAME=%~nx1
IF %THIS_DIR:~-1%==\ SET THIS_DIR=%THIS_DIR:~0,-1%
git clone "%THIS_DIR%" %1 || goto :EOF
pushd %1
    rd /s /q .git                                               ^
 && git init                                                    ^
 && git config user.name "Atif Aziz"                            ^
 && git config user.email "atifaziz@users.noreply.github.com"   ^
 && dotnet new sln                                              ^
 && dotnet new classlib -o src -n "%PROJECT_NAME%"              ^
 && dotnet new nunit -o tests -n "%PROJECT_NAME%.Tests"         ^
 && dotnet sln add src                                          ^
 && dotnet sln add tests                                        ^
 && dotnet add tests reference src                              ^
 && dotnet test tests                                           ^
 && git add .                                                   ^
 && git add --chmod +x *.sh
popd
endlocal
if not %ERRORLEVEL%==0 goto :EOF
echo ................................................
echo .########..########....###....########..##....##
echo .##.....##.##.........##.##...##.....##..##..##.
echo .##.....##.##........##...##..##.....##...####..
echo .########..######...##.....##.##.....##....##...
echo .##...##...##.......#########.##.....##....##...
echo .##....##..##.......##.....##.##.....##....##...
echo .##.....##.########.##.....##.########.....##...
echo ................................................
echo May the Force be with you!
cd /d %1
