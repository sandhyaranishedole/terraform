resource "aws_instance" "test" {
ami = "ami-0ddfba243cbee3768"
instance_type = "t2.micro"
key_name = "mykey"
tags = {
  Name="ec2"
}
   }
  
