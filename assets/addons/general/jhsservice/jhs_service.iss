[Setup]
AppName="jhs"
AppVerName="jhs 1.0"
AppVersion=1.0
AppMutex=InnoSetupExtensionsCompilerAppMutex
DefaultDirName={pf}\j701
AllowNoIcons=yes
AllowRootDirectory=true
CreateAppDir=true
DisableProgramGroupPage=true
PrivilegesRequired=admin
ShowComponentSizes=false
OutputBaseFilename="jhs_service"

[Dirs]
Name: {app}\tools

[Files]
Source: "instsrv.exe"; DestDir: {app}\tools; Flags: onlyifdoesntexist
Source: "srvany.exe"; DestDir: {app}\tools; Flags: onlyifdoesntexist

[Registry]
Root: HKLM; SubKey: SYSTEM\CurrentControlSet\Services\jhs; ValueType: NONE; Flags: uninsdeletekey
Root: HKLM; SubKey: SYSTEM\CurrentControlSet\Services\jhs; ValueName: Description; ValueType: STRING; ValueData: jhs
Root: HKLM; SubKey: SYSTEM\CurrentControlSet\Services\jhs\Parameters; ValueType: NONE
Root: HKLM; SubKey: SYSTEM\CurrentControlSet\Services\jhs\Parameters; ValueName: Application; ValueType: STRING; ValueData: """{app}\bin\jconsole.exe"" ~addons\ide\jhs\core.ijs -js ""init_jhs_ ''"""

[Run]
Filename: sc.exe; Parameters: "stop jhs"; Flags: runhidden runascurrentuser
Filename: {app}\tools\instsrv.exe; Parameters: "jhs ""{app}\tools\srvany.exe"""; Description: "Create jhs service"; Flags: runhidden runascurrentuser
Filename: sc.exe; Parameters: "config jhs start= auto"; Description: "Config jhs service"; Flags: runhidden runascurrentuser
Filename: sc.exe; Parameters: "start jhs"; Description: "Start jhs service"; Flags: postinstall unchecked skipifsilent runascurrentuser

[UninstallRun]
Filename: sc.exe; Parameters: "stop jhs"; Flags: runhidden runascurrentuser
Filename: sc.exe; Parameters: "delete jhs"; Flags: runhidden runascurrentuser
