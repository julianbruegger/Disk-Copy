
function ID {$Disk_Number = Read-Host "Welche Nummer hat die Disk"}
function Kopiervorgang {
    $read_drive = Read-Host "Von welchem Laufwerksbuchtsaben wird gelesen?"
    $write_drive = Read-Host "Wohin soll kopiert werden"

    ID
    if ($ID -eq"") {
    ID
    }


    Write-Host $read_drive $Disk_Number "auf das Laufwerk" $write_drive

    $read_size = Get-ChildItem $read_drive":\" -recurse | Measure-Object -property length -sum | Select-Object Sum

    mkdir $write_drive":\"$Disk_Number

    robocopy $read_drive":\" $write_drive":\"$Disk_Number /MIR /MT[:2]

    $write_size=Get-ChildItem $write_drive":\"$Disk_Number -recurse | Measure-Object -property length -sum | Select-Object Sum


    Write-Host $read_size $write_size

    if($read_size -eq $write_size){
        $wshell = New-Object -ComObject Wscript.Shell
        $Output = $wshell.Popup("Noch ein Laufwerk kopieren?",0,"Laufwerk wurde erfolgreich kopiert",4)

        If ($Output -eq "6")
            {
                Kopiervorgang
            }
        else
            {
                # keine Aktion ausführen
            }

    }


    else{
        $wshell = New-Object -ComObject Wscript.Shell
        $Output = $wshell.Popup("Beim Kopieren ist ein Fehler aufgetreten",0,"FEHLER")
        }
    
}


Kopiervorgang
