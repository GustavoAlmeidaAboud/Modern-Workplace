Sure, here's a more casual and engaging version for LinkedIn:

---

## Make Teams Your Default for Phone Numbers

If you've moved your telephony to Teams, you might have noticed that clicking on a phone number doesn't automatically open Teams. Instead, it asks you to choose an application. This happens because the Tel protocol doesn't switch to Teams by default. Here's a quick guide to fix that across all your devices.

### Quick Guide

**Step 1: Create a Custom Profile in Intune**

1. **Sign in** to the Microsoft Intune admin center.
2. **Go to** Devices > Configuration profiles > Create profile.
3. **Select** Windows 10 and later as the platform.
4. **Choose** Custom as the profile type.

**Step 2: Configure the Custom Profile**

1. **Enter** a name and description for the profile.
2. In the OMA-URI Settings section, **click Add**.
3. **Name**: Enter a name for the setting.
4. **Description**: Enter a description (optional).
5. **OMA-URI**: `./Device/Vendor/MSFT/Policy/Config/ApplicationDefaults/DefaultAssociationsConfiguration`
6. **Data type**: String
7. **Value**: `PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4NCjxEZWZhdWx0QXNzb2NpYXRpb25zPg0KICA8QXNzb2NpYXRpb24gSWRlbnRpZmllcj0idGVsIiBQcm9nSWQ9IkFwcFh2a3M5NGdqajZrcXl0M21kbTZnZGtuNzh6bmdweXRmZCIgQXBwbGljYXRpb25OYW1lPSJNaWNyb3NvZnQgVGVhbXMiIC8+DQo8L0RlZmF1bHRBc3NvY2lhdGlvbnM+`

**Step 3: Assign the Profile**

Assign the profile to the appropriate groups of devices or users.

**Step 4: Monitor Deployment**

After deploying the profile, monitor the deployment status in the Intune admin center to ensure it has been applied successfully.

**Step 5: Restart Computers**

After the profile is applied, computers need to be restarted to make it effective.

### Full Guide

**Step 1: Export Current Application Associations**

Use Command Prompt or PowerShell with administrative rights:
```powershell
Dism /Online /Export-DefaultAppAssociations:c:\temp\protocols.xml
```

**Step 2: Extract Relevant XML**

Extract the part of the XML file for Microsoft Teams:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<DefaultAssociations>
  <Association Identifier="tel" ProgId="AppXvks94gjj6kqyt3mdm6gdkn78zngpytfd" ApplicationName="Microsoft Teams" />
</DefaultAssociations>
```

**Step 3: Encode XML in Base64**

Encode the XML content in Base64 format using PowerShell:
```powershell
$xmlContent = @"
<?xml version="1.0" encoding="UTF-8"?>
<DefaultAssociations>
  <Association Identifier="tel" ProgId="AppXvks94gjj6kqyt3mdm6gdkn78zngpytfd" ApplicationName="Microsoft Teams" />
</DefaultAssociations>
"@

$bytes = [System.Text.Encoding]::UTF8.GetBytes($xmlContent)
$base64Encoded = [Convert]::ToBase64String($bytes)
```

**Step 4: Create and Configure Custom Profile in Intune**

Follow the steps mentioned in the Quick Guide to create and configure the custom profile.

**Step 5: Assign and Monitor**

Assign the profile to the appropriate groups and monitor the deployment status.

**Step 6: Restart Computers**

Ensure computers are restarted to apply the changes.

---

There you go! Now, the Tel protocol will be associated with Teams. 🚀

Feel free to tweak it further to match your style! 😊