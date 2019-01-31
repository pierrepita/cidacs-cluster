mkdir /home/cluster/hdfs
mkdir /home/cluster/hdfs/name
mkdir /home/cluster/hdfs/data
mkdir /home/cluster/hdfs/tmp

mv core-site.xml $HADOOP_PREFIX/etc/hadoop/core-site.xml
mv hdfs-site.xml $HADOOP_PREFIX/etc/hadoop/hdfs-site.xml

