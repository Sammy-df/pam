#!/bin/bash

GREEN='\e[32m'
NC='\033[0m'
libPamela="pamela.so"
libDir="/lib/x86_64-linux-gnu/security/"
saveDir=".save/"

if [ $(id -u) != 0 ]
then
    echo -e "${RED}You must be root."
    exit 1
fi

if [ ! -f ${libDir}${libPamela} ]
then
    echo -e "${GREEN}$0: Lib '${libPamela}' is not installed.${NC}"
else
    rm ${libDir}${libPamela} || exit 1    
    echo -e "${GREEN}Lib '${libPamela}' removed.${NC}"
fi

if [ ! -f ".save/common-session" ]
then
    echo -e "${GREEN}$0: common-session file not found. Can not restore this file${NC}"
else
    cp .save/common-session /etc/pam.d/common-session
    echo -e "${GREEN}$0: common-session file restored.${NC}"
fi


if [ ! -f ".save/common-password" ]
then
    echo -e "${GREEN}$0: common-password file not found. Can not restore this file.${NC}"
else
    cp .save/common-password /etc/pam.d/common-password
    echo -e "${GREEN}$0: common-password file restored.${NC}"
fi

if [ ! -f ".save/common-auth" ]
then
    echo -e "${GREEN}$0: common-auth file not found. Can not restore this file.${NC}"
else
    cp .save/common-auth /etc/pam.d/common-auth
    echo -e "${GREEN}$0: common-auth file restored.${NC}"
fi

sudo rm -rf ${saveDir}
echo -e "${GREEN}$0: Backup files deleted.${NC}"
