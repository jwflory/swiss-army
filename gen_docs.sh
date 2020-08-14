#!/bin/sh
#
# Barebones Asciidoctor docs deployment. Literally, barebones.


# Always start from docs source directory and purge old site source.
cd "$(dirname "$0")/docs/" && rm -rf _build/


# Generate HTML pages for each AsciiDoc source file.
for doc in *; do
    asciidoctor \
        --backend=html5 \
        --doctype=article\
        --out-file _build/$(echo $doc | sed --expression='s/.adoc//')/index.html \
        $doc
done
