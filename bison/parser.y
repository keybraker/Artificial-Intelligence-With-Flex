%{

    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <assert.h>

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

    enum stikser {

        comma,
        teleia,
        erotimatiko,
        anokatoteleia,
        thaumastiko,
        paula,
        openpar,
        closepar, 
        enter

    };


    char* getPunctuation(int punc){

        switch (punc) {
            case 0:     return ","; break;
            case 1:     return "."; break;
            case 2:     return ";"; break; 
            case 3:     return ":"; break;
            case 4:     return "!"; break; 
            case 5:     return "_"; break;
            case 6:     return "("; break; 
            case 7:     return ")"; break;
            case 8:     return "["; break; 
            case 9:     return "]"; break;
            case 10:    return "{"; break; 
            case 11:    return "}"; break;
            case 12:    return "+"; break; 
            case 13:    return "-"; break;
            case 14:    return "*"; break; 
            case 15:    return "/"; break;
            case 16:    return "="; break; 
            case 17:    return "\n"; break;

            default:    exit(0);
        }

    }

    int yylex       (void);
    int yyerror     (char* yaccProvidedMessage);
    
    extern FILE*    yyin;
    extern FILE*    yyout;
    extern char*    yytext;
    extern int      yylineno;

%}

%union{
    
    char*   leksi;

    char*   epitheto;
    char*   ousiastiko;
    char*   arthro;

    int     stiksi;

    double  arithmos;

}

%start              PROTASI

%type<leksi>        LLEKSI MEROSLOGOU LEKSEIS
%type<stiksi>       LSTIKSI
%type<arithmos>     LARITHMOS 
%type<arthro>       LARTHRO

%token<epitheto>    EPITHETO
%token<ousiastiko>  OUSIA
%token<arthro>      ARSENIKO_ARTHRO THILIKO_ARTHRO OUDETERO_ARTHRO 

%token<leksi>       LEKSI 
%token<stiksi>      STIKSI
%token<arithmos>    ARITHMOS 

%%

    PROTASI:    LEKSEIS            { printf("|----->Η ολοκληρωμένη πρόταση είναι: %s\n",$<leksi>1); }
                ;

    LEKSEIS:    LEKSEIS MEROSLOGOU {    
                                        printf("$$ = %s\n", $$);
                                        printf("$1 = %s\n", $1);
                                        printf("$2 = %s\n", $2);
                                        
                                        if($$ == NULL && $1 == NULL && $2 != NULL){
                                            $$ = calloc(strlen($2),sizeof(char));
                                            strcpy($$,$2); 

                                        }else if($$ != NULL && $1 != NULL && $2 != NULL){
                                            char* tmp = $$;
                                            $$ = calloc(strlen($$)+strlen($2),sizeof(char));
                                            strcpy($$, tmp); strcat($$, " "); 
                                            strcat($$, $2);

                                        }

                                        
                                        printf("|---->λέξεις μέρος του λόγου: %s\n\n",$$);
                                    }
                |                   
                ;

    MEROSLOGOU: LLEKSI      { $<leksi>$ = $<leksi>1; printf("|--->Το μέρος του λόγου είναι: %s\n",($$)); }
                |LARTHRO    { $<leksi>$ = $<arthro>1; printf("|--->Το μέρος του λόγου είναι: %s\n",($$)); }
                |LARITHMOS  { /*sprintf($$, "%d", $1);*/ }
                |LSTIKSI    { $$ = strdup(getPunctuation($1)); printf("|--->Το μέρος του λόγου είναι: %s\n",($$));/*switch case*/}


    LLEKSI:     LEKSI       { $<leksi>$ = yylval.leksi; printf("|-->λέξη είναι: %s\n",(yylval.leksi)); }

    LARTHRO:    ARSENIKO_ARTHRO     { $<arthro>$ = yylval.arthro; printf("|-> αρσενικό άρθρο είναι: %s\n",(yylval.arthro)); }
                |THILIKO_ARTHRO     { $<arthro>$ = yylval.arthro; printf("|-> θηλυκό άρθρο είναι: %s\n",(yylval.arthro)); }
                |OUDETERO_ARTHRO    { $<arthro>$ = yylval.arthro; printf("|-> ουδέτερο άρθρο είναι: %s\n",(yylval.arthro)); }

    LARITHMOS:  ARITHMOS    { $<arithmos>$ = yylval.arithmos; printf("|->αριθμός είναι: %f\n",(yylval.arithmos)); }

    LSTIKSI:    STIKSI      { $<stiksi>$ = yylval.stiksi; printf("|->σημείο στίξης είναι: %d\n",(yylval.stiksi)); }

%%


int yyerror (char* yaccProvidedMessage){
   
   printf("%s\n", yaccProvidedMessage);
   return 0;

}

int main(int argc, char** argv){
    
    if(argc > 2){
        if(!(yyin = fopen(argv[1], "r"))){
            fprintf(stderr,"Cannot read file: %s\n",argv[1]);
            return 1;
        }
        if(!(yyout = fopen(argv[2], "w"))){
            fprintf(stderr,"Cannot write file: %s\n",argv[1]);
            return 1;
        }
        stdout = yyout ;
    }
    else if(argc > 1){

        if(!(yyin = fopen(argv[1], "r"))){
            fprintf(stderr,"Cannot read file: %s\n",argv[1]);
            return 1;
        }

    }
    else{
        yyin = stdin;
    }

    yyparse();

    return 0;
}
