#include <stdio.h>
#include <string.h>
#include <math.h>

int nwd(int a, int b) {
    
    if (0 <= a,b <= 1000000) {
        int pom;
        while (b != 0) {
            pom = b;
            b = a%b;
            a = pom;
        }
    } else {
        return -1;
    }
    
    
    
    return a;
}

int main(void)
{
    int a;
    int b;
    int p;
    int c;
    
    scanf("%i", &p);
    
    for (int i = 0; i < p; i++) {
        scanf("%i %i", &a, &b);
        c = nwd(a,b);
        printf("%i \n", c);
    }
    
    return 0;
}