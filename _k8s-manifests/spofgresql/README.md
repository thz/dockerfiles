# spofgresql

Deployment of postgresql as a single point of failure (SPOF; i.e. _not_ HA).

### Uhh?

The deployment runs with a single replica. Data is stored in a K8s emptyDir volume.

All databases are dumped in intervals and uploaded to an S3 endpoint. Backup file retention is done on local disk (emptyDir) and removable files deleted at the S3 endpoint.

### Limits

- when the single replica goes down, the whole service is unavailable
- when the single replica goes down, all data since the last S3 upload is lost
- retained backup files must fit into an emptyDir
