resource "aws_launch_template" "lt" {
  name_prefix   = "prod-ec2-"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [var.security_group_id]

  user_data = base64encode(file("${path.module}/user_data.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "EC2-ASG"
      Env  = "production"
    }
  }
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity    = 1
  max_size            = 3
  min_size            = 1
  vpc_zone_identifier = [var.subnet_id]
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "prod-ec2-asg"
    propagate_at_launch = true
  }
}
