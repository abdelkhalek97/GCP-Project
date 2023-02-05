module "Vpc" {
    source = "./Vpc"
    project = "able-starlight-375707"
    name = "projectvpc"
  
}


module "subnet_1" {
  source = "./Subnet"
  name = "management-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region = "us-east4"
  network = module.Vpc.vpcID
}


module "subnet_2" {
  source = "./Subnet"
  name = "restricted-subnet"
  ip_cidr_range = "10.0.2.0/24"
  region = "us-east4"
  network = module.Vpc.vpcID
}

module "SSHfirewall" {
  source = "./Firewall"
  project = "able-starlight-375707"
  name = "ssh-firewall"
  network = module.Vpc.vpcID
  direction = "INGRESS"
  source_ranges = [ "0.0.0.0/0" ]
  protocol = "tcp"
  ports = ["22"]
}


module "nat_getway" {
  source = "./NatGateway"
  NatName = "my-router-nat"
  RouterName = "my-router"
  RouterRegion = module.subnet_1.subnetRegion
  network = module.Vpc.vpcID
  SubName = module.subnet_1.subnetName
}