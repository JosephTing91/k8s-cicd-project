# terraform plan --var-file=variables/test.tfvars

module "sgs" {
  source       = "../modules/sgs"
  vpc_id  = module.vpc.vpc_id
  whitelist-cidrs = var.whitelist-cidrs
}


### VPC module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "pipeline_vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private_cidr
  public_subnets  = var.public_cidr

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "cicd"
  }
}

### data source
data "aws_availability_zones" "available" {
  state = "available"
}

data "template_file" "jenkins_user_data" {
  template = "${file("../modules/ec2/userdata/jenkins-script-dec12.sh")}"
}

module "ec2" {
  source       = "../modules/ec2"
  priv_subnet_ids= module.vpc.private_subnets
  pub_subnet_ids= module.vpc.public_subnets
  key-name     =  var.key-name
  jenkins-sg   =  module.sgs.jenkins-sg

}






# data "aws_ami" "amazon_linux" {
#   most_recent= true
#   owners = ["amazon"]
#   filter {
#     name= "name"
#     values = [
#       "amzn-ami-hvm"
#     ]
#   }

# }





# ### EC2 Instance ## https://stackoverflow.com/questions/71359239/terraform-how-to-output-multiple-value
# ## in order to dynami
# resource "aws_instance" "web" {
#   ami           = var.ami_ids
#   # availability_zone = slice(data.aws_availability_zones.available.names, 0,3)
#   availability_zone = var.azs[count.index]
#   instance_type = var.instance_type
#   count = length(var.ec2_name_tag)
#   # subnet_id = var.subnet_ids[count.index]
#   subnet_id = module.vpc.private_subnets[count.index]

#   tags = {
#     Name = var.ec2_name_tag[count.index]
#   }
# }



# ### EC2 LB target group
# resource "aws_lb_target_group" "web_target_group" {
#   name     = "web-target-group"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = module.vpc.vpc_id
# }
