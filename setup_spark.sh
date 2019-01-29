cp $SPARK_HOME/conf/spark-env.sh.template $SPARK_HOME/conf/spark-env.sh

cat spark_config >> $SPARK_HOME/conf/spark-env.sh
