# features-poc


## Pre:

1. Init .env with real values for split key and redis cache details.



## Shell 2: Flask Application

```
cd /var/www/html_npatel/features-poc
docker build  -t features1 .
docker run -p 8080:8080 features1

```

