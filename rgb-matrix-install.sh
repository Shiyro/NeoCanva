#!/usr/bin/expect -f

# Set variables
set SCRIPT_REMOTE_URL "https://raw.githubusercontent.com/adafruit/Raspberry-Pi-Installer-Scripts/main/rgb-matrix.sh"
set SCRIPT_LOCAL_PATH "/tmp/rgb-matrix.sh"

# Download the script
spawn bash -c "curl -o $SCRIPT_LOCAL_PATH $SCRIPT_REMOTE_URL"
expect "$ "  ;# Expect the command prompt, indicating the command has finished

# Check if the file exists and is a regular file
spawn bash -c "test -f $SCRIPT_LOCAL_PATH && echo 'File is valid' || echo 'File is not valid'"
expect {
    "File is not valid" {
        send_user "The file was not downloaded correctly.\n"
        exit 1
    }
    "File is valid" {
        send_user "The file was downloaded correctly.\n"
    }
}

# Set the downloaded script to be executable
spawn chmod +x $SCRIPT_LOCAL_PATH
expect "$ "  ;# Expect the command prompt after chmod has finished

# Run the script
log_file output.log
spawn bash -c "$SCRIPT_LOCAL_PATH 2>&1"
set timeout 600
expect {
    "CONTINUE? " { 
        send "y\r" 
        send_user "Answered yes to continue.\n"
        exp_continue
    }
    "1. Adafruit RGB Matrix Bonnet" { 
        send "1\r" 
        send_user "Selected Adafruit RGB Matrix Bonnet.\n"
        exp_continue
    }
    "1. Quality (disables sound, requires soldering)" { 
        send "1\r" 
        send_user "Selected Quality (disables sound, requires soldering).\n"
        exp_continue
    }
    "REBOOT NOW? " { 
        send "n\r" 
        send_user "The installation is complete. Please reboot your system.\n"
    }
}
log_file;  # Stop logging

# Remove the script
spawn bash -c "rm $SCRIPT_LOCAL_PATH"
expect "$ "  ;# Expect the command prompt, indicating the command has finished
