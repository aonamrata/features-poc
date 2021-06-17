import split_model
from application import app


@app.route("/")
def hello():
    return "Hello, World!"


@app.route("/feature/<feature_name>")
def get_single_feature(feature_name):
    traffic_type = 'user'
    split_name = feature_name
    attributes = {}
    return split_model.get_split_feature(traffic_type, split_name, attributes)

@app.route("/feature/<feature_name>/user/<user_id>")
def get_single_user_feature(feature_name, user_id):
    traffic_type = 'user'
    split_name = feature_name
    attributes = {'user_id': user_id}
    return split_model.get_split_feature(traffic_type, split_name, attributes)
