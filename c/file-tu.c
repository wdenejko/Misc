//
// Created by wdenejko on 28.06.16.
//

#include <stdio.h>
#include <stdlib.h>

int main() {
    FILE *fp;

    fp = fopen("/home/wdenejko/Dokumenty/a.bin", "rb");

    if (fp == NULL) {
        printf("Failed to open file\n");
        return 1;
    }

    long size;
    size = ftell(fp);
    printf("Size = %ld\n", size);

    fseek(fp, 0L, 2);
    size = ftell(fp);
    printf("Size = %ld\n", size);

    int n = size / sizeof(double);
    printf("No of records: %d\n", n);

    double *data;
    data = (double *)malloc(sizeof(double) * n);
    fseek(fp, 0L, 0);

    fread((void *)data, sizeof(double), n, fp);

    int i;
    for (i = 0; i < n; i++) {
        printf("%10.2lf\n", data[i]);
    }

    fclose(fp);

    return 0;
}
