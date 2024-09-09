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
export ITALIC='tput sitm'

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
export BRIGHT_BLUE='tput setaf 39'

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

print_orange_bold() {
    eval "$ORANGE"
    eval "$BOLD"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_green() {
    eval "$GREEN"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_green_italic() {
    eval "$GREEN"
    eval "$ITALIC"
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

print_bright_blue_bold() {
    eval "$BRIGHT_BLUE"
    eval "$BOLD"
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

terminal_fda() {
    clear
    intro_logo
    print_bright_red_bold "#############################################"
    print_bright_red_bold "Grant Full Disk Access to Terminal by following these steps:"
    print_bright_red_bold "#############################################"
    print_bright_red_bold ""
    print_bright_red_bold "1. Open System Settings."
    print_bright_red_bold "2. Go to Privacy & Security > Full Disk Access."
    print_bright_red_bold "3. Click the '+' button and add Terminal from /Applications/Utilities."
    print_bright_red_bold "4. If prompted, enter your password to make changes."
    print_bright_red_bold "5. Restart Terminal for the changes to take effect."
    print_bright_red_bold ""
    print_bright_red_bold "Apple Documentation:"
    print_bright_red_bold "https://support.apple.com/guide/security/controlling-app-access-to-files-secddd1d86a6/web"
    print_bright_red_bold ""
    print_white_bold "Exiting SecuraMac..."
    exit 0
}

intro_logo

print_orange_bold "#############################################"
print_orange_bold "# Important Step Before You Continue"
print_orange_bold "#############################################"
print_orange ""
print_orange_bold "      1. Maximize Terminal Window to Full Screen or Largest Possible Size"
print_orange_bold "      2. Verify terminal has full disk access"
print_orange_bold "      3. Data loss is possible; ensure you have a backup"
print_orange ""
print_orange ""
print_orange_bold "I have confirmed and i want to proceed:"
print_orange_bold "1. Yes"
print_orange_bold "2. No"
print_orange ""

# Loop until a valid choice is made
while true; do
    printf "%b%bEnter your choice [Y/N]: %b" "$(eval "$ORANGE")" "$(eval "$BOLD")" "$(eval "$RESET_FORMAT")"; read choice

    # Process user input
    case "$choice" in
        1|y|Y|yes|YES)
            print_orange_bold "Proceeding..."
            sleep 1
            clear
            print_green_bold "Verifying Full Disk Access..."
            sleep 1
            clear
            # Place the code to execute if the user chooses Yes here
            break
            ;;
        2|n|N|no|NO)
            print_orange_bold "Operation aborted..."
            sleep 1
            clear
            echo "SecuraMac Exited"
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
    print_orange_bold "##############################"
    print_orange_bold "            ALERT!            "
    print_orange_bold "  Terminal does not have FDA  "
    print_orange_bold "##############################"
    print_orange ""
fi

print_green_bold "#############################################"
print_green_bold "# Select an Option:"
print_green_bold "#############################################"
print_green ""
print_green_bold "1. Full SecuraMac Setup"
print_green_italic "       Guides users to enable all security options."
print_green_bold "2. Log SecuraMac Setup"
print_green_italic "       Guides users through logging-only security options."
print_green_bold "3. Disable SecuraMac"
print_green_italic "       Guides users to disable all security options."
print_green_bold "4. Full SecuraMac System Report"
print_green_italic "       Provides a detailed report of current system security."
print_green_bold "5. Guide to Enable Terminal FDA"
print_green_italic "       Not required, but limits some settings."
print_green_bold "6. Exit"
print_green ""


while true; do
    # Print prompt in yellow and read input on the same line
    printf "%b%bEnter your choice [1-6]: %b" "$(eval "$GREEN")" "$(eval "$BOLD")" "$(eval "$RESET_FORMAT")"; read choice

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
        log_mode="enable"
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
        print_green "You selected FDA Guide..."
        sleep 1
        terminal_fda
        break
        ;;
    6)
        print_green "You selected exit SecuraMac..."
        sleep 1
        clear
        echo "SecuraMac Exited"
        exit 0
        ;;
    *)
        print_bright_red_bold "invalid choice. Please select a valid option (1-5)."
        ;;
    esac
done

