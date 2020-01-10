from split_connector import split_client


def get_split_feature(traffic_type, split_name, attributes):
    """ Get active variant for split (feature)
        @todo remove following points once split.io is ready
        for production usage
        1)if split factory is initialized, call split_client's
        get_treatment method and return split response
        2)if split factory is not initialized return "control",
        so that we fallback on features.yml for response
        3)if split factory is initialized and error in calling
        split client, return 500 response as split is not working

    Args:
        traffic_type(str): identifier type for any hierarchy of users
        split_name(str): feature name
        attributes(dict): parameter to filter features based on split rules
            eg: {'user_id': 'oa:562'}, {'user_id': 'alw:46997'},
            {'vendor_id': 23904}, {'identity_id': '5c548bd462501638ea3ed444'}
    Returns:
        Response: active variant eg: on, off, control(incase of error)
    """
    return split_client.get_treatment(
        traffic_type, split_name, attributes)
