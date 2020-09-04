$Parametro01 = $args[0]

if (!$Parametro01){
    Write-Host("Commands:");
    Write-Host("");
    Write-Host("m      : Help");
    Write-Host("m vm   : ViewMemory");
    Write-Host("m sh   : ScanHealth");
    Write-Host("m cd   : CheckDisk");
    Write-Host("m d    : Defrag");
    Write-Host("");
}

if ($Parametro01 -eq "vm"){
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
    docker ps
    Write-Host("");
    Write-Host("****************************************************************************");
    Write-Host("                               Hyper-V");
    Write-Host("****************************************************************************");
    Get-VM
}

if ($Parametro01 -eq "sh"){
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
    DISM /Online /Cleanup-Image /ScanHealth
}

if ($Parametro01 -eq "cd"){
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

if ($Parametro01 -eq "d"){
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