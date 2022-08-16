from azure.storage.blob import BlobServiceClient

from itertools import tee



#VNZR

STORAGEACCOUNTNAME = 'lake0ci0netz0dev'

STORAGEACCOUNTKEY = 'AGxapljoYWJtT55NKSL13b9y6mINf7ugGrtughR7ZSl8KRZ3qvzWqUsryzvKMYhyLzCV2tDoo62IFEBY42Dceg=='

CONTAINERNAME = "persisted"

BLOBNAME = "persisted/2016-12_test.csv"






STORAGEACCOUNTURL = f"https://{STORAGEACCOUNTNAME}.blob.core.windows.net"

#STORAGEACCOUNTURL = f"https://{STORAGEACCOUNTNAME}.file.core.windows.net"



credential={

    "account_name": STORAGEACCOUNTNAME,

    "account_key": STORAGEACCOUNTKEY

}



blob_service_client_instance = BlobServiceClient(

    account_url=STORAGEACCOUNTURL, credential=credential)



#container_client = blob_service_client_instance.create_container(name=CONTAINERNAME)



list = blob_service_client_instance.list_containers()



result, result_backup = tee(list)

for i, r in enumerate(result):

    print(r)