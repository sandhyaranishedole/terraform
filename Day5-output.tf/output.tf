output "ip" {
   value = [ aws_instance.test.public_ip , aws_instance.test.availability_zone,aws_instance.test.private_ip]
  
}
