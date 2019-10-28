FROM ubuntu:14.04

LABEL maintainer="Jørgen Borgesen"

# Install dependencies
RUN apt-get update && apt-get install -y \
  libcurl3 libjava3d-* ttf-dejavu* \
  fonts-ipafont fonts-baekmuk fonts-nanum fonts-arphic-uming fonts-arphic-ukai \
  default-jre\
  libc6-i386  lib32stdc++6 lib32gcc1 xvfb


# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/default-java

# Define URSIM version to use
ENV UR_VERSION 3.7.2.40245

# Define default robot type
ARG ROBOT_TYPE=UR10
ENV ROBOT_TYPE "$ROBOT_TYPE"

# Expose primary, secondary and realtime ports
EXPOSE 30001
EXPOSE 30002
EXPOSE 30003
EXPOSE 30004

# Copy URSIM directories
COPY ursim-$UR_VERSION/.urcontrol         /root/ursim-current/.urcontrol/
COPY ursim-$UR_VERSION/programs.UR10      /root/ursim-current/programs.UR10
COPY ursim-$UR_VERSION/programs.UR5       /root/ursim-current/programs.UR5
COPY ursim-$UR_VERSION/programs.UR3       /root/ursim-current/programs.UR3
COPY ursim-$UR_VERSION/ursim-dependencies/*amd64.deb /root/ursim-current/ursim-dependencies/


COPY \
  ursim-$UR_VERSION/filesys \
  ursim-$UR_VERSION/URControl \
  ursim-$UR_VERSION/ur-serial.* \
  ursim-$UR_VERSION/*.sh \
  start.sh \
  waitforportAndUnlock.sh \
  /root/ursim-current/

COPY ursim-$UR_VERSION/GUI /root/ursim-current

# Define working directory.
WORKDIR /root/ursim-current

# Install UR-sim packages
RUN dpkg -i ursim-dependencies/*amd64.deb

# Drop package info no longer needed
RUN rm -rf /var/lib/apt/lists/*

# Define default command.
CMD ["/root/ursim-current/start.sh", "$ROBOT_TYPE"]
