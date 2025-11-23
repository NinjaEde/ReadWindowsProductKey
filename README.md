# 🔑 Read Windows 10/11 Product Key
A simple PowerShell script to read the Windows product key stored on the system.

![PowerShell](https://img.shields.io/badge/PowerShell-Script-blue?logo=powershell&style=flat)
![Windows](https://img.shields.io/badge/Windows-10/11-0078D6?logo=windows&style=flat)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Status-Stable-success)

---

## 📘 Overview

This repository provides a PowerShell script that reads the locally stored Windows 10/11 product key directly from the Registry.  
It is lightweight, safe, and requires no additional software.

---

## 🗂 Table of Contents

- [Description](#description)
- [Download](#download)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Common Errors & Solutions](#common-errors--solutions)
- [FAQ](#faq)
- [Security Notes](#security-notes)
- [License](#license)

---

## 📝 Description

This script reads the Windows product key from the Registry and outputs it directly to the PowerShell console.  
It does **not** change any system settings and **does not** write anything to the Registry.

Typical use cases:

- Documenting the product key
- Backing it up before a reinstall
- Verifying OEM/device transfers

---

## ⬇️ Download

File in this repository:

`read_win11_product_key.ps1`

---

## ✔️ Requirements

- Windows 10 or Windows 11  
- PowerShell (minimum version 5, default on Windows)

---

## 🛠️ Installation

No installation required.  
Just download the file and save it locally.

---

## ▶️ Usage

1. Open PowerShell
2. Change to the folder where the script is located:

```powershell
cd C:\Users\<USERNAME>\Downloads
```
Run the script:

```powershell
.\read_win11_product_key.ps1
```
If the system allows script execution, the product key will be displayed.

## ❗ Common Errors & Solutions
Because Windows PowerShell restricts scripts for security reasons, downloaded scripts are often blocked.
Below are common errors and how to resolve them.

### ❌ Error 1: “Script execution is disabled”
Example message:

```
The file ... cannot be loaded because running scripts is disabled on this system.
```
### ✅ Solution:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Then run again:

```powershell
.\read_win11_product_key.ps1
```

### ❌ Error 2: “The file is not digitally signed”
Example message:

```
The file ... is not digitally signed. You cannot run this script on the current system.
```

### ✅ Solution 1 — less restrictive:

```powershell
Set-ExecutionPolicy Unrestricted -Scope CurrentUser
```

### ✅ Solution 2 — maximum compatibility (no prompts):

```powershell
Set-ExecutionPolicy Bypass -Scope CurrentUser
```


### ❌ You are asked for confirmation every time (“[Y] Yes / [N] No”)
Cause:
Windows may block downloaded files by setting the Zone.Identifier.

### ✅ Solution A — unlock the file once:

```powershell
Unblock-File .\read_win11_product_key.ps1
```

### ✅ Solution B — stop prompts for all scripts:

```powershell
Set-ExecutionPolicy Bypass -Scope CurrentUser
```

### ⚠️ Note:
Using `Bypass` removes security prompts. Only use it if you trust the scripts.

## ❓ FAQ
Does the script work with OEM keys?
Yes — both OEM and retail keys are read correctly.

Does the script change anything on the system?
No — it only reads Registry values.

Can it read cloud-/Microsoft-account keys?
No. Those are not stored on the device.

Do I need admin rights?
Usually no. If the Registry is restricted, run PowerShell as Administrator.


## 🔐 Security Notes
The script itself is read-only and safe.

Changing the ExecutionPolicy can reduce system security.

You can restore the default policy at any time:

```powershell
Set-ExecutionPolicy Restricted -Scope CurrentUser
```

## 📄 License
This project is released under the MIT License.
Free to use, including commercially.


