# Notes on PostgreSQL

## Client

```shell
psql -U <user>
```

The default user:
```shell
psql -U postgres
```

| Command | Description |
| --------| ------ |
| `\du`   | List users/roles |
| `\l`    | List databases |
| `\c <db>` | Connect to database named <db> |
| `\q`    | Quit |
| `\o <filename>` | Send output to <filename> |
| `\o`    | Reset output |

Pass SQL to run via the command line:
```shell
psql -U <user> -c 'CREATE DATABASE mydb;' -c 'CREATE USER myuser WITH PASSWORD 'pw';" -c 'GRANT ALL PRIVILEGES ON DATABASE mydb TO myuser;'
```

Pass a file containing SQL to run:
```shell
psql -U <user> -f sql_file.sql
```

## SQL files

### Create a database and tables in one SQL file

To create a database and tables inside it from one sql file, normally I would
use the `USE` or `CONNECT` statements, but they don't work in PostgreSQL.
Instead, use the `\c` psql command:

```sql
CREATE DATABASE mydb;
\c mydb
CREATE TABLE users (
  int_id SERIAL PRIMARY KEY,
  id VARCHAR(50) UNIQUE NOT NULL,
  email VARCHAR(355) UNIQUE NOT NULL,
  password VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);
...
```

## Extensions/UUID

To install an extension from contrib into a database:
```sql
\c mydb
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
```

With `uuid-ossp`, UUIDs can be generated:
```sql
SELECT uuid_generate_v4();
```

