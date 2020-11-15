#!/bin/bash

# Get CWD as reference
CWD=`pwd`

# From script execution directory, go to valhelsia directory
cd ../valhelsia-forge

# Build the image
docker image build -t minecraft-valhelsia .

# Sleep for 3 seconds before running
sleep 3

# Start the container
docker run -d -p 32500:32500 -p 32501:32501 --runtime=runsc minecraft-valhelsia

# Go back to setup dir
cd $CWD

echo
echo "Started valhelsia minecraft on port 32500"
echo "Started RCON interfacce on port 32501"
