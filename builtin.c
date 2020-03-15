#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>

int64_t readint() {
    int64_t _ret = 0;
    int _code = scanf("%"SCNd64, &_ret);
    return _code == 1 ? _ret : 0;
}

void putint(int64_t _v) {
    printf("%"PRId64, _v);
}
