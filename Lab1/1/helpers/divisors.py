import sys

num = int(sys.argv[1])
div = []

if(num >= 1):
    for i in range(1, num + 1):
        if(num % i == 0):
            div.append(i)
    print(div)
else:
    print("No divisors found.")
    exit(1)