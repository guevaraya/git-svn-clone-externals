#!/bin/bash
##############################################################
#
#   clone code from suversion server hisi3531
#
##############################################################
CLONE_DIR_DEFAULT=hisi3531
CLONE_USER_DEFAULT=root
if echo $1  | grep -qi "help";then
	echo "clone code from version server"
	echo "Usage:"
	echo "sub_clone [user] [dir]"
	echo "	dir is a directory will clone to, defautl: current dir"
	echo "	user used for login a verison server name, defautl: root"
	echo
	exit
fi

CLONE_PWD=`pwd`
if [ -z $1 ]
then
	CLONE_USER=${CLONE_USER_DEFAULT}
else
	CLONE_USER=$1
fi
if [ -z $2 ]
then
	CLONE_DIR=${CLONE_DIR_DEFAULT}
else
	CLONE_DIR=$2
fi


git clone $CLONE_USER@192.168.5.1:/opt/NvrSys/Hisi-platform/hisi3531 -b svn-hisi3531 ${CLONE_DIR}
cd $CLONE_DIR
echo Enter directory: $CLONE_DIR
echo clone svn remote svn://192.168.5.1/hbgk_nvr/Sys/Hisi3531 ...
echo -e '[svn-remote "svn"]
	url = svn://192.168.5.1/hbgk_nvr/Sys/Hisi3531
	fetch = :refs/remotes/git-svn 
	' >> .git/config 
git svn fetch 
git svn-clone
git gc
cd $CLONE_PWD


