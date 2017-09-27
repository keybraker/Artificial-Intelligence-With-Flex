#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "wordExifStruct.h"

#define UNDER     "\033[4m"
#define DEUNDER   "\033[0m"
#define a_c_r     "\x1b[31m"
#define a_c_g     "\x1b[32m"
#define a_c_y     "\x1b[33m"
#define a_c_b     "\x1b[34m"
#define a_c_m     "\x1b[35m"
#define a_c_c     "\x1b[36m"
#define a_c_re    "\x1b[0m"
#define under     "\e[4m"
#define under_re  "\e[0m"
#define italic    "\e[3m"
#define italic_re "\e[0m"
#define bold      "\e[1m"
#define bold_re   "\e[0m"

char *deleteSlashN(char* withSlashN){
  strtok(withSlashN, "\n");
  return withSlashN;
}

int toInt(char a[]) {
  int c, sign, offset, n;
 
  if (a[0] == '-') {  // Handle negative integers
    sign = -1;
  }else{
    sign = 0;
  }
 
  if (sign == -1) {  // Set starting position to convert
    offset = 1;
  }
  else {
    offset = 0;
  }
 
  n = 0;
 
  for (c = offset; a[c] != '\0'; c++) {
    n = n * 10 + a[c] - '0';
  }
 
  if (sign == -1) {
    n = -n;
  }
 
  return n;
}

// #0
void printRima(char* rima){

  int  Xronos, Prosopos, Arithmos, Klisi, Foni;
  char *word;

      strtok(rima, "|");
  word    = strtok(NULL, "|");
      strtok(NULL, "|");
      strtok(NULL, "|");
      strtok(NULL, "|");

  Xronos  = toInt(strtok(NULL, "|"));
  Prosopos  = toInt(strtok(NULL, "|"));
  Arithmos  = toInt(strtok(NULL, "|"));
  Klisi   = toInt(strtok(NULL, "|"));
  Foni    = toInt(strtok(NULL, "|"));

  printf("%s (" , word);
  printf(italic bold "ρήμα, %s πρόσωπο %s %s, %s φώνης, %s κλίσης"DEUNDER, prosopo[Prosopos], arithmos[Arithmos], xronos[Xronos], foni[Foni], klisi[Klisi]);
  printf(") ");

}

// #1
void printEpitheto(char* epitheto){

  int  Genos, Arithmos, Ptosi;
  char *word;

              strtok(epitheto, "|");
  word      = strtok(NULL, "|");
              strtok(NULL, "|");
              strtok(NULL, "|");
        strtok(NULL, "|");

  Genos   = toInt(strtok(NULL, "|"));
  Arithmos  = toInt(strtok(NULL, "|"));
  Ptosi   = toInt(strtok(NULL, "|"));

  printf("%s (" , word);
  printf(italic bold "επίθετο, %s αριθμου , γένος %s , %s πτώση"DEUNDER, arithmos[Arithmos], genos[Genos], ptosi[Ptosi]);
  printf(") ");
}

// #2
void printOusiastiko(char* ousiastiko){

  int  Genos, Arithmos, Ptosi;
  char *word;

              strtok(ousiastiko, "|");
  word      = strtok(NULL, "|");
              strtok(NULL, "|");
              strtok(NULL, "|");
              strtok(NULL, "|");

  Genos     = toInt(strtok(NULL, "|"));
  Arithmos  = toInt(strtok(NULL, "|"));
  Ptosi     = toInt(strtok(NULL, "|"));

  printf("%s (" , word);
  printf(italic bold "ουσιαστικό, %s αριθμου , γένος %s , %s πτώση"DEUNDER, arithmos[Arithmos], genos[Genos], ptosi[Ptosi]);
  printf(") ");

}

// #3
void printMetoxi(char* metoxi){

  strtok(metoxi, "|");
  char *word  = strtok(NULL, "|");

  printf("%s (" , word);
  printf(italic bold "μετοχή" DEUNDER);
  printf(") ");
}

// #4
void printArithmitika(char* arithmitika){

  strtok(arithmitika, "|");
  char *word  = strtok(NULL, "|");
            strtok(NULL, "|");
            strtok(NULL, "|");
            strtok(NULL, "|");

  int actualNum = toInt(strtok(NULL, "|"));

  printf("%s (", word);
  printf(italic bold "αριθμητικό, με πραματική τιμή: %d"DEUNDER, actualNum);
  printf(") ");

}

// #5
void printEpirima(char* epirima){

  int  Katigoria;
  char *word;

              strtok(epirima, "|");
  word      = strtok(NULL, "|");
              strtok(NULL, "|");
              strtok(NULL, "|");
              strtok(NULL, "|");

  Katigoria = toInt(strtok(NULL, "|"));

  printf("%s (", word);
  printf(italic bold "%s επίρρημα"DEUNDER, epirimata[Katigoria]);
  printf(") ");

}

// #6
void printSundesmo(char* sundesmo){

  int  Katigoria;
  char *word;

              strtok(sundesmo, "|");
  word      = strtok(NULL, "|");
              strtok(NULL, "|");
              strtok(NULL, "|");
              strtok(NULL, "|");

  Katigoria = toInt(strtok(NULL, "|"));

  printf("%s (", word);
  printf(italic bold "%s σύνδεσμος"DEUNDER, sundesmos[Katigoria]);
  printf(") ");
}

// #7
void printAntonimia(char* antonimia){

  strtok(antonimia, "|");
  char *word  = strtok(NULL, "|");

  printf("%s (", word);
  printf(italic bold "αντωνυμία"DEUNDER);
  printf(") ");
}

// a k r a i o 
typedef void (*f)(char*); 
f functionPrinter[8] = {
  &printRima,
  &printEpitheto,
  &printOusiastiko,
  &printMetoxi,
  &printArithmitika, 
  &printEpirima,
  &printSundesmo,
  &printAntonimia
 }; 
// a k r a i o 

