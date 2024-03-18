#====================================================================================
resource "local_file" "inventory-infra" {
  depends_on      = [aws_instance.main-proxy, aws_instance.main-reverseproxy, aws_instance.client1-web, aws_instance.client2-web]
  filename        = "ansible/inventory"
  file_permission = "0644"
  content         = <<EOF
[proxy]
${aws_instance.main-proxy.private_ip}

[reverseproxy]
${aws_instance.main-reverseproxy.private_ip}

[client1]
${aws_instance.client1-web.private_ip}

[client1:vars]
company_name="company1"

[client2]
${aws_instance.client2-web.private_ip}

[client2:vars]
company_name="company2"

[clients:children]
client1
client2

[servers:children]
proxy
reverseproxy
clients

[servers:vars]
ansible_user = admin
ansible_ssh_private_key_file = ../aws-sshkey.pem
ansible_ssh_common_args = "-o StrictHostKeyChecking=no"
EOF
}

#====================================================================================
resource "local_file" "reverse-config" {
  depends_on      = [aws_instance.main-proxy, aws_instance.main-reverseproxy, aws_instance.main-bastion, aws_instance.main-vpn, aws_instance.client1-web, aws_instance.client2-web]
  filename        = "ansible/roles/nginx/files/reverse-config"
  file_permission = "0644"
  content         = <<EOF
server {
    listen 80;
    server_name ${aws_instance.main-reverseproxy.public_ip};

    location /company1/ {
        proxy_pass http://${aws_instance.client1-web.private_ip}:80/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /company2/ {
        proxy_pass http://${aws_instance.client2-web.private_ip}:80/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
EOF
}