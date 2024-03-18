#bin/sh

. "$TOOLS_DIR/color.sh"

echo -e "\n${BLUE}#############################################################${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#####     Kill all processes which user Snowflake       #####${ENDCOLOR}"
echo -e "${BLUE}#####         externalbrowser loopback port             #####${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#############################################################${ENDCOLOR}"

lsof -ti :57531 | while read -r pid; do
    if ps -p $pid -o comm= | grep -q '^python$'; then
        echo "Killing Python process with PID $pid"
        kill -9 $pid
    fi
done

echo -e "\nDone\n"