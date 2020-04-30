Example 02 - Using a manifest file to deploy
===========================

Create action using NodeJs example

```sh
ibmcloud fn deploy --manifest hello_js_manifest.yml
```

List the actions by using the following command.

```sh
ibmcloud fn action list
```

```
actions
/<GUID>/example02/hello-js               private nodejs:10
```

List the APIs by using the following command.

```bash
ibmcloud fn api list -f
```

Output

```
ok: APIs

Action: /<GUID>/example02/hello-js
   API Name: hello-world
   Base path: /hello
   Path: /world
   Verb: get
   URL: https://service.us.apiconnect.ibmcloud.com/gws/apigateway/api/.../hello/world
```

Invoke the api

```sh
curl URL-FROM-API-LIST-OUTPUT
```

#### About the manifest file

The deployment manifest file defines the following variables.

* The package name.
* The action name.
* The action annotation that indicates it is to be a web action.
* The action code file name.
* The API with a base path of /hello.
* The endpoint path of /world.


#### Source code
The source code for the manifest and JavaScript files can be found here:
- [hello.js](https://github.com/ebasso/ibm-cloudfunctions-examples/blob/master/example02/hello.js)
- [hello_js_manifest.yml](https://github.com/ebasso/ibm-cloudfunctions-examples/blob/master/example02/hello_js_manifest.yml)
