#!/bin/bash
if [ $# -eq 0 ]; then
  echo "no docker img, exit"
  exit 1
fi
export USER_ID=`id -u`
export GID=`id -g`
export GNAME=`groups | cut -d ' ' -f 1`
export TARGET_IMAGE=$1
export IMAGE_NAME=${TARGET_IMAGE//:/_}
echo $IMAGE_NAME
#docker compose up -d
docker run -itd -v ${HOME}:${HOME} -w ${HOME}  --name ${USER}_${IMAGE_NAME} ${TARGET_IMAGE}  bash -c "apt-get update && apt-get install sudo -y && groupadd -g ${GID} ${GNAME}  && useradd -u ${USER_ID} -g ${GID} -m -s /bin/bash ${USER}  && echo '${USER} ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && su ${USER}"
