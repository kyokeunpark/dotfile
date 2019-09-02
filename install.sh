#!/bin/bash

# Run this script to create a link between dotfiles from repo to the system.
# Currently supported parameter is: desktop, x220
# You can check the "desktop" and "x220" folder for the details or if you 
#   want to edit the dotfile.
# Note that both dotfile shares "shared" folder.

# TODO: Make uninstall.sh as well!

TYPES=()
CORRPARAM=0

# Function to spit out the error and exit the script with code 1
errormsg() {
    echo -e "Usage:\n\tinstall.sh <dotfile type>"
    echo "Currently supported dotfile types are:"
    for TYPE in ${TYPES[@]}; do
        echo -e "\t$TYPE"
    done
    exit 1
}

synchronize() {
    cd $1
    stow -t ~ *
    cd ..
}

backup() {
    OUTPUT="$(stow -t ~ -n * 2>&1 >/dev/null | grep '*' | awk '{print $11}')"
    if [ "$OUTPUT" ]; then
        echo "Conflict detected. Backing up files..."
        for dir in $OUTPUT; do
            mkdir -p $(dirname ~/df_backup/"${dir}") && \
                mv ~/"${dir}" ~/df_backup/"${dir}"
        done
        echo "The backed up files can be found at '~/df_backup'"
    fi
}

# Check if stow is installed
[ ! $(command -v stow) ] && \
    echo -e "ERROR: Stow is not installed. Exiting..." && exit 1

# Go through all of the options that are present in the repo
for file in ./*/; do
    TMP="$(sed -e 's|/||g' -e 's|\.||g' <<<"$file")"
    [ "shared" != "$TMP" ] && TYPES+=("$TMP") && \
        [ "$1" == "$TMP" ] && CORRPARAM=1
done

# If the parameter that user provided is not valid, spit out error and exit
[ $CORRPARAM -eq 0 ] && errormsg

# Check for conflicts for the selected type
cd $1
backup
# Check for conflicts for the shared dotfiles
cd ../shared
backup
cd ..

# Finally, stow the dotfiles
echo "Linking the dotfiles..."
synchronize "$1"
synchronize "shared"

exit 0
