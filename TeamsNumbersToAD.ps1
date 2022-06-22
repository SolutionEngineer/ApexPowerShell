#	Teams Numbers to AD
#	2022-06-20
#	Apex Digital Script

function Show-Menu {
    param (
        [string]$Title = 'My Menu'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Press '1' to connect to MS Teams."
    Write-Host "2: Press '2' to retrive users with phone numbers."
	Write-Host "3: Press '3' to display users."
    Write-Host "4: Press '4' to update AD users with numbers."
    Write-Host "Q: Press 'Q' to quit."
}

$Users = ''

do
 {
    Show-Menu
    $selection = Read-Host "Please make a selection"
    switch ($selection)
    {
    '1' {
		# Connect to MSOL
		Connect-MicrosoftTeams
    } '2' {
		# Select Users with Teams Nummbers
		$users = Get-CsOnlineUser | Where-Object {$_.LineUri -notlike $Null} | select UserPrincipalName, LineURI
		#$Users.replace('tel:+','')
	} '3' {
		#Write-Host $users
		Foreach ($user in $users) {
			Write-Host $user.UserPrincipalName ',' $user.LineURI.replace('tel:+','')
			
		}
	} '4' {
		Foreach ($user in $users) {
			Set-ADUser -Identity $user.UserPrincipalName -telephonenumber $user.LineURI.replace('tel:+','')
		}
	}
	}
pause
 }
 until ($selection -eq 'q')
 