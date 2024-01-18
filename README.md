Open e-Class Docker image

# Run
* Build: `docker compose -f docker-compose.build.yaml build`
* Run stack: `docker compose up -d`
* Run stack with SimpleIdentity (SSO & LDAP): `docker compose -f docker-compose.yaml -f docker-compose.test.yaml up -d`