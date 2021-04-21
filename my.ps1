$Parametro01 = $args[0]
$Parametro02 = $args[1]
$Parametro03 = $args[2]

if (!$Parametro01){
    Write-Host("Commands:");
    Write-Host("my       : Help");
    Write-Host("my vm    : ViewMemory");
    Write-Host("my sh    : ScanHealth");
    Write-Host("my cd    : CheckDisk");
    Write-Host("my de    : Defrag");
	Write-Host("my do    : Docker");
	Write-Host("my del   : Clear logs");
	Write-Host("my ma    : Preventive Maintenance");
    Write-Host("");
	Write-Host("Projetos:");
    Write-Host("my p     : Projetos");
	Write-Host("my c     : Commands");
    Write-Host("my a9    : Angular9");
	Write-Host("my a9 b  : Angular9 BackEnd");
	Write-Host("my a9 f  : Angular9 FrontEnd");
    #Write-Host("my m     : Maestro");
	#Write-Host("my m s   : Maestro Sdk");
	#Write-Host("my m s i : Maestro Sdk Instalar");
	#Write-Host("my m s a : Maestro Sdk Atualizar");
	#Write-Host("my m w   : Maestro WebApp");
	#Write-Host("my m w i : Maestro WebApp Instalar");
	#Write-Host("my m w a : Maestro WebApp Atualizar");
    Write-Host("");
}

if ($Parametro01 -eq "c"){
    Set-Location("C:\Projetos\Commands");
}

if ($Parametro01 -eq "p"){
    Set-Location("C:\Projetos");
}

if ($Parametro01 -eq "a9"){
	if ($Parametro02 -eq "b"){
		Set-Location("C:\Projetos\Angular09\src\backend");
	}

	if ($Parametro02 -eq "f"){
		Set-Location("C:\Projetos\Angular09\src\frontend");
	}

	if (!$Parametro02){
		Set-Location("C:\Projetos\Angular09");
	}
}

if ($Parametro01 -eq "m"){
	if ($Parametro02 -eq "s"){
		Set-Location("C:\Projetos\carrefour-maestro-source\FONTES DEV\Sdk");
		
		if ($Parametro03 -eq "i"){
			Write-Host("npm run InstalarMaestro");
			npm run InstalarMaestro
		}
		
		if ($Parametro03 -eq "a"){
			Write-Host("npm run AtualizarMaestro");
			npm run AtualizarMaestro
		}
	}

	if ($Parametro02 -eq "w"){
		Set-Location("C:\Projetos\carrefour-maestro-source\FONTES DEV\webApp");
		
		if ($Parametro03 -eq "i"){
			Write-Host("npm run InstalarMaestro");
			npm run InstalarMaestro
		}
		
		if ($Parametro03 -eq "a"){
			Write-Host("npm run AtualizarMaestro");
			npm run AtualizarMaestro
		}
	}

	if (!$Parametro02){
		Set-Location("C:\Projetos\carrefour-maestro-source");
	}
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
	Remove-Item C:\Users\roger\AppData\Local\Temp\*.log -ErrorAction SilentlyContinue

	Write-Host("");
	Write-Host("Done");

    Write-Host("");
	Write-Host("****************************************************************************");
    Write-Host("                               List Logs Remaining");
    Write-Host("****************************************************************************");
	
	Get-ChildItem C:\ProgramData\Razer\Synapse3\Log\*.log
	Get-ChildItem C:\ProgramData\Razer\Synapse3\Log\archive\*.log
	Get-ChildItem "C:\ProgramData\Razer\Razer Central\Logs\*.*"
	Get-ChildItem C:\ProgramData\Razer\GameManager\Logs\*.*
	Get-ChildItem C:\Windows\Logs\CBS\*.log
	Get-ChildItem C:\Users\roger\AppData\Local\Razer\Synapse3\Log\*.log
	Get-ChildItem C:\Users\roger\AppData\Local\Razer\Synapse3\Log\archive\*.log
	Get-ChildItem C:\Windows\Temp\*.log
	Get-ChildItem C:\Users\roger\AppData\Local\Temp\*.log
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
    DISM /Online /Cleanup-Image /ScanHealth
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







if ($Parametro01 -eq "vm"){
	Get-MyVm
}

if ($Parametro01 -eq "sh"){
	Get-MySh
}

if ($Parametro01 -eq "cd"){
	Get-MyCd
}

if ($Parametro01 -eq "de"){
	Get-MyDe
}

if ($Parametro01 -eq "do"){
	Get-MyDo
}

if ($Parametro01 -eq "del"){
	Get-MyDel
}

if ($Parametro01 -eq "ma"){
	clear
	Get-MyDel
	Get-MyDe
	Get-MySh
	Get-MyCd
}


