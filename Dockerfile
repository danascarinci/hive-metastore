FROM openjdk:8u242-jre

WORKDIR /opt

ENV HADOOP_VERSION=3.3.2
ENV METASTORE_VERSION=3.0.0

ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HIVE_HOME=/opt/apache-hive-metastore-${METASTORE_VERSION}-bin


# Download hive and hadoop
RUN curl -L https://dlcdn.apache.org/hive/hive-standalone-metastore-${METASTORE_VERSION}/hive-standalone-metastore-${METASTORE_VERSION}-bin.tar.gz | tar zxf -
RUN curl -L https://dlcdn.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar zxf -

# Remove slf4j because it's duplicated
RUN rm hadoop-${HADOOP_VERSION}/share/hadoop/common/lib/slf4j-log4j12-1.7.30.jar

# Download Postgres driver
RUN curl -L https://jdbc.postgresql.org/download/postgresql-42.3.3.jar > ${HIVE_HOME}/lib/postgresql-42.3.3.jar


COPY scripts/entrypoint.sh /entrypoint.sh

RUN groupadd -r hive --gid=1000 && \
    useradd -r -g hive --uid=1000 -d ${HIVE_HOME} hive && \
    chown hive:hive -R ${HIVE_HOME} && \
    chown hive:hive /entrypoint.sh && chmod +x /entrypoint.sh

USER hive
EXPOSE 9083

ENTRYPOINT ["sh", "-c", "/entrypoint.sh"]
