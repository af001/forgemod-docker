# Forgemod/CurseForge Docker - Builder Scripts
This repo contains a set of scripts that can be used to install Forgemod/CurseForge servers as Docker containers. Users can interact with the Minecraft servers using Twitch modpacks for Minecraft. These containers should not be exposed to the Internet without additional iptable rules that restrict access to a set of trusted IP addresses. This build is ideal for home labs and/or local LANs. 

Whats Included:
* Script to install the required dependencies for Docker, Gvisor, and Git
* Installation of [Gvisor](https://gvisor.dev/) runsc runtime - Application Kernel for Containers
* Installation of [Docker](https://www.docker.com/)
* Installation of [Mcrcon](https://github.com/tiiffi/mcrcon) for managing running servers
* Start scripts for select modservers on [Forgemod](https://files.minecraftforge.net/)
* Default INPUT iptable rules that only allow 22/tcp for SSH. Note: Exposed Minecraft ports will still be open due to PREROUTING rules that are maintained by Docker when a container is running. 

## Twitch modpacks
For instructions on getting started with Minecraft on Twitch, reference [How to Play Minecraft with Twitch App](https://help.twitch.tv/s/article/How-to-Play-Minecraft-with-Twitch-App?language=en_US)

### Forgemod Server Setup
This setup assumes a fresh install of Ubuntu 20.04+. 

```bash
# Clone this repo
git clone https://github.com/af001/
cd repo/
```

### Forgemod Docker Creation
To build a container with one of the provided modded servers, the following helper scripts can be used.

```bash
# Build a Docker container and run it to expose a port.

```

### Multiplay Connect



### Currnet Forge Server Scripts
* [Valhelsia](https://www.curseforge.com/minecraft/modpacks/valhelsia-3/files) - 1.16.3 
