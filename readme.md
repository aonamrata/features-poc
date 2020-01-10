# features-poc


## Pre:

1. that Redis cache is running
2. Init .env with real values for split key and redis cache details.


## Shell 1: Synchronizer

```
cd /var/www/html_npatel/features-poc
source .env
sh synchronizer-start.sh

```


## Shell 2: Flask Application

```
cd /var/www/html_npatel/features-poc
source .env
sh sh uwsgi-start.sh

```


## Shell 3: K6 load tester

```
cd /var/www/html_npatel/features-poc
source .env
sh k6-test-runner.sh

```

