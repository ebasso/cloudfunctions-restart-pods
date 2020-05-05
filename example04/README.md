
# Using a Zip File

Zip the files 

```sh
zip -r example04.zip __main__.py helper.py
```

Deploying application using manifest.yaml

```sh
ibmcloud fn deploy --manifest manifest.yaml
```

Deploying application using manifest.yaml

```sh
ibmcloud fn action create example04/helper example04.zip --kind python:3.7
```

Run and get logs

```bash
$ ibmcloud fn action invoke example04/helper --result
```



