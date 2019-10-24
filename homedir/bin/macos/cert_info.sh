#!/usr/bin/env bash

# outputs certificate information for .app or .pkg

app_name="$1"
echo $app_name
#app_path=/Users/dpc/Downloads/"${app_name}"
app_path=/Applications/"${app_name}"
echo $app_path

pkgutil --check-signature "${app_path}"

codesign -dvvvv --extract-certificates "${app_path}"
openssl x509 -inform DER -in codesign0 -text > "$app_name".cert.txt
openssl x509 -inform DER -in codesign1 -text > "$app_name".cert1.txt
openssl x509 -inform DER -in codesign2 -text > "$app_name".cert2.txt

grep "Not After" "$app_name".*.txt

echo can run:
echo qlmanage -c public.x509-certificate -p codesign*