execute_and_log() {
    local rule_name="$1"
    local rule_recommend="$2"
    local rule_description="$3"
    local rule_check="$4"
    local rule_result="$5"
    local rule_enable="$6"
    local rule_disable="$7"

    # Check the current status
    local status_check=$(eval "$rule_check")

    # Function to set status color
    status_color() {
        if [[ "$1" == "Enabled" ]]; then
            echo "$(eval "$GREEN")"
        elif [[ "$1" == "Disabled" ]]; then
            echo "$(eval "$RED")"
        else
            echo "$(eval "$RESET_FORMAT")"
        fi
    }

    # Determine the status and apply color
    if [[ "$status_check" == "$rule_result" ]]; then
        current_status="Enabled"
        status_color_code=$(status_color "$current_status")
    else
        current_status="Disabled"
        status_color_code=$(status_color "$current_status")
    fi

    # Print statements with formatting using printf
    printf "%b%b-> Rule: %b%s%b\n" "$(eval "$BOLD")$(eval "$GREEN")" "$(eval "$BRIGHT_BLUE")" "$rule_name" "$(eval "$RESET_FORMAT")"

    # Print Current Status in parentheses with bold and color
    printf "%bCurrent Status: %b(%b%b%s%b%b\n" "$(eval "$GREEN")" "$(eval "$WHITE")$(eval "$BOLD")" "$status_color_code" "$current_status" "$(eval "$WHITE")$(eval "$BOLD")" ")" "$(eval "$RESET_FORMAT")"

    printf "%b{%b%s%b} %b%s%b\n" "$(eval "$GREEN")" "$(eval "$ORANGE")" "?" "$(eval "$GREEN")" "$(eval "$ITALIC")" "$rule_description" "$(eval "$RESET_FORMAT")"

    local attempt=1
    local max_attempts=3

    while [[ $attempt -le $max_attempts ]]; do
        printf "%b%b$rule_recommend [Yes/No]: %b" "$(eval "$BRIGHT_BLUE")" "$(eval "$BOLD")" "$(eval "$RESET_FORMAT")"; read user_input

        case "$user_input" in
            1|y|Y|yes|YES)
                print_orange_bold ""
                print_orange_bold "Enabling the rule..."
                print_orange_bold ""
                # eval "$rule_enable"
                return
                ;;
            2|n|N|no|NO)
                print_green ""
                print_green_bold "No changes made..."
                print_green ""
                print_green ""
                return
                ;;
            *)
                if [[ $attempt -lt $max_attempts ]]; then
                    print_red "Invalid input. Please enter 'Yes' or 'No'."
                else
                    print_green ""
                    print_green "Invalid input. Defaulting to 'No'."
                    print_green_bold "No changes made..."
                    print_green ""
                    print_green ""
                fi
                ;;
        esac
        ((attempt++))
    done
}

print_bright_blue_bold "#################"
print_bright_blue_bold "# FIREWALL RULES "
print_bright_blue_bold "#################"
print_bright_blue_bold ""

# Firewall Rules
##############################################
Rule_Name="Firewall"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This helps protect your Mac from being attacked over the internet"
Rule_Check='sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate | grep -q "enabled" && echo "true" || echo "false"'
Rule_Result="true"
Rule_Enable="sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on"
Rule_Disable="sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate off"

execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
##############################################
Rule_Name="Stealth Mode"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="Your Mac will not respond to ping requests or connection attempts from TCP and UDP networks"
Rule_Check='sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getstealthmode | grep -q "enabled" && echo "true" || echo "false"'
Rule_Result="true"
Rule_Enable="sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on"
Rule_Disable="sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode off"
execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"



print_bright_blue_bold "#################"
print_bright_blue_bold "# LOGGING RULES  "
print_bright_blue_bold "#################"
print_bright_blue_bold ""


# Logging Rules
##############################################
Rule_Name="Audit Log Files To Not Contain Access Control List"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="Access control lists will no longer be included in the log files."
Rule_Check="/bin/ls -le \$(/usr/bin/grep '^dir' /etc/security/audit_control | /usr/bin/awk -F: '{print \$2}') | /usr/bin/awk '{print \$1}' | /usr/bin/grep -c ':'"
Rule_Result="0"
Rule_Enable="/bin/chmod -RN /var/audit"
Rule_Disable=""

##############################################
Rule_Name="Audit Log Folders To Not Contain Access Control List"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="Access control lists will no longer be included in the log folders."
Rule_Check="/bin/ls -lde /var/audit | /usr/bin/awk '{print \$1}' | /usr/bin/grep -c ':'"
Rule_Result="0"
Rule_Enable="/bin/chmod -N /var/audit"
Rule_Disable=""

exit 0
##############################################
Rule_Name="Audit All Administrative Action Events"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="Administrative action events will now be audited for all activities."
Rule_Check="/usr/bin/awk -F':' '/^flags/ { print \$NF }' /etc/security/audit_control | /usr/bin/tr ',' '\n' | /usr/bin/grep -Ec 'ad'"
Rule_Result="1"
Rule_Enable="/usr/bin/grep -qE \"^flags.*[^-]ad\" /etc/security/audit_control || /usr/bin/sed -i.bak '/^flags/ s/\$/,ad/' /etc/security/audit_control; /usr/sbin/audit -s"
Rule_Disable=""

##############################################
Rule_Name="Audit All Log On Log Out"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="Audits all log on and log out actions in the audit log."
Rule_Check="/usr/bin/awk -F':' '/^flags/ { print \$NF }' /etc/security/audit_control | /usr/bin/tr ',' '\n' | /usr/bin/grep -Ec '^lo'"
Rule_Result="1"
Rule_Enable="/usr/bin/grep -qE \"^flags.*[^-]lo\" /etc/security/audit_control || /usr/bin/sed -i.bak '/^flags/ s/\$/,lo/' /etc/security/audit_control; /usr/sbin/audit -s"
Rule_Disable=""

###########################################

