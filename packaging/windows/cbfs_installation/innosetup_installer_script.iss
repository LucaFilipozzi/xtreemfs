; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "XtreemFS Windows Client"
#define MyAppVersion "1.4"
#define MyAppPublisher "XtreemFS Project"
#define MyAppURL "http://www.XtreemFS.org/"
#define MyAppExeName "run_xtreemfs_client_command_line_prompt.bat"

#define SVNRoot "..\..\..\"
#define CbFSAdapterBuildDir SVNRoot + "cpp\build\Release\"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{EA8FA8CB-02C9-4028-8CBC-C109F9B8DFFA}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
LicenseFile=LICENSE_WIN32
OutputBaseFilename=xtreemfs_windows_client_{#MyAppVersion}
SetupIconFile=xtreemfs_logo_transparent.ico
Compression=lzma
;Compression=none
SolidCompression=yes
InfoBeforeFile=info_before_install.txt

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

; Entries in Startmenu Folder
[Icons]
Name: "{group}\Run XtreemFS Client (command line prompt)"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"; IconFilename: "{app}\xtreemfs_logo_transparent.ico"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"

[Files]
; Binaries
Source: "{#CbFSAdapterBuildDir}mount.xtreemfs.exe"; DestDir: "{app}"; Flags: ignoreversion; BeforeInstall: InstallCbFS
;Source: "{#CbFSAdapterBuildDir}mount.xtreemfs.pdb"; DestDir: "{app}"; Flags: ignoreversion;
Source: "{#CbFSAdapterBuildDir}mkfs.xtreemfs.exe"; DestDir: "{app}"; Flags: ignoreversion;
Source: "{#CbFSAdapterBuildDir}rmfs.xtreemfs.exe"; DestDir: "{app}"; Flags: ignoreversion;
Source: "{#CbFSAdapterBuildDir}lsfs.xtreemfs.exe"; DestDir: "{app}"; Flags: ignoreversion;
; Required OpenSSL libraries
Source: "{#CbFSAdapterBuildDir}libeay32.dll"; DestDir: "{app}"; Flags: ignoreversion;
Source: "{#CbFSAdapterBuildDir}ssleay32.dll"; DestDir: "{app}"; Flags: ignoreversion;
; CbFS driver and install helper
Source: "cbfsinst.dll"; DestDir: "{app}";
Source: "cbfs.cab"; DestDir: "{app}";
; Instructions and command line prompt script to simply running the client
Source: "readme.txt"; DestDir: "{app}"; 
Source: "{#MyAppExeName}"; DestDir: "{app}"; 
Source: "xtreemfs_logo_transparent.ico"; DestDir: "{app}"; 
; Visual C++ Redistributables 2010
Source: "vcredist_x86_2010.exe"; DestDir: {tmp}; Flags: deleteafterinstall
; Visual C++ Redistributables 2010, required for OpenSSL libraries
Source: "vcredist_x86_2008.exe"; DestDir: {tmp}; Flags: deleteafterinstall
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

; Code for detecting if Visual C++ Redistributables are already installed, was taken
; from: http://stackoverflow.com/a/11172939 Thanks to user "TLama" for his great answer!
[Run]
; add the Parameters, WorkingDir and StatusMsg as you wish, just keep here
; the conditional installation Check
Filename: "{tmp}\vcredist_x86_2010.exe"; Parameters: "/q /log %temp%\log_vc_redist_x86_2010_install_triggered_by_xtreemfs_windows_client.html"; Check: VCRedist2010NeedsInstall
Filename: "{tmp}\vcredist_x86_2008.exe"; Parameters: "/q /log %temp%\log_vc_redist_x86_2008_install_triggered_by_xtreemfs_windows_client.txt"; Check: VCRedist2008NeedsInstall
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Code]
var
  RebootNeeded: DWORD;
  UninstallRebootNeeded: DWORD;

// Add install dir to PATH environment variable.
const 
    ModPathName = 'modifypath'; 
    ModPathType = 'system'; 

function ModPathDir(): TArrayOfString; 
begin 
    setArrayLength(Result, 1) 
    Result[0] := ExpandConstant('{app}'); 
