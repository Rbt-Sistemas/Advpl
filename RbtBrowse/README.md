<br />

<p align="center">
  <a href="https://github.com/Rbt-Sistemas/Advpl">
    <img src="storage/app/public/media/logo.png" alt="Logo" width="80" height="80">
  </a>
  <h3 align="center">Advpl - RbtBrowse</h3>	
  <p align="center">	
    Classe para criação de tabela herdada da FwBrowse
    <br/>	
    <a href="https://github.com/Rbt-Sistemas/Advpl/issues">Solicitar uma Feature</a>	
  </p>	
</p>

## RbtBrowse
* [Hierarquia](https://tdn.totvs.com/display/public/PROT/FwBrowse)	
  * [FwBrowse](https://tdn.totvs.com/display/public/PROT/FwBrowse)	
* [Sobre](#sobre)	
* [Classe](#classe)	  
  * [Construtores](#construtores)	
    * [RbtBrowse:New()](#new)	
  * [Instalação](#instalação)	
* [Roadmap](#roadmap)	
* [Contribuindo com o projeto](#contribuindo-com-o-projeto)	
* [Material de Apoio](#material-de-apoio)	

## Sobre  

**Exemplo RbtBrowse:**

![screenshot](https://github.com/Rbt-Sistemas/Advpl/blob/master/RbtBrowse/example.png?raw=true)	

Nossa proposta visa melhorar a forma como as pessoas se hospedam em hotéis/motéis, oferecendo uma experiência única	
de sempre conseguir localizar o melhor lugar, de acordo com seu orçamento e suas necessidades.	

## Classe	
O backend da aplicação foi construído à partir dos seguintes frameworks / bibliotecas:	
* [Laravel 7.0](https://laravel.com)	

  ### Construtores
    #### RbtBrowse:New()
      Retorno Objeto RbtBrowse
      
      Exemplo:
        oBrowse := RbtBrowse:New()

## Começando	

O backend da aplicação roda sob o framework Laravel na versão 7, portanto, boa parte dos requisitos 	
abaixo são necessários por conta dele.	

### Pré-requisitos
* PHP >= 7.2.5 
* Composer
* Node.js >= 10.0 
* MySQL >= 5.6
* BCMath PHP Extension
* Ctype PHP Extension
* Fileinfo PHP extension
* JSON PHP Extension	
* Mbstring PHP Extension	
* OpenSSL PHP Extension	
* PDO PHP Extension	
* Tokenizer PHP Extension	
* XML PHP Extension

### Instalação
1. Clone o repositório
```sh	
git clone https://github.com/ProjetoMTL/izi-backend.git	
```

2. Instale as dependências do composer	
```sh	
composer install	
```

3. Instale as dependências do npm
```sh	
npm install	
```

4. Renomeie o arquivo `.env.example` para `.env`

5. Mude as configurações do arquivo `.env` na seção `DB_*` para um banco local MySQL da sua máquina:
```dotenv
DB_CONNECTION=mysql	
DB_HOST=host_do_banco_de_dados (exemplo: 127.0.0.1)	
DB_PORT=porta_do_banco	
DB_DATABASE=nome_do_banco_de_dados	
DB_USERNAME=usuario_do_banco_de_dados	
DB_PASSWORD=senha_do_banco_de_dados	
```

6. Rode as migrations
```sh
php artisan migrate
```

7. Gere a chave da aplicação
```sh	
php artisan key:generate	
```

8. Rode a aplicação no servidor local (por padrão rodará na porta `8000`)
```sh	
php artisan serve	
```

9. Acesse no browser `http://localhost:8000`

## Roadmap

O roadmap de desenvolvimento você encontra no nosso [quadro do trello](https://trello.com/b/LsBD3WhP/mtl-backend).

## Contribuindo com o projeto

Contribuições são o que tornam a comunidade de desenvolvedores um lugar incrível para aprender,
inspirar e criar. Todas as contribuições que você fizer serão **muito bem vindas**.

1. Faça um `fork` do projeto
2. Crie sua `branch` de recursos (`git checkout -b feature/AmazingFeature`)	
3. Faça um `commit` de suas alterações (`git commit -m 'Add some AmazingFeature'`)	
4. Faça um `push` da sua `branch` (`git push origin feature/AmazingFeature`)	
5. Abra uma `pull request`

## Material de apoio

1. [Arquitetura MVC](https://www.devmedia.com.br/introducao-ao-padrao-mvc/29308)
2. [Crud com Laravel](https://www.youtube.com/watch?v=c4v1D2bYD5U)	
3. [Instalando e configurando o Laravel](https://www.youtube.com/watch?v=pEGp2ju24eE)	
4. [Laravel além do básico](https://medium.com/joaorobertopb/laravel-al%C3%A9m-do-b%C3%A1sico-0-introdu%C3%A7%C3%A3o-96d37a938d14)	
5. [Laravel tips](https://www.youtube.com/watch?v=s9CH7-U7-ZQ&list=PLi_gvjv-JgXqop7hgVKZMGPiT9rUYy1sr)	
6. [Laravel (O Framework PHP dos Artesãos da Web)](https://www.youtube.com/watch?v=4oxjaQCJRaA&t=534s)	
7. [PHP e Laravel 5.4](https://www.youtube.com/watch?v=0Fol4p26Xv0&list=PLw6ZnC_OJcva1PZgT_cdURU2pX0Eh6_nt)

[repository]: https://github.com/ProjetoMTL/izi-backend
[logo]: storage/app/public/media/logo.png	
[product-screenshot]: storage/app/public/media/scope.png	
[raw-product-screenshot]: https://github.com/ProjetoMTL/izi-backend/blob/master/storage/app/public/media/scope.png	
[trello]: https://trello.com/b/LsBD3WhP/mtl-backend
