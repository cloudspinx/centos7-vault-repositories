#!/bin/bash

# URL of the CentOS 7 vault
#base_url="https://vault.centos.org/centos/7/"
base_url="https://vault.centos.org/centos/\$releasever"

# Directory to store generated .repo files
repo_dir="centos7_repos"

# Create the directory if it doesn't exist
mkdir -p "${repo_dir}"

# Fetch repository list
#repo_list=$(curl -s "${base_url}")

# Extract repository URLs from the HTML
#repos=$(echo "${repo_list}" | grep -oP '(?<=href=")[^"]+(?=/?"\>)' | grep '^atomic\|^cloud\|^config\|^cr\|^extras\|^fasttrack\|^highavailability\|^iso\|^os\|^paas\|^rt\|^sclo\|^storage\|^updates\|^virt')

# List of repositories to generate .repo files for
# Others excluded check https://vault.centos.org/centos/7/
repos=(
    "atomic"
    "centosplus"
    "dotnet"
    "extras"
    "fasttrack"
    "os"
    "rt"
    "updates"
)

# Loop through each repository and generate a .repo file
for repo_name in "${repos[@]}"; do
    cat << EOF > "${repo_dir}/${repo_name}.repo"
[${repo_name}]
name=CentOS-\$releasever - ${repo_name}
baseurl=${base_url}/${repo_name}/\$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
enabled=0
EOF
 echo "Created centos7_repos/${repo_name}.repo"
done

echo "Generated .repo files for all repositories in ${repo_dir}."
