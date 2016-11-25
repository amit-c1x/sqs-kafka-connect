
if [ -z $CONFLUENT_HOME ]; then
  echo "CONFLUENT_HOME is unset, exiting."
  exit 1
fi

mv $CONFLUENT_HOME/etc/schema-registry/connect-avro-distributed.properties $CONFLUENT_HOME/etc/schema-registry/connect-avro-distributed.properties.original
cat $CONFLUENT_HOME/etc/schema-registry/connect-avro-distributed.properties.original | \
  sed s/bootstrap.servers=localhost:9092/bootstrap.servers=kafka:9092/g | \
  sed s/localhost:8081/schema_registry:8081/g \
  > $CONFLUENT_HOME/etc/schema-registry/connect-avro-distributed.properties