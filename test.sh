#!/bin/bash
  
CLOUDFLARE_FILE="cloudflare.txt"
GOOGLE_FILE="google.txt"
RET=0


test_cloudflare() {
    local url=""
    local tmp_file=$(mktemp)
    cat $CLOUDFLARE_FILE |egrep -v '^ *$|^ *#' > $tmp_file
    
    while IFS='' read -r line; do
        echo "test cloudflare: $line"
        url="https://www.cloudflare.com/ --connect-to ::${line}"
        curl --max-time 3 -sS -I $url >/dev/null
        if [ $? -ne 0 ]; then
            RET=1
        fi
    done < "$tmp_file"
    
    rm $tmp_file
}

test_google() {
    local url=""
    local tmp_file=$(mktemp)
    cat $GOOGLE_FILE |egrep -v '^ *$|^ *#' > $tmp_file
    
    while IFS='' read -r line; do
        echo "test google: $line"
        url="https://www.google.com/ --connect-to ::${line}"
        curl --max-time 3 -sS -I $url >/dev/null
        if [ $? -ne 0 ]; then
            RET=1
        fi
    done < "$tmp_file"
    
    rm $tmp_file
}


test_cloudflare
test_google
exit $RET
