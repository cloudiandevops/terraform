# Generate a key pair locally
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Save the private key locally
resource "local_file" "private_key" {
  filename = "./appserver.pem"
  content  = tls_private_key.key.private_key_pem
}

# Create AWS Key Pair
resource "aws_key_pair" "appserver" {
  key_name   = "appserver"
  public_key = tls_private_key.key.public_key_openssh
}
