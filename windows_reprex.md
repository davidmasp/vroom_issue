``` r


library(readr)
library(vroom)
#> Warning: package 'vroom' was built under R version 3.6.3

sessionInfo()
#> R version 3.6.0 (2019-04-26)
#> Platform: x86_64-w64-mingw32/x64 (64-bit)
#> Running under: Windows 10 x64 (build 17134)
#> 
#> Matrix products: default
#> 
#> locale:
#> [1] LC_COLLATE=Spanish_Spain.1252  LC_CTYPE=Spanish_Spain.1252   
#> [3] LC_MONETARY=Spanish_Spain.1252 LC_NUMERIC=C                  
#> [5] LC_TIME=Spanish_Spain.1252    
#> 
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base     
#> 
#> other attached packages:
#> [1] vroom_1.2.1 readr_1.3.1
#> 
#> loaded via a namespace (and not attached):
#>  [1] Rcpp_1.0.3       knitr_1.23       magrittr_1.5     hms_0.4.2       
#>  [5] tidyselect_1.0.0 bit_1.1-14       R6_2.4.1         rlang_0.4.4     
#>  [9] stringr_1.4.0    highr_0.8        tools_3.6.0      xfun_0.8        
#> [13] htmltools_0.4.0  yaml_2.2.0       bit64_0.9-7      digest_0.6.24   
#> [17] tibble_2.1.3     lifecycle_0.1.0  crayon_1.3.4     purrr_0.3.3     
#> [21] glue_1.3.1       evaluate_0.14    rmarkdown_1.13   stringi_1.4.4   
#> [25] compiler_3.6.0   pillar_1.4.3     pkgconfig_2.0.3

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
#> R version 3.6.0 (2019-04-26)
#> Platform: x86_64-w64-mingw32/x64 (64-bit)
#> Running under: Windows 10 x64 (build 17134)
#> 
#> Matrix products: default
#> 
#> locale:
#> [1] LC_COLLATE=Spanish_Spain.1252  LC_CTYPE=Spanish_Spain.1252   
#> [3] LC_MONETARY=Spanish_Spain.1252 LC_NUMERIC=C                  
#> [5] LC_TIME=Spanish_Spain.1252    
#> 
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base     
#> 
#> other attached packages:
#> [1] vroom_1.2.1 readr_1.3.1
#> 
#> loaded via a namespace (and not attached):
#>  [1] Rcpp_1.0.3       knitr_1.23       magrittr_1.5     hms_0.4.2       
#>  [5] tidyselect_1.0.0 bit_1.1-14       R6_2.4.1         rlang_0.4.4     
#>  [9] dplyr_0.8.4      stringr_1.4.0    highr_0.8        tools_3.6.0     
#> [13] parallel_3.6.0   xfun_0.8         htmltools_0.4.0  assertthat_0.2.1
#> [17] yaml_2.2.0       bit64_0.9-7      digest_0.6.24    tibble_2.1.3    
#> [21] lifecycle_0.1.0  crayon_1.3.4     purrr_0.3.3      fs_1.3.1        
#> [25] glue_1.3.1       evaluate_0.14    rmarkdown_1.13   stringi_1.4.4   
#> [29] compiler_3.6.0   pillar_1.4.3     pkgconfig_2.0.3
```

<sup>Created on 2020-10-01 by the [reprex package](https://reprex.tidyverse.org) (v0.3.0)</sup>
