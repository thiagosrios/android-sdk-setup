#!/bin/bash

### ------------------------------------------------------------
### Android SDK Setup
### Author: Thiago de Souza Rios
### Description: Script para instalação do Android SDK
### Version: 1.0.0
### Date: 16/08/2020
### ------------------------------------------------------------

# --------------------------------------------------------------------
# Variáveis utilizadas no script 
# (Mudar valores de acordo com o ambiente em que o SDK será instalado)
# --------------------------------------------------------------------

# Local de instalação da JVM - Java Virtual Machine (a JRE e a JDK devem estar instaladas por padrão)
JAVA_HOME_PATH=/usr/lib/jvm/java-1.8.0-openjdk-amd64

# Local de instalação do Android SDK
ANDROID_SDK_ROOT=/usr/lib/android-sdk
ANDROID_TOOLS="${ANDROID_SDK_ROOT}/cmdline-tools/tools/bin"

# URL para obtenção do SDK
ANDROID_SDK_URL=https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip

# Nome do arquivo para download do SDK
SDK_FILE=android-sdk.zip

# Novo valor de PATH
NEW_PATH='${PATH}:${JAVA_HOME}:${ANDROID_SDK_ROOT}:${ANDROID_TOOLS}'

# Variáveis para estilização do output
bold=$(tput bold)
normal=$(tput sgr0)

# ------------------------------------
# Funções utilizadas no script
# ------------------------------------

# Função para formatação de texto para output
function imprimir_texto
{
    echo
    echo "${bold} $1 ${normal}"
    echo
}

# Adiciona uma linha para escrita do PATH caso as variáveis não existam
function adicionar_linha_para_path
{
    if [[ -z "$JAVA_HOME_PATH" ]] && [[ -z "$ANDROID_SDK_ROOT" ]]; then
        echo >> ~/.bashrc
    else    
        echo 'Variáveis configuradas anteriormente'
    fi
}

# ---------------------------------
# Instalação de bibliotecas básicas
# ---------------------------------

imprimir_texto "Passo 1 >> Instalação de bibliotecas básicas"
apt-get update
apt-get install -y --force-yes git wget curl unzip ruby build-essential xvfb expect ant libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 qemu-kvm
apt-get clean

# ----------------------------
# Instalação de Font libraries
# ----------------------------

imprimir_texto "Passo 2 >> Instalação de Font libraries"
apt-get -qqy install fonts-ipafont-gothic xfonts-100dpi xfonts-75dpi xfonts-cyrillic xfonts-scalable ttf-ubuntu-font-family libfreetype6 libfontconfig apt-utils

# ----------------------------------------
# Instalação do python-software-properties
# ----------------------------------------

imprimir_texto "Passo 3 >> Instalação do python-software-properties (para usar o comando add-apt-repository)"
apt-get update && apt-get install -y -q python-software-properties software-properties-common

# -------------------------
# Instalação do Android SDK
# -------------------------

imprimir_texto "Passo 4 >> Instalação do Android SDK"
mkdir -m 777 $ANDROID_SDK_ROOT	
wget $ANDROID_SDK_URL --output-document=$SDK_FILE
unzip $SDK_FILE -d $ANDROID_SDK_ROOT"/cmdline-tools"
rm -f $SDK_FILE

# --------------------
# Configuração do PATH
# --------------------

imprimir_texto "Passo 5 >> Configuração do PATH, incluindo diretórios do Android SDK"

# Verificações de variáveis
if grep -w JAVA_HOME ~/.bashrc; then
    echo 'Variável JAVA_HOME existente, substituir valor'
    sed -i 's;^JAVA_HOME=.*;JAVA_HOME='"$JAVA_HOME"';' ~/.bashrc
else
    echo 'Variável JAVA_HOME inexistente, escrever valor'
    echo >> ~/.bashrc
    echo JAVA_HOME="${JAVA_HOME}" >> ~/.bashrc
fi

if grep -w ANDROID_SDK_ROOT ~/.bashrc; then
    echo 'Variável ANDROID_SDK_ROOT existente, substituir valor'
    sed -i 's;^ANDROID_SDK_ROOT=.*;ANDROID_SDK_ROOT='"$ANDROID_SDK_ROOT"';' ~/.bashrc
else
    echo 'Variável ANDROID_SDK_ROOT inexistente, escrever valor'
    echo ANDROID_SDK_ROOT="${ANDROID_SDK_ROOT}" >> ~/.bashrc
fi

if grep -w ANDROID_TOOLS ~/.bashrc; then
    echo 'Variável ANDROID_TOOLS existente, substituir valor'
    sed -i 's;^ANDROID_TOOLS=.*;ANDROID_TOOLS='"$ANDROID_TOOLS"';' ~/.bashrc
else
    echo 'Variável ANDROID_TOOLS inexistente, escrever valor'
    echo ANDROID_TOOLS="${ANDROID_TOOLS}" >> ~/.bashrc
fi

if grep -w PATH ~/.bashrc; then
    echo 'Variável PATH existente, substituir valor'
    sed -i 's;^PATH=.*;PATH='"$NEW_PATH"';' ~/.bashrc
else
    echo 'Variável PATH inexistente, escrever valor'
    echo PATH="${NEW_PATH}" >> ~/.bashrc
fi

source ~/.bashrc

# Configuração do SDK
# -------------------
imprimir_texto "Passo 6 >> Instalação de utilitários do SDK e de configuração de licenças"
yes | sdkmanager --licenses
