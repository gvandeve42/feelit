# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    feelit.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gvandeve <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2016/11/23 17:33:03 by gvandeve          #+#    #+#              #
#    Updated: 2016/11/30 23:35:57 by gvandeve         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

PATHF=~/work/fillit
IS_GOOD=FALSE

clear

echo "\033[44;1m============================================================================================="
echo "======================================== TEST FILLIT ========================================"
echo "============================================================================================="
echo
make re -C $PATHF/ && echo "\033[32;1m[COMPILATION DU FILLIT REUSSI]\033[0m" || echo "\033[31;1m/!\\ [ERREUR, FIN DU PROGRAMME] /!\\"
echo
echo "--------------------------------------------------"
echo "-------------------- ERROR TEST ------------------"
echo "--------------------------------------------------\033[0m"

for file in $(ls test_i/ | sort)
do
	echo
	echo "\033[44;1m---------- run on test_i/$file\033[0m"
	$PATHF/fillit test_i/$file > ./logs/user/invalid/user_$file.txt && \
		echo "\033[31;1m/!\\ MAUVAISE SORTIE /!\\\n[RESULTAT ENREGISTRE DANS ./logs/user/invalid/user_$file.txt]\033[0m" && \
		cat ./logs/user/invalid/user_$file.txt || \
		echo "\033[32;1m\o/ BONNE SORTIE \o/\n\033[0m"
done

echo
echo "\033[44;1m--------------------------------------------------"
echo "----------------- VALIDITY TEST ------------------"
echo "--------------------------------------------------\033[0m"

for file in $(ls test_v/ | sort)
do
	echo
	echo "\033[44;1m---------- run on test_v/$file\033[0m"
	$PATHF/fillit ./test_v/$file >  ./logs/user/valid/user_$file.txt && \
	    echo "\033[32;1m\o/ PAS D'ERREUR, EN ATTENTE DE LA DIFF \o/\n[RESULTAT ENREGISTRE DANS ./logs/user/valid/user_$file.txt]\033[0m" && \
	    cat ./logs/user/valid/user_$file.txt || \
		echo "\033[31;1m/!\\ [ERREUR, FIN DU PROGRAMME] /!\\" \
        echo
        diff ./logs/user/valid/user_$file.txt ./logs/results/result_$file > ./logs/results/diff_$file
        RESULT="$(cat ./logs/results/diff_$file)"
        if [ -z $RESULT ]
        then
            echo "\033[32;1m[ \o/ DIFF OK \o/ ]\033[0m";
            echo
        else
            echo "\033[31;1m/!\\ [ DIFF INVALIDE ] /!\\";
            echo
            cat ./logs/results/diff_$file;
            echo "\033[0m"
        fi
done

make -C $PATHF fclean;
