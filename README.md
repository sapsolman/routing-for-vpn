# routing-for-vpn
This PowerShell script will clean up your Windows routing table and re-create it again as it should.

Preparation (to do it once):
1. Make sure you have Windows PowerShell installed;
2. Clone this entire repository or just download a "modify-vpn-routes.ps1" script;
3. Launching PowerShell:
- Select "Start" -> type "Windows PowerShell" select Windows PowerShell and Run it;
- To be able to run "RemoteSigned" content type "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser" and press Enter;
- Type "A" and press Enter.

Changing routing:
1. Establish a VPN connection (preferred External);
2. Run script "modify-vpn-routes.ps1":
- In File Explorer (or Windows Explorer), right-click the script file name and then select "Run with PowerShell";
3. Make sure your Internet connection and Internal resources are available;

Every time you re-establish a VPN connection, you need to repeat steps 2-3 from the "Changing routing" block.