Rule_Name="Enable_Security_Auditing"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule checks if the security auditing service is running and if the audit control file exists."
Rule_Check='LAUNCHD_RUNNING=$(/bin/launchctl list | /usr/bin/grep -c com.apple.auditd); if [[ $LAUNCHD_RUNNING -eq 1 ]] && [[ -e /etc/security/audit_control ]]; then echo "pass"; else echo "fail"; fi'
Rule_Result="pass"
Rule_Enable="LAUNCHD_RUNNING=\$(/bin/launchctl list | /usr/bin/grep -c com.apple.auditd); if [[ ! \$LAUNCHD_RUNNING == 1 ]]; then /bin/launchctl load -w /System/Library/LaunchDaemons/com.apple.auditd.plist; fi; if [[ ! -e /etc/security/audit_control ]] && [[ -e /etc/security/audit_control.example ]]; then /bin/cp /etc/security/audit_control.example /etc/security/audit_control; else /usr/bin/touch /etc/security/audit_control; fi"
Rule_Disable=""
###########################################

Rule_Name="Configure System To Shutdown Upon Audit Failure"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule ensures that the system is configured to shut down automatically if an audit failure occurs."
Rule_Check='/usr/bin/awk -F":" "/^policy/ {print \$NF}" /etc/security/audit_control | /usr/bin/tr "," "\\n" | /usr/bin/grep -Ec "ahlt"'
Rule_Result="1"
Rule_Enable="/usr/bin/sed -i.bak 's/^policy.*/policy: ahlt,argv/' /etc/security/audit_control; /usr/sbin/audit -s"
Rule_Disable=""
###########################################
Rule_Name="Audit Log Files Owned By Root"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule checks that all audit log files are owned by the root user."
Rule_Check='/bin/ls -n $(/usr/bin/grep "^dir" /etc/security/audit_control | /usr/bin/awk -F: '\''{print $2}'\'') | /usr/bin/awk '\''{s+=$3} END {print s}'\'''
Rule_Result="0"
Rule_Enable="/usr/sbin/chown -R root /var/audit/*"
Rule_Disable=""
###########################################
Rule_Name="Audit Log Folders Owned By Root"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule checks that all audit log folders are owned by the root user."
Rule_Check='/bin/ls -dn $(/usr/bin/grep "^dir" /etc/security/audit_control | /usr/bin/awk -F: '\''{print $2}'\'') | /usr/bin/awk '\''{print $3}'\'''
Rule_Result="0"
Rule_Enable="/usr/sbin/chown root /var/audit"
Rule_Disable=""
###########################################

Rule_Name="Audit Log Files Group Owned By Wheel"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule ensures that audit log files are group-owned by the wheel group."
Rule_Check='/bin/ls -n $(/usr/bin/grep "^dir" /etc/security/audit_control | /usr/bin/awk -F: '\''{print $2}'\'') | /usr/bin/awk '\''{s+=$4} END {print s}'\'''
Rule_Result="0"
Rule_Enable="/usr/bin/chgrp -R wheel /var/audit/*"
Rule_Disable=""
###########################################

Rule_Name="Audit Log Folders Group Owned By Wheel"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule checks that all audit log folders are group-owned by the wheel group."
Rule_Check='/bin/ls -dn $(/usr/bin/grep "^dir" /etc/security/audit_control | /usr/bin/awk -F: '\''{print $2}'\'') | /usr/bin/awk '\''{print $4}'\'''
Rule_Result="0"
Rule_Enable="/usr/bin/chgrp wheel /var/audit"
Rule_Disable=""
###########################################

Rule_Name="Audit Log Files Mode 440 or Less Permissive"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule checks that audit log files have permissions set to 440 or less permissive."
Rule_Check="/bin/ls -l \$(/usr/bin/grep '^dir' /etc/security/audit_control | /usr/bin/awk -F: '{print \$2}') | /usr/bin/awk '!/-r--r-----|current|total/{print \$1}' | /usr/bin/wc -l | /usr/bin/tr -d ' '"
Rule_Result="0"
Rule_Enable="/bin/chmod 440 /var/audit/*"
Rule_Disable=""
###########################################
Rule_Name="Audit Log Folder Mode 700 or Less Permissive"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule checks that audit log folders have permissions set to 700 or less permissive."
Rule_Check="/usr/bin/stat -f %A \$(/usr/bin/grep '^dir' /etc/security/audit_control | /usr/bin/awk -F: '{print \$2}')"
Rule_Result="700"
Rule_Enable="/bin/chmod 700 /var/audit"
Rule_Disable=""
###########################################

Rule_Name="Audit All Deletion Of Object Attributes"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule ensures that deletion of object attributes is audited."
Rule_Check="/usr/bin/awk -F':' '/^flags/ { print \$NF }' /etc/security/audit_control | /usr/bin/tr ',' '\n' | /usr/bin/grep -Ec '-fd'"
Rule_Result="1"
Rule_Enable="/usr/bin/grep -qE \"^flags.*-fd\" /etc/security/audit_control || /usr/bin/sed -i.bak '/^flags/ s/\$/,-fd/' /etc/security/audit_control;/usr/sbin/audit -s"
Rule_Disable=""
###########################################

Rule_Name="Audit All Changes Of Object Attributes"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule ensures that changes to object attributes are audited."
Rule_Check="/usr/bin/awk -F':' '/^flags/ { print \$NF }' /etc/security/audit_control | /usr/bin/tr ',' '\n' | /usr/bin/grep -Ec '^fm'"
Rule_Result="1"
Rule_Enable="/usr/bin/grep -qE \"^flags.*fm\" /etc/security/audit_control || /usr/bin/sed -i.bak '/^flags/ s/\$/,fm/' /etc/security/audit_control;/usr/sbin/audit -s"
Rule_Disable=""
###########################################

