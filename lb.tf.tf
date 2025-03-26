#2 Application Load Balancer
resource "aws_lb" "app_lb" {
  name               = "aws-app-lb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.web-sg.id]
  subnets            = [aws_subnet.public-subnet1.id, aws_subnet.public-subnet2.id]

}

# Target Group for ALB
resource "aws_lb_target_group" "alb_ec2_tg" {
  name     = "test-web-server-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.siva.id
  tags = {
    Name = "test-web-server-tg"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_ec2_tg.arn
  }
  tags = {
    Name = "aws-alb-listener"
  }
}


resource "aws_lb_target_group_attachment" "server2" {
  target_group_arn = aws_lb_target_group.alb_ec2_tg.arn
  target_id        = "i-01cb1aacd2722eaf0"
  port             = 80

}
resource "aws_lb_target_group_attachment" "server1" {
  target_group_arn = aws_lb_target_group.alb_ec2_tg.arn
  target_id        = "i-0ca3f132d74ef4313"
  port             = 80

}