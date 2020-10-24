#!/bin/bash
# lib setup script originally by PewZ

function install_libs() {
    # LWJGL: this is the library used for graphics, we need this specific version
    LWJGL_URL="http://downloads.sourceforge.net/project/java-game-lib/Official%20Releases/LWJGL%202.8.5/lwjgl-2.8.5.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fjava-game-lib%2Ffiles%2FOfficial%2520Releases%2FLWJGL%25202.8.5%2F&ts=1426435601&use_mirror=softlayer-ams"
    # BASS: this is the library used for sound
    BASS_URL="http://jerome.jouvie.free.fr/downloads/Download.php?fileName=nativeBassSrc&fileUrl=NativeBass/NativeBass-1.1.2.7z"
    
    # we require 7z and wget, and the easiest way to 
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

    LIBDIR=$PWD/libs # prepares a directory for libraries
    mkdir $LIBDIR # creates the directory

    DIR=`mktemp -d` # makes a temporary directory to store the contents of the archives we're about to download

    cd $DIR # move into the temp directory
    wget -O bass.7z "$BASS_URL" # download BASS

    wget -O lwjgl.zip "$LWJGL_URL" # download LWJGL

    unzip lwjgl.zip && cp lwjgl-2.8.5/native/macosx/* $LIBDIR # unzip the contents and move the mac-related things into our directory for libs

    7z x bass.7z && cp NativeBass-1.1.2/lib/mac/* $LIBDIR # same here, except with 7zip

    cd .. && rm -r $DIR # move back out and remove our temporary directory
}

function get_c2_jar() {
    C2_ARCHIVE="$@" # takes the input from user

    DIR=`mktemp -d` # create a new temporary directory
    cd "$DIR" # move into it
    
    7z x "$C2_ARCHIVE" >/dev/null 2>&1 # extract the specified cultris 2 archive

    echo "Select your desired target FPS"
    ls -l "unblurred 60Hz/60Hz" | awk '$(NF) ~ /^[0-9]+\.app$/ { split($NF, w,"."); print w[1]}' # prints a selection of available FPS modes
    read -p "Selection: " FPS_SELECT # stores our selection in a variable

    cp "./unblurred 60Hz/60Hz/$FPS_SELECT.app/Contents/Resources/Java/cultris2.jar" "$PWD2" # copies the jar file to where we want it
    cd .. && rm -r $DIR
}

PWD=`pwd`
PWD2=`pwd` # unsure why we need a second one
install_libs
get_c2_jar $@