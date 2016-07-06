#include <stdio.h>

int main()
{
    int array[100];
    int n;
    int c;
    int d;
    int swap;
    
    printf("Podaj liczbe elementow w liscie do posrtowowania \n");
    scanf("%d", &n);
    
    printf("Enter %d liczb \n", n);
    
    for (c = 0; c < n; c++) {
        scanf("%d", &array[c]);
    }
    
    for (c = 0; c < (n - 1); c++) {
        for (d = 0; d < n - c - 1; d++) {
            if (array[d] > array[d + 1]) {
                swap = array[d];
                array[d] = array[d + 1];
                array[d + 1] = swap;
            }
        }
    }
    
    printf("Posortowana tablica: \n");
    
    for (c = 0; c < n; c++) {
        printf(" %d\n", array[c]);
    }
    
    return 0;
}