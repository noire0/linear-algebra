#!/bin/sh
LOG_FILE=$(pwd)/"$0".log
PROGRAMS=(bin/array_slicing_example.bin bin/coefficients_of_eigenpolynomial.bin\
    bin/solve_system_of_equations.bin bin/matrix_by_vector.bin)

test_if_runs () {
    echo "$program:" >> $LOG_FILE
    case $1 in
    bin/coefficients_of_eigenpolynomial.bin|bin/solve_system_of_equations.bin\
|bin/matrix_by_vector.bin)
        if (echo "n" | ./$1 >> $LOG_FILE); then 
            printf "$1: \033\n[32m%46s\033[m\n" "PASSED"
        else
            printf "$1: \033\n[31m%46s\033[m\n" "FAILED"
        fi
    ;;
    *)
        if (./$1 >> $LOG_FILE); then
            printf "$1: \033\n[32m%46s\033[m\n" "PASSED"
        else 
            printf "$1: \033\n[31m%46s\033[m\n" "FAILED"
        fi
    ;;
    esac
    echo "***********************" >> $LOG_FILE
    echo "" >> $LOG_FILE
}
test_if_it_exists () {
    if [ ! -e $1 ]; then
        echo "$1 does not exist"
        return 1
    fi
}
make_executable_if_not () {
    if [ ! -x $1 ]; then
        printf "\033[31mWARNING\033[m: $1 WAS NOT EXECUTABLE\n"
        echo "Making $1 executable by $USER"
        chmod u+x $1
    fi
}

############################### MAIN #################################
echo "*************** NO CRASH TEST ****************"
if [ -e $LOG_FILE ]; then
    rm $LOG_FILE
fi

for program in ${PROGRAMS[@]}; do
    if test_if_it_exists $program; then
        make_executable_if_not $program
    else
        continue
    fi
    test_if_runs $program
done
echo "**********************************************"
