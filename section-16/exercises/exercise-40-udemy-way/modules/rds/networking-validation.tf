# subnet validation
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "input" {
  for_each = toset(var.subnet_ids)
  id       = each.value

  lifecycle {
    postcondition {
      condition     = self.vpc_id != data.aws_vpc.default.id
      error_message = "should not be the default vpc, name: ${self.tags.Name}, id: ${self.id}"
    }
    postcondition {
      condition     = can(lower(self.tags.Access) == "Private")
      error_message = "should not be the default vpc, name: ${self.tags.Name}, id: ${self.id}, please ensure that subnet is tagged as Access = Private"
    }
  }
}


# sg group validation
data "aws_vpc_security_group_rules" "input" {
  filter {
    name   = "group-id"
    values = var.sg_group_ids
  }
}

data "aws_vpc_security_group_rule" "input" {
  for_each               = toset(data.aws_vpc_security_group_rules.input.ids)
  security_group_rule_id = each.value

  lifecycle {
    postcondition {
      condition = (
        self.is_egress ? true : self.cidr_ipv4 == null && self.cidr_ipv6 == null && self.referenced_security_group_id != null
      )
      error_message = "contains an invalid inbound rule, id: ${self.security_group_id}"
    }
  }
}
