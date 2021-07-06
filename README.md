# my-terraform-tests
Setup of ubuntu 20.04 LTS host
==============================

Name resolving
--------------
$ resolvectl status\
$ cd /etc/systemd  
$ sudo vi resolved.conf\ 
$ sudo systemctl restart systemd-resolved

This is a VirtualBox VM, first nw interface is a NAT ( for accessing internet )
and second is HostOnly for ssh access. Add ip interface with fix address
---------------------------------
$ sudo nmcli conn down "Wired connection 2"
$ sudo nmcli conn mod "Wired connection 2" ipv4.addresses 192.168.56.27/24
$ sudo nmcli conn mod "Wired connection 2" ipv4.method manual
$ sudo nmcli conn up "Wired connection 2"

Inastall terraform
------------------
$ sudo apt-get update
$ sudo apt-get install gnupg software-properties-common curl
$ curl -fsSL https://apt.releaese.hashicorp.com/gpg | sudo apt-key add -
$ sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
$ sudo apt-get update
$ sudo apt-get install terraform
$ terraform version
$ terraform -install-autocomplete

Install aws client
------------------
$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
$ unzip awscliv2.zip 
$ sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin
$ aws --version
$ rm -rf ./aws
$ aws configure

Install git
-----------
$ sudo apt install git
$ git clone https://github.com/tomislak/learn-terraform-aws-instance.git

Start with terraform
--------------------
$ cd Technology/Terraform/learn-terraform-aws-instance/
$ vi main.tf
$ terraform init
$ terraform fmt
$ terraform validate
$ terraform apply
$ terraform show
$ terraform state list
$ terraform output
$ ssh ec2-user@3.65.20.2
$ terraform destroy


Get various aws staff
---------------------
$ aws ec2 describe-images     --owners amazon     --filters "Name=name,Values=amzn2-ami-hvm-2.0.????????.?-x86_64-gp2" "Name=state,Values=available"     --query "reverse(sort_by(Images, &Name))[:1].ImageId"     --output text
$ aws ec2 describe-images     --owners amazon     --filters "Name=state,Values=available" --output text

Install ansible
---------------
$ sudo apt install ansible
$ ansible --version

Ansible dynamic inventory
-------------------------
https://clarusway.com/ansible-working-with-dynamic-inventory-using-aws-ec2-plugin/
$ sudo pip3 install boto3
$ ansible-inventory --graph -i inventory_aws_ec2.yml
