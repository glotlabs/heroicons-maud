#!/bin/bash
set -e

git clone git@github.com:tailwindlabs/heroicons.git > /dev/null

echo "use maud::html;"
echo "use maud::Markup;"

for icon_type in "outline" "solid"; do
    for path in heroicons/optimized/24/"$icon_type"/*.svg; do
        file="$(basename -- "$path")"
        name="${file%.*}"
        icon_name="${name//-/_}"

        fn_head="pub fn ${icon_name}_${icon_type}() -> Markup {"
        fn_body="$(html-to-maud convert < "$path" | awk '{ print "    " $0 }')"
        fn_tail="}"

        echo
        echo "$fn_head"
        echo "$fn_body"
        echo "$fn_tail"
    done
done


rm -rf heroicons
