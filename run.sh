#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" # fetches the directory of this script

# gets the java-binary for version 1.6 and runs the game with the set up libraries
if [ $(sw_vers | grep "ProductVersion" | awk '{split($NF, w, "."); print w[1]}') -gt "10" ]; then
    # sw_vers returns the software version, so we check if we're on a version after 10.15 Catalina
    # and utilize a hardcoded call to java which may or may not exist
    echo "Detected macOS version later than 10.15 Catalina, calling java in a hacky way (might not work)"
    /Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home/bin/java -Djava.library.path="$DIR/libs/" -jar "$DIR/cultris2.jar"
else
    $(/usr/libexec/java_home -v 1.6)/bin/java -Djava.library.path="$DIR/libs/" -jar "$DIR/cultris2.jar"
fi