Rule_Name="Audit All Failed Read Actions"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule ensures that all failed read actions are audited."
Rule_Check="/usr/bin/awk -F':' '/^flags/ { print \$NF }' /etc/security/audit_control | /usr/bin/tr ',' '\n' | /usr/bin/grep -Ec '-fr'"
Rule_Result="1"
Rule_Enable="/usr/bin/grep -qE \"^flags.*-fr\" /etc/security/audit_control || /usr/bin/sed -i.bak '/^flags/ s/\$/,-fr/' /etc/security/audit_control;/usr/sbin/audit -s"
Rule_Disable=""
###########################################
Rule_Name="Audit All Failed Write Actions"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule ensures that all failed write actions are audited."
Rule_Check="/usr/bin/awk -F':' '/^flags/ { print \$NF }' /etc/security/audit_control | /usr/bin/tr ',' '\n' | /usr/bin/grep -Ec '-fw'"
Rule_Result="1"
Rule_Enable="/usr/bin/grep -qE \"^flags.*-fw\" /etc/security/audit_control || /usr/bin/sed -i.bak '/^flags/ s/\$/,-fw/' /etc/security/audit_control;/usr/sbin/audit -s"
Rule_Disable=""
###########################################

Rule_Name="Audit All Failed Program Executions"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule ensures that all failed program executions are audited."
Rule_Check="/usr/bin/awk -F':' '/^flags/ { print \$NF }' /etc/security/audit_control | /usr/bin/tr ',' '\n' | /usr/bin/grep -Ec '-ex'"
Rule_Result="1"
Rule_Enable="/usr/bin/grep -qE \"^flags.*-ex\" /etc/security/audit_control || /usr/bin/sed -i.bak '/^flags/ s/\$/,-ex/' /etc/security/audit_control; /usr/sbin/audit -s"
Rule_Disable=""
###########################################
Rule_Name="Audit Retention Set To 7 Days"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule ensures that audit log retention is set to 7 days."
Rule_Check="/usr/bin/awk -F: '/expire-after/{print \$2}' /etc/security/audit_control"
Rule_Result="7d"
Rule_Enable="/usr/bin/sed -i.bak 's/^expire-after.*/expire-after:7d/' /etc/security/audit_control; /usr/sbin/audit -s"
Rule_Disable=""
###########################################
Rule_Name="Audit Capacity Warning"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule checks that a minimum free space of 25% is set for audit logs."
Rule_Check="/usr/bin/awk -F: '/^minfree/{print \$2}' /etc/security/audit_control"
Rule_Result="25"
Rule_Enable="/usr/bin/sed -i.bak 's/.*minfree.*/minfree:25/' /etc/security/audit_control; /usr/sbin/audit -s"
Rule_Disable=""
###########################################
Rule_Name="Audit Failure Notification"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule ensures that audit failures are logged with a notification."
Rule_Check="/usr/bin/grep -c 'logger -s -p' /etc/security/audit_warn"
Rule_Result="1"
Rule_Enable="/usr/bin/sed -i.bak 's/logger -p/logger -s -p/' /etc/security/audit_warn; /usr/sbin/audit -s"
Rule_Disable=""
###########################################
Rule_Name="Audit_All_Authorization_Authentication_Events"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule checks if all authorization and authentication events are being audited."
Rule_Check="/usr/bin/awk -F':' '/^flags/ { print \$NF }' /etc/security/audit_control | /usr/bin/tr ',' '\n' | /usr/bin/grep -Ec 'aa'"
Rule_Result="1"
Rule_Enable="/usr/bin/grep -qE \"^flags.*[^-]aa\" /etc/security/audit_control || /usr/bin/sed -i.bak '/^flags/ s/\$/,aa/' /etc/security/audit_control; /usr/sbin/audit -s"
Rule_Disable=""
###########################################
Rule_Name="Configure_Audit_Control_Group_To_Wheel"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule ensures that the audit control file group is set to wheel."
Rule_Check="/bin/ls -dn /etc/security/audit_control | /usr/bin/awk '{print \$4}'"
Rule_Result="0"
Rule_Enable="/usr/bin/chgrp wheel /etc/security/audit_control"
Rule_Disable=""
###########################################
Rule_Name="Configure_Audit_Control_Owner_To_Root"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule ensures that the audit control file is owned by root."
Rule_Check="/bin/ls -dn /etc/security/audit_control | /usr/bin/awk '{print \$3}'"
Rule_Result="0"
Rule_Enable="/usr/sbin/chown root /etc/security/audit_control"
Rule_Disable=""
###########################################
Rule_Name="Configure_Audit_Control_To_Mode_440_or_Less_Permissive"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule ensures that the audit control file has permissions set to 440 or less permissive."
Rule_Check="/bin/ls -l /etc/security/audit_control | /usr/bin/awk '!/-r--[r-]-----|current|total/{print \$1}' | /usr/bin/wc -l | /usr/bin/xargs"
Rule_Result="0"
Rule_Enable="/bin/chmod 440 /etc/security/audit_control"
Rule_Disable=""
###########################################
Rule_Name="Configure_Audit_Control_To_Not_Contain_Access_Control_Lists"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule ensures that the audit control file does not contain access control lists."
Rule_Check="/bin/ls -le /etc/security/audit_control | /usr/bin/awk '{print \$1}' | /usr/bin/grep -c \":\""
Rule_Result="0"
Rule_Enable="/bin/chmod -N /etc/security/audit_control"
Rule_Disable=""
###########################################
Rule_Name="Configure_Apple_System_Log_Files_To_Be_Owned_By_Root_and_Group_To_Wheel"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule ensures that Apple system log files are owned by root and the group is set to wheel."
Rule_Check="/usr/bin/stat -f '%Su:%Sg:%N' \$(/usr/bin/grep -e '^>' /etc/asl.conf /etc/asl/* | /usr/bin/awk '{ print \$2 }') 2> /dev/null | /usr/bin/awk '!/^root:wheel:/{print \$1}' | /usr/bin/wc -l | /usr/bin/tr -d ' '"
Rule_Result="0"
Rule_Enable="/usr/sbin/chown root:wheel \$(/usr/bin/stat -f '%Su:%Sg:%N' \$(/usr/bin/grep -e '^>' /etc/asl.conf /etc/asl/* | /usr/bin/awk '{ print \$2 }') 2> /dev/null | /usr/bin/awk '!/^root:wheel:/{print \$1}' | /usr/bin/awk -F\":\" '!/^root:wheel:/{print \$3}')"
Rule_Disable=""
###########################################
Rule_Name="Configure_Apple_System_Log_Files_To_Mode_640_Or_Less_Permissive"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule ensures that Apple system log files have permissions set to 640 or less permissive."
Rule_Check="/usr/bin/stat -f '%A:%N' \$(/usr/bin/grep -e '^>' /etc/asl.conf /etc/asl/* | /usr/bin/awk '{ print \$2 }') 2> /dev/null | /usr/bin/awk '!/640/{print \$1}' | /usr/bin/wc -l | /usr/bin/tr -d ' '"
Rule_Result="0"
Rule_Enable="/bin/chmod 640 \$(/usr/bin/stat -f '%A:%N' \$(/usr/bin/grep -e '^>' /etc/asl.conf /etc/asl/* | /usr/bin/awk '{ print \$2 }') 2> /dev/null | /usr/bin/awk -F\":\" '!/640/{print \$2}')"
Rule_Disable=""
###########################################
Rule_Name="Configure_System_Log_Files_To_Be_Owned_By_Root_and_Group_To_Wheel"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule ensures that system log files are owned by root and the group is set to wheel."
Rule_Check="/usr/bin/stat -f '%Su:%Sg:%N' \$(/usr/bin/grep -v '^#' /etc/newsyslog.conf | /usr/bin/awk '{ print \$1 }') 2> /dev/null | /usr/bin/awk '!/^root:wheel:/{print \$1}' | /usr/bin/wc -l | /usr/bin/tr -d ' '"
Rule_Result="0"
Rule_Enable="/usr/sbin/chown root:wheel \$(/usr/bin/stat -f '%Su:%Sg:%N' \$(/usr/bin/grep -v '^#' /etc/newsyslog.conf | /usr/bin/awk '{ print \$1 }') 2> /dev/null | /usr/bin/awk -F\":\" '!/^root:wheel:/{print \$3}')"
Rule_Disable=""
###########################################
Rule_Name="Configure_System_Log_Files_To_Mode_640_Or_Less_Permissive"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule ensures that system log files have permissions set to 640 or less permissive."
Rule_Check="/usr/bin/stat -f '%A:%N' \$(/usr/bin/grep -v '^#' /etc/newsyslog.conf | /usr/bin/awk '{ print \$1 }') 2> /dev/null | /usr/bin/awk '!/640/{print \$1}' | /usr/bin/wc -l | /usr/bin/tr -d ' '"
Rule_Result="0"
Rule_Enable="/bin/chmod 640 \$(/usr/bin/stat -f '%A:%N' \$(/usr/bin/grep -v '^#' /etc/newsyslog.conf | /usr/bin/awk '{ print \$1 }') 2> /dev/null | /usr/bin/awk '!/640/{print \$1}' | awk -F\":\" '!/640/{print \$2}')"
Rule_Disable=""
###########################################
Rule_Name="System_Log_Retention_To_365"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule ensures that system log retention is set to 365 days."
Rule_Check="/usr/sbin/aslmanager -dd 2>&1 | /usr/bin/awk '/\/var\/log\/install.log/ {count++} /Processing module com.apple.install/,/Finished/ { for (i=1;i<=NR;i++) { if (\$i == \"TTL\" && \$(i+2) >= 365) { ttl=\"True\" }; if (\$i == \"MAX\") {max=\"True\"}}} END{if (count > 1) { print \"Multiple config files for /var/log/install, manually remove\"} else if (ttl != \"True\") { print \"TTL not configured\" } else if (max == \"True\") { print \"Max Size is configured, must be removed\" } else { print \"Yes\" }}'"
Rule_Result="Yes"
Rule_Enable="/usr/bin/sed -i '' \"s/\* file \/var\/log\/install.log.*/\* file \/var\/log\/install.log format='\$\(\(Time\)\(JZ\)\) \$Host \$\(Sender\)\[\$\(PID\\)\]: \$Message' rotate=utc compress file_max=50M size_only ttl=365/g\" /etc/asl/com.apple.install"
Rule_Disable=""
###########################################
Rule_Name="Configure_Sudoers_Timestamp_Type"
Rule_Recommend="Do you want to enable this rule?"
Rule_Description="This rule ensures that the sudoers timestamp type is set correctly."
Rule_Check="/usr/bin/sudo /usr/bin/sudo -V | /usr/bin/awk -F\": \" '/Type of authentication timestamp record/{print \$2}'"
Rule_Result="tty"
Rule_Enable="/usr/bin/find /etc/sudoers* -type f -exec sed -i '' '/timestamp_type/d; /!tty_tickets/d' '{}' \;"
Rule_Disable=""
###########################################

