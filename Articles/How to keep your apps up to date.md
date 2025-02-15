I've been using Winget for the past few years, and it's clear that keeping your applications updated is crucial for minimizing vulnerabilities in your environment.

So let's get started.

## User Context

To update user context apps (which are installed in the user profile, such as in "AppData" and similar locations typically found under HKEY_USERS), we need to handle updates differently from system applications.

To perform these updates, I use a Remediation Script, which runs every day at a specific time or whenever you configure it to run.

### Detection.ps1

[Description of what Detection.ps1 does]

### Remediation.ps1

This script will update all applications that are compatible with Winget. The good news is that even if you installed an application through an .exe or .msi, Winget might detect and update it.

Remember to mark:
- Run in PowerShell 64-bit
- Run this as the signed-in user

## System Context

Updating system-wide applications can be more complicated, especially if you're just starting to deploy Winget installations system-wide. This is because you can't call the Winget command directly through the system PowerShell; you need to navigate to the path and execute it from there. I've sorted this out in the script with functions, so no worries about that.

### Detection.ps1

The detection script will verify if there are updates to be done. If there are updates needed, it will trigger the remediation script.

### Remediation.ps1

The remediation script will update all system-wide applications. The good thing is that it will not close applications that are currently running; they will be updated the next time the user runs the app.


I have added exclusions on apps where I would not recommend updating it through winget but instead update it through Configuration Profile, such as Teams, Edge, Office 365 packages. Also some developers apps might be senstivity to 