#!/bin/bash
CT="Content-Type:application/json"
workers_list=( "9443" )
should_undeploy=()


for u in "${workers_list[@]}"  
do  
    TEST="curl -k -X GET https://10.11.254.240:32390/siddhi-apps?isActive=true  -H accept:application/json -u admin:admin -k"
    #echo $TEST
    RESPONSE=`$TEST`
    #echo $RESPONSE
    echo 'printing the size'
    
    LEN=${#RESPONSE[0]}
    
    if (($LEN > 2));
    then
      echo "There are Partial Siddhi Apps in the worker $u";
     
    else
      echo "There are no Partial Siddhi Apps in the worker $u";
      should_undeploy+=($u)
    fi
done  
echo "The workers that needed to be undeployed.............."
echo "${should_undeploy[*]}"
