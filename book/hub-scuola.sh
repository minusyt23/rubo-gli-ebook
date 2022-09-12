#!/bin/bash

# Questo script ha bisogno di un path fondamentale delle immagini
# della token di merda di pspdfkit o come si chiama
# e del numero di pagine da scaricare

# tutt'e due le cose si trovano svoltando pagina
# guardando la network tab.

# Cambia le variabili qui perchè non ho voglia di fare check negli argomenti.

BASE_LINK="https://ms-pdf.hubscuola.it/i/d/6111755/h/g1AAAABMeJwVxEEOgDAIRFHjiSAthe68ygzUuPH-W-t_yX_O99j9u9RSLBejoIbR6RTC3LiBaDFGF12z623Zoko1UiYkpxP-AbSZE1A/"

TOKEN="SFMyNTY.g2gDYQN0AAAAAm0AAAALZG9jdW1lbnRfaWRtAAAABzYxMTE3NTVtAAAABWxheWVybQAAAABiYybxLA.vN8RbW-ac5yoxEX6LeER999pW_6LOXIOA4wnqIVBaKA"

USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"

HEADER="X-PSPDFKit-Image-Token: ${TOKEN}"

PAGE_NUM=0

DOWNLOAD_DIR=".";

get_page() {
    DIM="2382-3289"

    TILES="0-0-512-512 507-0-512-512 1014-0-512-512 1521-0-512-512 2028-0-354-512 0-507-512-512 507-507-512-512 1014-507-512-512 1521-507-512-512 2028-507-354-512 0-1014-512-512 507-1014-512-512 1014-1014-512-512 1521-1014-512-512 2028-1014-354-512 0-1521-512-512 507-1521-512-512 1014-1521-512-512 1521-1521-512-512 2028-1521-354-512 0-2028-512-512 507-2028-512-512 1014-2028-512-512 1521-2028-512-512 2028-2028-354-512 0-2535-512-512 507-2535-512-512 1014-2535-512-512 1521-2535-512-512 2028-2535-354-512 0-3042-512-247 507-3042-512-247 1014-3042-512-247 1521-3042-512-247 2028-3042-354-247"

    i=0

    echo "Downloading page ${1}..."

    for tile in $TILES; do
        wget -U "${USER_AGENT}" --header="${HEADER}" -O "page-tile-${i}" -q "${IMG_PATH}page-${1}-dimensions-${DIM}-tile-${tile}"
        ((i=i+1))
        # sleep 0.1
    done

    ALL_IMAGES=$(ls -v | grep "page-tile")

    montage $ALL_IMAGES -tile 5x7 -geometry -3-3 -background none "page-${1}.png"

    rm $ALL_IMAGES

    echo "Page ${1} downloaded."
}

# Main
# $1 is page num

# check if argument is num

make_book() {
    DOWNLOAD_DIR=$1;

    OLD_PWD=$(pwd)

    cd "${DOWNLOAD_DIR}"

    for i in $(seq 0 $PAGE_NUM); do
        get_page $i $BASE_LINK
    done

    mkdir tmpdir

    MAGICK_TMPDIR=./tmpdir convert -limit memory 2GiB -limit map 4GiB *.png book.pdf

    cd "${OLD_PWD}"
}
