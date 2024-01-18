Open e-Class Docker image

# Run
* Build: `docker compose -f docker-compose.build.yaml build`
* Run stack: `docker compose up -d`
* Run stack with SimpleIdentity (SSO & LDAP): `docker compose -f docker-compose.yaml -f docker-compose.test.yaml up -d`

# Environment Variables
* The variables below can be set in the `docker-compose.yaml` file
  - `MYSQL_LOCATION`: The DB location, used as default value when setting up a new installation. Should be left to the default value of `db` which is the service name of the `db` MariaDB container
  - `MYSQL_ROOT_PASSWORD`: The MariaDB root password to use to connect. Should be left to the default value of `secret`. Only containers in the Docker Compose stack have access to the MariaDB container, no SQL port is exposed to the outside world.
  - `PHP_MAX_UPLOAD`: The maximum file that can be uploaded. The default value is `256M`

# Size
* Docker image
  - e-Class: `850 MB`
  - MariaDB: `400 MB`
* Memory usage
  - e-Class: `50 MB`
  - MariaDB: `150 MB`