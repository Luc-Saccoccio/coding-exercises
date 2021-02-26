read -r x
read -r y
printf "%s\n%s\n%s\n%s\n" "$((x+y))" "$((x-y))" "$((x*y))" "$((x/y))"
