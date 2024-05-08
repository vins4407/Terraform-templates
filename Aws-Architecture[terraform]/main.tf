resource "aws_vpc" "vinsVpc" {
  cidr_block = var.aws-cidr
}

resource "aws_subnet" "sub_1" {
  vpc_id                  = aws_vpc.vinsVpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

}

resource "aws_subnet" "sub_2" {
  vpc_id                  = aws_vpc.vinsVpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vinsVpc.id

}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vinsVpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
}

resource "aws_route_table_association" "RTA_1" {
  subnet_id      = aws_subnet.sub_1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "RTA_2" {
  subnet_id      = aws_subnet.sub_2.id
  route_table_id = aws_route_table.rt.id
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vinsVpc.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  from_port         = 0
  to_port           = 0
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol    = "-1" # semantically equivalent to all ports
}

resource "aws_s3_bucket" "vinayaks3bucket4407" {
    bucket = "vinayaks3bucket4407"
}

resource "aws_instance" "webServer1" {
  ami = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  subnet_id = aws_subnet.sub_1.id
  user_data = base64encode(file("userData.sh"))
}

resource "aws_instance" "webServer2" {
  ami = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  subnet_id = aws_subnet.sub_2.id
  user_data = base64encode(file("userData2.sh"))
}

resource "aws_lb" "mylb" {
  name               = "my-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_tls.id]
  subnets            = [aws_subnet.sub_1.id,aws_subnet.sub_2.id]
  

  tags = {
    Name = "web"
    Environment = "production"
  }
}

resource "aws_lb_target_group" "mytg" {
  name     = "mytg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vinsVpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_target_group_attachment" "attach1" {
  target_group_arn = aws_lb_target_group.mytg.arn
  target_id = aws_instance.webServer1.id
  port = 80
  
}


resource "aws_lb_target_group_attachment" "attach2" {
  target_group_arn = aws_lb_target_group.mytg.arn
  target_id = aws_instance.webServer2.id
  port = 80
}


resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.mylb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.mytg.arn
    type             = "forward"
  }
}


output "loadbalancerdns" {
  value = aws_lb.mylb.dns_name
}