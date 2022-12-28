#Get Execution Policy for Current User and set it for accepting "RemoteSigned" into a Current User scope
$ExecPolicy = Get-ExecutionPolicy -Scope CurrentUser
if ( $ExecPolicy -ne "RemoteSigned" )
{
	Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Confirm:$false
}

#Fetching active routes and its interfaces, then removes
Get-NetRoute | Where-Object { $_.NextHop -match "10.*" -and $_.DestinationPrefix -notmatch "127.0.0.*" -and $_.DestinationPrefix -notmatch "0.0.0.0/0"} | % { $gw = $_.NextHop; $if = $_.InterfaceAlias; $_ | Remove-NetRoute -Confirm:$false }

#Create the new one 10.0.0.0/8 with active interface
New-NetRoute -DestinationPrefix 10.0.0.0/8 -NextHop $gw -InterfaceAlias $if

#Check your DNSs config and route some queries
#Under construction