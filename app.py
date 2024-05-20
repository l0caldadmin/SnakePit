from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/proxy')
def proxy_dashboard():
    # We'll add logic to interact with proxy.py here later
    return render_template('proxy.html')

if __name__ == '__main__':
    app.run(debug=True)