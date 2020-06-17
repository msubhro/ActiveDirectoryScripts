<# Welcome to MultiDCDiag V 1.0! This Script is prepared by Subhro Majumder.#>

<# The script has been prepared and tested in Powershell 4.0. So when you run this script, please make sure that the Powershell version is 4.0 or above. #>

<# The script takes the DC list as an input and stores the result in an output folder. #>

<# Seperate text file will be generated for each Domain Controller#>

<# While this script has been tested multiple times, I recommend that you test it in a test environment before using it in a production environment. #>

<# While every attempt has been made to make this script error free, I will not take any responsibilty for any consequence that would happen while running the script.#>


function Show-Menu

{


     param (
           [string]$Title = 'Welcome to MultiDCDiag V 1.0! Perform Health Check of multiple DCs and store the Result'
            )
     cls
     Write-Host "=====$Title ====="
     
     Write-Host "         "

     Write-Host "This script takes the DC list as an input and stores the result in an output folder."
     
     Write-Host "         "

     Write-Host "Separate text file will be generated for each Domain Controller."
     
     Write-Host "         "

     Write-Host "The script has been prepared and tested in Powershell 4.0. So when you run this script, please make sure that the Powershell version is 4.0 or above."

     
     Write-Host "         "

     Write-Host "============================================================================================="

     
     Write-Host "         "

}


Show-Menu

$inputpath = Read-Host "Please enter the location of the input file (This text file should contain list of Domain Controllers)"

Write-Host "         "

$outputpath = Read-Host "Please enter the location of the output folder (This is where Health Check Reports will be stored. The output folder should be created in advanced in the location which you mention)"

Write-Host "         "

$ComputerName1 = get-content $inputpath

$ErrorActionPreference='SilentlyContinue'


foreach ($computername in $computername1) {

if (test-Connection -ComputerName $computername -Count 2 -Quiet )

{

$outfile=Invoke-Command -scriptblock {dcdiag}  -ComputerName $computername


New-Item $outputpath\$computername.txt -type file

Add-Content $outputpath\$computername.txt $outfile

}

else
					
{ Write-Warning "Unable to contact $computername"
			
}	

}

