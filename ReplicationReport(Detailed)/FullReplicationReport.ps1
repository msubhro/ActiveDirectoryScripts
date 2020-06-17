
$date=Get-Date

$date1= $date.ToString("dd-MM-yyyy")+ "-"+$date.ToString("HH-mm-ss")

$path= "D:\FullReplication"

$directory= New-Item -ItemType directory -Path "$path\$date1"

$Report= repadmin /showrepl * /csv > $directory\ReplicationFullReport.csv

$File= "$directory\ReplicationFullReport.csv"

$bodyText=
@'

Hi Team,

Please find attached the Full AD Replication Report for the entire Forest.

This is an auto generated mail. Please do not reply.


Regards,
IT Team

'@

#Email Configuration
       
#SMTP server name

$smtpServer = <SMTP Server Name>

#Creating a Mail object

$msg = new-object Net.Mail.MailMessage

#Creating SMTP server object

$smtp = new-object Net.Mail.SmtpClient($smtpServer)

#Email structure

$msg.From = <Server Name where this script is runng>
$msg.To.Add("Recipient Email-address/ DL")
$msg.To.Add("Recipient Email-address / DL")
$msg.subject = "AD Replication FULL Report: Entire Forest"
$msg.body = $bodyText
       
$att = new-object Net.Mail.Attachment($File)

$msg.Attachments.Add($att) 
   
#Sending email

$smtp.Send($msg) 