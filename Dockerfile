FROM python:3.4

# installing necessary dependencies
RUN apt-get -y update && apt-get install -y yui-compressor && apt-get install -y xvfb

# user creation
RUN groupadd user && useradd --create-home --home-dir /home/user -g user user
WORKDIR /home/user

# Somewhere here there is the need for the app to be installed
# install celery just for testing purposes
RUN pip install celery

# test celery worker. Note, we again need the app code installed to use
# proper celery settings
RUN pip install redis

RUN { \
    echo 'import os'; \
    echo "BROKER_URL = os.environ.get('CELERY_BROKER_URL', 'amqp://')"; \
} > celeryconfig.py

ENV CELERY_BROKER_URL amqp://guest@rabbit

COPY celery_workers.sh /home/user
RUN chmod +x /home/user/celery_workers.sh

USER user

CMD ["/home/user/celery_workers.sh"]
