addhosts() {
    if [ -z "$HOSTS" ]; then
       echo -n "Please provide of list of hosts separated by spaces [ENTER]: "
       read HOSTS
    fi
 
    local hosts=( $HOSTS )
 
    for i in "${hosts[@]}"; do
        ssh-keyscan -H $i >> ~/.ssh/known_hosts
    done
}
 
HOSTS=$1

addhosts
