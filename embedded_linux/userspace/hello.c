#include <sys/syscall.h>
#include <unistd.h>

int main() {
    const int nr_syscall = 378;
    syscall(nr_syscall);
    return 0;
}
