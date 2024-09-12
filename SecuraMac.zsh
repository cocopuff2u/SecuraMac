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

# Initialize variables
skip_warning="no"
skip_descriptions="no"
terminal_logging=0
terminal_csv_logging=0
terminal_csv_plist_logging=0

# Process arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        /h|h)
            skip_descriptions="yes"
            ;;
        /y|y)
            skip_warning="yes"
            ;;
        *)
            echo "Unknown argument: $1"
            ;;
    esac
    shift
done

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


# Functions to print text with various colors and attributes
print_red() {
    eval "$RED"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_orange() {
    eval "$ORANGE"
    printf "%b%s%b\n" "$1" "$(eval "$RESET_FORMAT")"
}

print_green_orange_italic_rule() {
    eval "$GREEN"
    printf "{%b?%b} %b%s%b\n" "$(eval "$ORANGE")" "$(eval "$GREEN")" "$(eval "$ITALIC")" "$1" "$(eval "$RESET_FORMAT")"
}

print_green_orange_italic_menu() {
    if [[ "$skip_descriptions" == "no" ]]; then
        eval "$GREEN"
        printf "        {%b?%b} %b%s%b\n" "$(eval "$ORANGE")" "$(eval "$GREEN")" "$(eval "$ITALIC")" "$1" "$(eval "$RESET_FORMAT")"
    fi
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

print_green_bold() {
    eval "$GREEN"
    eval "$BOLD"
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


# Clear the screen
clear

write_to_plist() {
    local check_name=$1
    local simple_name=$2
    local boolean_result=$3

    echo '<?xml version="1.0" encoding="UTF-8"?>' >"$PLIST_LOG_FILE"
    echo '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">' >>"$PLIST_LOG_FILE"
    echo '<plist version="1.0">' >>"$PLIST_LOG_FILE"
    echo '<dict>' >>"$PLIST_LOG_FILE"
    echo '</dict>' >>"$PLIST_LOG_FILE"
    echo '</plist>' >>"$PLIST_LOG_FILE"

    # Create a temporary plist file for processing
    local temp_plist="/var/log/STIG_Checks_temp.plist"

    # Extract the existing plist content
    /usr/libexec/PlistBuddy -x -c "Print" "$PLIST_LOG_FILE" >"$temp_plist"

    # Update the plist with the new check result
    /usr/libexec/PlistBuddy -c "Add :$check_name\_$simple_name dict" "$temp_plist"
    /usr/libexec/PlistBuddy -c "Add :$check_name\_$simple_name:finding bool $boolean_result" "$temp_plist"

    # Replace the original plist file with the updated one
    mv "$temp_plist" "$PLIST_LOG_FILE"
}

write_to_csv() {
    local check_name="$1"
    local result="$2"
    local simple_name="$3"
    local requires_mdm="$4"

    # Define the header
    HEADER="Check Name,Simple Name,Result,Requires MDM"

    # Check if the file exists and if it contains the header
    if [ ! -f "$CSV_LOG_FILE" ]; then
        # File does not exist; write the header
        echo "$HEADER" > "$CSV_LOG_FILE"
    elif ! grep -q "^$HEADER$" "$CSV_LOG_FILE"; then
        # File exists but does not contain the header; add the header
        echo "$HEADER" >> "$CSV_LOG_FILE"
    fi

    # Preserve newlines and special characters by quoting the fields
    local pass_fail
    if [ "$command_output" = "$expected_result" ]; then
        pass_fail="Passed"
    else
        pass_fail="Failed"
    fi

    # Append the data row to the CSV file
    echo "$check_name,$simple_name,$result,$requires_mdm" >> "$CSV_LOG_FILE"
}

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

terminal_fda_guide() {
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

log_settings() {
    clear
    intro_logo
    print_green_bold "#############################################"
    print_green_bold "# Please Select an Option:"
    print_green_bold "#############################################"
    print_green ""

    print_green_bold "1. Display results in the terminal only"
    print_green_orange_italic_menu "Shows system results directly in the terminal"

    print_green_bold "2. Display results in the terminal and export to CSV"
    print_green_orange_italic_menu "Shows system results and saves them to a CSV file"

    print_green_bold "3. Display results in the terminal, export to CSV, and Plist"
    print_green_orange_italic_menu "Shows system results and saves them to both CSV and plist files"

    print_green_bold "4. Return to the SecuraMac main menu"
    print_green_bold "5. Exit SecuraMac"
    print_green ""

    while true; do
        # Print prompt in yellow and read input on the same line
        printf "%b%bEnter your choice [1-5]: %b" "$(eval "$GREEN")" "$(eval "$BOLD")" "$(eval "$RESET_FORMAT")"; read choice

        # Handle user input
        case "$choice" in
        1)
            print_green "You selected terminal logging only...."
            print_green ""
            terminal_logging=1
            firewall_rules
            Logging_rules
            sys_util_rules
            return_to_main_menu
            break
            # Insert code to perform Task 1
            ;;
        2)
            print_green "You selected terminal logging and CSV...."
            print_green ""
            terminal_csv_logging=1
            firewall_rules
            Logging_rules
            sys_util_rules
            return_to_main_menu
            break
            ;;
        3)
            print_green "You selected terminal logging, CSV, and plist...."
            print_green ""
            terminal_csv_plist_logging=1
            firewall_rules
            Logging_rules
            sys_util_rules
            return_to_main_menu
            break
            # Insert code to perform Task 3
            ;;
        4)
            print_green "Returning to main menu..."
            print_green ""
            clear
            script_main_menu
            break
            # Insert code to perform Task 4
            ;;
        5)
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
}

