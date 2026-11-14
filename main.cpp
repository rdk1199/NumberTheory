#include <iostream>

#include <number_theory.h>

int main()
{
    uint64_t gcd = euclid_gcd(79 * 127, 127 * 199);
    std::cout << gcd << std::endl;
    return 0;
}
