########### Beginnning of Main Menu #########

function Show-Menu

{


     param (
           [string]$Title = 'Welcome to the PowerGroup V1.0 !'
     )
     cls
     Write-Host "=====$Title ====="
     Write-Host "                   "
     
     Write-Host "Using this script , you can get account expiry dates for multiple users and also extend it."
     Write-Host "                   "
     Write-Host "While getting account expiry dates, you have to provide Distinguished Name of the OUs in the input file."
     Write-Host "   "
     Write-Host "The script has been prepared and tested in Powershell 4.0. So when you run this script, please make sure that the Powershell version is 4.0 or above."
     Write-Host "                   "
     Write-Host "Test before you use in production."
     Write-Host "                   "
     Write-Host "Use at your own Risk."

     Write-Host "                   "

     Write-Host "--------------MENU----------------"
     Write-Host "                   "
     Write-Host "1: Press 1 to get Account Expiry Date."
     Write-Host "                   "
     Write-Host "2: Press 2 to set Account Expiry Date."
     Write-Host "                   "
     Write-Host "Q: Press Q to quit this Program."
     Write-Host "----------------------------------"
     Write-Host "                   "

}


########### End of Main Menu #########


########### Beginning of the function get expired account #########

function ExpiredADAccount 

{

Write-Host "                   "

$inputpath=Read-Host ("Enter the location of the input file. It should be a text file containing OU Distingished Names where user accounts are located.")

Write-Host "                   "

Write-Warning ("When you specify an OU, sub OU's would be automatically included. No need to mention separately.")

Write-Host "                   "

$outputpath=Read-Host ("Enter the location of the output file. It should be a CSV file.")

Write-Host "                   "

$SearchBaseList= get-content -Path $inputpath

foreach ($SearchBase in $SearchBaseList )

{

$list=get-aduser -SearchBase $SearchBase -Filter * -Properties *|Select-Object SamAccountName,GivenName,Surname,Enabled,AccountExpirationDate

$list

$list | export-csv -Path $outputpath -NoTypeInformation

}

}

########### End of the function get expired account #########


########### Beginning of the function set expired account #########


function ExtendAccount


{

Write-Host "                   "

$path=Read-Host ("Enter the location of the input file. It should be a text file containing account list.")

$userlist= Get-Content -Path $path

Write-Host "                   "

$date= Read-Host ("Enter the date to which you need to extend the accounts.Date Format:MM/DD/YYYY")

foreach ($user in $userlist )

{

Set-ADAccountExpiration $user -DateTime "$date"

}

}

########### End of the function set expired account #########

########### Beginnning of Sub Menus and Function Execution #########

do
{
     Show-Menu
     $input = Read-Host "Please make a selection."
     switch ($input)
     {
           '1' {
                cls
                'You have selected option #1: Get Account Expiry Date.'
                 Write-host "               "
                 ExpiredADAccount

                  } 
           
           '2' {
                cls
                'You have selected option #2: Extend Account Expiry Date.'
                 
                 Write-host "               "
                 
                 ExtendAccount
                }
           
      

          
           'q' {
                return
               }
     }
     pause
}
until ($input -eq 'q')


########### End of Sub Menus and Function Execution #########