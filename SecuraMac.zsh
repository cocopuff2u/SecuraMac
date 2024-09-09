#!/bin/zsh

####################################################################################################
#
# SecuraMac
#
# Purpose: SecuraMac simplifies macOS security, offering quick and effective tools to fortify your
# system and ensure protection.
#
# https://github.com/cocopuff2u
#
####################################################################################################
#
# HISTORY
#
# 1.0 09/04/24 - Master Release
#
#
####################################################################################################

# Define the maximum number of allowed attempts for any input
MAX_ATTEMPTS=3

# Functions to set text attributes and colors using tput
export RESET_FORMAT='tput sgr0'
export BOLD='tput bold'
export UNDERLINE='tput smul'
export REVERSE='tput rev'

# Basic Colors
export RED='tput setaf 1'
export GREEN='tput setaf 10'
export BLUE='tput setaf 4'
export YELLOW='tput setaf 3'
export MAGENTA='tput setaf 5'
export CYAN='tput setaf 6'
export WHITE='tput setaf 7'
export ORANGE='tput setaf 214'

# Background Colors
export RED_BG='tput setab 1'
export GREEN_BG='tput setab 2'
export DEFAULT_BG='tput setab 0'

# Bright Colors
export BRIGHT_RED='tput setaf 9'
export BRIGHT_GREEN='tput setaf 10'
export BRIGHT_BLUE='tput setaf 12'

# 256 Colors
export COLOR256='tput setaf 82'

