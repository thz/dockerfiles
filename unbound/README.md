## Configuration

### $VERBOSITY
Level of verbosity. See nsd documentation for details.

### $CONFIG
A non-default path to a nsd configuration file can be specified by `$CONFIG` variable.

### $CONFIG_NO_IPV6

### $CONFIG_LOG_QUERIES

### $CONFIG_INCLUDE_FILES
List of include directives (wildcards allowed) separated by `:`.

## Example stub-zone:

```
stub-zone:
	name: "example.com"
	stub-host: nameserver.svc.cluster.local.
```
