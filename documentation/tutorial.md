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
#### Hostname

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
#### Creating User
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
#### Setup Java
#### Configure Enviroment Variables

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


