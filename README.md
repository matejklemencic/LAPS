Use PowerShell to create an interactive session or RDP connection to a remote computer with LAPS credentials. 

# How to Install?

- Install LAPS PowerShell module AdmPwd.PS on your management computer. 
- Copy the **RDPviaLAPS** and/or **PSviaLAPS** folder to *C:\Program Files\WindowsPowerShell\Modules.*
- Run PowerShell with a domain user account that has LAPS read password permissions.  

# How to use Connect-RDP
Connect-RDP cmdlet creates an RDP session with LAPS credentials. 

###### Example 1
`Connect-RDP -ComputerName Server01`

*This command gets local administrator password from Active Directory and creates a RDP connection with default username Administrator on port 3389.*

###### Example 2
`Connect-RDP -ComputerName Server01 -UserName Hulk -Port 43389`

*This command gets local administrator password from Active Directory and creates a RDP connection with username Hulk on port 43389.*

# How to use Connect-PS
Connect-PS cmdlet creates an interactive session with LAPS credentials.

###### Example 1
`Connect-PS -ComputerName Server01`

*This command gets local administrator password from Active Directory and creates an interactive session with default username Administrator.*

###### Example 2
`Connect-PS -ComputerName Server01 -UserName Hulk`

*This command gets local administrator password from Active Directory and creates an interactive session with username Hulk.*
