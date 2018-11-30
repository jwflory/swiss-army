#!/bin/bash
#
# Originally written as POC by Patrick Uiterwijk <puiterwijk [dot] redhat [dot] com>
# Modified by Justin W. Flory <jwf [at] fedoraproject [dot] org>

# First, we grab the data
if [ ! -d pkgdb ]; then
    mkdir pkgdb
    (
        cd pkgdb
        curl https://admin.fedoraproject.org/pkgdb/api/packages/ >pkgdb1
        export NUMPAGES=`cat pkgdb1 | grep page_total | awk '{print $2}'`

        for page in $(seq 2 $NUMPAGES)
        do
            echo "Getting page $page"
            curl https://admin.fedoraproject.org/pkgdb/api/packages/?page=$page >pkgdb$page
        done
    )
fi
if [ ! -f projects ];
then
    curl https://release-monitoring.org/api/projects >projects
fi

# Let the magic begin
(cat pkgdb/pkgdb* | sed -e 's/[",:]//g' | grep "name \|upstream_url " | awk '{if($1 ~ /name/) printf "%s: ", $2; else print $2}'; \
cat projects | sed -e 's/[",:]//g' | grep "homepage \|name " | awk '{if($1 ~ /name/) printf "%s: \n",$2; else printf "%s ",$2}' | awk '{print $2, $1}') \
\
| grep "code.google.com\|gitorious.org" | sort | awk '{print $2, $1}' | uniq --skip-fields=1 | awk '{print $2, $1}' | sort
