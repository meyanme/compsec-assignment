# -*- coding: utf-8 -*-
"""
Created on Wed Dec 23 11:59:50 2020

@author: Computer Security (TSN3251)  Trimester 2022
"""
#https://www.tutorialspoint.com/cryptography_with_python/cryptography_with_python_caesar_cipher.htm
import os
import sys


def openFile(textfile):
   file_content = ""
   file_name = textfile+'.txt'
   if (os.path.exists(file_name)):
      with open(file_name, 'r+') as file:
         try:
            line_in_file = file.readlines()
            for line in line_in_file:
               file_content+=line
            return file_content
         except:(FileNotFoundError)


def encrypt(text,s):
   curr_char = ''
   result = ""
   for i in range(len(text)):
      char = text[i]
      # Encrypt uppercase characters in plain text 
      if (char.isupper()):
         curr_char = chr((ord(char) + s-65) % 26 + 65)
         result += curr_char
         print ("i= ",i, "; Plaintext = ", char, ";added = ", curr_char, "; Ciphertext: ",  result)
      # Encrypt lowercase characters in plain text
      else:
         curr_char = "Z"
         result += curr_char
         print ("i= ",i, "; Plaintext = ", char, ";added = ", curr_char, "; Ciphertext: ",  result)
   return result

# The chr() function returns the character that represents the specified unicode.
# The ord() function returns the number representing the unicode code of a specified character.
# lalalallaa



def hackcaeser(message,LETTERS):
   for key in range(len(LETTERS)):
      translated = ''  
      for symbol in message:
         if symbol in LETTERS:
            num = LETTERS.find(symbol)
            num = num - key
            if num < 0:
               num = num + len(LETTERS) #26 
            translated = translated + LETTERS[num]
         else:
            translated = translated + symbol
      print('Hacking key #%s: %s' % (key, translated))



def main():
   while True:
      print ("#1: Encrypt from file")
      print ("#2: Decrypt from file")
      print ("#3: Hack cipher with brute force")
      print ("#4: Exit")
      
      option = input("\tOption = ")
      print()
   
      if option == "1":
         filename = input('filename:\n')
         plaintext = openFile(filename)
         print ("File content: ", plaintext)
         #plaintext = input('enter message:\n')
         key = int(input('enter your key:\n'))
         ciphertext = encrypt(plaintext, key)
         print ('\n')
         main()

      elif option == "2":
         pass
         #TODO: DECRYPTFUNCTION

      elif option == "3":
         pass
         print ("Plaintext : " + plaintext)
         print ("Shift pattern : " + str(key))
         print ("Ciphertext: ",  ciphertext)

         message = ciphertext                        #encrypted message
         LETTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
         hackcaeser(message,LETTERS)

      elif option == "4": 
         break

      else:
         print ("Invalid Input\n\n")
         continue
     
   

   
   #text = "CEASER CIPHER DEMO"
   #s = 4

   


# Executes the main function
if __name__ == '__main__':
    main()
