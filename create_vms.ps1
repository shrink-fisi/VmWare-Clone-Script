$vorlagePfad = "C:\VM\Vorlage\Vorlage.vmx"
$anzahlKlone = Read-Host "Wie viele Klone?"

for ($i = 1; $i -le $anzahlKlone; $i++) {
    $klonName = "Clone$i"
    $klonVmxPfad = "C:\VM\Clone$i\Clone$i.vmx"

    $klonVerzeichnis = "C:\VM\Clone$i"
    while (Test-Path $klonVerzeichnis) {
        $i++
        $klonName = "Clone$i"
        $klonVmxPfad = "C:\VM\Clone$i\Clone$i.vmx"
        $klonVerzeichnis = "C:\VM\Clone$i"
    }

    & "C:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe" clone "$vorlagePfad" "$klonVmxPfad" full -cloneName="$klonName"
    
}

Write-Host "Klonerstellung abgeschlossen!"```

Read-Host -Prompt "Enter zum Stoppen"
