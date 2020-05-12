if [ -z $1 ]; then
	echo "What's the target host?"
fi

scp -i $HOME/bigdata-first-assignment-ubuntu.pem $HOME/bigdata-first-assignment/mapper.py hadoop@$1:~
scp -i $HOME/bigdata-first-assignment-ubuntu.pem $HOME/bigdata-first-assignment/reducer.py hadoop@$1:~
scp -i $HOME/bigdata-first-assignment-ubuntu.pem $HOME/bigdata-first-assignment/aws/remote/execute-mr-job.sh hadoop@$1:~
scp -i $HOME/bigdata-first-assignment-ubuntu.pem $HOME/bigdata-first-assignment/aws/remote/setup.sh hadoop@$1:~
scp -i $HOME/bigdata-first-assignment-ubuntu.pem $HOME/bigdata-first-assignment/aws/remote/clean_dfs.sh hadoop@$1:~
scp -i $HOME/bigdata-first-assignment-ubuntu.pem $HOME/bigdata-first-assignment/aws/remote/execute_4kk.sh hadoop@$1:~
scp -i $HOME/bigdata-first-assignment-ubuntu.pem $HOME/bigdata-first-assignment/aws/remote/execute_8kk.sh hadoop@$1:~
scp -i $HOME/bigdata-first-assignment-ubuntu.pem $HOME/bigdata-first-assignment/aws/remote/execute_12kk.sh hadoop@$1:~
scp -i $HOME/bigdata-first-assignment-ubuntu.pem $HOME/bigdata-first-assignment/aws/remote/execute_16kk.sh hadoop@$1:~
scp -i $HOME/bigdata-first-assignment-ubuntu.pem $HOME/bigdata-first-assignment/aws/remote/execute_full.sh hadoop@$1:~
