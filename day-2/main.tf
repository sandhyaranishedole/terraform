resource "aws_instance" "name" {
  ami = "ami-0ddfba243cbee3768"
  instance_type="t2.micro"
   key_name = "mykey"
  
}
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
}
   
terraform {
  backend "s3" {
    bucket = "ravirani"
    key    = "terrafrom.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-state-lock-dynamo" # DynamoDB table used for state locking, note: first run day-4-s3-dynamodb resource then day-4-state-remote-backend
    encrypt        = true  
  }
}


 