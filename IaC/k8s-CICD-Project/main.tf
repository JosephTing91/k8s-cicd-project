# terraform plan --var-file=variables/test.tfvars


### VPC module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "bank_vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private_cidr
  public_subnets  = var.public_cidr

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

### data source
data "aws_availability_zones" "available" {
  state = "available"

}


# resource "aws_instance" "jenkins-k8s" {
#   instance_type          = "t2.xlarge"
#   ami                    = "${data.aws_ami.amazon-linux-2.id}"
#   key_name               = "${var.key-name}"
#   vpc_security_group_ids = ["${aws_security_group.public.id}"]
#   subnet_id              = "${aws_subnet.public1.id}"

#   user_data = "${data.template_file.jenkins_user_data.rendered}"
# }

# data "template_file" "jenkins_user_data" {
#   template = "${file("./jenkins-script-dec12.sh")}"

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
