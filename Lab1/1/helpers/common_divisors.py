import sys

if(len(sys.argv) != 3):
    print("Provide integers N, M.")
    exit(1)

N = int(sys.argv[1])
M = int(sys.argv[2])
div = []

limit = min(N, M)
if(limit > 0):
    for i in range(1, limit + 1):
        if(N % i == 0 and M % i == 0):
            div.append(i)
    print(div)
else:
    print("No common divisors.")
    exit(1)