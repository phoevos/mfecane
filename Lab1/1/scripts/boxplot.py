import sys
import numpy as np
import seaborn as sns
import pandas as pd 
import matplotlib.pyplot as plt

time1 = []
time2 = []
time3 = []
time4 = []
titles1 = []
titles2 = []

file1 = open('results/out/phods_initial.out')
line = file1.readline()

while line:
    tokens = line.split()
    time1.append(float(tokens[3]))
    line = file1.readline()

file1.close()

file2 = open('results/out/phods_opt.out')
line = file2.readline()

while line:
    tokens = line.split()
    time2.append(float(tokens[3]))
    line = file2.readline()

file2.close()

file3 = open('results/out/phods_B.out')
line = file3.readline()

while line:
    tokens = line.split()
    if(tokens[0].startswith("B")):
        titles1.append(line.split("\n")[0])
    else:
        time3.append(float(tokens[3]))
    line = file3.readline()

file3.close()

arr = np.array_split(np.array(time3), 5)
min1 = np.median(arr[0])
mindex1 = 0
for i in range(1, 5):
    med = np.median(arr[i])
    if (med < min1):
        min1 = med
        mindex1 = i

time3 = arr[mindex1]

file4 = open('results/out/phods_rect.out')
line = file4.readline()

while line:
    tokens = line.split()
    if(tokens[0].startswith("B")):
        titles2.append(line.split("\n")[0])
    else:
        time4.append(float(tokens[3]))
    line = file4.readline()

file4.close()

arr2 = np.array_split(np.array(time4), 150)
min2 = np.median(arr2[0])
mindex2 = 0
for i in range(1, 150):
    med = np.median(arr2[i])
    if (med < min2):
        min2 = med
        mindex2 = i

time4 = arr2[mindex2]

versions = ['Οptimized', titles1[mindex1], titles2[mindex2]] # 'Initial' has been removed for visual clarity
sns.set_theme(style="whitegrid")

df = pd.DataFrame([time2, time3, time4]).transpose() # time 1 has been removed from the list
df.columns = versions

sns.boxplot(data=df)
plt.ylabel("Time (s)")
plt.title('DSE Best')
plt.savefig("plots/best_times.png", bbox_inches="tight")