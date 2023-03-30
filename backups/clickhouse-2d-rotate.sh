#!/bin/bash
echo "Backing up ClickHouse ..."

backup_name=$(date +"%Y_%m_%d_%H_%M_%S")-clickhouse
script_backup_clickhouse_dir="./backups/daily/clickhouse"
temp_path="${script_backup_clickhouse_dir}/${backup_name}"
tar_path="${temp_path}.tar.gz"

echo "Creating backup ${backup_name} ..."
docker compose run --rm plausible_events_db_backups create "${backup_name}"

echo "Compressing ${tar_path}"
tar -zcf "${tar_path}" -C "${temp_path}" .

echo "Cleaning up ..."
rm -rf "${temp_path}"

echo "Done"

find $script_backup_clickhouse_dir -type f -name "*.tar.gz" -mtime +2 -exec rm {} \;