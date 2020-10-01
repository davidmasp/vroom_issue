``` r


library(readr)
library(vroom)

sessionInfo()
#> R version 3.6.3 (2020-02-29)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 18.04.5 LTS
#> 
#> Matrix products: default
#> BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.7.1
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.7.1
#> 
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
#>  [3] LC_TIME=es_ES.UTF-8        LC_COLLATE=en_US.UTF-8    
#>  [5] LC_MONETARY=es_ES.UTF-8    LC_MESSAGES=en_US.UTF-8   
#>  [7] LC_PAPER=es_ES.UTF-8       LC_NAME=C                 
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
#> [11] LC_MEASUREMENT=es_ES.UTF-8 LC_IDENTIFICATION=C       
#> 
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base     
#> 
#> other attached packages:
#> [1] vroom_1.3.2 readr_1.3.1
#> 
#> loaded via a namespace (and not attached):
#>  [1] Rcpp_1.0.1       knitr_1.23       magrittr_1.5     hms_0.4.2       
#>  [5] tidyselect_0.2.5 bit_1.1-14       R6_2.4.0         rlang_0.4.7     
#>  [9] stringr_1.4.0    highr_0.8        tools_3.6.3      xfun_0.8        
#> [13] htmltools_0.3.6  yaml_2.2.0       bit64_0.9-7      digest_0.6.19   
#> [17] tibble_2.1.3     lifecycle_0.2.0  crayon_1.3.4     purrr_0.3.2     
#> [21] glue_1.3.1       evaluate_0.14    rmarkdown_1.13   stringi_1.4.3   
#> [25] compiler_3.6.3   pillar_1.4.1     pkgconfig_2.0.2

# funs --------------------------------------------------------------------

vroom_like <- function(paths) {
  file_list = purrr::map(paths,readr::read_tsv,col_types = cols(
    letters = col_character(),
    LETTERS = col_character()
  ))
  dplyr::bind_rows(file_list)
}

# generate files ----------------------------------------------------------

n_files = 10000

df = data.frame(letters,LETTERS)

fs::dir_create("test_data")
purrr::walk(seq_len(n_files), function(x){
  readr::write_tsv(df,path = glue::glue("test_data/{x}_test.tsv"))
})


# read files --------------------------------------------------------------

file_names = fs::dir_ls("test_data/")

vroom_like(paths = file_names) -> dat_readr
ncol(dat_readr)
#> [1] 2
vroom::vroom(file = file_names) -> dat_vroom
#> Rows: 260,000
#> Columns: 2
#> Delimiter: "\t"
#> chr [2]: letters, LETTERS
#> 
#> Use `spec()` to retrieve the guessed column specification
#> Pass a specification to the `col_types` argument to quiet this message
ncol(dat_vroom)
#> [1] 2

sessionInfo()
#> R version 3.6.3 (2020-02-29)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 18.04.5 LTS
#> 
#> Matrix products: default
#> BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.7.1
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.7.1
#> 
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
#>  [3] LC_TIME=es_ES.UTF-8        LC_COLLATE=en_US.UTF-8    
#>  [5] LC_MONETARY=es_ES.UTF-8    LC_MESSAGES=en_US.UTF-8   
#>  [7] LC_PAPER=es_ES.UTF-8       LC_NAME=C                 
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
#> [11] LC_MEASUREMENT=es_ES.UTF-8 LC_IDENTIFICATION=C       
#> 
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base     
#> 
#> other attached packages:
#> [1] vroom_1.3.2 readr_1.3.1
#> 
#> loaded via a namespace (and not attached):
#>  [1] Rcpp_1.0.1       knitr_1.23       magrittr_1.5     hms_0.4.2       
#>  [5] tidyselect_0.2.5 bit_1.1-14       R6_2.4.0         rlang_0.4.7     
#>  [9] dplyr_0.8.1      stringr_1.4.0    highr_0.8        tools_3.6.3     
#> [13] parallel_3.6.3   xfun_0.8         htmltools_0.3.6  assertthat_0.2.1
#> [17] yaml_2.2.0       bit64_0.9-7      digest_0.6.19    tibble_2.1.3    
#> [21] lifecycle_0.2.0  crayon_1.3.4     purrr_0.3.2      vctrs_0.3.4     
#> [25] fs_1.3.1         glue_1.3.1       evaluate_0.14    rmarkdown_1.13  
#> [29] stringi_1.4.3    compiler_3.6.3   pillar_1.4.1     pkgconfig_2.0.2
```

<sup>Created on 2020-10-01 by the [reprex package](https://reprex.tidyverse.org) (v0.3.0)</sup>
