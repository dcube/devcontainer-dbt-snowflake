#!/bin/bash

. "$WORKSPACE_PATH/.devcontainer/color.sh"

echo -e "\n${BLUE}#############################################################${ENDCOLOR}"
echo -e "${BLUE}#####     Configure Git                                 #####${ENDCOLOR}"
echo -e "${BLUE}#############################################################${ENDCOLOR}"

echo -e "\n${GREEN}> Configure Git.${ENDCOLOR}\n"

# input user email
user_email=$(grep -oP 'export USER_EMAIL="\K[^"]+' ~/.bashrc)
if [ "$user_email" = "" ]; then
    . "$WORKSPACE_PATH/.devcontainer/install/01_set_your_email_for_sso.sh"
fi
echo "export GIT_EMAIL=\"$DBT_SF_USER\"" >> ~/.bashrc

# input git user name
if [ "$GIT_USERNAME" = "" ]; then
    while true; do
        echo -e "${YELLOW}Enter your git username:${ENDCOLOR}"
        read -p "> " git_name
        if [ -z "$git_name" ]; then
            echo -e "\n${RED}Your git username cannot be empty.${ENDCOLOR}\n"
        else
            echo "export GIT_USERNAME=\"$GIT_USERNAME\"" >> ~/.bashrc
            break
        fi
    done
fi

# export git conf bashrc
echo '
# Set git configurations
git config --global --add safe.directory "$WORKSPACE_PATH"
git config --global core.eol lf
git config --global core.autocrlf false
git config --global pull.rebase true
git config --global user.name "$GIT_USERNAME"
git config --global user.email "$GIT_EMAIL"
' >> ~/.bashrc

echo -e "Done"
