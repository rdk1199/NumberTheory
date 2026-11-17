#pragma once

#include <cstdint>
#include <cstddef>
#include <string>

extern "C" 
{
    // GCD for 64-bit ints
    uint64_t euclid_gcd(uint64_t a, uint64_t b);
    uint64_t binary_gcd(uint64_t a, uint64_t b);

    // Compute (base^power) % mod
    uint64_t modular_exp(uint64_t base, uint64_t power, uint64_t mod);

}

uint64_t cpp_modular_exp(uint64_t base, uint64_t power, uint64_t mod)
{
    uint64_t result = 1;

    while(power > 0)
    {
        if(power & 1)
        {
            result *= base;
            result %= mod;
        }

        power = power >> 1;
        base *= base;
        base %= mod;
    }
    return result;
}