#!/usr/bin/env bash

# Script to init a new project
# Create a git repository with a chosen structure
# Asking for a pyenv creation env
# Push all the structure on github

# Author: JynxZz
# Date: Nov 2023


# CHANGELOG:
# - v1.0.0 Initial release
# - v1.1.0 Added virtual environment setup
# - v1.2.0 Improved user prompts and error handling
# - v1.3.0 Installer to be more easy to use
# - v1.3.1 New version of the installer

# WIP:
# - Using select method to make a interactive menu
# - Creating test (using BATS ?)
# - Consolidate and reformat some redundant functions


##
# Color  Variables
##
red='\e[31m'
green='\e[32m'
blue='\e[34m'
clear='\e[0m'

# Default boilerplate path
BOILERPLATE_PATH="${BOILERPLATE_PATH:-$HOME/.boilerplate}"

# Set IFS to default value
IFS=$' \t\n'


##
# Validate required tools
# pyenv gh direnv git
##
required_tools=("pyenv" "gh" "direnv" "git")
for tool in "${required_tools[@]}"; do
  if ! command -v "$tool" &> /dev/null; then
    echo -e "${red}Error: $tool is not installed.${clear}"
    echo "Please install $tool to continue."
    exit 1
  fi
done


# Get the list of installed Python versions (excluding environments)
python_versions=($(pyenv versions | awk '{print $1}' | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | uniq))


##
# A generic function to prompt the user and validate input.
# Arguments:
#   $1: Prompt message
#   $2: A regular expression to validate the input
#   $3: An error message for invalid input
##
function prompt() {
  local input
  while true; do
    read -r -p "$1: " input
    if [[ $input =~ $2 ]]; then
      echo "$input"
      break
    else
      echo -e "${red}$3$clear"
    fi
  done
}


##
# Prompt the user to initiate the repository creation process.
##
function initiate_repo_creation() {
  echo -e "\n${blue}####################$clear"

  # Read the name of the repo
  repo_name=$(prompt "Enter the new repository name" "^[a-zA-Z0-9 _-]+$" "Invalid repository name. Please use only letters, numbers, hyphens, and underscores.")

  # Check the privacy of the repo
  echo -e "\nShould the repository be private or public?"
  echo "$green[1]$clearn Private $green[2]$clear Public"
  privacy=$(prompt "Select an option" "^[12]$" "Invalid choice, please choose 1 or 2.")

  if [[ $privacy == 1 ]]; then
    echo -e "Creating a new repository named $green$repo_name$clear in$green private$clear mode."
  else
    echo -e "Creating a new repository named $green$repo_name$clear in$green public$clear mode."
  fi

  choose_repo_type
}


##
# Prompt the user to choose the type of repository to create.
##
function choose_repo_type() {
  echo -e "\n$blue####################$clear"
  echo "Would you like a classic repository or a project structure?"
  echo "$green[1]$clear Classic $green[2]$clear Project"

  local repo_type_choice
  repo_type_choice=$(prompt "Select an option" "^[12]$" "Invalid choice, please choose 1 or 2.")

  if [[ $repo_type_choice == 1 ]]; then
    echo "Creating a classic repository..."
    create_classic_repo
  else
    echo "Creating a repository with a project structure..."
    create_project_repo
  fi
}


##
# Create a repository with a standard structure.
##
function create_classic_repo() {
  echo -e "\n$blue####################$clear"

  echo "Setting up a classic repository structure..."

  # Copy .gitignore and requirements.txt from the boilerplate path
  cp "${BOILERPLATE_PATH}/files/gitignore" .gitignore
  cp "${BOILERPLATE_PATH}/files/mini_requirements.txt" requirements.txt

  # Create and fill the Readme.md file
  echo "# Readme for $repo_name" > Readme.md
  echo "This is the Readme for the project $repo_name" >> Readme.md

  # Initialize the git repository and make the first commit
  git init -b main
  git add .
  git commit --message "Initial commit & Setup repository"

  # Create the GitHub repository
  if [[ $privacy == 1 ]]; then
    gh repo create "$repo_name" --private --source=. --remote=origin
  else
    gh repo create "$repo_name" --public --source=. --remote=origin
  fi

  echo -e "\n👌 Awesome, all set up!! 👌"

  create_virtual_env
}


##
# Create a repository with a project structure.
##
function create_project_repo() {
  echo -e "\n$blue####################$clear"

  echo "Setting up a repository with a project structure..."

  # Copy the project structure from the boilerplate
  cp -r "${BOILERPLATE_PATH}/project-structure/"* .
  mv env .env
  mv envrc .envrc
  direnv allow .
  mv gitignore .gitignore

  # Create and fill the README.md file
  echo "# Readme for Project $repo_name" > README.md
  echo "This is the Readme for the project $repo_name" >> README.md

  # Initialize the git repository and make the first commit
  git init -b main
  git add .
  git commit --message "Initial commit & setup repository"

  # Create the GitHub repository
  if [[ $privacy == 1 ]]; then
    gh repo create "$repo_name" --private --source=. --remote=origin
  else
    gh repo create "$repo_name" --public --source=. --remote=origin
  fi

  echo -e "\n👌 Awesome, all set up!! 👌"

  create_virtual_env
}


##
# Prompt the user to decide if they want to create a virtual environment.
##
function create_virtual_env() {
  echo -e "\n$blue####################$clear"

  echo "Would you like to create a Virtual Environment?"
  local create_venv_choice
  create_venv_choice=$(prompt "Create a Virtual Env? [y]es [n]o" "^[yn]$" "Invalid choice, please choose [y] or [n].")

  if [[ $create_venv_choice == "y" ]]; then
    echo "Let's create it..."
    setup_virtual_env
  else
    echo "No Virtual Environment will be created."
    push_to_github
  fi
}


##
# Create a Python virtual environment with the selected version.
##
function setup_virtual_env() {
  echo -e "\n$blue####################$clear"

  local env_name
  echo "Enter the name for the Virtual Environment:"
  read env_name

  echo -e "\nSelect the Python version for the Virtual Environment:"
  local version_choice
  for i in "${!python_versions[@]}"; do
      echo "[$((i+1))] Python version ${python_versions[$i]}"
  done
  version_choice=$(prompt "Enter your choice:" "^[1-${#python_versions[@]}]$" "Invalid choice, select a number from the list.")

  # Extracting the selected Python version
  local selected_version=${python_versions[$((version_choice-1))]}

  echo "Creating the $green$env_name$clear with Python version $green$selected_version$clear 🐍"
  pyenv virtualenv "$selected_version" "$env_name"

  echo -e "\nSetting up the new Virtual Environment locally..."
  pyenv local "$env_name"

  echo -e "\nUpdating Pip..."
  python3 -m pip install --upgrade pip

  # Ask if requirements should be installed
  local install_req_choice
  install_req_choice=$(prompt "Install requirements? [y]es [n]o" "^[yn]$" "Invalid choice, please choose [y] or [n].")

  if [[ $install_req_choice == "y" ]]; then
    echo "Installing requirements..."
    pip install -r requirements.txt
  else
    echo "Skipping requirements installation."
  fi

  push_to_github
}


##
# Offer the user the option to push the repository to GitHub.
##
function push_to_github() {
  echo -e "\n$blue####################$clear"

  local push_choice
  push_choice=$(prompt "Would you like to push the initial commit to GitHub? [y]es [n]o" "^[yn]$" "Invalid choice, please choose [y] or [n].")

  if [[ $push_choice == "y" ]]; then
    echo "Pushing to GitHub..."
    git push origin main
  else
    echo "Initial commit will not be pushed at this time."
  fi

  echo -e "\n$blue####################$clear"
  local web_view_choice
  web_view_choice=$(prompt "Would you like to open the repository in a web view? [y]es [n]o" "^[yn]$" "Invalid choice, please choose [y] or [n].")

  if [[ $web_view_choice == "y" ]]; then
    echo "Opening repository in web view..."
    gh repo view -w
  else
    echo "Repository will not be opened in web view."
  fi
}


# Call the function to start the script
initiate_repo_creation
