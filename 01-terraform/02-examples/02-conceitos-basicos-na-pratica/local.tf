# https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "test_local" {
  filename = "${path.module}/test_local.txt"
  content  = "Hello, World! Full Cycle"
}

resource "local_file" "test_var" {
  filename = "${path.module}/test_var.txt"
  content  = var.content
}

# https://developer.hashicorp.com/terraform/language/values/variables
variable "content" {}

output "file_id" {
  value = local_file.test_var.id
}

output "file_content" {
  value = var.content
}


data "local_file" "data-test_local" {
  filename = "${path.module}/test_local.txt"
}


output "data-result" {
  value = data.local_file.data-test_local.content
}
