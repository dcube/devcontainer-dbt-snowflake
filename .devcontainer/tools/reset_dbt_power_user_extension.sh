#bin/sh

. "$TOOLS_DIR/color.sh"

echo -e "\n${BLUE}#############################################################${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#####     Kill all processes which user Snowflake       #####${ENDCOLOR}"
echo -e "${BLUE}#####         externalbrowser loopback port             #####${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#############################################################${ENDCOLOR}"


# Check if the "innoverio.vscode-dbt-power-user" extension is installed and remove it
if code --list-extensions | grep -q "innoverio.vscode-dbt-power-user"; then
    # Uninstall the extension
    echo -e "\n${GREEN}> Uninstall extension "innoverio.vscode-dbt-power-user"\n"
    sudo code --uninstall-extension "innoverio.vscode-dbt-power-user"
fi
# remove the extension dir
extension_dir="$HOME/.vscode/extensions/$extension_id"
if [ -d "$extension_dir" ]; then
    echo -e "\n${GREEN}> remove $extension_dir\n"
    sudo rm -rf "$extension_dir"
    echo "Extension directory '$extension_dir' has been removed."
fi


# clean dbt and reinstall dependencies
echo -e "\n${GREEN}> clean dbt and reinstall dependencies\n"
cd $DBT_DIR
dbt clean
dbt deps

# install the "innoverio.vscode-dbt-power-user" extension
echo -e "\n${GREEN}> install code extension innoverio.vscode-dbt-power-user\n"
code --install-extension "innoverio.vscode-dbt-power-user"

echo -e "\nDone\n"
