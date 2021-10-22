$Parametro01 = $args[0]
$Parametro02 = $args[1]
$Parametro03 = $args[2]

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
    Write-Host("my a9    : Angular9");
    Write-Host("my a9 b  : Angular9 BackEnd");
    Write-Host("my a9 f  : Angular9 FrontEnd");
    Write-Host("my k     : Kafka");
    Write-Host("");
    Write-Host("Projetos Cap:");
    Write-Host("my pr    : PredicaoBaseFusivel");
    Write-Host("my ke    : Kafka eTerraConnector");
    Write-Host("my ca    : CaminhoEletricoSHS");
    Write-Host("");
}

if ($Parametro01 -eq "c") {
    Set-Location("C:\Projetos\Challenges");
}

if ($Parametro01 -eq "co") {
    Set-Location("C:\Projetos\Commands");
}

if ($Parametro01 -eq "p") {
    Set-Location("C:\Projetos");
}

if ($Parametro01 -eq "a9") {
    if ($Parametro02 -eq "b") {
        Set-Location("C:\Projetos\Angular09\src\backend");
    }

    if ($Parametro02 -eq "f") {
        Set-Location("C:\Projetos\Angular09\src\frontend");
    }

    if (!$Parametro02) {
        Set-Location("C:\Projetos\Angular09");
    }
}

if ($Parametro01 -eq "k") {
    Set-Location("C:\Projetos\Kafka");
}

if ($Parametro01 -eq "pr") {
    Set-Location("C:\Projetos\4-Enel\PredicaoBaseFusivel");
}

if ($Parametro01 -eq "ke") {
    Set-Location("C:\Projetos\4-Enel\KafkaeterraConnector");
}

if ($Parametro01 -eq "ca") {
    Set-Location("C:\Projetos\4-Enel\CaminhoEletricoSHS");
}

function Get-MyDel {
    clear
    Write-Host("Clear Logs:");
	
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Delete Logs");
    Write-Host("****************************************************************************");
	
    Remove-Item C:\ProgramData\Razer\Synapse3\Log\*.log -ErrorAction SilentlyContinue
    Remove-Item C:\ProgramData\Razer\Synapse3\Log\archive\*.log -ErrorAction SilentlyContinue
    Remove-Item "C:\ProgramData\Razer\Razer Central\Logs\*.*" -ErrorAction SilentlyContinue
    Remove-Item C:\ProgramData\Razer\GameManager\Logs\*.* -ErrorAction SilentlyContinue
    Remove-Item C:\Windows\Logs\CBS\*.log -ErrorAction SilentlyContinue
    Remove-Item C:\Users\roger\AppData\Local\Razer\Synapse3\Log\*.log -ErrorAction SilentlyContinue
    Remove-Item C:\Users\roger\AppData\Local\Razer\Synapse3\Log\archive\*.log -ErrorAction SilentlyContinue
    Remove-Item C:\Windows\Temp\*.log -ErrorAction SilentlyContinue
    Remove-Item C:\Windows\INF\*.log -ErrorAction SilentlyContinue
    Remove-Item C:\Windows\*.log -ErrorAction SilentlyContinue
    Remove-Item C:\Windows\System32\LogFiles\setupcln\*.log -ErrorAction SilentlyContinue
    Remove-Item C:\Windows\System32\*.log -ErrorAction SilentlyContinue
    Remove-Item C:\Users\roger\AppData\Local\Temp\*.log -ErrorAction SilentlyContinue
    Remove-Item C:\ProgramData\Microsoft\EdgeUpdate\Log\*.log -ErrorAction SilentlyContinue
    Remove-Item "C:\Program Files (x86)\TeamViewer\*.log" -ErrorAction SilentlyContinue
    Remove-Item C:\Windows\debug\WIA\*.log -ErrorAction SilentlyContinue
    Remove-Item "C:\Users\roger\AppData\Local\Docker\*log*.txt" -ErrorAction SilentlyContinue
    
    Write-Host("");
    Write-Host("Done");

    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Delete Trash");
    Write-Host("****************************************************************************");
    
    Remove-Item C:\Users\roger\AppData\Roaming\Nelogica\Profit\database\assets\* -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item C:\Windows\SoftwareDistribution\Download\* -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item C:\ProgramData\Intel\DSA\Downloads\* -Force -Recurse -ErrorAction SilentlyContinue
    Get-ChildItem "C:\ProgramData\NVIDIA Corporation\Downloader" -Directory | Where-Object {$_.Name.Length -eq 32 } | Select-Object $_ | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item "C:\Users\roger\AppData\Local\Docker Desktop Installer\update*.exe" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item "C:\Program Files (x86)\Google\Update\Download\*" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item C:\Users\roger\.nuget\packages\* -Force -Recurse -ErrorAction SilentlyContinue

    Write-Host("");
    Write-Host("Done");

    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               List Logs and Trashs Remaining");
    Write-Host("****************************************************************************");
	
    Get-ChildItem C:\ProgramData\Razer\Synapse3\Log\*.log
    Get-ChildItem C:\ProgramData\Razer\Synapse3\Log\archive\*.log
    Get-ChildItem "C:\ProgramData\Razer\Razer Central\Logs\*.*"
    Get-ChildItem C:\ProgramData\Razer\GameManager\Logs\*.*
    Get-ChildItem C:\Windows\Logs\CBS\*.log
    Get-ChildItem C:\Users\roger\AppData\Local\Razer\Synapse3\Log\*.log
    Get-ChildItem C:\Users\roger\AppData\Local\Razer\Synapse3\Log\archive\*.log
    Get-ChildItem C:\Windows\Temp\*.log
    Get-ChildItem C:\Windows\INF\*.log
    Get-ChildItem C:\Windows\*.log
    Get-ChildItem C:\Windows\System32\LogFiles\setupcln\*.log
    Get-ChildItem C:\Windows\System32\*.log
    Get-ChildItem C:\Users\roger\AppData\Local\Temp\*.log
    Get-ChildItem C:\ProgramData\Microsoft\EdgeUpdate\Log\*.log
    Get-ChildItem "C:\Program Files (x86)\TeamViewer\*.log"
    Get-ChildItem C:\Windows\debug\WIA\*.log
    Get-ChildItem "C:\Users\roger\AppData\Local\Docker\*log*.txt"

    Get-ChildItem C:\Users\roger\AppData\Roaming\Nelogica\Profit\database\assets\*
    Get-ChildItem C:\Windows\SoftwareDistribution\Download\*
    Get-ChildItem C:\ProgramData\Intel\DSA\Downloads\*
    Get-ChildItem "C:\ProgramData\NVIDIA Corporation\Downloader" -Directory | Where-Object {$_.Name.Length -eq 32 }
    Get-ChildItem "C:\Users\roger\AppData\Local\Docker Desktop Installer\update*.exe"
    Get-ChildItem "C:\Program Files (x86)\Google\Update\Download\*"
    Get-ChildItem C:\Users\roger\.nuget\packages\* 

    Write-Host("");
    Write-Host("Done");
}



