#!/bin/bash
set -x
set -e

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

IRODS_VERSION=$( echo $VERSION | awk 'BEGIN{ FS="_"; }{ print $2"."$3"."$4; }' )

cleanup () {
    exit_code=$?
    docker-compose -f ci/${VERSION}/docker-compose.yml down -v
    exit $exit_code
}

trap cleanup EXIT ERR INT TERM
source $(cd `dirname "${BASH_SOURCE[0]}"` && pwd)/version.sh

RPM_PACKAGE=`rpm_package $BUILD `

mkdir -p ci/RPMS/Centos/7/irods-${IRODS_VERSION}

docker-compose -f ci/${VERSION}/docker-compose.yml build
docker-compose -f ci/${VERSION}/docker-compose.yml up -d

docker exec ${VERSION}_icat_1 /app/create_rpm.sh $BUILD

docker exec ${VERSION}_icat_1 bash -c "set -x; set -e; cp /var/lib/irods/rpmbuild/RPMS/noarch/${RPM_PACKAGE} /build/ci/RPMS/Centos/7/irods-${IRODS_VERSION};" 
