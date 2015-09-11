FROM  ubuntu:15.10

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && apt-get -y install python-dev python-pip build-essential git libpq-dev vim postgresql-client postgresql
WORKDIR /usr/src/ 
RUN pip install boto luigi datetime kafka-python psycopg2 requests pyslack-real
RUN mkdir -p /mnt/data
