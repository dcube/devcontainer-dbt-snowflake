#!/bin/bash

. "$TOOLS_DIR/color.sh"

echo -e "\n${BLUE}#############################################################${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#####            Configure VSCode tools                 #####${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#############################################################${ENDCOLOR}"

UTILS_DIRECTORY="/usr/local/py-utils/bin"

echo -e "\n${GREEN}> Configure binaries used by VSCode (linters, formatters, etc.).${ENDCOLOR}\n"

mkdir -p "$HOME/.local/"

if [ -e "$HOME/.local/lib" ];
then
    rm -rf "$HOME/.local/lib"
fi

ln -s "$WORKSPACE_PATH/.venv/lib" "$HOME/.local/lib"

binaries=$(ls "$UTILS_DIRECTORY")

for binary in $binaries; do

    if  [ -x "$WORKSPACE_PATH/.venv/bin/$binary" ]; then
        echo "Create symbolic link for '$binary'."
        rm "$UTILS_DIRECTORY/$binary"
        ln -s "$WORKSPACE_PATH/.venv/bin/$binary" "$UTILS_DIRECTORY/$binary"
    fi

done

echo -e "\nDone\n"
