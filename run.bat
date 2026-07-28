@echo off
setlocal

set "BUILD_DIR=build"


where cmake >nul 2>nul
if errorlevel 1 (
    echo Error: CMake was not found.
    echo Install CMake and ensure it is available through PATH.
    exit /b 1
)

if not exist "%BUILD_DIR%" (
    echo Configuring OrbitBench...
    cmake -S . -B "%BUILD_DIR%"
    if errorlevel 1 (
        echo Error: CMake configuration failed.
        exit /b 1
    )
)

echo Building OrbitBench...
cmake --build "%BUILD_DIR%" --config Release
if errorlevel 1 (
    echo Error: OrbitBench failed to build.
    exit /b 1
)

echo.
echo Starting OrbitBench...
echo.


:: Due to different compilers placing finished .exe in different places, use this fallback system

:: Check for a Release subfolder, common for multi-config tools like Visual Studio
if exist "%BUILD_DIR%\Release\orbitbench.exe" (
    "%BUILD_DIR%\Release\orbitbench.exe"
    exit /b %errorlevel%
)

:: Check if .exe is directly in the root of the build folder, common single-config tools like Make or Ninja 
if exist "%BUILD_DIR%\orbitbench.exe" (
    "%BUILD_DIR%\orbitbench.exe"
    exit /b %errorlevel%
)

:: Catch-All failure if fallback system fails
echo Error: orbitbench.exe could not be found after building.
exit /b 1