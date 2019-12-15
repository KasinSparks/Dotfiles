#!/usr/bin/bash

## Author: Kasin Sparks
## Date: 14 DEC 2019
## Objective: A program to automatically symlink dotfile to respective locations

# Version
VERSION=0.0.1

# Set 1 for for debug messages, 0 for OFF
VERBOSE=1

# The file with the links
FILE=(`cat "./links"`)

# The file ending for the backup files
BACKUPENDING="bak"

# Print the string arg if VERBOSE is enabled
function verbosePrint(){
    if [[ $VERBOSE == 1 ]]; then
        echo $1
    fi
}


# Print the help message
function printHelp(){
    echo "Symlinker 5000: A program to automatically symlink dotfile to respective locations.
            Options:
            -h | --help: Display this message.
            -s | --silent: Non-verbose mode.
            -r | --revert: remove symlinks and change files to .bak files.
            -v | --version: Display the version."
}

# If file exist, return 1, else 0
function checkForFileExistance(){
    if [[ -e $1 ]]; then
        return 0 
    else
        return 1
    fi
}

# Create a backup of the file with extention .bak
function createFileBackup(){
    verbosePrint "Creating backup of $1..."
    (cp $1 $1.$BACKUPENDING)
}

# Revert a backup file
function revertFile(){
    if [[ -e $1.$BACKUPENDING ]]; then
        verbosePrint "Reverting $1"
        (rm $1)
        (mv $1.$BACKUPENDING $1)
    else
        echo "$1.$BACKUPENDING does not exist... Could not revert from backup."
    fi
}

# Remove dotfiles
function removeFile(){
    if [[ -e $1 ]]; then
        verbosePrint "Removing $1"
        (rm $1)
    else
        echo "$1 does not exist... Could not remove."
    fi
}

# Create a symlink with arg0: file name, arg1: file directory, arg2: symlink directory
function symLink(){
    mainFile=$2$1
    linkFile=$3$1

    verbosePrint "Symlinking $mainFile to $linkFile"

    # If the file does not exist, return 0. Additionally, check for if the 
    #  symlink has already been created and create backup if true
    if ! checkForFileExistance $mainFile; then
        verbosePrint "$mainFile does not exist... No symlink created."
        return 0
    fi

    # Check if a .bak file already exist
    if checkForFileExistance $linkFile.$BACKUPENDING; then
        # Ask user to override
        echo -n "Override existing $linkFile.$BACKUPENDING? [y/n]: "
        read ans
        if [[ "$ans" == "y" ]]; then
            createFileBackup $linkFile
        fi
    elif checkForFileExistance $linkFile; then
        verbosePrint "$linkFile already exist, creating backup then proceeding."
        createFileBackup $linkFile
    fi

    # Create the symlink
    (ln -sf $mainFile $linkFile)
}

# The main function
function main(){
    # Array to store the commands
    commandArr=('','','')
    count=0

    # Go through the file and execute the symlinks
    for line in ${FILE[@]}; do
        # If the item is empty ignore it, else add it the array
        if [[ -n $line ]]; then
            commandArr[count]=$line
            count=$(($count + 1))
        fi

        # Execute and move to the next command
        if [[ $(($count % 3)) == 0 ]]; then
            # If revert has been called
            if [[ -n $1 && $1 == "revert" ]]; then
                revertFile ${commandArr[2]}${commandArr[0]}
            elif [[ -n $1 && $1 == "remove" ]]; then
                removeFile ${commandArr[2]}${commandArr[0]}
            else
                # Execute a symlink
                symLink ${commandArr[0]} $(pwd)/${commandArr[1]} ${commandArr[2]}
            fi


            # Clear the array
            for i in {0..2}; do
                commandArr[i]=''
            done
        fi
    done 
}


# Handle the cli args
for arg in $@; do
    if [[ -n $arg ]]; then
        if [[ $arg == "-s" || $arg == "--silent" ]]; then
            VERBOSE=0
        elif [[ $arg == "-v" || $arg == "--version" ]]; then
            echo $VERSION
            exit
        elif [[ $arg == "-r" || $arg == "--revert" ]]; then
            echo "Reverting dotfiles..."
            main "revert"
            echo "DONE."
            exit
        elif [[ $arg == "--remove" ]]; then
            echo "Removing dotfiles..."
            main "remove"
            echo "DONE."
            exit
        else
            printHelp
            exit
        fi
    fi
done
    
# Execute it
main