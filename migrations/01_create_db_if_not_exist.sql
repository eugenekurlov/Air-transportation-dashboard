SELECT 'CREATE DATABASE demo'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'demo')\gexec
