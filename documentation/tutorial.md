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

### Config Softwares
#### Download Packages

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
#### Create HDFS Folders
#### Setup XML Files
#### Setup Slaves
#### Format HDFS


### Spark
#### Setup spark.env.sh file
#### Setup Slaves

### Livy
#### Livy.conf

### Anaconda
#### Install Anaconda
#### Add Anaconda to system PATH
#### Setup Jupyter Labs Enviroment
#### Enable Passowrd Login


