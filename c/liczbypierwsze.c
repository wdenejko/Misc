#include <stdio.h>

int pierwsza(int n) {
    int p = 1;
    
    if (n == 1)
        return 1;
    
    for (int i = 1; i < n; i++) {
        if (n % i == 0) {
            p++;
            if (p > 2)
                return 1;
        }
    }
    
    return 0;
}

int main(void)
{
    int l;
    int p;
    
    scanf("%d", &l);
    for (int i = 0; i < l; i++) {
        scanf("%d", &p);
        int result = pierwsza(p);
        if (result == 0) {
            printf("TAK\n");
        } else {
            printf("NIE\n");
        }
    }
    
    return 0;
}