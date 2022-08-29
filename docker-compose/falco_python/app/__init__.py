from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from routes.index import blueprint

db = SQLAlchemy()

def register_blueprints(app):
    app.register_blueprint(blueprint)

def register_extensions(app):
    db.init_app(app)

def configure_database(app):

    @app.before_first_request
    def initialize_database():
        db.create_all()

    @app.teardown_request
    def shutdown_session(exception=None):
        db.session.remove()

def create_app(config):
    app = Flask(__name__)
    app.config.from_object(config)
    register_blueprints(app)
    register_extensions(app)
    configure_database(app)
    return app