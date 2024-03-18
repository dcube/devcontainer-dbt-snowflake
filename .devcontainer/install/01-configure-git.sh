#!/bin/bash

. "$TOOLS_DIR/color.sh"

echo -e "\n${BLUE}#############################################################${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#####              Configure Git                        #####${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#############################################################${ENDCOLOR}"

echo -e "\n${GREEN}> Configure Git.${ENDCOLOR}\n"

# export git config to bashrc
cat <<EOF >> ~/.bashrc
# Set git configurations
git config --global --add safe.directory "$WORKSPACE_PATH"
git config --global core.eol lf
git config --global core.autocrlf false
git config --global pull.rebase true
git config --global user.email "$GIT_USEREMAIL"
git config --global user.name "$GIT_USERNAME"
EOF

echo -e "\nDone\n"
