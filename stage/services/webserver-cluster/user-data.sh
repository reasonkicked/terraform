#!/bin/bash

cat > index.html <<EOF
    echo "Hello, World" > index.html
    echo "${data.terraform_remote_state.db.outputs.address}" >> index.html
    echo "${data.terraform_remote_state.db.outputs.port}" >> index.html
    EOF
    nohup busybox httpd -f -p ${var.server_port} &
   