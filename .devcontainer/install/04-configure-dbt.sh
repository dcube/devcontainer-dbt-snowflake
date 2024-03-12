#!/bin/bash

. "$WORKSPACE_PATH/.devcontainer/color.sh"

echo -e "\n${BLUE}#############################################################${ENDCOLOR}"
echo -e "${BLUE}#####     Configure dbt                                 #####${ENDCOLOR}"
echo -e "${BLUE}#############################################################${ENDCOLOR}"

# input for dbt snowflake user
echo -e "\n${GREEN}> Set dbt user from your upn.${ENDCOLOR}\n"
user_email=$(grep -oP 'export USER_EMAIL="\K[^"]+' ~/.bashrc)
if [ "$user_email" = "" ]; then
    . "$WORKSPACE_PATH/.devcontainer/install/02_connect_to_azure.sh"
fi
echo "export DBT_SF_USER=\"$user_email\"" >> ~/.bashrc

# input for dbt snowflake role
echo -e "\n${GREEN}> Set dbt context for your dev environment.${ENDCOLOR}\n"
if [ "$DBT_SF_ROLE" = "" ]; then
    while true; do
        echo -e "${YELLOW}Which snowflake role to use ?${ENDCOLOR}"
        read -p "> " sf_role
        if [ -z "$sf_role" ]; then
            echo -e "\n${RED}Snowflake role cannot be empty. Please enter a valid role.${ENDCOLOR}\n"
        else
            echo "export DBT_SF_ROLE=\"$sf_role\"" >> ~/.bashrc
            break
        fi
    done
fi

# input for dbt snowflake warehouse
if [ "$DBT_SF_WAREHOUSE" = "" ]; then
    while true; do
        echo -e "${YELLOW}Which snowflake warehouse to use ?${ENDCOLOR}"
        read -p "> " sf_warehouse
        if [ -z "$sf_warehouse" ]; then
            echo -e "\n${RED}Snowflake role cannot be empty. Please enter a valid role.${ENDCOLOR}\n"
        else
            echo "export DBT_SF_WAREHOUSE=\"$sf_warehouse\"" >> ~/.bashrc
            break
        fi
    done
fi

# input for dbt snowflake database
if [ "$DBT_SF_DATABASE" = "" ]; then
    while true; do
        echo -e "${YELLOW}Which snowflake database to use ?${ENDCOLOR}"
        read -p "> " sf_database
        if [ -z "$sf_database" ]; then
            echo -e "\n${RED}Snowflake database cannot be empty. Please enter a valid database.${ENDCOLOR}\n"
        else
            echo "export DBT_SF_DATABASE=\"$sf_database\"" >> ~/.bashrc
            break
        fi
    done
fi

# create profiles.yaml into .venv
dbt_profile="$WORKSPACE_PATH/.venv/profiles.yml"
if  [ ! -f "$dbt_profile" ]; then
    cat <<EOF > "$dbt_profile"
default:
  target: default
  outputs:
    default:
      type: snowflake
      account: "$DBT_SF_ACCOUNT"
      user: "$user_email"
      authenticator: externalbrowser

      role: "$sf_role"
      warehouse: "$sf_warehouse"
      database: "$sf_database"
      schema: "$DBT_SF_SCHEMA"

      threads: 8
      client_session_keep_alive: true

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
