# Stoken in Docker

## RSA Tokens with Stoken and Docker

The following is documentation will walk you through:

- Storing and Retrieving your RSA TOKEN and PIN to the macOS keychain.
- Generating and Using the `.stokenrc` files
- Creating `stoken` Docker Images
- Basics of generating a `tokencode`
- Creating a wrapper function to streamline `tokencode` generation

**Notes:**
- https://www.systutorials.com/docs/linux/man/1-stoken/

### Working with the macOS Keychain

#### Add Secrets to Keychain

**Token**

```
security add-generic-password -a "${USER}" -s "RSA_TOKEN_XT" -w
```

**PIN**

```
security add-generic-password -a "${USER}" -s "RSA_PIN_XT" -w
```

#### Retreive Secret from Keychain

#### Token

```
security find-generic-password -a "${USER}" -s "RSA_TOKEN_XT" -w
```

#### PIN

```
security find-generic-password -a "${USER}" -s "RSA_PIN_XT" -w
```

### Creating the `.stokenrc` file

**Store Token**

```
stoken import --token "${RSA_TOKEN_XT}" --new-password=""
```

**Store Pin**

```
stoken setpin --new-pin="${RSA_PIN_XT}"
```


#### Generating `.stokenrc`

### Build Your Image

In order to build your own custom stoken image, we need to kick off a build

```
RSA_TOKEN="$(security find-generic-password -a "${USER}" -s "RSA_TOKEN_XT" -w)" && \
RSA_PIN="$(security find-generic-password -a "${USER}" -s "RSA_PIN_XT" -w)" && \
docker build \
      --build-arg RSA_TOKEN="$RSA_TOKEN" \
      --build-arg RSA_PIN="$RSA_PIN" \
      --tag stoken \
      --file ./Dockerfile .
```



