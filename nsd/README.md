## Configuration

### $LISTEN
Listen to the specified incoming IP address. The format is `ip-address[@port]`.

### $VERBOSITY
Level of verbosity. See nsd documentation for details.

### $CONFIG
A non-default path to a nsd configuration file can be specified by `$CONFIG` variable.

### $CONFIG_AUTO_ZONES
Adding a simple zone configuration per available zonefile is supported. Setting `$CONFIG_AUTO_ZONES` to a non-empty value will create the config fragment automatically. To make this work the basename of the zonefile must match the zonename (without the trailing dot). In addition to that the first line of the zonefile must include the zonename. This option has no effect when `$CONFIG` is specified.

### $CONFIG_APPEND_FILE
The file pointed to by `$CONFIG_APPEND_FILE` will be appended as a last configuration file fragment. This option has no effect when `$CONFIG` is specified.

## Example zone:

```
$ORIGIN example.com.
$TTL 1800
@       IN      SOA     ns1.example.com.      admin.example.com. (
                        2014070201        ; serial number
                        3600                    ; refresh
                        900                     ; retry
                        1209600                 ; expire
                        1800                    ; ttl
                        )
; Name servers
                    IN      NS      ns1.example.com.
                    IN      NS      ns2.example.com.

; A records for name servers
ns1                 IN      A       192.0.2.1
ns2                 IN      A       192.0.2.2

; Additional A records
@                   IN      A       192.0.2.3
www                 IN      A       192.0.2.3
```
