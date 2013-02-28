## Shell Script Documentation ##

### Documentation Codes ###
- `FUNC:` - (unique, required) The name of a shell script function.
- `ARG:` - (multiple allowed, optional) Shell script arguments, in order.
- `ENV:` - (multiple allowed, optional) environment variables required to be
  set prior to calling this function.
- `SETS:` - (multiple allowed, optional) Function sets this environment
  variable.
- `RET:` - (unique, optional) Returns an exit status that signifies something.
  Usually, returning a `0` means "success" and any other integer is a failure
  of some sort;  document special return codes using `ERR` (below).
- `ERR:` - Any error conditions that would cause the function to return a
  non-zero status; any special return codes can be documented here.
- `DESC:` - (multiple allowed, optional) Multiple `DESC:` fields are combined
  to make a long block of text for describing the function.

Example usage:

    ## FUNC: some_shell_function
    ## ARG: Whatever this argument does in the function
    ## ARG: Whatever this other argument does in the function
    ## ENV: VAR1 was set in the environment for this function
    ## ENV: VAR2 was also set
    ## SETS: SET1, the name of an environment variable that is set
    ## SETS: SET2, the name of another environment variable set
    ## RET: '0' is returned if the function call was successful
    ## ERR: '2' is returned if a set of conditions are met
    ## ERR: '3' is returned if a different set of conditions are met
    ## DESC: This is a line of text describing this function

vi: set filetype=markdown shiftwidth=4 tabstop=2:
