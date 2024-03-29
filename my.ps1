$Parametro01 = $args[0]
#$Parametro02 = $args[1]

if (!$Parametro01) {
    Write-Host([System.Net.Dns]::GetHostName());
    Write-Host("Commands:");
    Write-Host("my       : Help");
    Write-Host("my vm    : ViewMemory");
    Write-Host("my sh    : ScanHealth");
    Write-Host("my ac    : AnalyzeComponent");
    Write-Host("my cd    : CheckDisk");
    Write-Host("my de    : Defrag");
    Write-Host("my do    : Docker");
    Write-Host("my del   : Clear logs");
    Write-Host("my ma    : Preventive Maintenance");
    Write-Host("");
    Write-Host("Projetos:");
    Write-Host("my p     : Projetos");
    Write-Host("my c     : Challenges");
    Write-Host("my co    : Commands");
    Write-Host("");
    Write-Host("Projetos Cap:");
    Write-Host("my gas    : Gen-AI-Sommelier");
    Write-Host("");
}

if ($Parametro01 -eq "p") {
    Set-Location("E:\Projetos");
}

if ($Parametro01 -eq "c") {
    Set-Location("E:\Projetos\Challenges");
}

if ($Parametro01 -eq "co") {
    Set-Location("E:\Projetos\Commands");
}

if ($Parametro01 -eq "gas") {
    Set-Location("E:\Projetos\4-GPA\Gen-AI-Sommelier");
}

