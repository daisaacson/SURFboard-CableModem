# SURFboard-CableModem
PowerShell Module to parse SURFboard cable modem pages

Pages, Tables and Content are returned as HashTables

I included a script, ```SurfBoard-Log.ps1```, I'm using to log cable modem information to a log file (via Scheduled Task) while troubleshooting Internet outages.

I've only tested this on SB6120

## Instalation
Install the ```SURFboard-CableModem``` to a PowerShell modules directory.  Optionaly save anywhere and import using the path to the directory, ```Import-Module .\Path\to\SURFboard-CableModem```

## Functions
Here are a list of **Functions** available and the function *alias*

* **Get-SurfBoard** *gsb*

    Get all tables on all pages
  
  * **Get-SurfBoardIndexData** *gsbid*

    Get all tables on Index Page
  
    * **Get-SurfBoardTask** *gsbt*

      Get Tasks table on Index Page

    * **Get-SurfBoardOperation** *gsbo*

      Get Operation table on Index Page

  * **Get-SurfBoardSignalData** *gsbsd*

    Get all tables on Signal Page

    * **Get-SurfBoardDownStream** *gsbds*

      Get DownStream table on Signal Page
    
    * **Get-SurfBoardUpStream** *gsbus*

      Get UpStream table on Signal Page
    
    * **Get-SurfBoardSignalStatus** *gsbss*

      Get SignalStatus table on Signal Page

  * **Get-SurfBoardAddressData** *gsbad*

    Get all tables on Address Page

    * **Get-SurfBoardAddress** *gsba*

      Get Address table on Address Page

    * **Get-SurfBoardMac** *gsbm*

      Get MAC table from Address Page

  * **Get-SurfBoardConfigData** *gsbcd*

    Get all tables on Config Page

    * **Get-SurfBoardConfig** *gsbc*

      Get Config table on Config Page

  * **Get-SurfBoardLogsData** *gsbld*

    Get all tables on Logs Page

    * **Get-SurfBoardLogs** *gsbl*

      Get Logs table on Logs Page

  * **Get-SurfBoardOpenSourceData** *gsbosd*

    Get all tables on Open Source Page

    * **Get-SurfBoardOpenSource** *gsbos*

      Get Open Source table on Open Source Page

  * **Get-SurfBoardHelpData** *gsbhd*

    Get all tables on Help Page

    * **Get-SurfBoardHelp** *gsbh*

      Get Help table on Help Page

* **Get-SurfBoardBootTime** *gsbbt*

  Calcuate the boot time from the current time - uptime

* **Get-SurfBoardForwardErrorCorrection** *gsbfec*

  Calculate FEC % for all channels and each individual channel

## Parameters
By default ```192.168.100.1``` is used for connections. To override, use the ```-ComputerName``` parameter. Parameter aliases *```-CN```,```-SurfBoard```,```-SB```*

Pipelining is supported

## Examles
```
# Import the module
Import-Module SURFboard-CableModem

# Run commands
Get-SurfBoard -ComputerName 192.168.100.1 | ConvertTo-Json -Depth 5

# Get Uptime from multiple modems
$( @("192.168.100.1", "modem.local") | Get-SurfBoardOperation ).'System Up Time'

```
