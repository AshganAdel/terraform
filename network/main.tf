module "vpc" {
   source = "./modules/vpc"
   vpc_cidr = "10.42.0.0/16"
   vpc_name = "new_vpc"
}

module "subnet" {
   source = "./modules/subnet"
   public_cidr = "10.42.1.0/24"
   private_cidr = ["10.42.11.0/24","10.42.12.0/24"]
   public_name = "public_subnet"
   private_name = ["private_subnet-a","private_subnet-b"]
   vpc_id = module.vpc.vpc_id
}

module "nat" {
  source = "./modules/nat"
  public_subnet = module.subnet.public_subnet_id
}

module "igw" {
  source = "./modules/igw"
  vpc_id = module.vpc.vpc_id
}

module "route_table" {
  source = "./modules/route_table"
  private_subnet = module.subnet.private_subnet_id
  public_subnet = module.subnet.public_subnet_id
  nat_id = module.nat.nat_id
  vpc_id = module.vpc.vpc_id
  igw = module.igw.igw_id
}

