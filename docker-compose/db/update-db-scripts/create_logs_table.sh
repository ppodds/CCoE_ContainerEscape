#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE TABLE IF NOT EXISTS logs_info(
        container TEXT NOT NULL,
        syscall TEXT NOT NULL,
        process TEXT NOT NULL,
        timestamp TIMESTAMP NOT NULL
    );
EOSQL