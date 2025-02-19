# Encode the XML File in Base64:

# Define the XML content as a string
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

# Output the Base64 encoded string to a file
$base64Encoded