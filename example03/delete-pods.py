import requests, json
from requests.auth import HTTPBasicAuth
from requests.packages.urllib3.exceptions import InsecureRequestWarning

# Disable Warnings from Untrusted TLS keys
requests.packages.urllib3.disable_warnings(InsecureRequestWarning)

class App(object):
    
    def __init__(self, url, apikey,token):
        self.url = url
        self.apikey = apikey
        self.token = token
        self.iam_access_token = None
        
        
    def __doPost(self, url, data, headers=None, auth=None):
        try:
            r = requests.post(url=url, headers=None,  data=data, auth=auth, verify=False)

            if (r.status_code != 200):
                print('requests.get -> %s = %s\n' % (r.url, r))
                return None
            return r.content
        except requests.exceptions.RequestException as e:
            print(url, e)
            return None

    def __doGet(self, url, data, headers=None, auth=None):

        try:
            r = requests.get(url=url, headers=None, auth=auth, verify=False)
            #print('doGet')
            print(r)

            if (r.status_code != 200):
                print('requests.get -> %s = %s\n' % (r.url, r))
                return None
            return r.content
        except requests.exceptions.RequestException as e:
            print(url, e)
            return None

    def getIAMToken(self):
        url = 'https://iam.cloud.ibm.com/identity/token'
        headers = { 'Content-Type': 'application/x-www-form-urlencoded', 'Accept': 'application/json'}
        form =  { 'grant_type': 'urn:ibm:params:oauth:grant-type:apikey',
                  'apikey': self.apikey}

        r = requests.post(url, headers=headers,  data=form, verify=False) .json()
        #print(r)

        if ( r['access_token'] ):
            self.iam_access_token = r['access_token']

    def getAllPodsInNamespace(self,namespace):
        '''
        curl -k -H "Authorization: Bearer $TOKEN" -H 'Accept: application/json' \
            https://$ENDPOINT/api/v1/namespaces/$NAMESPACE/pods
        '''
        #authorization = 'Bearer %s' % self.iam_access_token
        authorization = 'Bearer %s' % self.token
        headers = {'Content-type': 'application/json', 'Accept': 'application/json', 'Authorization' : authorization }
        url=self.url + '/api/v1/namespaces/' + namespace + '/pods'

        #print('url='+ url )
        r = requests.get(url=url, headers=headers, verify=False)
        #print ('Response: ',r.status_code, ' - ', r.json())
        #print (r.json())
        return r.json()

    def deleteAllPodsInNamespace(self,namespace):
        '''
        curl -k -X DELETE -H "Authorization: Bearer $TOKEN" -H 'Accept: application/json' \
            https://$ENDPOINT/api/v1/namespaces/$NAMESPACE/pods
        '''
        #authorization = 'Bearer %s' % self.iam_access_token
        authorization = 'Bearer %s' % self.token
        headers = {'Content-type': 'application/json', 'Accept': 'application/json', 'Authorization' : authorization }
        url=self.url + '/api/v1/namespaces/' + namespace + '/pods'

        #print('url='+ url )
        r = requests.delete(url=url, headers=headers, verify=False)
        print ('Response: ',r.status_code, ' - ', r.json())
        
        
def main(params):
    
    app = App(params['IBMCLOUD_OC_CONSOLE'],params['APIKEY'],params['IBMCLOUD_OC_TOKEN'])

    app.getIAMToken()
    r = app.getAllPodsInNamespace(params['IBMCLOUD_OC_PROJECT'])

    for pod in r['items']:
        print(pod['metadata']['name'])
    #app.deleteAllPodsInNamespace(IBMCLOUD_OC_PROJECT)
    
    return { }

'''
if __name__ == '__main__':
    params = {}
    ret = main(params)
    #print (ret)
'''