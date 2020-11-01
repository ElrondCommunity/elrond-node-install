# This function is use to print the different steps of the procedure.
Log-Step() {
    echo -e "\e[32m---------------------------------    $1    ---------------------------------"
}

# This function is use to print the different warnings of the procedure.
Log-Warning() {
    echo -e "\e[33m WARNING:  $1    "
}

# This function is use to print the different errors of the procedure.
Log-Error() {
    echo -e "\e[31m ERROR:    $1    "
}