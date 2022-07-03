# Linux-Installation-Script
Script to prepare the desktop on Linux.

[shellcheck](https://www.shellcheck.net/)

> A função update serve para ressincronizar os arquivos do índice de pacotes de suas fontes. As listas de pacotes disponíveis são obtidas nos locais especificados em /etc/apt/sources.list, por exemplo. 

`sudo apt update`

> A função upgrade irá tentar atualizar “delicadamente” todo o sistema. Nesse caso nunca será instalado, removido ou atualizado algum pacote que possa gerar alguma quebra no sistema. Esse comando pode ser usado frequentemente para atualizar o seu sistema com relativa segurança. 

`sudo apt upgrade`

> O comando dist-upgrade também atualiza os pacotes, porém, remove e instala pacotes se for necessário. Muitas vezes alguns softwares precisam ser instalados como dependências para certos aplicativos, essa opção faz isso. O dist-upgrade é uma atualização mais completa, porém, “mais arriscada”, já que modificará o sistema profundamente.

`sudo apt dist-upgrade`
