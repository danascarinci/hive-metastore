# hive-metastore

Docker image used to create a minimal unsecured hive metastore for teaching 
purposes. DO NOT use for production.

It is configured to connect to a PostgreSQL database on port 5433.


ENV variables:
 - METASTORE_DB_HOSTNAME - hostname used to ping metastore db during init
 
 
