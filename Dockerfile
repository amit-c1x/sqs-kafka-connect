FROM java:8-jre

RUN mkdir /app
WORKDIR /app
RUN wget http://packages.confluent.io/archive/3.0/confluent-oss-3.0.1-2.11.tar.gz
RUN tar xfz confluent-oss-3.0.1-2.11.tar.gz
ENV CONFLUENT_HOME=/app/confluent-3.0.1

COPY target/scala-2.11/sqs-kafka-connect.jar /app
ENV CLASSPATH=/app/sqs-kafka-connect.jar
ENV PROJECT=sqs-kafka-connect-worker

WORKDIR $CONFLUENT_HOME
COPY prepare_config.sh .
RUN ./prepare_config.sh
RUN cat $CONFLUENT_HOME/etc/schema-registry/connect-avro-distributed.properties

ENTRYPOINT ["./bin/connect-distributed", "./etc/schema-registry/connect-avro-distributed.properties"]
