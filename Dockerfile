FROM ubuntu:14.04

LABEL maintainer="Jørgen Borgesen"

# Install dependencies
RUN apt-get update && apt-get install -y \
  # Install libraries to run 32 bits software on 64 bits environment
  lib32gcc1 \
  lib32stdc++6 \
  libc6-i386 \
  # Install java version 6 required by ursim
  openjdk-6-jre
  #libcurl3

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-6-openjdk-amd64

# Define URSIM version to use
ENV UR_VERSION 3.3.4.310

# Define default robot type
ENV ROBOT_TYPE UR10

# Expose primary, secondary and realtime ports
EXPOSE 30001
EXPOSE 30002
EXPOSE 30003

# Copy URSIM directories
COPY ursim-$UR_VERSION/.urcontrol         /root/ursim-current/.urcontrol
COPY ursim-$UR_VERSION/programs.UR10      /root/ursim-current/programs.UR10
COPY ursim-$UR_VERSION/programs.UR5       /root/ursim-current/programs.UR5
COPY ursim-$UR_VERSION/programs.UR3       /root/ursim-current/programs.UR3
COPY ursim-$UR_VERSION/ursim-dependencies/*amd64.deb /root/ursim-current/ursim-dependencies/

# Copy URSIM files
COPY \
  ursim-$UR_VERSION/URControl \
  ursim-$UR_VERSION/ur-serial.* \
  start.sh \
  /root/ursim-current/

# Define working directory.
WORKDIR /root/ursim-current

# Install UR-sim packages
RUN dpkg -i ursim-dependencies/*amd64.deb

# Drop package info no longer needed
RUN rm -rf /var/lib/apt/lists/*

# Define default command.
CMD ["/root/ursim-current/start.sh"]


