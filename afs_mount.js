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
var storage = {
    get_key: get_storage_key,
    account: storage_account
};

var storage_key = storage.get_key(storage.account);
var account = storage.account;

console.log(`//${account}.file.core.windows.net/data /ml/storage/data cifs vers=3.0,username=${account},password=${storage_key},dir_mode=0777,file_mode=0777`);
console.log(`//${account}.file.core.windows.net/code /ml/storage/data cifs vers=3.0,username=${account},password=${storage_key},dir_mode=0777,file_mode=0777`);