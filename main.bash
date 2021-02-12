#!/bin/bash

main(){
	echo '-------------------------------------------- '
	echo '           Clasical Cipher Program           '
	echo '---------------------------------------------'
	echo '           Please select and option          '
	echo '                                             '
	select opt in Encryption Decryption Hack Exit; do
	echo '                                             '
	echo '---------------------------------------------'
	#user then pick to what he wanted to do

		case $opt in
			Encryption)
			#encryption timeee
			encrypt
			;;

			Decryption)
			#decryption timeee
			decrypt
			;;

			Hack)
			#hacking timeee
			hacking
			;;

			Exit)
			#exit the program
			echo "Exit Succesfully"
			exit                    
		esac                        #close case
	done
}

encrypt(){
	input_encrypt
	echo ${plainText}
	echo ${key}
	length=${#plainText}            # = length
	for ((i=0; i<length; i++))      # for do loop ada 2 (())
	do
		character=${plainText:i:1}                  #content in index (i:1 = i iterate one)
		testing=$(printf "%d" "'${character}")      #index array
		if [[ ${character} =~ [A-Z] ]]              # =~ --> content is in array/etc
	       	then
			let testing=$(($testing+key-65))        # let is need in math operation       
			let testing=$(($testing%26+65))
		else
			let testing=$(($testing+key-97))
			let testing=$(($testing%26+97))
		fi                                          #tutup if
		newcharacter=$(printf "\x$(printf %x $testing)")
		echo ${newcharacter}
	done                                            #tutup for
	echo "Encryption Done"
}

decrypt(){
	input_decrypt
	echo ${cipherText}
	echo ${key}
       	length=${#cipherText}
	for ((i=0; i<length; i++))
	do 
		character=${cipherText:i:1}
		deci=$(printf "%d" "'${character}")
		if [[ ${character} =~ [A-Z] ]]
		then
			let deci=$(($deci-key-65))
			if [[ ${deci} -lt 0 ]]
			then
				let deci=$(($deci%26+26+65))
			else
				let deci=$(($deci%26+65))
			fi
		else
			let deci=$(($deci-key-97))
			if [[ ${deci} -lt 0 ]]
			then
				let deci=$(($deci%26+26+97))
				
			else
				let deci=$(($deci%26+97))
			fi
		fi
		newcharacter=$(printf "\x$(printf %x $deci)")
		echo ${newcharacter}
	done
	echo "Decryption Done"
}


hacking() {
    
    LETTERS=('A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z')
    letters=('a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z')
 
    read -p 'Enter Ciphertext: ' cipherText
    echo 'Received Cipher Text is --> ' ${cipherText}
    
    cipherLength=${#cipherText}
    length=${#LETTERS[@]}
    echo $length
       
    for ((key=0; key<length; key++))                    #for loop to iterate [A-Z]
    do
        translated="->"
        num=0
        for ((i=0; i<cipherLength; i++))   #for loop to iterate cipherText
        do
            cipherChar=${cipherText:i:1}
            count=0
            for j in {A..Z}
            do
                if [[ $j == $cipherChar ]]
                    then
                    break
                else
                fi
                let count=$count+1
            done
        
            if grep -q ${cipherChar} <<< ${LETTERS[@]}       #check upper()
                then
                let num=$count
                let num=$num-$key
                if [[ $num<0 ]]
                    then
                    let num=$num+26
                fi
                translated=${translated}${LETTERS[$num]}
                
            elif grep -q ${cipherChar} <<< ${letters[@]}     #check lower()
                then
                let num=$count
                let num=$num-$key
                if [[ $num<0 ]]
                    then
                    let num=$num+26
                fi
                translated=${translated}{$letters[$num]}
                
            else
                translated=${translated}${cipherChar}
            fi
        done
        echo 'Hacking Key #'$key': '$translated
    done
}


input_decrypt(){
	read -p 'Ciphertext:' cipherText
	read -p 'Key       :' key
}


input_encrypt(){
	read -p 'Plaintext :' plainText
	read -p 'Key       :' key
}



main


