#!/bin/bash

VERSION=$1
BUILD=$2

if [[ -z "$VERSION" ]]
then
    VERSION=centos7_4_2_6
fi

if [[ -z "$BUILD" ]]
then
    BUILD=0
fi

echo $BUILD_NUMBER
echo $GIT_BRANCH
echo $GIT_URL


echo ssh $SSH_OPTIONS $YUM_SERVER "mkdir -p /repos/CentOS/7/${REPO_PREFIX}irods-4.1.12/Packages/"
echo scp $SSH_OPTIONS ./ci/RPMS/Centos/7/irods-4.1.12/*.rpm $YUM_SERVER:/repos/CentOS/7/${REPO_PREFIX}irods-4.1.12/Packages/
echo ssh $SSH_OPTIONS $YUM_SERVER createrepo --update /repos/CentOS/7/${REPO_PREFIX}irods-4.1.12

printenv
