$Parametro01 = $args[0]
$Parametro02 = $args[1]
$Parametro03 = $args[2]

if (!$Parametro01){
    Write-Host("Commands:");
    Write-Host("my       : Help");
    Write-Host("my vm    : ViewMemory");
    Write-Host("my sh    : ScanHealth");
    Write-Host("my cd    : CheckDisk");
    Write-Host("my d     : Defrag");
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