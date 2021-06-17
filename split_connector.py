"""Connector for Split.io SDK"""
import os
import logging
import splitio
import uwsgi  # noqa
from uwsgidecorators import postfork  # Step 1
logging.basicConfig(level=logging.DEBUG)


SPLITIO_API_KEY = os.environ.get('SPLITIO_API_KEY')
print("*** Creating split factory")
factory = splitio.get_factory(
    SPLITIO_API_KEY,
    config={
        # 'preforkedInitialization': True,  # Step 2
        'ready': 5000,
    },
)
factory.block_until_ready(10)
print("*** Created split factory")

@postfork # Step 3
def post_fork_execution():
    print("*** In post_fork_execution")
    factory.resume()  # Step 4
    factory.block_until_ready(10)
    print("*** Factory is ready")

def get_split_client():
    print("*** In get_split_client")
    return factory.client()
