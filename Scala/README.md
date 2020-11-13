# MowItNow Scala
## Master IMSD 2020 - DEME & TRAN

Un programme de tondeuse à gazon automatique, écrit en Scala.



## Format du fichier en entrée

Le fichier en entrée doit suivre un format pré-défini.

Pour programmer la tondeuse, on lui fournit un fichier d'entrée construit comme suit :



• La première ligne correspond aux coordonnées du coin supérieur droit de la pelouse,
celles du coin inférieur gauche sont supposées être (0,0).

• La suite du fichier permet de piloter toutes les tondeuses qui ont été déployées.
Chaque tondeuse a deux lignes la concernant :

- la première ligne donne la position initiale de la tondeuse, ainsi que son
orientation. La position et l'orientation sont fournies sous la forme de 2 chiffres
et une lettre, séparés par un espace.

- la seconde ligne est une série d'instructions ordonnant à la tondeuse d'explorer
la pelouse. Les instructions sont une suite de caractères sans espaces.


```raw
# Exemple

5 5         dimension de la parcelle
1 2 N       initialisation d'une tondeuse
GAGAGAGAA   instructions relatives
3 3 E       initialisation d'une seconde tondeuse
AADAADADDA  instructions relatives
```


```console

```
