# my-terraform-tests

This is a simple app, consists of one reverse proxy ( nginx ) in front of
several httpd servers ( number is defined in variable.tf -> instance_count ),
which serve simple python app. App prints its current host name and datetime
and store this to postgreSQL database. Retrive last 10 rows from posrgreSQL 
and print them on web page. 

It use terraform to create VM's on AWS and ansible to configure services on them.

Procedure for creating environment on AWS:\
0. init terraform:\
	my-terraform-tests$ terraform init

1. run terraform to create VM's on AWS\
	my-terraform-tests$ terraform apply\
		( answer wth yes to create VM's )

2. change to ansible directory:\
	my-terraform-tests$ cd ansible

3. run playbook for db server:\
	ansible$ ansible-playbook playbooks/dbServerSetup.yaml

4. run playbook for app servers:\
	ansible$ ansible-playbook playbooks/appServersSetup.yaml

5. run playbook for proxy server:\
	ansible$ ansible-playbook playbooks/proxyServerSetup.yaml

6. change back to terraform dir to find proxy public ip address:\
	ansible$ cd ..\
	my-terraform-tests$ terraform output \
	...\
	instance_proxy_public_ip = [\
	  "3.66.221.203",\
	]

7. go to:\
	http://3.66.221.203/hostDate
   and hit reload couple of times, you should see similar output:

		ip-172-31-11-126.eu-central-1.compute.internal 2021-07-13T08:53:06.961878

		(14, 'ip-172-31-11-126.eu-central-1.compute.internal', '2021-07-13T08:53:07.378968')

		(13, 'ip-172-31-3-208.eu-central-1.compute.internal', '2021-07-13T08:53:05.774802')

		(12, 'ip-172-31-0-192.eu-central-1.compute.internal', '2021-07-13T08:53:04.915618')

		(11, 'ip-172-31-11-126.eu-central-1.compute.internal', '2021-07-13T08:53:03.931413')

		(10, 'ip-172-31-3-208.eu-central-1.compute.internal', '2021-07-13T08:53:02.984679')

		(9, 'ip-172-31-0-192.eu-central-1.compute.internal', '2021-07-13T08:53:01.777761')

		(8, 'ip-172-31-11-126.eu-central-1.compute.internal', '2021-07-13T08:52:59.517626')

		(7, 'ip-172-31-3-208.eu-central-1.compute.internal', '2021-07-13T08:52:58.579990')

		(6, 'ip-172-31-0-192.eu-central-1.compute.internal', '2021-07-13T08:52:57.121242')

		(5, 'ip-172-31-11-126.eu-central-1.compute.internal', '2021-07-13T08:52:53.885075')

8. and that's it.



Setup of ubuntu 20.04 LTS host
==============================

Name resolving
--------------
$ resolvectl status\
$ cd /etc/systemd\
$ sudo vi resolved.conf\
$ sudo systemctl restart systemd-resolved\

This is a VirtualBox VM, first nw interface is a NAT ( for accessing internet )
and second is HostOnly for ssh access. Add ip interface with fix address
---------------------------------
$ sudo nmcli conn down "Wired connection 2"\
$ sudo nmcli conn mod "Wired connection 2" ipv4.addresses 192.168.56.27/24\
$ sudo nmcli conn mod "Wired connection 2" ipv4.method manual\
$ sudo nmcli conn up "Wired connection 2"\

Inastall terraform
------------------
$ sudo apt-get update\
$ sudo apt-get install gnupg software-properties-common curl\
$ curl -fsSL https://apt.releaese.hashicorp.com/gpg | sudo apt-key add -\
$ sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"\
$ sudo apt-get update\
$ sudo apt-get install terraform\
$ terraform version\
$ terraform -install-autocomplete\

Install aws client
------------------
$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"\
$ unzip awscliv2.zip\
$ sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin\
$ aws --version\
$ rm -rf ./aws\
$ aws configure\

Install git
-----------
$ sudo apt install git\
$ git clone https://github.com/tomislak/learn-terraform-aws-instance.git\

Start with terraform
--------------------
$ cd Technology/Terraform/learn-terraform-aws-instance/\
$ vi main.tf\
$ terraform init\
$ terraform fmt\
$ terraform validate\
$ terraform apply\
$ terraform show\
$ terraform state list\
$ terraform output\
$ ssh ec2-user@3.65.20.2\
$ terraform destroy\


Get various aws staff
---------------------
$ aws ec2 describe-images     --owners amazon     --filters "Name=name,Values=amzn2-ami-hvm-2.0.????????.?-x86_64-gp2" "Name=state,Values=available"     --query "reverse(sort_by(Images, &Name))[:1].ImageId"     --output text\
$ aws ec2 describe-images     --owners amazon     --filters "Name=state,Values=available" --output text\

Install ansible
---------------
$ sudo apt install ansible\
$ ansible --version\

Ansible dynamic inventory
-------------------------
https://clarusway.com/ansible-working-with-dynamic-inventory-using-aws-ec2-plugin/\
$ sudo pip3 install boto3\
$ ansible-inventory --graph -i inventory_aws_ec2.yml\
