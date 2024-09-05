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

# Functions to set text attributes and colors using tput
export RESET_FORMAT='tput sgr0'
export BOLD='tput bold'
export UNDERLINE='tput smul'
export REVERSE='tput rev'

# Basic Colors
export RED='tput setaf 1'
export GREEN='tput setaf 2'
export BLUE='tput setaf 4'
export YELLOW='tput setaf 3'
export MAGENTA='tput setaf 5'
export CYAN='tput setaf 6'
export WHITE='tput setaf 7'

# Background Colors
export RED_BG='tput setab 1'
export GREEN_BG='tput setab 2'
export BLUE_BG='tput setab 4'
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

print_green() {
    eval "$GREEN"
    eval "$BOLD"
    eval "$BLUE_BG"
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

print_blue_bg() {
    eval "$BLUE_BG"
    eval "$BLUE"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_bright_red() {
    eval "$BRIGHT_RED"
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

eval "$BLUE_BG"

# Clear the screen to apply the background color
clear

# ASCII Logo with SecuraMac 
print_magenta_bold "                                                      "
print_magenta_bold "   _____                           __  __             "
print_magenta_bold "  / ____|                         |  \/  |            "
print_magenta_bold " | (___   ___  ___ _   _ _ __ __ _| \  / | __ _  ___  "
print_magenta_bold "  \___ \ / _ \/ __| | | | '__/ _' | |\/| |/ _' |/ __| "
print_magenta_bold "  ____) |  __/ (__| |_| | | | (_| | |  | | (_| | (__  "
print_magenta_bold " |_____/ \___|\___|\__,_|_|  \__,_|_|  |_|\__,_|\___| "
print_magenta_bold "                                                      "
print_magenta "https://github.com/cocopuff2u/SecuraMac               "
print_magenta ""
print_green "SecuraMac simplifies macOS security, offering quick and effective tools to fortify your system and ensure protection. "
print_magenta ""
print_magenta ""

# Prompt for user options
print_green "Welcome to SecuraMac!"
print_green ""
print_green "Please select an option:"
print_green "1. Perform Full SecuraMac"
print_green "2. Perform Log SecuraMac"
print_green "3. Perform Setting SecuraMac"
print_green "4. Full System Report"
print_green "5. Exit"

# Print prompt in yellow and read input on the same line
printf "%bEnter your choice [1-5]: %b" "$(eval "$YELLOW")" "$(eval "$RESET_FORMAT")"; read choice


# Handle user input
case $choice in
  1)
    print_green "You selected Task 1"
    # Insert code to perform Task 1
    ;;
  2)
    print_green "You selected Task 2"
    # Insert code to perform Task 2
    ;;
  3)
    print_green "You selected Task 3"
    # Insert code to perform Task 3
    ;;
  4)
    print_green "You selected Task 4"
    # Insert code to perform Task 4
    ;;
  5)
    print_green "Exiting..."
    # Reset background color to default before exiting
    clear
    echo "SecuraMac Exited"
    exit 0
    ;;
  *)
    print_white "Invalid option. Please select a valid option (1-5)."
    ;;
esac
