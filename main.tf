module "Vpc" {
  source  = "./Vpc"
  project = "able-starlight-375707"
  name    = "projectvpc"

}


module "subnet_1" {
  source        = "./Subnet"
  name          = "management-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-east4"
  network       = module.Vpc.vpcID
}


module "subnet_2" {
  source        = "./Subnet"
  name          = "restricted-subnet"
  ip_cidr_range = "10.0.2.0/24"
  region        = "us-east4"
  network       = module.Vpc.vpcID
}

module "SSHfirewall" {
  source        = "./Firewall"
  project       = "able-starlight-375707"
  name          = "ssh-firewall"
  network       = module.Vpc.vpcID
  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  protocol      = "tcp"
  ports         = ["22"]
}


module "nat_getway" {
  source       = "./NatGateway"
  NatName      = "my-router-nat"
  RouterName   = "my-router"
  RouterRegion = module.subnet_1.subnetRegion
  network      = module.Vpc.vpcID
  SubName      = module.subnet_1.subnetName
}

module "ServiceAccount" {
  source   = "./ServiceAccount"
  roleName = "myRole"
  title    = "my role"
  permissions = ["resourcemanager.projects.get", "storage.buckets.get", "storage.buckets.list" , "storage.objects.get" , "storage.objects.list" , "container.deployments.get" , "container.deployments.create" , "container.deployments.list" , "container.services.list" , "container.services.get" , "container.services.create" , "container.clusters.list" , "container.clusters.getCredentials" , "container.clusters.get" , "container.pods.list" ,"container.nodes.list" ]
  serviceName = "project-sa"
  project = "able-starlight-375707"
}

module "Gke" {
  source = "./K8s"
  clusterName = "project-cluster"
  location = "us-east4-b"
  network = module.Vpc.vpcID
  subnetwork = module.subnet_2.subnetName
  node_locations = [ "us-east4-c" ]
  nodeName = "node-pool"
  cidr_block = "10.0.1.0/24"
  display_name = "managment-cidr-range"
  service_account = module.ServiceAccount.ServiceName
}

module "Priv_instance" {
  source = "./Instance"
  name = "private-instance"
  zone = "us-east4-a"
  file = "${file("./bash.sh")}"
  service_account = module.ServiceAccount.ServiceName
  image = "ubuntu-os-cloud/ubuntu-2204-lts"
  size = 20
  network = module.Vpc.vpcID
  subnetwork = module.subnet_1.subnetName
   
}