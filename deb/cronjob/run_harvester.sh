!/bin/bash

 ip=$(echo $IP_MASTER | tr -d '\r')
/sbin/ip -o -4 addr list scope global | awk '{print $4}' | cut -d/ -f1 | grep "$ip"

 if [ $? -eq 0 ]; then
  logger "Start GovData harvester"
  /usr/lib/ckan/env/bin/paster --plugin=ckanext-harvest harvester run --config=/etc/ckan/default/production.ini
  logger "Finished GovData harvester"
else
  logger "Host isn't master host"
fi