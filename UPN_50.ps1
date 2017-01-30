$logfile_UPN= "C:\KK\Logs\test_UPN_50.txt"
$test_file=Get-Content -Path C:\KK\20170112-PilotUsers.txt
function update_upn()
{
For($i=0; $i -lt 50;$i+=1)
{
if($i -eq 50)
{
Stop-Transcript
}
$test_mail=$test_file[$i].Split("@")
$id = $test_mail[0]
#Stores the ID
get-aduser $id
$test="$?"
#Validates the UPN
if($test -eq "True")
{
$test= "The UPN exists for $id"
Log($test)
#Logs the success of the validation
$test= get-aduser $id| Set-ADUser -UserPrincipalName "$id@xxx.com" -Verbose 2>&1
#Updates the UPN to @xxx.com
$check = "$?"
if($check -eq "True")
{
Log("The UPN successfully change for $id")
}
else
{
Log($test)
update_upn
}
}
}
}

function GetFullDate
{
		get-date -Format yyyyMMdd-HH:mm:ss
}

function Log([string]$Msg) 	
{ 
  $TimeStamp = GetFullDate
  $Msg = $TimeStamp+" - "+$Msg
  $Msg| out-file -Filepath $logfile_UPN -append
  #logs the $msg given to it in a file 
}
