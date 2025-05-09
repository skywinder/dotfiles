#!/bin/bash
set -euo pipefail  # Exit on error, undefined vars, and pipe failures

############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

# Function for error handling
error_handler() {
    echo "Error occurred in script at line: ${1}"
    exit 1
}

trap 'error_handler ${LINENO}' ERR

# Function to handle bin directory installation
install_bin_directory() {
    echo -n "Setting up bin directory ..."

    # Check if bin directory exists and is a git repository
    if [[ -d "${HOME}/bin" && -d "${HOME}/bin/.git" ]]; then
        echo "~/bin exists and is a git repository"

        # Check for unstaged changes
        if ! (cd "${HOME}/bin" && git diff --quiet); then
            echo "Warning: Unstaged changes detected in ~/bin"

            read -p "Would you like to (s)tash changes, (i)gnore and skip update, or (f)orce stash and update? [s/i/f] " choice

            case "$choice" in
                s|S)
                    echo "Stashing changes in ~/bin"
                    (cd "${HOME}/bin" && git stash)
                    ;;
                f|F)
                    echo "Force stashing changes in ~/bin"
                    (cd "${HOME}/bin" && git stash --include-untracked)
                    ;;
                *)
                    echo "Skipping bin directory update"
                    return 0
                    ;;
            esac
        fi

        # Try to update the repository
        echo "Updating bin directory..."
        if ! (cd "${HOME}/bin" && git pull --rebase); then
            echo "Warning: Failed to update bin directory, but continuing with other tasks"
            return 0  # Non-fatal error, continue script
        fi
    else
        # If bin doesn't exist or is not a git repository, run install_bin.sh
        echo "Installing bin directory..."
        if ! ./install_bin.sh; then
            echo "Warning: Failed to install bin directory, but continuing with other tasks"
            return 0  # Non-fatal error, continue script
        fi
    fi

    echo "bin directory setup complete"
    return 0
}

# Function to ensure yq is installed
ensure_yq() {
    if ! command -v yq >/dev/null 2>&1; then
        echo "Installing yq for YAML parsing..."
        if command -v brew >/dev/null 2>&1; then
            brew install yq
        else
            echo "Error: brew not found. Please install yq manually"
            exit 1
        fi
    fi
}

# Function to read config values
read_config() {
    local config_file="${dir}/config.yml"
    if [[ ! -f "${config_file}" ]]; then
        echo "Error: config.yml not found at ${config_file}"
        exit 1
    fi
    yq "$1" "${config_file}"
}

# Validate config structure
validate_config() {
    local required_keys=(
        '.dotfiles.directory'
        '.dotfiles.backup_directory'
        '.dotfiles.files'
        '.brew.packages'
    )

    for key in "${required_keys[@]}"; do
        if ! read_config "${key}" >/dev/null 2>&1; then
            echo "Error: Required configuration key '${key}' not found in config.yml"
            exit 1
        fi
    done
}

# Initialize variables from config
init_from_config() {
    dir=$(read_config '.dotfiles.directory' | sed "s|~/|${HOME}/|")
    olddir=$(read_config '.dotfiles.backup_directory' | sed "s|~/|${HOME}/|")

    # Get backup strategy settings
    backup_strategy=$(read_config '.dotfiles.backup_strategy.type' 2>/dev/null || echo "simple")
    backup_versions=$(read_config '.dotfiles.backup_strategy.keep_versions' 2>/dev/null || echo "5")

    # If using versioned backups, create a timestamped directory
    if [[ "${backup_strategy}" == "versioned" ]]; then
        timestamp=$(date +"%Y%m%d_%H%M%S")
        olddir="${olddir}/${timestamp}"
        echo "Using versioned backup strategy. Backup directory: ${olddir}"

        # Clean up old backups if we exceed the keep_versions limit
        clean_old_backups
    fi

    # Read files array from config
    files=()
    while IFS= read -r file; do
        files+=("$file")
    done < <(read_config '.dotfiles.files[]')

    # Read brew packages from config
    packages=()
    while IFS= read -r pkg; do
        packages+=("$pkg")
    done < <(read_config '.brew.packages[].name')
}

