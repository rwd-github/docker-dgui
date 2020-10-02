#!/bin/bash
set -o errexit -o pipefail -o nounset

#mypath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#docker-compose pull
docker-compose up --build -d

. ./.env

myport=33890
# l
#myport=33891
# xl
myport=33892

while true; do
        ret=0
        xfreerdp /u:${guiuser} /p:${guipass} /rfx /sound /v:localhost:${myport} || ret=$?
# +clipboard  /f
        if [ "$ret" -eq "0"  ] ||  [ "$ret" -eq "12"  ]; then break; fi
        sleep 1
done

docker-compose down