# SSH Rules
###########################################
Rule_Name="Disable Root Login for SSH"
Rule_Recommend="Do you want to disable or enable this rule?"
Rule_Description="This rule ensures that SSH does not allow root login by checking the SSH configuration and updating it if necessary."
Rule_Check="/usr/sbin/sshd -G | /usr/bin/awk '/permitrootlogin/{print \$2}'"
Rule_Result="no"
Rule_Enable="include_dir=\$(/usr/bin/awk '/^Include/ {print \$2}' /etc/ssh/sshd_config | /usr/bin/tr -d '*'); if [[ -z \$include_dir ]]; then /usr/bin/sed -i.bk \"1s/.*/Include \/etc\/ssh\/sshd_config.d\/\*/\" /etc/ssh/sshd_config; fi; /usr/bin/grep -qxF 'permitrootlogin no' \"\${include_dir}01-mscp-sshd.conf\" 2>/dev/null || echo \"permitrootlogin no\" >> \"\${include_dir}01-mscp-sshd.conf\"; for file in \$(ls \${include_dir}); do if [[ \"\$file\" == \"100-macos.conf\" ]]; then continue; fi; if [[ \"\$file\" == \"01-mscp-sshd.conf\" ]]; then break; fi; /bin/mv \${include_dir}\${file} \${include_dir}20-\${file}; done"
Rule_Disable=""
###########################################

