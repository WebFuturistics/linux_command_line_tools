#!/bin/bash
# Filename: db_seed_production.sh
# Description: Seed production database with preset data
#
# Codes:
# 64 - table not exist and aborting
# 65 - Laravel error during seeding
# TODO: need path rewriting and testing
source "$PWD/library/fs.sh"
source "$PWD/library/mysql/tables.sh"

laravelEnvFileLocation="$PWD/../../../.env"
laravelArtisanFile="$PWD/../../../artisan"

# 64 - if some table not exist
# 65 - if error while seeding
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

            declare -A tableSeeders
            tableSeeders=(
                ["admin_credentials"]="AdminsTable"
                ["supplier_credentials"]="SuppliersTable"
                ["contract_types"]="ContractTypesTable"
                ["payment_periods"]="PaymentPeriodsTable"
                ["payment_sequences"]="PaymentSequencesTable"
                ["payment_statuses"]="PaymentStatusesTable"
                ["product_types"]="ProductTypesTable"
                ["taxes"]="TaxesTable"
                ["product_templates"]="ProductTemplatesTable"
            )

            declare -a orders;

            orders+=("admin_credentials")
            orders+=("supplier_credentials")
            orders+=("contract_types")
            orders+=("payment_periods")
            orders+=("payment_sequences")
            orders+=("payment_statuses")
            orders+=("product_types")
            orders+=("taxes")
            orders+=("product_templates")

            for table in ${!orders[@]};
            do
                if checkIfTableExist ${laravelEnvParameters[DB_HOST]} ${laravelEnvParameters[DB_USERNAME]} ${laravelEnvParameters[DB_PASSWORD]} ${laravelEnvParameters[DB_DATABASE]} ${orders[$table]}
                then
                    if checkIfTableContainsRecords ${laravelEnvParameters[DB_HOST]} ${laravelEnvParameters[DB_USERNAME]} ${laravelEnvParameters[DB_PASSWORD]} ${laravelEnvParameters[DB_DATABASE]} ${orders[$table]}
                    then
                        echo "Skipping '${orders[$table]}' table..."
                    else
                        echo "Seeding '${orders[$table]}' table..."

                        if php $laravelArtisanFile db:seed --class="${tableSeeders[${orders[$table]}]}Seeder"
                        then
                            echo "Table '${tableSeeders[${orders[$table]}]}' seeded successfully..."
                        else
                            exit 65
                        fi
                    fi
                else
                    exit 64
                fi
            done
        }

        exit 0
else
    exit 1
fi