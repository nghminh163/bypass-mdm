```sh
curl https://raw.githubusercontent.com/nghminh163/bypass-mdm/main/test2.sh -o test.sh && chmod +x ./test.sh && ./test.sh
```

## Reset pass root
```sh
curl https://raw.githubusercontent.com/nghminh163/bypass-mdm/main/reset-password.sh -o test.sh && chmod +x ./test.sh && ./test.sh
```

# Son 
```sh
dscl -f /Volumes/Data/private/var/db/dslocal/nodes/Default localhost -passwd /Local/Default/Users/root && echo "0.0.0.0 deviceenrollment.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts && echo "0.0.0.0 mdmenrollment.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts && echo "0.0.0.0 iprofiles.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts"
```
