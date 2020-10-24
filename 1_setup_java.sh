#!/bin/bash

echo "Downloading Java 1.6 install from apple.com"
curl https://updates.cdn-apple.com/2019/cert/041-88384-20191011-3d8da658-dca4-4a5b-b67c-26e686876403/JavaForOSX.dmg -O # downloads JavaForOSX.dmg from Apple's CDN
hdiutil mount JavaForOSX.dmg # mounts the file to a volume just like what would happen if you double-clicked this file
pkgutil --expand /Volumes/Java\ for\ macOS\ 2017-001/JavaForOSX.pkg tmp # extracts the contents of the installer-package into a temporary folder
hdiutil unmount /Volumes/Java\ for\ macOS\ 2017-001/ # unmounts the volume, we have the needed contents in our temporary folder now
sed -i '' 's/return false/return true/g' tmp/Distribution # let's replace false with true so the installer lets us install no matter what 
pkgutil --flatten tmp ModifiedJava6Install.pkg # create a new installer package with our changes
rm -rf tmp # remove the temporary folder
rm JavaForOSX.dmg # remove the dmg file we downloaded from Apple
open ModifiedJava6Install.pkg -W # open the installer
echo "Please install Java now."
rm ModifiedJava6Install.pkg 2> /dev/null # deletes the installer file if it still exists at this point
echo "Java 1.6 should be installed now! You can proceed with the next step"
