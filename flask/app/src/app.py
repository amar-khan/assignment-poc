import os
import logging
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return '<html><body><p>Hello,Welcome to <b>bitwala World!</b></p></body></html>'

@app.route('/actuator/health')
def health_check():
    return '200 OK'

logging.basicConfig(filename='/var/log/app.log', level=logging.DEBUG, format=f'%(asctime)s %(levelname)s %(name)s %(threadName)s : %(message)s')

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(debug=True,host='0.0.0.0',port=port)
