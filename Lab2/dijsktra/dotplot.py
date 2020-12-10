import numpy as np
import matplotlib.pyplot as plt
from math import log



def sunarthsh(i):
    if(i==2 or i==5 or i==8):
        return (-100,4)
    else:
        return (8,8)

x = [102317980, 102486489, 149800562]
x = [log(j,10) for j in x]
print(x)
y = [356.5, 471.3, 360.7]
#y = [w * 1000 for w in y]
types = ["SLL", "DLL", "DYN_ARR"]

fig, ax = plt.subplots()
ax.scatter(x, y)

ax.set_xlabel('Memory Accesses(log10)', fontsize=14)
ax.set_ylabel('Memory Footprint(KB)', fontsize=14)
ax.set_title('Plot', fontsize=18)

for i, txt in enumerate(types):
    ax.annotate(txt, (x[i], y[i]), xytext= (8,8), textcoords='offset points')
    plt.scatter(x, y, marker='o', color='red')

plt.savefig("dotplot.png", bbox_inches="tight")
