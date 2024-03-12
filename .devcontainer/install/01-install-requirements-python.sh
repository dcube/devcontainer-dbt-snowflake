#!/bin/bash

. "$WORKSPACE_PATH/.devcontainer/color.sh"

echo -e "\n${BLUE}#############################################################${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#####     Update pip / Identify dependency manager      #####${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#############################################################${ENDCOLOR}"

source $WORKSPACE_PATH/.venv/bin/activate

echo -e "\n${GREEN}> Update pip tool.${ENDCOLOR}\n"
pip install --upgrade pip
pip install -r $WORKSPACE_PATH/.devcontainer/requirements.txt