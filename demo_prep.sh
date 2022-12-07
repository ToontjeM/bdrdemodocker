#!/bin/bash
primary1=upwards
primary2=koala
witness=unpaid

# Environment variables
DEMO_DIR=`pwd`				; export DEMO_DIR
BIN_DIR=${DEMO_DIR}/scripts		; export BIN_DIR

# Primary
docker cp ${BIN_DIR}/data.sql ${primary1}:/home/admin
docker cp ${BIN_DIR}/pg1.sh ${primary1}:/home/admin
docker exec -ti ${primary1} "chmod 755 /home/admin/pg1.sh"
docker exec -ti ${primary1} "chmod 755 /home/admin/data.sql"
docker exec -ti ${primary1} "/home/admin/pg1.sh"

# Witness
docker cp ${BIN_DIR}/pg3.sh ${witness}:/home/admin
docker exec -ti ${witness} "chmod 755 /home/admin/pg3.sh"
docker exec -ti ${witness} "/home/admin/pg3.sh"

# Primaries
for i in [${primary1},${primary2}]
do
  echo ${i}
  docker cp ${BIN_DIR}/remote_ctl.sh ${i}:/home/admin
  docker cp ${BIN_DIR}/efm_rewind.sh ${i}:/home/admin
  docker cp ${BIN_DIR}/efm_reconfigure_node.sh ${i}:/home/admin
  docker exec -ti ${i} "chmod 755 /home/admin/remote_ctl.sh"
  docker exec -ti ${i} "/home/admin/remote_ctl.sh"
done
