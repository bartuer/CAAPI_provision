var fs = require('fs');
var sep = require('path').sep;
var sshkey_parameter = JSON.parse(fs.readFileSync([process.cwd(), 'sshkey.parameters.json'].join(sep)));
console.dir(sshkey_parameter);
var key_parts = fs.readFileSync([process.env[(process.platform == 'win32') ? 'USERPROFILE' : 'HOME'], '.ssh', 'id_rsa.pub'].join(sep)).toString().split(' ');
key_parts.splice(2);
sshkey_parameter.parameters.sshkey.value = key_parts.join(" ");
fs.writeFileSync([process.cwd(), 'sshkey.parameters.json'].join(sep), JSON.stringify(sshkey_parameter, null, 4));