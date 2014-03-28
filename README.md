1) Instalação dos prerrequisitos :
- Antes de se intalar o rvm, é necessário que a máquina tenha os seguintes programas:
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

- Para saber se a máquina tem os programas ácima, digite no terminal:
	for name in {bash,awk,sed,grep,ls,cp,tar,curl,gunzip,bunzip2} ; do which $name ;  done


2) Instalação do ambiente Ruby
- Instalação do rvm (ruby version manager)
	\curl -sSL https://get.rvm.io | sudo bash -s stable

- A instalação do rvm criou um grupo e é necesário adicionar ao grupo todos os usuários que
usarão a rvm na máquina
Para fazer isso digite:
	sudo adduser [username] rvm

- Execute o seguinte comando:
	sudo editor-texto-preferido .bashrc

- Depois disso adicione o seguinte trecho no final do arquivo e o salve:
	[[ -s "usr/local/rvm/scripts/rvm" ]] && . "usr/local/rvm/scripts/rvm" 

- Permitir que o rvm possa fazer login no shell:
	/bin/bash --login

- Pra ter certeza que tudo funcionou digite:
	type rvm | head -n1
Você deverá ver a seguinte mensagem: "rvm is a function"
Caso o comando não dê certo digite-o em uma nova janela ou aba) do terminal


Faça log out e depois faça login novamente para as alterações acima terem efeito.


- Instalação do ruby
	rvm install ruby

- Defina a versão do ruby que você vai usar com o comando:
	rvm --default use d.c.m
OBS: d.c.m pode ser por exemplo 2.1.1 .

- Permitir que o rvm possa fazer login no shell:
	/bin/bash --login

- Certifique-se que está tudo certo com o comando:
	ruby -v

- Instalação da versão 4.1 release candidate do Rails (recomendação do Manzo). (essa etapa pode demorar):
	gem install rails --pre
OBS: Ignorem caso apareça a mensagem "unable to convert "\x80" from ASCII-8BIT to UTF-8 for guides/assets/images/tab_info.gif, skipping"

Uma das fontes usadas: http://eecs.vanderbilt.edu/research/hmtl/wp/index.php/rvm-ruby-ruby-on-rails/

OBS: vale a pena dar uma olhada na página acima posteriormente
