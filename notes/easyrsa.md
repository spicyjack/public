# EasyRSA #

## URLs ##
- https://github.com/OpenVPN/easy-rsa

Download the latest EasyRSA release from
https://github.com/OpenVPN/easy-rsa/releases, and unpack it into a working
directory, hopefully on a host that's disconnected from the network or powered
off when not in use.

## Generating a CA Certificate ##
Grab the `vars.example` file from the EasyRSA distribution and customize to
suit.  Name your customized copy `easyrsa.vars`, then, on your CA host...

    mkdir ${WORKING}/easyrsa
    cp easyrsa.vars ${WORKING}/easyrsa/
    cd ${WORKING}/easyrsa
    sudo ln -s ../easyrsa.vars vars
    ./easyrsa init-pki
    # will prompt for a CA passphrase
    ./easyrsa build-ca

## Generating a Client or Server Certificate ##
For both client and server hosts, generate a CSR...

    # will not prompt for a passphrase
    ./easyrsa gen-req <Certificate_Name> nopass

    # will prompt for a passphrase for the SSL key
    ./easyrsa gen-req <Certificate_Name>

Unless you plan on passing in the PEM password every time you start your
program that uses the SSL certificates, you should probably use the `nopass`
version of the `gen-req` command above.

Sign a server request...

    ./easyrsa sign-req server <Certificate Name>

Sign a client request...

    sudo ./easyrsa sign-req client <Certificate Name>

Copy the `ca.cert` and `pki/issued/<Certificate Name>.crt` files back to the
remote server.

## Revoking Certificates ##
Revoke a certificate

    ./easyrsa revoke <Certificate Name>

Generate a "certificate revocation list" (CRL)

    sudo ./easyrsa gen-crl

Copy the certificate revocation list to the server, and add it to the file
that's specified for SSL certificate revokation in your server application.

## Certificate Details ##
Show details of requests or certifictes

    ./easyrsa show-req <Certificate Name>
    ./easyrsa show-cert <Certificate Name>

## Changing Private Key Passphrase ##
Changing the passphrase of a private key

    ./easyrsa set-rsa-pass <Certificate Name>
    ./easyrsa set-ec-pass <Certificate Name>

vim: filetype=markdown tabstop=2 shiftwidth=2
