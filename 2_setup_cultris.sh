#!/bin/bash
# lib setup script originally by PewZ

function install_lwjgl() {
    # this is the library used for graphics, we need this specific version
    LWJGL_URL="http://downloads.sourceforge.net/project/java-game-lib/Official%20Releases/LWJGL%202.8.5/lwjgl-2.8.5.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fjava-game-lib%2Ffiles%2FOfficial%2520Releases%2FLWJGL%25202.8.5%2F&ts=1426435601&use_mirror=softlayer-ams"
    DIR=`mktemp -d` # makes a temporary directory to store the contents of the archives we're about to download
    cd $DIR # move into the temp directory
    echo "Downloading LWJGL..."
    wget -q --show-progress -O lwjgl.zip "$LWJGL_URL" # download LWJGL
    echo "Extracting LWJGL..."
    unzip -qq lwjgl.zip >/dev/null 2>&1 && cp lwjgl-2.8.5/native/macosx/* $@  # unzip the contents and move the mac-related things into our directory for libs
    cd $HERE && rm -r $DIR # move back out and remove our temporary directory
}

function install_bass() {
    # this is the library used for sound
    BASS_URL="http://jerome.jouvie.free.fr/downloads/Download.php?fileName=nativeBassSrc&fileUrl=NativeBass/NativeBass-1.1.2.7z"
    DIR=`mktemp -d`
    cd $DIR
    echo "Downloading NativeBass..."
    wget -q --show-progress -O bass.7z "$BASS_URL"
    echo "Extracting NativeBass libraries..."
    7z x bass.7z >/dev/null 2>&1 && cp NativeBass-1.1.2/lib/mac/* $@ # extract the 7z file
    cd $HERE && rm -r $DIR
}

function get_def_mod_jar() {
    C2_ARCHIVE="$@" # takes the input we got from user and uses it as a path to copy stuff from

    DIR=`mktemp -d` # create a new temporary directory
    cd "$DIR" # move into it
    
    echo "Extracting modded client..."
    7z x "$C2_ARCHIVE" >/dev/null 2>&1 # extract the specified cultris 2 archive

    echo "Select your desired target FPS."
    ls -l "unblurred 60Hz/60Hz" | awk '$(NF) ~ /^[0-9]+\.app$/ { split($NF, w,"."); print w[1]}' # prints a selection of available FPS modes
    read -p "Selection: " FPS_SELECT # stores our selection in a variable

    cp "unblurred 60Hz/60Hz/$FPS_SELECT.app/Contents/Resources/Java/cultris2.jar" "$HERE" # copies the jar file to where we want it
    cd $HERE && rm -r $DIR
}

function get_c2_jar() {
    OFFICIAL_CLIENT_URL="http://gewaltig.net/files/cultris2-1.4c.app.zip"
    DIR=`mktemp -d`
    cd "$DIR"

    echo "Downloading client..."
    wget -O c2.zip -q --show-progress "$OFFICIAL_CLIENT_URL"

    echo "Extracting game jar..."
    unzip -qq c2.zip && cp "Cultris.app/Contents/Resources/Java/cultris2.jar" "$HERE"

    cd $HERE && rm -r $DIR
    echo "Setup complete, execute ./run.sh to start the game!"
}

function install_missing_libs() {
    echo "We're missing required libraries for the game to run."
    echo "So we'll try to download them and set it up for you."
    # we require 7z and wget, and the easiest way to install that is to have homebrew installed
    command -v brew >/dev/null 2>&1 || { 
        echo >&2 "Homebrew is required. Please install: https://brew.sh/"; exit 1;
    }
    command -v 7z >/dev/null 2>&1 || { 
        echo >&2 "p7zip is required. Installing with Homebrew now";
        brew install p7zip;
    }
    command -v wget >/dev/null 2>&1 || { 
        echo >&2 "wget is required. Installing with Homebrew now";
        brew install wget;
    }

    LIBDIR=$HERE/libs # prepares a directory for libraries
    [ -d "$LIBDIR" ] || mkdir $LIBDIR # creates the directory if it doesn't exist

    [ -f "$LIBDIR/liblwjgl.jnilib" ] || install_lwjgl $LIBDIR
    [ -f "$LIBDIR/libbass.dylib" ] || install_bass $LIBDIR
}

HERE=`pwd`
install_missing_libs
read -r -p "Do you want to use the official client? [y/N] " response
if [[ "$response" =~ ^([yY]([eE][sS])?)$ ]]
then
    get_c2_jar
else
    if [[ $# -eq 0 ]]
    then
        echo -e "You must provide a path to the custom client rar file, for example:\n"
        echo -e "\t./2_setup_cultris.sh \"$HOME/Downloads/unblurred 60Hz.rar\"\n"
    else 
        get_def_mod_jar $@
    fi
fi
