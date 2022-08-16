import logging
import requests

import azure.functions as func


def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    
    try:

        response = requests.get("https://api.publicapis.org/entries")

        if response.status_code == 200 and 'values' in response.json():
            return func.HttpResponse(
                f"URL OK",
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

