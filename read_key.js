var fs = require('fs');
var sep = require('path').sep;

// find ssh key
var sshkey_parameter = JSON.parse(fs.readFileSync([process.cwd(), 'sshkey.parameters.json'].join(sep)));
console.dir(sshkey_parameter);
var key_parts = fs.readFileSync([process.env[(process.platform == 'win32') ? 'USERPROFILE' : 'HOME'], '.ssh', 'id_rsa.pub'].join(sep)).toString().split(' ');
key_parts.splice(2);
sshkey_parameter.parameters.sshkey.value = key_parts.join(" ");

// find machine name and username
var machine_parameter = JSON.parse(fs.readFileSync([process.cwd(), 'parameters.json'].join(sep)));
var user_name = machine_parameter.parameters.virtualMachines_nixml_adminUsername.value;
var machine_name = machine_parameter.parameters.virtualMachines_nixml_name.value;
sshkey_parameter.parameters.virtualMachines_nixml_adminUsername = user_name;
sshkey_parameter.parameters.virtualMachines_nixml_name = machine_name;

fs.writeFileSync([process.cwd(), 'sshkey.parameters.json'].join(sep), JSON.stringify(sshkey_parameter, null, 4));