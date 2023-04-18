#!/bin/bash
  
CLOUDFLARE_FILE="cloudflare.txt"
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


test_cloudflare
exit $RET
