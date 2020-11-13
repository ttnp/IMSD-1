# MowItNow Scala

## (FRENCH)

### Les membres du groupe
DEME & TRAN @ Master IMSD 2020 

### Le projet
MowItNow: Un programme de tondeuse à gazon automatique, écrit en Scala.

### Format du fichier en entrée

Le fichier en entrée doit suivre un format pré-défini.

Pour programmer la tondeuse, on lui fournit un fichier d'entrée construit comme suit :

- La première ligne correspond aux coordonnées du coin supérieur droit de la pelouse,
celles du coin inférieur gauche sont supposées être (0,0).

- La suite du fichier permet de piloter toutes les tondeuses qui ont été déployées.
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



## (ENGLISH)

### Group members
DEME & TRAN @ Master IMSD 2020 

### The project
MowItNow: An automatic lawn mower program, written in Scala.

### Input file format

The input file must follow a pre-defined format.

To program the mower, it is provided with an input file constructed as follows:

- The first line corresponds to the coordinates of the upper right corner of the lawn,
those in the lower left corner are assumed to be (0,0).

- The rest of the file allows you to control all the mowers that have been deployed.
Each mower has two lines relating to it:

- the first line gives the initial position of the mower, as well as its
orientation. Position and orientation are provided as 2 digits
and a letter, separated by a space.

- the second line is a series of instructions ordering the mower to explore
the lawn. Instructions are a sequence of characters without spaces.

```raw
# Example

5 5         plot size
1 2 N       initialization of a mower
GAGAGAGAA   related instructions
3 3 E       initialization of a second mower
AADAADADDA  related instructions
```
