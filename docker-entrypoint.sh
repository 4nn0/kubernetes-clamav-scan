#!/bin/sh
while true
do
  if [ $(date +"%k") -eq $RUNHOUR ]
  then
    if [ -d $SCANDIR ]
    then
      freshclam --no-warnings
      # run scan with given scandir and excludes
      clamscan -ri $SCANDIR --exclude-dir=${SCANDIR}/proc --exclude-dir=${SCANDIR}/dev --exclude-dir=${SCANDIR}/sys
      # sleep 1h to prevent two runs within one hour
      sleep 3600
    else
      echo "Scan target ${SCANDIR}: no such file or directory"
      exit 1
    fi
  fi
  sleep 60
done
