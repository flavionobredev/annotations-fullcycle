## 02 - Sobre o Terraform

O Terraform é uma ferramenta de infraestrutura como código (IaC) que permite criar, alterar e versionar a infraestrutura de forma segura e eficiente. Ele é desenvolvido pela HashiCorp e é uma ferramenta open source.

Ele provisiona componentes de infraesturura, não só de alto nivel (vm, bancos, etc), mas tambem de baixo nivel (vpc, subnets, etc).

Ele foi criado para utilizar vários providers de nuvem, como AWS, Azure, Google Cloud, entre outros.

Pontos principais:
- **Declarativo**: Você descreve o estado desejado da infraestrutura em um arquivo de configuração.
- **Multi-cloud**: Suporta vários providers de nuvem.
- **Guarda o estado da infraestrutura**: Ele guarda o estado da infraestrutura em um arquivo, para que ele possa gerenciar a infraestrutura de forma eficiente.

## 03 - Idempotência

O Terraform é **idempotente**, ou seja, ele garante que o estado da infraestrutura seja o mesmo que o estado descrito no arquivo de configuração. Se a infraestrutura já estiver no estado desejado, ele não fará nenhuma alteração.

Idepotência é uma propriedade de operações em matemática e ciência da computação que podem ser aplicadas várias vezes sem alterar o resultado além da primeira aplicação. Em resumo, se a operação já foi realizada, ela não será realizada novamente.

Diante disso, o Terraform garante que um recurso não seja criado novamente a cada execução, caso ele já exista. Além disso, se houver alteração em algum recurso, o Terraform irá (ou tentará) alterar apenas o recurso que foi modificado.

O Terraform também é declarativo, ou seja, você descreve o estado desejado da infraestrutura e o Terraform se encarrega de fazer as alterações necessárias para que a infraestrutura fique no estado desejado. Ele compara o arquivo de configuração com o estado atual da infraestrutura, faz um plano de execução e, se você concordar, executa as alterações necessárias.

Em alguns casos, o Terraform não trabalha tão bem com idempotência. Em algumas situações, é interessante até mesmo utilizar serviços externos, como o Ansible, para garantir a idempotência.

## 04 - Terraform vs Ansible

O que o Terraform faz de melhor?
R: provisionamento de infraestrutura

O que o Ansible faz de melhor?
R: gerenciamento e automação de configuração

As duas ferramentas fazem, em partes, a mesma coisa, mas cada uma tem seu foco e ponto forte. Atualmente, é comum ver empresas utilizando as duas ferramentas em conjunto, para que cada uma faça o que faz de melhor.

## 05 - Gerenciamento de estado

O Terraform guarda o estado da infraestrutura em um arquivo chamado `terraform.tfstate`. Esse arquivo é gerado automaticamente após a execução do Terraform e contém informações sobre os recursos criados, como ID, IP, etc.

O arquivo de estado é usado para comparar o estado atual da infraestrutura com o estado descrito no arquivo de configuração. Ele é importante para que o Terraform saiba o que precisa ser alterado, criado ou removido.

Esse arquivo é muito importante para o uso do Terraform. Imagine que você precisa provisionar algum recurso na sua cloud e já existe uma infraestrutura provisionada. Se você não tiver o arquivo de estado, o Terraform não saberá o que já foi provisionado e poderá criar recursos duplicados ou estourar muitos erros (isso se não corromper serviços inesperados).

