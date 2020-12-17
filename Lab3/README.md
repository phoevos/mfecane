# Lab 3

## ARM assembly

### Part 1

ARM assembly programme which performs transformations on an input string.

* `cd ex1`
* `make`
* `./ex1`

### Part 2

Guest - Host communication through serial port.

* `cd ex2`

Guest machine:

* Move *guest* directory into guest machine (scp -P 22223 -r ...)
* `cd guest`
* `make`
* `./guest`

Host machine:

* `cd host`
* `make`
* `sudo ./host /dev/pts/x`

### Part 3

ARM assembly implementation of strlen, strcpy, strcat, strcmp can be found in the respective `.s` files. After compilation they can be tested with the `string_manipulation.out` executable.

* `cd ex3`
* `make`
* `./string_manipulation.out rand_str_input.txt`
