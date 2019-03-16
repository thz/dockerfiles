#!/bin/sh

die() {
	echo "$*" > /dev/stderr
	exit 1
}

zonedir="$1" ; shift

[ ! -d "$zonedir" ] && die "Zonedir \"$zonedir\" does not exist."

cd "$zonedir"
ls | while read candidate; do
	# a valid zone will have its name in its first line
	# this is our assumption for auto-config-generation
	head -n 1 "$candidate" | grep -q "$candidate" || continue

	printf "\nzone:\n"
	printf "\tname: \"%s\"\n" "$candidate"
	printf "\tzonefile: \"/zones/%%s\"\n"
done
