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

  ulimits = [
    for limit in var.ulimits :
    {
      name      = limit.name
      hardLimit = tonumber(limit.hardLimit)
      softLimit = tonumber(limit.softLimit)
    }

  ]

  container_definition = {
    name    = "Container"
    secrets = local.secrets
    ulimits = local.ulimits
  }

  container_definition_json = format("[%s]", jsonencode(local.container_definition))
}

output "values" {
  value = <<-EOF
    ${local.container_definition_json}
  EOF
}