#!/bin/zsh

# Define color variables
BLUE_BG='\033[44m'
RED='\033[31m'
RESET='\033[0m'

printf "%b" "${BLUE_BG}"

clear

print_magenta() {
    printf "%b%s%b\n" "${BLUE_BG}${MAGENTA}" "$1" "${RESET}"
}

# Debug by printing each color variable
print_magenta "testing things"
printf "Blue BG: ${BLUE_BG}Text${RESET}\n"
printf "Red: ${RED}Text${RESET}\n"

# Print text with background and foreground color using variables
printf "${BLUE_BG}${RED}Testing${RESET}\n"

print_magenta "testing this thing"
