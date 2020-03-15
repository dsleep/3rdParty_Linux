#!/bin/bash

git pull
git submodule update --recursive --remote --merge

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

pwd

THIRDPARTYROOT=`readlink -f ${SCRIPTPATH}/../3rdParty`
echo "3rd Party INSTALL ROOT: " $THIRDPARTYROOT

apt install python3-pip
pip install requests-aws
pip install requests

python Generate3rdPartyOutput.py