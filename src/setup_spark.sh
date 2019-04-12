cp $SPARK_HOME/conf/spark-env.sh.template $SPARK_HOME/conf/spark-env.sh

cat spark_config >> $SPARK_HOME/conf/spark-env.sh

cp spark-defaults.conf $SPARK_HOME/conf/
