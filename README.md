AutomaticHWID
======

Usage
======
You need `config.json` and `AutomaticHWID.ps1` to get the hardware identification. `Start.bat` is recommended if you are uncomfortable with commands. Please note: All of these scripts assume and absolutely require them to be in the same folder when they are run.
  To run `AutomaticHWID.ps1` it needs to be run as administrator and bypass execution policy. You can do this by running `Powershell.exe -ExecutionPolicy Bypass -File <pathto: AutomaticHWID.ps1>` as administrator. Or you can run `Start.bat` as an administrator.


Functions
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

Bugs
======
- [x] Confirm-NuGet has no output and possibly doesn't do anything.
- [x] Get-HardwareID fails to output proper filename.


To Be Added
======
- [x] More verbose terminal output.
- [x] Configuration file.
  - [x] Version requirements.
  - [x] HWID directory location.
  - [x] HWID directory name.
  - [x] HWID output file temp-name.
  - [x] HWID output file file type. 
- [ ] Output logging.
  - [ ] Output logging config.
    - [ ] Option to actually have output.
    - [ ] Directory.
    - [ ] Extension type.
    - [ ] Naming convention.
    - [ ] Temp holding name.
- [ ] Elevations / administrative permissions checking.
- [ ] Internet connection checking. (Glorified pinging of Cloudfare or something idk.)


Nice To Have
=====
- [ ] Script automatically updates itself and its config file. (Not happening ANY TIME FUCKING SOON.)
- [ ] Migrate script to a .exe file using C++ or another native language. (Also not happening ANY TIME FUCKING SOON. EVER.)
- [ ] Continually increase verbosity for debugging and output logging reasons.