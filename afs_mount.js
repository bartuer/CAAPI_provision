var storage = require('./afs_storage.js');
var storage_key = storage.get_key(storage.account);
var account = storage.account;

console.log(`//${account}.file.core.windows.net/data /ml/storage/data cifs vers=3.0,username=${account},password=${storage_key} dir_mode=0777,file_mode=0777`);
console.log(`//${account}.file.core.windows.net/code /ml/storage/data cifs vers=3.0,username=${account},password=${storage_key} dir_mode=0777,file_mode=0777`);