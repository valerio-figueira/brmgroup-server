# Aplicação Serverside - GROUP BRM

Bem-vindo à aplicação serverside da **GROUP BRM!** Este projeto é uma aplicação em **Ruby** que fornece uma API para interagir com a empresa GROUP BRM. A GROUP BRM é uma empresa especializada em **tecnologia** e **contabilidade**, oferecendo serviços para municípios.

## SITE OFICIAL

- https://groupbrm.com.br
- https://server.groupbrm.com.br

## Dependências

Antes de executar o projeto, certifique-se de ter as seguintes dependências instaladas:

- json
- mail
- mime-types
- rack-cors
- sinatra

Você pode instalar essas dependências executando o comando `bundle install` no diretório raiz do projeto.

## Estrutura do Projeto

A estrutura do projeto é organizada da seguinte maneira:


    ├── config.ru
    ├── curriculum
    │   ├── `pessoa1@email.com`
    │   │   └── curriculum.jpeg
    │   └── `pessoa2@email.com`
    │       └── curriculum.jpeg
    ├── Gemfile
    ├── Gemfile.lock
    └── src
        ├── controllers
        │   ├── base_controller.rb
        │   ├── curriculum_controller.rb
        │   └── mailer_controller.rb
        ├── helpers
        │   ├── contact_form_submission.rb
        │   └── recaptcha_verifier.rb
        ├── server.rb
        ├── services
        │   ├── curriculum_service.rb
        │   └── mailer_service.rb
        └── validation
            ├── curriculum_validator.rb
            └── mailer_validator.rb


- config.ru: Arquivo de configuração para executar a aplicação Rack.
- curriculum: Diretório que armazena os currículos enviados pelos usuários. Cada currículo está armazenado em uma pasta com o nome do remetente.
- Gemfile: Arquivo de especificação das dependências do projeto.
- Gemfile.lock: Arquivo que registra as versões exatas das gems instaladas.
- src: Diretório que contém o código-fonte da aplicação.
- controllers: Diretório que contém os controladores responsáveis por tratar as requisições HTTP.
- helpers: Diretório que contém módulos com funções auxiliares para o projeto.
- server.rb: Arquivo principal que inicia o servidor e define as rotas.
- services: Diretório que contém os serviços responsáveis pela lógica de negócio.
- validation: Diretório que contém as classes de validação dos dados recebidos.

## Rotas

A aplicação possui as seguintes rotas:

- **GET** '/': Esta é a rota principal que retorna a seguinte mensagem em formato JSON:

`{ "message": "Welcome to GROUP_BRM - API" }`

- **POST** '/contato': Esta rota é utilizada para enviar mensagens de e-mail de contato. Os dados da mensagem devem ser enviados no corpo da requisição. O serviço de e-mail será acionado para enviar a mensagem para a empresa GROUP BRM.

- **POST** '/enviar-curriculo': Esta rota é utilizada para enviar currículos para a empresa GROUP BRM. Os currículos devem ser enviados como anexos no corpo da requisição. O serviço de currículo será acionado para salvar o currículo enviado.

## Autor

- Nome: José Valerio Figueira
- Profissão: Desenvolvedor de Aplicações Web
- Tecnologias: Typescript, HTML, CSS, React, Node.js
- Conhecimentos adicionais: Ruby, Linux, comandos do terminal, SSH, etc.

## Contato

- E-mail: j.valerio.figueira@gmail.com
- LinkedIn: https://www.linkedin.com/in/valerio-figueira/

- Telefone: (34) 99971-3607