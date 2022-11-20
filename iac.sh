#! /usr/bin/env bash

# Author: João Paulo <ojpojao@gmail.com> <joaopaul93@gmail.com>
# Jornada DevOps com AWS - Impulso

GROUP_FOLDERS=("/publico" "/adm" "/ven" "/sec")
GROUPS_ADD=("GRP_ADM" "GRP_VEN" "GRP_SEC")
USERS_ADM=("carlos" "maria" "joao")
USERS_VEN=("debora" "sebastiana" "roberto")
USERS_SEC=("rogerio" "amanda" "josefina")
USERS_ADD=($USERS_ADM $USERS_VEN $USERS_SEC)
DEFAULT_PASS="Senha123"


if ! [ -x "$(command -v openssl &>/dev/null)" ]; then
    echo "Installing OpenSSL"
    export DEBIAN_FRONTEND=noninteractive
    apt update && apt install -y openssl --no-install-recommends &>/dev/null
fi

echo "Creating group folders..."
echo ""
for group_folder in ${GROUP_FOLDERS[@]}; do
    # echo $group_folder
    echo "mkdir -p $group_folder"
    mkdir -p $group_folder
done
echo ""

echo "Creating groups..."
for group in ${GROUPS_ADD[@]}; do
    echo "groupadd $group"
    groupadd $group
done
echo ""

echo "Adding users..."
for user in ${USERS_ADM[@]}; do
    # echo 'useradd "'$user'" -m -s /bin/bash -p "'$(openssl passwd -crypt ${DEFAULT_PASS})'"'
    useradd "'$user'" -m -s /bin/bash -p "'$(openssl passwd -crypt ${DEFAULT_PASS})'"
    echo 'User "'$user'" created.'
done

for user in ${USERS_VEN[@]}; do
    # echo 'useradd "'$user'" -m -s /bin/bash -p "'$(openssl passwd -crypt ${DEFAULT_PASS})'"'
    useradd "'$user'" -m -s /bin/bash -p "'$(openssl passwd -crypt ${DEFAULT_PASS})'"
    echo 'User "'$user'" created.'
done

for user in ${USERS_SEC[@]}; do
    # echo 'useradd "'${user}'" -m -s /bin/bash -p "'$(openssl passwd -crypt ${DEFAULT_PASS})'"'
    useradd "'$user'" -m -s /bin/bash -p "'$(openssl passwd -crypt ${DEFAULT_PASS})'"
    echo 'User "'$user'" created.'
done
echo ""

echo "chown root:GRP_ADM /adm"
chown root:GRP_ADM /adm
echo "chown root:GRP_VEN /ven"
chown root:GRP_VEN /ven
echo "chown root:GRP_SEC /sec"
chown root:GRP_SEC /sec

for folder in ${GROUP_FOLDERS[@]}; do
    if ! [ "${folder}" = "/publico" ]; then
        # echo 'chmod 770 "'${folder}'"'
        chmod 770 ${folder}
    else
        # echo "chmod 777 ${folder}"
        chmod 777 ${folder}
    fi
    echo 'Permissions to "'${folder}'": "'$(ls -ld ${folder})'"'
done
