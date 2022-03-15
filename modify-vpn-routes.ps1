#Allow to execute script
Set-ExecutionPolicy RemoteSigned -Confirm:$false
#Fetching routes, saves IF and deletes routes
Get-NetRoute | Where-Object { $_.NextHop -match "10.*" } | % { $gw=$_.NextHop; $if=$_.InterfaceAlias; $_ | Remove-NetRoute -Confirm:$false }
#Adding permanent route 10.0.0.0/8 for IF
New-NetRoute -DestinationPrefix 10.0.0.0/8 -NextHop $gw -InterfaceAlias $if