locals {

  loadbalancer_ingress_rules = {
    "lb_ingress" = {
      description = "Loadbalancer ingress rule from CloudFront"
      from_port   = var.security_group_ingress_from_port
      to_port     = var.security_group_ingress_to_port
      protocol    = var.security_group_ingress_protocol
      # cidr_blocks     = ["0.0.0.0/0"]
    }
  }

  loadbalancer_egress_rules = {
    "lb_egress" = {
      description     = "Loadbalancer egress rule"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
    }
  }
}
provider "aws" {
  alias  = "test"
  region = "eu-west-2"
  assume_role {
    role_arn = "arn:aws:iam::${local.environment_management.account_ids["core-network-services-production"]}:role/modify-dns-records"
  }

}

module "dns_mod" {
  source = "../../"
  providers = {
    aws.core-vpc = aws.core-vpc # core-vpc-(environment) holds the networking for all accounts
  }
  application_name         = local.application_name
  zone                     = data.aws_route53_zone.network-services.zone_id
  dns_name                 = local.application_name
  record_type              = "A"
  alias_zone               = aws_alb.testalb.zone_id
  alias_dns_name           = aws_alb.testalb.dns_name
  gandi_certificate_needed = false
  acm_certificate_needed   = false
  set_identifier           = ""
  certificate_body         = ""
  certificate_chain        = ""
  record                   = ""
  ssm_private_key          = ""
  private_key              = ""
  tags = merge(
    local.tags,
    {
      Name = "dns-testing"
    },
  )

}

resource "aws_alb" "testalb" {
  # A number of tests to ignore to stop errors in the overnight check
  #checkov:skip=CKV_AWS_150 "Ensure that Load Balancer has deletion protection enabled - Not applicable in the test"
  #checkov:skip=CKV_AWS_91: "Ensure the ELBv2 (Application/Network) has access logging enabled - not appropriate in the test"
  #checkov:skip=CKV2_AWS_28: "Ensure public facing ALB are protected by WAF - not required in the test"
  name               = "alb-test"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]
  subnets            = [data.aws_subnet.private_subnets_a.id, data.aws_subnet.private_subnets_b.id, data.aws_subnet.private_subnets_c.id]

  tags = merge(
    local.tags,
    {
      Name = "alb-test"
    },
  )
  drop_invalid_header_fields = true
}
resource "aws_security_group" "lb" {
  name        = "${local.application_name}-lb-security-group"
  description = "Controls access to the loadbalancer"
  vpc_id      = data.aws_vpc.shared.id

  dynamic "ingress" {
    for_each = local.loadbalancer_ingress_rules
    content {
      description     = lookup(ingress.value, "description", null)
      from_port       = lookup(ingress.value, "from_port", null)
      to_port         = lookup(ingress.value, "to_port", null)
      protocol        = lookup(ingress.value, "protocol", null)
      cidr_blocks     = lookup(ingress.value, "cidr_blocks", null)
      security_groups = lookup(ingress.value, "security_groups", null)
      prefix_list_ids = lookup(ingress.value, "prefix_list_ids", null)
    }
  }

  dynamic "egress" {
    for_each = local.loadbalancer_egress_rules
    content {
      description     = lookup(egress.value, "description", null)
      from_port       = lookup(egress.value, "from_port", null)
      to_port         = lookup(egress.value, "to_port", null)
      protocol        = lookup(egress.value, "protocol", null)
      cidr_blocks     = lookup(egress.value, "cidr_blocks", null)
      security_groups = lookup(egress.value, "security_groups", null)
    }
  }
}