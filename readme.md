# TPM2 SSH Key Setup

`tpm2_ptool init`

`export HISTFILE=/dev/null`

`tpm2_ptool addtoken --pid=1 --label=ftpmtoken1 --sopin=youradminpassword --userpin=youruserpassword`

`tpm2_ptool addkey --algorithm=ecc256 --label=ftpmtoken1 --userpin=youruserpassword`

to get the public Key

`ssh-keygen -D /run/current-system/sw/lib/libtpm2_pkcs11.so > ~/.ssh/tpm.pub`

to add to the SSH agent

`ssh-add -s /run/current-system/sw/lib/libtpm2_pkcs11.so`

# TPM2 GPG Key Setup

`gpg --quick-generate-key "Alec Miller <alecmichaelmiller@gmail.com>" rsa2048`

`gpg --edit-key alecmichaelmiller@gmail.com`

`keytotpm`

Ctrl+C out of the GPG CLI

`gpg --armor --export alecmichaelmiller@gmail.com`
