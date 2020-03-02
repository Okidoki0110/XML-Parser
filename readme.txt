Corcodel Denisa 336CC                                                       
                                                            Tema LFA
                                                                        Parser XML

Rulare :
	make build - se creeaza executabilul output
    ./output < input_exemplu*.in (* = 1 | 2 | 3 | 4 | 5) pentru fiecare test
	make clean - se sterge executabilul si fisierul lex.yy.c

S-au definit starile:
    INITIAL:
        - starea default din care pleaca problema
        - daca s-a gasit inceputul unui comentariu trecem in starea IGNORE
        - daca s-a gasit caracterul "<" urmat de un text trecem in starea ELEMENT1
        - daca s-a gasit caracterul "</" trecem in starea ELEMENT2
        - daca s-a gasit text, il retinem in variabila textFrunza (este posibil sa fie textul unui nod frunza in arborele DOM)
        - daca textul din tag-ul curent corespunde cu cel din lastTagFE, atunci avem tag-uri frati (trebuiau numerotati incepand cu numarul 0)
        - se retine textul tag-ului in firstTagLE (tag de deshidere, ultimul element)
        - s-a incercat numerotarea elementelor adicente care au acelasi tag, prin retinerea ultimului tag citit si compararea acestuia cu tag-ul curent (deschis)
    IGNORE :
        - starea de ignorare a comentariilor
        - daca s-a gasit text il ignoram
        - daca s-a gasit sfarsitul unui comentariu ne intoarcem in starea initiala
    ELEMENT1 :
        - starea in care suntem intr-un tag de inceput
        - daca am gasit un text diferit de caracterele "<" si ">", inseamna ca acesta  este un atribut si il afisam corespunzator
        - daca am gasit caracterele = si " urmat de un text si de caracterul ", atunci avem valoarea unui atribut si o afisam corespunzator
        - daca s-au gasit spatii le ignoram
        - daca s-a gasit caracterul ">" se revine in starea initiala
    ELEMENT2 :
        - starea in care suntem intr-un tag de sfarsit
        - daca s-au gasit spatii le ignoram
        - daca s-a gasit caracterul ">" se revine in starea initiala
        - daca s-a gasit un text urmat de caracterul ">" se verifica daca este frunza, si se seteaza variabila frunza la true sau false. De asemenea se copiaza textul tag-ulu inchis 
        in variabila lastTagFE (tag de inchidere, primul element)
        - daca ultimul tag deschis are acelasi nume cu tag-ul curent, inseanmna ca avem o frunza, si o afisam corespunzator


S-au definit constantele:
1. start_ignore - incepe ignorarea comentariilor
2. stop_ignore - opreste ignorarea comentariilor
3. start_first_elem - incepe recunoasterea unui tag de deschidere
4. end_first_elem - opreste recunoasterea unui tag de deschidere
5. start_first_elem - incepe recunoasterea unui tag de inchidere
6. end_first_elem - opreste recunoasterea unui tag de inchidere
7. space - incepe recunoasterea unui spatiu
8. start_atribut - incepe recunoasterea unui atribut
9. end_atribut - opreste recunoasterea unui atribut