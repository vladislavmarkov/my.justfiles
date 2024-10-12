#!/usr/bin/env just --justfile

set quiet := true

new NAME STANDARD:
    #!/usr/bin/env bash
    set -euo pipefail

    # check if standard is valid
    standards=("11" "14" "17" "20" "23")
    found=false

    for standard in "${standards[@]}"
    do
        if [[ "$standard" == "{{ STANDARD }}" ]]
        then
            found=true
            break
        fi
    done

    if [ "$found" = false ]
    then
        echo "error: invalid C++ standard"
    else
        if [ -z "$( ls -A '{{ invocation_dir() }}')" ]
        then
            echo "============================"
            echo "creating empty C++{{ STANDARD }} project"
            echo "============================"

            # if standard > 20 we need different template
            template_dir="cpp_upto_20_template"
            if [ "{{STANDARD}}" -gt 20 ]
            then
                template_dir="cpp_23_template"
            fi

            cp -r {{ justfile_dir() }}/$template_dir/. {{ invocation_dir() }}/
            find {{ invocation_dir() }} -type f -exec sed -i 's/NEWPROJNAME/{{ NAME }}/g' {} +
            find {{ invocation_dir() }} -type f -exec sed -i 's/NEWPROJCPPSTD/{{ STANDARD }}/g' {} +
            mv NEWPROJNAME.cpp {{ NAME }}.cpp

            # create repo with initial commit
            if [ ! -d ".git" ]
            then
                git -c init.defaultBranch=master init
                git add -- {{ invocation_dir() }}
                git commit -m "Foundation"
            fi
        else
            echo "============================"
            echo "WARNING directory is not empty"
            echo "project was not created"
            echo "============================"
        fi
    fi
