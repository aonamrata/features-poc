"""Connector for Split.io SDK"""
import os
import logging
import splitio
import uwsgi  # noqa
from uwsgidecorators import postfork  # Step 1
logging.basicConfig(level=logging.DEBUG)


SPLITIO_API_KEY = os.environ.get('SPLITIO_API_KEY')

factory = splitio.get_factory(
    SPLITIO_API_KEY,
    config={
        'preforkedInitialization': True,  # Step 2
        'ready': 5000,
    },
)


@postfork # Step 3
def post_fork_execution():
    factory.resume()  # Step 4
    factory.block_until_ready(10)


def get_split_client():
    return factory.client()