end; 
#include "modpath.iss"
  
#IFDEF UNICODE
  #DEFINE AW "W"
#ELSE
  #DEFINE AW "A"
#ENDIF
type
  INSTALLSTATE = Longint;
const
  INSTALLSTATE_INVALIDARG = -2;  // An invalid parameter was passed to the function.
  INSTALLSTATE_UNKNOWN = -1;     // The product is neither advertised or installed.
  INSTALLSTATE_ADVERTISED = 1;   // The product is advertised but not installed.
  INSTALLSTATE_ABSENT = 2;       // The product is installed for a different user.
  INSTALLSTATE_DEFAULT = 5;      // The product is installed for the current user.

  VC_2005_REDIST_X86 = '{A49F249F-0C91-497F-86DF-B2585E8E76B7}';
  VC_2005_REDIST_X64 = '{6E8E85E8-CE4B-4FF5-91F7-04999C9FAE6A}';
  VC_2005_REDIST_IA64 = '{03ED71EA-F531-4927-AABD-1C31BCE8E187}';
  VC_2005_SP1_REDIST_X86 = '{7299052B-02A4-4627-81F2-1818DA5D550D}';
  VC_2005_SP1_REDIST_X64 = '{071C9B48-7C32-4621-A0AC-3F809523288F}';
  VC_2005_SP1_REDIST_IA64 = '{0F8FB34E-675E-42ED-850B-29D98C2ECE08}';
  VC_2005_SP1_ATL_SEC_UPD_REDIST_X86 = '{837B34E3-7C30-493C-8F6A-2B0F04E2912C}';
  VC_2005_SP1_ATL_SEC_UPD_REDIST_X64 = '{6CE5BAE9-D3CA-4B99-891A-1DC6C118A5FC}';
  VC_2005_SP1_ATL_SEC_UPD_REDIST_IA64 = '{85025851-A784-46D8-950D-05CB3CA43A13}';

  VC_2008_REDIST_X86 = '{FF66E9F6-83E7-3A3E-AF14-8DE9A809A6A4}';
  VC_2008_REDIST_X64 = '{350AA351-21FA-3270-8B7A-835434E766AD}';
  VC_2008_REDIST_IA64 = '{2B547B43-DB50-3139-9EBE-37D419E0F5FA}';
  VC_2008_SP1_REDIST_X86 = '{9A25302D-30C0-39D9-BD6F-21E6EC160475}';
  VC_2008_SP1_REDIST_X64 = '{8220EEFE-38CD-377E-8595-13398D740ACE}';
  VC_2008_SP1_REDIST_IA64 = '{5827ECE1-AEB0-328E-B813-6FC68622C1F9}';
  VC_2008_SP1_ATL_SEC_UPD_REDIST_X86 = '{1F1C2DFC-2D24-3E06-BCB8-725134ADF989}';
  VC_2008_SP1_ATL_SEC_UPD_REDIST_X64 = '{4B6C7001-C7D6-3710-913E-5BC23FCE91E6}';
  VC_2008_SP1_ATL_SEC_UPD_REDIST_IA64 = '{977AD349-C2A8-39DD-9273-285C08987C7B}';
  VC_2008_SP1_MFC_SEC_UPD_REDIST_X86 = '{9BE518E6-ECC6-35A9-88E4-87755C07200F}';
  VC_2008_SP1_MFC_SEC_UPD_REDIST_X64 = '{5FCE6D76-F5DC-37AB-B2B8-22AB8CEDB1D4}';
  VC_2008_SP1_MFC_SEC_UPD_REDIST_IA64 = '{515643D1-4E9E-342F-A75A-D1F16448DC04}';

  VC_2010_REDIST_X86 = '{196BB40D-1578-3D01-B289-BEFC77A11A1E}';
  VC_2010_REDIST_X64 = '{DA5E371C-6333-3D8A-93A4-6FD5B20BCC6E}';
  VC_2010_REDIST_IA64 = '{C1A35166-4301-38E9-BA67-02823AD72A1B}';
  VC_2010_SP1_REDIST_X86 = '{F0C3E5D1-1ADE-321E-8167-68EF0DE699A5}';
  VC_2010_SP1_REDIST_X64 = '{1D8E6291-B0D5-35EC-8441-6616F567A0F7}';
  VC_2010_SP1_REDIST_IA64 = '{88C73C1C-2DE5-3B01-AFB8-B46EF4AB41CD}';

