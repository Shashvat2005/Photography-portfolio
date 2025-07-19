from flask import Flask, send_from_directory, jsonify
from flask_cors import CORS
import os

app = Flask(__name__)
CORS(app)

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
PHOTO_DIR = os.path.join(BASE_DIR, 'static')

@app.route('/photos')
def list_photos():
    try:
        files = os.listdir(PHOTO_DIR)
        print("Files found:", files)
        photos_data = []

        for f in files:
            if f.lower().endswith(('.jpg', '.jpeg', '.png')):
                photos_data.append({
                    'url': f'/photo/{f}',
                    'metadata': {}
                })

        return jsonify(photos_data)

    except Exception as e:
        print("Error:", e)
        return jsonify({"error": str(e)}), 500

@app.route('/photo/<filename>')
def serve_photo(filename):
    return send_from_directory(PHOTO_DIR, filename)

if __name__ == '__main__':
    app.run(port=5000)
