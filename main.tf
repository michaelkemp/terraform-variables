module "test" {
  source = "./test"

  container_secrets = {
    TESTVAL1 = "testValue1"
    TESTVAL2 = "testValue2"
    TESTVAL3 = "testValue3"
  }

  ulimits = [
    { "name" = "nofile", "softLimit" = "1024", "hardLimit" = "2048" },
    { "name" = "stack", "softLimit" = "2048", "hardLimit" = "4096" },
    { "name" = "core", "softLimit" = "8192", "hardLimit" = "32768" }
  ]

}

output "fromModule" {
  value = module.test.values
}