function MsiQueryProductState(szProduct: string): INSTALLSTATE; 
  external 'MsiQueryProductState{#AW}@msi.dll stdcall';

function VCVersionInstalled(const ProductID: string): Boolean;
begin
  Result := MsiQueryProductState(ProductID) = INSTALLSTATE_DEFAULT;
end;

function VCRedist2010NeedsInstall: Boolean;
begin
  // here the Result must be True when you need to install your VCRedist
  // or False when you don't need to, so now it's upon you how you build
  // this statement, the following won't install your VC redist only when
  // the Visual C++ 2010 Redist (x86) and Visual C++ 2010 SP1 Redist(x86)
  // are installed for the current user
//  Result := not (VCVersionInstalled(VC_2010_REDIST_X86) and 
//    VCVersionInstalled(VC_2010_SP1_REDIST_X86));
  Result := not (VCVersionInstalled(VC_2010_REDIST_X86));
  If Result = True Then
    Log('Visual C++ 2010 Redistributables were not found and will be installed.')
  else
    Log('Visual C++ 2010 Redistributables are already installed.');
end;

function VCRedist2008NeedsInstall: Boolean;
begin
  Result := not (VCVersionInstalled(VC_2008_REDIST_X86));
  If Result = True Then
    Log('Visual C++ 2008 Redistributables were not found and will be installed.')
  else
    Log('Visual C++ 2008 Redistributables are already installed.');
end;

// Install CbFS
function RunCbFSInstaller(CabPathName, ProductName: String; SupportPnP: Integer; ModulesToInstall: DWORD; var RebootNeeded: DWORD) : Integer;
external 'InstallW@files:cbfsinst.dll,cbfs.cab stdcall setuponly';

procedure InstallCbFS();
var
  InstallerResult: Integer;
begin
  Log('Using CbFS archive: ' + ExpandConstant('{tmp}') + '\' + 'cbfs.cab');
  InstallerResult := RunCbFSInstaller(ExpandConstant('{tmp}') + '\' + 'cbfs.cab', 'XtreemFS Windows Client', 1, 196609, RebootNeeded);
  if InstallerResult <> 1 then
    MsgBox('Failed to install the CbFS driver. Please reboot your system and try again.', mbCriticalError, MB_OK);
end;

function NeedRestart(): Boolean;
begin
  If RebootNeeded = 1 then
    Result := True
  else
    Result := False;
end;

// Uninstall CbFS
function RunCbFSUninstaller(CabPathName, ProductName: String; var RebootNeeded: DWORD) : Integer;
external 'UninstallW@{app}\cbfsinst.dll stdcall uninstallonly';

procedure UninstallCbFS();
var
  InstallerResult: Integer;
begin
  Log('Using CbFS archive: ' + ExpandConstant('{app}') + '\' + 'cbfs.cab');
  InstallerResult := RunCbFSUninstaller(ExpandConstant('{app}') + '\' + 'cbfs.cab', 'XtreemFS Windows Client', RebootNeeded);
  if InstallerResult <> 1 then
    MsgBox('Failed to uninstall the CbFS driver.', mbCriticalError, MB_OK);
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  If CurUninstallStep = usUninstall Then
  begin
    UninstallCbFS()
    UnloadDLL(ExpandConstant('{app}') + '\' + 'cbfsinst.dll')
  end;

  CurUninstallStepChangedModPath(CurUninstallStep)
end;

function UninstallNeedRestart(): Boolean;
begin
  If UninstallRebootNeeded = 1 then
    Result := True
  else
    Result := False;
end;

//[Tasks]
//  Name: modifypath; Description: Add application directory to your environmental path; Flags: unchecked