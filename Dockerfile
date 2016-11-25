FROM java:8-jre

RUN mkdir /app
WORKDIR /app
RUN wget http://packages.confluent.io/archive/3.0/confluent-oss-3.0.1-2.11.tar.gz
RUN tar xfz confluent-oss-3.0.1-2.11.tar.gz
ENV CONFLUENT_HOME=/app/confluent-3.1.1

COPY target/scala-2.11/sqs-kafka-connect.jar /app
ENV CLASSPATH=/app/sqs-kafka-connect.jar
ENV PROJECT=sqs-kafka-connect-worker

WORKDIR /app/confluent-3.0.1/bin/
RUN ls -lR 

ENTRYPOINT ["./connect-distributed", "/app/confluent-3.0.1/etc/schema-registry/connect-avro-distributed.properties"]
