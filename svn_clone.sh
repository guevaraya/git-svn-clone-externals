#!/bin/bash
##############################################################
#
#   clone code from suversion server hisi3531
#
##############################################################
git_repo_default="yangkai@192.168.5.1:/opt/NvrSys/hbgk_nvr.git"
svn_repo_default="svn://192.168.5.1/hbgk_nvr"
local_dir_default="source_dir"
svn_branch_default="svn_hbgk_nvr"


if echo $1  | grep -qi "help";then
	echo "clone code from version server"
	echo "Usage:"
	echo "svn_clone [[usrname@]git_repository] [svn_repository] [local_dir]"
	echo "	dir is a directory will clone to, defautl: current dir"
	echo "	user used for login a verison server name, defautl: root"
	echo
	exit
fi

CLONE_PWD=`pwd`
if [ -z $1 ]
then
	git_repo=${git_repo_default}
else
	git_repo=$1
fi
if [ -z $2 ]
then
	svn_repo=${svn_repo_default}
else
	svn_repo=$2
fi

if [ -z $3 ]
then
	local_dir=${local_dir_default}
else
	local_dir=$3
fi

git clone ${git_repo}  ${local_dir} 
pushd ${local_dir}
echo Enter directory: ${local_dir}
echo clone svn remote ${svn_repo} ...
git config -add svn-remote.svn.url ${svn_repo}
git config -add svn-remote.svn.fetch :refs/remotes/git-svn
git svn fetch 
git checkout -b ${svn_branch_default} -t remotes/git-svn
git gc
popd


git config -add svn-remote.svn.url ${svn_repo}
git config -add svn-remote.svn.fetch :refs/remotes/svn
git svn fetch 