function Get-MyVm {
    clear
    Write-Host("View Memory:");
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               WSL List");
    Write-Host("****************************************************************************");
    wsl -l -v
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Docker List containers");
    Write-Host("****************************************************************************");
    docker ps -a
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Docker List images");
    Write-Host("****************************************************************************");
    docker images
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Hyper-V");
    Write-Host("****************************************************************************");
    Get-VM
}

function Get-MySh {
    Write-Host("Scan Health:");
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               verificando arquivos");
    Write-Host("****************************************************************************");
    SFC /Scannow
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Verificando componentes");
    Write-Host("****************************************************************************");
    Dism /Online /Cleanup-Image /StartComponentCleanup
    Dism /Online /Cleanup-Image /RestoreHealth
}

function Get-MyAc {
    Write-Host("Analyze Component:");
    Write-Host("****************************************************************************");
    Write-Host("                               Verificando componentes");
    Write-Host("****************************************************************************");
    Dism /Online /Cleanup-Image /AnalyzeComponentStore
}



function Get-MyCd {
    Write-Host("Check Disk:");
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Verificando C:");
    Write-Host("****************************************************************************");
    chkdsk C: /scan
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Verificando D:");
    Write-Host("****************************************************************************");
    chkdsk D: /scan
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Verificando E:");
    Write-Host("****************************************************************************");
    chkdsk E: /scan
}

function Get-MyDe {
    Write-Host("Defrag:");
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Desfragmentando C:");
    Write-Host("****************************************************************************");
    Defrag C: /U /V /D /O
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Desfragmentando D:");
    Write-Host("****************************************************************************");
    Defrag D: /U /V /D /O
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Desfragmentando E:");
    Write-Host("****************************************************************************");
    Defrag E: /U /V /D /O
}

function Get-MyDo {
    clear
    Write-Host("Docker:");
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               List containers");
    Write-Host("****************************************************************************");
    docker ps -a
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               List images");
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
    clear
    Get-MyDel
    Get-MyDe
    Get-MySh
    Get-MyCd
    Get-MyAc
}


