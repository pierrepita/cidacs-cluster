# Operational System Optimizations for Clusters Spark

[Source](https://www.dezyre.com/article/how-to-ensure-best-performance-for-your-hadoop-cluster/200)

## Improving IO performance

1. Linux OS has a checkpoint for each file including checksum,
last accessed time, creation time, user who created the file, etc.
To achieve better IO performance, 
the checkpoint should be disabled in HDFS - as HDFS supports write-once-read-many times’ model.
The applications will be able to access the data on HDFS in a random fashion.
2. The mount points for DataNode or data directories
should be configured with the noatime option to ensure that the metadata
is not updated by the NameNode every time the data is accessed.
The mounts for MapReduce storage and DFS,
when mounted with noatime option,
deactivates access time tracking - rendering enhanced IO performance.
3. It is recommended not to use LVM and RAID on DataNode
or TaskTracker machines as it reduces performance.

### Set noatime for /hdfs partition

To disable the writing of access times,
you need to mount the filesystem(s) in question with the noatime option.

To mount an already mounted filesystem with the noatime option, do the following:

```mount /home -o remount,noatime```

To make the change permanent, update your /etc/fstab and add noatime to the options field.

For example.

Before:

```/dev/mapper/sys-home  /home  xfs  nodev,nosuid         0       2```

After:

```/dev/mapper/sys-home  /home  xfs  nodev,nosuid,noatime  0       2```

[Source](https://unix.stackexchange.com/questions/219015/how-to-disable-access-time-settings-in-debian-linux)

## OS Optimization for Cluster

[Source](https://community.hortonworks.com/articles/55637/operating-system-os-optimizations-for-better-clust.html)

1. Disable Transparent Huge Pages (THP)
2. Disable Host Swappiness
3. Improve Virtual Memory Usage
4. Configure CPUs for Performance Scaling
5. Tune SSD Configurations

## Increase "Open Files" limit

[Source](https://easyengine.io/tutorials/linux/increase-open-files-limit)

