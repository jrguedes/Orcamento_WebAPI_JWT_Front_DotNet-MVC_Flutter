# Construí um Controle Simplificado de Orçamentos utilizando as tecnologias: WebAPI criada em DotNet 8 + Autenticação JWT + Banco de Dados SQLite (Back-end), ASP.Net MVC + HttpClient (Versão Web) e Flutter (Versão Mobile) como Front-end 

### Veja o resultado no vídeo abaixo

https://github.com/user-attachments/assets/6bd63150-5fcf-4dd7-a629-6f10ca62a6d5



Este projeto não tem como objetivo estar pronto para uso em produção, pois para tal, seriam necessários ajustes mais refinados e uma arquitetura mais robusta para escalabilidade.
Nem todos os Endpoints fornecidos pela API estão sendo utilizados pelos projetos front, Web e mobile. Foram utilizadas somente algumas funções fornecidas necessárias para exemplificar as tecnoligias utilizadas e fluxo básico do sistema.

Este projeto tem o propósito de exemplificar a construção de um sistema simples de controle de orçamento indo desde o Back-end ao Front-end Web e Mobile.
Algumas melhorias poderiam ter sido aplicadas, como separar as camadas Models, Controllers, Data, Domain, Services, Application em projetos distintos e implementar 
um padrão Domain-driven Design (DDD) ou quem sabe utilizar o Unit of work e Clean Architecture mas como essa não é a proposta do projeto decidi simplificar as coisas.


## 🚀 Começando

Os Projetos Orcamento.API (Backend) e OrcamentoMVC.Front foram feitos em Solutions separadas, assim como o projeto orcamento_app_flutter foi feito em uma pasta separada.
Isso foi feito com a intenção de separar os projetos frontend do backend. Futuramente caso eu deseje criar uma nova versão do frontend em VueJS ou ReactJS basta criar uma nova pasta para o novo projeto front em uma outra linguagem.

O projeto OrcamentoMVC.Front está configurado para buscar os endpoints via HttpClient no endereço do projeto Orcamento.API (Backend) ["OrcamentoAPI": "https://localhost:7206"].
Sendo assim, depois de efeturar um restore nos dois projetos, para executar o OrcamentoMVC.Front é necessário estar com o projeto Orcamento.API em execução. A menos que quem for executar deseje publicar a aplicação no IIS deverá fazer as devidas configurações.

### Observações:

Alguns Endpoints foram deixados desprotegidos para fins didáticos e para que seja possível ter acesso à listagem via Swagger. Como por exemplo, é possível retornar a lista de usuários do sistema via Swagger e pegar suas credencias para fazer um post no método de autenticação no controller Account e pegar o token JWT para inserir a chave de autenticação no próprio Swagger e assim ter acesso aos Endpoints protegidos. Caso contrário será retornado 401.

### Usuários padrão do sistema:
### Login: **gerente@gerente.com**
### senha: **1234**

### Login: **funcionario@funcionario.com**
### senha: **1234**


### 📋 Pré-requisitos

DotNet 8 e Flutter versão 3.22.2


## 🛠️ Construído com as tecnologias

### Sistema Operacional: **MacOS Sonoma versão 14.5**
### IDE: **VSCode 1.91.1**
### Backend: **WebAPI do Dotnet na versão 8 + Atenticação JWT, AutoMapper e SQLite para Banco de Dados**
### Frontend Web: **ASP Net MVC com HttpClient para consumir os Endpoints**
### Frontend Mobile: **Flutter versão 3.22.2**

* [Dotnet 8](https://dotnet.microsoft.com/en-us/download/dotnet/8.0) - WebAPI do Dotnet na versão 6 + Autenticação JWT
* [Flutter](https://flutter.dev/) - Flutter - Desenvolvimento Mobile

## ✒️ Autor

João Guedes Pereira Júnior - (Júnior Guedes)

* **Júnior Guedes** - *Backend + Frontend + Mobile* - [GitHub](https://github.com/jrguedes)
* **Júnior Guedes** - *Documentação* - [LinkedIn](https://www.linkedin.com/in/junior-guedes-pereira/)


## 📄 Licença

Este projeto está sob a licença (sua licença) - veja o arquivo [LICENSE.md](https://github.com/usuario/projeto/licenca) para detalhes.

## 🎁 Expressões de gratidão

Não poderia deixar de agradecer a Deus por todas as coisas que Ele tem feito em minha vida.  Também a todas as pessoas que tive a oportunidade de trabalhar nessa constante troca de conhecimento acrescentando tanto a mim quanto a elas mais um degrau no mundo da tecnologia.


---
⌨️ [João Guedes Pereira Júnior](https://www.linkedin.com/in/junior-guedes-pereira/) 

* **GitHub** - https://github.com/jrguedes
* **LinkedIn** - https://www.linkedin.com/in/junior-guedes-pereira/
