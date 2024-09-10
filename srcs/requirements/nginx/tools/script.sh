#!/bin/bash

# Variables
DOMAIN="mdouzi.42.fr"
CERTS_DIR="/etc/nginx/ssl"
KEY_FILE="$CERTS_DIR/$DOMAIN.key"
CERT_FILE="$CERTS_DIR/$DOMAIN.crt"
DAYS_VALID=365

# Create directory for SSL certificates if it doesn't exist
mkdir -p $CERTS_DIR

# Generate the private key without encryption
openssl genpkey -algorithm RSA -out $KEY_FILE

# Generate the self-signed certificate
openssl req -new -key $KEY_FILE -x509 -out $CERT_FILE -days $DAYS_VALID -subj "/CN=$DOMAIN"

# Output the locations of the generated files
echo "SSL Certificate generated:"
echo "Private Key: $KEY_FILE"
echo "Certificate: $CERT_FILE"



