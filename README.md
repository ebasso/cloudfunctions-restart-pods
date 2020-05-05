
IBM Cloud Functions Examples
===========================

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)


Multiples examples of IBM Cloud Functions. You can use this template to deploy some IBM Cloud Functions assets for you.

# Available examples

* [Example 01 - Hello World using NodeJs and Python](https://github.com/ebasso/ibm-cloudfunctions-examples/tree/master/example01)
* [Example 02 - Using a manifest file to deploy](https://github.com/ebasso/ibm-cloudfunctions-examples/tree/master/example02)
* Draft [Example 03 - Using IBM Cloud Functions to Restart Pods on Openshift](https://github.com/ebasso/ibm-cloudfunctions-examples/tree/master/example03)
* [Example 04 - Deploy using a Zip file](https://github.com/ebasso/ibm-cloudfunctions-examples/tree/master/example04)


# Cloning Repository

Clone the repository

```bash
git clone https://github.com/ebasso/ibm-cloudfunctions-examples.git
```


# Login in on IBM Cloud


```bash
$ ibmcloud login --sso

Terminal de API: https://cloud.ibm.com
Região: us-south

Obtenha um código de uso único de https://identity-2.uk-south.iam.cloud.ibm.com/identity/passcode para continuar.
Abrir a URL no navegador padrão? [Y/n] >
One Time Code >
```

Do the login using Browser and paste the One Time Code.

```bash
Authenticating...
OK

Selecione uma conta:
1. ebasso_COMPANY.COM (f..............................5)
2. Company B S.A. (d..............................3) <-> 1.....3
4. Company Y Corp (1..............................5) <-> 3.....0
Insert a number> 1
Target account ebasso_COMPANY.COM (f..............................5)
```


#### Target a namespace

Make sure to target this namespace's resource group with ibmcloud target -g [name of resource group]
You can list available resource groups using the command ibmcloud resource groups

In my case:

```bash
$ ibmcloud target -o ebasso_COMPANY.COM -g default

API endpoint:      https://cloud.ibm.com
Region:            us-south
User:              ebassoAtCompany.com
Account:           ebasso_COMPANY.COM (f..............................5)
Resource group:    No resource group targeted, use 'ibmcloud target -g RESOURCE_GROUP'
CF API endpoint:   https://api.us-south.cf.cloud.ibm.com (API version: 2.147.0)
Org:               ebassoAtCompany.com
Space:             
```


#### Create a namespace

```bash
$ ibmcloud fn namespace create cloudfunctions-dev

ok: created namespace cloudfunctions-dev
```

#### Listing the namespace

```bash
$ ibmcloud fn namespace list

name                     type            id                                    description
cloudfunctions-dev       IAM-based       XXXXXXXX-XXXX-XXXX-XXXX-844dc90ae28X
ebassoAtCompany.com_dev  CF-based        ebassoAtCompany.com_dev
```

#### Preparing to our examples

```bash
$ ibmcloud fn property set --namespace cloudfunctions-dev

ok: whisk namespace set to cloudfunctions-dev
```
 

**Now you can Click on examples to how to deploy**.


