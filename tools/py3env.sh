#!/usr/bin/env bash
set -e


    # Check if an arg was passed for the venv directory.
    if [[ "$1" != "" ]]; then
        VENVDIR=$1
    else
        VENVDIR=".env"
    fi

    # Evaluate if Virtualenv is already active
    if [[ "$VIRTUAL_ENV" != "" ]]; then
        echo "Virtualenv is already activated."
    else
        # Evaluate if a .env/ directory exists in the current working director
        [ -d "$(pwd)/$VENVDIR" ] && \
        ENVEXIST="True" || ENVEXIST="False"

        # If the directory does not currently exist, create it
        if [ "$ENVEXIST" = "False" ]; then
            echo "Couldn't find $(pwd)/$VENVDIR; creating it now."
            python3 -m venv $VENVDIR
        fi

        # Activate the virtual environment
        echo "Activating the virtual environment."
        source $(pwd)/$VENVDIR/bin/activate

        # Ensuring that .gitignore exists and that the $VENVDIR directory exists in the file.
        [ -f "$(pwd)/.gitignore" ] && \
        GIEXIST="True" || GIEXIST="False"

        ## Ensure the .gitignore file exists
        if [ "$GIEXIST" = "False" ]; then
            echo "Creating the .gitignore file."
        fi

        # Virtualenv Ignore Line
        VELINE="$VENVDIR"

        # Ensure the line in file exists
        if grep -Fxq "$VELINE" "$(pwd)/.gitignore"; then
            :
        else
            echo "$VELINE" >> .gitignore
            echo "Added '$VENVDIR' to the .gitignore."
        fi
    fi
