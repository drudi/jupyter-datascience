FROM    alpine:latest

MAINTAINER M. Drudi <mdrudi@gmail.com>

RUN apk update && apk add python python-dev py-pip gcc g++ musl-dev \
    && pip install --upgrade pip \
    && pip install jupyter \
    && pip install solr \
    && pip install redis \
    && pip install pymongo \
    && pip install requests;

RUN apk add --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ tini

# Obtaining mysql.connector from Mysql, as it is no longer available from PIP for python2
RUN wget http://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-2.1.3.tar.gz \
    && tar -xvzf mysql-connector-python-2.1.3.tar.gz \
    && cd mysql-connector-python-2.1.3 \
    && python setup.py install

VOLUME /notebooks
WORKDIR /notebooks

EXPOSE  8888

ENTRYPOINT ["tini", "--"]
CMD ["jupyter", "notebook", "--ip=172.17.0.2", "--no-browser"]
