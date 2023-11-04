#!/usr/bin/env bash

# Script to setup for the user

# Author: JynxZz
# Date: Nov 2023

# CHANGELOG:
# - v1.0.0 Initial release
# - v1.1.0 Refactoring in functions

# WIP:
# - Error Handling
# - Install required tools
# - Using select to make interactive menu ?


##
# Color  Variables
##
red='\e[31m'
green='\e[32m'
blue='\e[34m'
clear='\e[0m'

# Boilerplate path
BOILERPLATE_PATH="${BOILERPLATE_PATH:-$HOME/.boilerplate}"

##
# Starting Refactoring all to functions
##

# Checking required tools
function check_required_tools() {
  echo -e "\n${blue}****************************$clear"
  echo "Checking required tools ..."

  required_tools=("pyenv" "gh" "direnv" "git")

  for tool in "${required_tools[@]}"; do
    if ! command -v "$tool" &> /dev/null; then

      # Output
      echo -e "${red}Error: $tool is not installed.${clear}"
      echo "Please install $tool to continue."

      # Creating missing_tool bool
      missing_tool=true
    fi
  done

  # Check if missing_tool exist & exit
  if [ "$missing_tool" = true]; then
    echo -e "\n${red}Exit Install${clear}"
    exit 1
  fi
}

#TODO: Install required tools depending to the OS
function install_required_tools() {

}

# Creating directory
function setup_repository() {
  echo -e "\n${blue}****************************$clear"
  echo "Setting up the directory & cloning the repo ..."

  # Check dirctory exist
  if [ -d "${BOILERPLATE_PATH}"]; then

    # Update
    if [ -d "${BOILERPLATE_PATH}/.git"]; then
      echo "Repository already cloned. Pulling latest changes..."
      git -C "${BOILERPLATE_PATH}" pull

    # Refresh
    else
      echo "Directory exists but is not a Git repository. Cleaning & Cloning..."
      rm -rf "${BOILERPLATE_PATH}"
      git clone https://github.com/JynxZz/Init-Project.git "${BOILERPLATE_PATH}"
    fi

  # First Cloning
  else
    echo "Directory doesn't exist. Cloning the repo..."
    git clone https://github.com/JynxZz/Init-Project.git "${BOILERPLATE_PATH}"
  fi
}

# Setting permission
function set_permissions() {
  echo -e "\n${blue}****************************$clear"
  echo "Giving execute permissions ..."

  chmod +x ${BOILERPLATE_PATH}/init_repo.sh
}

# Checking & Creating alias
function create_alias() {
  echo -e "\n${blue}****************************$clear"
  echo "Creating aliases ..."

  if ! grep -q 'alias init_repo' ~/.aliases; then
    echo "# ----------------------" >> ~/.aliases
    echo "# Alias for Init Repo" >> ~/.aliases
    echo "# ----------------------" >> ~/.aliases
    echo -e 'alias init_repo="bash ~/.boilerplate/initrepo.sh"' >> ~/.aliases
  else
    echo "Alias 'init_repo' already exists"
  fi

  source ~/.aliases
}


# Last Output
function finish_setup() {
  echo -e "\n${blue}****************************$clear"
  echo "👌 Awesome, all set up!! 👌"
  echo -e "${blue}****************************$clear"
}

##
# Execution the script
##
check_required_tools
setup_repository
set_permissions
create_aliases
finish_setup
