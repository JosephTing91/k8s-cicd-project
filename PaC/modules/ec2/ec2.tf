

resource "aws_instance" "jenkins-k8s" {
  instance_type          = "t2.xlarge"
  #"${data.aws_ami.amazon-linux-2.id}"
  ami                    =  "ami-0b0dcb5067f052a63" #amazon linux 2 us-east1
  key_name               = "${var.key-name}"
  vpc_security_group_ids = ["${var.jenkins-sg}"]
  #here i use public subnet to easily connect. Best practice to use bastion host or ssh forwarding with putty..
  subnet_id              = "${var.pub_subnet_ids[0]}"

  user_data = "${data.template_file.jenkins_user_data.rendered}"
}

data "template_file" "jenkins_user_data" {
  template = "${file("../modules/ec2/userdata/jenkins-script-dec12.sh")}"
}


resource "aws_instance" "sonarqube-k8s" {
  instance_type          = "t2.medium"
  #"${data.aws_ami.amazon-linux-2.id}"
  ami                    =  "ami-0574da719dca65348" #ubuntu 22.04 us-east-1
  key_name               = "${var.key-name}"
  vpc_security_group_ids = ["${var.jenkins-sg}"]
  #here i use public subnet to easily connect. Best practice to use bastion host or ssh forwarding with putty..
  subnet_id              = "${var.pub_subnet_ids[0]}"

  user_data = "${data.template_file.jenkins_user_data.rendered}"
}

data "template_file" "sonarqube_user_data" {
  template = "${file("../modules/ec2/userdata/jenkins-script-dec12.sh")}"
}
