################################################################################
## opsat.sh list #############################################################

OPSATCommandRegister "list" "CommandList"

################################################################################
################################################################################

function CommandList() {(

	local Arg=""
	local Mode="default"

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

	JSON=$(curl -s "https://opsat.net/opi/domain" --request "LIST" --data "apikey=$OPSAT_API_KEY")

	########

	if [[ $Mode == "default" ]];
	then
		JQED=$(jq -r "([\"Domain\",\"CertDateExpire\",\"CertWhenExpire\"] | @tsv), ([\"------\",\"--------------\",\"--------------\"] | @tsv), (.Payload.Domains[] | [.Domain, .CertDateExpire, .CertWhenExpire] | @tsv)" <<< "$JSON")
		TBLD=$(column -ts $'\t' <<< "$JQED")
		echo "$TBLD"
	fi

	########

	if [[ $Mode == "json" ]];
	then
		jq ".Payload.Domains" <<< "$JSON"
	fi

	return $KTHXBAI
)};
