#include <stdio.h>
#include <string.h>
#include <math.h>


int main(void)
{
    int n;
    int l;
    int tab[100];
    
    scanf("%d", &n);
    
    for (int i = 0; i < n; i++) {
        
        int v, sum = 0;
        scanf("%i", &l);
        for (int j = 0; j < l; j++) {
            char ch = 0;
            scanf("%d%c", &v, &ch);
            sum += v;
            if(ch == '\n' || ch == 0)
                break;
        }
        printf("%d\n", sum);
    }
    
    return 0;
}