import sys
import numpy as np
import seaborn as sns
import pandas as pd 
import matplotlib.pyplot as plt

if(len(sys.argv) != 2):
    print("Provide version (B or rect).")
    exit(1)

version = sys.argv[1]
file = open("results/out/phods_" + version + ".out")

time = []
title = []
line = file.readline()

while line:
    tokens = line.split()
    if(tokens[0].startswith("B")):
        title.append(line.split("\n")[0])
    else:
        time.append(float(tokens[3]))
    line = file.readline()

file.close()

if (version == "B"):
    arr = np.array_split(np.array(time), 5)
    min = np.median(arr[0])
    mindex = 0
    for i in range(1, 5):
        med = np.median(arr[i])
        if (med < min):
            min = med
            mindex = i

    time = arr[mindex]
elif (version == "rect"):
    arr = np.array_split(np.array(time), 150)
    min = np.median(arr[0])
    mindex = 0
    for i in range(1, 150):
        med = np.median(arr[i])
        if (med < min):
            min = med
            mindex = i

    time = arr[mindex]
else:
    print("Pick a version: B or rect.")
    exit(1)

print(title[mindex])
print("---------------")
min = format(np.min(time), ".6f")
max = format(np.max(time), ".6f")
avg = format(np.mean(time), ".6f")
med = format(np.median(time), ".6f")

print(" Min:", min, "\n Med:", med, "\n Avg:", avg, "\n Max:", max)
