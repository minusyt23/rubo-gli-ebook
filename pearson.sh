#!/bin/sh

BASE_LINK="https://d38l3k3yaet8r2.cloudfront.net/resources/products/epubs/generated/EBA38F30-D086-459C-9133-E557041B0E46/foxit-assets/pages/"

LINK_ARGS="password=&accessToken=null&formMode=true"

PAGE_NUM=0

get_page() {
    echo "Downloading page ${1}..."
    wget -O "page-${1}.png" -q "${BASE_LINK}page${1}?${LINK_ARGS}"
    echo "Page ${1} downloaded."
}

# Main
# $1 is page num

# check if argument is num

case $1 in
    ''|*[!0-9]*) echo "Input a fucking number, moron" ;;
    *)
        PAGE_NUM=$1

        ((PAGE_NUM=PAGE_NUM-1))

        if [ -n $2 ]; then
            DOWNLOAD_DIR=$2;
        fi

        OLD_PWD=$(pwd)

        cd "${DOWNLOAD_DIR}"

        for i in $(seq 0 $PAGE_NUM); do
            get_page "$i"
        done

        mkdir tmpdir

        MAGICK_TMPDIR=./tmpdir convert -limit memory 2GiB -limit map 4GiB *.png book.pdf

        cd "${OLD_PWD}"
        ;;
esac
