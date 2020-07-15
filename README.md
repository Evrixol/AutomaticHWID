Get-HardwareID
======

#### Ignore the name of this branch. It's not made by a group of people. Just little old me.

Description
------
This script will gather the internal windows product identity and place it in a file with the name of the twelve digit serial number located inside of the file. 

How it do
------
Using [NuGet](https://www.nuget.org/) download [Get-WindowsAutoPilotInfo](https://www.powershellgallery.com/packages/Get-WindowsAutoPilotInfo/2.5) from [PSGallery](https://www.powershellgallery.com/).

Using [Get-WindowsAutoPilotInfo](https://www.powershellgallery.com/packages/Get-WindowsAutoPilotInfo/2.5) gather the internal PKID and output to a file in a seperate directory. 

Gather the internal twelve digit numerical code located inside of the file and rename the file to said code.

Then futz off to next week. 