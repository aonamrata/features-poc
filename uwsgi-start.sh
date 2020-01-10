#!/bin/bash

# Modeled closely after flask portion of amazon/aws-eb-python:3.4.2-onbuild-3.5.1 entrypoint script

UWSGI_NUM_PROCESSES='1'
UWSGI_NUM_THREADS='15'
UWSGI_UID='uwsgi'
UWSGI_GID='uwsgi'
UWSGI_BUFFER_SIZE='12288'
UWSGI_TIMEOUT='90'
UWSGI_HEADERS='Connection:Keep-Alive'


cd /var/www/html_npatel/features-poc

. env/bin/activate

# Flask support
if cat requirements.txt | grep -q -i Flask && [ -z "${WSGI_MODULE}" ]; then
 UWSGI_MODULE='--module application:app'
fi

# defaulting to application.py if not explicitly set
[ -z "${WSGI_PATH}" ] && WSGI_PATH=application.py

DDTRACE_BINARY=$(whereis ddtrace-run | cut -d ' ' -f 2)
if [ -x ${DDTRACE_BINARY} ]; then
 ${DDTRACE_BINARY} uwsgi --http :8080 --chdir /var/www/html_npatel/features-poc --wsgi-file ${WSGI_PATH} ${UWSGI_MODULE} --master --processes ${UWSGI_NUM_PROCESSES} --threads ${UWSGI_NUM_THREADS} --uid ${UWSGI_UID} --gid ${UWSGI_GID} -t ${UWSGI_TIMEOUT} --http-keepalive --add-header ${UWSGI_HEADERS} --buffer-size ${UWSGI_BUFFER_SIZE} --lazy-apps
else
 uwsgi --http :8080 --chdir /var/www/html_npatel/features-poc --wsgi-file ${WSGI_PATH} ${UWSGI_MODULE} --master --processes ${UWSGI_NUM_PROCESSES} --threads ${UWSGI_NUM_THREADS} --uid ${UWSGI_UID} --gid ${UWSGI_GID} -t ${UWSGI_TIMEOUT} --http-keepalive --add-header ${UWSGI_HEADERS} --buffer-size ${UWSGI_BUFFER_SIZE} --lazy-apps
fi
