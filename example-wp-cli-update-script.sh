#!/bin/bash
printf "\n\n --== Magical WordPress Importer Script ==-- \n\n"
printf "\n\n ---- Copying database ---- \n\n"
cd /home/forge/example.com
ssh root@123.456.789.111 "cd /var/www/example.com > /dev/null&&wp --allow-root db export /tmp/the-old-wp-database.sql"
printf "\n\n ---- Moving the database to the new server ---\n\n"
scp root@123.456.789.111:/tmp/the-old-wp-database.sql /tmp/the-old-wp-database.sql
printf "\n\n ---- Importing database ---- \n\n"
wp --quiet db import /tmp/the-old-wp-database.sql
printf "\n\n ---- Replacing strings in database ----\n\n"
wp search-replace 'http://example.com' 'https://example.com'
rm /tmp/the-old-wp-database.sql
printf "\n\n--- Synchronising the uploads only --- \n\n"
rsync -r root@123.456.789.111:/var/www/example.com/wp-content/uploads /home/forge/example.com/wp-content/
