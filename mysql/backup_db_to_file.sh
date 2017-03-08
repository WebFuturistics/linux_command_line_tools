#!/bin/bash -x
# Filename: backup_db_to_file.sh
# Description: Backups project database
#
# Codes:
# 64 - dump not created
# TODO: need path rewriting and testing
source "$PWD/library/fs.sh"
source "$PWD/library/mysql/dump.sh"

laravelEnvFileLocation="$PWD/../../../.env"
dumpDirectoryLocation="$PWD/../../../storage/db_dumps"

if  checkIfFileExist '.env' $1  &&  checkIfFileReadable '.env' $1
then
    declare -A laravelEnvParameters

    oldIFSValue=$IFS
    IFS='='

    cat $laravelEnvFileLocation |
        {
            while read key value; do
                if [ "$key" == "" ]; then
                    continue
                fi

                laravelEnvParameters+=([$key]=$value)
            done

            IFS=$oldIFSValue

            if createMySQLDBDump $dumpDirectoryLocation ${laravelEnvParameters[DB_HOST]} ${laravelEnvParameters[DB_USERNAME]} ${laravelEnvParameters[DB_PASSWORD]} ${laravelEnvParameters[DB_DATABASE]}
            then
                exit 0
            else
                exit 64
            fi
        }

        exit 0
else
    exit 64
fi