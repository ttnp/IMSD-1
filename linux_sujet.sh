#!/bin/bash


PS3='Veuillez faire un choix: ' 							# Sets the prompt string

echo														# echo without strings are just for Readability

s=() 														# Sets 2 empty arrays, s: students, n: notes
n=()

function enterNote											# Sets function
{
    echo "Entrez le nom: "									# Sets the prompt string
    read name												# Reads the value entered
    s+=($name)												# Adds the value to the existing array "s"
    echo "Entrez la note:"									# Sets the prompt string
    read note 												# Reads the value entered
    while [ "$note" -gt 20 -o "$note" -lt 0 ]				# while loop: if the input is greater than 20 or lower than 0
        do
        	echo "Les notes doivent être comprises entre 0 et 20 points, veuillez saisir à nouveau:"	# then write out this line						
    		read note 										# Reads the input again
        done   
    n+=($note)												# check done, now add the valid value to the existing array "n"
   	echo "La note de $name est: $note"						# Confirms
   	echo												
}

function appearMerit										# Sets function for second choice										
{
    echo "Étudiant, note"									# a line indicating the format of output
    for i in ${!s[@]};										# for each value in the s array (student)
    do
        if [ "${n[$i]}" -ge 12 ]							# if the correspondant value in the n array (note) is [g]reater than or [e]qual to 12
        then
            echo "${s[$i]}, ${n[$i]}"						# print the student & the note
        fi
    done
    echo
}


function appearFail											# Sets function for third choice
{
	echo "Étudiant, note"									# a line indicating the format of output
    for i in ${!s[@]};										# for each value in the s array (student)
    do
        if [ "${n[$i]}" -lt 10 ]							# if the correspondant value in the n array (note) is [l]ower [t]han 10 
        then
            echo "${s[$i]}, ${n[$i]}"		# print the student & the note
        fi
    done
    echo
}
 

# List of choices
select choice in "Saisir les notes" "Afficher les étudiants qui ont une mention (moy supérieure 12)" "Afficher sont qui seront au rattrapage (moy < 10)" "Quitter"
do
  case $choice in
        "Saisir les notes")
			echo
            echo "Vous avez choisi l'option $REPLY : $choice"
            enterNote
            ;;
        "Afficher les étudiants qui ont une mention (moy supérieure 12)")
			echo
            echo "Vous avez choisi l'option $REPLY : $choice"
            appearMerit 
            ;;
        "Afficher sont qui seront au rattrapage (moy < 10)")
			echo
            echo "Vous avez choisi l'option $REPLY : $choice"
            appearFail
            ;;
        "Quitter")
            break
            ;;
        *) echo "L'option saisi ($REPLY) n'est pas valide.";;
    esac
done

exit



# SUJET
# Le nombre d'étudiants et le nombre de matières seront passés au script en paramètre. 

# On va créer un menu qui nous offrira les options suivantes:

# ---------------------------------
# Bonjour, veuillez faire un choix:
# 1) Saisir les notes
# 2) Afficher les étudiants qui ont une mention (moy supérieure 12)
# 3) Afficher sont qui seront au rattrapage (moy < 10)
# 4) Quitter
# ---------------------------------


# FOLLOW-UP: https://www.tutorialspoint.com/unix/shell_scripting.htm

