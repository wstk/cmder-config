@echo off
setlocal ENABLEDELAYEDEXPANSION
 


IF DEFINED CMDER_ROOT (
	set CONFIG_PATH=%CMDER_ROOT%\config
	choice /M "Copy files -> !CONFIG_PATH!? (Existing files will be overwritten)"
	if errorlevel 2 (
		exit /B
	)
	echo Copying config files to '!CONFIG_PATH!'
	xcopy /S %~dp0\config !CONFIG_PATH!
) ELSE (
	echo CMDER_ROOT environment variable not set
	echo Set one with
	echo	setx CMDER_ROOT [path to cmder install]
	echo setx requires a terminal session to be restarted to apply
)
