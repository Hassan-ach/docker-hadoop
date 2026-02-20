FROM bde2020/hadoop-base:2.0.0-hadoop3.2.1-java8

RUN sed -i s/deb.debian.org/archive.debian.org/g /etc/apt/sources.list && \
    sed -i 's|security.debian.org/debian-security|archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    sed -i '/stretch-updates/d' /etc/apt/sources.list

ENV SQOOP_VERSION=1.99.7
ENV SQOOP_HOME=/opt/sqoop
ENV PATH=$PATH:$SQOOP_HOME/bin

RUN apt-get update && \
    apt-get install -y --allow-unauthenticated wget tar bash && \
    rm -rf /var/lib/apt/lists/*

    RUN wget http://archive.apache.org/dist/sqoop/${SQOOP_VERSION}/sqoop-${SQOOP_VERSION}-bin-hadoop200.tar.gz && \
    tar -xvf sqoop-${SQOOP_VERSION}-bin-hadoop200.tar.gz && \
    mv sqoop-${SQOOP_VERSION}-bin-hadoop200 $SQOOP_HOME && \
    rm sqoop-${SQOOP_VERSION}-bin-hadoop200.tar.gz


RUN mkdir -p $SQOOP_HOME/lib/sqoop

ENV SQOOP_SERVER_EXTRA_LIB=$SQOOP_HOME/lib/sqoop
ENV MYSQL_JDBC_VERSION=8.3.0
RUN wget https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/${MYSQL_JDBC_VERSION}/mysql-connector-j-${MYSQL_JDBC_VERSION}.jar -P $SQOOP_HOME/lib/
RUN cp $SQOOP_HOME/lib/mysql-connector-j-${MYSQL_JDBC_VERSION}.jar $SQOOP_HOME/server/lib

RUN rm $SQOOP_HOME/tools/lib/guava-*.jar && cp $HADOOP_HOME/share/hadoop/common/lib/guava-*.jar $SQOOP_HOME/tools/lib
RUN rm $SQOOP_HOME/shell/lib/guava-*.jar && cp $HADOOP_HOME/share/hadoop/common/lib/guava-*.jar $SQOOP_HOME/shell/lib
RUN rm $SQOOP_HOME/server/lib/guava-*.jar && cp $HADOOP_HOME/share/hadoop/common/lib/guava-*.jar $SQOOP_HOME/server/lib

RUN mkdir -p /etc/hadoop && ln -s /etc/hadoop /etc/hadoop/conf

WORKDIR $SQOOP_HOME

COPY run.sh $SQOOP_HOME/run.sh
RUN chmod +x $SQOOP_HOME/run.sh

HEALTHCHECK CMD curl -f http://localhost:12000 || exit 1

EXPOSE 12000

CMD ["/opt/sqoop/run.sh"]
