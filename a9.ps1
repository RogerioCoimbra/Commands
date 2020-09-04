$Parametro01 = $args[0]

if ($Parametro01 -eq "b"){
    Set-Location("C:\Projetos\Angular09\src\backend");
}

if ($Parametro01 -eq "f"){
    Set-Location("C:\Projetos\Angular09\src\frontend");
}

if (!$Parametro01){
    Set-Location("C:\Projetos\Angular09");
}