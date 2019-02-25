# CIDACS Cluster Documentation

## Index 

1. Network Access
2. User
3. Software Configuration
4. HDFS
5. Spark
6. Livy
7. Anaconda
8. Spark Magic


## Prerequisites

### Network Access

Prior to starting the cluster configuration we must check if:

1. All nodes of the cluster are in the same network;
2. Network ports related to HDFS, Spark and Livy are open;
3. SSH service is enabled and every the master node can connect to each slave node.

After these conditions are met,
we can proceed to the next step. 

#### Hostname

The first step is to name each machine in the cluster.
The following convention was used for naming the machine:
we used `nodeX` where X is the number of the machine assuming node1 is going to be the master node.
Then, we replace the content of `/etc/hostname` with the name chosen for the machine
(eg. we write node1 in ´/etc/hostname´ for the master node,
node2 for the second computer and so on)

#### Hosts File

When a DNS server is not available,
accessing one node from another by SSH is done by using the full IP address number.
One better option is to setup host names for each node.
Thus, the user can access the nodes by typing their host names,
which is easier for humans to deal with.
The following lines were added to the `/etc/hosts` file of each node:

```
172.16.5.15	node3
172.16.5.14	node2
172.16.5.25	node1
``` 

### User

In this tutorial we assume a standard name for the username used to access each server.
The standard name chosen was `cluster` and all the steps in this tutorial must be done using this user
(except those cases where sudo is needed).
This user does not need to have SU permisions,
but it must be able to become su through `sudo` command. 

#### Creating User

Creating the user is done using `adduser` command on a user with SU rights.
After adding the user `cluster` it is necessary to do a `passwd cluster` to setup the password.
To simplify the configuration, the same user and password should be used in every machine in the cluster.   

#### SSH Paswordless Login

One cluster is usually composed of several slave nodes
that are controlled by one master node.
In order to control the slaves,
the master has to have access by ssh to the slaves.
SSH normally requires a password to be typed in order to establish a connection.
Thus,
a configuration is set on the master node to enable it
to access the slaves without password requirement.
The following steps need to be followed to achieve passwordless ssh login:

1. Under the user cluster in the master node 
the bash command `ssh-keygen -t rsa` is used to create public and private keys.
Prompt will show a message asking for an address to store the keys.
Type enter to choose the default location.
2. The public needs to be transferred to the slave nodes through the following bash command:
`ssh-copy-id -i ~/.ssh/id_rsa.pub <node-hostname>`.

### Setting Up Softwares

For security infrastructure reasons,
the CIDACS cluster installation must be made offline.
In order to do that,
we need to download the packages and libraries needed to perform an offline installation.

The following section will address how to download such files in an online environment
to subsequently use them in the offline installation.
We will store the libraries under `/opt/cluster_cidacs/lib` folder
and the packages under `/opt/cluster_cidacs/packages` folder.
We will also create a `/opt/cluster_cidacs/bin` folder
that will contain the scripts created as a product of this documentation.

#### Download Packages

The first step before downloading the package
is to create the file structure where the files will be stored.

The following commands are used to create the folders:

```
sudo mkdir -p /opt/cluster_cidacs/{lib,packages,bin}
sudo chmod -R 777 /opt/cluster_cidacs
cd /opt/cluster_cidacs
```

Inside the `cluster_cidacs` folder use the following commands to download the softwares:

```
curl -LO https://archive.apache.org/dist/hadoop/common/hadoop-3.2.0/hadoop-3.2.0.tar.gz
curl -LO http://apache.mirrors.tds.net/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz
curl -LO http://archive.apache.org/dist/incubator/livy/0.5.0-incubating/livy-0.5.0-incubating-bin.zip
curl -LO https://repo.anaconda.com/archive/Anaconda2-5.3.1-Linux-x86.sh
``` 

Downloading libraries and dependencies:

```
repotrack -a x86_64 -p /opt/cluster_cidacs/repotrack-lib/ unzip bzip2 gcc python-devel krb5-devel krb5-workstation
```

NOTE:  repotrack will download any architectures compatible with the one specified `(x86_64)`. You should remove the i686 architecture files:

```
rm /opt/cluster_cidacs/lib/*i686.rpm
```

To install the downloaded packages:

```
sudo yum --disablerepo=* localinstall /opt/cluster_cidacs/lib/*.rpm
``` 

As the pip repository is already installed in the offline environment, to install the necessary pip packages:


```
# pip version used in this guide: 19.0.1
sudo pip install sparkmagic jupyterlab
```

##### Extract and Setup Folders