Rule_Name="Disable Password Authentication For SSH"
Rule_Recommend="Do you want to disable or enable this rule?"
Rule_Description="This rule ensures that SSH does not allow password-based authentication by checking the SSH configuration and updating it if necessary."
Rule_Check="/usr/sbin/sshd -G | /usr/bin/grep -Ec '^(passwordauthentication\s+no|kbdinteractiveauthentication\s+no)'"
Rule_Result="2"
Rule_Enable="include_dir=\$(/usr/bin/awk '/^Include/ {print \$2}' /etc/ssh/sshd_config | /usr/bin/tr -d '*'); if [[ -z \$include_dir ]]; then /usr/bin/sed -i.bk \"1s/.*/Include \/etc\/ssh\/sshd_config.d\/\*/\" /etc/ssh/sshd_config; fi; echo \"passwordauthentication no\" >> \"\${include_dir}01-mscp-sshd.conf\"; echo \"kbdinteractiveauthentication no\" >> \"\${include_dir}01-mscp-sshd.conf\"; for file in \$(ls \${include_dir}); do if [[ \"\$file\" == \"100-macos.conf\" ]]; then continue; fi; if [[ \"\$file\" == \"01-mscp-sshd.conf\" ]]; then break; fi; /bin/mv \${include_dir}\${file} \${include_dir}20-\${file}; done"
Rule_Disable=""
###########################################




# Disable Random Services
######################################
Rule_Name="Disable Server Message Block Sharing"
Rule_Recommend="Do you want to disable or enable this rule?"
Rule_Description="This rule checks if the Server Message Block (SMB) sharing service is disabled and provides a command to disable it if necessary."
Rule_Check="/bin/launchctl print-disabled system | /usr/bin/grep -c '\"com.apple.smbd\" => disabled'"
Rule_Result="1"
Rule_Enable="/bin/launchctl disable system/com.apple.smbd"
Rule_Disable=""
###########################################

Rule_Name="Disable Network File System Service"
Rule_Recommend="Do you want to disable or enable this rule?"
Rule_Description="This rule checks if the Network File System (NFS) service is disabled and provides a command to disable it if necessary."
Rule_Check="/bin/launchctl print-disabled system | /usr/bin/grep -c '\"com.apple.nfsd\" => disabled'"
Rule_Result="1"
Rule_Enable="/bin/launchctl disable system/com.apple.nfsd"
Rule_Disable=""
###########################################

Rule_Name="Disable Location Services"
Rule_Recommend="Do you want to disable or enable this rule?"
Rule_Description="This rule checks if Location Services are disabled and provides a command to disable them if necessary."
Rule_Check="/usr/bin/sudo -u _locationd /usr/bin/osascript -l JavaScript -e \"$.NSUserDefaults.alloc.initWithSuiteName('com.apple.locationd').objectForKey('LocationServicesEnabled').js\""
Rule_Result="false"
Rule_Enable="/usr/bin/defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -bool false; /bin/launchctl kickstart -k system/com.apple.locationd"
Rule_Disable=""
###########################################

