#!/usr/bin/env bash

waitfor() {
    for n in $( seq 1 60 )
    do
        $@ &> /dev/null && return
        sleep 1
    done
}

waitfor docker volume inspect pihole_dnsmasq
data=$( docker volume inspect pihole_dnsmasq -f '{{ .Mountpoint }}' )
container=$( docker container ls | grep pihole | awk '{ print $1 }' )
addr=$( hostname -I | awk '{ print $1 }' )
echo "address=/.pi/$addr" > $data/99-pi.conf
docker exec $container pihole restartdns
