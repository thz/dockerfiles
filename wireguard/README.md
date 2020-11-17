## Configuration

### PRIVATE_KEY (no default)
Set this variable to inject an existing private key. Public key will be derived. Private key will be generated on startup if not specified.

### PEER_PUBKEY (no default)
Set this variable to add a peer definition after configuring the server side.

### LISTEN_PORT (defaul: 51820)
Set the listening port for the server side.

### INTERFACE (default: wg0)
Set the interface name.

### ADDRESS (default: 10.254.0.1/24)
Set an address for the server side interface (CIDR notation).

### PEER_ALLOWANCE (default: 10.254.0.0/24)
Set allowed (overlay) address for the connecting peer. Can be specific IP address or CIDR notation.

