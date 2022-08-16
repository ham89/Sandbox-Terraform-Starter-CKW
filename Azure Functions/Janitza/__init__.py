import logging
import requests

import azure.functions as func


def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    
    try:

        url_base= "http://ced-azs6014.ced.intra:8096/janitza"
        url_relative = "/rest/1/projects/GridVis_CKW/devices/119/hist/values/PowerApparent/L2/900/.json?start=UTCNANO_1651183200000000000&end=NAMED_Yesterday"

        header_dic = {'url':url_relative}
        response = requests.get(url_base,headers= header_dic)

        if response.status_code == 200 and 'values' in response.json():
            return func.HttpResponse(
                f"URL read: {url_relative}",
                status_code=200
            )
        else:
            return func.HttpResponse(
                f"URL request error code: {response.status_code}",
                status_code=200
            )
    
    except Exception as e:
        return func.HttpResponse(
                f"Someting went wrong, Error {e}",
                status_code=200
        )

