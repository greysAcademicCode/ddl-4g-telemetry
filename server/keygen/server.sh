#!/bin/sh
SERVERN=marba.stanford.edu
ipsec pki --gen --outform pem > caKey.pem
ipsec pki --self --in caKey.pem --dn "C=US, O=xxx, CN=${SERVERN}" --ca --outform pem > caCert.pem
ipsec pki --gen --outform pem > serverKey.pem
ipsec pki --pub --in serverKey.pem | ipsec pki --issue --cacert caCert.pem --cakey caKey.pem --dn "C=US, O=xxx, CN=${SERVERN}" --san="${SERVERN}" --flag serverAuth --flag ikeIntermediate --outform pem > serverCert.pem
cp caCert.pem /etc/ipsec.d/cacerts/
cp serverCert.pem /etc/ipsec.d/certs/
cp serverKey.pem /etc/ipsec.d/private/
