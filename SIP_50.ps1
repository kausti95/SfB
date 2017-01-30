$logfile_SIP= "C:\KK\Logs\test_SIP_50.txt"
$test_file=Get-Content -Path C:\KK\20170112-PilotUsers.txt
function update_sip()
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
get-csuser $id
$test="$?"
#Validates the SIP
if($test -eq "True")
{
$test= "The SIP exists for $id"
Log($test)
#Logs the success of the validation
$test= get-csuser $id| Set-CsUser -SipAddress "sip:$id@xxx.com" -Verbose 2>&1
#Updates the UPN to @xxx.com
$check = "$?"
if($check -eq "True")
{
Log("The SIP successfully change for $id")
}
else
{
Log("The SIP change for $id- Unsuccessful")
update_sip
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
  $Msg| out-file -Filepath $logfile_SIP -append
  #logs the $msg given to it in a file 
}
