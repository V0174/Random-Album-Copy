$startFolder=$args[0]
$targetFolder=$args[1]
$MaxSize=$args[2] * 1MB

if ($MaxSize -eq $Null) {
    "Použití: randomAlbum.ps1 zdrojový_adresář cílový_adresář velikost[MB]"
    exit
}

$colItems = (Get-ChildItem $startFolder -recurse | Where-Object {$_.PSIsContainer -eq $True})
$seznamAdresaru = New-Object System.Collections.ArrayList
foreach ($i in $colItems) {
    $subFolderItems = (Get-ChildItem $i.FullName | Measure-Object -property length -sum -ErrorAction SilentlyContinue)
    if ($subFolderItems.sum -ne $Null) {
        $malepole = $i.FullName, ($subFolderItems.sum)
        $seznamAdresaru.add($malepole) | out-null
    }
}
$pocetAddr = $seznamAdresaru.Count

"Zdrojový adresář: " + $startFolder
"Cílový adresář: " + $targetFolder
"Maximální velikost: " + $maxSize / 1MB
"Počet adresářů: " + $pocetAddr
#"Výpis adresářů: "
#foreach ($i in $seznamAdresaru) {
# $i[0] + " - " + $i[1]
#}
echo "Počítám..."

$celkovaVelikost = 0
$vybraneAdresare = @()

while ($true) {
    $nahoda = Get-Random -minimum 0 -maximum $pocetAddr
    if ($celkovaVelikost + $seznamAdresaru[$nahoda][1] / 2 -lt $maxSize) {
        $vybraneAdresare += $seznamAdresaru[$nahoda][0]
        $celkovaVelikost += $seznamAdresaru[$nahoda][1]
        $seznamAdresaru.RemoveAt($nahoda)
        $pocetAddr--
        if ($pocetAddr -eq 0) {
            "Zkopírovány všechny soubory, končím."
            break
        }
    }
    else {
        break
    }
}

"Celková velikost: " + "{0:N2}" -f ($celkovaVelikost / 1MB) + " MB"
"Počet vybraných adresářů: " + $vybraneAdresare.Count
"Kopíruji adresáře: "
foreach ($i in $vybraneAdresare) {
    "" + ($vybraneAdresare.indexOf($i)+1) + "/" + $vybraneAdresare.Count + ": " + $i
    $rodicAdresar = Split-Path $i | Split-Path -leaf
    $adresar = Split-Path $i -leaf
    #echo $rodicAdresar
    Copy-Item $i "$targetFolder\$rodicAdresar\$adresar" -Recurse
}

# .\randomcopy.ps1 "S:\Dokumenty\My Music\sbírka" "E:\Hudba" 10000