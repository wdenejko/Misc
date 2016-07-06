//
// Created by wdenejko on 28.06.16.
//
#include <stdio.h>

void toh(int n, int source, int aux, int destination) {
    if (n == 1) {
        //pick and place
        printf("Move the disk from tower no: %d to tower no: %d \n", source, destination);
        return;
    }
    // move all n-1 disk to aux
    toh(n-1, source, destination, aux);
    // move the single disk from source to destination
    toh(1, source, aux, destination);
    // move all the n-1 disk kept in auxiliary to destination
    toh(n -1, aux, source, destination);
}

int main() {
    toh(3, 1, 2, 3);

    return 0;
}