# Clean up old backup versions
clean_old_backups() {
    local backup_root=$(read_config '.dotfiles.backup_directory' | sed "s|~/|${HOME}/|")
    local max_versions="${backup_versions}"

    if [[ ! -d "${backup_root}" ]]; then
        return
    fi

    # Get list of backup directories sorted by date (oldest first)
    backup_dirs=()
    while IFS= read -r dir_path; do
        backup_dirs+=("$dir_path")
    done < <(find "${backup_root}" -maxdepth 1 -type d -name "[0-9]*_[0-9]*" | sort)

    # Remove oldest backups if we exceed the limit
    local count=${#backup_dirs[@]}
    local to_remove=$((count - max_versions))

    if [[ ${to_remove} -gt 0 ]]; then
        echo "Cleaning up ${to_remove} old backup(s)..."
        for ((i=0; i<to_remove; i++)); do
            echo "Removing old backup: ${backup_dirs[i]}"
            rm -rf "${backup_dirs[i]}"
        done
    fi
}

# Function to check package version requirements
check_package_version() {
    local package=$1
    local required_version=$(read_config ".brew.packages[] | select(.name == \"${package}\") | .required_version")

    if [[ -n "${required_version}" ]]; then
        local current_version=$(brew list "${package}" --versions | awk '{print $2}')
        echo "Checking ${package} version: ${current_version} against requirement: ${required_version}"
    fi
}

# Install Homebrew if needed
install_homebrew() {
    echo "Installing Homebrew..."
    if ! /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
        echo "Error: Homebrew installation failed"
        exit 1
    fi

    if [[ "$(uname -m)" == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "${HOME}/.zprofile"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> "${HOME}/.zprofile"
        eval "$(/usr/local/bin/brew shellenv)"
    fi
}

########## Main Script ##########

# Set up initial directory for config reading
dir="${HOME}/dotfiles"  # Temporary value for initial config reading

# Change to dotfiles directory first
echo -n "Changing to the $dir directory ..."
if ! cd "${dir}"; then
    echo "Error: Could not change to directory ${dir}"
    exit 1
fi
echo "done"

# Ensure requirements are met
ensure_yq

# Initialize configuration
init_from_config
validate_config

# Create backup directory
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p "$olddir"
echo "done"

# Create symlinks
for file in "${files[@]}"; do
    source_file="${dir}/${file}"
    target_link="${HOME}/.${file}"
    backup_file="${olddir}/.${file}"

    # Check if the source file exists in dotfiles repo
    if [[ ! -e "${source_file}" ]]; then
        # If the file exists in home directory, copy it to the dotfiles repo
        if [[ -e "${target_link}" && ! -L "${target_link}" ]]; then
            echo "File ${target_link} exists in home directory but not in dotfiles repo"
            echo "Copying ${target_link} to ${source_file}"

            # Create parent directories if they don't exist
            mkdir -p "$(dirname "${source_file}")"

            # Copy the file/directory
            if [[ -d "${target_link}" ]]; then
                cp -r "${target_link}" "${source_file}"
            else
                cp "${target_link}" "${source_file}"
            fi
            echo "Successfully copied ${file} to dotfiles repository"
        else
            echo "Warning: Source file ${source_file} does not exist and no original found in home directory"
            continue
        fi
    fi

    # Check if it's already correctly linked
    if [[ -L "${target_link}" ]]; then
        current_link=$(readlink "${target_link}")
        if [[ "${current_link}" == "${source_file}" ]]; then
            echo "${file} is already correctly linked -> skip"
            continue
        fi
    fi

    # Backup existing file if it exists
    if [[ -e "${target_link}" ]]; then
        echo "Moving ${target_link} to ${backup_file}"
        if ! mv "${target_link}" "${backup_file}"; then
            echo "Error: Failed to backup ${target_link}"
            exit 1
        fi
    fi

    echo "Creating symlink to ${file} in home directory."
    if ! ln -s "${source_file}" "${target_link}"; then
        echo "Error: Failed to create symlink for ${file}"
        exit 1
    fi
done

# Handle bin directory separately - make it non-fatal
install_bin_directory

# Install/Update Homebrew
if ! command -v brew >/dev/null 2>&1; then
    install_homebrew
else
    echo "Updating Homebrew..."
    brew update
fi

# Install required packages
echo "Installing required packages..."
for package in "${packages[@]}"; do
    if ! brew list "${package}" >/dev/null 2>&1; then
        echo "Installing ${package}..."
        if ! brew install "${package}"; then
            echo "Error: Failed to install ${package}"
            exit 1
        fi
        check_package_version "${package}"
    else
        echo "${package} is already installed"
        check_package_version "${package}"
    fi
done

# Install vim-plug and plugins
if ! command -v vim >/dev/null 2>&1; then
    echo "Error: vim is not installed"
    exit 1
fi

vim_plug_url=$(read_config '.vim.plug_url')
vim_plug_dir=$(read_config '.vim.plug_install_dir' | sed "s|~/|${HOME}/|")

curl -fLo "${vim_plug_dir}" --create-dirs "${vim_plug_url}"
vim +'PlugInstall --sync' +qa
