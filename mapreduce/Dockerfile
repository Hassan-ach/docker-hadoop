FROM bde2020/hadoop-base:2.0.0-hadoop3.2.1-java8

RUN sed -i s/deb.debian.org/archive.debian.org/g /etc/apt/sources.list && \
    sed -i 's|security.debian.org/debian-security|archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    sed -i '/stretch-updates/d' /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y --allow-unauthenticated wget tar python3 python3-pip bash && \
    rm -rf /var/lib/apt/lists/*


WORKDIR /app

COPY *.py /app/
COPY run.sh /app/run.sh

RUN chmod +x /app/*.py /app/run.sh

CMD ["/app/run.sh"]
