//
// Created by wdenejko on 28.06.16.
//
#include <stdio.h>

// Fib: 1 1 2 3 5 8 13 21 34 55...

long getFibbTerm(int t) {
    if (t == 1 || t == 2) {
        return 1;
    }
    return getFibbTerm(t-1) + getFibbTerm(t-2);
}

int main() {

    int i;
    for (i = 1; i <= 10; ++i) {
        printf("%ld\n", getFibbTerm(i));
    }

    return 0;
}