#!/bin/bash

VERSION=$1
BUILD=$2
GIT_URL=$3
GIT_BRANCH=$4

if [[ -z "$VERSION" ]]
then
    VERSION=centos7_4_2_6
fi

if [[ -z "$BUILD" ]]
then
    BUILD=0
fi


source $(cd `dirname "${BASH_SOURCE[0]}"` && pwd)/version.sh
RPM_PACKAGE=`rpm_package $BUILD `
IRODS_VERSION=`irods_version $VERSION`
REPO_NAME=`repo_name $VERSION $GIT_URL $GIT_BRANCH `

ssh $SSH_OPTIONS $YUM_SERVER "mkdir -p /repos/CentOS/7/${REPO_NAME}/Packages/"
scp $SSH_OPTIONS ./ci/RPMS/Centos/7/${REPO_NAME}/${RPM_PACKAGE} $YUM_SERVER:/repos/CentOS/7/${REPO_NAME}/Packages/
ssh $SSH_OPTIONS $YUM_SERVER createrepo --update /repos/CentOS/7/${REPO_NAME}
