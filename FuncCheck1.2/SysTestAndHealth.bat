@echo off
cls

echo == Hardware Information ==
echo.

:: Combine hardware information queries
wmic cpu get Name,Manufacturer,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed
wmic path win32_videocontroller get Name,DriverVersion
wmic MEMORYCHIP get BankLabel, Capacity, MemoryType, TypeDetail, Speed
wmic logicaldisk where drivetype=3 get DeviceID, Size, FreeSpace

echo.
echo == End of Hardware Information ==

:: System File Check
echo Checking and repairing Windows system files...
sfc /scannow

:: Windows Image Health Check
echo Checking the Windows image health...
DISM /Online /Cleanup-Image /CheckHealth

:: Fetch Device Serial Number
echo Fetching device's serial number...
wmic bios get serialnumber

:: Hardware Checks
echo.
echo Checking Battery and Hard Drive Health...
start /b powershell -Command "Get-WmiObject Win32_Battery | Select-Object DesignCapacity, FullChargeCapacity"
wmic diskdrive get status

echo.
