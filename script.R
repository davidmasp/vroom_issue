

library(readr)

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
vroom::vroom(file = file_names) -> dat_vroom
ncol(dat_vroom)

sessionInfo()

