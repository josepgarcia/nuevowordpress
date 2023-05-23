#!/bin/bash
mysqlbin="/Applications/MAMP/Library/bin/mysql"

if ! [[ $# -eq 1 ]]; then
  echo 'Necesario 1 parámetro, nombre del proyecto'
  exit 1
fi

GREEN='\033[0;32m'
BLUE="\033[1;34m"
RED='\033[0;31m'
NC='\033[0m' # No Color

DIRNAME="wp$1"
DBNAME="wp_$1"
DBUSER="root"
DBPASS="root"

clear
echo -e "${BLUE}"
echo "+---------------------+"
echo "| Deleting Wordpress  |"
echo "+---------------------+"
echo -e "${NC}"

########### DATABASE
$mysqlbin -u $DBUSER -p$DBPASS -e "use $DBNAME;" 2> /dev/null
printf '\n'
echo "Removing DB"
if [[ $result -eq 0 ]]
then
  $mysqlbin -u $DBUSER -p$DBPASS -e "DROP DATABASE $DBNAME;" 2> /dev/null
  echo -e "${GREEN}Done! ✅${NC}"
else
  echo -e "${RED}La BD no existe ✅${NC}"
fi
printf '\n'
####################


########### FOLDER
printf '\n'
echo "Removing FOLDER"
if [[ ! -d $DIRNAME ]]; then
  echo -e "${RED}Folder does not exist ✅${NC}"
else
  rm -rf $DIRNAME 2> /dev/null
  echo -e "${GREEN}Done! ✅${NC}"
fi
printf '\n'
####################

