This Script generates replication report for the entire forest and export the result in a CSV file. It includes replication status for each NTDS partition for each Domain Controller within a forest.

For Replication Summary Report, please refer my another script under the "replicationSummary" folder in this repository.

Filter the result with "Status Code" column. If Replication is successful for that partition, the status code would be zero (0). Any non zero value in Staus Code filed indicates replication error in that partition and needs to be investigated.

The script also emails the result to specified email addresses or DLs.

For optimum result, please incorporate the script with Windows Task Scheduler and schedule it to run on a daily basis.
You need to do some modification based on your environment.

This script has been developed and tested in PowerShell 4.0.

Please test it before use.

Use at your own risk.
