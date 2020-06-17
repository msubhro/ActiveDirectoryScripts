<# This script is created and tested by Subhro Majumder on 04-June-2018 #>

<# For this script to work, the DNS records should have corresponding computer accounts in AD. Ex: If we are updaing ACL of server1, so there should be a computer account for server1 in AD. #>

<# You have to carefully put the value of $path, which is the path of the DNS Zone. In this script, it is assumed that example.org is an AD Integrated zone which is replicated Domain Wide. Please make sure $path value is opening in ADSI EDIT. #>


function Show-Menu

{

     
     cls
     Write-Host "=============================Welcome ================================="
     Write-Host "                   "
     
     Write-Host "Using this script , you can Set or Remove entries in DNS ACL."
     Write-Host "                 "
     Write-Host "The script has been prepared and tested in Powershell 4.0."
     Write-Host "                   "
     Write-Warning "The script is tested. But please test it before Using in Production Environment."
     Write-Host "                   "
     Write-Warning "Use at your Own Risk."

     Write-Host "                   "

     Write-Host "--------------------------------MENU----------------------------------------"
     Write-Host "                   "
     Write-Host "1: Press 1 to add entries in DNS ACL."
     Write-Host "                   "
     Write-Host "2: Press 2 to Remove entries from DNS ACL."
     Write-Host "                   "
     Write-Host "Q: Press 'Q' to quit this Program."
     Write-Host "                   "
     Write-Host "-----------------------------------------------------------------------------"
     Write-Host "                   "
}


function SetDNSACL

{

Import-Module ActiveDirectory

#$ErrorActionPreference = 'SilentlyContinue'

$inputpath= Read-Host "Please enter the location of the input file. This should be a TXT file containing list of entries that needs to be added to the ACL."

$outputpath= Read-Host "Please enter the location of the error log file. This should be a TXT file. Ex: c:\temp\ErrorLog.txt"

$computerlist= Get-Content -Path $inputpath



foreach ($computer in $computerlist)

{

$Sid = (Get-ADComputer -Identity $computer -Properties *).SID

If($? -eq $true)

{


}

else

{

$failure= "The computer object $computer is not found.No change has been made in the ACL."

out-file -FilePath $outputpath -InputObject $failure -Append

}



<# You have to carefully put the value of $path, which is the path of the DNS Zone. In this script, it is assumed that example.org is an AD Integrated zone which is replicated Domain Wide. Please make sure $path value is opening in ADSI EDIT. #>

$path= "ActiveDirectory:://RootDSE/DC=$computer,DC=example.org,CN=MicrosoftDNS,DC=DomainDnsZones,DC=example,DC=org"

<# Access Rule "GenericAll" means "Full Control". #>

$AccessRule = New-Object System.DirectoryServices.ActiveDirectoryAccessRule($Sid,"GenericAll","Allow")

$Acl = Get-Acl -Path $path

$Acl.AddAccessRule($AccessRule)

Set-Acl -Path $path -AclObject $Acl


}



}


function RemoveDNSACL

{
Import-Module ActiveDirectory

#$ErrorActionPreference = 'SilentlyContinue'

$inputpath= Read-Host "Please enter the location of the input file. This should be a TXT file containing list of entries that needs to be removed from ACL."

$outputpath= Read-Host "Please enter the location of the error log file. This should be a TXT file. Ex: c:\temp\ErrorLog.txt"

$computerlist= Get-Content -Path $inputpath


foreach ($computer in $computerlist)

{

$Sid = (Get-ADComputer -Identity $computer -Properties *).SID


If($? -eq $true)

{


}

else

{

$failure= "The computer object $computer is not found.No change has been made in the ACL."

out-file -FilePath $outputpath -InputObject $failure -Append

}



<# You have to carefully put the value of $path, which is the path of the DNS Zone. In this script, it is assumed that example.org is an AD Integrated zone which is replicated Domain Wide. Please make sure $path value is opening in ADSI EDIT. #>

$path= "ActiveDirectory:://RootDSE/DC=$computer,DC=example.org,CN=MicrosoftDNS,DC=DomainDnsZones,DC=example,DC=org"

$AccessRule = New-Object System.DirectoryServices.ActiveDirectoryAccessRule($Sid,"GenericAll","Allow")

$Acl = Get-Acl -Path $path

$Acl.RemoveAccessRule($AccessRule)

Set-Acl -Path $path -AclObject $Acl


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

                'You have selected option #1: Add Entry in DNS ACL.'
                
                 Write-Host "                   "
                 
                 SetDNSACL


                }

 
            '2' {

                cls

                'You have selected option #2: Remove Entry from DNS ACL.'

                 Write-Host "                   "
                
                 RemoveDNSACL


                }



             'q' {

                return
                 }
     } 
     pause
}
until ($input -eq 'q')