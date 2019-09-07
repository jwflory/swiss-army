#!/bin/bash
#
# Author:
#     Justin W. Flory
#
# About:
#     Hacky script to cobble together multiple gitignores into a single file.
#     Depends on collection of gitignores maintained by GitHub.
#
# Usage:
#     Add/remove URLs to gitignores you want to the $gitignore_url array.
#
# Known issues:
#     Python gitignore does not label correctly. My `cut` sequence is not
#     sufficient. If I have more time to work on this later, I will probably
#     move it to Python.
#
# License:
#     This Source Code Form is subject to the terms of the Mozilla Public
#     License, v. 2.0. If a copy of the MPL was not distributed with this
#     file, You can obtain one at https://mozilla.org/MPL/2.0/.

gitignore_url=(
    https://raw.githubusercontent.com/github/gitignore/master/Global/Ansible.gitignore
    https://raw.githubusercontent.com/github/gitignore/master/Global/Linux.gitignore
    https://raw.githubusercontent.com/github/gitignore/master/Global/macOS.gitignore
    https://raw.githubusercontent.com/github/gitignore/master/Global/NotepadPP.gitignore
    https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore
    https://raw.githubusercontent.com/github/gitignore/master/Global/SublimeText.gitignore
    https://raw.githubusercontent.com/github/gitignore/master/Global/Vim.gitignore
    https://raw.githubusercontent.com/github/gitignore/master/Global/Windows.gitignore
)

get_gitignore_name() {
    local url="$1"
    echo "$url" | cut -d "/" -f 8 | cut -d "." -f 1
}

for url in ${gitignore_url[@]}; do
    gi_type=$(get_gitignore_name $url)
    echo -e "#############\n# $gi_type\n#############\n\n"
    curl -s $url
    echo -e "\n\n"
done
