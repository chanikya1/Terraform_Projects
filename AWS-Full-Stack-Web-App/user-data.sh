#!/bin/bash

sudo apt update -y
sudo apt install -y nginx

echo "<h1>Hello from EC2</h1>" | sudo tee /var/www/html/index.html

sudo systemctl enable nginx
sudo systemctl start nginx