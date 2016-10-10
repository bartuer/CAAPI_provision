var storage = require('./afs_storage.js');
var storage_key = storage.get_key(storage.account);

console.log('# Environment file for azurefile-dockervolumedriver.service');
console.log('# ');
console.log('# AF_OPTS=--debug');
console.log('# AZURE_STORAGE_BASE=core.windows.net');
console.log('');
console.log(`AZURE_STORAGE_ACCOUNT=${storage.account}`);
console.log(`AZURE_STORAGE_ACCOUNT_KEY=${storage_key}`);