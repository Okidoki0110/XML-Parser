/*** Corcodel Denisa 336CC ***/

%{

int identare=1;
int nrElemente=0;
int elementCurent = 0;
char listaElemente[100][20];
char listaTags[100][20];
int nListaTags = 0;
int nListaElemente[100]={0};
int nrListaElemente = 0;
char text[2000];
char tagReferinta[100];
char textFrunza[100];
char lastTagFE[100];
int nlastTagFE=100;
char firtTagLE[100];
int nfirtTagLE=100;
int nLista;
char temp1[100];
char temp2[100];
int frunza=0;

%}

start_ignore "<!"|"<?"
stop_ignore ">"
start_first_elem "<"[^<>!?\n\t\r /]*
end_first_elem ">"
start_last_elem "</"
end_last_elem [^<> !?\n\t\r]*">"
space [ \n\t\r]*
start_atribut [^<> !?\n\t\r\"]*"="
end_atribut "\""[^<> !?\n\t\r]*"\""
elem "<"[^<> !?\n\t\r /]*">"

%x IGNORE ELEMENT1 ELEMENT2 TXT ATTR

%%

<INITIAL>{start_ignore}             			{BEGIN(IGNORE);}
<IGNORE>[^>]*                       			{}
<IGNORE>{stop_ignore}               			{BEGIN(0);}
<INITIAL>{start_first_elem} 					{
												strncpy(temp1,lastTagFE,nlastTagFE-1);
												strncpy(temp2,yytext+1,yyleng-1);				

												temp1[nlastTagFE-1]='\0';
												temp2[yyleng-1]='\0';
												
												strcpy(firtTagLE,temp2);
												nfirtTagLE = strlen(temp2);												
												if (strncmp(temp1,temp2,nlastTagFE-1)==0)
												{	
													if (strcmp(tagReferinta,temp1)!=0){
														strcpy(tagReferinta,temp1);
														nrElemente = 1;
														elementCurent = 0;
													}
													else {
														nrElemente++;
													}
													elementCurent++;
												}
												printf("\n");
												for (int i=0;i<identare;i++){
													printf("\t");
												}
												identare++;
												if (!frunza && strcmp(temp2,"to") != 0 ){
													printf("<%s>",temp2);
												}
												BEGIN(ELEMENT1);
												}
<INITIAL>{start_last_elem} 						{
													BEGIN(ELEMENT2);
												}
<INITIAL>[^<>\n\t\r\"]*							{
													strcpy(textFrunza,yytext);
												}

<INITIAL>{space} 								{}


<ELEMENT1>[^<> \n\t\r\="]*						{
													printf("\n");
													for (int i=0;i<identare-1;i++){
														printf("\t");
													}
													printf("_%s:",yytext);
												}
<ELEMENT1>"=\""[^<> \n\t\r\"]*"\""   			{
													yytext[0]=' ';
													yytext[1]=' ';
													yytext[yyleng-1]=' ';
													printf("%s\n",yytext);
												}
<ELEMENT1>{space}								{}
<ELEMENT1>{end_first_elem}						{BEGIN(0);}

<ELEMENT2>[^<> \n\t\r\"]*						{}
<ELEMENT2>{space}								{}
<ELEMENT2>{end_last_elem}						{
												if (strncmp(firtTagLE,yytext,strlen(firtTagLE))==0){
													frunza = 1;
												}else {
													frunza = 0;
												}
												
												if (frunza)
													{	
														printf("%s : %s",temp2,textFrunza);												
													}
												strcpy(lastTagFE,yytext);
												nlastTagFE = yyleng;
												identare--;
												BEGIN(0);
												}
%%

int main() { 
	printf("%s","<root>");
	yylex();
	for (int i=0;i<nLista;i++){
		printf("%s\n",listaElemente[i]);
	}
}


