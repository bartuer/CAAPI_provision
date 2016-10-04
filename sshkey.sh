#!/bin/bash

usage() { echo "Usage: $0 -t <subscriptionId> -p <resourceGroupName> -q <deploymentName> -l <resourceGroupLocation>" 1>&2; exit 1; }

node read_key.js

# Initialize parameters specified from command line
while getopts ":t:p:q:l:" o; do
	case "${o}" in
		t)
			echo "in case t"
			subscriptionId=${OPTARG}
			;;
		p)
			resourceGroupName=${OPTARG}
			;;
		q)
			deploymentName=${OPTARG}
			;;
		l)
			resourceGroupLocation=${OPTARG}
			;;
		esac
done
shift $((OPTIND-1))

#Prompt for parameters is some required parameters are missing
if [ -z "$subscriptionId" ]; then
        subscriptionId=e225d10c-2fce-4a2c-8ab8-fbf0cf28b99e
fi

if [ -z "$resourceGroupName" ]; then
        resourceGroupName=CAAPI
fi

if [ -z "$deploymentName" ]; then
	echo "you will check the deployment status https://ms.portal.azure.com/#resource/subscriptions/e225d10c-2fce-4a2c-8ab8-fbf0cf28b99e/resourcegroups/CAAPI/eventlogs"
        deploymentName="caapi_nixml_sshey"  
fi

if [ -z "$resourceGroupLocation" ]; then
        resourceGroupLocation=japaneast
fi

#templateFile Path - template file to be used
templateFilePath="sshkey.json"

#parameter file path
parametersFilePath="sshkey.parameters.json"

if [ -z "$subscriptionId" ] || [ -z "$resourceGroupName" ] || [ -z "$deploymentName" ]; then
	echo "Either one of subscriptionId, resourceGroupName, deploymentName is empty"
	usage
fi

#login to azure using your credentials
# azure login

#set the default subscription id
echo "Set account to $subscriptionId"
azure account set $subscriptionId

#switch the mode to azure resource manager
azure config mode arm

#Check for existing resource group
if [ -z "$resourceGroupLocation" ] ; 
then
	echo "Using existing resource group..."
else 
	echo "Creating a new resource group..." 
	azure group create --name $resourceGroupName --location $resourceGroupLocation
fi

echo "Deploy to location: $resourceGroupLocation"

#Start deployment
echo "Starting sshkey deployment..."
azure group deployment create --name $deploymentName --resource-group $resourceGroupName --template-file $templateFilePath --parameters-file $parametersFilePath -v