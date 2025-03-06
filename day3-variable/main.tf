resource "aws_instance" "name" {
  ami = var.san
  instance_type=var.megha
   key_name = var.sa
  
}