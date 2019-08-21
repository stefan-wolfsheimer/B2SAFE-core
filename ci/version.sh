function rpm_package()
{
    local BUILD=$1
    local ABSOLUTE_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)
    local MAJOR_VERS=`grep "^\s*\*major_version" $ABSOLUTE_PATH/../rulebase/local.re | awk -F\" '{print $2}'`
    local MINOR_VERS=`grep "^\s*\*minor_version" $ABSOLUTE_PATH/../rulebase/local.re | awk -F\" '{print $2}'`
    local SUB_VERS=`grep "^\s*\*sub_version" $ABSOLUTE_PATH/../rulebase/local.re | awk -F\" '{print $2}'`
    local VERSION="${MAJOR_VERS}.${MINOR_VERS}.${SUB_VERS}"
    echo "irods-eudat-b2safe-${MAJOR_VERS}.${MINOR_VERS}.${SUB_VERS}-${BUILD}.noarch.rpm"
}

function irods_version()
{
    local VERSION=$1
    echo $VERSION | awk 'BEGIN{ FS="_"; }{ print $2"."$3"."$4; }'
}

function repo_name()
{
    local VERSION=$1
    local GIT_URL=$2
    local GIT_BRANCH=$3
    local IRODS_VERSION=$( echo $VERSION | awk 'BEGIN{ FS="_"; }{ print $2"."$3"."$4; }' )
    if [[ "${GIT_BRANCH}" == "master" ]]
    then
        local BRANCH=""
    else
        local BRANCH="${GIT_BRANCH}-"
    fi
    local USER=$( echo $GIT_URL | awk 'BEGIN{ FS="/"; }{ print $4; }' )
    if [[ "${USER}" == "EUDAT-B2SAFE" ]]
    then
        USER=""
    else
        USER="${USER}-"
    fi
    echo "${USER}${BRANCH}irods-${IRODS_VERSION}"
}
