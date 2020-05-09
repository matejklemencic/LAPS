<# 
.SYNOPSIS 
    Creates a RDP connection with LAPS credentials.
     
.DESCRIPTION 
    The Connect-RDP cmdlet gets local administrator password from Active Directory and creates a RDP connection. 
     
.PARAMETER ComputerName
    Name of the computer to create a RDP connection.

.PARAMETER UserName
    Specify a custom User Name. Default User Name is Administrator.

.PARAMETER Port
    Specify a custom RDP port. Default port is 3389.

.NOTES 
    Name: Connect-RDP
    Author: Matej Klemencic
    Version: 1.0 
    http://www.matej.guru
 
.EXAMPLE 
    Connect-RDP -ComputerName Server01 
     
    Description 
    ----------- 
    This command gets local administrator password from Active Directory and creates a RDP connection with default username Administrator on port 3389.

.EXAMPLE 
    Connect-RDP -ComputerName Server01 -UserName Hulk -Port 43389
     
    Description 
    ----------- 
    This command gets local administrator password from Active Directory and creates a RDP connection with username Hulk on port 43389.
#> 

function Connect-RDP {

    param(
    
        [Parameter(Mandatory=$true)]
        [string]$ComputerName,

        [Parameter(Mandatory=$false)]
        [string]$UserName="Administrator",

        [Parameter(Mandatory=$false)]
        [int]$Port="3389"

    )
        Import-Module AdmPwd.PS -ErrorAction Stop
        $AdmPwdPassword = (Get-AdmPwdPassword -ComputerName $ComputerName).Password
        if ($AdmPwdPassword -eq $null)
            {
                $CurrentUser = whoami
                Write-Host "No password found for $ComputerName" -ForegroundColor Red
                Write-Host "- Check if computer $ComputerName is maneged by LAPS." -ForegroundColor Yellow
                Write-Host "- Check if user account $CurrentUser has permissions to read password for computer $ComputerName." -ForegroundColor Yellow
            }
        else
            {
                Write-Host "Adding credentials..." -ForegroundColor Yellow
                cmdkey /generic:TERMSRV/$ComputerName /user:$ComputerName\$UserName /pass:$AdmPwdPassword
                Write-Host "Connecting to $ComputerName..." -ForegroundColor Yellow
                mstsc /v:"$ComputerName":"$port"
                Write-Host "Removing stored credentials..." -ForegroundColor Yellow
                start-sleep -Seconds 1
                cmdkey /delete:TERMSRV/$ComputerName
            }
}