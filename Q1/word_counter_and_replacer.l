%{
#include <stdio.h>
int word_count = 0;
int total_size = 0;
%}

%%

[a-zA-Z]+ {
  word_count++;
  total_size += yyleng;
  int i;
  for (i = 0; i < yyleng; i++) {
    if (yytext[i] == 'a' && yytext[i+1] == 'b' && yytext[i+2] == 'c') {
      printf("ABC");
      i += 2;
    } else {
      printf("%c", yytext[i]);
    }
  }
}

[ \t\n]+  { printf("%s", yytext); }  // Preserves and prints whitespace characters

.         { printf("%s", yytext); }  // Prints any other characters as it is

%%

int main(int argc, char *argv[]) {
  if (argc != 2) {
    printf("Usage: %s file_name\n", argv[0]);
    return 1;
  }

  FILE *fp = fopen(argv[1], "r");
  if (fp == NULL) {
    printf("Failed to open file: %s\n", argv[1]);
    return 1;
  }

  yyin = fp;
  yylex();

  printf("\nNumber of words: %d\n", word_count);
  printf("Total size of words: %d\n", total_size);

  fclose(fp);
  return 0;
}

int yywrap() {
    return 1;
}
