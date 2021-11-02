provider "aws" {
  region  = "us-east-2"
  profile = "default"
}

resource "aws_key_pair" "mytest-key" {
  key_name   = "my-test-terraform-key-new1"
  public_key = file(var.my_public_key)
}

resource "aws_iam_role" "role" {
  name               = "test_role"
  assume_role_policy = file("${path.module}/assumerolepolicy.json")

}

resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"
  policy      = file("${path.module}/policys3bucket.json")
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  roles      = ["${aws_iam_role.role.name}"]
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = aws_iam_role.role.name
}



resource "aws_launch_configuration" "my-test-launch-config" {
  image_id             = "ami-020aa883151b54611"
  instance_type        = "t2.micro"
  security_groups      = ["${aws_security_group.my-asg-sg.id}"]
  key_name             = aws_key_pair.mytest-key.id
  iam_instance_profile = aws_iam_instance_profile.test_profile.name


  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.my-test-launch-config.name
  vpc_zone_identifier  = ["${var.subnet1}", "${var.subnet2}"]
  target_group_arns    = ["${var.target_group_arn}"]
  health_check_type    = "ELB"


  min_size         = 2
  max_size         = 2
  desired_capacity = 2

  tag {
    key                 = "Name"
    value               = "my-test-asg"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "my-asg-sg" {
  name   = "my-asg-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "inbound_ssh" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.my-asg-sg.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "inbound_http" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.my-asg-sg.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "outbound_all" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.my-asg-sg.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}
