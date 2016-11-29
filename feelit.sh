# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    feelit.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gvandeve <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2016/11/23 17:33:03 by gvandeve          #+#    #+#              #
#    Updated: 2016/11/29 14:54:19 by gvandeve         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

PATHF=~/work/fillit

clear

make re -C $PATHF/

gcc -o f_strerror ./strerror/strerror.c

echo "\033[44;1m============================================================================================="
echo "======================================== TEST FILLIT ========================================"
echo "============================================================================================="
echo
echo "--------------------------------------------------"
echo "-------------------- ERROR TEST ------------------"
echo "--------------------------------------------------\033[0m"

for file in $(ls test_i/ | sort)
do
	echo
	echo "\033[44;1m---------- run on test_i/$file"
	$PATHF/fillit test_i/$file
	result=$(echo $?)
	echo $(./f_strerror $result)
	if [ $result == 1 ]
	then
		echo "\033[32;1mOK\033[0m"
	else
		echo "\033[31;1mKO\033[0m"
	fi
done

echo
echo "\033[44;1m--------------------------------------------------"
echo "----------------- VALIDITY TEST ------------------"
echo "--------------------------------------------------\033[0m"

for file in $(ls test_v/ | sort)
do
	echo
	echo "\033[44;1m---------- run on test_i/$file"
	$PATHF/fillit test_v/$file
	result=$(echo $?)
	echo $(./f_strerror $result)
	if [ $result == 0 ]
	then
		echo "\033[32;1mOK\033[0m"
	else
		echo "\033[31;1mKO\033[0m"
	fi
done
