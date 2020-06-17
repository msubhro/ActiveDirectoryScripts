By default, the "Get-ADComputer" cmdlet serches computer accounts only within the current domain. This makes it difficult to search computers within a multi domain forest. Using this script, you can search for computer accounts within an entire forest, be it single domain or multi domains.

You have to prepare an input file which will contain list of all computers. Those computers may be in different domains, but they have to be within the same forest where you are running the script.

If you do not give FQDN of computers, and if you have same computer name in multiple domains then you might get duplicate result. For example: in your input file you have mentioned a computer "server1", without any FQDN. The script will search for "Server1" in all domains within the forest. Now, if you have "Server1" in both Domain A and Domain B, the script will find both.

User PowerShell 4.0 or above.

Test before you use in production environment.

Use at your own risk.