prescript_warning() {
    if [[ "$skip_warning" == "no" ]]; then
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
    fi
}

return_to_main_menu() {

    print_bright_blue_bold "#############################################"
    print_bright_blue_bold "# COMPLETE! Select an Option below:"
    print_bright_blue_bold "#############################################"
    print_green ""
    print_green_bold "1. Return to SecuraMac main menu"
    print_green_bold "2. Exit SecuraMac"
    print_green ""

        while true; do
            printf "%b%bEnter your choice [1/2]: %b" "$(eval "$GREEN")" "$(eval "$BOLD")" "$(eval "$RESET_FORMAT")"; read choice

            # Process user input
            case "$choice" in
                1)
                    print_green "Proceeding to SecuraMac main menu..."
                    sleep 1
                    clear
                    script_main_menu
                    # Place the code to execute if the user chooses Yes here
                    break
                    ;;
                2)
                    print_green "You selected exit SecuraMac..."
                    sleep 1
                    clear
                    echo "SecuraMac Exited"
                    exit 0
                    ;;
                *)
                    print_bright_red_bold "Invalid choice. Please enter 1 or 2."
                    ;;
            esac
        done
}

script_main_menu() {
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
    print_green_bold "1. SecuraMac Enable Rules"
    print_green_orange_italic_menu "Guides users to enable all security options."
    print_green_bold "2. SecuraMac Disable Rules"
    print_green_orange_italic_menu "Guides users to disable all security options."
    print_green_bold "3. SecuraMac Full System Report"
    print_green_orange_italic_menu "Provides a detailed report of current system security."
    print_green_bold "4. SecuraMac Guide to Enable Terminal FDA"
    print_green_orange_italic_menu "FDA Not required, but limits some setting options."
    print_green_bold "5. Exit"
    print_green ""


    while true; do
        # Print prompt in yellow and read input on the same line
        printf "%b%bEnter your choice [1-5]: %b" "$(eval "$GREEN")" "$(eval "$BOLD")" "$(eval "$RESET_FORMAT")"; read choice

        # Handle user input
        case "$choice" in
        1)
            print_green "You selected Perform Full SecuraMac..."
            print_green ""
            disable_execute=0
            terminal_logging=0
            terminal_csv_logging=0
            terminal_csv_plist_logging=0
            firewall_rules
            Logging_rules
            sys_util_rules
            return_to_main_menu
            break
            # Insert code to perform Task 1
            ;;
        2)
            print_green "You selected Perform Disable SecuraMac..."
            print_green ""
            disable_execute=1
            terminal_logging=0
            terminal_csv_logging=0
            terminal_csv_plist_logging=0
            firewall_rules
            Logging_rules
            sys_util_rules
            return_to_main_menu
            break
            # Insert code to perform Task 3
            ;;
        3)
            print_green "You selected Full Secura System Report..."
            print_green ""
            terminal_logging=0
            terminal_csv_logging=0
            terminal_csv_plist_logging=0
            log_settings
            break
            # Insert code to perform Task 4
            ;;
        4)
            print_green "You selected FDA Guide..."
            sleep 1
            terminal_fda_guide
            break
            ;;
        5)
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
}

execute_and_log() {
    local rule_name="$1"
    local rule_recommend="$2"
    local rule_description="$3"
    local rule_check="$4"
    local rule_result="$5"
    local rule_enable="$6"
    local rule_disable="$7"

    # Check the current status
    local status_check=$(eval "$rule_check" 2>&1)

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

    # Check if disable_execute=1 and rule_disable is empty; if true, exit the function
    if [[ "$disable_execute" -eq 1 && -z "$rule_disable" ]]; then
        return
    fi

    # Print statements with formatting using printf
    printf "%b%b-> Rule: %b%s%b\n" "$(eval "$BOLD")$(eval "$GREEN")" "$(eval "$BRIGHT_BLUE")" "$rule_name" "$(eval "$RESET_FORMAT")"

    # Print Current Status in parentheses with bold and color
    printf "%bCurrent Status: %b(%b%b%s%b%b\n" "$(eval "$GREEN")" "$(eval "$WHITE")$(eval "$BOLD")" "$status_color_code" "$current_status" "$(eval "$WHITE")$(eval "$BOLD")" ")" "$(eval "$RESET_FORMAT")"

    if [ "$terminal_logging" -eq 1 ]; then
        return
    fi

    if [[ "$skip_descriptions" == "no" ]]; then
        print_green_orange_italic_rule "$rule_description"
    fi

    # Check if rule_disable is empty
    if [[ -z "$rule_disable" ]]; then
        printf "%b{%b%s%b} %b%s%b\n" "$(eval "$RED")" "$(eval "$ORANGE")" "!" "$(eval "$RED")" "$(eval "$ITALIC")" "WARNING: This feature may not be disabled once enabled" "$(eval "$RESET_FORMAT")"
    fi

    local attempt=1
    local max_attempts=3

    while [[ $attempt -le $max_attempts ]]; do

        if [ "$disable_execute" -eq 0 ]; then
                if [ "$auto_enable" -eq 1 ]; then
                        print_orange_bold ""
                        print_orange_bold "Enabling the rule..."
                        print_orange_bold ""n
                        echo "FAKE ENABLING"
                        # eval "$rule_enable"
                        return
                else
                    printf "%b%bPress Z for Main Menu. Do you want to enable this rule? [Yes/No]: %b" "$(eval "$BRIGHT_BLUE")" "$(eval "$BOLD")" "$(eval "$RESET_FORMAT")"; read user_input
                fi
        else
            printf "%b%bPress Z for Main Menu. Do you want to disable this rule? [Yes/No]: %b" "$(eval "$BRIGHT_BLUE")" "$(eval "$BOLD")" "$(eval "$RESET_FORMAT")"; read user_input
        fi

        case "$user_input" in
            1|y|Y|yes|YES)
                    if [ "$disable_execute" -eq 0 ]; then
                        print_orange_bold ""
                        print_orange_bold "Enabling the rule..."
                        print_orange_bold ""
                        echo "FAKE ENABLING"
                        # eval "$rule_enable"
                    else
                        print_orange_bold ""
                        print_orange_bold "Disabling this rule..."
                        print_orange_bold ""
                        echo "FAKE DISABLING"
                        # eval "$rule_disable"
                    fi
                return
                ;;
            2|n|N|no|NO)
                print_green ""
                print_green_bold "No changes made..."
                print_green ""
                print_green ""
                return
                ;;
            z|Z)
                print_green ""
                print_green_bold "No changes made..."
                print_green "Proceeding to SecuraMac main menu..."
                sleep 1
                clear
                script_main_menu
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

