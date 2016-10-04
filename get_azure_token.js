var fs = require('fs');
var sep = require('path').sep;
var exec = require('child_process').execSync;

var storage_account = "caapi857";
var resource_group = "CAAPI";

function get_storage_key(account) {
    var account_info = JSON.parse(exec(`azure storage account keys list -g ${resource_group} ${storage_account} --json`).toString());
    return account_info.storageAccountKeys.key1;
}
var storage_key = get_storage_key(storage_account);

console.log('# Environment file for azurefile-dockervolumedriver.service');
console.log('# ');
console.log('# AF_OPTS=--debug');
console.log('# AZURE_STORAGE_BASE=core.windows.net');
console.log('');
console.log(`AZURE_STORAGE_ACCOUNT=${storage_account}`);
console.log(`AZURE_STORAGE_ACCOUNT_KEY=${storage_key}`);