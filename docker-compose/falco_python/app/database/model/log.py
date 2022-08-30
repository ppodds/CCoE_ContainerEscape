from app import db

class Log(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    container = db.Column(db.String(255), nullable=False)
    syscall = db.Column(db.String(255), nullable=False)
    process = db.Column(db.String(15), nullable=False)
    timestamp = db.Column(db.DateTime, nullable=False)

    def __init__(self, container, syscall, process, timestamp):
        self.container = container
        self.syscall = syscall
        self.process = process
        self.timestamp = timestamp

    def __repr__(self) -> str:
        return f'<Log {self.id} {self.container} {self.syscall} {self.process} {self.timestamp}>'
