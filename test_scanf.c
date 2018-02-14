#include <stdio.h>

int main () {
    char input[33];
    scanf("%[^\n]s", input);
    printf("%s\n", input);
}
