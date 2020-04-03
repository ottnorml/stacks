#!/usr/bin/env bash

addr=$( hostname -I | col1 )
data=$( docker volume inspect pihole_dnsmasq -f '{{ .Mountpoint }}' )
for n in $( seq 1 120 )
do
    if [ -d $data ]
    then
        echo "address=/.pi/$addr" > $data/99-pi.conf
        break
    fi
    sleep 1
done
