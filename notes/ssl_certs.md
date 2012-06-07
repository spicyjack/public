Changing the password in a key?
Changing certificate formats?
What cert formats are used for which purposes?

Generating SSL certificates for signing by a CA
===============================================
For the initial SSL cert generation, you can use 'make certificate type=CUSTOM'
inside of Apache.  This will generate both the custom Certificate Authority
(CA) certificate (ca.crt) , and the server's certificate (server.crt).  Once
you have a CA certificate, you can sign more certificates.  There's a Perl
script inside of OpenSSL called 'CA.pl' that will do the work for you.
Here's how you use it:

$ perl CA.pl -newreq (You'll be prompted for a password for this new SSL key)

# You can see the details of this RSA private key via the command:
$ openssl rsa -noout -text -in newkey.pem

# And you could create a decrypted PEM version (not recommended) of this RSA
# private key via:

$ openssl rsa -in newkey.pem -out newkey.pem.nopass

# sign the CSR with CA.pl

$ perl CA.pl -sign (You'll be prompted for the CA password)

# View the signed certificate

openssl x509 -noout -text -in newcert.pem

Creating a CA certificate
=========================
$ CA.pl -newca (You'll be prompted for a new CA key password)

# You can see the details of this RSA private key via the command

$ openssl rsa -noout -text -in /root/CA/private/cakey.pem

# And you can create a decrypted PEM version (not recommended) of this private
# key via:

$ openssl rsa -in ca.key -out ca.key.unsecure

Creating a self-signed SSL Cert for testing purposes
====================================================
openssl req -new -x509 -nodes -out server.crt -keyout server.key

# vim: filetype=markdown tabstop=2
