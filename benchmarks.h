#pragma once

#include <chrono>
#include <cmath>
#include <cstdlib>
#include <iostream>
#include <numeric>

#include <number_theory.h>

#define BENCHMARK_INNER(x, name)                                                                                  \
    auto name ## _start = std::chrono::high_resolution_clock::now();                                              \
    x                                                                                                         \
    auto name ## _end = std::chrono::high_resolution_clock::now();                                                \
    auto name ## _duration = std::chrono::duration_cast<std::chrono::nanoseconds>(name ## _end - name ## _start); \
    std::cout << #name << ": Time elapsed (ns) : " << name ## _duration.count() << std::endl;

#define BENCHMARK(x,name) BENCHMARK_INNER(x,name)






void benchmark_gcds()
{
    constexpr size_t num_tests = 1000000;

    static uint64_t arr0[num_tests];
    static uint64_t arr1[num_tests];
    static uint64_t std_gcd[num_tests];
    static uint64_t euclid_gcd_result[num_tests];
    static uint64_t binary_gcd_result[num_tests];

    std::cout << "Starting GCD tests" << std::endl;

    for(size_t i = 0; i < num_tests; i++)
    {
        arr0[i] = rand();
        arr1[i] = rand();
    }

    auto std_gcd_start = std::chrono::high_resolution_clock::now();
    for(size_t i = 0; i < num_tests;i++)
    {
        std_gcd[i] = std::gcd(arr0[i], arr1[i]);
    }
    auto std_gcd_end = std::chrono::high_resolution_clock::now();
    auto std_gcd_duration = std::chrono::duration_cast<std::chrono::nanoseconds>(std_gcd_end - std_gcd_start);
    std::cout << "std::gcd: Time elapsed (ns): " << std_gcd_duration.count() << std::endl; 

    auto euclid_gcd_start = std::chrono::high_resolution_clock::now();
    for(size_t i = 0; i < num_tests;i++)
    {
        euclid_gcd_result[i] = euclid_gcd(arr0[i], arr1[i]);
    }
    auto euclid_gcd_end = std::chrono::high_resolution_clock::now();
    auto euclid_gcd_duration = std::chrono::duration_cast<std::chrono::nanoseconds>(euclid_gcd_end - euclid_gcd_start);
    std::cout << "euclid_gcd: Time elapsed (ns): " << euclid_gcd_duration.count() << std::endl; 

    auto binary_gcd_start = std::chrono::high_resolution_clock::now();
    for(size_t i = 0; i < num_tests; i++)
    {
        binary_gcd_result[i] = binary_gcd(arr0[i], arr1[i]);
    }
    auto binary_gcd_end = std::chrono::high_resolution_clock::now();
    auto binary_gcd_duration = std::chrono::duration_cast<std::chrono::nanoseconds>(binary_gcd_end - binary_gcd_start);
    std::cout << "binary_gcd: Time elapsed (ns): " << binary_gcd_duration.count() << std::endl; 

    for(size_t i = 0; i < num_tests; i++)
    {
        if(euclid_gcd_result[i] != std_gcd[i])
        {
            std::cout << i << std::endl;
            std::cout << "std_gcd(" << arr0[i] << "," << arr1[i] << "): " << std_gcd[i] << std::endl;
            std::cout << "euclid_gcd(" << arr0[i] << "," << arr1[i] << "): " << euclid_gcd_result[i] << std::endl;
            abort();
        }

        if(binary_gcd_result[i] != std_gcd[i])
        {   
            std::cout << i << std::endl;
            std::cout << "std_gcd(" << arr0[i] << "," << arr1[i] << "): " << std_gcd[i] << std::endl;
            std::cout << "binary_gcd(" << arr0[i] << "," << arr1[i] << "): " << binary_gcd_result[i] << std::endl;
            abort();
        }
    }
}

void benchmark_mod_exp()
{
        constexpr size_t num_tests = 1000000;

    static uint64_t base[num_tests];
    static uint64_t power[num_tests];
    static uint64_t mod[num_tests];
    static uint64_t cpp_result[num_tests];
    static uint64_t asm_result[num_tests];

    for(size_t i = 0; i < num_tests; i++)
    {
        base[i] = rand();
        power[i] = rand();
        mod[i] = rand();

        if(mod[i] <= 1)
        {
            mod[i] += 2;
        }
    }

    BENCHMARK(
        for(size_t i = 0; i < num_tests; i++)
        {
            asm_result[i] = modular_exp(base[i], power[i], mod[i]);
        },
        asm_modular_exp
    )

    BENCHMARK(
        for(size_t i = 0; i < num_tests; i++)
        {
            cpp_result[i] = cpp_modular_exp(base[i], power[i], mod[i]);
        },
        cpp_modular_exp
    )
    
    for(size_t i = 0; i < num_tests; i++)
    {
        if(cpp_result[i] != asm_result[i])
        {
            std::cout << "Base: " << base[i] << ", Power: " << power[i] << ", Mod: " << mod[i] << std::endl;
            std::cout << "cpp result: " << cpp_result[i] << ", asm result: " << asm_result[i] << std::endl;
        }
    }
}
