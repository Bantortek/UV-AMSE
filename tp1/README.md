# Utilisation

Pour télécharger le projet, taper dans la console:

    git clone https://github.com/Bantortek/UV-AMSE.git

Pour lancer le projet se placer dans le fichier tp1 et taper les deux commandes suivantes:

    flutter emulators --launch Medium_Phone_API_35
    flutter run

le projet utilise une commande qui ne fonctionne pas dans la version Web de flutter pour trouver le chemin actuel du fichier 
( getApplicationDocumentsDirectory() ), il est donc recommandé d'utiliser un téléphone ou un émulateur pour que l'application fonctionne correctement.