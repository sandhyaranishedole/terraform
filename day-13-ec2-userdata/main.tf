resource "aws_instance" "name" {
    ami = "ami-0d682f26195e9ec0f"
    instance_type = "t2.micro"
    key_name = "mykey"
    #availability_zone = "us-east-1a"
    user_data = file("test.sh")
}