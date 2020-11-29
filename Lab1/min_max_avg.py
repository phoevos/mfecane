import sys
import numpy as np

time = []

file = open(sys.argv[1])
line = file.readline()

while line:
    tokens = line.split()
    if(not(tokens[0].startswith("B"))):
        time.append(float(tokens[3]))
    line = file.readline()

file.close()

min = format(np.min(time), ".6f")
max = format(np.max(time), ".6f")
avg = format(np.mean(time), ".6f")
med = format(np.median(time), ".6f")

print("Min:", min, "\nMed:", med, "\nAvg:", avg, "\nMax:", max)
