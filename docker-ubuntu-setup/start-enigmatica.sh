#!/bin/bash

# Get CWD as reference
CWD=`pwd`

# From script execution directory, go to valhelsia directory
cd ../enigmatica-forge

# Build the image
docker image build -t minecraft-enigmatica .

# Sleep for 3 seconds before running
sleep 3

# Start the container
docker run -d -p 32510:32510 -p 32511:32511 --runtime=runsc minecraft-enigmatica

# Go back to setup dir
cd $CWD

echo
echo "Started enigmatica minecraft on port 32510"
echo "Started RCON interfacce on port 32511"
