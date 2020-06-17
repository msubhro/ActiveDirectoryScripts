Domain Controllers act as time source for member servers and workstaions. Therefore, it is important that all Domain Controllers maintain correct time and there is minimum time difference bewteen Domain Controllers in a Domain.

This PowerShell script performs following tasks:

1) Captures Time Skew Report for all Domain Controllers within a Domain.

2) Create date wise folder and stores the report as a text file.

3) Emails the report.


You need to customize the script for your environment.

Note: This script does not compare Domain Controller time with any external clock. This script only generates Time Skew Report for all Domain Controllers within a Domain.

 
For best result, please incorporate the script with Windows Task Scheduler, so that the script runs at a certain interval (Ex: Weekly once).

This script has been developed and tested in PowerShell 4.0

Please test before use.

Use at your own risk.
