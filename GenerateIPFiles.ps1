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