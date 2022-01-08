# WSGI service environment

FROM sourcepole/qwc-uwsgi-base:alpine-v2022.01.08

# Required for pip with git repos
RUN apk add --no-cache --update git
# Required for psychopg, --> https://github.com/psycopg/psycopg2/issues/684
RUN apk add --no-cache --update postgresql-dev gcc python3-dev musl-dev

# maybe set locale here if needed

ADD . /srv/qwc_service
# Workaround for "ImportError: cannot import name 'PackageFinder'"
RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py pip
RUN pip3 install --no-cache-dir -r /srv/qwc_service/requirements.txt
