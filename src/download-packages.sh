cd packages

echo "Downloading Hadoop"
curl -LO https://archive.apache.org/dist/hadoop/common/hadoop-3.2.0/hadoop-3.2.0.tar.gz
echo "Downloading Spark"
curl -LO http://apache.mirrors.tds.net/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz
echo "Downloading Livy"
curl -LO http://archive.apache.org/dist/incubator/livy/0.5.0-incubating/livy-0.5.0-incubating-bin.zip
echo "Downloading Anaconda"
curl -LO https://repo.anaconda.com/archive/Anaconda3-2018.12-Linux-x86_64.sh
