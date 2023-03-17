#v03 14032023	funktion fuer hoechsteKlonNr vereinfacht. \D regex viel komfortabler als vorher. Kleine Textänderungen

$vorlagePfad = "D:\VM\Clone of ErsterServer\Clone of ErsterServer.vmx"
$anzahlKlone = Read-Host "Wie viele Klone?"

$hoechsteKlonNr = 0
Get-ChildItem -Path "D:\VM\" -Filter "Klon*" -Directory | ForEach-Object {
    $klonNrStr = $_.Name -replace '\D', ''
    if (![string]::IsNullOrEmpty($klonNrStr)) {
        $klonNr = [int]$klonNrStr
        if ($klonNr -gt $hoechsteKlonNr) {
            $hoechsteKlonNr = $klonNr
        }
    }
}

for ($i = $hoechsteKlonNr + 1; $i -le $hoechsteKlonNr + $anzahlKlone; $i++) {
    $klonName = "Klon$i"
    $klonVmxPfad = "D:\VM\Klon$i\Klon$i.vmx"

    $klonVerzeichnis = "D:\VM\Klon$i"
    while (Test-Path $klonVerzeichnis) {
        $i++
        $klonName = "Klon$i"
        $klonVmxPfad = "D:\VM\Klon$i\Klon$i.vmx"
        $klonVerzeichnis = "D:\VM\Klon$i"
    }
	
	Write-Host "Starte mit der Erstellung von Klon Nr.$i"

    & "C:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe" clone "$vorlagePfad" "$klonVmxPfad" full -cloneName="$klonName"
    
}

Write-Host "Klonerstellung abgeschlossen!"

Read-Host -Prompt "Enter zum Beenden"

