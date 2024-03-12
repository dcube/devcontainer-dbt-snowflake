#!/bin/bash

. "$TOOLS_DIR/color.sh"

echo -e "\n${BLUE}#############################################################${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#####       VS Code extention installation              #####${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#############################################################${ENDCOLOR}"

# force dbt deps installation before installing vscode dbt extensions
cat <<EOF >> ~/.bashrc
# activate python venv
source $WORKSPACE_PATH/.venv/bin/activate

# setting the dbt project as the working dir
cd $WORKSPACE_PATH/src

# force reinstall vscode extensions for dbt
extensions=(
    "innoverio.vscode-dbt-power-user",
    "dorzey.vscode-sqlfluff"
)

# Uninstall the extension if it is installed
for extension in \${extensions[@]}; do
    if code --list-extensions | grep -q "\$extension"; then
        code --uninstall-extension "\$extension"
    fi
done

# execute dbt deps before installing dbt vscode extensions
dbt deps

# Reinstall the extension
for extension in \${extensions[@]}; do
    code --install-extension "\$extension"
done

EOF

echo -e "\nDone\n"
