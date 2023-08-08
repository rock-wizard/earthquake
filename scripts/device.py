from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/deviceStatus', methods=['GET'])
def get_device_status():
    return jsonify({
        "deviceName": "router",
        "deviceStatus": "unavailable"
    })

if __name__ == '__main__':
    app.run(port=5000)
