


function Show-Menu

{

     
     cls
     Write-Host "=============================Welcome ================================="
     Write-Host "                   "
     
     Write-Host "Using this script , you can Get and Set preferred DNS Server's IP in multiple systems."
     Write-Host "                 "
     Write-Host "The script has been prepared and tested in Powershell 4.0."
     Write-Host "                   "
     Write-Warning "The script is tested. But please test it before Using in Production Environment."
     Write-Host "                   "
     Write-Warning "Use at your Own Risk."

     Write-Host "                   "

     Write-Host "--------------------------------MENU----------------------------------------"
     Write-Host "                   "
     Write-Host "1: Press 1 to get the list of Prefered DNS Servers for a given list."
     Write-Host "                   "
     Write-Host "2: Press 2 to set the list of Prefered DNS Servers for a given list."
     Write-Host "                   "
     Write-Host "Q: Press 'Q' to quit this Program."
     Write-Host "                   "
     Write-Host "-----------------------------------------------------------------------------"
     Write-Host "                   "
}


function CheckDNSServer

{

$inputpath= Read-Host "Please enter the location of the input file. This should be a TXT file containing list of systems."

$Serverlist = get-content -Path $inputpath

Write-Host "                   "
     
$path= Read-Host "Please enter the location of the output file. The output file format will be in CSV."
 
foreach ($Server in $ServerList)
 
{
 
$config= Get-WmiObject -Computer $Server -class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE | Select-Object @{label='Server';expression= {$_.PSComputerName}},@{label='DNSServer'; expression= {$_.DNSServerSearchOrder}},@{label='DHCPEnabled'; expression= {$_.DHCPEnabled}}
 
$config
 
$config | Export-Csv -Path $path -NoTypeInformation -Append
 
}

}


function UpdateDNSServer

{


$inputfile= Read-Host "Please enter the location of the input file. This should be a CSV file containing Server and DNS IP list. Seperate multiple IPs by a comma."

$inputlist=Import-Csv $inputfile


ForEach ($input in $inputlist)

{

$NIC = Get-WMIObject Win32_NetworkAdapterConfiguration -computername $input.Server |where{$_.IPEnabled -eq “TRUE”}

$DNSServers= $input.DNSServer -split ","

$NIC.SetDNSServerSearchOrder($DNSServers)

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

                'You have selected option #1: Check Preferred DNS Server List.'
                
                 Write-Host "                   "
                 
                 CheckDNSServer


                }

 
            '2' {

                cls

                'You have selected option #2: Set Preferred DNS Server List.'

                 Write-Host "                   "
                
                 UpdateDNSServer


                }



             'q' {

                return
                 }
     } 
     pause
}
until ($input -eq 'q')