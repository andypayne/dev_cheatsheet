# Generating a self-signed certificate for development

It's useful to be able to test TLS/HTTPS services on your local dev system. To
do that one option is to generate a self-signed certificate to use, and add that
to your local trust store.


## Generating a certificate and key

```shell
openssl req \
  -newkey rsa:2048 \
  -nodes \
  -sha256 \
  -x509 \
  -out localhost.crt \
  -keyout localhost.key \
  -subj '/CN=localhost' -extensions EXT -config <( \
   printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
```

## Adding it to the trust store (on Ubuntu Linux)

Copy it to `/usr/local/share/ca-ca-certificates`, and then run
`update-ca-certificates`:

```shell
sudo cp localhost.crt /usr/local/share/ca-certificates
sudo update-ca-certificates
Updating certificates in /etc/ssl/certs...
1 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...

Adding debian:localhost.pem
done.
done.
```

## Verifying the certificate

A quick sanity test is to search for the certificate's presence in
`/etc/ssl/certs/ca-certificates.crt`:
```shell
grep `head -n 2 localhost.crt | grep -v "BEGIN CERT" | cut -c1-50` /etc/ssl/certs/ca-certificates.crt
```

## Generating with a new root certificate

Also see [this article](https://www.freecodecamp.org/news/how-to-get-https-working-on-your-local-development-environment-in-5-minutes-7af615770eec/).

Generate an RSA-2048 key:
```shell
openssl genrsa -des3 -out localhost_rootCA.key 2048
```

Enter a passphrase to use each time you use this to generate a certificate.

```shell
openssl req -x509 -new -nodes -key localhost_rootCA.key -sha256 -days 1024 -out localhost_rootCA.pem
Enter pass phrase for localhost_rootCA.key:
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:US
State or Province Name (full name) [Some-State]:California
Locality Name (eg, city) []:San Francisco
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Localhost
Organizational Unit Name (eg, section) []:Localhost
Common Name (e.g. server FQDN or YOUR name) []:Localhost Certificate
Email Address []:my_email@example.com
```

```shell
openssl x509 -in localhost_rootCA.pem -inform PEM -out localhost_rootCA.crt
```

```shell
sudo mkdir /usr/share/ca-certificates/extra
sudo cp localhost_rootCA.crt /usr/share/ca-certificates/extra/
```

Add the certificate by running either:
```shell
sudo dpkg-reconfigure ca-certificates
```

and interactively add trust, or run:
```shell
sudo update-ca-certificates
```

To easily work with Go's TLS config, create a version of the key file with no password:
```shell
openssl rsa -in localhost_rootCA.key -out localhost_rootCA.unenc.key -passin pass:YOUR_PASSWORD
```

After running the server with this combo, verification works:
```shell
❯ openssl s_client -tls1_3 -connect localhost:8083 -CApath /etc/ssl/certs/
CONNECTED(00000003)
Can't use SSL_get_servername
depth=0 C = US, ST = California, L = San Francisco, O = Localhost, OU =
Localhost, CN = Localhost Certificate, emailAddress = ...
verify return:1
---
Certificate chain
 0 s:C = US, ST = California, L = San Francisco, O = Localhost, OU = Localhost,
CN = Localhost Certificate, emailAddress = ...
   i:C = US, ST = California, L = San Francisco, O = Localhost, OU = Localhost,
CN = Localhost Certificate, emailAddress = ...
---
Server certificate
-----BEGIN CERTIFICATE-----
...
-----END CERTIFICATE-----
subject=C = US, ST = California, L = San Francisco, O = Localhost, OU =
Localhost, CN = Localhost Certificate, emailAddress = ...

issuer=C = US, ST = California, L = San Francisco, O = Localhost, OU =
Localhost, CN = Localhost Certificate, emailAddress = ...

---
No client certificate CA names sent
Peer signing digest: SHA256
Peer signature type: RSA-PSS
Server Temp Key: X25519, 253 bits
---
SSL handshake has read 1609 bytes and written 279 bytes
Verification: OK
---
New, TLSv1.3, Cipher is TLS_AES_128_GCM_SHA256
Server public key is 2048 bit
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
Early data was not sent
Verify return code: 0 (ok)
---
---
Post-Handshake New Session Ticket arrived:
SSL-Session:
    Protocol  : TLSv1.3
    Cipher    : TLS_AES_128_GCM_SHA256
...
    Start Time: 1592492726
    Timeout   : 7200 (sec)
    Verify return code: 0 (ok)
    Extended master secret: no
    Max Early Data: 0
---
read R BLOCK

HTTP/1.1 400 Bad Request
Content-Type: text/plain; charset=utf-8
Connection: close

400 Bad Requestclosed
```

For Firefox, I had to convert the `crt` file into a `pfx` file:
```shell
openssl pkcs12 -export -out localhost_rootCA.pfx -inkey localhost_rootCA.key -in localhost_rootCA.crt
Enter pass phrase for localhost_rootCA.key: ...
Enter Export Password: ...
Verifying - Enter Export Password: ...
```

Then import this into Firefox in `about:preferences#privacy` -> Certificates

I still receive a self-signed exception (`MOZILLA_PKIX_ERROR_SELF_SIGNED_CERT`)
and have to add it as an exception to continue.

