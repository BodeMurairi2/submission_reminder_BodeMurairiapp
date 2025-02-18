#!/bin/bash
# This script sets up the environment
# for the application submission reminder app to run

# Create the root directory project
read -p "Enter your name: " name
dir_path="submission_reminder_$name"

mkdir "$dir_path"

# Create the README.md file
touch "README.md"

# Check if the directory was created successfully
if [ -d "$dir_path" ]; then
    echo "Directory created successfully"

    # Create the subdirectories and the startup.sh file
    mkdir "$dir_path/app"
    mkdir "$dir_path/modules"
    mkdir "$dir_path/assets"
    mkdir "$dir_path/config"
    touch "$dir_path/startup.sh"
    chmod a+x "$dir_path/startup.sh"

    echo "startup.sh and directories created successfully"
else
    echo "Directory creation failed"
fi

# Save application required modules inside the subdirectories
modules_path="application_modules"
chmod +r "$modules_path"

if [ -d "$modules_path" ]; then
    cp "$modules_path/reminder.sh" "$dir_path/app/"
    cp "$modules_path/functions.sh" "$dir_path/modules/"
    cp "$modules_path/config.env" "$dir_path/config/"
    cp "$modules_path/submissions.txt" "$dir_path/assets/"
    echo "Modules copied successfully"
    echo "Environment set up successfully"
else
    echo "Modules not found"
    echo "Environment set up failed. Failed to copy files to the project directory"
fi
