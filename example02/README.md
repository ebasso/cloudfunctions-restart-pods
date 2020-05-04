Example 02 - Using a manifest file to deploy
===========================

# hello.js 

Create action using NodeJs example

```sh
$ ibmcloud fn deploy --manifest hello_js_manifest.yml
```

List the actions by using the following command.

```sh
$ ibmcloud fn action list

actions
/<GUID>/example02/hello-js               private nodejs:10
```

List the APIs by using the following command.

```bash
$ ibmcloud fn api list -f

ok: APIs

Action: /<GUID>/example02/hello-js
   API Name: hello-world
   Base path: /hello
   Path: /world
   Verb: get
   URL: https://service.us.apiconnect.ibmcloud.com/gws/apigateway/api/.../hello/world
```

Invoke the api using curl or copy and paste url on your browser

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


# hello2.js 

Create action using NodeJs example

```sh
$ ibmcloud fn deploy --manifest hello2_js_manifest.yml
```

