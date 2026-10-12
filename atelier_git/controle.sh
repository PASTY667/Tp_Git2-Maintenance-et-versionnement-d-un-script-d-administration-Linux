#!/bin/bash

source ./configuration.conf

echo "================================"
echo " Contrôle du serveur : $SERVEUR"
echo "================================"

echo ""
echo "Espace disque :"
df -h /

echo ""
echo "Mémoire :"
free -h

echo ""
echo "Durée de fonctionnement :"
uptime -p

echo ""
echo "Seuil disque configuré : $SEUIL_DISQUE %"
echo "Seuil mémoire configuré : $SEUIL_MEMOIRE %"