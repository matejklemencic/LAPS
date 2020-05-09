<# 
.SYNOPSIS 
    Creates an interactive session with LAPS credentials.
     
.DESCRIPTION 
    The Connect-PS cmdlet gets local administrator password from Active Directory and creates an interactive session with a single remote computer. 
     
.PARAMETER ComputerName
    Name of the computer to create a RDP connection.

.PARAMETER UserName
    Specify a custom User Name. Default User Name is Administrator.


.NOTES 
    Name: Connect-PS
    Author: Matej Klemencic
    Version: 1.0 
    http://www.matej.guru
 
.EXAMPLE 
    Connect-PS -ComputerName Server01 
     
    Description 
    ----------- 
    This command gets local administrator password from Active Directory and creates an interactive session with default username Administrator.

.EXAMPLE 
    Connect-PS -ComputerName Server01 -UserName Hulk
     
    Description 
    ----------- 
    This command gets local administrator password from Active Directory and creates an interactive session with username Hulk.
#> 

function Connect-PS {

    param(
    
        [Parameter(Mandatory=$true)]
        [string]$ComputerName,

        [Parameter(Mandatory=$false)]
        [string]$UserName="Administrator"


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
                Write-Host "Connecting to $ComputerName..." -ForegroundColor Yellow
                $Password = ConvertTo-SecureString -AsPlainText -Force -String $AdmPwdPassword
                $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "$ComputerName\$UserName",$Password
                Enter-PSSession -ComputerName $ComputerName -Credential $Credential
            }
}