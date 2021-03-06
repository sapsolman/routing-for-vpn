#Fetching active routes and its interfaces, then removes
Get-NetRoute | Where-Object { $_.NextHop -match "10.*" } | % { $gw=$_.NextHop; $if=$_.InterfaceAlias; $_ | Remove-NetRoute -Confirm:$false }
#Create the new one 10.0.0.0/8 with active interface
New-NetRoute -DestinationPrefix 10.0.0.0/8 -NextHop $gw -InterfaceAlias $if
