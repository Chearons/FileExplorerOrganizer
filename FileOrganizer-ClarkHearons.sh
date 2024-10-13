#!/bin/bash

# Function to display help
usage() {
    echo "Usage: $0 [-d directory] [-h]"
    echo "   -d directory : Specify the directory to organize (default: $HOME/Downloads)"
    echo "   -h           : Display this help message"
    echo " Example: "./Bash_Project.sh" "-d" "HOME/Downloads...Desktop...Directory Name...""
    exit 0
}

# Default directory to organize
target_directory="$HOME/Downloads"

# Parse command line options
while getopts "d:h" opt; do
    case $opt in
        d) target_directory=$OPTARG ;;
        h) usage ;;
        *) echo "Invalid option: -$OPTARG" >&2; usage ;;
    esac
done

# Define directories for file types
declare -A directories
directories=(
    ["Images"]=".*\.(jpg|png|gif)$"
    ["Documents"]=".*\.(txt|pdf|docx)$"
    ["Scripts"]=".*\.(sh|py|js)$"
    ["Zipped"]=".*\.(zip)$"
)

# Create directories if they don't exist
for dir in "${!directories[@]}"; do
    mkdir -p "$target_directory/$dir"
done

# Move files to respective directories based on regex patterns
for dir in "${!directories[@]}"; do
    pattern=${directories[$dir]}
    for file in "$target_directory"/*; do
        if [[ $(basename "$file") =~ $pattern ]]; then
            mv "$file" "$target_directory/$dir"
        fi
    done
done

echo "Files organized successfully in $target_directory!"