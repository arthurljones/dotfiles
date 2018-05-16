comment="^[ \t]*#"
name_glob=${1:-"*.rb"}
echo $name_glob
for file in `find . -name "$name_glob"`; do
    args="$(grep '$comment)' $file | wc -l) $(wc -l $file) $file"
    awk_cmd='{ comments = int($1 * 100 / $2); if (comments > 0) { print comments " " $3 }}'
    echo $args | awk "$awk_cmd"
done | sort -h -k 1 -t' '
