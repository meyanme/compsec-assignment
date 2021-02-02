# -*- coding: utf-8 -*-
"""
Created on Wed Dec 23 11:59:50 2020

@author: Computer Security (TSN3251)  Trimester 2022
"""
#https://www.tutorialspoint.com/cryptography_with_python/cryptography_with_python_caesar_cipher.htm
def encrypt(text,s):
   curr_char = ''
   result = ""
   # transverse the plain text
   for i in range(len(text)):
      char = text[i]
      # Encrypt uppercase characters in plain text 
      if (char.isupper()):
         curr_char = chr((ord(char) + s-65) % 26 + 65)
         result += curr_char
         print ("i= ",i, "; Plaintext = ", char, ";added = ", curr_char, "; Ciphertext: ",  result)
      # Encrypt lowercase characters in plain text
      else:
         #result += chr((ord(char) + s - 97) % 26 + 97)
         curr_char = "Z"
         result += curr_char
         print ("i= ",i, "; Plaintext = ", char, ";added = ", curr_char, "; Ciphertext: ",  result)
   return result
#check the above function

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
   #return [key, translated]

def main():
    #message = 'THE GERMAN ATTACK'
    #key = 'SECRET'
    plaintext = input('enter message:\n')
    #message=message.replace(" ", "") # removes spaces
    #plaintext=plaintext.upper()  # coverts all text to uppercase
    key = int(input('enter your key:\n'))
    #key=key.upper()
    ciphertext = encrypt(plaintext, key)
    print ('\n')
    #text = "CEASER CIPHER DEMO"
    #s = 4

    print ("Plaintext : " + plaintext)
    print ("Shift pattern : " + str(key))
    print ("Ciphertext: ",  ciphertext)

    message = ciphertext #encrypted message
    LETTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    #hacked=hackcaeser(message,LETTERS)
    hackcaeser(message,LETTERS)
    #print (hacked)


# Executes the main function
if __name__ == '__main__':
    main()
