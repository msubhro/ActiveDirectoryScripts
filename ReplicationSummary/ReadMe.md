This script creates a folder with current date and stores the Replication summary report for the entire forest. It can also email the report.

Note: To get FULL replication report for all NTDS partitions, please use my another script under the "Full Replication Report" folder in this repository.

 
You can schedule this script through Windows Task Scheduler. Program / Script: Path of Powershell.exe  Argument: Script Path)

For Example: Program / Script: %SystemRoot%\syswow64\WindowsPowerShell\v1.0\powershell.exe

Argument: C:\ReplicationReport.ps1

 
 
The script has been prepared and tested in Powershell 4.0. So when you run this script, please make sure that the Powershell version is 4.0 or above.

Please run this script from a Domain Controller, or from a computer where Active Directory PowerShell module is installed.
 
Please test it before running it in production.

Use at your own Risk.
