import os
import json
import uuid
import requests

import azure.functions as func

def main(req: func.HttpRequest) -> func.HttpResponse:

    key = "****"
    endpoint = "https://api.cognitive.microsofttranslator.com"

    # Add your location, also known as region. The default is global.
    # This is required if using a Cognitive Services resource.
    location = "westeurope"

    path = '/translate'
    constructed_url = endpoint + path

    params = {
        'api-version': '3.0',
        'from': 'en',
        'to': ['fr', 'zu']
    }

    headers = {
    'Ocp-Apim-Subscription-Key': key,
    'Content-type': 'application/json',
    'X-ClientTraceId': str(uuid.uuid4())
    }

    # You can pass more than one object in body.
    body = [{
        'text': 'I would really like to drive your car around the block a few times!'
    }]

    request = requests.post(constructed_url, params=params, headers=headers, json=body)
    response = request.json()

    print(json.dumps(response, sort_keys=True, ensure_ascii=False, indent=4, separators=(',', ': ')))