# Create a system with a loadbalancer and set of virtual machines

## Requirement

The code should accomplish the following:

- Provision a load-balancer with a public IP and at-least 2 virtual machines
- Each of the virtual machines should listen to port 8222
- The load-balancer will receive request from a port range, ranging from 8222 and incrementing by one
- The request coming to any port, say 8224, will forwarded to one of the VMs (say vm-3), dedicated for the port.

## Solutioning

The code is broken down into modules.
- nsg_vnet. This module is to setup network security group and Vnet provisioning.
- Loadbalancer. This module is to setup the load-balancer and public IP. The NAT rules, backend-pool are also setup
- main module. This module creates the virtual machines and associates the same with the loadbalancer.

## Steps to execute

- Create a service-principal (SPN) and assign Contributor role on the resource group
- Replace the SPN ID, Secret, Tenant Id and Subscription Id in Provider
- Execute: terraform init for the first time
- Execute: terraform plan -var-file="auto.tfvars"
- Execute: terraform apply -var-file="auto.tfvars"
- Execute: terraform destroy -var-file="auto.tfvars"
