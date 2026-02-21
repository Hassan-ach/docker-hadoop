FROM bde2020/hadoop-base:2.0.0-hadoop3.2.1-java8

RUN sed -i s/deb.debian.org/archive.debian.org/g /etc/apt/sources.list && \
    sed -i 's|security.debian.org/debian-security|archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    sed -i '/stretch-updates/d' /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y --allow-unauthenticated python3 python3-pip && \
    pip3 install 'pymysql==0.9.3' && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=$PATH:/opt/sqoop

WORKDIR /opt/sqoop

COPY pysqoop.py /opt/sqoop/pysqoop.py
RUN chmod +x /opt/sqoop/pysqoop.py

RUN echo '#!/bin/bash' > /opt/sqoop/sqoop && \
    echo 'python3 /opt/sqoop/pysqoop.py "$@"' >> /opt/sqoop/sqoop && \
    chmod +x /opt/sqoop/sqoop

COPY run.sh run.sh
RUN chmod +x run.sh

CMD ["tail", "-f", "/dev/null"]
