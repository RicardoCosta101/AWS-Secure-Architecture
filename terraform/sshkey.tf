#====================================================================================
# Generate rsa private key
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Store rsa private key as a sensitive file localy
resource "local_sensitive_file" "private_key" {
  filename        = "aws-sshkey.pem"
  content         = tls_private_key.key.private_key_pem
  file_permission = "0400"
}

#====================================================================================
# Push public key from rsa private key to AWS to put it later in EC2
resource "aws_key_pair" "key_pair" {
  key_name   = "qletourneur-sshkey"
  public_key = tls_private_key.key.public_key_openssh
}
