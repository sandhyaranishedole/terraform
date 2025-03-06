resource "aws_instance" "test" {
  ami = "ami-0ddfba243cbee3768"
  instance_type="t2.micro"
   key_name = "mykey"
   availability_zone = "ap-south-1a"
   tags = {
     name="dev"

   }
  
}

  
