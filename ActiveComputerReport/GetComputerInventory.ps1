
# Specify the input file location. This shoudl contain list of OUs where you want to run the search.Use Distinguished Name.

# You can also search in the entire domain.


$SearchBaseList= get-content -Path "C:\input\list.txt"

# Specify the selection criteria. Ex: if the value is 30, the result will exclude those computers which did not log on within last 30 days.

$DaysInactive = 30 

$time = (Get-Date).Adddays(-($DaysInactive))

foreach ($SearchBase in $SearchBaseList )

{ 

$details= Get-ADComputer -SearchBase $SearchBase -Filter {LastLogonTimeStamp -gt $time} -Properties *
 

$details | select-object Name,OperatingSystem,CanonicalName,@{Name="Last Logon Time";Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp)}},IPv4Address,PasswordLastSet | export-csv c:\input\ServerList.csv -notypeinformation -Append

}