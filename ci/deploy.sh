#!/bin/bash

printenv

ssh $SSH_OPTIONS $YUM_SERVER "mkdir -p /repos/CentOS/7/${REPO_PREFIX}irods-4.1.12/Packages/"
scp $SSH_OPTIONS ./ci/RPMS/Centos/7/irods-4.1.12/*.rpm $YUM_SERVER:/repos/CentOS/7/${REPO_PREFIX}irods-4.1.12/Packages/
ssh $SSH_OPTIONS $YUM_SERVER createrepo --update /repos/CentOS/7/${REPO_PREFIX}irods-4.1.12
