set /p AWS_TARGET=<target-host.txt
scp -i C:\Users\Falcao5\Downloads\bigdata-first-assignment-kp.pem ../remote/execute-mr-job.sh hadoop@%AWS_TARGET%:~
echo yes
