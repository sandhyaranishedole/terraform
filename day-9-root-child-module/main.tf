module "ec2" {
    source = "./modules/ec2"
    san = "ami-0ddfba243cbee3768"
    megha = "t2.micro"
    sa = "mykey"
  
}
module "s3_bucket" {
    source = "./modules/s3"
}
module "aws_rds_cluster" {
    source = "./modules/rds"
  
}