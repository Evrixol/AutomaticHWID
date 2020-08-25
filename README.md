AutomaticHWID
======

Usage
======
### Required File(s)
  * config.json
  * AutomaticHWID.ps1

### Optional File(s)
  * start.bat

### Instructions
**WARNING**
You absoultely must have `config.json` and `AutomaticHWID.ps1` in order to run this script. They must also be in the same folder in order to function.
----

Functions
======

#### Confirm-NuGet
* Ensure that package provider NuGet is installed to minimum version listed in config.json.
  * If NuGet isn't installed, then install with required version listed in config.json.
  * If NuGet is installed, check if version number is greater than or equal to required version. 
  * If previous case is false, update to minimum required version listed in config.json.

#### Confirm-Elevation
* Checks whether or not script is running with administraitive permissions.
  * If not running with elevation, break script.
  * Else, end function call.

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

Bugs
======
- [x] Confirm-NuGet has no output and possibly doesn't do anything.
- [x] Get-HardwareID fails to output proper filename.


TODO
======
- [ ] Cleanup terminal output & make it just look nicer.
- [ ] Output logging.
  - [ ] Output logging config.
    - [ ] Option to actually have output.
    - [ ] Directory.
    - [ ] Extension type.
    - [ ] Naming convention.
    - [ ] Temp holding name.
- [x] Elevations / administrative permissions checking.
- [ ] Internet connection checking. (Glorified pinging of Cloudfare or something idk.)
- [x] More verbose terminal output.
- [x] Configuration file.
  - [x] Version requirements.
  - [x] HWID directory location.
  - [x] HWID directory name.
  - [x] HWID output file temp-name.
  - [x] HWID output file file type. 
