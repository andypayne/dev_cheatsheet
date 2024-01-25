# OpenSSL Notes


## Show basic certificate info on Windows/Powershell

```
dir .\some_certificate_file.crt | %{ $cert = New-Object Security.Cryptography.X509Certificates.X509Certificate2 $_.FullName; echo $cert | Format-List }
```


## Check the expiration date of a certificate on Windows/Powershell

```
dir .\some_certificate_file.crt | %{ $cert = New-Object Security.Cryptography.X509Certificates.X509Certificate2 $_.FullName; echo $cert.NotAfter }
```


## Connect to a PostgreSQL Server and show server certificate info

```
openssl s_client -starttls postgres -connect localhost:5432 -showcerts
```


