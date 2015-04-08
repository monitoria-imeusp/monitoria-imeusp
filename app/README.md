
Descrição geral do sistema
==========================

Arquitetura
-----------

O sistema usa o padrão de arquitetura de software chamado Model-View-Control
(MVC). Nele, a aplicação fica dividia em três grandes partes (como indica o
nome do padrão):

### Model

Aqui são definidas classes que representam os modelos usados na aplicação.
Basicamente correspondem a tabelas do banco de dados, mas são tratados usando
um mapeamento para Orientação a Objetos. Por exemplo, a classe User corresponde
à tabela "users" no esquema. Cada instância dela equivale a uma linha da tabela,
e o valor em cada coluna dessa linha pode ser acessado como se forre um atributo
do objeto:

```ruby
user = User.first #gets first user
puts user.name #prints user name
```

Nessas classes também podemos (re)definir métodos personalizados que façam
consultas especializadas ao BD. Em geral, consultas são feitas usando a classe
em si:

```ruby
user_joao = User.where(name: "João da Silva").take
```

Além disso, também tem vários comandos auxiliares que impõem validações sobre as
colunas da tabela ou conferem propriedades especiais ao modelo em questão. Por
exemplo, o modelo Student "tem um" User - isso é, a tabela "students" possui uma
chave extrangeira para a tabela "users". Isso é descrito da seguinte maneira:

```
belongs_to :user
```

As classes do Model da aplicação estão na pasta "models" deste diretório. Lá tem
um README explicando maiores detalhes.

### Control

Aqui se especifica o que a aplicação faz quando recebe uma requisição. As
classes de Controller estão associadas ao seus respectivos modelos, e cada
método público delas descreve como um tipo específico de requisição é tratada.

WIP

### View

WIP
