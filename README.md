AutomaticHWID
======

#### Confirm-NuGet
* Ensure that package provider NuGet is installed to minimum version listed in config.json.
  * If NuGet isn't installed, then install with required version listed in config.json.
  * If NuGet is installed, check if version number is greater than or equal to required version. 
  * If previous case is false, update to minimum required version listed in config.json.

#### Confirm-Get_WindowsAutoPilotInfo.ps1
* Check that script Get-WindowsAutoPilotHWID.ps1 is installed and downladed. 
  * If script isn't installed, then install with minimum required version listed in config.json.
  * If script is installed, then don't do anything.

#### Confirm-Directory
* Confirm that the directory listed in config.json exists in the location stated. 
  * If directory exists in proper location, don't do anything.
  * If directory doesn't exist in proper location, create a new directory in that location with name listed in config.json.

#### Get-HardwareIdentification
* Get hardware ID and output to file listed in config.json.
  * Rename file to twelve digit hardware ID located in file.