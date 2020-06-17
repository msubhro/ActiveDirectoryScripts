<# In this script, we will capture the owner of some DNS Host Records which belong to the zone subhro.org. We will then export the result to a CSV file.#>

<# This script will only work for Active Directory Integrated DNS Zones. #>


Import-Module ActiveDirectory

# Export DNS Zone in a text file, and keep only the record name (Without FQDN) as input file.

$DNSEntries = Get-Content -Path "C:\input\input.txt"

ForEach ($Entry in $DNSEntries)

{

# Here we will capture the owner of DNS Records which belong to the zone subhro.org. Please substitute this with your zone name, as per the below format.

# If the Zone is forest wide replicated, please substitute "DC=DomainDnsZones" with "DC=ForestDnsZones"

# The section: "ActiveDirectory:://RootDSE/DC=$Entry" should remain as it is.Please Do not make any change on that part.
	
$ACL= Get-Acl -Path "ActiveDirectory:://RootDSE/DC=$Entry,DC=subhro.org,CN=MicrosoftDNS,DC=DomainDnsZones,DC=subhro,DC=org" | Select-Object @{label='Record';expression= {$Entry}},@{label='Owner'; expression= {$_.Owner}}


# For PTR Records, please follow below format.In the below example, we have captured owner for the PTR zone 192.168.2.

# The input file for PTR should contain only the host part of the record.Ex: For the PTR Record 192.168.2.3 in the above zone, the input file should only contain the value 3.

# $ACL= Get-Acl -Path "ActiveDirectory:://RootDSE/DC=$Entry,DC=2.168.192.in-addr.arpa,CN=MicrosoftDNS,DC=DomainDnsZones,DC=subhro,DC=org" | Select-Object @{label='Record';expression= {$Entry}},@{label='Owner'; expression= {$_.Owner}}


# Location of the output file. The output file format will be CSV.

$ACL | export-csv -Path "C:\input\ACL.CSV" -NoTypeInformation -Append

}

