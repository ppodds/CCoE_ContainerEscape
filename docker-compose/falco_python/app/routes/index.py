from app.routes import blueprint
from flask import request, current_app
import json
from datetime import datetime
from app.database.model import Log
from app import db

@blueprint.route('/', methods=['POST']) 
def index():
    data = request.get_json()
    current_app.logger.info(json.dumps(data))

    db.session.add(Log(data['output_fields']['container.name'], data['output_fields']['syscall.type'], data['output_fields']['proc.name'], datetime.fromisoformat(str(data['time'][:26]))))
    db.session.commit()

    return "Hello"