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
			encrypt
			echo ''
			;;

			Decryption)
			decrypt
			echo ''

			;;

			Hack)
			hacking
			echo ''
			;;

			Exit)
			echo "Exit Succesfully"
			exit                    
		esac                        
	done
}

encrypt(){
	echo '             E N C R Y P T I O N             '
	echo '---------------------------------------------'
	newcharacter=''
	input_encrypt									#function to read file
	plainText=$text
	key=$encryptkey

	echo 'Received Plain Text is --> ' ${plainText}
	echo 'Received key is        --> ' ${key}
	length=${#plainText}            				#length of plaintext
	for ((i=0; i<length; i++))      				#iterate each character in plaintext
	do
		character=${plainText:i:1}                  #split into single char
		testing=$(printf "%d" "'${character}")      #convert to ASCII
		if [[ ${character} =~ [A-Z] ]]              #check for uppercase
	       	then
			let testing=$(($testing+key-65))        #ceaser calculation
			let testing=$(($testing%26+65))
		elif [[ ${character} == ' ' ]]				#check for whitespaces
			then
			let testing=90
		else
			let testing=$(($testing+key-97))
			let testing=$(($testing%26+97))
		fi                                         
		newcharacter=$newcharacter$(printf "\x$(printf %x $testing)")	#append encrypted result
		echo ${newcharacter}
	done                                           
	echo "Encryption Done"
}

decrypt(){
	echo '             D E C R Y P T I O N             '
	echo '---------------------------------------------'
	newcharacter=''
	input_decrypt								#function to read file	
	cipherText=$text
	key=$encryptkey

	echo 'Received Cipher Text is --> ' ${cipherText}
	echo 'Received key is         --> ' ${key}
    length=${#cipherText}						#ciphertextlength
	for ((i=0; i<length; i++))					#iterate text length
	do 
		character=${cipherText:i:1}				#split intro single char
		deci=$(printf "%d" "'${character}")		#convert to ASCII
		if [[ ${character} =~ [A-Z] ]]			#check for uppercase
		then
			let deci=$(($deci-key-65))			#ceaser calculation
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
		newcharacter=${newcharacter}$(printf "\x$(printf %x $deci)") #append decrypted result
		echo ${newcharacter}
	done
	echo "Decryption Done"
}


hacking() {
	echo '    B R U T E   F O R C E  H A C K I N G     '
	echo '---------------------------------------------'
    
	#array of 26 alphabet for brute force checking
    LETTERS=('A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z')
    letters=('a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z')
 
	input_file								#function to read file
	cipherText=$text
    echo 'Received Cipher Text is --> ' ${cipherText}
    echo ''
    cipherLength=${#cipherText}				#text length
    length=${#LETTERS[@]}					#length 26 to try all 26 keys
       
    for ((key=0; key<length; key++))        #loop for 26 keys
    do
        translated="->"
        num=0
        for ((i=0; i<cipherLength; i++))    #loop for ciphertext
        do
            cipherChar=${cipherText:i:1}	#split text into single char
            count=0
            for j in {A..Z}					#loop to find decrypted char value
            do
                if [[ $j == $cipherChar ]]	#if value found, exit
                    then
                    break
                fi
                let count=$count+1			#increment value until found
            done
        
            if grep -q ${cipherChar} <<< ${LETTERS[@]}      #check uppercase
                then
                let num=$count
                let num=$num-$key							#decrypted char value minus attempted key(0-25)
                if [[ $num<0 ]]
                    then
                    let num=$num+26
                fi
                translated=${translated}${LETTERS[$num]}
                
            elif grep -q ${cipherChar} <<< ${letters[@]}    #check lowercase
                then
                let num=$count
                let num=$num-$key							#decrypted char value minus attempted key(0-25)
                if [[ $num<0 ]]
                    then
                    let num=$num+26
                fi
                translated=${translated}{$letters[$num]}	#append brute force hack result
                
            else
                translated=${translated}${cipherChar}
            fi
        done
        echo 'Hacking Key #'$key': '$translated				#print the result per key
    done
}


input_decrypt(){
	text=''
	read -p 'Enter filename :' filename			#get file name
	read -p 'Key            :' encryptkey		#get decryption key
	txt='.txt'
	filename=$filename$txt
	echo 'File ('$filename') is being read'
	echo ''
	text=$(<$filename)							#read file content
}


input_encrypt(){
	text=''
	read -p 'Enter filename :' filename			#get file name
	read -p 'Key            :' encryptkey		#get decryption key
	txt='.txt'
	filename=$filename$txt
	echo 'File ('$filename') is being read'
	echo ''
	text=$(<$filename)							#read file content
}

input_file() {
	text=''
	read -p 'Enter filename :' filename			#get file name
	txt='.txt'
	filename=$filename$txt
	echo 'File ('$filename') is being read'
	echo ''
	text=$(<$filename)							#read file content

}

main


