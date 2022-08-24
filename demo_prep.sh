#!/bin/bash

# Environment variables
DEMO_DIR=`pwd`				; export DEMO_DIR
#DEMO_DIR="/root/projects/efmdemo"	; export DEMO_DIR
BIN_DIR=${DEMO_DIR}/scripts		; export BIN_DIR

# Commands
SCP="/usr/bin/scp"			; export SCP
SSH="/usr/bin/ssh"			; export SSH
ECHO="/usr/bin/echo"			; export ECHO

i=pg1
${SCP} -F ${DEMO_DIR}/ssh_config ${BIN_DIR}/data.sql admin@${i}:/home/admin
${SCP} -F ${DEMO_DIR}/ssh_config ${BIN_DIR}/pg1.sh admin@${i}:/home/admin
${SSH} -F ${DEMO_DIR}/ssh_config admin@${i} -t "chmod 755 /home/admin/data.sql"
${SSH} -F ${DEMO_DIR}/ssh_config admin@${i} -t "chmod 755 /home/admin/pg1.sh"
${SSH} -F ${DEMO_DIR}/ssh_config admin@${i} -t "/home/admin/pg1.sh"

i=pg3
${SCP} -F ${DEMO_DIR}/ssh_config ${BIN_DIR}/pg3.sh admin@${i}:/home/admin
${SSH} -F ${DEMO_DIR}/ssh_config admin@${i} -t "chmod 755 /home/admin/pg3.sh"
${SSH} -F ${DEMO_DIR}/ssh_config admin@${i} -t "/home/admin/pg3.sh"

for i in `${ECHO} "pg1 pg2"`
do
  ${ECHO} ${i}
  ${SCP} -F ${DEMO_DIR}/ssh_config ${BIN_DIR}/remote_ctl.sh admin@${i}:/home/admin
  ${SCP} -F ${DEMO_DIR}/ssh_config ${BIN_DIR}/efm_rewind.sh admin@${i}:/home/admin
  ${SCP} -F ${DEMO_DIR}/ssh_config ${BIN_DIR}/efm_reconfigure_node.sh admin@${i}:/home/admin
  ${SSH} -F ${DEMO_DIR}/ssh_config admin@${i} -t "/home/admin/remote_ctl.sh"
done
