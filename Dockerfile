ARG DBT_VERSION
FROM ghcr.io/dbt-labs/dbt-snowflake:${DBT_VERSION}

# Set environment variables
ENV DBT_APP_DIR=/dbt

# Install AZ CLI
RUN apt-get update && apt-get install -y curl

# Copy DBT project
COPY src $DBT_APP_DIR

# Set working dir
WORKDIR $DBT_APP_DIR
