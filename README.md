# Controle Simplificado de Orçamentos utilizando as tecnologias: WebAPI criada em DotNet 8 + Autenticação JWT + Banco de Dados SQLite (Back-end), ASP.Net MVC + HttpClient (Versão Web) e Flutter (Versão Mobile)

## Demonstração

https://github.com/user-attachments/assets/6bd63150-5fcf-4dd7-a629-6f10ca62a6d5



### Descrição

Este projeto demonstra a construção de um sistema simplificado de controle de orçamentos, integrando Back-end e Front-end Web e Mobile. Utilizando uma WebAPI criada em .NET 8 com autenticação JWT e banco de dados SQLite, o projeto também inclui uma versão Web desenvolvida com ASP.NET MVC e HttpClient, além de uma versão Mobile feita em Flutter.

### Objetivo

O objetivo deste projeto é exemplificar a construção de um sistema completo, desde o Back-end até o Front-end, utilizando tecnologias modernas. Embora não esteja pronto para produção, ele serve como um excelente ponto de partida para entender a integração entre diferentes camadas e tecnologias.

### Funcionalidades

- **Back-end**: WebAPI em .NET 8 com autenticação JWT e banco de dados SQLite.
- **Front-end Web**: Desenvolvido com ASP.NET MVC e HttpClient.
- **Front-end Mobile**: Aplicativo em Flutter, utilizando gerência de estado via Provider para DI + ValueNotifier

### Observações

Este projeto não visa estar pronto para produção. Para tal, seriam necessários ajustes mais refinados e uma arquitetura mais robusta para escalabilidade. Nem todos os Endpoints fornecidos pela API estão sendo utilizados pelos projetos front-end (Web e Mobile). Foram utilizadas somente algumas funções necessárias para exemplificar as tecnologias e o fluxo básico do sistema.

### Melhorias Futuras

Algumas melhorias que poderiam ser aplicadas incluem:
- Separação das camadas Models, Controllers, Data, Domain, Services, Application em projetos distintos.
- Implementação de um padrão Domain-driven Design (DDD).
- Utilização do padrão Unit of Work e Clean Architecture.
- Utilização de log.
- Utilização de testes Unitários, Integração e End-to-end.

### Acesso aos Endpoints

Alguns Endpoints foram deixados desprotegidos para fins didáticos, permitindo acesso via Swagger. Por exemplo, é possível retornar a lista de usuários do sistema via Swagger, obter suas credenciais para autenticação no controller Account, e pegar o token JWT para acessar os Endpoints protegidos. Caso contrário, será retornado um erro 401.


## 🚀 Instalação

Os Projetos Orcamento.API (Backend) e OrcamentoMVC.Front foram feitos em Solutions separadas, assim como o projeto orcamento_app_flutter foi feito em uma pasta separada.
Isso foi feito com a intenção de separar os projetos frontend do backend. Futuramente caso eu deseje criar uma nova versão do frontend em VueJS ou ReactJS basta criar uma nova pasta para o novo projeto front em uma outra linguagem.

O projeto OrcamentoMVC.Front está configurado para buscar os endpoints via HttpClient no endereço do projeto Orcamento.API (Backend) ["OrcamentoAPI": "https://localhost:7206"].
Sendo assim, depois de efeturar um restore nos dois projetos, para executar o OrcamentoMVC.Front é necessário estar com o projeto Orcamento.API em execução. A menos que quem for executar deseje publicar a aplicação no IIS deverá fazer as devidas configurações.


### Usuários padrão do sistema:
### Login: **gerente@gerente.com**
### senha: **1234**

### Login: **funcionario@funcionario.com**
### senha: **1234**


### 📋 Pré-requisitos

DotNet 8 e Flutter versão 3.22.2


### 🛠️ Construído com as tecnologias

### Sistema Operacional: **MacOS Sonoma versão 14.5**
### IDE: **VSCode 1.91.1**
### Backend: **WebAPI do Dotnet na versão 8 + Atenticação JWT, AutoMapper e SQLite para Banco de Dados**
## Frontend Web: **ASP Net MVC com HttpClient para consumir os Endpoints**
## Frontend Mobile: **Flutter versão 3.22.2**

* [Dotnet 8](https://dotnet.microsoft.com/en-us/download/dotnet/8.0) - WebAPI do Dotnet na versão 6 + Autenticação JWT
* [Flutter](https://flutter.dev/) - Flutter - Desenvolvimento Mobile

### ✒️ Autor

João Guedes Pereira Júnior - (Júnior Guedes)

* **Júnior Guedes** - *Backend + Frontend + Mobile* - [GitHub](https://github.com/jrguedes)
* **Júnior Guedes** - *Documentação* - [LinkedIn](https://www.linkedin.com/in/junior-guedes-pereira/)


### 📄 Licença

Este projeto está sob a licença MIT - veja o arquivo [LICENSE.md](https://github.com/git/git-scm.com/blob/main/MIT-LICENSE.txt) para detalhes.

### 🎁 Expressões de gratidão

Não posso deixar de expressar minha gratidão a Deus por todas as bênçãos que Ele tem derramado em minha vida. Também gostaria de agradecer a todas as pessoas com quem tive a honra de trabalhar. Essa constante troca de conhecimento tem sido inestimável, elevando tanto a mim quanto a elas a novos patamares no mundo da tecnologia.


---
⌨️ [João Guedes Pereira Júnior](https://www.linkedin.com/in/junior-guedes-pereira/) 

* **GitHub** - https://github.com/jrguedes
* **LinkedIn** - https://www.linkedin.com/in/junior-guedes-pereira/