Rule_Name="Disable Unix to Unix Copy Protocol Service"
Rule_Recommend="Do you want to disable or enable this rule?"
Rule_Description="This rule checks if the Unix to Unix Copy Protocol (UUCP) service is disabled and provides a command to disable it if necessary."
Rule_Check="/bin/launchctl print-disabled system | /usr/bin/grep -c '\"com.apple.uucp\" => disabled'"
Rule_Result="1"
Rule_Enable="/bin/launchctl disable system/com.apple.uucp"
Rule_Disable=""
###########################################

Rule_Name="Disable Built-In Web Server"
Rule_Recommend="Do you want to disable or enable this rule?"
Rule_Description="This rule checks if the built-in web server (Apache) is disabled and provides a command to disable it if necessary."
Rule_Check="/bin/launchctl print-disabled system | /usr/bin/grep -c '\"org.apache.httpd\" => disabled'"
Rule_Result="1"
Rule_Enable="/bin/launchctl disable system/org.apache.httpd"
Rule_Disable="/bin/launchctl enable system/org.apache.httpd"
###########################################

Rule_Name="Disable Remote Apple Events"
Rule_Recommend="Do you want to disable or enable this rule?"
Rule_Description="This rule checks if Remote Apple Events are disabled and provides a command to disable them if necessary."
Rule_Check="/bin/launchctl print-disabled system | /usr/bin/grep -c '\"com.apple.AEServer\" => disabled'"
Rule_Result="1"
Rule_Enable="/usr/sbin/systemsetup -setremoteappleevents off && /bin/launchctl disable system/com.apple.AEServer"
Rule_Disable=""
###########################################

Rule_Name="Disable Trivial File Transfer Protocol Service"
Rule_Recommend="Do you want to disable or enable this rule?"
Rule_Description="This rule checks if the Trivial File Transfer Protocol (TFTP) service is disabled and provides a command to disable it if necessary."
Rule_Check="/bin/launchctl print-disabled system | /usr/bin/grep -c '\"com.apple.tftpd\" => disabled'"
Rule_Result="1"
Rule_Enable="/bin/launchctl disable system/com.apple.tftpd"
Rule_Disable=""
###########################################

Rule_Name="Disable Bluetooth Sharing"
Rule_Recommend="Do you want to disable or enable this rule?"
Rule_Description="This rule checks if Bluetooth Sharing is disabled and provides a command to disable it if necessary."
CURRENT_USER=$( /usr/sbin/scutil <<< "show State:/Users/ConsoleUser" | /usr/bin/awk '/Name :/ && ! /loginwindow/ { print $3 }' ) ## Required for Command
Rule_Check="/usr/bin/sudo -u \"$CURRENT_USER\" /usr/bin/defaults -currentHost read com.apple.Bluetooth PrefKeyServicesEnabled"
Rule_Result="0"
Rule_Enable="/usr/bin/sudo -u \"\$CURRENT_USER\" /usr/bin/defaults -currentHost write com.apple.Bluetooth PrefKeyServicesEnabled -bool false"
Rule_Disable=""
###########################################

Rule_Name="Disable CD/DVD Sharing"
Rule_Recommend="Do you want to disable or enable this rule?"
Rule_Description="This rule checks if CD/DVD Sharing is disabled and provides a command to disable it if necessary."
Rule_Check="/usr/bin/pgrep -q ODSAgent; /bin/echo \$?"
Rule_Result="1"
Rule_Enable="/bin/launchctl unload /System/Library/LaunchDaemons/com.apple.ODSAgent.plist"
Rule_Disable=""
###########################################

Rule_Name="Disable Printer Sharing"
Rule_Recommend="Do you want to disable or enable this rule?"
Rule_Description="This rule checks if Printer Sharing is disabled and provides a command to disable it if necessary."
Rule_Check="/usr/sbin/cupsctl | /usr/bin/grep -c \"_share_printers=0\""
Rule_Result="1"
Rule_Enable="/usr/sbin/cupsctl --no-share-printers && /usr/bin/lpstat -p | awk '{print \$2}'| /usr/bin/xargs -I{} lpadmin -p {} -o printer-is-shared=false"
Rule_Disable=""
###########################################

Rule_Name="Disable Remote Management"
Rule_Recommend="Do you want to disable or enable this rule?"
Rule_Description="This rule checks if Remote Management is disabled and provides a command to disable it if necessary."
Rule_Check="/usr/libexec/mdmclient QuerySecurityInfo | /usr/bin/grep -c \"RemoteDesktopEnabled = 0\""
Rule_Result="1"
Rule_Enable="/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -stop"
Rule_Disable=""
###########################################



# Extra Measures
############################

