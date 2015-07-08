#!/bin/bash
#
# scanning host to add public key to the known_hosts file
# use like this :
#  ex) $ awk 'NR>1' hosts | xargs ./add_ssh_hosts.sh
#        skip first line -> passing all hosts to the script

addhosts() {
    if [ -z "$HOSTS" ]; then
       echo -n "Please provide of list of hosts separated by spaces [ENTER]: "
       read HOSTS
    fi
 
    local hosts=( $HOSTS )
 
    for i in "${hosts[@]}"; do
        ssh-keyscan -t rsa $i >> ~/.ssh/known_hosts
    done
}
 
HOSTS="$*"

addhosts
