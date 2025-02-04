from flask import Flask
from taipy.gui import Gui

# Create a minimal Flask application
app = Flask(__name__)

# Define a simple route for testing
@app.route("/")
def hello():
    return "Hello, World! Welcome to Taipy Flask!"

# Integrate Taipy if you need to use any of its advanced features:
gui = Gui(app=app)

if __name__ == "__main__":
    # Run on host '0.0.0.0' to be accessible from outside the container on port 3500
    app.run(host="0.0.0.0", port=3500, debug=True)