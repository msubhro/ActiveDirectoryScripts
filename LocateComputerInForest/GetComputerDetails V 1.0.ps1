Write-Host "  "
 
$inputpath= Read-host "Enter the path of the input file. It shoudl be a TXT file."
 
Write-Host "  "

$outputpath= Read-host "Enter the path of the output file. It shoudl be a CSV file."

Write-Host "  "

$ErrorActionPreference = 'silentlycontinue '

$domains = (Get-ADForest).Domains

foreach ($domain in $domains)


{

$output= Get-Content -Path $inputpath | Get-ADComputer -Server $domain -Properties * | Select-Object Name,DistinguishedName,DNSHostName,OperatingSystem,IPv4Address,CanonicalName

$output | ft *

$output | export-csv -Path $outputpath -NoTypeInformation -Append
}