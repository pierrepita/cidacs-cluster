mkdir /home/cluster/hdfs
mkdir /home/cluster/hdfs/name
mkdir /home/cluster/hdfs/data
mkdir /home/cluster/hdfs/tmp

sudo cp core-site.xml $HADOOP_PREFIX/etc/hadoop/core-site.xml
sudo cp hdfs-site.xml $HADOOP_PREFIX/etc/hadoop/hdfs-site.xml

