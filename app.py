from flask import Flask, render_template, request, redirect 
import datetime

#Give me the tools I need to build a web app

app = Flask(__name__)

#Creates web application

entries = []

@app.route('/', methods=['GET', 'POST'])
def index():
#this def index runs every time someone visits the site
    if request.method == 'POST':
        emotion = request.form['emotion']
        note = request.form['note']

        entries.append({
            'emotion': emotion,
            'note': note,
            'time' : datetime.datetime.now()
        
        })

        return redirect('/')
    #without redirect the browser would stay on a POST request and if 
    #the user refreshes the browser would resend the POST duplicating the data

    return render_template('index.html', entries=entries)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

    #0.0.0.0 listens on ALL networks rather than the default IP to 
    #ensure that it listens on all network interfaces, this is required
    #for containerised app env such as Docker and K8s where external
    #access to application is necessary.

