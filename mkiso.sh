#!/usr/bin/env bash

######## CABEÇALHO ########
# AUTOR: welly <wellyton.offcer@gmail.com>
# NOME: mkiso.sh
# USO: automatizar o build de uma iso com archiso
# COMO UTILIZAR: você precisa ter uma estrutura de diretórios pré-definida
#				 diretórios: build, iso, profiles, repo, work
# 				 basta rodar o script especificando o profile que deseja compilar
#				 exemplo: mkiso <profile>

profile="$(./profile)"
workdir="$(./work)"
outdir="$(./iso)"
# REGRA

if [ -z "$profile"  ]; then
	echo "você não pode passar um profile vazio."
	exit 1
fi

if [ ! "$(id -u)" == 0  ]; then
   echo "você precisa ser root para executar esse script"
   exit 1
fi

# VERIFICANDO E LIMPANDO WORK DIR

if [ "$(ls -A $workdir)" ]; then
   echo "diretório não vazio, limpando..."
   rm -vrf "$workdir"/*
fi

# INICIANDO BUILD

mkarchiso -v -w "$workdir" -o "$outdir" "$profile"

# LIMPANDO WORKDIR APÓS O FINAL DO BUILD

echo "limpando workdir"
rm -vrf "$workdir"/*
