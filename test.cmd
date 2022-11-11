@echo off
setlocal
pushd "%~dp0"
call :main %*
popd && exit /b %ERRORLEVEL%

:main
dotnet tool restore ^
 && call build ^
 && call :test Debug ^
 && call :test Release ^
 && dotnet reportgenerator -reports:.\tests\TestResults\*\coverage.cobertura.xml -targetdir:tmp -reporttypes:TextSummary ^
 && type tmp\Summary.txt
exit /b %ERRORLEVEL%

:test
dotnet test --no-build --collect:"XPlat Code Coverage" -c %1 tests
exit /b %ERRORLEVEL%
