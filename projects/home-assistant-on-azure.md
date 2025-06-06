# Hosting Home Assistant on Azure VM

## Overview
To prepare for potential natural disasters and local power failures, I deployed Home Assistant on an Azure Virtual Machine.

This setup ensures that smart home automations remain accessible from anywhere, even if the home network is down or local hardware is damaged.

To speed up deployment and reduce manual setup, I created a custom shell script (`install-home-assistant.sh`) that:
- Installs everything Home Assistant needs to run
- Sets it up in a seprate space so it doesn't affect other software
- Makes it run in the background automatically
- Starts it up again if the virtual machine restarts

This makes it quick to reinstall or move if something goes wrong.

## Motivation
Running Home Assistant locally can create a single point of failure—especially during emergencies like storms, power outages, or hardware issues.

By hosting it on Azure, I ensured continuous uptime and access to smart home controls from any location, including mobile or temporary housing during disruptions.

## Architecture
![diagram](../assets/home-assistant-architecture.png)

## Technologies Used
- Azure Virtual Machine (Ubuntu)
- Network Security Group
- Public IP
- SSH
- Home Assistant Core
- Optional: Azure DNS, SSL with Let’s Encrypt

## Skills Demonstrated
- VM provisioning
- Port and access configuration
- Linux enviroment setup
- Smart home hosting in the cloud
 
## Project Files
- [Instal Script](../install-home-assistant.sh)
