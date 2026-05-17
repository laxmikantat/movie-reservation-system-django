module "vpc" {
  source = "./modules/vpc"

  vpc_cidr        = var.vpc_cidr
  public_subnet_1 = var.subnet_1
  public_subnet_2 = var.subnet_2

  availability_zone_1 = "us-east-1a"
  availability_zone_2 = "us-east-1b"
}

module "security_group" {
  source = "./modules/security-group"

  vpc_id = module.vpc.vpc_id
}
resource "aws_key_pair" "deployer" {
  key_name   = "my-key"
  public_key = file("my-key.pub")
}

module "ec2" {
  source = "./modules/ec2"

  ami_id            = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = module.vpc.subnet_1_id
  security_group_id = module.security_group.security_group_id
  key_name          = aws_key_pair.deployer.key_name

  # FIX: Removed the stray "$" and wrapped in "${path.module}"
  user_data = file("${path.module}/scripts/script.sh")

}