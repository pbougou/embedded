#include <stdio.h>
#define STR_SZ 33
int main() {
    char str[STR_SZ];

    while(1) {
    
        scanf("%s", str);
        if((*str == 'q' || *str == 'Q') && *(str + 1) == '\0')
           break;
        char *p;
        for(p = str; *p != '\0'; p++) {
            if((*p >= '0') && (*p < '5'))
                *p += 5;
            else if((*p >= '5') && (*p <= '9'))
                *p -= 5;
            else if ((*p >= 'A') && (*p <= 'Z'))
                *p += 'a' - 'A';
            else if ((*p >= 'a') && (*p <= 'z'))
                *p -= 'a' - 'A';

        }

        printf("%s\n", str);
        return 0;
    }
}
