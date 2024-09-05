if ! plutil -lint /Library/Preferences/com.apple.SoftwareUpdate.plist >/dev/null 2>&1; then
    print_bright_red_bold "Terminal does not have Full Disk Access."
    print_bright_red_bold "Please grant Full Disk Access to Terminal by following these steps:"
    print_bright_red_bold "1. Open System Preferences."
    print_bright_red_bold "2. Go to Privacy & Security > Full Disk Access."
    print_bright_red_bold "3. Click the lock icon to make changes (you may need to enter your password)."
    print_bright_red_bold "4. Click the '+' button and add Terminal from /Applications/Utilities."
    print_bright_red_bold "5. Restart Terminal for the changes to take effect."
    exit 0
fi

#!/bin/zsh

# Define the file to check
FILE="/Library/Application Support/com.apple.TCC/TCC.db"

# Attempt to check read access to the file and capture output and errors
OUTPUT=$(sudo test -r "$FILE" 2>&1)
EXIT_STATUS=$?

if [[ $EXIT_STATUS -ne 0 ]]; then
  if [[ $EXIT_STATUS -eq 1 ]]; then
    # Check if it's a permission error
    echo "This script requires Full Disk Access."
    echo "Add Terminal to the Full Disk Access list in System Preferences > Privacy & Security."
    echo "Quit Terminal and re-run this script after granting Full Disk Access."
  else
    # Other errors
    echo "Error accessing the file: $FILE"
    echo "Error details: $OUTPUT"
  fi
else
  # File accessed successfully
  echo "Terminal has Full Disk Access."
fi
