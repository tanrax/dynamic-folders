#!/usr/bin/env bash

# --
# Description: Script that watches when new image (PNG, JPEG or Webp) are added and transform to AVIF format.
# --
# Requirements: Install libavif
# Example Debian: $sudo apt install libavif-bin
# --
# Cron: @reboot bash-folders-image-to-avif.sh >/dev/null 2>&1 &
# --

# START
set -e


# FUNCTIONS

usage() {
    if [ "$*" != "" ] ; then
        echo "Error: $*"
    fi

    cat << EOF
Usage: $PROGNAME [OPTION]
Watches when new image (PNG, JPEG or WebP) are added and transform to AVIF format.
Options:
--folder [path]  Folder path where will be monitored.
--help           Display this usage message and exit
EOF

    exit 1
}

start() {
    # Monitors the selected folder
    inotifywait -m -e create,moved_to --format '%f' "$FOLDER_ORIGIN" |
	while read -r filename; do
	    # Gets the file extension
	    extension="${filename##*.}"
	    # Checks if the extension is in the extension list
	    for ext in "${EXTENSIONS_TO_WATCH[@]}"; do
		if [[ "$ext" = "$extension" ]]; then
		    filename_output="${filename%.*}.avif"
		    # Displays a flat file of information
		    touch "$FOLDER_ORIGIN/$MESSAGE_WAITING"
		    # Converts the image to WebP
		    avifenc "$FOLDER_ORIGIN/$filename" "$FOLDER_ORIGIN/$filename_output"
		    # Remove a flat file of information
		    rm "$FOLDER_ORIGIN/$MESSAGE_WAITING"
		fi
	    done
	done
}


# CONTROLE ARGUMENTS

# Parse command line arguments
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
	--folder)
	    FOLDER_ORIGIN="$2"
	    shift # past argument
	    shift # past value
	    ;;
	*)
	    usage "Unknown option: $1"
	    ;;
    esac
done

# VARIABLES
PROGNAME=$(basename "$0")
MESSAGE_WAITING="converting_please_wait"
EXTENSIONS_TO_WATCH=("jpg" "jpeg" "png" "webp")

# CHECKS

# Check if exists cwebp
if ! which avifenc > /dev/null; then
    echo "Error: You must install the AVIF terminal tools."
    exit 1
fi

# Check if the required --folder flag is provided
if [ -z "$FOLDER_ORIGIN" ]; then
    echo "Error: The --folder flag is required."
    exit 1
fi

start
