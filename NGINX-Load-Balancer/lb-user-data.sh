#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y
sudo systemctl enable nginx
sudo systemctl start nginx

car <<EOF | sudo tee /etc/nginx/nginx.conf
events{}

http {
    upstream app_servers {
        server 10.0.1.101:3000;
        server 10.0.1.102:3000;
    }
    
    server {
        listen 80;
        location / {
        proxy_pass http://app_servers;
        }
    }
}
EOF

sudo systemctl restart nginx
