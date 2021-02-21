# Send an email to test Powershell lab

# Body of the email
$msg = "Hello there. General Kenobi"

#Echos the message to the screen
write-host -BackgroundColor DarkGreen -ForegroundColor Cyan $msg

# Email From Address
$email = "jackson.wajer@mymail.champlain.edu"

# To address
$toEmail = "jcwajer@gmail.com"

# Sending the email
# NOTE: This below command won't actually send the email as the mail server in question is on Champlain's network
#Send-MailMessage -From $email -to $toEmail -Subject "General Grievous" -body $msg -SmtpServer 192.168.6.71

