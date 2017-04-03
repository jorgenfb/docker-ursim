# URSIM
Provides an UR simulator without GUI

## Usage
Start simulation with an UR10 robot
```
docker run -p 30001:30001 -p 30002:30002 -p 30003:30003 jorgenfb/ursim:latest
```

Use another robot type by specifying the environment variable ROBOT_TYPE. Valid options are UR3, UR5 and UR10. Defaults to UR10.
```
docker run -p 30001:30001 -p 30002:30002 -p 30003:30003 -e ROBOT_TYPE=UR5 jorgenfb/ursim:latest
```

## How I got it to work
This section documents how I got this to work. Read it to prevent doing the same mistakes as I did.

### The official installation procedure from UR
I was unable to use the use the linux installation package that you can download directly from universal robots.
Looks like it was created for an enviroment not exactly equal to the one we have. Please tell me if you can get it to work. Using the official installation process would remove the need to maintain a custom install process.

### Custom install process
Image was created by slighly modifying the process found in install.sh provided by universal robots and skipping some
of the compability steps since we control the environment to install on.

- Copy the ~/ursim-VERSION file from an working virtualbox image.
- Read its install.sh script to find out which dependencies to install (listed in the dockerfile)
- Install .deb dependencies from UR (only care about 64 bits packages)
- Create custom start.sh file to setup config files and start urcontrol with polyscope (GUI)





