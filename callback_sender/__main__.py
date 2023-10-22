import datetime
import json
import logging
import time
import requests
from local_extensions import db_methods

while True:
    callbacks_to_send = db_methods.callback.callback_send_log.get_all_to_send()
    for record_id, url, payload in callbacks_to_send:
        resp = requests.post(url, json=json.loads(payload))
        try:
            resp_data = json.dumps(resp.json())
        except Exception as e:
            logging.error('cant decode answer from json')
            resp_data = resp.text
        db_methods.callback.callback_send_log.update_as_sent(record_id, resp_data, datetime.datetime.now())
        time.sleep(0.5)
    time.sleep(1)


