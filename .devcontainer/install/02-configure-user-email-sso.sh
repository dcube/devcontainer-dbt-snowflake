#!/bin/bash

. "$WORKSPACE_PATH/.devcontainer/color.sh"

echo -e "\n${BLUE}#############################################################${ENDCOLOR}"
echo -e "${BLUE}#####     Set your email address for SSO                #####${ENDCOLOR}"
echo -e "${BLUE}#############################################################${ENDCOLOR}"

# input user email
if [ "$USER_EMAIL" = "" ]; then
    while true; do
        echo -e "${YELLOW}What is your email work address ?${ENDCOLOR}"
        read -p "> " upn
        if [ -z "$upn" ]; then
            echo -e "\n${RED}Your email cannot be empty.${ENDCOLOR}\n"
        else
            echo "export USER_EMAIL=\"$upn\"" >> ~/.bashrc
            break
        fi
    done
fi