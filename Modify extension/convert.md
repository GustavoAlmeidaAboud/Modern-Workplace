# Deploying Default Link Associations with Microsoft Intune

Step 1: Export Current Associations
First, export your current application associations using the Command Prompt or PowerShell with administrative rights:

Dism /Online /Export-DefaultAppAssociations:c:\temp\AppAssoc.xml

Step 2: Extract Relevant Associations

Extract the relevant part of the XML file for the application you want to set as the default. For this example, we'll focus on Microsoft Teams:

<?xml version="1.0" encoding="UTF-8"?>
<DefaultAssociations>
  <Association Identifier="tel" ProgId="AppXvks94gjj6kqyt3mdm6gdkn78zngpytfd" ApplicationName="Microsoft Teams" />
</DefaultAssociations>

Step 3: Encode the XML File in Base64
Encode the XML content in Base64 format using PowerShell:

# Define the XML content as a variable
$xmlContent = @"
<?xml version="1.0" encoding="UTF-8"?>
<DefaultAssociations>
  <Association Identifier="tel" ProgId="AppXvks94gjj6kqyt3mdm6gdkn78zngpytfd" ApplicationName="Microsoft Teams" />
</DefaultAssociations>
"@

# Convert the string to bytes
$bytes = [System.Text.Encoding]::UTF8.GetBytes($xmlContent)

# Convert the bytes to Base64
$base64Encoded = [Convert]::ToBase64String($bytes)

Step 4: Create a Custom Profile in Intune

Sign in to the Microsoft Intune admin center.

Go to Devices > Configuration profiles > Create profile.

Select Windows 10 and later as the platform.

Choose Custom as the profile type.

Step 5: Configure the Custom Profile

Enter a name and description for the profile.

In the OMA-URI Settings section, click Add.

Name: Enter a name for the setting.

Description: Enter a description (optional).

OMA-URI: Enter the OMA-URI path: ./Device/Vendor/MSFT/Policy/Config/ApplicationDefaults/DefaultAssociationsConfiguration
Data type: Select String.
Value: Paste the Base64 encoded content of your XML file here. It should look something like this:
PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4NCjxEZWZhdWx0QXNzb2NpYXRpb25zPg0KICA8QXNzb2NpYXRpb24gSWRlbnRpZmllcj0idGVsIiBQcm9nSWQ9IkFwcFh2a3M5NGdqajZrcXl0M21kbTZnZGtuNzh6bmdweXRmZCIgQXBwbGljYXRpb25OYW1lPSJNaWNyb3NvZnQgVGVhbXMiIC8+DQo8L0RlZmF1bHRBc3NvY2lhdGlvbnM+

Step 6: Assign the Profile
Assign the profile to the appropriate groups of devices or users.

Step 7: Monitor Deployment
After deploying the profile, monitor the deployment status in the Intune admin center to ensure it has been applied successfully.

Step 8: After the profile is applied computers have to been restarted to make it effective.