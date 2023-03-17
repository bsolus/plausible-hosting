#!/bin/bash

cd /var/docker/plausible/

docker compose exec plausible_events_db bash /backups/clickhouse-2d-rotate.sh

docker compose exec plausible_db bash /backups/postgres-2d-rotate.sh


rsync \
    -POa \
    -e "ssh -o StrictHostKeyChecking=no -p 7890 -i /etc/automysqlbackup/id_rsa " \
    /var/docker/plausible/backups/daily/ backupman@130.185.86.164:/var/backup/db/`hostname -f`/