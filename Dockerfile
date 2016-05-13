FROM   krallin/ubuntu-tini:latest 

MAINTAINER M. Drudi <mdrudi@gmail.com>

RUN apt-get update && apt-get -y install python python-dev python-pip gcc g++ libc-dev wget

RUN pip install --upgrade pip \
    && pip install jupyter \
    && pip install solr \
    && pip install redis \
    && pip install pymongo \
    && pip install requests;

#RUN apk add --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ tini

# Obtaining mysql.connector from Mysql, as it is no longer available from PIP for python2
RUN wget http://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-2.1.3.tar.gz \
    && tar -xvzf mysql-connector-python-2.1.3.tar.gz \
    && cd mysql-connector-python-2.1.3 \
    && python setup.py install

# Installing additional packages: nltk
RUN pip install -U nltk \
    && pip install -U numpy

RUN apt-get install -y python-scipy python-matplotlib python-pandas python-sympy python-nose 

# Install scipy stack
#RUN pip install scipy \
#    && pip install matplotlib \
#    && pip install pandas \
#    && pip install sympy \
#    && pip install nose;

# Install scikit-learn
RUN pip install -U scikit-learn

VOLUME /notebooks
WORKDIR /notebooks

EXPOSE  8888

ENTRYPOINT ["tini", "--"]
CMD ["jupyter", "notebook", "--ip=172.17.0.2", "--no-browser"]
