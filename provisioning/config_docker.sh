#!/usr/bin/env bash

torrent_uid=$(grep torrent /etc/passwd|cut -d ':' -f 3)
sed -i "s/1001/${torrent_uid}/g" /root/docker-compose.yml
systemctl enable docker
service docker start
