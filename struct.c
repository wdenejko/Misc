//
// Created by wdenejko on 28.06.16.
//

#include <stdio.h>

typedef int integer;

typedef struct {
    int roll;
    char name[20];
    double gp;
} Student;


int main() {
    Student s;
    Student *sp;

    sp = &s;

    return 0;
}