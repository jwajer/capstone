#!/bin/bash

#Admin and Security admin menu

#Admin menu function
function admin_menu() {

        #Clear the screen
        clear

        #Create menu options
        echo "1. List Running Processes"
        echo "2. Show Open Network Sockets"
        echo "3. Check currently logged in users"
        echo "4. Get Linux kernel and arch version"
		echo "5. Retrieve disk usage and statistics"
		echo "6. Obtain CPU specifications "
		echo "7. Obtain RAM statistics"
		echo "8. Obtain USB input device information"
		echo "9. Go back to main menu"
        echo "[E]xit"

        #Prompt for the menu option
        echo -n "Please enter a value from above: "
        #Read in the user input
        read option

        #Case statement to process options
        case "${option}" in

			#Prints out all running processes on the system.  Is useful for an admin to see what is running at
			#the time.
			1) ps -ef |less

            ;;

			#Shows all open network sockets.  Useful for an admin to see if there are any strange or unknown
			#sockets open on the system.
			2) netstat -an --inet |less
			   # lsof -i -n |less

            ;;

            #Retrieves all currently logged in users.  Useful to see if anyone logged in who shouldn't be.
			3) w |less

            ;;


			# So the user can inspect the results like you did in the options 1 - 3.
			#Gets the current Linux kernel and arch version.  Useful for an admin to check to see if the version
			#is out of date.  If it is, there could possibly be security issues that need to be patched.
            4) uname -a | less

            ;;

			#Retrieves the disk information for all physical and virtual disks.  Shows used space, free space, 
			#% used, dev, and mount point.  Useful for an admin to see if there is any anomalous activity with
			#the disks.
			5) df -k | less

			;;

			#Allows for the user to see the CPU of the system.  This would allow the admin to see the CPU specs
			#to help to determine performance if necessary.
			6) lscpu | less

			;;


			#Allows for the user to get memory statistics and information.  Includes total RAM amount, RAM used,
			#RAM free, and more statistics.  Useful for an admin to see RAM usage to see if it is too high and
			#more investigation is necessary as to why.
			7) cat /proc/meminfo | less

			;;

			#Gathers information on the USB input devices that are registered by the OS.  This allows for an 
			#admin to see if there are any devices connected that shouldn't be, such as an unregistered
			#flash drive.
			8) lsusb | less

			;;

			#Returns to the main menu
			9) main_menu

			;;

			# Exits the program
			[Ee]) exit 0

			;;

			# Catches for an invalid option and then returns the user to the admin menu
			*) echo "Invalid Option!"
					sleep 3
					admin_menu
			;;

        #Stops the case statement
        esac

#Show admin menu
admin_menu

}


#Main Menu
function main_menu() {

        #Clear the screen
        clear

        #Create menu options
        echo "1. Admin Menu"
        echo "2. Security Menu"
        echo "[E]xit"

        #Prompt for the menu option and read in the option
        read -p "Please enter in a value from above: " option

        #Case statement to process options
        case "${option}" in

				# Calls the admin menu
                1) admin_menu

                ;;

				# Calls the security menu
                2) security_menu

                ;;

				# Exits the program
                [Ee]) exit 0

				;;

				# Catches for an invalid option and then returns the user to the main menu
                *) echo "Invalid Option!"
                        sleep 3
                        main_menu

                ;;

        #Stops the case statement
        esac

#Shows the main menu
main_menu
}


#Security Menu Function
function security_menu() {

        #Clear the screen
        clear

        #Create the menu
        echo "1. Show last logged in users"
        echo "2. Check installed packages"
        echo "3. Check all users and their IDs"
		echo "4. Go to the Incident Response Collection"
        echo "5. Return to the main menu"
        echo "[E]xit"

        #Prompt the user for input
        read -p "Please select an option from above: " option

		case "${option}" in

				# This command allows a security admin to see who was the user who was last logged
				# in to the system, which can be useful in determining a timeline for an incident
                1) last -adx |less

                ;;

				# This command allows a security admin to see all of the installed packages on the system,
				# making it easy to spot suspicious packages
                2) dpkg -l |less

                ;;

				# This command shows the security admin all of the users and IDs that are present on the system
                3) cut -d: -f1,3 /etc/passwd |less

                ;;

				# Opens the IR Collect menu
				4) ir_collect_menu

				;;

				# Returns the user to the main menu
                5) main_menu

                ;;

				# Exits the program
                [Ee]) exit 0

                ;;

				# Catches an invalid option not defined above
                *) echo "Invalid input"
                        sleep 3
                        security_menu

                ;;

		#Stop the case statement
		esac

#Shows the security admin menu
security_menu

}


