$LICENSEOPTIONS = New-MsolLicenseOptions -AccountSkuId xxxltd:STANDARDPACK -DisabledPlans FLOW_O365_P1,POWERAPPS_O365_P1,PROJECTWORKMANAGEMENT,SWAY,YAMMER_ENTERPRISE,EXCHANGE_S_STANDARD
$cred = Get-Credential kkapoor
Import-Module MSOnline
Connect-MSolService -Credential $cred
$logfile_switch= "C:\KK\Logs\test_move_50.txt"
$test_file=Get-Content -Path C:\KK\20170112-PilotUsers.txt
function set_licences_MK()
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
$test= move-csuser -identity "$id@xxx.com" -Target sipfed.online.xxx.com -Credential $Cred -HostedmigrationOverrideUrl https://adminca1.online.lync.com/HostedMigration/hostedmigrationservice.svc -confirm:$false -verbose 2>> "C:\KK\Logs\test_move_50.txt"
#Switches to SfB
$check= "$?"
if($check -eq "True")
{
Log("Switch was successful user $id")
}
else
{
Log("Switch for user $id-Unsuccessful")
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
  $LogString | out-file -Filepath $logfile_switch -append
  #logs the $msg given to it in a file 
}
