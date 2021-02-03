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


def encrypt(text,key):
   curr_char = ''
   result = ""
   for i in range(len(text)):
      char = text[i]
      # Encrypt uppercase characters in plain text 
      if (char.isupper()):
         curr_char = chr((ord(char) + key-65) % 26 + 65)
         result += curr_char
         print ("i= ",i, "; Plaintext = ", char, ";added = ", curr_char, "; Ciphertext: ",  result)
      # Encrypt whitespace -> Z   
      elif (char.isspace()):
         curr_char = "Z"
         result += curr_char
         print ("i= ",i, "; Plaintext = ", char, ";added = ", curr_char, "; Ciphertext: ",  result)
      # Encrypt lowercase characters in plain text
      else:
         curr_char = chr((ord(char) + key - 97) % 26 + 97)
         result += curr_char
         print ("i= ",i, "; Plaintext = ", char, ";added = ", curr_char, "; Ciphertext: ",  result)
   return result

# The chr() function returns the character that represents the specified unicode.
# The ord() function returns the number representing the unicode code of a specified character.
# lalalallaa


def decrypt(text,key):
   #TODO
   curr_char = ''
   result = ""
   for i in range(len(text)):
      char = text[i]
      # Encrypt uppercase characters in plain text 
      if (char.isupper()):
         curr_char = chr((ord(char) - key-65) % 26 + 65)
         result += curr_char
         print ("i= ",i, "; Ciphertext = ", char, ";added = ", curr_char, "; Plaintext: ",  result)
      # Encrypt whitespace -> Z   
      # elif (char.isspace()):
      #    curr_char = "Z"
      #    result += curr_char
      #    print ("i= ",i, "; Ciphertext = ", char, ";added = ", curr_char, "; Plaintext: ",  result)
      # Encrypt lowercase characters in plain text
      else:
         curr_char = chr((ord(char) - key - 97) % 26 + 97)
         result += curr_char
         print ("i= ",i, "; Ciphertext = ", char, ";added = ", curr_char, "; Plaintext: ",  result)
   return result
   


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
         #TODO: decrypt()
         filename = input('filename:\n')
         ciphertext = openFile(filename)
         print ("File content: ", ciphertext)
         #plaintext = input('enter message:\n')
         key = int(input('enter your key:\n'))
         plaintext = decrypt(ciphertext, key)
         print ('\n')
         main()

      elif option == "3":
         filename = input('filename:\n')
         ciphertext = openFile(filename)

         print ("File content: ", ciphertext)
         # print ("Plaintext : " + plaintext)
         # print ("Shift pattern : " + str(key))
         # print ("Ciphertext: ",  ciphertext)

         LETTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
         hackcaeser(ciphertext,LETTERS)

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
