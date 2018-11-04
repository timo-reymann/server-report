#!/bin/bash

TARGET_DIR=dist

# Create target
rm -rf $TARGET_DIR
mkdir $TARGET_DIR

# Copy installer to final filename
cp ./src/installer.sh $TARGET_DIR/installer.sh

# Create tar file with relevant files from src
tar cJf $TARGET_DIR/installer.tar.xz --directory=src run.sh config.sample

# Append tar to installer
cat $TARGET_DIR/installer.tar.xz >> $TARGET_DIR/installer.sh

# Make installer executable
chmod +x $TARGET_DIR/installer.sh
