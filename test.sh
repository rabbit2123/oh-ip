#!/bin/bash
  
CLOUDFLARE_FILE="cloudflare.txt"
GOOGLE_FILE="google.txt"
RET=0


test_cloudflare() {
    local url=""

    while IFS='' read -r line; do
        echo "test cloudflare: $line"
        url="https://www.cloudflare.com/ --connect-to ::${line}"
        curl --max-time 3 -sS -I $url >/dev/null
        if [ $? -ne 0 ]; then
            RET=1
        fi
    done < "$CLOUDFLARE_FILE"
}

test_google() {
    local url=""

    while IFS='' read -r line; do
        echo "test google: $line"
        url="https://www.google.com/ --connect-to ::${line}"
        curl --max-time 3 -sS -I $url >/dev/null
        if [ $? -ne 0 ]; then
            RET=1
        fi
    done < "$GOOGLE_FILE"
}


test_cloudflare
test_google
exit $RET
