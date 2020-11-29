# ORIO: Automatic Optimization

## Basic info

There are 4 different code versions, as well as 4 groups of corresponding output files:

* **initial**
* **exhaustive**
* **random**
* **simplex**

We used ORIO in order to find the optimal unroll factor to minimize the execution time of the initial loop. The first version is the code to be optimized, while each of the other 3 uses the unroll factor proposed by ORIO's exhaustive, random and simplex search, respectively.

## Instructions

### Compile and run

*Inside root folder (2):*

* `make`
* `sudo orcc tables_orioc.c`
* `./run.sh version` *where version is initial/exhaustive/random/simplex*

### After running

* Get stats:

> * `python3 ../min_max_avg.py results/out/tables_version.out` *where version is initial/exhaustive/random/simplex*

* Get plots:

> * `python3 boxplot.py`