Once all files are downloaded and placed in `/opt/cluster_cidacs`
folder it is time to create the file structure necessary for the cluster to work.
A bash script has been created to deal with this step.
The script `setup_folders.sh` can be found in `/opt/cluster_cidacs/bin`.
It unpacks Spark, Hadoop and Livy, moves each folder to `/opt` and create three symbolic links,
one for each software folder.
The expected result is to have three symbolic links: `/opt/spark`, `/opt/livy`, and `/opt/hadoop`.

#### Setup Java

Hadoop, Livy and Spark are JVM based tools. 
They require java to work.
This documentation assumes Sun JDK is already installed in
every machine in the `/usr/lib/jvm/java` directory.

#### Configure Enviroment Variables

After placing each folder at its place,
a list of environment variables for binary and configuration
folders are added to the `bash_profile` file.
These variables are needed in order for the cluster to work.
They provide a unified way to find and call Spark/Hadoop/Livy binaries and configs.
The script `setup_env_var.sh` found in `/opt/cluster_cidacs/bin` appends the following lines to the `bash_profile` file:

```
export JAVA_HOME=/usr/lib/jvm/java
export HADOOP_PREFIX=/opt/hadoop                                                                          
export HADOOP_CONF_DIR=$HADOOP_PREFIX/etc/hadoop                                                          
export SPARK_HOME=/opt/spark                                                                              
export JAVA_LIBRARY_PATH=/opt/hadoop/lib/native                                                           
export LD_LIBRARY_PATH=/opt/hadoop/lib/native                                                             
PATH=$PATH:$HOME/.local/bin:$HOME/bin:$JAVA_HOME/bin:$HADOOP_PREFIXbin:$HADOOP_PREFIX/sbin:$SPARK_HOME/bi
n:$SPARK_HOME/sbin                                                                                        
export PATH
```

### HDFS

In order to HDFS to work
we need to setup a physical location where HDFS files will be stored
in the machine file system,
two XML files that control HDFS behavior,
and the slaves file which is used by the master to start the whole cluster automatically.

#### Create HDFS Folders

The HDFS folders are created using the  script `setup_hdfs.sh`.
The script creates the following folders:

```
mkdir /home/cluster/hdfs
mkdir /home/cluster/hdfs/name
mkdir /home/cluster/hdfs/data
mkdir /home/cluster/hdfs/tmp
```

#### Setup XML Files

We need to configure the `core-site.xml` file and the `hdfs-site.xml` file.
The `setup_hdfs.sh` script also take care of this part.
It appends the following configs to each file:

- `hdfs-site.xml`
```
<!-- FIXME: edit hadoop adress and tmp folder -->
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://node1:9000</value>
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/home/cluster/hdfs/tmp</value>
    </property>
    <property>
        <name>io.compression.codecs</name>
        <value>org.apache.hadoop.io.compress.SnappyCodec</value>
    </property>
</configuration>
``` 

- `core-site.xmk`
```
<configuration>
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>file:///home/cluster/hdfs/name</value>
    </property>
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>file:///home/cluster/hdfs/data</value>
    </property>
</configuration>
```

#### Setup Slaves

We need to add the network adress of all datanode machines to
`$HADOOP_PREFIX/etc/hadoop/slaves` file.
An example of the file for three machines would be:

```
node1
node2
node3
```
 
#### Format HDFS

Assuming `node1` as the master for HDFS
we need to run `$HADOOP_PREFIX/bin/hdfs namenode node1` to format the file system.

### Spark

To setup spark we need to change two files:
`spark-env.sh` and the slaves file.

#### Setup spark.env.sh file

We use the script `setup_spark.sh` from our repository to setup spark.
Note the conficurations in this script must change acording to each machine.
If the machines in your cluster have different hardware setups,
please adjust the script accordingly.

#### Setup Slaves

We need to adjust the slaves files for spark the same way we did for HDFS.
It can be done adding the network adresses to `$SPARK_HOME/conf/slaves`

### Livy

Livy is the software used to connect Jupyter notebook to Spark cluster.
We need to config the livy.conf file before starting the service.

#### Livy.conf

Assuming we are using `node1` as master,
we can use the `setup_livy.sh` script to configure livy.
The script will append the following line to `/opt/livy/conf/livy.conf`:

```
spark://node1:7077
```

### Anaconda

1. Download anaconda 3
2. Install in /opt/conda/anaconda
3. Add Bashrc manually `export PATH=/opt/anaconda/conda/bin:$PATH`
4. conda install -c conda-forge jupyterhub
5. Install kernels in `/usr/local/share/jupyter/kernels/`
6. Add configuration file for each user `.sparkmagic/config.json`
7. Add configuration for user impersonate in `core-site.xml`
8. Add configs for spark to work with Dynamic allocation

--- install anaconda for all users

#### Install Anaconda
#### Add Anaconda to system PATH
#### Setup Jupyter Labs Enviroment
#### Enable Passowrd Login

### IPython Kernel

#### Levels
#### Kernel File



