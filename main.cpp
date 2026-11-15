#include <iostream>

#include <number_theory.h>

#include "benchmarks.h"

int main()
{
    uint64_t test_gcd = binary_gcd(64,96);
    std::cout << test_gcd << std::endl;
    benchmark_gcds();
    return 0;
}
