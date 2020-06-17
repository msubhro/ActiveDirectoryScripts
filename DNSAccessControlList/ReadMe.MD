Using this script, you can set or remove ACL of multiple DNS records.

For this script to work, the DNS records should have corresponding computer accounts in Active Directory. Ex: If we are updaing ACL of server1, so there should be a computer account for server1 in AD.

You have to carefully put the value of $path, which is the path of the DNS Zone. In this script, it is assumed that example.org is an AD Integrated zone which is replicated Domain Wide. Please make sure $path value is opening in ADSI EDIT.

This script has been developed and tested in PowerShell 4.0.

Please test it before use.

Use at your own risk.

If you want to capture owners of multiple DNS records, please use my another script under "DNSRecordOwner" in this repository.
