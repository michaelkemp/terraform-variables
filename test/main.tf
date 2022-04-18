variable "container_secrets" {
  type    = map(string)
  default = {}
}
variable "ulimits" {
  type    = list(map(string))
  default = []
}

locals {
  secrets = [
    for key in keys(var.container_secrets) :
    {
      name      = key
      valueFrom = "${lookup(var.container_secrets, key)}"
    }
  ]
}

output "values" {
  value = <<-EOF
    ${jsonencode(local.secrets)}
    ${jsonencode(var.ulimits)}
    
  EOF
}