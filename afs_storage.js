var fs = require('fs');
var sep = require('path').sep;
var exec = require('child_process').execSync;

var storage_account = "caapi857";
var resource_group = "CAAPI";

function get_storage_key(account) {
    var account_info = JSON.parse(exec(`azure storage account keys list -g ${resource_group} ${storage_account} --json`).toString());
    if (account_info.storageAccountKeys) {
        return account_info.storageAccountKeys.key1;
    } else {
        return account_info[0].value;
    }
}
module.exports = {
    get_key: get_storage_key,
    account: storage_account
};