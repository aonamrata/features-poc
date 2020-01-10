"""Connector for Split.io SDK"""
import os

import splitio

# split.io
SPLITIO_API_KEY = os.environ.get('SPLITIO_API_KEY')
SPLIT_CONFIG = {
    'ready': 5000,
}
SPLIT_BLOCK_UNTIL_READY_TIMEOUT = 10



def get_split_factory():
    """Python SDK factory is initialized.

    Returns:
        split_client : split_client object, used to fetch variants
        split_manager: split_manager object, used to fetch
        split(feature details)
    """
    # @todo remove try/except block once split.io is ready
    # for production usage
    factory = splitio.get_factory(
        SPLITIO_API_KEY, config=SPLIT_CONFIG)
    factory.block_until_ready(SPLIT_BLOCK_UNTIL_READY_TIMEOUT)
    split_client = factory.client()

    return split_client


split_client = get_split_factory()
