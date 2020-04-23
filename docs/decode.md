# Decode

```
tar -xvf {{file}}
cd {{dir}}
openssl rsautl -decrypt -inkey {{path to private_key.pem}} -in key.bin.enc -out key.bin
openssl enc -d -aes-256-cbc -in {{encrypted file (xxx.enc)}} -out {{decrypt file}} -pass file:key.bin
```
