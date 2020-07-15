# Get-HardwareID
----

#### Usage
* Download `Get-HardwareID.ps1`.
* Run `Get-HardwareID.ps1` using `Powershell.exe -ExecutionPolicy Bypass -File <patht>Get-HardwareID.ps1`
  * It is highly recommended to run this script in a double nested folder as it will create it's own folder for the hardware id. 
  * This script will install NuGet and download a script (`Get-WindowsAutoPilotInfo.ps1`) from `PSGallery`.

----

##### TODO
* Resolve bugs listed in "_Known issues_`".
* Add "Purpose" section in `README.md`.
* Add "How to use" section in `README.md`.

##### Bugs
- [ ] Check_Nuget has no output and possibly doesn't do anything.
- [x] Get-HardwareIdentification fails to output proper filename. 

##### Would be nice to have
* More verbose terminal output.
* Configuration file.
  * Output file temporary placeholder name.
  * Output directory location. 
  * Output directory name.
  * Output file extension. (Eg: .csv .txt .md .shoveit)
  * Required external scripts minimum version(s). 
  * Verbosity (True/False) option.
  * Option to automatically upload hardware ID to asset data server.
