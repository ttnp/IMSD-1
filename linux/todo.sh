#!/bin/bash


#         PPPPPPPPPPP   PPP     PPP   PPPPPPPPPP
#         PPPPPPPPPPP   PPPP    PPP   PPPP  PPPPP
#             PPP       PPPPPP  PPP   PPPP  PPPPP
#             PPP       PPPPPPPPPPP   PPPPPPPPPP
#             PPP       PPP  PPPPPP   PPP 
#             PPP       PPP   PPPPP   PPP 
#             PPP       PPP     PPP   PPP 
#
#         M2 IMSD 2020  # Apprentie @ Groupe PSA


###################### miscellaneous ###############################################

# a little bit of decoration
colorOK="\e[32m"
colorErr="\e[5m"
colorAlert="\e[93m"
colorEnd="\e[0m"
colorSecret="\e[90m"

SEPARATOR=$(echo -e $"\035")    # note: echo -e making echo to enable interpret backslash escapes 

IS_NUMBER_REGEX='^[0-9]+$'     # 'done' (as well as 'undone') command will be reduced by using only numbers


###################### INIT FUNCTION: create & locate files #############################

# if './todo.sh' is executed, use the line below
#SAVE_DIR="${BASH_SOURCE%/*}"

# in this example, 'source todo.sh' will be executed
SAVE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
FILE_TODO_LIST="$SAVE_DIR/.todo.list"

function init {
    touch ${FILE_TODO_LIST}
    chmod +rw ${FILE_TODO_LIST}
    touch ${FILE_TODO_LIST}.saved
    chmod +rw ${FILE_TODO_LIST}.saved
}

###################### AVAILABLE FUNCTIONS ############################################

function help {
    echo ""
    echo    "  #--------------------------------------#"
    echo    "  #  Welcome to your personal todo list  #"
    echo    "  #--------------------------------------#"
    echo ""
    echo "  List of available commands:"
    echo ""
    echo "  todo list                    Shows all todos"
    echo "  todo add [content]           Adds a todo"
    echo "  todo add [number] [content]  Adds a todo at position [number]"
    echo "  [todo_number]                Marks the selected todo number as done OR undone"
    echo "  todo rm [todo_number]        Removes the selected todo"   
    echo "  todo clean                   Cleans the actual todo list"
    echo "  todo recover                 Recovers the last saved todo list"
    echo "  todo save                    Saves the actual todo list"
    echo "  help                         Sees list of available commands"
    echo "  quit                         Saves the actual list and closes the terminal"
    echo ""
}

# function to mark a task as done or reverse
function check {
    local TODO_DONE=$(sed ''"$1"'q;d' ${FILE_TODO_LIST} | cut -d ${SEPARATOR} -f2)
    local SED_SEPARATOR="s/${SEPARATOR}.*/${SEPARATOR}"
    if [[ "$TODO_DONE" == "t" ]]; then
        cat ${FILE_TODO_LIST} | sed -e ''"$1"''${SED_SEPARATOR}'f/' > tmp.list
    else
        cat ${FILE_TODO_LIST} | sed -e ''"$1"''${SED_SEPARATOR}'t/' > tmp.list
    fi
    mv tmp.list ${FILE_TODO_LIST}
    print
}

# function to appear the todo list
function print {
    local TODO_INDEX=1;
    if [[ ! -s ${FILE_TODO_LIST} ]]; then           
        echo -e "$colorErr No todos. $colorEnd" 
        echo -e "$colorSecret Type todo add [todo_content] to get started ! $colorEnd";
    else
        while IFS= read -r line
            do
                local TODO_ELEM=$(echo ${line} | cut -d ${SEPARATOR} -f1);
                local TODO_DONE=$(echo ${line} | cut -d ${SEPARATOR} -f2);
                if [[ "$TODO_DONE" == "t" ]]; then
                    echo -e "$colorOK ✓ $TODO_ELEM $colorEnd";
                else
                    echo -e "$colorSecret $TODO_INDEX $colorEnd$TODO_ELEM";
                fi
                TODO_INDEX=$(($TODO_INDEX+1));
        done < "$FILE_TODO_LIST"
    fi
}

# function to clean the entire list
function clean {
    echo -e "$colorOK Todo list is cleaned. $colorEnd"
    echo -e "$colorSecret Got mistaken? You can always use recover command to go back ! $colorEnd"
    mv ${FILE_TODO_LIST} ${FILE_TODO_LIST}.tmp
    touch ${FILE_TODO_LIST}
    chmod +x ${FILE_TODO_LIST}
    rm ${FILE_TODO_LIST}.tmp
}

