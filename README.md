# 🔑 Windows 10/11 Product Key auslesen  
Ein einfaches PowerShell-Script zum Auslesen des im System hinterlegten Windows-Produktschlüssels.

![PowerShell](https://img.shields.io/badge/PowerShell-Script-blue?logo=powershell&style=flat)
![Windows](https://img.shields.io/badge/Windows-10/11-0078D6?logo=windows&style=flat)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Status-Stable-success)

---

## 📘 Übersicht

Dieses Repository stellt ein PowerShell-Script zur Verfügung, das den lokal gespeicherten Windows 10/11 Product Key direkt aus der Registry ausliest.  
Es ist schlank, sicher und benötigt keinerlei zusätzliche Software.

---

## 🗂 Inhaltsverzeichnis

- [Beschreibung](#-beschreibung)
- [Download](#-download)
- [Voraussetzungen](#-voraussetzungen)
- [Installation](#️-installation)
- [Nutzung](#-nutzung)
- [Häufige Fehler & Lösungen](#-häufige-fehler--lösungen)
- [FAQ](#-faq)
- [Screenshots](#-screenshots)
- [Sicherheitshinweise](#-sicherheitshinweise)
- [Lizenz](#-lizenz)

---

## 📝 Beschreibung

Dieses Script liest den Windows-Produktschlüssel aus der Registry aus und zeigt ihn direkt im PowerShell-Terminal an.  
Es verändert **keinerlei** Systemeinstellungen und schreibt **nichts** in die Registry.

Typische Einsatzfälle:

- Dokumentation des Produktkeys  
- Sichern vor einer Neuinstallation  
- OEM-/Gerätewechsel überprüfen  

---

## ⬇️ Download

Datei im Repository:

read_win11_product_key.ps1


---

## ✔️ Voraussetzungen

- Windows 10 oder Windows 11  
- PowerShell (mind. Version 5, Standard bei Windows)

---

## 🛠️ Installation

Keine Installation nötig.  
Einfach die Datei herunterladen und lokal speichern.

---

## ▶️ Nutzung

1. PowerShell öffnen  
2. Ordner wechseln, in dem das Script liegt:

```powershell
cd C:\Users\<USERNAME>\Downloads```
Script ausführen:

```
.\read_win11_product_key.ps1```
Wenn das System Skripte zulässt, wird der Product Key direkt angezeigt.

## ❗ Häufige Fehler & Lösungen
Da Windows PowerShell aus Sicherheitsgründen einschränkt, werden Skripte häufig blockiert.
Hier findest du alle typischen Fehler + Lösungen.

### ❌ Fehler 1: „Die Ausführung von Skripts ist deaktiviert“
Fehlermeldung (Beispiel):

```
Die Datei ... kann nicht geladen werden, da die Ausführung von Skripts auf diesem System deaktiviert ist.
```
### ✅ Lösung:

```Set-ExecutionPolicy RemoteSigned -Scope CurrentUser```

Danach erneut:

```.\read_win11_product_key.ps1```

### ❌ Fehler 2: „Die Datei ist nicht digital signiert“
Fehlermeldung (Beispiel):

```Die Datei ... ist nicht digital signiert. Sie können dieses Skript nicht ausführen.```

### ✅ Lösung 1 – weniger restriktiv:

```Set-ExecutionPolicy Unrestricted -Scope CurrentUser```

### ✅ Lösung 2 – maximale Kompatibilität (keine Rückfragen):

```Set-ExecutionPolicy Bypass -Scope CurrentUser```


### ❌ Jedes Mal erscheint eine Bestätigungsabfrage („[J] Ja / [N] Nein“)
Ursache:
Windows blockiert heruntergeladene Dateien (Zone.Identifier).

### ✅ Lösung A – Datei einmalig entsperren:

```Unblock-File .\read_win11_product_key.ps1```

### ✅ Lösung B – Keine Rückfragen mehr für alle Skripte:
```Set-ExecutionPolicy Bypass -Scope CurrentUser```

### ⚠️ Hinweis:
Bypass entfernt alle Sicherheitsabfragen.
Nur nutzen, wenn du Skripten vertraust.

## ❓ FAQ
Funktioniert das Script auch mit OEM-Keys?
Ja, sowohl OEM- als auch Retail-Keys werden korrekt ausgelesen.

Verändert das Script irgendetwas am System?
Nein – es liest ausschließlich Registry-Werte.

Kann ich damit Cloud-/Microsoft-Account-Keys auslesen?
Nein. Diese werden nicht im System gespeichert.

Muss ich Adminrechte haben?
Nein, normalerweise nicht.
Falls die Registry gesperrt wurde: PowerShell als Admin starten.


## 🔐 Sicherheitshinweise
Das Script selbst ist sicher und nur lesend.

ExecutionPolicy-Änderungen können das System öffnen.

Du kannst die Standard-Sicherheit jederzeit wieder aktivieren:

```Set-ExecutionPolicy Restricted -Scope CurrentUser```

## 📄 Lizenz
Dieses Projekt ist unter der MIT License veröffentlicht.
Frei nutzbar, auch kommerziell.


