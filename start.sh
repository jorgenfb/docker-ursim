#!/bin/sh

URSIM_ROOT=$(dirname $(readlink -f $0))

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

# URControl needs this to find libxmlrpc_client++.so.8
export LD_LIBRARY_PATH=/opt/urtool-3.0/lib

export HOME=$URSIM_ROOT

# Start URControl
$URSIM_ROOT/URControl
