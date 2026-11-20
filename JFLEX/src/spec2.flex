%%

%class MPLexer2
%function next_token
%line
%column
%debug
%type Yytoken

%eofval{
return new Yytoken(sym.EOF, null, yyline, yycolumn);
%eofval}

%xstate COMMENT

letter = [a-zA-Z]
digit = [0-9]
identifier = {letter}({letter}|{digit})*
realConstant = {digit}+"."{digit}(E[+-]?{digit}+)?
base2 = 2"#"[01]+
base8 = 8"#"[0-7]+
base16 = 16"#"[0-9A-Fa-f]+

decimalInteger = {digit}+

%%

"/**"                    { yybegin(COMMENT); }
<COMMENT>[^*]+           { ; }
<COMMENT>"*"+"/"        { yybegin(YYINITIAL); }




[\t\n\r ]+              { ; }

"main"                   { return new Yytoken(sym.MAIN, yytext(), yyline, yycolumn); }
"int"                    { return new Yytoken(sym.INTEGER, yytext(), yyline, yycolumn); }
"real"                   { return new Yytoken(sym.REAL, yytext(), yyline, yycolumn); }
"boolean"                { return new Yytoken(sym.BOOLEAN, yytext(), yyline, yycolumn); }
"if"                     { return new Yytoken(sym.IF, yytext(), yyline, yycolumn); }
"elif"                   { return new Yytoken(sym.ELIF, yytext(), yyline, yycolumn); }
"else"                   { return new Yytoken(sym.ELSE, yytext(), yyline, yycolumn); }
"true"|"false"           { return new Yytoken(sym.CONST, yytext(), yyline, yycolumn); }

\(                       { return new Yytoken(sym.LEFTPAR, yytext(), yyline, yycolumn); }
\)                       { return new Yytoken(sym.RIGHTPAR, yytext(), yyline, yycolumn); }
\{                       { return new Yytoken(sym.LEFTCURL, yytext(), yyline, yycolumn); }
\}                       { return new Yytoken(sym.RIGHTCURL, yytext(), yyline, yycolumn); }
"<="                    { return new Yytoken(sym.LE, yytext(), yyline, yycolumn); }
"=="                    { return new Yytoken(sym.EQ, yytext(), yyline, yycolumn); }
"<>"                    { return new Yytoken(sym.NE, yytext(), yyline, yycolumn); }
">="                    { return new Yytoken(sym.GE, yytext(), yyline, yycolumn); }
"<"                     { return new Yytoken(sym.LT, yytext(), yyline, yycolumn); }
">"                     { return new Yytoken(sym.GT, yytext(), yyline, yycolumn); }
":="                    { return new Yytoken(sym.ASSIGN, yytext(), yyline, yycolumn); }
":"                     { return new Yytoken(sym.COLON, yytext(), yyline, yycolumn); }
";"                     { return new Yytoken(sym.SEMICOLON, yytext(), yyline, yycolumn); }

{realConstant}           { return new Yytoken(sym.CONST, yytext(), yyline, yycolumn); }
{base2}|{base8}|{base16}    { return new Yytoken(sym.CONST, yytext(), yyline, yycolumn); }
{decimalInteger}         { return new Yytoken(sym.CONST, yytext(), yyline, yycolumn); }
{identifier}             { return new Yytoken(sym.ID, yytext(), yyline, yycolumn); }

.                        { System.out.println("ERROR at line " + (yyline + 1)
                              + ", column " + (yycolumn + 1) + ": " + yytext()); }
