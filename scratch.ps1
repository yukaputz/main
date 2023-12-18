# Import the FSRM module
Import-Module FileServerResourceManager

# Create a new file screen using the Block Audio and Video Files template
$fsrmScreenTemplate = Get-FsrmFileScreenTemplate | Where-Object { $_.Description -eq "Block Audio and Video Files" }

if ($fsrmScreenTemplate -ne $null) {
    # Specify the path to apply the file screen (adjust the path as needed)
    $pathToScreen = "C:\Path\To\Your\Folder"

    # Create the file screen
    New-FsrmFileScreen -Path $pathToScreen -Template $fsrmScreenTemplate

    # Add specific file extensions to the block (flv and thumbs.db)
    $blockedFileExtensions = @(".flv", "thumbs.db")
    foreach ($extension in $blockedFileExtensions) {
        Add-FsrmFileScreenExtension -Path $pathToScreen -FileType $extension -Action Block
    }

    Write-Host "File screen created successfully."
} else {
    Write-Host "Error: Block Audio and Video Files template not found."
}














Install File Server Resource Manager feature
Install-WindowsFeature -Name FS-Resource-Manager -IncludeManagementTools

# Configuration variables
$fileGroup = "AudioVideoFiles"
$fileScreenTemplateName = "BlockAudioVideoFiles"
$fileScreenPath = "C:\Shares\BlockingPath"  # Set your desired path
$notificationTemplateName = "BlockNotificationTemplate"
$notificationSender = "noreply@example.com"
$notificationRecipients = "admin@example.com"

# Create file group for audio and video files
New-FsrmFileGroup -Name $fileGroup -IncludePattern @("*.mp3", "*.wav", "*.mp4", "*.avi")

# Create file screen template for blocking
New-FsrmFileScreenTemplate -Name $fileScreenTemplateName -IncludeGroup $fileGroup -Action Block

# Create file screen on the specified path using the template
New-FsrmFileScreen -Path $fileScreenPath -Template $fileScreenTemplateName

# Create notification template
New-FsrmFileScreenTemplate -Name $notificationTemplateName -IncludeGroup $fileGroup -Action Email -MailTo $notificationRecipients -MailFrom $notificationSender -Subject "Blocked File Notification" -Message "A user attempted to save a blocked file."

# Apply notification template to the file screen
Set-FsrmFileScreen -Path $fileScreenPath -Notification $notificationTemplateName



