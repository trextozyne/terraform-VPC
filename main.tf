provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name: "${var.env_prefix}-vpc"
  }
}

module "myapp-subnet" {
  source = "./modules/subnet"
  subnet_cidr_block =  var.subnet_cidr_block
  avail_zone = var.avail_zone
  env_prefix = var.env_prefix
  vpc_id = aws_vpc.myapp-vpc.id
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
}

module "myapp-server" {
  source = "./modules/webserver"
  avail_zone = var.avail_zone
  env_prefix = var.env_prefix
  image_name = var.image_name
  instance_type = var.instance_type
  my_ip = var.my_ip
  private_key_location = var.private_key_location
  public_key_location = var.public_key_location
  script_location = var.script_location
  subnet_id = module.myapp-subnet.subnet.id
  vpc_id = aws_vpc.myapp-vpc.id
}

resource "aws_route_table_association" "a-trb-subnet" {
  subnet_id = module.myapp-subnet.subnet.id // aws_subnet.myapp-subnet-1.id
  route_table_id = module.myapp-subnet.default_route_table.id  //aws_route_table.myapp-route-table.id
}


