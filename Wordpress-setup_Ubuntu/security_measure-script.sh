#!/bin/bash
# This script automates the process of updating you php config file with a randomiser that returns completely random keys each time it is opened.
#This step is important to ensure that your site is not vulnerable to “known secrets” attacks.
#Found in step 6 of [https://ubuntu.com/tutorials/install-and-configure-wordpress#6-configure-wordpress-to-connect-to-the-database](6-configure-wordpress-to-connect-to-the-database)

# Define the file where you need to replace the lines
TARGET_FILE="/srv/www/wordpress/wp-config.php"

# Define the URL to fetch the new content
SECRET_KEY_URL="https://api.wordpress.org/secret-key/1.1/salt/"

# Fetch the new content from the URL
NEW_CONTENT=$(curl -s $SECRET_KEY_URL)

# Check if the file exists
if [ ! -f "$TARGET_FILE" ]; then
  echo "File $TARGET_FILE does not exist."
  exit 1
fi

# Define the markers to identify the lines to be replaced
START_MARKER="define('AUTH_KEY',"
END_MARKER="define('NONCE_SALT',"

# Delete the lines between the markers and replace them with the new content
sed -i "/$START_MARKER/,/$END_MARKER/d" $TARGET_FILE
#sed -i "/$START_MARKER/i $NEW_CONTENT" $TARGET_FILE


echo "Secret keys deleted"
#echo "Secret keys updated successfully in $TARGET_FILE."

