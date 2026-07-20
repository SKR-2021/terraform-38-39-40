### Terraform AWS VPC Module
This module creates the following resources:-

* VPC
* IGW
* 2 Public Subnets in us-east-1a & us-east-1b
* 2 Private Subnets in us-east-1a & us-east-1b
* 2 Database Subnets in us-east-1a & us-east-1b
* Public Route table
* Private Route table
* Database Route table
* EIP for NAT
* NAT Gateway created using public subnet 1a az
* IGW route is added to public route table
* NAT Gateway routed to private & database subnets in routetable(Private_rt) 
* Routetable association with subnets 
* VPC to Default VPC Peering
* Public RT to Default VPC Route
* Deafult VPC main route table to create VPC Route

### Inputs
* vpc_cidr - (required) user must provide cidr for VPC.
* project_name - (required) user must provide the project name.