# Sobre o repositório

O Sistema de Monitoria é o sistema de pedidos e candidaturas de monitores para disciplinas do Instituto de Matemática e Estatística da USP.]

Ele foi desenvolvido durante a disciplina **MAC 342/5716 (Laboratório de Programação eXtrema)**.

# Conteúdo

Lista de conteúdos deste *README*:

* [Instruções para instalação e configuração](#instrucoes);
    * [Instalação dos prerrequisitos](#prerrequisitos);
    * [Instalação do ambiente Ruby](#instalaruby);
    * [Configurando o sistema de monitoria](#configure);
* [Possíveis erros durante a instalação](#erros);

# <a name="instrucoes"></a> Instruções para instalação e configuração

## <a name="prerrequisitos"></a> Instalação dos prerrequisitos:

Antes de se instalar o rvm, é necessário que a máquina tenha os seguintes programas:

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

----

**Note 1**: pode ser preciso instalar os seguintes pacotes em sistemas Linux:

    -libqt4-dev
    -libqtwebkit-dev
    -postgresql
    -postgresql-server-dev-all

Para instalar, entre com o comando:

```bash
sudo apt-get install <pacote1> <pacote2>
```

**Note 2**: instale o webkit `phantomjs 1.9.7`. Para isso, siga os comandos:

```bash
sudo mv phantomjs-1.9.7-linux-i686.tar.bz2 /usr/local/share/.
cd /usr/local/share/
sudo tar xjf phantomjs-1.9.7-linux-i686.tar.bz2
sudo ln -s /usr/local/share/phantomjs-1.9.7-linux-i686 /usr/local/share/phantomjs
sudo ln -s /usr/local/share/phantomjs/bin/phantomjs /usr/local/bin/phantomjs
```

Finalmente, verifique se a instalação foi bem sucedida:

```bash
phantomjs -v
```

## <a name="instalaruby"></a> Instalação do ambiente Ruby

### Instalação do rvm (ruby version manager)

Instalaremos o **rvm**.

Inicialmente, instale a chave pública **mpapis** (talvez seja necessário `gpg2` e/ou `sudo`):

```bash
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
```

Em seguida, instale a última versão estável do `rvm`:

```bash
\curl -sSL https://get.rvm.io | bash -s stable
```

* **Possível erro**: `curl: (77) error setting certificate verify locations`. Para resolvê-lo, entre [aqui](#curl).


----

**Note:** A instalação do rvm criou um grupo e pode ser necesário adicionar ao grupo todos os usuários que usarão a rvm na máquina. No caso, **basta adicionar o seu usuário normal**. Para fazer isso digite:

```bash
sudo adduser [username] rvm
```

Depois, execute o seguinte comando:

    editor-texto-preferido ~/.bashrc

E adicione o seguinte trecho no final do arquivo e o salve:

```bash
[[ -s "usr/local/rvm/scripts/rvm" ]] && . "usr/local/rvm/scripts/rvm"
```

### Usando o rvm

Agora, *sempre que você for usar o RVM*, você precisa permitir que o RVM use o Shell no modo login:

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

Primeiramente, instale o ruby. Nós vamos usar a versão 2.1.1:

```bash
rvm install ruby-2.1.1
```

Certifique-se que está tudo certo com o comando:

```bash
ruby -v
```

## <a name="configure"></a> Configurando o sistema de monitoria

### Clonando o repositório

Para clonar o repositório, entre em um diretório de preferência e em seguida execute (lembre-se que ao clonar, os arquivo do repositório serão copiado para uma pasta chamada *monitoria-imeusp*):

```bash
git clone https://github.com/monitoria-imeusp/monitoria-imeusp
```

Ou, se preferir por `ssh`, execute:

```bash
git clone git@github.com:monitoria-imeusp/monitoria-imeusp.git
```

**Note**: para configurar uma chave `ssh`, siga este [tutorial](https://help.github.com/articles/generating-an-ssh-key/).


### Instalação das gemas

Finalizado as etapas anteriores, entre na pasta clonada.

Agora, instale as gemas:

```bash
gem install bundler

bundle install
```

### Configurando o servidor

Inicialize o banco de dados:

```bash
rake db:setup

rake db:migrate RAILS_ENV=test
```

### Rodando os testes

Para iniciar os testes **rspec**:

```bash
rspec
```

Para iniciar os testes **cucumber**:

```bash
HISTORY_REQUEST_URL=http://abc/ rake cucumber
```

### Rodando o sistema

Finalmente, execute:

```bash
rails s
```

Abra o seu browser preferido e entre `http://localhost:3000/`.

----

**Note**:

Se a porta `3000` estiver ocupada, entre como alternativa: `rails s -p <numero_da_porta>`.


# <a name="erros"></a> Possíveis erros durante a instalação

### curl

O seguinte erro foi encontrado em Debian 8 (Jessie):

    curl: (77) error setting certificate verify locations:
      CAfile: /etc/pki/tls/certs/ca-bundle.crt
      CApath: none

Para resolver:

    sudo apt-get install ca-certificates
    sudo mkdir -p /etc/pki/tls/certs
    sudo cp /etc/ssl/certs/ca-certificates.crt /etc/pki/tls/certs/ca-bundle.crt

