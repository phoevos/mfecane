import numpy as np
import matplotlib.pyplot as plt
from math import log



def sunarthsh(i):
    if(i==2 or i==5 or i==8):
        return (-100,4)
    else:
        return (8,8)

x = [67732342, 68376553, 469437498, 67744776, 68388587, 469453681, 68257559, 68923684, 470156422]
x = [log(j,10) for j in x]
print(x)
y = [798.8, 980.3, 1111, 823.0, 983.3, 1128, 760.2, 928.5, 1075]
#y = [w * 1000 for w in y]
types = ["SLL & SLL", "SLL & DLL", "SLL & DYN_ARR", "DLL & SLL", "DLL & DLL", "DLL & DYN_ARR", "DYN_ARR & SLL", "DYN_ARR & DLL", "DYN_ARR & DYN_ARR"]

fig, ax = plt.subplots()
ax.scatter(x, y)

ax.set_xlabel('Memory Accesses(log10)', fontsize=14)
ax.set_ylabel('Memory Footprint(KB)', fontsize=14)
ax.set_title('Plot', fontsize=18)

for i, txt in enumerate(types):
    ax.annotate(txt, (x[i], y[i]), xytext= sunarthsh(i), textcoords='offset points')
    plt.scatter(x, y, marker='o', color='red')

plt.savefig("dotplot.png", bbox_inches="tight")
