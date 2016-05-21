#find Redis sentinel pid
ps -ef | grep redis-sentinel | grep -v grep | awk '{print $2}'

#find Redis Server pid
ps -ef | grep redis-server | grep -v grep | awk '{print $2}'