#!/bin/bash
## Simple rough script to install a particular version of operator-sdk on Linux
## Steps are referred for Linux from https://sdk.operatorframework.io/docs/installation/install-operator-sdk/

if [[ -z ${1} ]]
then
	echo "Please provide required version of operator-sdk to be installed"
	echo "Usage: $0 <OPERATOR_SDK_VERSION"
	echo "Example: $0 1.0.0"
	echo
	exit 1
fi

export RELEASE_VERSION=v${1}

if echo $(operator-sdk version | awk -F"," '{ print $1 }') | grep -wq "v${RELEASE_VERSION}"
then
	echo "You already have operator-sdk v${RELEASE_VERSION} installed. Exiting."
	exit 0
fi

echo "-- Downloading operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu binary"
curl -LO https://github.com/operator-framework/operator-sdk/releases/download/${RELEASE_VERSION}/operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu

echo "-- Verifying operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu.asc"
curl -LO https://github.com/operator-framework/operator-sdk/releases/download/${RELEASE_VERSION}/operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu.asc

gpg --verify operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu.asc

#gpg --recv-key "$KEY_ID"

chmod +x operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu && sudo mkdir -p /usr/local/bin/ && sudo cp operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu /usr/local/bin/operator-sdk && rm operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu
