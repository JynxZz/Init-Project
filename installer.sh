#!/bin/bash

# Script to setup for the user

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
# Validate required tools
# pyenv gh direnv git
##
echo -e "\n${blue}****************************$clear"
echo "Checking required tools ..."

#TODO: Install required tools depending to the OS

required_tools=("pyenv" "gh" "direnv" "git")
for tool in "${required_tools[@]}"; do
  if ! command -v "$tool" &> /dev/null; then
    echo -e "${red}Error: $tool is not installed.${clear}"
    echo "Please install $tool to continue."
  fi
done
for tool in "${required_tools[@]}"; do
  if ! command -v "$tool" &> /dev/null; then
  echo -e "\n${red}Exit Install${clear}"
  exit 1
  fi
done

echo -e "\n${blue}****************************$clear"
echo "Checking directory and create it ..."

if [ ! -d ${BOILERPLATE_PATH} ]; then
  mkdir ${BOILERPLATE_PATH}
fi


echo -e "\n${blue}****************************$clear"
echo "Cloning the repo ..."

git clone https://github.com/JynxZz/Init-Project.git ${BOILERPLATE_PATH}


echo -e "\n${blue}****************************$clear"
echo "Giving execute permissions ..."

chmod +x ${BOILERPLATE_PATH}/init_repo.sh


echo -e "\n${blue}****************************$clear"
echo "Creating aliases ..."

echo "# ----------------------" >> ~/.aliases
echo "# Alias for Init Repo" >> ~/.aliases
echo "# ----------------------" >> ~/.aliases
echo -e "alias init_repo='bash $BOILERPLATE_PATH/init_repo.sh'" >> ~/.aliases


echo -e "\n${blue}****************************$clear"
echo "👌 Awesome, all set up!! 👌"
echo -e "${blue}****************************$clear"
