FROM  ubuntu:15.10

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && apt-get -y install python-dev python-pip build-essential git libpq-dev vim postgresql-client postgresql unzip vim
WORKDIR /usr/src/ 
RUN mkdir -p /mnt/data/manifests && mkdir -p /mnt/data/markers
RUN mkdir /usr/src/enricher
RUN pip install boto luigi datetime psycopg2 requests pysparkling pandas pyyaml
RUN git clone https://github.com/adqio/python-confluent-schemaregistry.git && cd python-confluent-schemaregistry && python setup.py bdist_egg && cp dist/*.egg ../enricher
RUN git clone https://github.com/adqio/fastavro.git && cd fastavro && python setup.py bdist_egg && cp dist/*.egg ../enricher
RUN git clone https://github.com/Parsely/pykafka.git && cd pykafka && python setup.py bdist_egg && cp dist/*.egg ../enricher
RUN git clone https://github.com/john-kurkowski/tldextract.git && cd pykafka && python setup.py bdist_egg && cp dist/*.egg ../enricher
RUN cd usr/local/lib/python2.7/dist-packages && zip -r pyyaml.zip yaml && cp pyyaml.zip /usr/src/enricher/
