#!/bin/bash
set -x
set -e

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

cleanup () {
    exit_code=$?
    docker-compose -f ci/${VERSION}/docker-compose.yml down -v
    exit $exit_code
}

trap cleanup EXIT ERR INT TERM

source $(cd `dirname "${BASH_SOURCE[0]}"` && pwd)/version.sh
RPM_PACKAGE=`rpm_package $BUILD `
IRODS_VERSION=`irods_version $VERSION`
REPO_NAME=`repo_name $VERSION $GIT_URL $GIT_BRANCH `


mkdir -p ci/RPMS/Centos/7/${REPO_NAME}

docker-compose -f ci/${VERSION}/docker-compose.yml build
docker-compose -f ci/${VERSION}/docker-compose.yml up -d

docker exec ${VERSION}_icat_1 /app/create_rpm.sh $BUILD

docker exec ${VERSION}_icat_1 bash -c "set -x; set -e; cp /var/lib/irods/rpmbuild/RPMS/noarch/${RPM_PACKAGE} /build/ci/RPMS/Centos/7/${REPO_NAME};" 
