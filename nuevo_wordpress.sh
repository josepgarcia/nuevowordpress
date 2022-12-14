#!/bin/bash
mysqlbin="/Applications/MAMP/Library/bin/mysql"

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
echo "| WordPress Installer |"
echo "+---------------------+"
echo -e "${NC}"

printf '\n'
echo "Creating DB"
SQL_CREATE="CREATE DATABASE $DBNAME CHARACTER SET utf8 COLLATE utf8_general_ci;"
$mysqlbin -u $DBUSER -p$DBPASS -e $SQL_CREATE 2> /dev/null
echo -e "${GREEN}Done! ✅${NC}"
printf '\n'

mkdir $DIRNAME
cd $DIRNAME
printf '\n'
echo "Downloading the latest version of Wordpress... "
curl --remote-name --silent --show-error https://wordpress.org/latest.tar.gz
echo -e "${GREEN}Done! ✅${NC}"
printf '\n'

tar -zxvf latest.tar.gz
rm latest.tar.gz
mv wordpress/* .
rm -rf wordpress

printf '\n'
echo "Configuring WordPress... "
cp wp-config-sample.php wp-config.php
#set database details with perl find and replace
### PROVAR ESTOS
perl -pi -e "s/database_name_here/$DBNAME/g" wp-config.php
perl -pi -e "s/username_here/$DBUSER/g" wp-config.php
perl -pi -e "s/password_here/$DBPASS/g" wp-config.php
#sed -i "" "s/database_name_here/$DBNAME/g" wp-config.php
#sed -i "" "s/username_here/$DBUSER/g" wp-config.php
#sed -i "" "s/password_here/$DBPASS/g" wp-config.php
# sed -i "" "s/localhost/localhost/g" wp-config.php

#   Set authentication unique keys and salts in wp-config.php
perl -i -pe '
  BEGIN {
    @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
    push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
    sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
  }
  s/put your unique phrase here/salt()/ge
' wp-config.php

echo -e "${GREEN}Done! ✅${NC}"
printf '\n'

echo "Applying folder and file permissions... "
find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;
echo -e "${GREEN}Done! ✅${NC}"
printf '\n'

echo "Removing default WordPress plugins..."
rm -rf wp-content/plugins/akismet
rm -rf wp-content/plugins/hello.php
echo -e "${GREEN}Done! ✅${NC}"
printf '\n'

echo "Removing default WordPress themes..."
rm -rf wp-content/themes/twentyfifteen
rm -rf wp-content/themes/twentysixteen
rm -rf wp-content/themes/twentyseventeen
rm -rf wp-content/themes/twentynineteen
rm -rf wp-content/themes/twentytwenty
rm -rf wp-content/themes/twentytwentyone
rm -rf wp-content/themes/twentytwentythree
echo -e "${GREEN}Done! ✅${NC}"
printf '\n'

printf '\n'
echo -e "${GREEN}Fantastisch! All done 🙌${NC}";


