#!/bin/sh

die() {
	echo "$*"
	exit 1
}

mkdir -p /run/nsd
chown nsd /run/nsd
[ ! -d /zones ] && die "/zones missing"

FLAGS="-d -l /dev/stdout -c /etc/nsd/nsd.conf"
[ -n "$LISTEN" ] && FLAGS="$FLAGS -a $LISTEN"
[ -n "$VERBOSITY" ] && FLAGS="$FLAGS -V $VERBOSITY"

if [ -z "$CONFIG" ]; then
	CONFIG=/etc/nsd/nsd.conf.sample
	if [ -n "$CONFIG_AUTO_ZONES" ]; then
		/create-zone-config.sh /zones >> $CONFIG
	fi
	if [ -n "$CONFIG_APPEND_FILE" ]; then
		cat "$CONFIG_APPEND_FILE" >> $CONFIG
	fi
fi
[ ! "$CONFIG" = /etc/nsd/nsd.conf ] && ln -snf $CONFIG /etc/nsd/nsd.conf

/usr/sbin/nsd -v
echo "Starting nsd with flags: $FLAGS"
exec /usr/sbin/nsd $FLAGS
