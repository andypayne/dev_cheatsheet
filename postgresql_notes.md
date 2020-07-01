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

