#!/bin/bash
mysqlbin="/Applications/MAMP/Library/bin/mysql"

# GIST: https://gist.github.com/bgallagh3r/2853221

#export red="\033[1;31m"
#export green="\033[1;32m"
#export yellow="\033[1;33m"
#export blue="\033[1;34m"
#export purple="\033[1;35m"
#export cyan="\033[1;36m"
#export grey="\033[0;37m"
#export reset="\033[m"

GREEN='\033[0;32m'
BLUE="\033[1;34m"
NC='\033[0m' # No Color

if ! [[ $# -eq 1 ]]; then
  echo 'Necesario 1 parámetro, nombre del proyecto'
  exit 1
fi

DIRNAME="wp$1"
DBNAME="wp_$1"
DBUSER="root"
DBPASS="root"

clear
echo -e "${BLUE}"
echo "+---------------------+"
echo "|      CREATE DB      |"
echo "+---------------------+"
echo -e "${NC}"

printf '\n'
$mysqlbin -u $DBUSER -p$DBPASS -e "CREATE DATABASE $DBNAME CHARACTER SET utf8 COLLATE utf8_general_ci;" 2> /dev/null
echo -e "${GREEN}Done! ✅${NC}"
printf '\n'

mkdir $DIRNAME
printf '\n'
#curl --remote-name --silent --show-error https://wordpress.org/latest.tar.gz
## IF ERROR 
echo -e "${GREEN}Done! ✅${NC}"
printf '\n'

printf '\n'
echo -e "${GREEN}Fantastisch! All done 🙌${NC}";
printf '\n'
printf '\n'

cd $DIRNAME

