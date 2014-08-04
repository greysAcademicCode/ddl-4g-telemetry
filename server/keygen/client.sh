#!/bin/sh
CNAME=billy
ipsec pki --gen --outform pem > ${CNAME}clientKey.pem
ipsec pki --pub --in ${CNAME}clientKey.pem | ipsec pki --issue --cacert caCert.pem --cakey caKey.pem --dn "C=US, O=xxx, CN=${CNAME}" --outform pem > ${CNAME}clientCert.pem
openssl pkcs12 -export -inkey ${CNAME}clientKey.pem -in ${CNAME}clientCert.pem -name "${CNAME}" -certfile caCert.pem -caname "${CNAME}" -out ${CNAME}clientCert.p12
cp ${CNAME}clientCert.pem /etc/ipsec.d/certs/
cp ${CNAME}clientKey.pem /etc/ipsec.d/private/
cp caKey.pem /etc/ipsec.d/private/
