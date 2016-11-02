#include <stdio.h>
#include <string.h>
#include <math.h>

int Is_Palindrome( char* Word )
{
    int i, l = strlen(Word); // l - length
    
    for( i = 0; i < ceil(l/2); i++ )
    {
        if( Word[i] != Word[l-i-1] ) return 0;  // Jeżeli słowo nie jest palindromem zwróć false
    }
    

    return 1; // Jeżeli słowo jest palindromem zwróć true
    
}

int main(void)
{
    char *Slowo;            // Wczytaj słowo
    scanf("%s", Slowo);
    
    if( Is_Palindrome(Slowo) == 1 ) printf("%s jest palidromem.", Slowo);
    else printf("%s nie jest palidromem.", Slowo);
    
    return 0;
}
