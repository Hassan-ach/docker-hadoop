FROM bde2020/hadoop-base:2.0.0-hadoop3.2.1-java8

RUN sed -i s/deb.debian.org/archive.debian.org/g /etc/apt/sources.list && \
    sed -i 's|security.debian.org/debian-security|archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    sed -i '/stretch-updates/d' /etc/apt/sources.list

ENV FLUME_VERSION=1.11.0
ENV FLUME_HOME=/opt/flume
ENV PATH=$PATH:$FLUME_HOME/bin

RUN apt-get update && \
    apt-get install -y --allow-unauthenticated wget tar python3 python3-pip bash && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://archive.apache.org/dist/flume/${FLUME_VERSION}/apache-flume-${FLUME_VERSION}-bin.tar.gz \
    && tar -xzf apache-flume-${FLUME_VERSION}-bin.tar.gz \
    && mv apache-flume-${FLUME_VERSION}-bin $FLUME_HOME \
    && rm apache-flume-${FLUME_VERSION}-bin.tar.gz

RUN rm $FLUME_HOME/lib/guava-*.jar && \
    cp $HADOOP_HOME/share/hadoop/common/lib/guava-*.jar $FLUME_HOME/lib/

RUN mkdir -p $FLUME_HOME/conf

WORKDIR $FLUME_HOME

COPY generator.py $FLUME_HOME/generator.py
COPY flume.conf.template $FLUME_HOME/flume.conf.template
COPY run.sh $FLUME_HOME/run.sh
RUN chmod +x $FLUME_HOME/run.sh

CMD ["/opt/flume/run.sh"]
