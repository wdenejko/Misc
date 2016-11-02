#include <stdio.h>

typedef enum { false, true } bool;

int partition(int array[], int p, int r) {
    // dzielimy tablice na dwie czesci, w pierwszej wszystkie liczby sa mniejsze badz rowne x,
    // w drugiej wieksze lub rowne od x
    int x = array[p]; // obieramy x
    int i = p; // i, j - inteksy w tablicy
    int j = r;
    int w;
    
    while (true) {
        while (array[j] > x) { // dopoki elementy sa wieksze od x
            j--;
        }
        while (array[i] < x) { // dopoki elementy sa mniejsze od x
            i++;
        }
        if (i < j) { // zamieniamy miejscami gdy i < j
            w = array[i];
            array[i] = array[j];
            array[j] = w;
            i++;
            j--;
        } else { // gdy i >= j zwracamy j jako punkt podzialu tablicy
            return j;
        }
    }
}

void quicksort(int array[], int p, int r) {
    int q;
    if (p < r) {
        q = partition(array, p, r); // dzielimy tablice na dwie czesci; q oznacza punkt podzialu
        quicksort(array, p, q); // wywolujemy rekurencyjnie quicksort dla pierwszej czesci tablicy
        quicksort(array, q+1, r); // wywolujemy rekurencyjnie quicksort dla drugiej czesci tablicy
    }
    
}

int main()
{
    int liczby;
    int i;
    printf("Podaj ilosc liczb do posortowania: \n");
    scanf("%d", &liczby);
    
    int array[liczby];
    
    for (i = 0; i < liczby; i++) {
        printf("Podaj liczbe: \n");
        scanf("%d", &array[i]);
    }
    
    quicksort(array, 0, liczby - 1);
    
    printf("Wynik: \n");
    
    for (i = 0; i < liczby; i++) {
        printf("array[%d] = %d \n", i, array[i]);
    }
    
    return 0;
}