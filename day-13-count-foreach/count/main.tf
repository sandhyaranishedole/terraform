# resource "aws_instance" "name" {
#     ami = "ami-085ad6ae776d8f09c"
#     instance_type = "t2.micro"
#     key_name = "ec2test"
#     availability_zone = "us-east-1a"
#     count = 2
#     # tags = {
#     #   Name = "dev"   two resource will create on same name 
#     # }
#     tags = {
#       Name = "dev-${count.index}"
#     }
   
   
  
# }
############################### Example-2 Different names #############
variable "env" {
  type    = list(string)
  default = [ "dev", "prod"]
}

resource "aws_instance" "name" {
    ami = "ami-0ddfba243cbee3768"
    instance_type = "t2.micro"
    key_name = "mykey"
    availability_zone = "us-east-1a"
    count = length(var.env)

    tags = {
      Name = var.env[count.index]
    }
}

# example-2 with variables list of string 


#example-3 creating IAM users 
# variable "user_names" {
#   description = "IAM usernames"
#   type        = list(string)
#   default     = ["user1", "user2", "user3"]
# }
# resource "aws_iam_user" "example" {
#   count = length(var.user_names)
#   name  = var.user_names[count.index]
# }