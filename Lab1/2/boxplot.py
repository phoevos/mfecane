import sys
import numpy as np
import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt

time1 = []
time2 = []
time3 = []
time4 = []

file1 = open('results/out/tables_initial.out')
line = file1.readline()

while line:
    tokens = line.split()
    time1.append(float(tokens[3]))
    line = file1.readline()

file1.close()

file2 = open('results/out/tables_exhaustive.out')
line = file2.readline()

while line:
    tokens = line.split()
    time2.append(float(tokens[3]))
    line = file2.readline()

file2.close()

file3 = open('results/out/tables_random.out')
line = file3.readline()

while line:
    tokens = line.split()
    time3.append(float(tokens[3]))
    line = file3.readline()

file3.close()

file4 = open('results/out/tables_simplex.out')
line = file4.readline()

while line:
    tokens = line.split()
    time4.append(float(tokens[3]))
    line = file4.readline()

file4.close()

versions = ['Initial', 'Exhaustive', 'Random', 'Simplex']
sns.set_theme(style="whitegrid")

df = pd.DataFrame([time1, time2, time3, time4]).transpose()
df.columns = versions

sns.boxplot(data=df)
plt.ylabel("Time (s)")
plt.title('Orio Optimization')
plt.savefig("boxplot.png", bbox_inches="tight")
