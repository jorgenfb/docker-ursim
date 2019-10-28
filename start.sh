#!/bin/bash

export LD_LIBRARY_PATH=/opt/urtool-3.0/lib

URSIM_ROOT=$(dirname $(readlink -f $0))

pushd $URSIM_ROOT &>/dev/null

CLASSPATH=$(echo $URSIM_ROOT/lib/*.jar | tr ' ' ':')

./stopurcontrol.sh
#./starturcontrol.sh



#Setting up the configuration files according to the robot type
#urcontrol.conf
rm -f $URSIM_ROOT/.urcontrol/urcontrol.conf
ln -s $URSIM_ROOT/.urcontrol/urcontrol.conf.$ROBOT_TYPE $URSIM_ROOT/.urcontrol/urcontrol.conf

#ur-serial
rm -f $URSIM_ROOT/ur-serial
ln -s $URSIM_ROOT/ur-serial.$ROBOT_TYPE $URSIM_ROOT/ur-serial

#safety.conf
rm -f $URSIM_ROOT/.urcontrol/safety.conf
ln -s $URSIM_ROOT/.urcontrol/safety.conf.$ROBOT_TYPE $URSIM_ROOT/.urcontrol/safety.conf

#program directory
rm -f $URSIM_ROOT/programs
ln -s $URSIM_ROOT/programs.$ROBOT_TYPE $URSIM_ROOT/programs

#Start the gui
#pushd GUI
#nohup Xvfb :99 -screen 0 1152x900x8 &
#DISPLAY=:99 HOME=$URSIM_ROOT java  -Duser.home=$URSIM_ROOT -Dconfig.path=$URSIM_ROOT/.urcontrol -Djava.library.path=/usr/lib/jni -jar bin/*.jar
#popd


#clean up
#rm -f $URSIM_ROOT/.urcontrol/urcontrol.conf
#rm -f $URSIM_ROOT/ur-serial
#rm -f $URSIM_ROOT/.urcontrol/safety.conf
#rm -f $URSIM_ROOT/programs

#popd &>/dev/null
./waitforportAndUnlock.sh &
./starturcontrol.sh
#echo "confirm user safety parameters" | nc localhost 30001
