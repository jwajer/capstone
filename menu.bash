#!/bin/bash

# Creates a menu for admin, VPN, and security functions


function invalid_option () {

    echo ""
    echo "That was an invalid option."
    echo ""
    sleep 2

}


function menu() {
    
    # Clears the screen
    clear

    # Creating our options
    echo "[1] Admin Menu"
    echo "[2] VPN Menu"
    echo "[3] Exit"
    read -p "Please enter an option above: " option

    case "$option" in

        1) admin_menu
        ;;

        2) vpn_menu
        ;;

        3) exit 0
        ;;

        *)   
        
            invalid_option
         
            #Call the main menu
            menu

        ;;

    esac


}

function admin_menu () {

    echo "[L]ist Running Processes"
    echo "[N]etwork sockets"
    echo "[V]PN Menu"
    echo "[4] Exit"
    read -p "Please enter an option above: " option

    case "$choice" in

        L|l) ps -ef
        ;;
        N|n) netstat -an --inet
        ;;
        V|v) vpn_menu
        ;;
        4) exit 0
        ;;

        *)
        
            invalid_option

            #Call the admin menu
            admin_menu

        ;;

    esac

admin_menu
}


function vpn_menu() {

    echo "[A]dd a peer"
    echo "[D]elete a peer"
    echo "[B]ack to admin menu"
    echo "[M]ain menu"
    echo "[E]xit"
    read -p "Please select an option above: " option

    case "$option" in

        A|a)

            bash peer.bash
            tail -6 wg0.conf | less

        ;;

        D|d)
        # Create a prompt for the user
        # Call the manage-user.bash file and pass the proper switches
        # and argument to delete the user

        ;;

        B|b) admin_menu

        ;;

        M|m) menu

        ;;

        E|e) exit 0

        ;;

        *)

            invalid_option

            # Call the VPN menu
            vpn_menu           

        ;;
    esac

vpn_menu
}


# Call the main function
menu
