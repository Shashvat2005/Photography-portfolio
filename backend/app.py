# app.py
from flask import Flask, jsonify, send_from_directory, request
from flask_cors import CORS
import os
from urllib.parse import quote

# ---- CONFIG ----
IMAGE_FOLDER = "/Users/shashvatgarg/Desktop/Shashvat_Garg/All Pictures/Scenery etc./Best"
ALLOWED_EXTS = (".png", ".jpg", ".jpeg", ".webp", ".gif")
PORT = 8080

app = Flask(__name__, static_folder=None)

# Allow your GitHub Pages origin (replace with your actual pages URL)
# Example: "https://shashvatgarg.github.io"
CORS(app, resources={
    r"/photos": {"origins": "*"},
    r"/images/*": {"origins": "*"},
})

def list_image_files():
    if not os.path.isdir(IMAGE_FOLDER):
        return []
    files = []
    for f in os.listdir(IMAGE_FOLDER):
        if f.lower().endswith(ALLOWED_EXTS) and os.path.isfile(os.path.join(IMAGE_FOLDER, f)):
            files.append(f)
    return sorted(files)

@app.route("/health")
def health():
    return "ok", 200

@app.route("/photos")
def photos():
    files = list_image_files()
    # This will be the public host if you access via tunnel (ngrok/Cloudflare), or your LAN IP otherwise
    base = request.host_url.rstrip("/")
    urls = [f"{base}/images/{quote(f)}" for f in files]
    return jsonify({"count": len(urls), "photos": urls})

@app.route("/images/<path:filename>")
def serve_image(filename):
    # Add long cache + ETag/conditional support
    return send_from_directory(
        IMAGE_FOLDER, filename, etag=True, conditional=True, cache_timeout=86400
    )

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=PORT, debug=True)
