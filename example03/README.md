Example 03 - List and Delete pods on OpenShift
===========================

In below examples, we will deploy IBM Cloud Functions using a manifest.yaml file.

Sample manifest.yaml file

```yaml
packages:
  OpenshiftFnPkgTools:
    version: 1.0
    license: Apache-2.0
    actions:
      list-pods-in-namespace:
        function: list-pods.py
        inputs:
          IBMCLOUD_OC_CONSOLE: https://c101-e.us-south.containers.cloud.ibm.com:NNNNN
          IBMCLOUD_OC_TOKEN: XXXXXX-XXXXX-XXXXXX
          IBMCLOUD_OC_PROJECT: YYYYYY
          APIKEY: ZZZZZ
      delete-pods-in-namespace:
        function: delete-pods.py
        inputs:
          IBMCLOUD_OC_CONSOLE: https://c101-e.us-south.containers.cloud.ibm.com:NNNNN
          IBMCLOUD_OC_TOKEN: XXXXXX-XXXXX-XXXXXX
          IBMCLOUD_OC_PROJECT: YYYYYY
          APIKEY: ZZZZZ
```
The deployment manifest file defines the following variables.

* The package name.
* The action name.
* The action code file name.
* The action parameters

Create action using manifest.yaml

```sh
$ cd example03

$ ibmcloud fn deploy --manifest manifest.yaml

Success: Deployment completed successfully.
```

Change variables on IBM Cloud Console


* IBMCLOUD_OC_TOKEN:  token to authenticate against OpenShift on IBM Cloud.
* IBMCLOUD_OC_CONSOLE:  url to OpenShift on IBM Cloud.
* IBMCLOUD_OC_PROJECT:  need to define project on OpenShift.