firewall_rules() {

    print_bright_blue_bold "# # # # # # # # # # #"
    print_bright_blue_bold "#                    "
    print_bright_blue_bold "# FIREWALL RULES     "
    print_bright_blue_bold "#                    "
    print_bright_blue_bold "# # # # # # # # # # #"
    print_bright_blue_bold ""

    if [[ "$terminal_logging" -eq 1 || "$terminal_csv_logging" -eq 1 || "$terminal_csv_plist_logging" -eq 1 ]]; then
    # test
    else
        while true; do
            printf "%b%bWould you like to proceed with configuring firewall rules? [Yes or No]: %b" "$(eval "$GREEN")" "$(eval "$BOLD")" "$(eval "$RESET_FORMAT")"; read choice

            # Process user input
            case "$choice" in
                1|y|Y|yes|YES)
                    print_green "Proceeding..."
                    print_green ""
                    sleep 1
                    # Place the code to execute if the user chooses Yes here
                    break
                    ;;
                2|n|N|no|NO)
                    print_green "Skipping firewall rules..."
                    print_green ""
                    sleep 1
                    return
                    break
                    ;;
                *)
                    print_bright_red_bold "Invalid choice. Please enter y for Yes or n for No."
                    ;;
            esac
        done

        if [ "$disable_execute" -eq 0 ]; then
            while true; do
            printf "%b{%b%s%b} %b%s%b\n" "$(eval "$RED")" "$(eval "$ORANGE")" "!" "$(eval "$RED")" "$(eval "$ITALIC")" "WARNING: Some rules cannot be disabled once enabled" "$(eval "$RESET_FORMAT")"
            printf "%b%bWould you like to auto enable all firewall rules? [Yes or No]: %b" "$(eval "$GREEN")" "$(eval "$BOLD")" "$(eval "$RESET_FORMAT")"; read choice

            # Process user input
            case "$choice" in
                1|y|Y|yes|YES)
                    print_green "Proceeding with auto enabling all..."
                    print_green ""
                    auto_enable=1
                    sleep 1
                    # Place the code to execute if the user chooses Yes here
                    break
                    ;;
                2|n|N|no|NO)
                    print_green "Manually enabling firewall rules..."
                    print_green ""
                    auto_enable=0
                    sleep 1
                    break
                    ;;
                *)
                    print_bright_red_bold "Invalid choice. Please enter y for Yes or n for No."
                    ;;
                esac
            done
        else
            auto_enable=0
        fi
    fi
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
    ##############################################
}

