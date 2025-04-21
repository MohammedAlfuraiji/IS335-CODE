# app.py
from flask import Flask, request, jsonify
from ride_services import request_ride, accept_ride

app = Flask(__name__)

@app.route('/api/rides', methods=['POST'])
def create_ride():
    data = request.get_json()
    try:
        result = request_ride(
            rider_id=data['rider_id'],
            pickup_loc_id=data['pickup_location_id'],
            dropoff_loc_id=data['dropoff_location_id'],
            ride_type=data.get('ride_type', 'economy')
        )
        return jsonify(result), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 400

@app.route('/api/rides/<int:ride_id>/accept', methods=['POST'])
def accept_ride_endpoint(ride_id):
    data = request.get_json()
    try:
        result = accept_ride(
            driver_id=data['driver_id'],
            ride_id=ride_id
        )
        return jsonify(result), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000 , debug=True)
