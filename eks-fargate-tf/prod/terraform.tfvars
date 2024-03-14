vpc_cidr                   = "10.0.0.0/16"
public_azs                 = ["us-east-1a", "us-east-1b"] 
private_azs                = ["us-east-1a", "us-east-1b"] 
public_subnet_cidr_blocks  = ["10.0.1.0/24", "10.0.3.0/24"]  
private_subnet_cidr_blocks = ["10.0.2.0/24", "10.0.4.0/24"]  
vpc_name                   = "prod-eks-vpc"
pubsubnet_name             = ["prod-vpc-public-subnet-1", "prod-vpc-public-subnet-2"]
prisubnet_name             = ["prod-vpc-private-subnet-1", "prod-vpc-private-subnet-2"]
IG_name                    = "prod-vpc-ig"
SG_name                    = "prod-sg"
pubsubroutetable_name      = "prod-vpc-pubsub-routetable"
privsubroutetable_name     = "prod-vpc-prisub-routetable"
Nat-GW_name                = "prod-vpc-nat-gw"
key                        = "ba-key"
instance_name              = "prod-bastion"
instance_type              = "t2.medium"
ami                        = "ami-0c7217cdde317cfec"
cluster_name               = "prod-eks-private"
cluster_version            = "1.29"
user_data = <<-EOF
                                #!/bin/bash
                                sudo apt upgrade linux-image-generic -y
                                sudo tee /etc/apt/sources.list.d/pritunl.list << EOL
                                deb http://repo.pritunl.com/stable/apt jammy main
                                EOL

                                sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
                                curl https://raw.githubusercontent.com/pritunl/pgp/master/pritunl_repo_pub.asc | sudo apt-key add -

                                sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list << EOL
                                deb https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse
                                EOL

                                wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -

                                sudo apt update
                                sudo apt --assume-yes upgrade

                                sudo apt -y install wireguard wireguard-tools

                                sudo ufw disable

                                sudo apt -y install pritunl mongodb-org
                                sudo systemctl enable mongod pritunl
                                sudo systemctl start mongod pritunl
                            EOF

