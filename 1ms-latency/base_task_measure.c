#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <string>
#include <cmath>
#include <ctime>

#define MHZ  3500

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

// ./a.out memsize(in KB)
int main(int argc, char** argv)
{
	unsigned long mem_size_KB = 60;  // mem size in KB
	unsigned long mem_size_B  = mem_size_KB * 1024;	// mem size in Byte
    unsigned long count       = mem_size_B / sizeof(long);
    
    unsigned long long start, finish, dur1;
    unsigned long temp;

    long *buffer;
    buffer = new long[count];

    // init array
    for (unsigned long i = 0; i < count; ++i)
        buffer[i] = i+1;
    for (unsigned long i = count-1; i >0; --i) {
        temp = rand()%i;
        swap(buffer[i], buffer[temp]);
    }

    temp = buffer[0];
    start = rdtsc();
        
    for (int k = 0; k < atoi(argv[1]); ++k) {

        int sum = 0;
        for (int j = 0; j < 25; ++j)
        for (unsigned long i = 1; i < count; ++i) {
        	if (i%2 == 0) sum += buffer[temp];
        	else sum -= buffer[temp];
        	temp = buffer[temp];
        }

    }

    finish = rdtsc();
    dur1 = finish-start;

    // Res
	printf("%lld\n", dur1/MHZ);

	return 0;
}
