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


