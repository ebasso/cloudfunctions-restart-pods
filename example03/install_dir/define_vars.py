import sys,os

def main(dict):
    if dict['IBMCLOUD_OC_CONSOLE']:
        print(dict['IBMCLOUD_OC_CONSOLE'])
        os.environ['IBMCLOUD_OC_CONSOLE'] = dict['IBMCLOUD_OC_CONSOLE']

    if dict['IBMCLOUD_OC_TOKEN']:    
        os.environ['IBMCLOUD_OC_TOKEN'] = dict['IBMCLOUD_OC_TOKEN']

    if dict['IBMCLOUD_OC_PROJECT']:
        os.environ['IBMCLOUD_OC_PROJECT'] = dict['IBMCLOUD_OC_PROJECT']

    if dict['RESTART_PODS']:
        os.environ['RESTART_PODS'] = dict['RESTART_PODS']
    
    if dict['SLEEP_TIME']:
        os.environ['SLEEP_TIME'] = dict['SLEEP_TIME']

    return { 'result' : 'sucesso' } 