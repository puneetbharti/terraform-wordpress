# Terraform-wordpress


##Objetive of the project 
* Using terraform setup the wordpress site end to end, including mysql database and also the nginx server.
* Setup nagios, a monitoring server 

###Tools Used 
* terraform (v0.10.2) 
* Ansible (2.3.1.0)

###Cloud Provider 
Amazon Web Services

### Platform 
Ubuntu 16

###Assumptions 
* AWS is used as a cloud provider
* Security is not considered, port 22 and 80 are opened to public
* Default VPC is used with subnets 
* Route53 has been used to assign a domain name to the servers.
* Scripts developed to create single wordpress and single monitoring server.
* Since it is just a small dev project so did not considered high availability and fault tolerance, for a good architecture we can have a discussion.
 
### Steps for local environment 
* Install terraform 
https://www.terraform.io/intro/getting-started/install.html 
* Install Ansible  http://docs.ansible.com/ansible/latest/intro_installation.html#basics-what-will-be-installed
https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-ubuntu-14-04
Set environment variable 
export ANSIBLE_HOST_KEY_CHECKING=False

### AWS Dependency 
Few things  like security groups and public subnets needs to be created before initialising the scripts. All values to be placed in “var.tf” file.

* Create one security group  with two ports opened.(80 and 22)
* An S3 Bucket to be created to upload terraform state.
* Create a subnet if not available
* AMI also needs to be updated on the variable.



### How to play with scripts 

* Wordpress Setup : Go to the instances directory 
	*	Initialise terraform 
		* ```terraform init ```

	* Plan before executing script 
		* ```terraform plan```   

	* Once everything is fine
		* ```terraform apply``` 

           Just wait for 2-3 min it will deploy wordpress site on a particular server.
	Orchestration: terraform 
            Installation & Configuration: Ansible

* Monitoring Setup: 
Nagios has been to as a monitoring server.

	* Go to nagios  directory 
		* Initialise terraform 
			* ```terraform init``` 

		* Plan before executing script 
			* ```terraform plan```   

		* Once everything is fine
			* ```terraform apply```
In 2-3 min server would be ready to use.







