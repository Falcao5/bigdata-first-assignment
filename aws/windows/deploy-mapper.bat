set /p AWS_TARGET=<target-host.txt
scp -i C:\Users\Falcao5\Downloads\bigdata-first-assignment-kp.pem ../../mapper.py hadoop@%AWS_TARGET%:~
echo yes
