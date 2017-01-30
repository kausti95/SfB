$LICENSEOPTIONS = New-MsolLicenseOptions -AccountSkuId xxxltd:STANDARDPACK -DisabledPlans FLOW_O365_P1,POWERAPPS_O365_P1,PROJECTWORKMANAGEMENT,SWAY,YAMMER_ENTERPRISE,EXCHANGE_S_STANDARD
$cred = Get-Credential kkapoor
Import-Module MSOnline
Connect-MSolService -Credential $cred
$logfile_licences= "C:\KK\Logs\test_set_SP_licences_50.txt"
$test_file=Get-Content -Path C:\KK\20170112-PilotUsers.txt
function set_licences()
{
For($i=0; $i -lt 50;$i+=1)
{
if($i -eq 50)
{
Stop-Transcript
}
else
{
$test_mail=$test_file[$i].Split("@")
$id = $test_mail[0]
$test= Set-MsolUserLicense -UserPrincipalName "$id@xxx.com" -AddLicenses xxxltd:STANDARDPACK -LicenseOptions $LICENSEOPTIONS -verbose 2>&1
#Sets the Standard pack licence
$check= "$?"
if($check -eq "True")
{
Log("Standard Pack licence successfully set for user $id")
}
else
{
Log("Standard Pack licence set for user $id-Unsuccessful")
}
function GetFullDate
{
		get-date -Format yyyyMMdd-HH:mm:ss
}
function Log([string]$Msg) 	
{ 
  $TimeStamp = GetFullDate
  $LogString = $TimeStamp+" - "+$Msg
  write-host $LogString
  $LogString |out-file -Filepath $logfile_licences -append
  #logs the $msg given to it in a file 
}
