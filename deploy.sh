#!/usr/bin/bash

#####################################################
#
#   Description : Déploiement à la volée de conteneur
#
#   Auteur : Bedril
#
#   Date  : 10/07/2020
#####################################################

#Recuperation du nombre de machine passé en arguments [ ./deploy.sh --create 2]
nbre_machine=1
[ "$2" != "" ] && nbre_machine="$2" # operation ternaire

#Si option --create
if [ "$1" == "--create" ]; then

    echo ""
    echo "Notre option est --create"
    echo ""

    echo "Nombre de conteneurs docker à créer : ${nbre_machine}"
    echo "Debut de la creation du/des conteneur(s) ..."

    #Recuperation de l'id max de conteneurs deja creer
    idmax=`sudo docker ps -a --format '{{.Names}}' | awk -F "-" -v user=$USER '$0 ~ user"-alpine" {print $3}' | sort -r | head -1`

    min=$(($idmax + 1))
    max=$(($idmax + $nbre_machine))

    #Boucle de creation de conteneurs
    for i in $(seq $min $max); do
        sudo docker run -tid --name $USER-alpine-$i alpine:latest
        echo "Conteneur $USER-alpine-$i crée"
    done
    echo "Fin de creation"

#Si option --drop
elif [ "$1" == "--drop" ]; then

    echo ""
    echo "Notre option est --drop"
    echo ""
    echo "Debut de suppresion du/des conteneur(s) ..."
    # Suppresion de la liste des conteneurs dont le nom contient
    # $USER-alipine. Pas besoin d'utiliser la boucle
    sudo docker rm -f $(sudo docker ps -a | grep $USER-alpine | awk '{print $1}')
    echo "Fin de suppression "
#Si option --infos
elif [ "$1" == "--infos" ]; then

    echo ""
    echo "Notre option est --infos"
    echo ""
    echo "Informations des conteneurs "
    echo ""
    for conteneur in $(sudo docker ps -a | grep $USER-alpine | awk '{print $1}');do
     sudo docker inspect -f ' => {{.Name}} - {{.NetworkSettings.IPAddress}}' $conteneur
    done

#Si option --start
elif [ "$1" == "--start" ]; then

    echo ""
    echo "Notre option est --start"
    echo ""

    sudo docker start $(sudo docker ps -a | grep $USER-alpine | awk '{print $1}')

#Si option --ansible
elif [ "$1" == "--ansible" ]; then

    echo ""
    echo "Notre option est --ansible"
    echo ""

# Si aucune option affichage de l'aide
else

    echo "
 
Options : 
        - --create : lancer des conteneurs

        - --drop : supprimer des conteneurs créer par le script deploy.sh

        - --infos : caracteristique des conteneurs [ip,nom,user, ...]

        - --start : redemarrage des conteneurs

        - --ansible : deploiement arborescence ansible
"

fi

# Recuperer tous les nom de conteneur ayant une certaine nomenclature
# Exemple : bedril-alpine-1, bedril-alpine-2, bedril-alpine3 ...
# Script
# sudo docker ps -a --format '{{.Names}}' | awk -v user=$USER '$0 ~ user"-alpine" {print $0}'
