#!/usr/bin/env bash
################################################################################
################################################################################

declare    AppBin=$(realpath "${BASH_SOURCE}")
declare    AppRoot=$(dirname "${AppBin}")
declare -r AppVersion="1.0.0-dev"

declare -A Config=(
	["AppRoot"]="${AppRoot}"
	["ConfDir"]="${AppRoot}/.cfg"
	["HelpDir"]="${AppRoot}/.docs"
	["FuncDir"]="${AppRoot}/.fn"
);

################################################################################
################################################################################

function OPSATClient {(

	declare -A Commands=()
	declare Cmd=$1
	declare Args=${@:2}

	declare -r KTHXBAI=0
	declare -r OHSNAP=1

	################################
	################################

	function Constructor() {

		return $KTHXBAI
	};

	################################
	################################

	function _CheckAPIKey() {

		if [[ ! -v OPSAT_API_KEY ]];
		then
			return $OHSNAP
		fi

		return $KTHXBAI
	};

	function _CheckInstallCURL() {

		command -v "curl" >/dev/null 2>&1

		if [[ $? -ne 0 ]];
		then
			return $OHSNAP
		fi

		return $KTHXBAI
	};

	function _CheckInstallJQ() {

		command -v "jq" >/dev/null 2>&1

		if [[ $? -ne 0 ]];
		then
			return $OHSNAP
		fi

		return $KTHXBAI
	};

	function _LoadPluginsFrom() {

		local Dir=$1
		local File=""

		########

		for File in ${Dir}/*.sh;
		do
			source "${File}"
		done

		########

		return $KTHXBAI
	};

	function _ExecuteCommand() {

		# reference $Commands

		local Cmd=$1
		local Args=$2

		########

		if [[ -v Commands[$Cmd] ]];
		then
			${Commands[$Cmd]} $Args
			exit $?
		fi

		########

		return $KTHXBAI
	};

	################################
	################################

	_CheckAPIKey
	if [[ $? -ne $KTHXBAI ]];
	then
		echo "No OPSAT_API_KEY defined."
		exit $OHSNAP
	fi

	_CheckInstallCURL
	if [[ $? -ne $KTHXBAI ]];
	then
		echo "no 'curl' found"
		exit $OHSNAP
	fi

	_CheckInstallJQ
	if [[ $? -ne $KTHXBAI ]];
	then
		echo "no 'jq' found"
		exit $OHSNAP
	fi

	################################
	################################

	function OPSATCommandRegister() {

		# reference $Commands
		# plugin api function

		local Cmd=$1
		local Fnc=$2

		Commands[$Cmd]=$Fnc

		return $KTHXBAI
	};

	Constructor $*
	_LoadPluginsFrom "${Config['FuncDir']}"
	_ExecuteCommand "${Cmd}" "${Args}"

	exit $KTHXBAI
)};

OPSATClient $*

if [[ $BASH_SOURCE == $0 ]];
then
	exit $?
else
	return $?
fi
