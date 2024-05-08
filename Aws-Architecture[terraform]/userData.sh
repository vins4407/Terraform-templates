#!/bin/bash

# Update package list
sudo apt update

# Install Nginx
sudo apt install -y nginx

# Start Nginx
sudo systemctl start nginx

# Enable Nginx to start on boot
sudo systemctl enable nginx

# Open port 80 in the firewall (if needed)
sudo ufw allow 'Nginx HTTP'

# Modify default HTML page
sudo tee /var/www/html/index.html > /dev/null <<'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to my subnet 1 at uc-east-1a</title>
</head>
<body>
    <h1>Welcome to my Nginx server on EC2! Welcome to my subnet 1 at uc-east-1a</h1>
    <p>This is a default page modified by vinayak.</p>
</body>
</html>
EOF

# Restart Nginx to apply changes
sudo systemctl restart nginx

# Display Nginx status
sudo systemctl status nginx
