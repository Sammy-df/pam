#!/bin/bash

RED='\e[31m'
GREEN='\e[32m'
NC='\033[0m'
libPath="/lib/x86_64-linux-gnu/security/"
libPamela="pamela.so"
sessionFile="/etc/pam.d/common-session"
passwordFile="/etc/pam.d/common-password"
authFile="/etc/pam.d/common-auth"
saveDir=".save/"

if [ $(id -u) != 0 ]
then
    echo -e "${RED}You must be root.${NC}"
    exit 1
fi

apt-get install -y libcryptsetup-dev libpam0g-dev cryptsetup cryptsetup-bin || exit 1

if [ ! -f ${libPath}${libPamela} ]
then
    make || exit
    cp ${libPamela} ${libPath}
    echo -e "${GREEN}$0: Lib '${libPamela}' installed.${NC}"
else
    echo -e "${GREEN}$0: Lib '${libPamela}' already installed.${NC}"
fi

if [ ! -f ${sessionFile} ]
then
    echo -e "${RED}$0: File '${sessionFile}' not found.${NC}"
    exit 1
fi

if [ ! -f ${passwordFile} ]
then
    echo -e "${RED}$0: File '${passwordFile}' not found.${NC}"
    exit 1
fi

if [ ! -f ${authFile} ]
then
    echo -e "${RED}$0: File '${authFile}' not found.${NC}"
    exit 1
fi

# Edit pam files and save originals
mkdir -p ${saveDir}
echo -e "${GREEN}Editing file '${sessionFile}'${NC}"
cp ${sessionFile} ${saveDir}
echo -e "${GREEN}Backup file for ${sessionFile} saved.${NC}"
echo "session optional pamela.so" >> ${sessionFile} || exit 1
echo -e "${GREEN}File edited.${NC}"

cp ${passwordFile} ${saveDir}
echo -e "${GREEN}Backup file for ${passwordFile} saved.${NC}"
echo -e "${GREEN}Editing file '${passwordFile}'${NC}"
echo "password optional pamela.so" >> ${passwordFile} || exit 1
echo -e "${GREEN}File edited.${NC}"

cp ${authFile} ${saveDir}
echo -e "${GREEN}Backup file for ${authFile} saved.${NC}"
echo -e "${GREEN}Editing file '${authFile}'${NC}"
echo "auth optional pamela.so" >> ${authFile} || exit 1
echo -e "${GREEN}File edited.${NC}"

echo -e "${GREEN}Installation successfull.${NC}"

