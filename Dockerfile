FROM  ubuntu:15.10

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && apt-get -y install python-dev python-pip build-essential git libpq-dev vim postgresql-client postgresql
WORKDIR /usr/src/ 
RUN mkdir -p /mnt/data/manifests && mkdir -p /mnt/data/markers
RUN mkdir /usr/src/enricher
RUN pip install boto luigi datetime kafka-python psycopg2 requests pysparkling pandas tldextract
RUN git clone https://github.com/adqio/python-confluent-schemaregistry.git && cd python-confluent-schemaregistry && python setup.py bdist_egg && cp dist/*.egg ../enricher
RUN git clone https://github.com/dpkp/kafka-python.git && cd kafka-python && python setup.py bdist_egg && cp dist/*.egg ../enricher 
RUN git clone https://github.com/adqio/fastavro.git && cd fastavro && python setup.py bdist_egg && cp dist/*.egg ../enricher
