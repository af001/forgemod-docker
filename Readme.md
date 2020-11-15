# Forgemod/CurseForge Docker - Builder Scripts
This repo contains a set of scripts that can be used to install Forgemod/CurseForge servers as Docker containers. Users can interact with the Minecraft servers using Twitch modpacks for Minecraft. These containers should not be exposed to the Internet without additional iptable rules that restrict access to a set of trusted IP addresses. This build is ideal for home labs and/or local LANs. 

These instructions will use Forgemod|CurseForge interchangably. Minecraft Forge is the project that builds Mincraft so that it can be modded. CurseForge is a set of modpacks that are built using the Minecraft Forge server.  

**Whats Included:**
* Script to install the required dependencies for Docker, Gvisor, and Git
* Installation of [Gvisor](https://gvisor.dev/) runsc runtime - Application Kernel for Containers
* Installation of [Docker](https://www.docker.com/)
* Installation of [Mcrcon](https://github.com/tiiffi/mcrcon) for managing running servers
* Start scripts for select modservers on [Forgemod](https://files.minecraftforge.net/) | [CurseForge](https://www.curseforge.com/minecraft/modpacks)
* Default INPUT iptable rules that only allow 22/tcp for SSH. Note: Exposed Minecraft ports will still be open due to PREROUTING rules that are maintained by Docker when a container is running. 

### Twitch modpacks
For instructions on getting started with Minecraft on Twitch, reference [How to Play Minecraft with Twitch App](https://help.twitch.tv/s/article/How-to-Play-Minecraft-with-Twitch-App?language=en_US)

### Forgemod|CurseForge Server Setup
This setup assumes a fresh install of Ubuntu 20.04+. The following actions will clone this repo and install all the requited software and dependencies to get started. 

```bash
# Clone this repo
git clone https://github.com/af001/forgemod-docker.git
cd forgemod-docker/docker-ubuntu-setup
chmod 755 setup-ubuntu.sh
./setup-ubuntu.sh
```

### Forgemod|CurseForge Docker Creation
The default rcmon password is ```bash changemepassword```. If you wish to change or disable rcmon, it is recommended to make the changes prior to running one of the start scripts. In the following example, the CurseForge server that is intended to be started is ```bash Valhelsiaa```. On an internal LAN, the risk is minimal since the Docker is running Alpine with Gvisor. 

```bash
cd forgemod-docker/valhelsia-forge
vim server.properties

# To disable rcon
:%s/enable-rcon=true/enable-rcon=false/g

# To change the rcon password
:%s/rcon.password=changemepassword/rcon.password=<new_password>/g
```

To build a container with one of the provided CurseForge modded servers, the following helper scripts can be used. This should be executed after modifying server.properties, although modifying server.properties is not required. 

```bash
# Build a Docker container and run it to expose a port.
cd forgemod-docker/docker-ubuntu-setup
./start-valhelsia.sh
```

### Multiplay Connect
After using one of the start scripts, the port to the Minecraft server will be displayed to the screen. For instructions on connecting to the server, follow the instructions for [multiplayer setup](https://apexminecrafthosting.com/how-to-connect-to-a-multiplayer-minecraft-server/) and replace the the server:port with the port provided by the script and your server's IP address.

### Mcrcon Connection
By default, [Mcrcon](https://www.mankier.com/1/mcrcon) is installed on the server hosting Docker containes. This could also be compiled on a remote host for remote management. This tool allows admins to sends rcon commands to a Minecraft server. The Rcon port will be displayed at the end of the startup scrip after displaying the server's Minecraft port.

```bash
# Connect to a Minecraft server on the Ubuntu machine hosting docker containers. This should be modified if connecting from a remote machine on the same LAN. 
mcrcon -H 127.0.0.1 -P <rcon_port> -p chamgemepassword
```

### Currnet Forge Server Scripts
* [Valhelsia](https://www.curseforge.com/minecraft/modpacks/valhelsia-3/files) - 1.16.3 
