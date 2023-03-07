#!/bin/bash

[ -d $SCRIPT_BACKUP_POSTGRES_DIR ] || mkdir $SCRIPT_BACKUP_POSTGRES_DIR

chmod -R 777 $SCRIPT_BACKUP_POSTGRES_DIR

BACKUP_FILE="$SCRIPT_BACKUP_POSTGRES_DIR/$SCRIPT_BACKUP_POSTGRES_DB_NAME-$(date +"%Y_%m_%d_%H_%M_%S").sql"

# Executa o backup usando pg_dump
pg_dump --host=$SCRIPT_BACKUP_POSTGRES_DB_HOST --username=$SCRIPT_BACKUP_POSTGRES_DB_USERNAME --port=$SCRIPT_BACKUP_POSTGRES_DB_PORT --dbname=$SCRIPT_BACKUP_POSTGRES_DB_NAME --clean --file=$BACKUP_FILE

# Testa se o backup foi criado com sucesso
if [ $? -eq 0 ]; then
    echo "Backup criado com sucesso em $BACKUP_FILE"
else
    echo "Erro ao criar o backup"
    exit 1
fi

find $SCRIPT_BACKUP_POSTGRES_DIR -type f -name "$SCRIPT_BACKUP_POSTGRES_DB_NAME-*ll" -mtime +2 -exec rm {} \;
