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