# Functions to print text with various colors and attributes
print_red() {
    eval "$RED"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_orange() {
    eval "$ORANGE"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_green() {
    eval "$GREEN"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_green_bold() {
    eval "$GREEN"
    eval "$BOLD"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_blue() {
    eval "$BLUE"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_yellow() {
    eval "$YELLOW"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_magenta_bold() {
    eval "$MAGENTA"
    eval "$BOLD"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_magenta() {
    eval "$MAGENTA"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_cyan() {
    eval "$CYAN"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_white() {
    eval "$WHITE"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_white_bold() {
    eval "$WHITE"
    eval "$BOLD"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_red_bg() {
    eval "$RED_BG"
    eval "$RED"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_green_bg() {
    eval "$GREEN_BG"
    eval "$GREEN"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_bright_red() {
    eval "$BRIGHT_RED"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_bright_red_bold() {
    eval "$BRIGHT_RED"
    eval "$BOLD"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_bright_green() {
    eval "$BRIGHT_GREEN"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_bright_blue() {
    eval "$BRIGHT_BLUE"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_color256() {
    eval "$COLOR256"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

# Rainbow color function
print_rainbow() {
    local text="$1"
    local i=0
    local colors=("$RED" "$YELLOW" "$GREEN" "$CYAN" "$WHITE" "$MAGENTA")

    for ((i=0; i<${#text}; i++)); do
        eval "${colors[$((i % 6))]}"
        printf "%s" "${text:$i:1}"
    done
    printf "\n"
    eval "$RESET_FORMAT"
}

# Clear the screen
clear

intro_logo() {
    # ASCII Logo with SecuraMac
    print_green_bold "                                                                                "
    print_green_bold "┌──────────────────────────────────────────────────────────────────────────────┐"
    print_green_bold "│                                                                              │"
    print_green_bold "│ ███████╗███████╗ ██████╗██╗   ██╗██████╗  █████╗ ███╗   ███╗ █████╗  ██████╗ │"
    print_green_bold "│ ██╔════╝██╔════╝██╔════╝██║   ██║██╔══██╗██╔══██╗████╗ ████║██╔══██╗██╔════╝ │"
    print_green_bold "│ ███████╗█████╗  ██║     ██║   ██║██████╔╝███████║██╔████╔██║███████║██║      │"
    print_green_bold "│ ╚════██║██╔══╝  ██║     ██║   ██║██╔══██╗██╔══██║██║╚██╔╝██║██╔══██║██║      │"
    print_green_bold "│ ███████║███████╗╚██████╗╚██████╔╝██║  ██║██║  ██║██║ ╚═╝ ██║██║  ██║╚██████╗ │"
    print_green_bold "│ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝ │"
    print_green_bold "│ https://github.com/cocopuff2u/SecuraMac                                      │"
    print_green_bold "└──────────────────────────────────────────────────────────────────────────────┘"
    print_green_bold ""

    # Prompt for user options
    print_white_bold "Welcome to SecuraMac!"
    print_white ""
    print_white "SecuraMac simplifies macOS security, offering quick and effective tools to fortify your system and ensure protection. "
    print_white ""
}

intro_logo

print_orange "##############################"
print_orange "# BEFORE PROCEEDING"
print_orange "##############################"
print_orange ""
print_orange "      1. Maximize Terminal Window to Full Screen or Largest Possible Size"
print_orange "      2. Verify terminal has full disk access"
print_orange "      3. Data loss is possible; ensure you have a backup"
print_orange ""
print_orange ""
print_orange "I have confirmed and i want to proceed:"
print_orange "1. Yes"
print_orange "2. No"
print_orange ""

# Loop until a valid choice is made
while true; do
    printf "%bEnter your choice [Y/N]: %b" "$(eval "$ORANGE")" "$(eval "$RESET_FORMAT")"; read choice

    # Process user input
    case "$choice" in
        1|y|Y|yes|YES)
            print_orange "Proceeding..."
            sleep 1
            clear
            print_green "Verifying Full Disk Access...."
            sleep 1
            clear
            # Place the code to execute if the user chooses Yes here
            break
            ;;
        2|n|N|no|NO)
            print_orange "Operation aborted."
            exit 1
            ;;
        *)
            print_bright_red_bold "Invalid choice. Please enter y for Yes or n for No."
            ;;
    esac
done

# Attempting to check Full Disk Access for Terminal
if sudo test -r "/Library/Application Support/com.apple.TCC/TCC.db" 2>/dev/null; then
    intro_logo
else
    intro_logo
    print_bright_red_bold "##############################"
    print_bright_red_bold "Terminal does not have Full Disk Access."
    print_bright_red_bold "##############################"
    print_bright_red_bold "Please grant Full Disk Access to Terminal by following these steps:"
    print_bright_red_bold "1. Open System Settings."
    print_bright_red_bold "2. Go to Privacy & Security > Full Disk Access."
    print_bright_red_bold "3. Click the '+' button and add Terminal from /Applications/Utilities."
    print_bright_red_bold "4. If prompted, enter your password to make changes."
    print_bright_red_bold "5. Restart Terminal for the changes to take effect."
    print_bright_red_bold ""
    print_bright_red_bold ""
fi

print_green "##############################"
print_green "# Please select an option:"
print_green "##############################"
print_green ""
print_green "1. Perform Full SecuraMac (Runs Full Security Options)"
print_green "2. Perform Log SecuraMac (Runs Only Logging Security Options)"
print_green "3. Perform Disable SecuraMac (Gives Options to Disable)"
print_green "4. Full SecuraMac System Report (Shows report of current settings)"
print_green "5. Exit"
print_green ""

while true; do
    # Print prompt in yellow and read input on the same line
    printf "%bEnter your choice [1-5]: %b" "$(eval "$GREEN")" "$(eval "$RESET_FORMAT")"; read choice

    # Handle user input
    case "$choice" in
    1)
        print_green "You selected Peform Full SecuraMac"
        print_green ""
        break
        # Insert code to perform Task 1
        ;;
    2)
        print_green "You selected Perform Log SecuraMac"
        print_green ""
        break
        # Insert code to perform Task 2
        ;;
    3)
        print_green "You selected Perform Disable SecuraMac"
        print_green ""
        break
        # Insert code to perform Task 3
        ;;
    4)
        print_green "You selected Full Secura System Report"
        print_green ""
        break
        # Insert code to perform Task 4
        ;;
    5)
        print_green "You selected exit SecuraMac..."
        sleep 1
        clear
        echo "SecuraMac Closed"
        exit 0
        ;;
    *)
        print_bright_red_bold "invalid choice. Please select a valid option (1-5)."
        ;;
    esac
done


# Just works
Rule_Name="Firewall"
Rule_Recommend="Enable Firewall?"
Rule_Description="This helps protect your Mac from being attacked over the internet"
Rule_Check='sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate | grep -q "enabled" && echo "true" || echo "false"'
Rule_Enable="sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on"
Rule_Disable="sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate off"

Rule_Name="Stealth Mode"
Rule_Recommend="Enable Stealth Mode?"
Rule_Description="Your Mac will not respond to ping requests or connection attempts from TCP and UDP networks"
Rule_Check='sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getstealthmode | grep -q "enabled" && echo "true" || echo "false"'
Rule_Enable="sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on"
Rule_Disable="sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode off"

# User Safety Considerations 
Rule_Name="Printer Sharing"
Rule_Recommend="Disable Printer Sharing?"
Rule_Description="Offers redundancy in case the Firewall was not configured"
Rule_Check='sudo cupsctl | grep 'SharePrinters' | grep -q "Yes" && echo "true" || echo "false"'
Rule_Enable="sudo cupsctl --share-printers"
Rule_Disable="sudo cupsctl --no-share-printers"


# Requires Full Disk access
Rule_Name="SSH"
Rule_Recommend="Do you use SSH?"
Rule_Description="If no, remote login will be turned off"
Rule_Check='sudo systemsetup -getremotelogin | grep -q "on" && echo "true" || echo "false"'
Rule_Enable="sudo systemsetup -f -setremotelogin on"
Rule_Disable="sudo systemsetup -f -setremotelogin off"



# Only enable via manual
Rule_Name="GateKeepeer"
Rule_Recommend="Enable GateKeeper?"
Rule_Description="Defend against malware by enforcing code signing and verifying downloaded applications before letting them to run"
Rule_Check='sudo spctl --status'

# CANT CONFIRM THESE BELO
Rule_Name="Firewall Logging"
Rule_Check='sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getloggingmode | grep -q "on" && echo "true" || echo "false"'
Rule_Enable="sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on"
Rule_Disable="sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode off"

Rule_Name="Firewall Logging Detail Level"
Rule_Check='sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getloggingmode | grep -q "on" && echo "true" || echo "false"'
Rule_Enable="sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on"
Rule_Disable="sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode off"