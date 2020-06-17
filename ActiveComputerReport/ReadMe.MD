
This script takes the list of searchbases from a text file, and generate a list of all Active Computers which are available on those given searchbases. Searchbases are typically Organizational Units or sub OUs. Use Distinguished Name in the input file.

Ex: OU=Servers,DC=subhro,DC=com

    OU= Exchange Servers,DC=subhro,DC=com

You can also search in the entire domain.

You can also change the search criteria , by changing the value of "$DaysInactive " variable.

Ex: if the value is 30, the result will exclude those computers which did not log on within last 30 days.


Use Powershell 4.0 or higer version.

Test before you use, and use at your own risk.
