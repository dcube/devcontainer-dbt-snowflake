#!/bin/bash

. "$TOOLS_DIR/color.sh"

echo -e "\n${BLUE}#############################################################${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#####              Configure dbt                        #####${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#############################################################${ENDCOLOR}"

echo -e "\n${GREEN}> Create local dbt profiles if not exists.${ENDCOLOR}\n"

# create profiles.yaml using .credentials.env
if [ ! -d /home/vscode/.dbt ]; then
    # Create the directory if it doesn't exist
    mkdir -p /home/vscode/.dbt
fi

# create the local profiles.yml if not exists
dbt_profile="/home/vscode/.dbt/profiles.yml"
if  [ ! -f "$dbt_profile" ]; then
    cat <<EOF > /home/vscode/.dbt/profiles.yml
default:
  target: default
  outputs:
    default:
      type: snowflake
      account: "$DBT_SF_ACCOUNT"
      user: "$DBT_SF_USER"
      authenticator: externalbrowser

      role: "$DBT_SF_ROLE"
      warehouse: "$DBT_SF_WAREHOUSE"
      database: "$DBT_SF_DATABASE"
      schema: "$DBT_SF_SCHEMA"

      threads: 8
      client_session_keep_alive: false

      connect_retries: 0
      connect_timeout: 10
      retry_on_database_errors: false
      retry_all: false
      reuse_connections: true

config:
  log_format: csv
EOF
fi

#install dbt dependencies
echo -e "\n${GREEN}> Install dbt dependencies.${ENDCOLOR}\n"
cd $DBT_DIR
dbt deps

cat <<EOF >> ~/.bashrc
cd $DBT_DIR
EOF

echo -e "\nDone\n"
