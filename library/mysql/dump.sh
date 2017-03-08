#!/bin/bash
# Filename: mysql.sh
# Description: MySQL dump related functions

# Function that creates mysql dump file in the corresponding directory
#
# @access public
#
# @param string $1 path to directory where dump will be crated
# @param string $2 database host
# @param string $3 database user
# @param string $4 database password
# @param string $5 database name
#
# @return number 0 if dump was is created successfully and 64 if not
#

function createMySQLDBDump()
{
    fileName="$1/$(date +'%s').sql"

    if checkIfDirectoryExist Dump $1
    then
        if checkIfDirectoryIsWritable Dump $1
        then
            mysqldump --host=$2 --user=$3 --password=$4 --databases $5 >> $fileName
            echo "Dump $fileName created successfully..."
            return 0
        else
            echo "Cannot create dump..."
            return 64
        fi
    else
        if makeDirectory Dump $1
        then
            mysqldump --host=$2 --user=$3 --password=$4 --databases $5 >> $fileName
            echo "Dump $fileName created successfully..."
            return 0
        else
            echo "Cannot create dump..."
            return 64
        fi
    fi
}