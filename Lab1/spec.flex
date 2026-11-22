// import section

%%

%class MPLexer
%function next_token
%type Yytoken

%line
%column
%debug

%eofval{
return new Yytoken( sym.EOF, null, yyline, yycolumn);
%eofval}

%{
KWTable kwTable = new KWTable();
Yytoken getKW()
{
	return new Yytoken( kwTable.find( yytext() ),
	yytext(), yyline, yycolumn );
}
%}

%xstate COMMENT

letter = [a-zA-Z]
digit = [0-9]
digits = {digit}+
exponent = E[+-]?{digits}

%%

"--" { yybegin( COMMENT ); }
<COMMENT>~"--" { yybegin( YYINITIAL ); }

[\t\n\r ] { ; }
"(" { return new Yytoken( sym.LEFTPAR, yytext(), yyline, yycolumn ); }
")" { return new Yytoken( sym.RIGHTPAR, yytext(), yyline, yycolumn ); }
"{" { return new Yytoken( sym.LEFTBRACE, yytext(), yyline, yycolumn ); }
"}" { return new Yytoken( sym.RIGHTBRACE, yytext(), yyline, yycolumn ); }

// separators
":" { return new Yytoken( sym.COLON, yytext(), yyline, yycolumn ); }
"=>" { return new Yytoken( sym.ARROW, yytext(), yyline, yycolumn ); }
"," { return new Yytoken( sym.COMMA, yytext(), yyline, yycolumn ); }
"=" { return new Yytoken( sym.ASSIGN, yytext(), yyline, yycolumn ); }
";" { return new Yytoken( sym.SEMICOLON, yytext(), yyline, yycolumn ); }

// keywords
{letter}+ { return getKW(); }

// identifiers
{letter}({letter}|{digit})* { return new Yytoken(sym.ID, yytext(),yyline, yycolumn ); }

// constants
// int
0[0-7]+ { return new Yytoken(sym.CONST, yytext(), yyline, yycolumn); }
0x[0-9a-fA-F]+ { return new Yytoken(sym.CONST, yytext(), yyline, yycolumn); }
{digits} { return new Yytoken(sym.CONST, yytext(), yyline, yycolumn); }

// float
{digits}\.{digits}?{exponent}? { return new Yytoken( sym.CONST, yytext(), yyline, yycolumn ); }
\.{digits}?{exponent}? { return new Yytoken( sym.CONST, yytext(), yyline, yycolumn ); }

// char
'[^]' { return new Yytoken( sym.CONST, yytext(), yyline, yycolumn ); }

// error handling
. { if (yytext() != null && yytext().length() > 0) System.out.println( "ERROR: " + yytext() ); }
