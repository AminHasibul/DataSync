
#!/usr/bin/env bash

#Get current date
NOW="$(date +'%m-%d-%Y_%H-%M')"

# Path to a temporary directory
DIR=./home/custodian/mongodb_daily_dump

# Path to the target dropbox directory
TARGET_DIR=/

# Name of the database
DB_URI=$1
DB_NAME=TlAnalytics

# Name of the compressed file
FILE="${DB_NAME}_${NOW}.tar.gz"

function mongodb_dump
{
  # Dump the database
  mongodump --uri $DB_URI -o $DIR

  if [ $? -eq 0 ]
  then
    echo "✅ MongoDB dump successful"
  else
    echo "🔴 MongoDB dump failed"
    exit 1
  fi

  # Compress
  tar -zcvf $FILE $DIR

  # Remove the temporary database dump directory
  rm -fr $DIR
}

mongodb_dump

fi
