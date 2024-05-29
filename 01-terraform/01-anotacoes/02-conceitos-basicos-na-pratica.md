## 01 - Tour pelo Terraform.io

O terraform provê um registry de módulos, que são códigos prontos para serem utilizados em seus projetos. O registry é uma coleção de módulos de infraestrutura prontos para serem utilizados. Você pode encontrar módulos para AWS, Azure, Google Cloud, Kubernetes, etc.

Para acessar o registry, acesse o link [registry.terraform.io](https://registry.terraform.io/).

Registry do provider AWS: [registry.terraform.io/providers/hashicorp/aws/latest](https://registry.terraform.io/providers/hashicorp/aws/latest)

## 02 - Instalando terraform

Para instalar o terraform, acesse o link [https://developer.hashicorp.com/terraform/install](https://developer.hashicorp.com/terraform/install).

## 03 - Executando pela primeira vez

```tf
# local.tf

# https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "test_local" {
 filename = "${path.module}/test_local.txt"
 content  = "Hello, World!"
}
```

Ao rodar o comando `terraform init`, o terraform irá baixar o provider local e instalar na pasta `.terraform`. Se houvesse mais providers, ele baixaria todos.

### Para verificar o plano de execução, rode o comando `terraform plan`.

```txt
Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # local_file.test_local will be created
  + resource "local_file" "test_local" {
      + content              = "Hello, World!"
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "./test_local.txt"
      + id                   = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

- os recursos que serão criados são indicados com o símbolo `+`.

### Para executar o código, rode o comando: `terraform apply`.

- o terraform roda o plan novamente e pede uma confirmação
- ao rodar novamente o comando `terraform plan`, o terraform mostrará uma mensagem de `no changes`, pois o estado atual é o mesmo que o estado desejado.

### Alteração no código

```tf
resource "local_file" "test_local" {
  filename = "${path.module}/test_local.txt"
  content  = "Hello, World! Full Cycle"
}
```

Ao rodar o comando de plan, o terraform mostrará que o arquivo será alterado.

```txt
Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # local_file.test_local must be replaced
-/+ resource "local_file" "test_local" {
      ~ content              = "Hello, World!" -> "Hello, World! Full Cycle" # forces replacement
      ~ content_base64sha256 = "3/1gIbsr1bCvZ2KQgJ7DpTGR3YHH9wpLKGiKNiGCmG8=" -> (known after apply)
      ~ content_base64sha512 = "N015SpXNz9izWZMYX++bo2jxYNja9DLQi6nx7R5avmzGkpHg+i/gAGpSVw7xjBne9OYXwzzlLvCm5fvjGMsDhw==" -> (known after apply)
      ~ content_md5          = "65a8e27d8879283831b664bd8b7f0ad4" -> (known after apply)
      ~ content_sha1         = "0a0a9f2a6772942557ab5355d76af442f8f65e01" -> (known after apply)
      ~ content_sha256       = "dffd6021bb2bd5b0af676290809ec3a53191dd81c7f70a4b28688a362182986f" -> (known after apply)
      ~ content_sha512       = "374d794a95cdcfd8b35993185fef9ba368f160d8daf432d08ba9f1ed1e5abe6cc69291e0fa2fe0006a52570ef18c19def4e617c33ce52ef0a6e5fbe318cb0387" -> (known after apply)
      ~ id                   = "0a0a9f2a6772942557ab5355d76af442f8f65e01" -> (known after apply)
        # (3 unchanged attributes hidden)
    }

Plan: 1 to add, 0 to change, 1 to destroy.

```

- o terraform mostra que o arquivo será destruído e recriado, pois o conteúdo será alterado.

## 04 - Trabalhando com variáveis

ref: [https://developer.hashicorp.com/terraform/language/values/variables](https://developer.hashicorp.com/terraform/language/values/variables)

```tf
resource "local_file" "test_var" {
  filename = "${path.module}/test_var.txt"
  content  = var.content
}

variable "content" {}
```

Nesse exemplo, a variável `content` será solicitada ao rodar o comando `terraform apply`.

O Terraform provê um arquivo de variáveis, que pode ser utilizado para passar valores para as variáveis. O arquivo é chamado de `terraform.tfvars`.

```tf
# terraform.tfvars
content = "This is a test content."
```

Ao rodar o comando `terraform apply`, o terraform não irá solicitar o conteudo da variável.

### Variáveis de ambiente

O terraform também aceita variáveis de ambiente. Para isso, basta exportar a variável com o prefixo `TF_VAR_`.

```sh
export TF_VAR_content="This is a test content."
```

Ao rodar o comando `terraform apply`, o terraform não irá solicitar o conteudo da variável.

### `-var` e `-var-file` flags

O terraform também aceita flags para passar variáveis.

```sh
terraform apply -var "content=This is a test content."
```

```sh
terraform apply -var-file="other.tfvars"
```
