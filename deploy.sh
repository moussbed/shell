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
[ "$2" != "" ] && nbre_machine="$2"

#Si option --create
if [ "$1" == "--create" ]; then

    echo ""
    echo "Notre option est --create"
    echo ""

    sudo docker run -tid --name $USER-alpine alpine:latest

    echo " j'ai crée ${nbre_machine} machine(s)"

#Si option --drop
elif [ "$1" == "--drop" ]; then

    echo ""
    echo "Notre option est --drop"
    echo ""

    sudo docker rm -f $USER-alpine

#Si option --infos
elif [ "$1" == "--infos" ]; then

    echo ""
    echo "Notre option est --infos"
    echo ""

#Si option --start
elif [ "$1" == "--start" ]; then

    echo ""
    echo "Notre option est --start"
    echo ""

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
