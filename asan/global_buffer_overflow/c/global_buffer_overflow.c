#include <stdlib.h>

int array[100];

int func()
{
    return array[100];
}

int main(int argc, char *argv[])
{
    int a = func();
    return a;
}
