# MTWILSON SERVER CONFIGURATION
# ------------------------
# Required settings:
# MTWILSON_HOST (example: 198.51.100.129)
# MTWILSON_PORT (example: 8443)
# MTWILSON_ADMIN_PASSWORD (example: faDN8crPg0PZVqVgElFJlDuA)
# MTWILSON_ASSET_TAG_API_PASSWORD (example: faDN8crPg0PZVqVgElFJlDuA)
# ------------------------

export MTWILSON_SERVER=<MTWILSON_HOST>
export MTWILSON_API_BASEURL="https://<MTWILSON_HOST>:<MTWILSON_PORT>/mtwilson/v1"
export MC_FIRST_PASSWORD=<MTWILSON_ADMIN_PASSWORD>
export PRIVACYCA_DOWNLOAD_PASSWORD=<MTWILSON_PRIVACYCA_DOWNLOAD_PASSWORD>

# TODO: generate database password and set here; default is "password" ??
export DATABASE_PASSWORD=<DATABASE_PASSWORD>

# ------------------------
# Optional settings:
# MTWILSON_TAG_ADMIN_USERNAME (example: tagadmin)
# ------------------------



# ------------------------
# Default settings:
# ------------------------

export INSTALL_PKGS="java logrotate postgres tomcat monit privacyca SERVICES PORTALS"
export WEBSERVER_VENDOR=tomcat
export MC_FIRST_USERNAME=admin
export LOG_SIZE=50M
export LOG_OLD=3
export MTWILSON_TLS_POLICY_ALLOW="certificate,certificate-digest,public-key,public-key-digest,TRUST_FIRST_CERTIFICATE,INSECURE"
# TODO: change default tls policy
export MTWILSON_DEFAULT_TLS_POLICY_ID="TRUST_FIRST_CERTIFICATE"
export MTWILSON_API_SSL_VERIFY_HOSTNAME=false
export DATABASE_VENDOR=postgres
export DATABASE_HOSTNAME=127.0.0.1
export DATABASE_PORTNUM=5432
export DATABASE_SCHEMA=mw_as
export DATABASE_USERNAME=root

# ------------------------
# Feature: java
# ------------------------

export JAVA_REQUIRED_VERSION=1.7.0_51

# ------------------------
# Feature: privacy ca
# ------------------------

export PRIVACYCA_DOWNLOAD_USERNAME=admin
export PRIVACYCA_SERVER=<MTWILSON_HOST>
export PRIVACYCA_KEYGEN_URANDOM=yes

# ------------------------
# Feature: postgresql
# ------------------------

export POSTGRES_REQUIRED_VERSION=9.3
export POSTGRES_HOSTNAME=${DATABASE_HOSTNAME}
export POSTGRES_PORTNUM=${DATABASE_PORTNUM}
export POSTGRES_DATABASE=${DATABASE_SCHEMA}
export POSTGRES_USERNAME=${DATABASE_USERNAME}
export POSTGRES_PASSWORD=${DATABASE_PASSWORD}
export POSTGRESQL_KEEP_PGPASS=true
export ADD_POSTGRESQL_REPO=yes

# ------------------------
# Feature: tomcat
# ------------------------

export TOMCAT_REQUIRED_VERSION=7.0
export TOMCAT_CREATE_SSL_CERT=yes
export TOMCAT_SSL_CERT_CN=<MTWILSON_HOST>,127.0.0.1

# ------------------------
# Feature: asset tagging
# ------------------------

export MTWILSON_TAG_SERVER_PRIVATE=<MTWILSON_HOST>
export MTWILSON_TAG_ADMIN_USERNAME=<MTWILSON_TAG_ADMIN_USERNAME>
export MTWILSON_TAG_ADMIN_PASSWORD=<MTWILSON_TAG_ADMIN_PASSWORD>
# TODO: possibly broken... should be in /opt/mtwilson/...
export MTWILSON_TAG_HTML5_DIR=/usr/share/apache-tomcat-7.0.34/webapps/mtwilson-portal/tag
export MTWILSON_TAG_CERT_IMPORT_AUTO=true
export TAG_PROVISION_EXTERNAL=false
export TAG_PROVISION_NOCACHE=true
export TAG_PROVISION_XML_ENCRYPTION_REQUIRED=false
# todo: possibly broken with xml password ... shouldn't be needed.
export TAG_PROVISION_XML_PASSWORD=password
export TAG_VALIDITY_SECONDS=31536000
export TAG_ISSUER_DN='CN=mtwilson-tag-ca'

