#include <stdio.h>
#include <string.h>

int main() {
    char text[100];
    int begin;
    int middle;
    int end;
    int length = 0;
    
    gets(text);
    
    while (text[length] != '\0') {
        length++;
    }
    
    end = length - 1;
    middle = length / 2;
    
    for (begin = 0; begin < middle; begin++) {
        if (text[begin] != text[end]) {
            printf("Not a palindrom \n");
            break;
        }
        end--;
    }
    if (begin == middle) {
        printf("palindrome \n");
    }
    
    return 0;
}