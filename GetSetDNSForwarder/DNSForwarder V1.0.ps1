<# This script is created and tested by Subhro Majumder on 03-April-2017 #>


function Show-Menu

{

     
     cls
     Write-Host "=============================Welcome ================================="
     Write-Host "                   "
     
     Write-Host "Using this script , you can Get, Remove and Set DNS Forwarders for multiple DNS Servers."
     Write-Host "                 "
     Write-Host "The script has been prepared and tested in Powershell 4.0."
     Write-Host "                   "
     Write-Warning "The script is tested. But please test it before Using in Production Environment."
     Write-Host "                   "
     Write-Warning "Use at your Own Risk."

     Write-Host "                   "

     Write-Host "--------------------------------MENU----------------------------------------"
     Write-Host "                   "
     Write-Host "1: Press 1 to get the list of DNS Forwarders for all DNS Servers, from a given list."
     Write-Host "                   "
     Write-Host "2: Press 2 to Remove DNS Forwarders from all DNS Servers, from a given list."
     Write-Host "                   "
     Write-Host "3: Press 3 to edit DNS Forwarders of all DNS Servers, from a given list. This will overwrite existing Forwarder Configuration."
     Write-Host "                   "
     Write-Host "Q: Press 'Q' to quit this Program."
     Write-Host "                   "
     Write-Host "-----------------------------------------------------------------------------"
     Write-Host "                   "
}


function CheckDNSForwarders

{

$inputfile= Read-Host "Please enter the location of the input file. This should be a TXT file containing DNS Server list."

Write-Host "                   "

$outputfile= Read-Host "Please enter the location of the output file. The output file format would be CSV."

$DNSServerList= Get-Content -Path $inputfile

foreach ($DNSServer in $DNSServerList)

{

$forwarder=Get-WMIObject -Computer $DNSSERVER -Namespace "root\MicrosoftDNS" -Class "MicrosoftDNS_Server" | Select-Object @{label='DNS Server'; expression= {$_.PSComputerName}},@{label='Forwarders'; expression= {$_.Forwarders}} 

$forwarder

$forwarder | Export-Csv -Path $outputfile -NoTypeInformation -Append

}

}

function RemoveDNSForwarders

{


$inputfile= Read-Host "Please enter the location of the input file. This should be a CSV file containing DNS Server and Forwarder IP list. Please note that only those Forwarders would be removed which is mentioned in the input file. A sample file is provided with the script."

$inputlist=Import-Csv $inputfile

ForEach ($input in $inputlist)

{

$IP= $input.Forwarders -split ","

Remove-DnsServerForwarder -ComputerName $input.DNSServer -IPAddress $IP -Confirm


}

}


function SetDNSForwarders 

{

$inputfile= Read-Host "Please enter the location of the input file. This should be a CSV file containing DNS Server and Forwarder IP list. A sample file is provided with the script."

$inputlist=Import-Csv $inputfile

ForEach ($input in $inputlist)

{

$IP= $input.Forwarders -split ","

Set-DnsServerForwarder -ComputerName $input.DNSServer -IPAddress $IP -Confirm


}

}

do
{
Show-Menu

$input = Read-Host "Please make a selection"


switch ($input)
     {
           '1' {

                cls

                'You have selected option #1: Check DNS Forwarders.'
                
                 Write-Host "                   "
                 
                 CheckDNSForwarders


                }

 
            '2' {

                cls

                'You have selected option #2: Remove DNS Forwarders.'

                 Write-Host "                   "
                
                 RemoveDNSForwarders


                }


             '3' {

                cls

                'You have selected option #3: Set DNS Forwarders.'

                 Write-Host "                   "

                 Write-Warning " It will NOT be appended with current Forwarder settings. This will overwrite current Forwarder settings, if any."
                
                 Write-Host "                   "
                 
                 SetDNSForwarders


                }


             'q' {

                return
                 }
     } 
     pause
}
until ($input -eq 'q')












