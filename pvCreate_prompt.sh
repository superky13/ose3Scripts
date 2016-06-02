#!/bin/bash

#Uncomment the following line to aid in debugging
#set -x

## Kyle R (kritchie@redhat.com)
## Create a persistent volume with user defined specs

echo " "
echo -e "########################################\n### Persistent Volume Creator Script ###\n########################################"
echo " "

## Prompt user for requisite variables
echo "Please enter the PV name (ex. myvolume):"
read volName

echo "Please enter the volume size (ex. 10Gi):"
read volSize

echo "Please enter the path to the nfs mounted share (ex. /mnt/nfs):"
read nfsPath

echo "Please enter the nfs server IP (ex. the OSE Master IP):"
read nfsServerIP

echo -e "{
 \"apiVersion\": \"v1\",
 \"kind\": \"PersistentVolume\",
 \"metadata\": {
 \"name\": \""$volName"\"
},
\"spec\": {
   \"capacity\": {
   \"storage\": \""$volSize"\"
   },
   \"accessModes\": [ \"ReadWriteOnce\" ],
   \"nfs\": {
      \"path\": \""$nfsPath"\",
      \"server\": \""$nfsServerIP"\"
   },
   \"persistentVolumeReclaimPolicy\": \"Recycle\"
   }
}" > /tmp/$volName.json
oc create -f /tmp/$volName.json
