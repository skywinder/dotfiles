#!/bin/bash
set -euo pipefail  # Exit on error, undefined vars, and pipe failures
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables


# TODO: thinks about migration to https://github.com/anishathalye/dotbot

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
if ! cd "${dir}"; then
    echo "Error: Could not change to directory ${dir}"
    exit 1
fi
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    source_file="${dir}/${file}"
    target_link="${HOME}/.${file}"
    backup_file="${olddir}/.${file}"

    # Check if the source file exists
    if [[ ! -e "${source_file}" ]]; then
        echo "Warning: Source file ${source_file} does not exist"
        continue
    }

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


echo -n "Clonning bin directory ..."
./install_bin.sh
echo "Done"
#check if ~/.vim/bundle/Vundle.vim is empty - run "git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim"


# Extra installations:

# brew installation:

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

# Check for Homebrew installation
if ! command -v brew >/dev/null 2>&1; then
    install_homebrew
else
    echo "Updating Homebrew..."
    brew update
fi

# First, ensure yq is installed for YAML parsing
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
    }
    yq "$1" "${config_file}"
}

# Initialize variables from config
init_from_config() {
    dir=$(read_config '.dotfiles.directory' | sed "s|~/|${HOME}/|")
    olddir=$(read_config '.dotfiles.backup_directory' | sed "s|~/|${HOME}/|")

    # Read files array from config
    mapfile -t files < <(read_config '.dotfiles.files[]')

    # Read brew packages from config
    mapfile -t packages < <(read_config '.brew.packages[].name')
}

# Function to check package version requirements
check_package_version() {
    local package=$1
    local required_version=$(read_config ".brew.packages[] | select(.name == \"${package}\") | .required_version")

    if [[ -n "${required_version}" ]]; then
        local current_version=$(brew list "${package}" --versions | awk '{print $2}')
        echo "Checking ${package} version: ${current_version} against requirement: ${required_version}"
        # Note: This is a simplified version check. A more robust version comparison would be needed
        # for proper semantic versioning
    fi
}

# Function definitions...
ensure_yq
init_from_config
validate_config

# Modified package installation to use config
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

# vim things

# install https://github.com/junegunn/vim-plug
vim_plug_url=$(read_config '.vim.plug_url')
vim_plug_dir=$(read_config '.vim.plug_install_dir' | sed "s|~/|${HOME}/|")

curl -fLo "${vim_plug_dir}" --create-dirs "${vim_plug_url}"

vim +'PlugInstall --sync' +qa

# Function for error handling
error_handler() {
    echo "Error occurred in script at line: ${1}"
    exit 1
}

trap 'error_handler ${LINENO}' ERR
