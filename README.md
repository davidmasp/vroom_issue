

# README

Issue with too many files in vroom:

## Usage

To reproduce run:

```bash
R -e "reprex::reprex(input = 'script.R', outfile = 'Linux' )"
```

To obtain the error messages in a file, just directly run

```bash
Rscript script.R 2> error_centos.txt
```

## Redered outputs

Rendered reprex:

* In [Linux/Centos](centos_reprex.md)
* In [Linux/Ubuntu](ubuntu_reprex.md)
* In [Windows](windows_reprex.md)

* In [Linux/Ubuntu after workaround (see below)](ubuntu_12Kfiles_vctrsUpdate_reprex.md)

Standard error:

* In [Linux/Centos](error_centos.txt)
* In [Linux/Ubuntu](error_ubuntu.txt)

They are the same:

```
mapping error: Too many open files
Error in vroom_(file, delim = delim %||% col_types$delim, col_names = col_names,  :
  Files must all have 2 columns:
* File 1018 has 0 columns
Calls: <Anonymous> -> vroom_
Execution halted
```

## System limits

Linux has a soft limit in the number of open files that can be checked with
with `ulimit -Sn` (see
[this](https://www.tecmint.com/increase-set-open-file-limits-in-linux/)). I did
increase the limit to 12k files which should be sufficient to deal with the
current problem and indeed it does workaround it. However I get another
(unrelated?) issue. See [below](error_ubuntu12kulimit.txt).

```bash
$ ulimit -Sn
12000

$ Rscript script.R 2> error_ubuntu12kulimit.txt
R version 3.6.3 (2020-02-29)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 18.04.5 LTS

Matrix products: default
BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.7.1
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.7.1

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=es_ES.UTF-8        LC_COLLATE=en_US.UTF-8
 [5] LC_MONETARY=es_ES.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=es_ES.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=es_ES.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base

other attached packages:
[1] vroom_1.3.2 readr_1.3.1

loaded via a namespace (and not attached):
 [1] Rcpp_1.0.1       crayon_1.3.4     R6_2.4.0         lifecycle_0.2.0
 [5] magrittr_1.5     pillar_1.4.1     rlang_0.4.7      bit64_0.9-7
 [9] glue_1.3.1       purrr_0.3.2      bit_1.1-14       hms_0.4.2
[13] compiler_3.6.3   pkgconfig_2.0.2  tidyselect_0.2.5 tibble_2.1.3
[1] 2

$  more error_ubuntu12kulimit.txt
Error: 'vec_as_names' is not an exported object from 'namespace:vctrs'
Execution halted
```

After updating the package `vctrs` it managed to run allright. I am not
sure why it didn't update with vroom as this package is not loaded in the
session info for some reason. The output of this last run can be seen in
[here](error_ubuntu12kulimit_vctrsUpdate.txt).


## Other things

I have also tried to change `num_threads=3` but also fails as above.
