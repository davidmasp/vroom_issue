

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

