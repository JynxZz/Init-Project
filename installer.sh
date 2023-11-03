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
required_tools=("pyenv" "gh" "direnv" "git")
for tool in "${required_tools[@]}"; do
  if ! command -v "$tool" &> /dev/null; then
    echo -e "${red}Error: $tool is not installed.${clear}"
    echo "Please install $tool to continue."
  fi
  echo -e "\n${red}Exit Install${clear}"
  exit 1
done

echo -e "\n${blue}****************************$clear"
echo "Check and create ..."

if [ ! -d ${BOILERPLATE_PATH} ]; then
  mkdir ${BOILERPLATE_PATH}
fi

echo -e "\n${blue}****************************$clear"
echo "Checking required tools ..."


#TODO: Install required tools depending to the OS


echo -e "\n${blue}****************************$clear"
echo "Cloning the repo ..."

git clone https://github.com/JynxZz/Init-Project.git ${BOILERPLATE_PATH}


echo -e "\n${blue}****************************$clear"
echo "Giving execute permissions ..."

chmod +x ${BOILERPLATE_PATH}/init_repo.sh

echo -e "\n${blue}****************************$clear"
echo "Creating aliases ..."

echo 'alias initrepo="bash ${BOILERPLATE_PATH}/init_repo.sh"' >> ~/.aliases

echo -e "\n${blue}****************************$clear"
echo "👌 Awesome, all set up!! 👌"
echo -e "${blue}****************************$clear"