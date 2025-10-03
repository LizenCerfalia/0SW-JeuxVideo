

GOAP.

    L'IA doit pouvoir intéragir avec les différentes méchanique du boss ou ennemies qui pourrait apparaître.

    *Puisque la coopération entre les joueurs (ou IA) est absolument intégrale, c'est la partie la plus importante du projet*

    https://www.youtube.com/watch?v=LhnlNKWh7oc

    - L'introduction au GOAP explique qu'il faut utiliser un système de coût d'opportunité pour diriger l'IA ou l'on veut

Finite State machine pour le boss.

    Le boss n'utilise pas un algorithme de GOAP, il va plutot alterner entre différents états
    qui vont définir les méchaniques qu'il fera.

    https://www.youtube.com/watch?v=otHfaomtJh0

    - Il faut implémenter divers états en tant que Node dont le boss utilisera dépendamment de la situation.
    Ceci est très adaptable selon les besoins

    - Plein d'autre méchanique non-relié qui pourrait être utile possiblement 

Tab targeting et gestion de cooldown.

    Mon jeu utilise un système de combat pseudo MMO, donc il me faut un système permettant choisir une cible en appuyant sur Tab et un moyen de gérer un cooldown central (genre chaque attaque du joueur met toutes ses abilités en cooldown)

    https://www.youtube.com/watch?v=QoM0NsjMlE8 - tab targeting

    -Il faut ajouter les enemies qui entre dans le champ de vision du joueur dans un tableau de cible possible.
    Appuyé sur tab bouge l'index de cible possible vers le prochain enemie dans le tableau
    
    https://www.youtube.com/watch?v=6qQjmq8L-hU - Cooldown (pour abilités individuelles mais adaptable pour un cooldown global)

    -Il faut créer un code de shaders custom qu'on utilisera dans une section de code qui s'occupe de gérer les cooldowns.
    Vu qu'il faudra que je gère plusieurs personnagez, j'adapterais ce code pour que ce soit individuel.

