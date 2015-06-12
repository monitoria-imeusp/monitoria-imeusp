## Instalação dos prerrequisitos :

Antes de se intalar o rvm, é necessário que a máquina tenha os seguintes programas:

	- bash (versão 3.2.25 ou superior)
	- awk
	- sed
	- grep
	- which
	- ls
	- cp
	- tar
	- curl
	- gunzip
	- bunzip2

Para saber se a máquina tem os programas acima, digite no terminal:

```bash
for name in {bash,awk,sed,grep,ls,cp,tar,curl,gunzip,bunzip2} ; do which $name ;  done
```

## Instalação do ambiente Ruby

### Instalação do rvm (ruby version manager)

```bash
\curl -sSL https://get.rvm.io | bash -s stable
```

A instalação do rvm criou um grupo e é necesário adicionar ao grupo todos os usuários que
usarão a rvm na máquina. No caso, **basta adicionar o seu usuário normal**.
Para fazer isso digite:

```bash
sudo adduser [username] rvm
```

Depois, execute o seguinte comando:
	editor-texto-preferido ~/.bashrc

E adicione o seguinte trecho no final do arquivo e o salve:

```bash
[[ -s "usr/local/rvm/scripts/rvm" ]] && . "usr/local/rvm/scripts/rvm"
```

Agora, *sempre que você for usar o RVM*, você precisa permitir que o RVM use o Shell
no modo login:

```bash
/bin/bash --login
# ou simplesmente
bash --login
```

Pra ter certeza que tudo funcionou digite:

```bash
type rvm | head -n1
```

Você deverá ver a seguinte mensagem: "rvm is a function"
Caso o comando não dê certo digite-o em uma nova janela ou aba do terminal.

Faça log out e depois faça login novamente para as alterações acima terem efeito.


### Adicionando uma instalação do ruby ao RVM

Primeiramente, instale o ruby (versão 2.1.1):

```bash
rvm install ruby
```

Agora, defina a versão do ruby que você vai usar com o comando abaixo. Nós vamos
usar a versão 2.1.1.

```bash
rvm --default use 2.1.1
```

Certifique-se que está tudo certo com o comando:

```bash
ruby -v
```

Instale as gemas:

```bash
bundle install
```

Pode ser preciso instalar os seguintes pacotes em um Ubuntu:

-libqt4-dev
-libqtwebkit-dev
-postgresql
-postgresql-server-dev-all

## Configurando o servidor

Inicializar o banco de dados:

```bash
rake db:setup
```

E para os testes:

```bash
rake db:migrate RAILS_ENV=test
rspec
```

## Tarefas agendadas em produção
Para rodar a thread que verifica tarefas agendadas e as executa no
tempo correto, é necessário rodar o script:
RAILS_ENV=production bin/delayed_job start
OU
rake jobs:work
Se acontecerem problemas, https://github.com/collectiveidea/delayed_job/wiki/Common-problems
tem troubleshooting. 

## Conversao para pdf
Precisa instalar o binario em produção
https://github.com/mileszs/wicked_pdf/wiki/Getting-Started-Installing-wkhtmltopdf
e em /config/initializers/wicked_pdf.rb mudar o path se nao ficar em /usr/bin/



## Coisas antigas do README

Deixei aqui algumas informações do Jack que não precisei usar, mas podem vir a ser relevantes.

- Instalação da versão 4.1 release candidate do Rails (recomendação do Manzo). (essa etapa pode demorar):
	gem install rails --pre
OBS: Ignorem caso apareça a mensagem "unable to convert "\x80" from ASCII-8BIT to UTF-8 for guides/assets/images/tab_info.gif, skipping"

Uma das fontes usadas: http://eecs.vanderbilt.edu/research/hmtl/wp/index.php/rvm-ruby-ruby-on-rails/

OBS: vale a pena dar uma olhada na página acima posteriormente
