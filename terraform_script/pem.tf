resource "tls_private_key" "pk" {
 # count = var.create_pemkey=="YES" ? 1:0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
 # count = var.create_pemkey=="YES" ? 1:0
  key_name   = var.PemkeyName
  public_key = tls_private_key.pk.public_key_openssh
 # provisioner "local-exec" { # Create a "myKey.pem" to your computer!!
 #   command = "echo '${tls_private_key.pk.private_key_pem}' > ../Cassandra-Setup-Using-Ansible/sample-testing.pem"
 # }
}

resource "local_file" "ssh_key" {
#  count = var.create_pemkey=="YES" ? 1:0
  filename = "../${aws_key_pair.generated_key.key_name}.pem"
  content = tls_private_key.pk.private_key_pem
}
