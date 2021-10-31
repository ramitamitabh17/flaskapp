from flask import Flask, request
import json
import urllib.request
import os
from app.mods import *




app = Flask(__name__)

@app.route("/")
def index():
    return "Hello Stranger!!!"

@app.route("/helloworld")
def helloworld():
    if request.args:

        # We have our query string nicely serialized as a Python dictionary
        args = request.args

        # We'll create a string to display the parameters & values
        serialized = ", ".join(f"{v}" for k, v in request.args.items())
        out = camel_case_split(serialized)

        # Display the query string to the client in a different format
        return "Hello " + " ".join(out)

    else:
        return "Hello Stranger!", 200


@app.route("/versionz")
def versionz():

    url = "https://api.github.com/repos/ramitamitabh17/gryphon-task"
    url1 = "https://api.github.com/repos/ramitamitabh17/gryphon-task/commits/main"


    response = urllib.request.urlopen(url)
    data = response.read()
    dict = json.loads(data)

    response1 = urllib.request.urlopen(url1)
    data1 = response1.read()
    dict1 = json.loads(data1)

    dict2 = {
      "Repository Name" : dict["full_name"],
      "Git Hash" : dict1["sha"]
    }

    #result = json.loads(dict2)

    return dict2
