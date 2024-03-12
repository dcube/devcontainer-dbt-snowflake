#!/bin/bash

. "$WORKSPACE_PATH/.devcontainer/color.sh"

echo -e "\n${BLUE}#############################################################${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#####     VS Code extention installation                #####${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#############################################################${ENDCOLOR}"

# force dbt deps installation before installing vscode dbt extensions
echo "source $WORKSPACE_PATH/.venv/bin/activate" >> ~/.bashrc
echo "cd $WORKSPACE_PATH/src" >> ~/.bashrc
echo "dbt deps" >> ~/.bashrc

# Install dbt power user and sqlfluff extensions
echo "
if ! code --list-extensions | grep -q \"innoverio.vscode-dbt-power-user\"; then
    code --install-extension \"innoverio.vscode-dbt-power-user\"
fi" >> ~/.bashrc

echo "
if ! code --list-extensions | grep -q \"dorzey.vscode-sqlfluff\"; then
    code --install-extension \"dorzey.vscode-sqlfluff\"
fi" >> ~/.bashrc
