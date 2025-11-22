# Ausführung: PowerShell als Administrator öffnen, Code einfügen und Enter.
# Ausgabe: Gefundene(n) Produktschlüssel im Klartext.

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Get-ProductKeyFrom-UEFI {
    try {
        $oa = Get-CimInstance -ClassName SoftwareLicensingService -ErrorAction Stop
        $key = $oa.OA3xOriginalProductKey
        if ([string]::IsNullOrWhiteSpace($key)) { return $null }
        [pscustomobject]@{
            Source = "UEFI/MSDM (OEM-BIOS)"
            Key    = $key
            Notes  = "Vom Mainboard ausgelesen"
        }
    } catch { $null }
}

function Get-ProductKeyFrom-Backup {
    try {
        $p = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform' -ErrorAction Stop
        $key = $p.BackupProductKeyDefault
        if ([string]::IsNullOrWhiteSpace($key)) { return $null }
        [pscustomobject]@{
            Source = "BackupProductKeyDefault"
            Key    = $key
            Notes  = "Von SoftwareProtectionPlatform"
        }
    } catch { $null }
}

function Get-ProductKeyFrom-DigitalProductId {
    # Dekodiert den installierten Key aus der Registry (funktioniert für Win 7–11, inkl. MAK/KMS/GVLK).
    try {
        $regPaths = @(
            'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion',
            'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion'
        )

        foreach ($rp in $regPaths) {
            try {
                $dpi = (Get-ItemProperty -Path $rp -Name 'DigitalProductId' -ErrorAction Stop).DigitalProductId
            } catch { continue }

            if (-not $dpi) { continue }

            $key = Convert-DigitalProductIdToKey -DigitalProductId $dpi
            if ($key) {
                return [pscustomobject]@{
                    Source = "Registry (DigitalProductId)"
                    Key    = $key
                    Notes  = "Installierter Schlüssel (bei KMS meist generischer GVLK)"
                }
            }
        }
        $null
    } catch { $null }
}

function Convert-DigitalProductIdToKey {
    param(
        [Parameter(Mandatory)]
        [byte[]]$DigitalProductId
    )

    # Microsofts Base24-Zeichensatz (ohne I, O, U, A, S, Z etc.)
    $chars = "BCDFGHJKMPQRTVWXY2346789".ToCharArray()

    # Key liegt ab Offset 52 über 15 Bytes
    $keyOffset = 52
    $pid = New-Object byte[] 15
    [Array]::Copy($DigitalProductId, $keyOffset, $pid, 0, 15)

    # Für Windows 8+ gibt es ein Flag in Byte 66; die Standard-Dekodierung funktioniert jedoch allgemein.
    $result = ""
    for ($i = 24; $i -ge 0; $i--) {
        $current = 0
        for ($j = 14; $j -ge 0; $j--) {
            $current = ($current * 256) + $pid[$j]
            $pid[$j] = [math]::Floor($current / 24)
            $current = $current % 24
        }
        $result = $chars[$current] + $result
        if (($i % 5) -eq 0 -and $i -ne 0) { $result = "-" + $result }
    }

    # Ergebnis im Format XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
    if ($result -match '^[A-Z0-9\-]{29}$') { $result } else { $null }
}

# --- Lauf ---

$found = @()
$found += Get-ProductKeyFrom-UEFI
$found += Get-ProductKeyFrom-Backup
$found += Get-ProductKeyFrom-DigitalProductId

if (-not $found -or $found.Count -eq 0) {
    Write-Host "Es konnte kein Produktschlüssel ausgelesen werden." -ForegroundColor Yellow
    Write-Host "Hinweise:" -ForegroundColor Yellow
    Write-Host "• Bei KMS-Aktivierung wird oft nur ein generischer GVLK verwendet und ggf. nicht vollständig gespeichert."
    Write-Host "• Stelle sicher, dass du PowerShell mit Administratorrechten ausführst."
    exit 1
}

# Doppelte/identische Keys filtern
$unique = $found | Where-Object { $_ -and $_.Key } | Group-Object Key | ForEach-Object { $_.Group[0] }

Write-Host "`nGefundene Windows-Produktschlüssel:" -ForegroundColor Cyan
$unique | ForEach-Object {
    "{0,-30} {1}" -f ($_.Source + ":"), $_.Key
}

Write-Host "`nTipp:" -ForegroundColor Gray
Write-Host "• Für Neuinstallation mit Volumenlizenz (MAK/KMS) nutzt du den passenden MAK/GVLK + Key-Management (z. B. KMS-Host)."
Write-Host "• Den Schlüssel sicher aufbewahren."
