#bin/sh

echo -e "\n${BLUE}#############################################################${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#####     Kill all processes which user Snowflake       #####${ENDCOLOR}"
echo -e "${BLUE}#####         externalbrowser loopback port             #####${ENDCOLOR}"
echo -e "${BLUE}#####                                                   #####${ENDCOLOR}"
echo -e "${BLUE}#############################################################${ENDCOLOR}"

sudo lsof -t -i :57531
sudo lsof -t -i :57531 | xargs -r sudo kill -9

echo -e "\nDone\n"
