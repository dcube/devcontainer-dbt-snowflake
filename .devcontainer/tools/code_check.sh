#!/bin/bash
cd $DBT_DIR

sqlfluff lint --dialect snowflake --templater jinja models
