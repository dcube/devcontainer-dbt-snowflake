# devcontainer-dbt-snowflake
Starter kit for all our dbt projects within vscode

# Prerequisites
On your local machine, you'll need:
- git client
- Visual Studio Code with decontainers extensions installed
- Docker Desktop installed and running with WSL2
- A snowflake account with SSO enabled

# Create the .credentials.env file
Before building the container (next step), you have to create the **.credential.env** into the **.devccontainer** folder.
The file must contain your Snowflake and git informations:

```bash
DBT_SF_ACCOUNT=<your snowflake account>
DBT_SF_WAREHOUSE=<the warehouse to use with dbt>
DBT_SF_DATABASE=<the database where dbt will write data>
DBT_SF_SCHEMA=<prefix for your database schemas>
DBT_SF_USER=<your email>
DBT_SF_ROLE=<the snowflake role you want to use >
GIT_USEREMAIL=$DBT_SF_USER
GIT_USERNAME=<your git username>
```

# Build the container
Now you are ready to build the container.

The installation will be completely finished when the following message will be displayed in the terminal **"You can close all terminal windows and reload the project".**

The steps to build the container are :
- Go to the "View" menu in the top bar.
- Select "Command Palette..." (or use the keyboard shortcut Ctrl+Shift+P).
- Type "Dev Containers: Rebuild Container" in the command palette search bar and select this option.

This step may take some time, depending on the complexity of your container and your internet connection speed. 😴

# Reload the project
After building the container, I recommend to reload your project.
- Go to the "View" menu in the top bar.
- Select "Command Palette..." (or use the keyboard shortcut Ctrl+Shift+P).
- Type "Developer: Reload Window" in the command palette search bar and select this option.
This will refresh the Visual Studio Code window with the changes made during the container rebuild.

# Play with dbt under vscode
By default our devcontainer for dbt-snowflake comes from:
- dbt power user extension and sqlfluff
- we also have include the dbt_utils package

To play with dbt, you just need to execute your dbt commands under a terminal bash or use the dbt power user extension

# dbt models folders
We recommend to use a medaillon architecture with a data mesh approach.
You should have at least one dbt project by data domain, each in a dedicated git repo.
Data products under a data domain should be organized under a folder topography like this:

- 0_feeds: layer which contains the defintion of your data sources. Each data source must be defined in its own yaml file to ease metadata management and reduce Pull Requests conflicts.

- 1_silver: layer which contains all aggregated data products. Each data product is materialized by a specific schema under the silver database. The data products must me stored in a specific dbt folder.
~~~yaml
+ silver
  -core_data_model_1
  -core_data_model_2
~~~

- 2_gold: layer which contains all consumer-aligned data products. Each data product is materialized by a specific schema under the silver database. The data products must me stored in a specific dbt folder.
~~~yaml
+ gold
  -mart_1
  -mart_2
~~~

For silver and gold data products, you can use the following folders:
- stage: for temporary models that don't need to persist onto your data platform. You should choose the **ephemeral** materialization for those objects
- refined: for models that are refined and need to persist on your data plateforme. You can choose between **table** or **incremental** materialization depending on the size of data
- output: if you want to expose some sort of semantic model on top of your refined data. For those models you should choose the **view** materialization

# Learn about dbt
**Resources:**
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
- dbt power user [user guide](https://github.com/AltimateAI/vscode-dbt-power-user#HOW-TO-SETUP-THE-EXTENSION)
- sqlfluff [doc](https://github.com/sqlfluff/sqlfluff)
-
# Known issues
- Sometines when running dbt command you will get the error:
~~~bash
Database error while listing schemas in database "<your database>"
  Database Error
    [Errno 98] Address already in use
~~~
Because of using Snowflake externalbrowser auth mecanisms, we should have been forced to specifyed the loopback port forwarding when connecting to snowflake via the external browser, cf. devcontainer.json file **remoteEnv** and **forwardPorts** sections.
To kill all processes concurrently using port 557351, you simply need to execute the command:
~~~bash
$TOOLS_DIR/kill_pid_listening_lpbck.sh
~~~
