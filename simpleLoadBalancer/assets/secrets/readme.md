# How to

When executing the terraform for the first time, execute ssh-keygen command and save the keys to a different name, say x_id_rsa.
This will create 2 files in `.ssh` folder, namely `x_id_rsa` and `x_id_rsa.pub`.
The `id_rsa` (private key) has to be copied to the `x_id_rsa`, using `nano`.
The `id_rsa.pub` (private key) has to be copied to the `x_id_rsa.pub`, using `nano`.
The mode of the file has to be changed to `0600`

Commands are:

Change directory : `cd ~`
Generate rsa key: `ssh-keygen -t rsa -b 4096`
Change mode: `chmod 0600 x_id_rsa`
Edit file: `nano x_id_rsa`
ssh into the machine: `ssh adminuser@20.71.252.167 -p 22 -i x_id_rsa`