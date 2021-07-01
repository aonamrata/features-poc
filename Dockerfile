# Dockerfile

FROM       centos:centos7

WORKDIR    /var/app

# Update and install common packages
RUN        yum -y update
RUN        yum -y install curl git tar zip

# Install python 3.6 and wsgi dependencies
RUN        yum -y install gcc python36 python36-libs python36-devel python36-pip

# Install ows-users dependencies
RUN        yum -y install make patch glibc-static libstdc++-static ncurses-devel ncurses-static openssl openssl-devel

# Create and configure virtualenv and uwsgi
RUN        python3.6 -m venv /var/app
RUN        /var/app/bin/pip install --upgrade pip
RUN        /var/app/bin/pip install uwsgi
RUN        useradd uwsgi -s /bin/false
RUN        mkdir /var/log/uwsgi
RUN        chown -R uwsgi:uwsgi /var/log/uwsgi

# Add application and install requirements
ADD        . /var/app
RUN        if [ -f /var/app/requirements.txt ]; then /var/app/bin/pip install -I -r /var/app/requirements.txt --use-deprecated=legacy-resolver; fi

# Add startup script
ADD        uwsgi-start-multi-thread-uwsgi.sh /
RUN        chmod +x /uwsgi-start-multi-thread-uwsgi.sh
ENTRYPOINT ["/uwsgi-start-multi-thread-uwsgi.sh"]

# ADD        uwsgi-start-multi-process-uwsgi.sh /
# RUN        chmod +x /uwsgi-start-multi-process-uwsgi.sh
# ENTRYPOINT ["/uwsgi-start-multi-process-uwsgi.sh"]


EXPOSE     8080
