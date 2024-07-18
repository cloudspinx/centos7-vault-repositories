#!/bin/bash

# Directory where .repo files are stored
repo_dir="centos7_repos"

# Check if repo_dir exists and contains .repo files
if [ ! -d "${repo_dir}" ] || ! ls "${repo_dir}"/*.repo &> /dev/null; then
    echo "No .repo files found in ${repo_dir}. Please run the repo generation script first."
    exit 1
fi

# List all .repo files in the directory
repo_files="${repo_dir}"/*.repo

# Iterate over each .repo file
for repo_file in ${repo_files}; do
    # Extract repository name from the file name
    repo_name=$(basename "${repo_file}" .repo)
    
    # Prompt user to enable the repository
    read -p "Do you want to enable repository '${repo_name}' (y/n)? " enable_repo
    
    # Check user's input
    case "${enable_repo}" in
        [Yy]*)
            # Enable the repository by setting enabled=1
            sed -i 's/^enabled=.*/enabled=1/' "${repo_file}"
            echo "Enabled repository '${repo_name}'."
            ;;
        [Nn]*)
            # Disable the repository by setting enabled=0
            sed -i 's/^enabled=.*/enabled=0/' "${repo_file}"
            echo "Disabled repository '${repo_name}'."
            ;;
        *)
            echo "Invalid input '${enable_repo}'. Skipping repository '${repo_name}'."
            ;;
    esac
done

echo "Repository enablement process completed."
