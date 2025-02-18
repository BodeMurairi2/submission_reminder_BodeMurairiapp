#!/bin/bash
# This script sets up the environment
# for the application submission reminder app to run

# Create the root directory project
read -p "Enter your name: " username
dir_path="submission_reminder_$username"

mkdir "$dir_path"

# Check if the directory was created successfully
if [ -d "$dir_path" ]; then
    echo "Project directory created successfully"

    # Create the subdirectories and the startup.sh file
    mkdir "$dir_path/app"
    mkdir "$dir_path/modules"
    mkdir "$dir_path/assets"
    mkdir "$dir_path/config"
        
    echo "Project subdirectories created successfully"
else
    echo "Directory creation failed"
fi

# Create the startup.sh file
cat > "$dir_path/startup.sh" << 'EOF'
#!/usr/bin/env bash
# This script runs the application
bash app/reminder.sh

EOF

echo "startup.sh created successfully"

# Make the startup.sh file executable
chmod a+x "$dir_path/startup.sh"

# Create the config.env file
cat > "$dir_path/config/config.env" << 'EOF'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

echo "config.env created successfully"

# Create the reminder.sh file
cat > "$dir_path/app/reminder.sh" << 'EOF'
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

echo "reminder.sh file created successfully"

# Make reminder.sh executable
chmod a+x "$dir_path/app/reminder.sh"

# Create the functions.sh file
cat > "$dir_path/modules/functions.sh" << 'EOF'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF
echo "functions.sh file created successfully"

# Make functions.sh executable
chmod a+x "$dir_path/modules/functions.sh"

# Create the submissions.txt file
cat > "$dir_path/assets/submissions.txt" << 'EOF'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Shell Navigation, not submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Navigation, submitted
Bode, Shell Navigation, submitted
Maurice, Shell Navigation, not submitted
Jean-Francois, Shell Navigation, submitted
Pascaline, Shell Navigation, not submitted
Angeline, Shell Navigation, not submitted
Ornella, Shell Navigation, submitted
EOF
echo "submissions.txt file created successfully"
echo "Environment setup completed successfully"
echo "Navigate to the $dir_path directory to run the application"
echo "Run the application using the command: ./startup.sh"
echo "Environment Setup complete, built by Bode Murairi"