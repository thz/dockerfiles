#!/bin/sh

die() {
	echo "$*"
	exit 1
}

mkdir -p /run/unbound
chown unbound /run/unbound

FLAGS="-d -c /etc/unbound/unbound.conf"
[ -n "$LISTEN" ] && FLAGS="$FLAGS -a $LISTEN"
[ -n "$VERBOSITY" ] && FLAGS="$FLAGS -v"

if [ -z "$CONFIG" ]; then
	CONFIG=/etc/unbound/unbound.conf
	(
		printf "\nserver:\n"
		printf "\tlogfile: \"/dev/stdout\"\n"
		[ -n "$CONFIG_NO_IPV6" ] && printf "\tdo-ip6: no\n"
		[ -n "$CONFIG_LOG_QUERIES" ] && printf "\tlog-queries: yes\n"

		if [ -n "$CONFIG_INCLUDE_FILES" ]; then
			IFS=:
			for incl in $CONFIG_INCLUDE_FILES; do
				printf "\ninclude: %s\n" "$incl"
			done
			unset IFS
		fi
	) >> $CONFIG
fi
[ ! "$CONFIG" = /etc/unbound/unbound.conf ] && ln -snf $CONFIG /etc/unbound/unbound.conf

/usr/sbin/unbound -h | grep ^Version
echo "Running unbound-anchor..."
/usr/sbin/unbound-anchor
echo "Starting unbound with flags: $FLAGS"
exec /usr/sbin/unbound $FLAGS
