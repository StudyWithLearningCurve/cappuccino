#!/bin/bash

#  Created by Alex Karahalios on 6/12/11.
#  Last edited 1/27/2012
#  Copyright 2011-2012 Alex Karahalios. All rights reserved.
#
# Updates Xcode and to support Objective-J language for editing
#

# Path were this script is located
#
SCRIPT_PATH="$(dirname "$BASH_SOURCE")"

# Set up path for PlistBuddy helper application which can add elements to Plist files
#
PLISTBUDDY=/usr/libexec/PlistBuddy

# Filename path private framework we need to modify
#
#DVTFOUNDATION_PATH="/Developer/Library/PrivateFrameworks/DVTFoundation.framework/Versions/A/Resources/"
#DVTFOUNDATION_PATH="/XCode4.3/Library/PrivateFrameworks/DVTFoundation.framework/Versions/A/Resources/"

# This framework is found withing the Xcode.app package and is used when Xcode is a monolithic
# install (all contained in Xcode.app)
#
DVTFOUNDATION_PATH="/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/"

# Create Plist file of additional languages to add to 'DVTFoundation.xcplugindata'
#
cat >AdditionalLanguages.plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Xcode.SourceCodeLanguage.Objective-J</key>
	<dict>
		<key>languageSpecification</key>
		<string>xcode.lang.objj</string>
		<key>fileDataType</key>
		<array>
			<dict>
				<key>identifier</key>
				<string>com.apple.xcode.objective-j-source</string>
			</dict>
		</array>
		<key>id</key>
		<string>Xcode.SourceCodeLanguage.Objective-J</string>
		<key>point</key>
		<string>Xcode.SourceCodeLanguage</string>
		<key>languageName</key>
		<string>Objective-J</string>
		<key>version</key>
		<string>1.0</string>
		<key>conformsTo</key>
		<array>
			<dict>
				<key>identifier</key>
				<string>Xcode.SourceCodeLanguage.Generic</string>
			</dict>
		</array>
		<key>name</key>
		<string>Objective-J Language</string>
	</dict>
</dict>
</plist>
EOF

# Now merge in the additonal languages to DVTFoundation.xcplugindata
#
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Merge AdditionalLanguages.plist plug-in:extensions'

# Get rid of the AdditionalLanguages.plist since it was just temporary
#
rm -f AdditionalLanguages.plist

# Copy in the xclangspecs for the languages (assumes in same directory as this shell script)
#
cp "$SCRIPT_PATH/ObjectiveJ.xclangspec" "$DVTFOUNDATION_PATH"
