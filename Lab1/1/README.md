# PHODS Optimization

## Basic info

There are 4 different algorithm versions, as well as 4 groups of corresponding output files:

* Standard (**initial**)
* Optimized (**opt**) e.g.  transformed version
* Variable Block Size (**B**); q.4 of the assignment
* Rectangle Block (**rect**); q.5 of the assignment

## Instructions

### Compile and run

*Inside root folder (1):*

* `make`
* `./run.sh version` *where version is initial/opt/B/rect*

### After running

* Get stats:

> * `python3 ../min_max_avg.py results/out/phods_version.out` *where version is initial/opt/B/rect*
> * `python3 scripts/best_block.py version` *where version is B/rect*

* Get plots:

> * `python3 scripts/plot_B.py`
> * `python3 scripts/plot_rect.py`
> * `python3 scripts/boxplot.py`
