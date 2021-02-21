# Login to a remote SSH server
#New-SSHSession -ComputerName '10.1.1.10' -Credential (Get-Credential student1)

# Loop that runs the actual SSH script
while ($True) {

    # Add a prompt to run commands
    $command = Read-Host -Prompt "Please enter a command to run: "

    # Run command on remote SSH server
    (Invoke-SSHCommand -index 0 $command).Output

} # Closes while loop

<#


Set-SCPFile -Computername '10.1.1.10' -Credential (Get-Credential student1)
-RemotePath '/home/student1' -LocalFile '.\ips-bad.txt'

#>