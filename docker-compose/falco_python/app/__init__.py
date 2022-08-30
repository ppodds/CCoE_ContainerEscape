from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from app.routes.index import blueprint
from app.config import Config

db = SQLAlchemy()

def register_blueprints(app):
    app.register_blueprint(blueprint)

def register_extensions(app):
    db.init_app(app)

def configure_database(app):

    @app.before_first_request
    def initialize_database():
        from app.database import model
        db.create_all()

    @app.teardown_request
    def shutdown_session(exception=None):
        db.session.remove()

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    register_blueprints(app)
    register_extensions(app)
    configure_database(app)
    return app