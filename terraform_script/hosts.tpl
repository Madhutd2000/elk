[es]
%{ for index,ip in es ~}
${format("es%d", index + 1)}  ansible_host=${ip}  ansible_ssh_private_key_file=../${pemkey}.pem ansible_user=${usr}
%{ endfor ~}

[logstash]
%{ for index,ip in ls ~}
${format("lg%d", index + 1)}  ansible_host=${ip}  ansible_ssh_private_key_file=../${pemkey}.pem ansible_user=${usr}
%{ endfor ~}


[kibana]
%{ for index,ip in ki ~}
kib  ansible_host=${ip}  ansible_ssh_private_key_file=../${pemkey}.pem ansible_user=${usr}
%{ endfor ~}

[elk]
es1
es2
es3
lg1
lg2
kib

[pass]
es1
kib

[logs]
es1
lg1
lg2


[copies]
es2
es3
