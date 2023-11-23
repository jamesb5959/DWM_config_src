#!/bin/bash

# Compile the prodcons.c file
gcc -o tempTest prodcons.c -lpthread

# Testcases
testcaseNums=(5 10 100 300 500 1000)
testcases=()

for num1 in "${testcaseNums[@]}"; do
    for num2 in "${testcaseNums[@]}"; do
        for num3 in "${testcaseNums[@]}"; do
            testcases+=("$num1 $num2 $num3")
        done
    done
done

# Run the compiled file and redirect output to test.txt
> test.txt
for testcase in "${testcases[@]}"; do
    IFS=' ' read -r prodCons items bufSize <<< "$testcase"
    ./tempTest "$prodCons" "$items" "$bufSize" >> test.txt 2>&1
done

# Check the output
outputs=($(awk 'NR%2{print $1}' test.txt))

failed=false
for ((index=0; index<${#outputs[@]}; index++)); do
    if [ "${outputs[$index]}" -ne 0 ]; then
        echo "Test Failed: ${testcases[$index]}"
        failed=true
    fi
done

if ! $failed; then
    echo "All ${#testcases[@]} testcases passed"
fi

# Clean up
rm tempTest
rm test.txt
