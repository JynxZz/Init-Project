# Documentation : `init_repo.sh`

## Overview

`init_repo.sh` is a bash script for automating the initialization of a new Git repository.

It facilitates creating a repository with a selected structure, setting up a Python virtual environment, and pushing the initialized repository to GitHub. The script interacts with users via the command line to collect necessary details and preferences for the repository setup.

## Author

- **Name:** JynxZz
- **Date:** November 2023

## Version History

- **v1.0.0:** Initial release
- **v1.1.0:** Added virtual environment setup
- **v1.2.0:** Improved user prompts and error handling
- **v1.3.0:** Add a installer to be more easy to use
- **v1.3.1:** New version of the installer

## Work In Progress

- Using the `select` method to create an interactive menu
- Creating tests (possibly using BATS)
- Completing the documentation (Check ✅ ?):
    1. Complete the `How to Run`
    2. Be sure to explain well the process for the copy and aliases
- Consolidate and reformat some redundant functions

Link to the [WIP Notes](wip.md)

## Requirements

The script requires the following tools to be installed:

- pyenv
- gh (GitHub CLI)
- direnv
- git

## How to install

To use the script, run the following command in your terminal to install localy

```bash
curl "https://raw.githubusercontent.com/JynxZz/Init-Project/main/installer.sh" | bash
```

## How to Run It

Just use in the directory you wann start a new project the alias

```bash
cd <path/to/your/future/project>
initrepo
```

## Features

- Validates the presence of required tools
- Prompts for the new repository name
- Choice between private or public repository
- Options for a classic or a project repository structure
- .gitignore and requirements.txt or mini_requirements.txt setup
- Local Git repository initialization and initial commit
- Remote GitHub repository creation
- Optional Python virtual environment setup
- Optional installation of Python packages from requirements.txt
- Option to push the initial commit to GitHub
- Option to open the repository in a web view using GitHub CLI

## Functions

### `prompt()`

A utility function to interact with the user, validate input against a regular expression, and display error messages for invalid input.

### `initiate_repo_creation()`

Begins the repository creation process by collecting the repository name and privacy preference from the user.

### `choose_repo_type()`

Asks the user to choose the type of repository (classic or project structure) and calls the corresponding function based on their choice.

### `create_classic_repo()`

Sets up a classic repository structure, copies necessary files from a boilerplate path, and initializes the repository.

### `create_project_repo()`

Sets up a repository with a project structure by copying the structure from a boilerplate path and initializing the repository.

### `create_virtual_env()`

Queries the user on whether to create a Python virtual environment and proceeds with its setup if desired.

### `setup_virtual_env()`

Manages the creation of a Python virtual environment, including its naming, Python version selection, and installation of dependencies from `requirements.txt`.

### `push_to_github()`

Offers the option to push the initial commit to GitHub and to open the repository in a web view.

## Execution Flow

1. **Validate Required Tools**: Checks if the required tools (`pyenv`, `gh`, `direnv`, `git`) are installed.

2. **Initiate Repository Creation**:
    - Prompt the user for the new repository name.
    - Ask whether the repository should be private or public.
    - Delegate to the `choose_repo_type` function based on the user's input.

3. **Choose Repository Type**:
    - Prompt the user to choose between a classic repository or one with a project structure.
    - Based on the choice, delegate to `create_classic_repo` or `create_project_repo`.

4. **Create Classic Repository** (if chosen):
    - Set up a classic repository structure.
    - Copy necessary files from the boilerplate path.
    - Initialize the git repository and make the first commit.
    - Create the GitHub repository (private or public based on user input).
    - Offer to create a virtual environment.

5. **Create Project Repository** (if chosen):
    - Set up a repository with a project structure.
    - Copy the project structure from the boilerplate.
    - Initialize the git repository and make the first commit.
    - Create the GitHub repository (private or public based on user input).
    - Offer to create a virtual environment.

6. **Create Virtual Environment** (optional):
    - Ask the user if they want to create a virtual environment.
    - If yes, proceed to set up the virtual environment.

7. **Setup Virtual Environment** (if chosen):
    - Prompt for the environment name.
    - Allow the user to select the Python version from the list of installed versions.
    - Create the virtual environment using `pyenv`.
    - Offer to install requirements from `requirements.txt`.

8. **Push to GitHub**:
    - Ask the user if they wish to push the initial commit to GitHub.
    - If yes, perform the push operation.

9. **Open Repository in Web View** (optional):
    - Ask the user if they want to open the repository in a web view.
    - If yes, open the repository using `gh repo view -w`.

## Disclaimer

This script is provided "as is", without warranty of any kind, express or implied. Use at your own risk.
