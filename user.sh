#!/bin/bash
​
read -p "Enter your first name: " FIRST_NAME
read -p "Enter your last name: " LAST_NAME
read -s -p "Enter your password: " PASSWORD

USER_NAME_UPPER=`echo $FIRST_NAME | tr 'A-Z' 'a-z'`
CHECK_USER=`cat /etc/passwd |grep -w tia |awk -F":" '{print$1}'`

if [[ "$CHECK_USER" == "$USER_NAME_UPPER" ]]; then
    echo "The User $USER_NAME_UPPER exist."
    cat /etc/passwd |grep $USER_NAME_UPPER
    exit 0
else
    useradd $USER_NAME_UPPER
    # Set the password for the user
    echo "$USER_NAME_UPPER:$PASSWORD" | chpasswd
    echo "User $FIRST_NAME created with the provided password."

    mkdir -p /home/$USER_NAME_UPPER
    cd /home/$USER_NAME_UPPER 
   

    chown $USER_NAME_UPPER:$USER_NAME_UPPER /home/$USER_NAME_UPPER
    usermod -c "$FIRST_NAME $LAST_NAME" $USER_NAME_UPPER

    cat /etc/passwd |grep $USER_NAME_UPPER
    cat /etc/shadow |grep $USER_NAME_UPPER
    id $USER_NAME_UPPER
fi
