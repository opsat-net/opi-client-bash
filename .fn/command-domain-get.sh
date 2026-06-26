################################################################################
## opsat.sh list #############################################################

OPSATCommandRegister "get" "CommandGet"

################################################################################
################################################################################

function CommandGet() {(

	local Domain=$1
	local Mode="normal"

	local JSON
	local JQED
	local TBLD

	################################
	################################

	for Arg in "$@";
	do
		if [[ $Arg == "--json" ]];
		then
			Mode="json"
		fi
	done

	################################
	################################

	JSON=$(curl -s "https://opsat.net/opi/domain?apikey=$OPSAT_API_KEY&domain=$Domain" --request "GET")

	if [[ $Mode == "normal" ]];
	then
		JQED=$(jq -r "([\"Domain\",\"CertDateExpire\",\"CertWhenExpire\"] | @tsv), ([\"------\",\"--------------\",\"--------------\"] | @tsv), (.Payload.Domain | [.Domain, .CertDateExpire, .CertWhenExpire] | @tsv)" <<< "$JSON")
		TBLD=$(column -ts $'\t' <<< "$JQED")
		echo "$TBLD"
	fi

	if [[ $Mode == "json" ]];
	then
		jq ".Payload.Domain" <<< "$JSON"
	fi

	return $KTHXBAI
)};