function Get-MyDel {
    Clear-Host
    Write-Host("Clear Logs:");
	
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Delete Logs");
    Write-Host("****************************************************************************");
	
    Remove-Item C:\Windows\Logs\CBS\*.log -ErrorAction SilentlyContinue
    Remove-Item C:\Windows\Temp\*.log -ErrorAction SilentlyContinue
    Remove-Item C:\Windows\INF\*.log -ErrorAction SilentlyContinue
    Remove-Item C:\Windows\*.log -ErrorAction SilentlyContinue
    Remove-Item C:\Windows\System32\LogFiles\setupcln\*.log -ErrorAction SilentlyContinue
    Remove-Item C:\Windows\System32\*.log -ErrorAction SilentlyContinue
    Remove-Item C:\Users\roger\AppData\Local\Temp\*.log -ErrorAction SilentlyContinue
    Remove-Item C:\ProgramData\Microsoft\EdgeUpdate\Log\*.log -ErrorAction SilentlyContinue
    Remove-Item C:\Windows\debug\WIA\*.log -ErrorAction SilentlyContinue
    Remove-Item "C:\Users\roger\AppData\Local\Docker\*log*.txt" -ErrorAction SilentlyContinue
    Remove-Item C:\Users\roger\AppData\Roaming\Evernote\logs\*.log -ErrorAction SilentlyContinue
    Remove-Item C:\Users\roger\AppData\Roaming\Evernote\logs\*log.*.gz -ErrorAction SilentlyContinue
    #Remove-Item "C:\Program Files (x86)\TeamViewer\*.log" -ErrorAction SilentlyContinue
    #Get-ChildItem "C:\ProgramData\Battle.net\*.log" -Recurse | Select-Object $_ | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    
    Write-Host("");
    Write-Host("Done");

    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Delete Trash");
    Write-Host("****************************************************************************");
    
    if(Test-Path("C:\Users\roger\Pictures\Screenshots\")) {Remove-Item C:\Users\roger\Pictures\Screenshots\*}
    #Remove-Item C:\Users\roger\AppData\Roaming\Nelogica\XPTrader\database\assets\* -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item C:\Windows\SoftwareDistribution\Download\* -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item C:\ProgramData\Intel\DSA\Downloads\* -Force -Recurse -ErrorAction SilentlyContinue
    Get-ChildItem "C:\ProgramData\NVIDIA Corporation\Downloader" -Directory | Where-Object {$_.Name.Length -eq 32 } | Select-Object $_ | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item "C:\Users\roger\AppData\Local\Docker Desktop Installer\update*.exe" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item "C:\Program Files (x86)\Google\Update\Download\*" -Force -Recurse -ErrorAction SilentlyContinue
    #Remove-Item C:\Users\roger\.nuget\packages\* -Force -Recurse -ErrorAction SilentlyContinue
    if(Test-Path("C:\Users\roger\AppData\Local\Temp\WinGet\")) {Remove-Item C:\Users\roger\AppData\Local\Temp\WinGet\* -Force -Recurse -ErrorAction SilentlyContinue}
    Remove-Item "C:\Program Files (x86)\Microsoft\EdgeUpdate\Download\*" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item "E:\Emulation\System\LaunchBox\Updates\*" -Force -Recurse -ErrorAction SilentlyContinue

    Write-Host("");
    Write-Host("Done");

    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               List Logs and Trashs Remaining");
    Write-Host("****************************************************************************");
	
    Get-ChildItem C:\Windows\Logs\CBS\*.log
    Get-ChildItem C:\Windows\Temp\*.log
    Get-ChildItem C:\Windows\INF\*.log
    Get-ChildItem C:\Windows\*.log
    Get-ChildItem C:\Windows\System32\LogFiles\setupcln\*.log
    Get-ChildItem C:\Windows\System32\*.log
    Get-ChildItem C:\Users\roger\AppData\Local\Temp\*.log
    Get-ChildItem C:\ProgramData\Microsoft\EdgeUpdate\Log\*.log
    Get-ChildItem C:\Windows\debug\WIA\*.log
    Get-ChildItem "C:\Users\roger\AppData\Local\Docker\*log*.txt"
    Get-ChildItem C:\Users\roger\AppData\Roaming\Evernote\logs\*.log
    Get-ChildItem C:\Users\roger\AppData\Roaming\Evernote\logs\*log.*.gz
    #Get-ChildItem "C:\Program Files (x86)\TeamViewer\*.log"
    #Get-ChildItem "C:\ProgramData\Battle.net\*.log" -Recurse

    if(Test-Path("C:\Users\roger\Pictures\Screenshots\")) { Get-ChildItem C:\Users\roger\Pictures\Screenshots\*}
    #Get-ChildItem C:\Users\roger\AppData\Roaming\Nelogica\XPTrader\database\assets\*
    Get-ChildItem C:\Windows\SoftwareDistribution\Download\*
    Get-ChildItem C:\ProgramData\Intel\DSA\Downloads\*
    Get-ChildItem "C:\ProgramData\NVIDIA Corporation\Downloader" -Directory | Where-Object {$_.Name.Length -eq 32 }
    Get-ChildItem "C:\Users\roger\AppData\Local\Docker Desktop Installer\update*.exe"
    Get-ChildItem "C:\Program Files (x86)\Google\Update\Download\*"
    #Get-ChildItem C:\Users\roger\.nuget\packages\* 
    if(Test-Path("C:\Users\roger\AppData\Local\Temp\WinGet\")) {Get-ChildItem C:\Users\roger\AppData\Local\Temp\WinGet\*}
    Get-ChildItem "C:\Program Files (x86)\Microsoft\EdgeUpdate\Download\*"
    Get-ChildItem "E:\Emulation\System\LaunchBox\Updates\*"

    Write-Host("");
    Write-Host("Done");
}



function Get-MyVm {
    Clear-Host
    Write-Host("View Memory:");
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               WSL List (wsl -l -v)");
    Write-Host("****************************************************************************");
    wsl -l -v
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Docker List containers (docker ps -a)");
    Write-Host("****************************************************************************");
    docker ps -a
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Docker List images (docker images)");
    Write-Host("****************************************************************************");
    docker images
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Hyper-V (Get-VM)");
    Write-Host("****************************************************************************");
    Get-VM
}

function Get-MySh {
    Write-Host("Scan Health:");
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Verificando arquivos (SFC /Scannow)");
    Write-Host("****************************************************************************");
    SFC /Scannow
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Verificando componentes");
    Write-Host("****************************************************************************");
    Write-Host("");
    Write-Host("Dism.exe /online /Cleanup-Image /CheckHealth");
    Dism.exe /online /Cleanup-Image /CheckHealth
    Write-Host("");
    Write-Host("Dism.exe /online /Cleanup-Image /ScanHealth");
    Dism.exe /online /Cleanup-Image /ScanHealth
    Write-Host("");
    Write-Host("Dism.exe /online /Cleanup-Image /RestoreHealth");
    Dism.exe /online /Cleanup-Image /RestoreHealth
}

function Get-MyAc {
    Write-Host("Analyze Component:");
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Verificando componentes");
    Write-Host("****************************************************************************");
    Write-Host("");
    Write-Host("Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase");
    Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
    Write-Host("");
    Write-Host("Dism.exe /online /Cleanup-Image /SPSuperseded /HideSP");
    Dism.exe /online /Cleanup-Image /SPSuperseded /HideSP
    #Write-Host("");
    #Write-Host("Dism.exe /online /Cleanup-Image /AnalyzeComponentStore");
    #Dism.exe /online /Cleanup-Image /AnalyzeComponentStore
}



function Get-MyCd {
    Write-Host("Check Disk:");
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Verificando C: (chkdsk C: /scan)");
    Write-Host("****************************************************************************");
    chkdsk C: /scan
    # Write-Host("");
    # Write-Host("****************************************************************************");
    # Write-Host("                               Verificando D: (chkdsk D: /scan)");
    # Write-Host("****************************************************************************");
    # chkdsk D: /scan
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Verificando E: (chkdsk E: /scan)");
    Write-Host("****************************************************************************");
    chkdsk E: /scan
}

function Get-MyDe {
    Write-Host("Defrag:");
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Desfragmentando C: (Defrag C: /H /O)");
    Write-Host("****************************************************************************");
    Defrag C: /H /O
    Optimize-Volume -DriveLetter C
    # Write-Host("");
    # Write-Host("****************************************************************************");
    # Write-Host("                               Desfragmentando D: (Defrag D: /H /O)");
    # Write-Host("****************************************************************************");
    # Defrag D: /H /O
    #Optimize-Volume -DriveLetter D
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Desfragmentando E: (Defrag E: /H /O)");
    Write-Host("****************************************************************************");
    Defrag E: /H /O
    Optimize-Volume -DriveLetter E
}

function Get-MyDo {
    Clear-Host
    Write-Host("Docker:");
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               List containers (docker ps -a)");
    Write-Host("****************************************************************************");
    docker ps -a
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               List images (docker images)");
    Write-Host("****************************************************************************");
    docker images
}







if ($Parametro01 -eq "vm") {
    Get-MyVm
}

if ($Parametro01 -eq "sh") {
    Get-MySh
}

if ($Parametro01 -eq "cd") {
    Get-MyCd
}

if ($Parametro01 -eq "ac") {
    Get-MyAc
}

if ($Parametro01 -eq "de") {
    Get-MyDe
}

if ($Parametro01 -eq "do") {
    Get-MyDo
}

if ($Parametro01 -eq "del") {
    Get-MyDel
}

if ($Parametro01 -eq "ma") {
    Clear-Host
    Get-MyDel   #Delete Logs
    Write-Host("");
    Get-MyDe    #Defrag
    Write-Host("");
    Get-MyCd    #Check Disk:
    Write-Host("");
    #Get-MySh    #Scan Health:
    #Write-Host("");
    #Get-MyAc    #Analyze Component:
    #Write-Host("");
}