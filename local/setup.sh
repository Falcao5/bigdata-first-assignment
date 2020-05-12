#!/bin/sh
if [ -z $HADOOP_HOME ]; then
	HADOOP_HOME=$HOME/hadoop-3.2.1
fi

echo "======================== I think that you hdfs installation is here: $HADOOP_HOME"

echo "************************ Stopping HDFS"
$HADOOP_HOME/sbin/stop-dfs.sh

# Formatting
echo "************************ Formatting"
$HADOOP_HOME/bin/hdfs namenode -format

# Starting HDFS
echo "************************ Starting HDFS"
$HADOOP_HOME/sbin/start-dfs.sh
jps

# Creating some dirs
echo "************************ Creating some dis in HDFS"
$HADOOP_HOME/bin/hdfs dfs -mkdir /user
$HADOOP_HOME/bin/hdfs dfs -mkdir /user/falcao5

# Dropping dataset in dfs
echo "************************ Dropping dataset in HDFS"
$HADOOP_HOME/bin/hdfs dfs -put /home/falcao5/bigdata-first-assignment/data/historical_stock_prices.csv /user/falcao5/historical_stock_prices.csv

# Preparing for hive

if [ -z $HIVE_HOME ]; then
	HIVE_HOME=$HOME/apache-hive-3.1.2-bin
fi
echo "======================== I think that your hive installation is here: $HIVE_HOME"

cd	# metastore_db directory will be created in the user folder (/home/<username>)

# Cleaning last metastore_db
echo "************************ Cleaning up last metastore_db"
rm -R metastore_db

# Initializing metastore_db
echo "************************ Creating a new metastore_db"
$HIVE_HOME/bin/schematool -dbType derby -initSchema

# Creating Hive's required directories in dfs
echo "************************ Creating some Hive's required dir in HDFS"
$HADOOP_HOME/bin/hdfs dfs -mkdir /tmp
$HADOOP_HOME/bin/hdfs dfs -mkdir /user
$HADOOP_HOME/bin/hdfs dfs -mkdir /user/hive
$HADOOP_HOME/bin/hdfs dfs -mkdir /user/hive/warehouse

# Permissions
echo "************************ Setting up permissions for Hive's required dirs in HDFS"
$HADOOP_HOME/bin/hdfs dfs -chmod g+w /tmp
$HADOOP_HOME/bin/hdfs dfs -chmod g+w /user/hive/warehouse
