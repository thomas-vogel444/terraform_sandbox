from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "I am the walrus! And I am awesome..."

@app.route("/ping")
def ping():
    return "It's working!"

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0',port=5000)