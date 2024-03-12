#!/bin/bash

. "$TOOLS_DIR/color.sh"

echo -e "\n${BLUE}#############################################################${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#####         Configure virtual environment             #####${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#############################################################${ENDCOLOR}"

echo -e "\n${GREEN}> Configure virtual environment.${ENDCOLOR}\n"

sudo chgrp vscode $WORKSPACE_PATH/.venv
sudo chown vscode $WORKSPACE_PATH/.venv

python3 -m venv $WORKSPACE_PATH/.venv
PATH="$WORKSPACE_PATH/.venv/bin:$PATH"

mkdir -p $WORKSPACE_PATH/.venv/lib

echo -e "Done\n"
