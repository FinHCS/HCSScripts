$currPolicy = Get-ExecutionPolicy
$host.UI.RawUI.WindowTitle = "Fin's Remote Autoinstaller" 
$ProgressPreference = 'SilentlyContinue'
$ShortcutPath = "C:\Users\*\Desktop\*HCS*.lnk"
Get-ChildItem "C:\Users\*\Desktop\*HCS*.lnk" | Remove-Item -Force | Write-Host "Shortcut to old installation of HCS Remote found on desktop, deleting now"

$NewScriptCheckPath = "$env:ProgramFiles\HCS Remote\HCS Remote Support.exe"
if(Test-Path $NewScriptCheckPath){
    Write-Host "Previous installation of HCS Remote found, press any key to exit script"
    if(!$psISE) {
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
        }  
    
    exit
    }

New-Item -ItemType Directory -Path "$env:ProgramFiles\HCS Remote\" | Write-Host "Creating Program Files Folder"

Invoke-WebRequest -Uri "https://customdesignservice.teamviewer.com/download/windows/v15/2refr8j/TeamViewerQS.exe" -OutFile "$env:ProgramFiles\HCS Remote\HCS Remote Support.exe" | Write-Host "Downloading file (1/2)"

Invoke-WebRequest -Uri "https://cgp.lol/wp-content/uploads/2023/06/hcs.ico" -OutFile "$env:ProgramFiles\HCS Remote\icon.ico"| Write-Host "Downloading file (2/2)"

$TargetFile = "$env:ProgramFiles\HCS Remote\HCS Remote Support.exe"
$ShortcutFile = "$env:PUBLIC\Desktop\HCS Remote Support App.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)| Write-Host "Creating shortcut on all users Desktops"
$Shortcut.TargetPath = $TargetFile
$Shortcut.IconLocation = "$env:ProgramFiles\HCS Remote\icon.ico"
$Shortcut.Save() | Write-Host "Changing Icon"
Write-Host "Previous installation of HCS Remote found, press any key to exit script"
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
exit