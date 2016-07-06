#include <stdio.h>

typedef enum { false, true } bool;

int sum_array(int a[], int num_elements) {
    int i, sum = 0;
    for (i = 0; i < num_elements; i++) {
        sum = sum + a[i];
    }
    
    return(sum);
}

int wylicz_srednia(int array[], int dlugosc_tablicy) {
    int x[dlugosc_tablicy];
    int i, j;
    int wynik;
    int w = 1;
    
    for (i = 0; i < dlugosc_tablicy; i++) {
        if (i < dlugosc_tablicy - w) {
            x[i] = array[i - w] + array[i] + array[i + w];
        } else {
            x[i] = array[i - w] + array[i];
        }
    }
    
    for (i = 0; i < dlugosc_tablicy; i++) {
        printf("array[%d] = %d \n", i, x[i]);
    }
    
    wynik = sum_array(x, dlugosc_tablicy);
    
    return wynik;
}


int main()
{
    int table_size = 8;
    int array[] = {1, 2, 3, 4, 5, 6, 7, 8 };
    int wynik;
    
    wynik = wylicz_srednia(array, table_size);
    
    printf("wynik = %d \n", wynik);
    
    return 0;
}