#!/bin/bash

RED='\e[31m'
GREEN='\e[32m'
NC='\033[0m'
libPamela="pamela.so"
libDir="/lib/x86_64-linux-gnu/security/"

sessionFile="/etc/pam.d/common-session"
passwordFile="/etc/pam.d/common-password"
authFile="/etc/pam.d/common-auth"

backSession=".save/common-session"
backPassword=".save/common-password"
backAuth=".save/common-auth"

if [ $(id -u) != 0 ]
then
    echo -e "${RED}You must be root.${NC}"
    exit 1
fi

if [ ! -f ${backSession} ] || [ ! -f ${backPassword} ] || [ ! -f ${backAuth} ]
then
    echo -e "${RED}$0: Backup files not found. Run make install.${NC}"
    exit 1
fi

echo -e "Backup Files found."

if [ ! -f ${pathLib}${libPamela} ]
then
    echo -e "${RED}$0: Lib '${libPamela}' is not installed.${NC}"
    exit 1
fi

echo -e "Lib '${libPamela}' found."

if [ ! -f ${sessionFile} ]
then
    echo -e "${RED}$0: File '${sessionFile}' not found.${NC}"
    exit 1
fi

echo -e "File '${sessionFile}' found."

if [ ! -f ${passwordFile} ]
then
    echo -e "${RED}$0: File '${passwordFile}' not found.${NC}"
    exit 1
fi

echo -e "File '${passwordFile}' found."

if [ ! -f ${authFile} ]
then
    echo -e "${RED}$0: File '${authFile}' not found.${NC}"
    exit 1
fi

echo -e "File '${authFile}' found."

echo -e "${GREEN}OK!"
