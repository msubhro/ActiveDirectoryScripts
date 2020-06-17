<# This script is created and tested by Subhro Majumder on 01-April-2017 #>


function Show-Menu

{

     
     cls
     Write-Host "=============================Welcome ================================="
     Write-Host "                   "
     
     Write-Host "Using this script , you can Check, Enable and Disable OU Accidental Deletion Protection."
     Write-Host "                 "
     Write-Host "This script only operates on Organizational Units, not Containers."
     Write-Host "                 "
     Write-Host "The script has been prepared and tested in Powershell 4.0."
     Write-Host "                   "
     Write-Host "The script is tested. But please test it before Using in Production Environment."
     Write-Host "                   "
     Write-Host "Use at your Own Risk."

     Write-Host "                   "

     Write-Host "--------------MENU----------------"
     Write-Host "                   "
     Write-Host "1: Press 1 to get the Status of OU Accidental Deletion Protection for all OUs in current Domain."
     Write-Host "                   "
     Write-Host "2: Press 2 to enable OU Accidental Deletion Protection."
     Write-Host "                   "
     Write-Host "3: Press 3 to disable OU Accidental Deletion Protection."
     Write-Host "                   "
     Write-Host "Q: Press 'Q' to quit this Program."
     Write-Host "                   "
     Write-Host "----------------------------------"
     Write-Host "                   "
}

Write-Host "                   "


function CheckStatus

{

$Path= Read-Host "Please enter the Output file path. The output file format will be CSV."
$Result= Get-ADOrganizationalUnit -Filter * -Properties *| Select-Object CanonicalName,DistinguishedName,ProtectedFromAccidentalDeletion
$Result | Export-Csv -Path $Path -NoTypeInformation

}

function EnableProtection
{

$Path= Read-Host "Please enter the Input file path with OU List. File Format: TXT. Use Canonical Format. Ex: OU=OU1,DC=Domain Name,DC=Domain Name"

Get-Content -Path $Path | Set-ADOrganizationalUnit -ProtectedFromAccidentalDeletion $True

}

function DisableProtection
{

$Path= Read-Host "Please enter the Input file path with OU List. File Format: TXT. Use Canonical Format. Ex: OU=OU1,DC=Domain Name,DC=Domain Name"

Get-Content -Path $Path | Set-ADOrganizationalUnit -ProtectedFromAccidentalDeletion $False

}


do
{
Show-Menu

$input = Read-Host "Please make a selection"


switch ($input)
     {
           '1' {

                cls

                'You have selected option #1'
                
                 Write-Host "                   "
                 
                 CheckStatus


                }

 
            '2' {

                cls

                'You have selected option #2'

                  Write-Host "                   "
                
                 EnableProtection


                }


             '3' {

                cls

                'You have selected option #3'
                
                 Write-Host "                   "
                 
                 DisableProtection


                }


             'q' {

                return
                 }
     } 
     pause
}
until ($input -eq 'q')




