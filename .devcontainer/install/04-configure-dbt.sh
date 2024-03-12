#!/bin/bash

. "$TOOLS_DIR/color.sh"

echo -e "\n${BLUE}#############################################################${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#####              Configure dbt                        #####${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#############################################################${ENDCOLOR}"

# create profiles.yaml into .venv using .credentials.env
dbt_profile="$WORKSPACE_PATH/.venv/profiles.yml"
if  [ ! -f "$dbt_profile" ]; then
    cat <<EOF > "$dbt_profile"
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

echo -e "Done"
