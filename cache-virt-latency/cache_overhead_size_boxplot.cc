#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <string>
#include <ctime>

using namespace std;

#if defined(__i386__)
static __inline__ unsigned long long rdtsc(void)
{
    unsigned long long int x;
    __asm__ volatile (".byte 0x0f, 0x31" : "=A" (x));
    return x;
}
#elif defined(__x86_64__)
static __inline__ unsigned long long rdtsc(void)
{
    unsigned hi, lo;
    __asm__ __volatile__ ("rdtsc" : "=a"(lo), "=d"(hi));
    return ( (unsigned long long)lo)|( ((unsigned long long)hi)<<32 );
}
#endif

#define CACHE_LINE_SIZE 64

#define WSS 24567 /* 24 Mb */
#define NUM_VARS WSS * 1024 / sizeof(long)

#define KHZ 3500000

#define POLLUTER_KB    256

// ./a.out memsize(in KB)
int main(int argc, char** argv)
{
    unsigned long mem_size_KB = atol(argv[1]);  // mem size in KB
    unsigned long mem_size_B  = mem_size_KB * 1024; // mem size in Byte
    unsigned long count       = mem_size_B / sizeof(long);
    unsigned long row         = mem_size_B / CACHE_LINE_SIZE;
    int           col         = CACHE_LINE_SIZE / sizeof(long);
    unsigned long polluter_mem_size_B = POLLUTER_KB * 1024;
    unsigned long polluter_count = polluter_mem_size_B / sizeof(long);
    unsigned long polluter_row = polluter_mem_size_B / CACHE_LINE_SIZE;
    int           polluter_col = CACHE_LINE_SIZE / sizeof(long);
    
    unsigned long long start, finish, dur1;
    unsigned long temp;

    long *buffer;
    long *polluter;
    buffer = new long[count];
    polluter = new long[polluter_count];

    // init array buffer
    for (unsigned long i = 0; i < count; ++i)
        buffer[i] = i;

    for (unsigned long i = row-1; i >0; --i) {
        temp = rand()%i;
        swap(buffer[i*col], buffer[temp*col]);
    }


    // init array polluter
    for (unsigned long i = 0; i < polluter_count; ++i)
        polluter[i] = i;

    for (unsigned long i = polluter_row-1; i >0; --i) {
        temp = rand()%i;
        swap(polluter[i*col], polluter[temp*col]);
    }

    // pollute the cache
    temp = polluter[0];
    for (unsigned long i = 0; i < polluter_row-1; ++i) {
        polluter[i] = polluter[i]*2;
    }

    // First read, should be cache miss //use this to minus cache hit is cache overhead
    temp = buffer[0];
    start = rdtsc();
    int sum = 0;
    for (unsigned long i = 0; i < row-1; ++i) {
        if (i%2 == 0) sum += buffer[temp];
        else sum -= buffer[temp];
        temp = buffer[temp];
    }
    finish = rdtsc();
    dur1 = finish-start;

    // Res
    printf("%lld %lld %.2f\n", dur1, dur1/row, dur1*1.0/KHZ);
    delete[] buffer;
    delete[] polluter;
    return 0;
}
