FROM  ubuntu:15.10
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && apt-get -y install python-dev python-pip build-essential git libpq-dev vim postgresql-client postgresql zip vim
WORKDIR /usr/src/ 
RUN mkdir -p /mnt/data/manifests && mkdir -p /mnt/data/markers && mkdir /usr/src/enricher
RUN easy_install pip && mv /usr/bin/pip /usr/bin/pip_os && ln -s /usr/local/bin/pip /usr/bin/pip
RUN /usr/local/bin/pip install pyslack-real boto luigi datetime psycopg2 requests pysparkling cython pandas pyyaml pykafka avro tldextract simplejson cachetools
RUN git clone https://github.com/adqio/python-confluent-schemaregistry.git && cd python-confluent-schemaregistry && python setup.py bdist_egg && cp dist/*.egg ../enricher
RUN git clone https://github.com/adqio/fastavro.git && cd fastavro && python setup.py bdist_egg && cp dist/*.egg ../enricher
RUN git clone https://github.com/Parsely/pykafka.git && cd pykafka && python setup.py bdist_egg && cp dist/*.egg ../enricher
RUN git clone https://github.com/dpkp/kafka-python.git && cd kafka-python && python setup.py bdist_egg && cp dist/*.egg ../enricher
RUN git clone https://github.com/john-kurkowski/tldextract.git && cd pykafka && python setup.py bdist_egg && cp dist/*.egg ../enricher
RUN git clone https://github.com/yaml/pyyaml.git && cd pyyaml && python setup.py bdist && cd dist && tar -zxvf *.tar.gz && cd usr/local/lib/python2.7/dist-packages && zip -r pyyaml.zip yaml && cp pyyaml.zip /usr/src/enricher