Logging_rules() {
    print_bright_blue_bold "# # # # # # # # # # #"
    print_bright_blue_bold "#                    "
    print_bright_blue_bold "# SYS LOGGING RULES  "
    print_bright_blue_bold "#                    "
    print_bright_blue_bold "# # # # # # # # # # #"
    print_bright_blue_bold ""

    while true; do
        printf "%b%bWould you like to proceed with configuring system logging rules? [Yes or No]: %b" "$(eval "$GREEN")" "$(eval "$BOLD")" "$(eval "$RESET_FORMAT")"; read choice

        # Process user input
        case "$choice" in
            1|y|Y|yes|YES)
                print_green "Proceeding..."
                print_green ""
                sleep 1
                # Place the code to execute if the user chooses Yes here
                break
                ;;
            2|n|N|no|NO)
                print_green "Skipping system logging rules..."
                print_green ""
                sleep 1
                return
                break
                ;;
            *)
                print_bright_red_bold "Invalid choice. Please enter y for Yes or n for No."
                ;;
        esac
    done

    if [ "$disable_execute" -eq 0 ]; then
        while true; do
        printf "%b{%b%s%b} %b%s%b\n" "$(eval "$RED")" "$(eval "$ORANGE")" "!" "$(eval "$RED")" "$(eval "$ITALIC")" "WARNING: Some rules cannot be disabled once enabled" "$(eval "$RESET_FORMAT")"
        printf "%b%bWould you like to auto enable all logging rules? [Yes or No]: %b" "$(eval "$GREEN")" "$(eval "$BOLD")" "$(eval "$RESET_FORMAT")"; read choice

        # Process user input
        case "$choice" in
            1|y|Y|yes|YES)
                print_green "Proceeding with auto enabling all..."
                print_green ""
                auto_enable=1
                sleep 1
                # Place the code to execute if the user chooses Yes here
                break
                ;;
            2|n|N|no|NO)
                print_green "Manually enabling logging rules..."
                print_green ""
                auto_enable=0
                sleep 1
                break
                ;;
            *)
                print_bright_red_bold "Invalid choice. Please enter y for Yes or n for No."
                ;;
            esac
        done
    else
        auto_enable=0
    fi

    ##############################################
    Rule_Name="Audit Log Files To Not Contain Access Control List"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="Access control lists will no longer be included in the log files."
    Rule_Check="/bin/ls -le \$(/usr/bin/grep '^dir' /etc/security/audit_control | /usr/bin/awk -F: '{print \$2}') | /usr/bin/awk '{print \$1}' | /usr/bin/grep -c ':'"
    Rule_Result="0"
    Rule_Enable="/bin/chmod -RN /var/audit"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ##############################################
    Rule_Name="Audit Log Folders To Not Contain Access Control List"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="Access control lists will no longer be included in the log folders."
    Rule_Check="/bin/ls -lde /var/audit | /usr/bin/awk '{print \$1}' | /usr/bin/grep -c ':'"
    Rule_Result="0"
    Rule_Enable="/bin/chmod -N /var/audit"
    Rule_Disable=""


    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ##############################################
    Rule_Name="Audit All Administrative Action Events"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="Administrative action events will now be audited for all activities."
    Rule_Check="/usr/bin/awk -F':' '/^flags/ { print \$NF }' /etc/security/audit_control | /usr/bin/tr ',' '\n' | /usr/bin/grep -Ec 'ad'"
    Rule_Result="1"
    Rule_Enable="/usr/bin/grep -qE \"^flags.*[^-]ad\" /etc/security/audit_control || /usr/bin/sed -i.bak '/^flags/ s/\$/,ad/' /etc/security/audit_control; /usr/sbin/audit -s"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ##############################################
    Rule_Name="Audit All Log On Log Out"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="Audits all log on and log out actions in the audit log."
    Rule_Check="/usr/bin/awk -F':' '/^flags/ { print \$NF }' /etc/security/audit_control | /usr/bin/tr ',' '\n' | /usr/bin/grep -Ec '^lo'"
    Rule_Result="1"
    Rule_Enable="/usr/bin/grep -qE \"^flags.*[^-]lo\" /etc/security/audit_control || /usr/bin/sed -i.bak '/^flags/ s/\$/,lo/' /etc/security/audit_control; /usr/sbin/audit -s"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Enable_Security_Auditing"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule checks if the security auditing service is running and if the audit control file exists."
    Rule_Check='LAUNCHD_RUNNING=$(/bin/launchctl list | /usr/bin/grep -c com.apple.auditd); if [[ $LAUNCHD_RUNNING -eq 1 ]] && [[ -e /etc/security/audit_control ]]; then echo "pass"; else echo "fail"; fi'
    Rule_Result="pass"
    Rule_Enable="LAUNCHD_RUNNING=\$(/bin/launchctl list | /usr/bin/grep -c com.apple.auditd); if [[ ! \$LAUNCHD_RUNNING == 1 ]]; then /bin/launchctl load -w /System/Library/LaunchDaemons/com.apple.auditd.plist; fi; if [[ ! -e /etc/security/audit_control ]] && [[ -e /etc/security/audit_control.example ]]; then /bin/cp /etc/security/audit_control.example /etc/security/audit_control; else /usr/bin/touch /etc/security/audit_control; fi"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Configure System To Shutdown Upon Audit Failure"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule ensures that the system is configured to shut down automatically if an audit failure occurs."
    Rule_Check='/usr/bin/awk -F":" "/^policy/ {print \$NF}" /etc/security/audit_control | /usr/bin/tr "," "\\n" | /usr/bin/grep -Ec "ahlt"'
    Rule_Result="1"
    Rule_Enable="/usr/bin/sed -i.bak 's/^policy.*/policy: ahlt,argv/' /etc/security/audit_control; /usr/sbin/audit -s"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Audit Log Files Owned By Root"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule checks that all audit log files are owned by the root user."
    Rule_Check='/bin/ls -n $(/usr/bin/grep "^dir" /etc/security/audit_control | /usr/bin/awk -F: '\''{print $2}'\'') | /usr/bin/awk '\''{s+=$3} END {print s}'\'''
    Rule_Result="0"
    Rule_Enable="/usr/sbin/chown -R root /var/audit/*"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Audit Log Folders Owned By Root"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule checks that all audit log folders are owned by the root user."
    Rule_Check='/bin/ls -dn $(/usr/bin/grep "^dir" /etc/security/audit_control | /usr/bin/awk -F: '\''{print $2}'\'') | /usr/bin/awk '\''{print $3}'\'''
    Rule_Result="0"
    Rule_Enable="/usr/sbin/chown root /var/audit"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Audit Log Files Group Owned By Wheel"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule ensures that audit log files are group-owned by the wheel group."
    Rule_Check='/bin/ls -n $(/usr/bin/grep "^dir" /etc/security/audit_control | /usr/bin/awk -F: '\''{print $2}'\'') | /usr/bin/awk '\''{s+=$4} END {print s}'\'''
    Rule_Result="0"
    Rule_Enable="/usr/bin/chgrp -R wheel /var/audit/*"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Audit Log Folders Group Owned By Wheel"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule checks that all audit log folders are group-owned by the wheel group."
    Rule_Check='/bin/ls -dn $(/usr/bin/grep "^dir" /etc/security/audit_control | /usr/bin/awk -F: '\''{print $2}'\'') | /usr/bin/awk '\''{print $4}'\'''
    Rule_Result="0"
    Rule_Enable="/usr/bin/chgrp wheel /var/audit"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Audit Log Files Mode 440 or Less Permissive"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule checks that audit log files have permissions set to 440 or less permissive."
    Rule_Check="/bin/ls -l \$(/usr/bin/grep '^dir' /etc/security/audit_control | /usr/bin/awk -F: '{print \$2}') | /usr/bin/awk '!/-r--r-----|current|total/{print \$1}' | /usr/bin/wc -l | /usr/bin/tr -d ' '"
    Rule_Result="0"
    Rule_Enable="/bin/chmod 440 /var/audit/*"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Audit Log Folder Mode 700 or Less Permissive"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule checks that audit log folders have permissions set to 700 or less permissive."
    Rule_Check="/usr/bin/stat -f %A \$(/usr/bin/grep '^dir' /etc/security/audit_control | /usr/bin/awk -F: '{print \$2}')"
    Rule_Result="700"
    Rule_Enable="/bin/chmod 700 /var/audit"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Audit All Deletion Of Object Attributes"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule ensures that deletion of object attributes is audited."
    Rule_Check="/usr/bin/awk -F':' '/^flags/ { print \$NF }' /etc/security/audit_control | /usr/bin/tr ',' '\n' | /usr/bin/grep -Ec '\-fd'"
    Rule_Result="1"
    Rule_Enable="/usr/bin/grep -qE \"^flags.*-fd\" /etc/security/audit_control || /usr/bin/sed -i.bak '/^flags/ s/\$/,-fd/' /etc/security/audit_control;/usr/sbin/audit -s"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Audit All Changes Of Object Attributes"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule ensures that changes to object attributes are audited."
    Rule_Check="/usr/bin/awk -F':' '/^flags/ { print \$NF }' /etc/security/audit_control | /usr/bin/tr ',' '\n' | /usr/bin/grep -Ec '^fm'"
    Rule_Result="1"
    Rule_Enable="/usr/bin/grep -qE \"^flags.*fm\" /etc/security/audit_control || /usr/bin/sed -i.bak '/^flags/ s/\$/,fm/' /etc/security/audit_control;/usr/sbin/audit -s"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Audit All Failed Read Actions"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule ensures that all failed read actions are audited."
    Rule_Check="/usr/bin/awk -F':' '/^flags/ { print \$NF }' /etc/security/audit_control | /usr/bin/tr ',' '\n' | /usr/bin/grep -Ec '\-fr'"
    Rule_Result="1"
    Rule_Enable="/usr/bin/grep -qE \"^flags.*-fr\" /etc/security/audit_control || /usr/bin/sed -i.bak '/^flags/ s/\$/,-fr/' /etc/security/audit_control;/usr/sbin/audit -s"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Audit All Failed Write Actions"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule ensures that all failed write actions are audited."
    Rule_Check="/usr/bin/awk -F':' '/^flags/ { print \$NF }' /etc/security/audit_control | /usr/bin/tr ',' '\n' | /usr/bin/grep -Ec '\-fw'"
    Rule_Result="1"
    Rule_Enable="/usr/bin/grep -qE \"^flags.*-fw\" /etc/security/audit_control || /usr/bin/sed -i.bak '/^flags/ s/\$/,-fw/' /etc/security/audit_control;/usr/sbin/audit -s"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Audit All Failed Program Executions"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule ensures that all failed program executions are audited."
    Rule_Check="/usr/bin/awk -F':' '/^flags/ { print \$NF }' /etc/security/audit_control | /usr/bin/tr ',' '\n' | /usr/bin/grep -Ec '-ex'"
    Rule_Result="1"
    Rule_Enable="/usr/bin/grep -qE \"^flags.*-ex\" /etc/security/audit_control || /usr/bin/sed -i.bak '/^flags/ s/\$/,-ex/' /etc/security/audit_control; /usr/sbin/audit -s"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Audit Retention Set To 7 Days"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule ensures that audit log retention is set to 7 days."
    Rule_Check="/usr/bin/awk -F: '/expire-after/{print \$2}' /etc/security/audit_control"
    Rule_Result="7d"
    Rule_Enable="/usr/bin/sed -i.bak 's/^expire-after.*/expire-after:7d/' /etc/security/audit_control; /usr/sbin/audit -s"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Audit Capacity Warning"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule checks that a minimum free space of 25% is set for audit logs."
    Rule_Check="/usr/bin/awk -F: '/^minfree/{print \$2}' /etc/security/audit_control"
    Rule_Result="25"
    Rule_Enable="/usr/bin/sed -i.bak 's/.*minfree.*/minfree:25/' /etc/security/audit_control; /usr/sbin/audit -s"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Audit Failure Notification"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule ensures that audit failures are logged with a notification."
    Rule_Check="/usr/bin/grep -c 'logger -s -p' /etc/security/audit_warn"
    Rule_Result="1"
    Rule_Enable="/usr/bin/sed -i.bak 's/logger -p/logger -s -p/' /etc/security/audit_warn; /usr/sbin/audit -s"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Audit_All_Authorization_Authentication_Events"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule checks if all authorization and authentication events are being audited."
    Rule_Check="/usr/bin/awk -F':' '/^flags/ { print \$NF }' /etc/security/audit_control | /usr/bin/tr ',' '\n' | /usr/bin/grep -Ec 'aa'"
    Rule_Result="1"
    Rule_Enable="/usr/bin/grep -qE \"^flags.*[^-]aa\" /etc/security/audit_control || /usr/bin/sed -i.bak '/^flags/ s/\$/,aa/' /etc/security/audit_control; /usr/sbin/audit -s"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Configure_Audit_Control_Group_To_Wheel"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule ensures that the audit control file group is set to wheel."
    Rule_Check="/bin/ls -dn /etc/security/audit_control | /usr/bin/awk '{print \$4}'"
    Rule_Result="0"
    Rule_Enable="/usr/bin/chgrp wheel /etc/security/audit_control"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Configure_Audit_Control_Owner_To_Root"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule ensures that the audit control file is owned by root."
    Rule_Check="/bin/ls -dn /etc/security/audit_control | /usr/bin/awk '{print \$3}'"
    Rule_Result="0"
    Rule_Enable="/usr/sbin/chown root /etc/security/audit_control"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Configure_Audit_Control_To_Mode_440_or_Less_Permissive"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule ensures that the audit control file has permissions set to 440 or less permissive."
    Rule_Check="/bin/ls -l /etc/security/audit_control | /usr/bin/awk '!/-r--[r-]-----|current|total/{print \$1}' | /usr/bin/wc -l | /usr/bin/xargs"
    Rule_Result="0"
    Rule_Enable="/bin/chmod 440 /etc/security/audit_control"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Configure_Audit_Control_To_Not_Contain_Access_Control_Lists"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule ensures that the audit control file does not contain access control lists."
    Rule_Check="/bin/ls -le /etc/security/audit_control | /usr/bin/awk '{print \$1}' | /usr/bin/grep -c \":\""
    Rule_Result="0"
    Rule_Enable="/bin/chmod -N /etc/security/audit_control"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Configure_Apple_System_Log_Files_To_Be_Owned_By_Root_and_Group_To_Wheel"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule ensures that Apple system log files are owned by root and the group is set to wheel."
    Rule_Check="/usr/bin/stat -f '%Su:%Sg:%N' \$(/usr/bin/grep -e '^>' /etc/asl.conf /etc/asl/* | /usr/bin/awk '{ print \$2 }') 2> /dev/null | /usr/bin/awk '!/^root:wheel:/{print \$1}' | /usr/bin/wc -l | /usr/bin/tr -d ' '"
    Rule_Result="0"
    Rule_Enable="/usr/sbin/chown root:wheel \$(/usr/bin/stat -f '%Su:%Sg:%N' \$(/usr/bin/grep -e '^>' /etc/asl.conf /etc/asl/* | /usr/bin/awk '{ print \$2 }') 2> /dev/null | /usr/bin/awk '!/^root:wheel:/{print \$1}' | /usr/bin/awk -F\":\" '!/^root:wheel:/{print \$3}')"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Configure_Apple_System_Log_Files_To_Mode_640_Or_Less_Permissive"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule ensures that Apple system log files have permissions set to 640 or less permissive."
    Rule_Check="/usr/bin/stat -f '%A:%N' \$(/usr/bin/grep -e '^>' /etc/asl.conf /etc/asl/* | /usr/bin/awk '{ print \$2 }') 2> /dev/null | /usr/bin/awk '!/640/{print \$1}' | /usr/bin/wc -l | /usr/bin/tr -d ' '"
    Rule_Result="0"
    Rule_Enable="/bin/chmod 640 \$(/usr/bin/stat -f '%A:%N' \$(/usr/bin/grep -e '^>' /etc/asl.conf /etc/asl/* | /usr/bin/awk '{ print \$2 }') 2> /dev/null | /usr/bin/awk -F\":\" '!/640/{print \$2}')"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Configure_System_Log_Files_To_Be_Owned_By_Root_and_Group_To_Wheel"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule ensures that system log files are owned by root and the group is set to wheel."
    Rule_Check="/usr/bin/stat -f '%Su:%Sg:%N' \$(/usr/bin/grep -v '^#' /etc/newsyslog.conf | /usr/bin/awk '{ print \$1 }') 2> /dev/null | /usr/bin/awk '!/^root:wheel:/{print \$1}' | /usr/bin/wc -l | /usr/bin/tr -d ' '"
    Rule_Result="0"
    Rule_Enable="/usr/sbin/chown root:wheel \$(/usr/bin/stat -f '%Su:%Sg:%N' \$(/usr/bin/grep -v '^#' /etc/newsyslog.conf | /usr/bin/awk '{ print \$1 }') 2> /dev/null | /usr/bin/awk -F\":\" '!/^root:wheel:/{print \$3}')"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Configure_System_Log_Files_To_Mode_640_Or_Less_Permissive"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule ensures that system log files have permissions set to 640 or less permissive."
    Rule_Check="/usr/bin/stat -f '%A:%N' \$(/usr/bin/grep -v '^#' /etc/newsyslog.conf | /usr/bin/awk '{ print \$1 }') 2> /dev/null | /usr/bin/awk '!/640/{print \$1}' | /usr/bin/wc -l | /usr/bin/tr -d ' '"
    Rule_Result="0"
    Rule_Enable="/bin/chmod 640 \$(/usr/bin/stat -f '%A:%N' \$(/usr/bin/grep -v '^#' /etc/newsyslog.conf | /usr/bin/awk '{ print \$1 }') 2> /dev/null | /usr/bin/awk '!/640/{print \$1}' | awk -F\":\" '!/640/{print \$2}')"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="System_Log_Retention_To_365"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule ensures that system log retention is set to 365 days."
    Rule_Check="/usr/sbin/aslmanager -dd 2>&1 | /usr/bin/awk '/\/var\/log\/install.log/ {count++} /Processing module com.apple.install/,/Finished/ { for (i=1;i<=NR;i++) { if (\$i == \"TTL\" && \$(i+2) >= 365) { ttl=\"True\" }; if (\$i == \"MAX\") {max=\"True\"}}} END{if (count > 1) { print \"Multiple config files for /var/log/install, manually remove\"} else if (ttl != \"True\") { print \"TTL not configured\" } else if (max == \"True\") { print \"Max Size is configured, must be removed\" } else { print \"Yes\" }}'"
    Rule_Result="Yes"
    Rule_Enable="/usr/bin/sed -i '' \"s/\* file \/var\/log\/install.log.*/\* file \/var\/log\/install.log format='\$\(\(Time\)\(JZ\)\) \$Host \$\(Sender\)\[\$\(PID\\)\]: \$Message' rotate=utc compress file_max=50M size_only ttl=365/g\" /etc/asl/com.apple.install"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Configure_Sudoers_Timestamp_Type"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="This rule ensures that the sudoers timestamp type is set correctly."
    Rule_Check="/usr/bin/sudo /usr/bin/sudo -V | /usr/bin/awk -F\": \" '/Type of authentication timestamp record/{print \$2}'"
    Rule_Result="tty"
    Rule_Enable="/usr/bin/find /etc/sudoers* -type f -exec sed -i '' '/timestamp_type/d; /!tty_tickets/d' '{}' \;"
    Rule_Disable=""

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
}

