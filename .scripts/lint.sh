#!/bin/bash
# This script can be used to ensure that terraform source code is properly formatted

# get all directories inside the working directory
DIRECTORY_LIST=()

function get_directories {
    local -r working_directory="$1"

    DIRECTORY_LIST+=( "$working_directory" )

    for i in "$working_directory"/*
    do
        if [[ -d "$i" ]]
        then
            get_directories "$i"
        fi
    done
}

# get all files that resulted in terraform fmt errors
errors_found=0

function run_terraform_fmt {
    local -r green_color="\e[92m"
    local -r grey_color="\e[90m"
    local -r yellow_color="\e[33m"
    local -r red_color="\e[31m"
    local -r reset_color="\e[0m"
    local -r new_line_character="\n"
    local -r tab_character="    "

    for directory in "${DIRECTORY_LIST[@]}"
    do
        printf "${green_color}==> Running terraform fmt check in ${directory}...${reset_color}${new_line_character}"

        # run terraform fmt command
        local response=$(terraform fmt -check "$directory")

        if [[ ! -z "$response" ]]
        then
            # split response in new line character
            local errors=()
            IFS=$'\n' read -rd '' -a errors <<< "${response}"

            # increment the total number of errors found so far
            ((errors_found+=${#errors[@]}))

            # print files with error
            printf "${red_color}==> Found errors in ${#errors[@]} files${reset_color}${new_line_character}"
            for file in "${errors[@]}"
            do
                printf "${tab_character}${grey_color}${file}${reset_color}${new_line_character}"
            done

            # print fix command
            printf "${yellow_color}==> Fix then by running${reset_color}${new_line_character}"
            printf "${tab_character}${grey_color}terraform fmt ${directory}${reset_color}${new_line_character}"
        fi
    done
}

get_directories "$PWD"

run_terraform_fmt

if [[ "$errors_found" -eq 0 ]]
then
    exit 0
else
    exit 1
fi
