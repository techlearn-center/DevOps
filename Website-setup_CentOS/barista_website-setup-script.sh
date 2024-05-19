#!/bin/bash

echo " "
echo "Starting the deployment of Barista Cafe website..."
echo " "

# Install necessary packages
echo "Installing necessary packages..."
sudo yum install httpd wget unzip vim -y

# Start the httpd service
echo "Starting the httpd service..."
sudo systemctl start httpd

# Enable the httpd service to start on boot
echo "Enabling the httpd service to start on boot..."
sudo systemctl enable httpd

# Create a temporary directory for the website files
echo "Creating a temporary directory for the website files..."
sudo mkdir -p /tmp/barista

# Change to the temporary directory
echo "Changing to the temporary directory..."
cd /tmp/barista

# Download the Barista Cafe website template
echo "Downloading the Barista Cafe website template..."
sudo wget https://www.tooplate.com/zip-templates/2137_barista_cafe.zip

# Unzip the downloaded template
echo "Unzipping the downloaded template..."
sudo unzip -o 2137_barista_cafe.zip

# Copy the extracted files to the web server's root directory
echo "Copying the extracted files to the web server's root directory..."
sudo cp -r 2137_barista_cafe/* /var/www/html/

# Restart the httpd service to apply changes
echo "Restarting the httpd service to apply changes..."
sudo systemctl restart httpd

# Clean up by removing the temporary directory
echo "Cleaning up by removing the temporary directory..."
cd /tmp
sudo rm -rf /tmp/barista

echo " "
echo "Deployment of Barista Cafe website completed successfully."
echo " "
