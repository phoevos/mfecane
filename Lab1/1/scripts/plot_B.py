import sys
import numpy as np
import seaborn as sns
import pandas as pd 
import matplotlib.pyplot as plt

file = open("results/out/phods_B.out")

time = []
title = []
blocks = ['1', '2', '4', '8', '16']
line = file.readline()

while line:
    tokens = line.split()
    if(not(tokens[0].startswith("B"))):
        time.append(float(tokens[3]))
    line = file.readline()

file.close()

arr = np.array_split(np.array(time), 5)
medians = []
averages = []
for i in range(0, 5):
    medians.append(np.median(arr[i]))
    averages.append(np.mean(arr[i]))

fig, ax = plt.subplots()
ax.grid(True)
ax.set_xlabel("Block Size")

ax.xaxis.set_ticks(np.arange(0, len(blocks), 1))
ax.set_xticklabels(blocks, rotation=45)
ax.set_xlim(-0.5, len(blocks) - 0.5)
ax.set_ylabel("Time (s)")
ax.plot(medians, color="darkslateblue", label="Median", marker="o")
ax.plot(averages, color="darkred", label="Average", marker="o")

plt.legend()

plt.title("Effect of block size on time of execution")
plt.savefig("plots/B_lineplot.png", bbox_inches="tight")


fig, ax = plt.subplots()
ax.grid(True)
ax.set_xlabel("Block Size")

sns.set_theme(style="whitegrid")

df = pd.DataFrame(arr).transpose()
df.columns = blocks

sns.boxplot(data=df)
plt.ylabel("Time (s)")
plt.title("Effect of block size on time of execution")
plt.savefig("plots/B_boxplot.png", bbox_inches="tight")