#Incident Response Collection Menu Function
function ir_collect_menu() {

	#Clear the screen
	clear

	#Create a menu
	echo "1. Access the sudoers file"
	echo "2. Access password file"
	echo "3. View the history file"
	echo "4. View the SSH hosts file"
	echo "5. View the SSH authorized keys file"
	echo "6. View all open files"
	echo "7. See permissions for the root directory"
	echo "8. View scheduled commands in the crontabs file"
	echo "9. Locate all log files"
	echo "10. Locate remote hosts file"
	echo "11. Return to the Security Admin Menu"
	echo "12. Return to the Main Menu"
	echo "[E]xit"

	#Prompt the user for input
	read -p "Please select an option from above: " option

	case "${option}" in

		#This command allows the user to view the /etc/sudoers file, which lists all of the users on the
		#system who are part of the sudoers group.  This would be useful for an admin to double check if
		#there are any users who are in the sudoers group who shouldn't be, which would be an object
		#of suspicion in the wake of an attack.
		1) sudo cat/etc/sudoers | less

		;;

		#This command allows the user to view the /etc/shadow file, which lists all of the password hashes
		#for each user on the system.  This would be useful for an admin to see if any of the hashes had
		#changed, which could be a sign that an attacker changed the passwords for accounts in order to
		#cover their tracks.
		2) sudo cat/etc/shadow | less

		;;

		#This command allows the user to view the history file, which is a history of all of the commands
		#executed.  Assuming the file wasn't wiped by an attacker, it would be a very useful place to start
		#an investigation as you could see all of the commands they executed.
		3) cat /home/*/.*hist* |less

		;;

		#This command allows the user to view the known_hosts file in the SSH directory, which lists all of
		#the public key data of known server hosts.  This could be used to see if there are any public keys
		#added to the file without the admin's knowledge.  The file is used to verify that the host key
		#offered by the server hasn't changed.
		4) cat /home/*/.ssh/known_hosts |less

		;;

		#This command allows the user to view the authorized_keys file in the SSH directory.  This file
		#allows for anyone with the public key matching the authorized key to log onto the system without
		#needing a password.  An attacker could have used SSH to access the system, and looking at this file
		#could see if it has been tampered in any way.
		5) cat /home/*/ssh/authorized_keys |less

		;;

		#The lsof command allows for a user to see all files that are opened by any process on the entire
		#system.  The -n tells the command to not resolve hostnames (no DNS).  The -P tells the command to
		#not resolve port names and instead list the port number.  The -i tells the command to list the IP
		#sockets.  This command could let a user know if there are any files open on the system, which would
		#be useful in the wake of an attack to see if the attacker left any files open, which would provide
		#an excellent place to begin an investigation.
		6) lsof -nPi

		;;

		#This command shows the user the files that are present in the root directory.  The -a tells the
		#command to list all files, including hidden files.  The -l lists the results in long format,
		#displaying file types, permissions, hard links, owner, last modified date, and filename among
		#other attributes.  The -h prints file sizes in human readable format, such as 7K or 143M.  This
		#command would allow for a user to see if there have been any modifications to the root directory
		#or any files within it.  This could help for the user to diagnose the damage to a system if the root
		#directory was compromised.
		7) ls -alh /root/

		;;

		#This command allows the user to view the crontabs file.  Crontabs are tet files containing a list of
		#commands meant to be run at specified commands.  Running this command could be useful to see if an
		#attacker added any crontabs files to execute commands on a schedule.  If this did happen, then more
		#damage could still occur on a system.  It would be beneficial to run this command to ensure that more
		#issues won't arise from a stopped breach.
		8) cat /var/spool/cron/crontabs/* |less

		;;

		#This command locates all log files on the system.  This could be used by a user to find the location
		#of all log files to do more in depth recon on an attack that occurred.  Also, if any files have been
		#removed, the user could find out by executing this command by referencing what logs should be present
		9) find /var/log type f perm 0004 2>/dev/null |less

		;;

		#This command allows the user to see the location of the rhosts file.  This could be useful for a user
		#to see if this file has been moved in any way, or removed altogether.  The user could open the file
		#and see if any changes have been made to it.  If there have been changes, then it could be another
		#route an intruder could use to get into a system.  Sleep 5 was added to allow the user to actually
		#see the directory location instead of it disappearing right away.
		10) locate rhosts
			sleep 5

		;;

		# Returns the user to the security menu
		11) security_menu

		;;

		# Returns the user to the main menu
		12) main_menu

		;;

		# Exits the program
		[Ee]) exit 0

		;;

		# Catches for an invalid option and then returns the user to the IR Collect menu
		*) echo "Invalid input"
			sleep 3
			ir_collect_menu

		;;

	#Stop the case statement
	esac

#Shows the Incident Response Collection menu
ir_collect_menu
}

main_menu
