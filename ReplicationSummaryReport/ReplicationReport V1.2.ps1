<# This script creates a folder for current date and stores the Replication summary report for the entire forest. It also emails the Replication Report. #>

<# You can schedule this script through Windows Task Scheduler. Program / Script: Path of Powershell.exe  Argument: Script Path) #>

<# The script has been prepared and tested in Powershell 4.0. So when you run this script, please make sure that the Powershell version is 4.0 or above. #>

<# Please run this script from a Domain Controller. #>

<# Please test it before running it in production. #>

<# Use at your own Risk.#>

$date=Get-Date

$date1= $date.ToString("dd-MM-yyyy")+ "-"+$date.ToString("HH-mm-ss")

$path= "C:\Replication Report"

$directory= New-Item -ItemType directory -Path "$path\$date1"

$Report= repadmin /replsummary /bysrc /bydest /sort:delta > $directory\ReplicationReport.txt


<# Please modify the body text as per your requirement.#>

$bodyText=
@'

Hi Team,

Please find attached the AD Replication Summary Report for the entire Forest.

This is an auto generated mail. Please do not reply.


Regards,
IT Team

'@


       
# Please enter SMTP server name

$smtpServer = <SMTP Server Name>

#Creating a Mail object
$msg = new-object Net.Mail.MailMessage

#Creating SMTP server object
$smtp = new-object Net.Mail.SmtpClient($smtpServer)

#Email structure
$msg.From = <Server Name where this script is runng> # This should be in email address format.

$msg.To.Add("Recipient Email-address/ DL")  # Please add Recepient Email Address / DL

$msg.To.Add("Recipient Email-address / DL")  # Please add additional Recepient Email Address / DL

$msg.subject = "AD Replication FULL Report: Entire Forest"

$msg.body = $bodyText
       
$att = new-object Net.Mail.Attachment($Report) # The Replication Report is being attached here

$msg.Attachments.Add($att) 
   
#Sending email

$smtp.Send($msg) 