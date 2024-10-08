# openup-ckan

Dokku Dockerfile-based deployment repository for CKAN for OpenUp's data portal


## Development

Initialise the database

    docker compose run --rm web paster --plugin=ckan db init -c ckan.ini


## Deployment

Set CKAN environment variables, replacing these examples with actual producation ones

- REDIS_URL: use the Redis _Dsn_
- SOLR_URL: use the alias given for the docker link below
- BEAKER_SESSION_SECRET: this must be a secret long random string. Each time it changes it invalidates any active sessions.
- S3FILESTORE__SIGNATURE_VERSION: use as-is - no idea why the plugin requires this.

```
dokku config:set ckan CKAN_SQLALCHEMY_URL=postgres://ckan_default:password@host/ckan_default \
                      CKAN_REDIS_URL=.../0 \
                      CKAN_INI=/app/ckan.ini \
                      CKAN_SITE_URL=http://data.openup.org.za/ \
                      CKAN___BEAKER__SESSION__SECRET=... \
                      CKAN_SMTP_SERVER= \
                      CKAN_SMTP_USER= \
                      CKAN_SMTP_PASSWORD= \
                      CKAN_SMTP_MAIL_FROM=info@openup.org.za \
                      CKAN___CKANEXT__S3FILESTORE__AWS_BUCKET_NAME=openup-ckan \
                      CKAN___CKANEXT__S3FILESTORE__AWS_ACCESS_KEY_ID= \
                      CKAN___CKANEXT__S3FILESTORE__AWS_SECRET_ACCESS_KEY= \
                      CKAN___CKANEXT__S3FILESTORE__HOST_NAME=http://s3-eu-west-1.amazonaws.com/openup-ckan \
                      CKAN___CKANEXT__S3FILESTORE__REGION_NAME=eu-west-1 \
                      CKAN___CKANEXT__S3FILESTORE__SIGNATURE_VERSION=s3v4
```

## Production

Deployment

    git remote add dokku-prod dokku@hetzner1.openup.org.za:openupckan
    git push dokku-prod master

## User Management


### Adding
Registration has been disabled on the web UI due to spam. To register a new user:

    ssh hetzner1@openup.org.za
    dokku enter openup-ckan
    paster --plugin=ckan user add newusername email=test@test.test password=test12345

### Removing

    ssh hetzner1@openup.org.za
    dokku enter openup-ckan
    paster --plugin=ckan user remove newusername
