Scalarm Information Service
===========================

Information Service for the Scalarm platform is a "well-known" place, where Scalarm services are registered.

To run Information Service you need to fulfill the following requirements:

* Ruby version

We are currently working with Rubinius 2.2.1 installed via RVM.

* System dependencies

libSQLite3 and any other required by native gems.

* Configuration

You need two configuration files in the config folder, and you need to generate a private key and SSL certificate.
The first one is 'scalarm.yml', and in this file you put the following information in the YAML format:

```
# login and password to the service
service_login: secret_login
service_password: secret_password
# paths to SSL certificate and private key
service_crt: ./config/my_cert.pem
service_key: ./config/my_key.pem
```

The second file, 'thin.yml', includes the following information for the web server:
```
pid: tmp/pids/thin.pid
log: log/thin.log
environment: production
port: 11300
```

* Database creation and initialization

Before starting Information Service you need to initialize a database with the following command:

```
$ RAILS_ENV=production rake db:migrate
```

* To start Information Service just type

```
$ rake service:start
```

* To stop Information Service just type

```
$ rake service:stop
```