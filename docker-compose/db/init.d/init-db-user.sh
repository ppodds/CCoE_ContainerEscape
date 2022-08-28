#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE USER admin;
	CREATE DATABASE falco;
	GRANT ALL PRIVILEGES ON DATABASE falco TO admin;
EOSQL