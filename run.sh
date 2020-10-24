#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" # fetches the directory of this script

# gets the java-binary for version 1.6 and runs the game with the set up libraries
$(/usr/libexec/java_home -v 1.6)/bin/java -Djava.library.path="$DIR/libs/" -jar "$DIR/cultris2.jar"
