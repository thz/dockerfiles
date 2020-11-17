#!/bin/bash

die() {
	echo "$*"
	exit 1
}

LISTEN_PORT="${LISTEN_PORT:-51820}"
INTERFACE="${INTERFACE:-wg0}"
ADDRESS="${ADDRESS:-10.254.0.1/24}"
PEER_ALLOWANCE="${PEER_ALLOWANCE:-10.254.0.0/24}"

mkdir -p /run/wireguard

setup() {
	umask 77
	if [ -n "$PRIVATE_KEY" ]; then
		printf "Using specified private key. Public: " >&2
		echo "$PRIVATE_KEY" \
			| tee /run/wireguard/priv \
			| wg pubkey \
			| tee /run/wireguard/pub >&2
	else
		printf "New private key generated. Public: " >&2
		wg genkey \
			| tee /run/wireguard/priv \
			| wg pubkey \
			| tee /run/wireguard/pub >&2
	fi

	echo "Creating wireguard interface [$INTERFACE]." >&2
	ip link add dev "$INTERFACE" type wireguard

	echo "Configuring listen port: $LISTEN_PORT" >&2
	wg set "$INTERFACE" \
		listen-port "$LISTEN_PORT" \
		private-key /run/wireguard/priv

	if [ -n "$ADDRESS" ]; then
		echo "Configuring local address: $ADDRESS" >&2
		ip addr add "$ADDRESS" dev "$INTERFACE"
		ip link set "$INTERFACE" up
	fi
	if [ -n "$PEER_PUBKEY" ]; then
		echo "Configuring peer: $PEER_PUBKEY (allow: $PEER_ALLOWANCE)." >&2
		wg set "$INTERFACE" \
			peer "$PEER_PUBKEY" \
			persistent-keepalive 15 \
			allowed-ips "$PEER_ALLOWANCE"
	fi
}

setup

while sleep 1; do
	printf "\n\n"
	date -uIs
	ip -c addr show type wireguard
	printf "\n"
	wg show
done
