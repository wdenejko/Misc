#include <stdio.h>

int main() {
    int array[100];
    int n;
    int c;
    int d;
    int possition;
    int swap;
    
    printf("Podaj liczbe elementow do posortowania \n");
    scanf("%d", &n);
    
    printf("Podaj %d liczb \n", n);
    
    for (c = 0; c < n; c++) {
        scanf("%d", &array[c]);
    }
    
    for (c = 0; c < (n-1); c++) {
        possition = c;
        
        for (d = c + 1; d < n; d++) {
            if (array[possition] > array[d]) {
                possition = d;
            }
            
            if (possition != c) {
                swap = array[c];
                array[c] = array[possition];
                array[possition] = swap;
            }
        }
    }
    
    printf("Posortowana tablica: \n");
    
    for (c = 0; c < n; c++) {
        printf(" %d\n", array[c]);
    }
    
    return 0;
}