################################################################################
## opsat.sh list #############################################################

OPSATCommandRegister "get" "CommandGet"

################################################################################
################################################################################

function CommandGet() {(

	local Domain=$1

	JSON=$(curl -s "https://opsat.net/opi/domain?apikey=$OPSAT_API_KEY&domain=$Domain" --request "GET")

	jq ".Payload.Domain" <<< "$JSON"

	return $KTHXBAI
)};