sys_util_rules() {

    print_bright_blue_bold "# # # # # # # # # # #"
    print_bright_blue_bold "#                    "
    print_bright_blue_bold "# SYSTEM UTIL RULES  "
    print_bright_blue_bold "#                    "
    print_bright_blue_bold "# # # # # # # # # # #"
    print_bright_blue_bold ""

        while true; do
        printf "%b%bWould you like to proceed with configuring system utility rules? [Yes or No]: %b" "$(eval "$GREEN")" "$(eval "$BOLD")" "$(eval "$RESET_FORMAT")"; read choice

        # Process user input
        case "$choice" in
            1|y|Y|yes|YES)
                print_green "Proceeding..."
                print_green ""
                sleep 1
                # Place the code to execute if the user chooses Yes here
                break
                ;;
            2|n|N|no|NO)
                print_green "Skipping system utility rules..."
                print_green ""
                sleep 1
                return
                break
                ;;
            *)
                print_bright_red_bold "Invalid choice. Please enter y for Yes or n for No."
                ;;
        esac
    done

        if [ "$disable_execute" -eq 0 ]; then
        while true; do
        printf "%b{%b%s%b} %b%s%b\n" "$(eval "$RED")" "$(eval "$ORANGE")" "!" "$(eval "$RED")" "$(eval "$ITALIC")" "WARNING: Some rules cannot be disabled once enabled" "$(eval "$RESET_FORMAT")"
        printf "%b%bWould you like to auto enable all system utility rules? [Yes or No]: %b" "$(eval "$GREEN")" "$(eval "$BOLD")" "$(eval "$RESET_FORMAT")"; read choice

        # Process user input
        case "$choice" in
            1|y|Y|yes|YES)
                print_green "Proceeding with auto enabling all..."
                print_green ""
                auto_enable=1
                sleep 1
                # Place the code to execute if the user chooses Yes here
                break
                ;;
            2|n|N|no|NO)
                print_green "Manually enabling system utility rules..."
                print_green ""
                auto_enable=0
                sleep 1
                break
                ;;
            *)
                print_bright_red_bold "Invalid choice. Please enter y for Yes or n for No."
                ;;
            esac
        done
    else
        auto_enable=0
    fi

    ######################################
    Rule_Name="Disable Server Message Block Sharing"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="Disabling the SMB sharing service helps secure your system by preventing unauthorized access to shared files over the network."
    Rule_Check="/bin/launchctl print-disabled system | /usr/bin/grep -c '\"com.apple.smbd\" => disabled'"
    Rule_Result="1"
    Rule_Enable="/bin/launchctl disable system/com.apple.smbd"
    Rule_Disable="/bin/launchctl enable system/com.apple.smbd"

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Disable Network File System Service"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="Disabling NFS prevents unauthorized file access and sharing over the network, improving system security."
    Rule_Check="/bin/launchctl print-disabled system | /usr/bin/grep -c '\"com.apple.nfsd\" => disabled'"
    Rule_Result="1"
    Rule_Enable="/bin/launchctl disable system/com.apple.nfsd"
    Rule_Disable="/bin/launchctl enable system/com.apple.nfsd"

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Disable Location Services"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="Disabling Location Services protects user privacy by preventing apps from accessing location data."
    Rule_Check="/usr/bin/sudo -u _locationd /usr/bin/osascript -l JavaScript -e \"$.NSUserDefaults.alloc.initWithSuiteName('com.apple.locationd').objectForKey('LocationServicesEnabled').js\""
    Rule_Result="false"
    Rule_Enable="/usr/bin/defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -bool false; /bin/launchctl kickstart -k system/com.apple.locationd"
    Rule_Disable="/usr/bin/defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -bool true; /bin/launchctl kickstart -k system/com.apple.locationd"

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Disable Unix to Unix Copy Protocol Service"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="Disabling UUCP prevents potential exploitation of outdated communication protocols, securing the system."
    Rule_Check="/bin/launchctl print-disabled system | /usr/bin/grep -c '\"com.apple.uucp\" => disabled'"
    Rule_Result="1"
    Rule_Enable="/bin/launchctl disable system/com.apple.uucp"
    Rule_Disable="/bin/launchctl enable system/com.apple.uucp"

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Disable Built-In Web Server"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="Disabling the built-in web server (Apache) secures your system by preventing unauthorized web service access."
    Rule_Check="/bin/launchctl print-disabled system | /usr/bin/grep -c '\"org.apache.httpd\" => disabled'"
    Rule_Result="1"
    Rule_Enable="/bin/launchctl disable system/org.apache.httpd"
    Rule_Disable="/bin/launchctl enable system/org.apache.httpd"

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Disable Remote Apple Events"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="Disabling Remote Apple Events prevents remote control of your system, increasing overall security."
    Rule_Check="/bin/launchctl print-disabled system | /usr/bin/grep -c '\"com.apple.AEServer\" => disabled'"
    Rule_Result="1"
    Rule_Enable="/usr/sbin/systemsetup -setremoteappleevents off && /bin/launchctl disable system/com.apple.AEServer"
    Rule_Disable="/usr/sbin/systemsetup -setremoteappleevents on && /bin/launchctl enable system/com.apple.AEServer"

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Disable Trivial File Transfer Protocol Service"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="Disabling TFTP protects your system from unauthorized file transfers, enhancing security."
    Rule_Check="/bin/launchctl print-disabled system | /usr/bin/grep -c '\"com.apple.tftpd\" => disabled'"
    Rule_Result="1"
    Rule_Enable="/bin/launchctl disable system/com.apple.tftpd"
    Rule_Disable="/bin/launchctl enable system/com.apple.tftpd"

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Disable Bluetooth Sharing"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="Disabling Bluetooth Sharing ensures that files are not shared over Bluetooth, protecting sensitive data."
    CURRENT_USER=$( /usr/sbin/scutil <<< "show State:/Users/ConsoleUser" | /usr/bin/awk '/Name :/ && ! /loginwindow/ { print $3 }' ) ## Required for Command
    Rule_Check="/usr/bin/sudo -u \"\$CURRENT_USER\" /usr/bin/defaults -currentHost read com.apple.Bluetooth PrefKeyServicesEnabled"
    Rule_Result="0"
    Rule_Enable="/usr/bin/sudo -u \"\$CURRENT_USER\" /usr/bin/defaults -currentHost write com.apple.Bluetooth PrefKeyServicesEnabled -bool false"
    Rule_Disable="/usr/bin/sudo -u \"\$CURRENT_USER\" /usr/bin/defaults -currentHost write com.apple.Bluetooth PrefKeyServicesEnabled -bool true"

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Disable CD/DVD Sharing"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="Disabling CD/DVD Sharing prevents unauthorized access to media drives, securing your system."
    Rule_Check="/usr/bin/pgrep -q ODSAgent; /bin/echo \$?"
    Rule_Result="1"
    Rule_Enable="/bin/launchctl unload /System/Library/LaunchDaemons/com.apple.ODSAgent.plist"
    Rule_Disable="/bin/launchctl load /System/Library/LaunchDaemons/com.apple.ODSAgent.plist"

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Disable Printer Sharing"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="Disabling Printer Sharing ensures that printers are not accessible over the network, protecting sensitive data."
    Rule_Check="/usr/sbin/cupsctl | /usr/bin/grep -c \"_share_printers=0\""
    Rule_Result="1"
    Rule_Enable="/usr/sbin/cupsctl --no-share-printers && /usr/bin/lpstat -p | awk '{print \$2}'| /usr/bin/xargs -I{} lpadmin -p {} -o printer-is-shared=false"
    Rule_Disable="/usr/sbin/cupsctl --share-printers && /usr/bin/lpstat -p | awk '{print \$2}'| /usr/bin/xargs -I{} lpadmin -p {} -o printer-is-shared=true"

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
    Rule_Name="Disable Remote Management"
    Rule_Recommend="Do you want to enable this rule?"
    Rule_Description="Disabling Remote Management prevents unauthorized control of your system, enhancing security."
    Rule_Check="/usr/libexec/mdmclient QuerySecurityInfo | /usr/bin/grep -c \"RemoteDesktopEnabled = 0\""
    Rule_Result="1"
    Rule_Enable="/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -stop"
    Rule_Disable="/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate"

    execute_and_log "$Rule_Name" "$Rule_Recommend" "$Rule_Description" "$Rule_Check" "$Rule_Result" "$Rule_Enable" "$Rule_Disable"
    ###########################################
}

# Trigger Prescript Warning Variable
prescript_warning

# Trigger Main Menu Variable
script_main_menu

exit 0


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

check_name="V-259555"
simple_name="System_Must_Reauthenticate_For_Priviledge_Escalations_When_Using_Sudo_Command"
command="/usr/bin/sudo /usr/bin/sudo -V | /usr/bin/grep -c \"Authentication timestamp timeout: 0.0 minutes\""
expected_result="1"
fix_command="/usr/bin/find /etc/sudoers* -type f -exec sed -i '' '/timestamp_timeout/d' '{}' \;
/bin/echo \"Defaults timestamp_timeout=0\" >> /etc/sudoers.d/mscp"



# SSH Rules
########################################
# Requires Full Disk access
Rule_Name="SSH"
Rule_Recommend="Do you use SSH?"
Rule_Description="If no, remote login will be turned off"
Rule_Check='sudo systemsetup -getremotelogin | grep -q "on" && echo "true" || echo "false"'
Rule_Enable="sudo systemsetup -f -setremotelogin on"
Rule_Disable="sudo systemsetup -f -setremotelogin off"


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