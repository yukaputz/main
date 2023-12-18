Install-WindowsFeature -Name FS-Resource-Manager -IncludeManagementTools
Set-FsrmSetting -SmtpServer "smtp.example.com" -AdminEmailAddress "admin@example.com" -FromEmailAddress "fsrm@example.com" -EmailSubjectPrefix "[FSRM]"$threshold = New-FsrmQuotaThreshold -Path "C:\path\to\directory" -Percentage 80
Send-MailMessage -To "recipient@example.com" -From "sender@example.com" -Subject "Test Email" -Body "This is a test email." -SmtpServer "smtp.example.com"
Set-FsrmSetting -EmailNotificationLimit 1 -EventNotificationLimit 1 -CommandNotificationLimit 1 -ReportNotificationLimit 1
New-FsrmQuota -Path "C:\path\to\directory" -Size 1GB -Notification $threshold -Template "Monitoring Template"
New-FsrmFileScreen 