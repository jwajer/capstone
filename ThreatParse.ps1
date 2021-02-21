# Array of websites containing threat intelligence
$drop_urls = @('https://rules.emergingthreats.net/blockrules/emerging-botcc.rules', 'https://rules.emergingthreats.net/blockrules/compromised-ips.txt')

# Loop through the URLs for the rules list
foreach ($u in $drop_urls) {

    # Extract the filename
    $temp = $u.split("/")
    
    # The last element in the array plucked off is the filename
    $file_name = $temp[-1]

    # Checks if the files exist, and if they do, the script continues
    if (Test-Path $file_name) {

        continue

    } else {

        # Download the rules list
        Invoke-WebRequest -Uri $u -OutFile $file_name

    } # Close if statement

} # Close the foreach loop

#Array with the filenames
$input_paths = @('compromised-ips.txt','.\emerging-botcc.rules')

# Extract the IP address
$regex_drop = '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b'

# Add the IP addresses to the temporary IP list
select-string -Path $input_paths -Pattern $regex_drop |
ForEach-Object { $_.Matches } |
ForEach-Object { $_.Value } | Sort-Object | Get-Unique |
Out-File -FilePath "bad-ips.tmp"


# Get the discovered IP addresses, loop through and replace the beginning of the line with IPTables syntax
# After the IP adddress, add the remaining IPTables syntax and save it to a file
# iptables -A INPUT -s IP -j DROP
(Get-Content -Path ".\bad-ips.tmp") | % `
{ $_ -replace "^","iptables -A INPUT -s " -replace "$"," -j DROP" } | `
Out-File -FilePath "iptables.bash"
