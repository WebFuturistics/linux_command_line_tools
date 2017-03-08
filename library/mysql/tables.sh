#!/bin/bash
# Filename: mysql.sh
# Description: MySQL tables related functions

# Function that checks whether table exist in current database
#
# @access public
#
# @param string $1 database host
# @param string $2 database user
# @param string $3 database password
# @param string $4 database name
# @param string $5 table
#
# @return number 0 if table exist and 64 if not
#

function checkIfTableExist()
{
    echo "Checking if '$5' table exist..."

    mysqlResult=$(mysql -h $1 -u $2 -p$3 -D $4 <<-EOF

    SHOW TABLES LIKE '$5';

EOF
)

    if [ "$mysqlResult" == "" ];
    then
        echo "Table '$5' not exist..."
        return 64
    else
        echo "Table '$5' exist..."
        return 0
    fi
}

# Function that checks whether table contains any records or not
#
# @access public
#
# @param string $1 database host
# @param string $2 database user
# @param string $3 database password
# @param string $4 database name
# @param string $5 table
#
# @return number 0 if table contains records and 64 if not
#

function checkIfTableContainsRecords()
{
    echo "Checking if table '$5' contains records..."

    mysqlResult=$(mysql -h $1 -u $2 -p$3 -D $4 <<-EOF

    SELECT COUNT(*) AS '' FROM $5;

EOF
)
    mysqlResult=$(echo $mysqlResult|tr -d '\n')

    if [ "$mysqlResult" != "0" ] && [ "$mysqlResult" != "" ];
    then
        echo "Table '$5' contains records..."
        return 0
    else
        echo "Table '$5' does not contain records..."
        return 64
    fi
}