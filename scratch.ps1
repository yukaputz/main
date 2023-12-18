# Install File Server Resource Manager feature
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
