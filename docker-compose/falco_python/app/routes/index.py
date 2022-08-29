from app.routes import blueprint
from flask import request, current_app
import json
from datetime import datetime, timedelta

@blueprint.route('/', methods=['POST']) 
def index():
    data = request.get_json()
    current_app.logger.info(json.dumps(data))

    #解析Falco傳過來的資訊（process PID, 時間戳記, 出問題的container IP）
    # falco_process_id = str(data['output_fields']['proc.ppid'])
    falco_time_stp = datetime.fromisoformat(str(data['time'][:26])) + timedelta(hours=8) #改成UTC+8
    falco_container_name = str(data['output_fields']['container.name'])

    return "Hello"