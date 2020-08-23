# Android SDK Setup

Esse repositório contém um *script* para instalação do Android SDK para Linux. Através desse script é possível ter as ferramentas do SDK para gerenciamento de aplicações Android, sem precisar instalar o Android Studio. 

## Requisitos

Para instalação adequada do SDK, é necessário ter o Java JRE e JDK instalados na máquina. Caso não tenha, siga esse [tutorial](https://www.digitalocean.com/community/tutorials/como-instalar-o-java-com-apt-no-ubuntu-18-04-pt) para um exemplo de instalação. 

## Utilização

Simplesmente baixe o arquivo *setup.sh* ou faça clone do projeto. 

Edite as variáveis usadas no script de acordo com sua preferência (local de instalação, nomes, etc). Dentro da pasta onde está o arquivo execute o seguinte comando: 

```bash
$ sh setup.sh 
```

Após isso, teste se o SDK foi instalado: 

```bash
$ sdkmanager 
```
Se a instalação estiver correta, ira surgir uma barra de progresso logo após o comando. 

Para atualizar as licenças, digite:

```bash
$ sdkmanager --licenses
```