check_name="V-259514"
simple_name="Secure_Users_Home_Folders"
command="/usr/bin/find /System/Volumes/Data/Users -mindepth 1 -maxdepth 1 -type d ! \( -perm 700 -o -perm 711 \) | /usr/bin/grep -v "Shared" | /usr/bin/grep -v \"Guest\" | /usr/bin/wc -l | /usr/bin/xargs"
expected_result="0"
fix_command="IFS=\$'\n'
for userDirs in \$( /usr/bin/find /System/Volumes/Data/Users -mindepth 1 -maxdepth 1 -type d ! \( -perm 700 -o -perm 711 \) | /usr/bin/grep -v \"Shared\" | /usr/bin/grep -v \"Guest\" ); do
  /bin/chmod og-rwx \"\$userDirs\"
done
unset IFS"
requires_mdm="false"

check_name="V-259515"
simple_name="System_Must_Require_Administrator_Privileges_To_Modify_Systemwide_Settings"
command="authDBs=(\"system.preferences\" \"system.preferences.energysaver\" \"system.preferences.network\" \"system.preferences.printing\" \"system.preferences.sharing\" \"system.preferences.softwareupdate\" \"system.preferences.startupdisk\" \"system.preferences.timemachine\")
result=\"1\"
for section in \${authDBs[@]}; do
  if [[ \$(/usr/bin/security -q authorizationdb read \"\$section\" | /usr/bin/xmllint -xpath 'name(//*[contains(text(), \"shared\")]/following-sibling::*[1])' -) != \"false\" ]]; then
    result=\"0\"
  fi
done
echo \$result"
expected_result="1"
fix_command="authDBs=(\"system.preferences\" \"system.preferences.energysaver\" \"system.preferences.network\" \"system.preferences.printing\" \"system.preferences.sharing\" \"system.preferences.softwareupdate\" \"system.preferences.startupdisk\" \"system.preferences.timemachine\")

for section in \${authDBs[@]}; do
/usr/bin/security -q authorizationdb read \"\$section\" > \"/tmp/\$section.plist\"
key_value=\$(/usr/libexec/PlistBuddy -c \"Print :shared\" \"/tmp/\$section.plist\" 2>&1)
if [[ \"\$key_value\" == *\"Does Not Exist\"* ]]; then
  /usr/libexec/PlistBuddy -c \"Add :shared bool false\" \"/tmp/\$section.plist\"
else
  /usr/libexec/PlistBuddy -c \"Set :shared false\" \"/tmp/\$section.plist\"
fi
  /usr/bin/security -q authorizationdb write \"\$section\" < \"/tmp/\$section.plist\"
done"
requires_mdm="false"



check_name="V-259544"
simple_name="Remove_Password_Hints_From_User_Accounts"
command="/usr/bin/dscl . -list /Users hint | /usr/bin/awk '{print \$2}' | /usr/bin/wc -l | /usr/bin/xargs"
expected_result="0"
fix_command="for u in \$(/usr/bin/dscl . -list /Users UniqueID | /usr/bin/awk '\$2 > 500 {print \$1}'); do
  /usr/bin/dscl . -delete /Users/\$u hint
done"
requires_mdm="false"

check_name="V-259555"
simple_name="System_Must_Reauthenticate_For_Priviledge_Escalations_When_Using_Sudo_Command"
command="/usr/bin/sudo /usr/bin/sudo -V | /usr/bin/grep -c \"Authentication timestamp timeout: 0.0 minutes\""
expected_result="1"
fix_command="/usr/bin/find /etc/sudoers* -type f -exec sed -i '' '/timestamp_timeout/d' '{}' \;
/bin/echo \"Defaults timestamp_timeout=0\" >> /etc/sudoers.d/mscp"
requires_mdm="false"



# SSH Rules
########################################
# Requires Full Disk access
Rule_Name="SSH"
Rule_Recommend="Do you use SSH?"
Rule_Description="If no, remote login will be turned off"
Rule_Check='sudo systemsetup -getremotelogin | grep -q "on" && echo "true" || echo "false"'
Rule_Enable="sudo systemsetup -f -setremotelogin on"
Rule_Disable="sudo systemsetup -f -setremotelogin off"


# Checks Only
####################################
Rule_Name="GateKeeper"
Rule_Recommend="Enable GateKeeper?"
Rule_Description="Defend against malware by enforcing code signing and verifying downloaded applications before letting them to run"
Rule_Check='sudo spctl --status'

check_name="V-259570"
simple_name="Enable_Authenticated_Root"
command="/usr/bin/csrutil authenticated-root | /usr/bin/grep -c 'enabled'"
expected_result="1"
fix_command="/usr/bin/csrutil authenticated-root enable"
requires_mdm="false"

check_name="V-259575"
simple_name="Enable_Recovery_Lock"
command="/usr/libexec/mdmclient QuerySecurityInfo | /usr/bin/grep -c \"IsRecoveryLockEnabled = 1\""
expected_result="1"
chip_specific="Apple Only"
fix_command=""
requires_mdm="false"

check_name="V-259560"
simple_name="System_Integrity_Protection_Is_Enabled"
command="/usr/bin/csrutil status | /usr/bin/grep -c 'System Integrity Protection status: enabled.' && /usr/bin/grep -c \"logger -s -p\" /etc/security/audit_warn "
expected_result="1
1"
fix_command="/usr/bin/csrutil enable"
requires_mdm="false"

check_name="V-259543"
simple_name="Enable_Firmware_Password_Intel_Chip"
command="/usr/sbin/firmwarepasswd -check | /usr/bin/grep -c \"Password Enabled: Yes\""







# CANT CONFIRM THESE BELOW
Rule_Name="Firewall Logging"
Rule_Check='sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getloggingmode | grep -q "on" && echo "true" || echo "false"'
Rule_Enable="sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on"
Rule_Disable="sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode off"

Rule_Name="Firewall Logging Detail Level"
Rule_Check='sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getloggingmode | grep -q "on" && echo "true" || echo "false"'
Rule_Enable="sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on"
Rule_Disable="sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode off"