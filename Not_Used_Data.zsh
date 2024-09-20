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


#   # SSH Rules (Comment - SSH can break things for many users who dont understand FIPS/Keys, also enable/disable requires full disk access, may add this later on)
#   ########################################
#    # Requires Full Disk access
#    Rule_Name="SSH"
#    Rule_Recommend="Do you use SSH?"
#    Rule_Description="If no, remote login will be turned off"
#    Rule_Check='sudo systemsetup -getremotelogin | grep -q "on" && echo "true" || echo "false"'
#    Rule_Enable="sudo systemsetup -f -setremotelogin on"
#    Rule_Disable="sudo systemsetup -f -setremotelogin off"
#   ###########################################
#    Rule_Name="Disable Root Login for SSH"
#    Rule_Recommend="Do you want to disable or enable this rule?"
#    Rule_Description="This rule ensures that SSH does not allow root login by checking the SSH configuration and updating it if necessary."
#    Rule_Check="/usr/sbin/sshd -G | /usr/bin/awk '/permitrootlogin/{print \$2}'"
#    Rule_Result="no"
#    Rule_Enable="include_dir=\$(/usr/bin/awk '/^Include/ {print \$2}' /etc/ssh/sshd_config | /usr/bin/tr -d '*'); if [[ -z \$include_dir ]]; then /usr/bin/sed -i.bk \"1s/.*/Include \/etc\/ssh\/sshd_config.d\/\*/\" /etc/ssh/sshd_config; fi; /usr/bin/grep -qxF 'permitrootlogin no' \"\${include_dir}01-mscp-sshd.conf\" 2>/dev/null || echo \"permitrootlogin no\" >> \"\${include_dir}01-mscp-sshd.conf\"; for file in \$(ls \${include_dir}); do if [[ \"\$file\" == \"100-macos.conf\" ]]; then continue; fi; if [[ \"\$file\" == \"01-mscp-sshd.conf\" ]]; then break; fi; /bin/mv \${include_dir}\${file} \${include_dir}20-\${file}; done"
#    Rule_Disable=""
#    ###########################################
#    Rule_Name="Disable Password Authentication For SSH"
#    Rule_Recommend="Do you want to disable or enable this rule?"
#    Rule_Description="This rule ensures that SSH does not allow password-based authentication by checking the SSH configuration and updating it if necessary."
#    Rule_Check="/usr/sbin/sshd -G | /usr/bin/grep -Ec '^(passwordauthentication\s+no|kbdinteractiveauthentication\s+no)'"
#    Rule_Result="2"
#    Rule_Enable="include_dir=\$(/usr/bin/awk '/^Include/ {print \$2}' /etc/ssh/sshd_config | /usr/bin/tr -d '*'); if [[ -z \$include_dir ]]; then /usr/bin/sed -i.bk \"1s/.*/Include \/etc\/ssh\/sshd_config.d\/\*/\" /etc/ssh/sshd_config; fi; echo \"passwordauthentication no\" >> \"\${include_dir}01-mscp-sshd.conf\"; echo \"kbdinteractiveauthentication no\" >> \"\${include_dir}01-mscp-sshd.conf\"; for file in \$(ls \${include_dir}); do if [[ \"\$file\" == \"100-macos.conf\" ]]; then continue; fi; if [[ \"\$file\" == \"01-mscp-sshd.conf\" ]]; then break; fi; /bin/mv \${include_dir}\${file} \${include_dir}20-\${file}; done"
#    Rule_Disable=""
#   ###########################################