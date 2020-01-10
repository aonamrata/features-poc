import split_model
from application import app


@app.route("/")
def hello():
    return {"greetings": "Hello, World!"}


@app.route("/feature/<feature_name>")
def get_single_feature(feature_name):
    traffic_type = 'user'
    split_name = feature_name
    attributes = {}  # {'user_id': 'alw:123'}  # for testing
    return split_model.get_split_feature(traffic_type, split_name, attributes)
