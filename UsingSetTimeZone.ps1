#Start Transcript for me to get the trace of what you test
Start-Transcript $env:userprofile\Document\TimeZonetest.txt

## Method #1 Using System.TimeZoneInfo .NET accelerator
#Getting current system's Time Zone
[System.TimeZoneInfo]::GetSystemTimeZones()

#Retrieve Yukon time zone specifically
[System.TimeZoneInfo]::FindSystemTimeZoneById("Yukon Standard Time")

## Method #2 Using Get-TimeZone and Set-TimeZone PowerShell cmdlets
# To list your timezones available on the system:
Get-TimeZone -ListAvailable | Sort StandardName |ft id, StandardName

#Store all the TZ in a variable:
$TZList = Get-TimeZone -ListAvailable | Sort StandardName

#Print the TZ list (for my information)
$TZList

#Check if Yukon TZ is there:
$TZList |?{$_.ID -like "*Yukon*"}

#Then store Yukon TZ in another variable
$Yukon = $TZList |?{$_.ID -like "*Yukon*"}

#Check $Yukon variable only has Yukon
$Yukon

#Store your current timezone in another variable to set it back after the test with Yukon TZ
$OldTimeZone = Get-Timezone

#Try setting your time zone to Yukon using the $Yukon variable with the “ID” property
set-timezone -id $Yukon.ID -PassThru

#Set your Time Zone back to what it was
set-timezone $OldTimeZone -PassThru

#Now try setting Yukon TZ using the $Yukon variable again but this time with the “Standard Name” property
set-timezone -name $Yukon.StandardName -PassThru

#Set your Time Zone back to what it was again
set-timezone $OldTimeZone -PassThru

#Stop transcript
Stop-Transcript
