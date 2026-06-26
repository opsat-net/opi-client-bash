# Bash Script API client for OPSAT.net OPI

Lightweight API client to query the SSL certs tracked in an OPSAT.net account. It should be simple enough to fill its few dependencies via your system's package manager.

## Requirements

* Bash 4+ (does not need to be your active shell)
* cURL (https://curl.se/)
* jq (https://jqlang.org/)
* an OPSAT.net API key

## Installation

```bash
git clone https://github.com/opsat-net/opi-client-bash
cd opi-client-bash
```

## Usage

Configure the API key.

```bash
export OPSAT_API_KEY=<YOUR-API-KEY-HERE>
```

Fetch a list of all the domains tracked in the account in a human readable format.

```bash
./opsat.sh list
```

Fetch a list of all the domains tracked in the account as a JSON array.

```bash
./opsat.sh list --json
```

## TODO

```bash
./opsat.sh get <domain>
./opsat.sh add <domain>
./opsat.sh del <domain>
```
