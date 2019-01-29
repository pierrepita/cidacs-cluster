cd /opt/cluster_cidacs/packages

echo "Extracting packages..."
tar -xvzf tar -xvzf hadoop-3.2.0.tar.gz
tar -xvzf spark-2.4.0-bin-hadoop2.7.tgz
unzip livy-0.5.0-incubating-bin.zip
echo "Done."

echo "Moving folders to /opt"
sudo mv hadoop-3.2.0/ /opt/
sudo mv spark-2.4.0-bin-hadoop2.7/ /opt/
sudo mv livy-0.5.0-incubating-bin/ /opt/
cd /opt
sudo ln -s hadoop-3.2.0/ hadoop
sudo ln -s spark-2.4.0-bin-hadoop2.7/ spark
sudo ln -s livy-0.5.0-incubating-bin/ livy
echo "Done"

ls
