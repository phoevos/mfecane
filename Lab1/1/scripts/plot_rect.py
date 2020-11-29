import sys
import numpy as np
import matplotlib.pyplot as plt

file = open("results/out/phods_rect.out")

time = []
title = []

Bx = "1 2 3 4 6 8 9 12 16 18 24 36 48 72 144"
By = "1 2 4 8 11 16 22 44 88 176"
blocks = [sub1 + "x" + sub2 for sub1 in Bx.split(" ") for sub2 in By.split(" ")]

line = file.readline()

while line:
    tokens = line.split()
    if(not(tokens[0].startswith("B"))):
        time.append(float(tokens[3]))
    line = file.readline()

file.close()

arr = np.array_split(np.array(time), 150)
medians = []
averages = []
mins = []
for i in range(0, 150):
    medians.append(np.median(arr[i]))
    averages.append(np.mean(arr[i]))
    if(i%10 == 9):
        temp = []
        for j in range(i-9, i+1):
            temp.append(medians[j])
        mins.append(np.min(temp))

for j in range(0, len(medians)):
    if(len(mins)==0):
        continue
    if(medians[j] != mins[0]):
        blocks[j]=" "
    else:
        mins.pop(0)

fig, ax = plt.subplots()
ax.grid(False)
ax.set_xlabel("Bx, By")

ax.xaxis.set_ticks(np.arange(0, len(blocks), 1))
ax.set_xticklabels(blocks, rotation=45)
ax.set_xlim(-0.5, len(blocks) - 0.5)
ax.set_ylabel("Time (s)")
ax.plot(medians, color="darkslateblue", label="Median")
ax.plot(averages, color="darkred", label="Average")

plt.legend()

plt.title("Effect of block dimensions on time of execution")
plt.savefig("plots/rect_lineplot.png", bbox_inches="tight")
