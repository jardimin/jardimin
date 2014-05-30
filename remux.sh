#!/bin/bash

#Esse script pega todos arquivos .mp4 dentro de uma pasta e junta os áudios em .wav que estejam com o mesmo nome do arquivo de vídeo em um novo arquivo.

#Cria duas pastas, Temp para arquivos temporários e Remux para armazenar os arquivos remuxados
mkdir Remux |
mkdir Temp |

#Para cada arquivo .mp4 dentro da pasta ele estrai a track de vídeo e salva o arquivo novo na pasta Temp
for f in *.mp4; do MP4Box -single 1 $f && mv "${f%.*}_track1.mp4" Temp ; done &&

#Para cada arquivo .wav ele encoda para um arquivo em .mp3 (o programa MP4Box não é capaz de encodar wav) e o salva na pasta Temp
for f in *.wav; do ffmpeg -i $f -f mp2 "${f%.*}_track1.mp3" && mv "${f%.*}_track1.mp3" Temp ; done &&

#Entra na pasta Temp
cd Temp &&

#Remuxa todos os vídeos e áudios dentro da pasta Temp em um novo arquivo com nomeclatura "_Final" e o salva na pasta Remux
for f in *.mp4; do MP4Box -add $f -add "${f%.*}.mp3" "${f%.*}_Final.mp4" && mv "${f%.*}_Final.mp4" ../Remux ; done &&

#Remove a pasta Temp e todos os arquivos dentro dela
cd .. &&
rm -rf Temp/ &&

#Remux feito
echo "Saravah!!"
