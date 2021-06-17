import split_connector


def get_split_feature(traffic_type, split_name, attributes):
    """ Get active variant for split (feature)"""
    return split_connector.get_split_client().get_treatment(
        traffic_type, split_name, attributes)
