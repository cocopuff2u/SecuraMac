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

    if [[ "$status_check" == "$rule_result" ]]; then
        current_status="enabled"
    else
        current_status="disabled"
    fi

    echo "Rule: $rule_name"
    echo "Current Status: $current_status"
    echo "{?} $rule_description"

    local attempt=1
    local max_attempts=3

    while [[ $attempt -le $max_attempts ]]; do
        read -p "$rule_recommend (Yes/No)? " user_input

        case "$user_input" in
            1|y|Y|yes|YES)
                echo "Enabling the rule..."
                eval "$rule_enable"
                echo "Rule has been enabled."
                return
                ;;
            2|n|N|no|NO)
                echo "No changes made."
                return
                ;;
            *)
                if [[ $attempt -lt $max_attempts ]]; then
                    echo "Invalid input. Please enter 'Yes' or 'No'."
                else
                    echo "Invalid input. Defaulting to 'No'."
                    echo "No changes made."
                fi
                ;;
        esac
        ((attempt++))
    done
}

echo "##############################################"
echo "# FIREWALL RULES"
echo "##############################################"
echo ""
echo ""

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
