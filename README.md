# AutomaticHWID

## Usage

#### Required File(s)

  * config.json
  * AutomaticHWID.ps1

#### Optional File(s)

  * start.bat

### Instructions

----

#### **WARNING**

* You absolutely must have the files `config.json` and `AutomaticHWID.ps1` in order to run this script. They must also be in the same folder in order to function.
* The file `start.bat` is not required to run the script, but is completely optional if you do not wish to use commands. Note that this file must also be in the same folder as `config.json` and `AutomaticHWID.ps1`.
* This script must be run as an Administrator to function properly, if it is not run as an Administrator, it will not work.
* Depending, this script may not output a proper hardware serial number, if this occurs then please note that the system this was run on does not have an internal hardware ID and cannot be identified. 
* Do not run this script multiple times on the same machine, it can cause issues. 

#### **Usage Instructions**

*Please ensure that you have read and acknowledged all warnings and have all required files in the proper places before proceeding further.*

##### Using `start.bat` (Recommended)
###### Command Line
* Change directory to script location. [eg: `cd <path to file>`]
* 



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
* Check that script Get-WindowsAutoPilotHWID.ps1 is installed and downloaded. 
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
