#!/bin/bash
. "$TOOLS_DIR/color.sh"
cd "$WORKSPACE_PATH/.devcontainer/install"

CONTAINER_TYPE=$(jq -r '.customizations.vscode.settings."container.type"' $WORKSPACE_PATH/.devcontainer/devcontainer.json);
echo -e "\n${BLUE}You are about to initiate a project '${YELLOW}$CONTAINER_TYPE${BLUE}'.${ENDCOLOR}"

if [ ]; then
    echo -e "\n💥 ${RED}Installation was aborted. Specified container type '$CONTAINER_TYPE' is not supported.${ENDCOLOR}💥\n"
    exit 1
fi

install_files=()

while IFS= read -r -d $'\0' current_file ; do
    if ! grep -q "# ignored: $CONTAINER_TYPE" "$current_file"; then
        install_files+=("$current_file")
    fi
done < <(find ./ -type f -name "*.sh" -print0)

install_files=($(printf "%s\n" "${install_files[@]}" | sort))

echo -e "${BLUE}We have found ${YELLOW}${#install_files[@]}${BLUE} installation files.${ENDCOLOR}"

for install_file in "${install_files[@]}"; do
    if [ -f "$install_file" ]; then

        echo -e "\n\e[104m Execute: $install_file \e[49m"

        if [ ! -x "$install_file" ]; then
            chmod +x "$install_file"
        fi

        ./"$install_file"

        if [ "$?" -ge 1 ]; then
            echo -e "\n💥 ${RED}Installation was aborted. Check the errors displayed above.${ENDCOLOR}💥\n"
            exit 1
        #else # uncomment to ease debug
            #echo -e "${YELLOW}... Press any key to continue ..."
            #read -s -p " " -n 1 -r
            #echo -e "${ENDCOLOR}"
        fi

    fi
done

echo -e "🎉 ${YELLOW}Installation is finished!${ENDCOLOR}"
echo -e "🎉 ${YELLOW}You can close all terminal windows and reload the project!${ENDCOLOR}\n"