# function to recover the last saved list
function recover {
    if [[ ! -f ${FILE_TODO_LIST}.saved ]]; then
        echo -e "$colorErr No todo list to recover $colorEnd"
    elif [[ ! -s ${FILE_TODO_LIST}.saved ]]; then
        echo -e "$colorErr No todo list to recover $colorEnd"
    else
        echo -e "$colorOK Recovering todos (from $FILE_TODO_LIST.saved)..."
        cp $FILE_TODO_LIST.saved $FILE_TODO_LIST
        echo -e " See below your recovered todo list"
        print
    fi
}

# function to remove a task (equivalent to the 'supprimer une tâche' requirement)
function remove {
    while true; do
        echo "Are you sure to delete the following todo entry? [Y/n]"
        echo -e " $(sed -n "${1}p" ${FILE_TODO_LIST} | cut -d ${SEPARATOR} -f1)"
        read yn
        if [[ "$yn" == "y" ]] || [[ "$yn" == "Y" ]]; then
            sed -e ''"$1"'d' ${FILE_TODO_LIST} > tmp.list
            mv tmp.list ${FILE_TODO_LIST}
            print
            break
        elif [[ "$yn" == "n" ]] || [[ "$yn" == "N" ]]; then
            break
        else
            echo -e "$colorAlert Please answer 'y' or 'n' $colorEnd"
        fi
     done
}

# function to save the actual list (without having to quit the program)
function save {
    echo -e "$colorOK Your todo list is saved !"
    cp $FILE_TODO_LIST $FILE_TODO_LIST.saved
}

# add a task in the list, then use print to appear the list
function add {
    echo -e "$@ ${SEPARATOR}f" >> ${FILE_TODO_LIST}
    print
}

# add a task in a specific position 
function mani {
    head -n $((${1}-1)) ${FILE_TODO_LIST} > tmp.list
    echo "${@:2} ${SEPARATOR}f" >> tmp.list
    tail -n +${1} ${FILE_TODO_LIST} >> tmp.list
    mv tmp.list ${FILE_TODO_LIST}
    print
}

# Quits, saves the actual list and closes the terminal
function quit {
    cp $FILE_TODO_LIST $FILE_TODO_LIST.saved
    echo -e " Have a productive day, don't procrastinate !"
    echo -e "$colorErr Your todo list is saved. Closing the terminal... $colorEnd"
    sleep 2.5
    exit
}


###################### initialization in the first place #################

if [[ ! -f ${FILE_TODO_LIST} ]]; then
    init
fi


###################### TODO FUNCTION ##################################### 

function todo {
    if [[ "${1}" ]]; then
        if [[ ${1} =~ ${IS_NUMBER_REGEX} ]]; then
            check ${1}
        elif [[ ${1} = "" ]] || [[ ${1} = "help" ]]; then
            help
        elif [[ ${1} = "list" ]]; then
            print
        elif [[ ${1} = "clean" ]] || [[ ${1} = "clear" ]]; then
            clean
        elif [[ ${1} = "recover" ]]; then
            recover
        elif [[ ${1} = "save" ]]; then
            save
        elif [[ ${1} = "add" ]]; then
            # write here to check if $2 is a number
            if [[ ${2} =~ ${IS_NUMBER_REGEX} ]]; then
                mani ${@:2}
            else
                add ${@:2}
            fi
        elif [[ ${1} = "rm" ]]; then
            remove ${2}
        else
            echo -e "Unknown command: ${1}. Please choose again."
            help
        fi
    else
        help
    fi
}


###################### handle user's input ###############################
case $1 in
    todo)
        shift
        todo
        ;;
    quit)
        quit
        break
        ;;
    *) 
        help
        ;;
esac


###################### FOLLOW-UP ###############################

# These sites were highly consulted during the making of this project

# https://ineumann.developpez.com/tutoriels/linux/exercices-shell/
# https://www.cyberciti.biz/faq/unix-for-loop-1-to-10/

# https://www.tutorialspoint.com/unix/unix-what-is-shell.htm
# https://tldp.org/LDP/abs/html/abs-guide.html

# https://stackoverflow.com/questions/59895/how-to-get-the-source-directory-of-a-bash-script-from-within-the-script-itself
# https://www.cyberciti.biz/faq/create-a-file-in-linux-using-the-bash-shell-terminal/
# https://www.garron.me/en/linux/add-line-to-specific-position-in-file-linux.html
# https://stackoverflow.com/questions/6537490/insert-a-line-at-specific-line-number-with-sed-or-awk
