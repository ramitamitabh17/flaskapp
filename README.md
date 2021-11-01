# Flaskapp

This is a Demo flask app, whose build and deployment has been automated with AWS CodeBuild and AWS CodeDeploy.
* App link: [flaskapp](http://flaskapp-lb-1873731349.us-east-2.elb.amazonaws.com/)

## Application Routes

The app has three main routes:

* / - This is the index route
![index](https://drive.google.com/file/d/1KokxSs5P_jLy1qJ3ucBdjlasVlc9Fna0/view?usp=sharing)
* /helloworld - This route serves a request for a Stranger, this also has a query string parameter ?name=
![helloworld](https://drive.google.com/file/d/1euYamSdFPAFkWlqyaWT--jQ7zInrtjRN/view?usp=sharing)
* ?name= - This query parameter serves request for Camel Case queries
![querystring](https://drive.google.com/file/d/1tDjSNP72M3c0jh9OE9HP40MwcnY-cBq_/view?usp=sharing)
* /versionz - shows the current git hash of this app

## Command Line Options

* --host - to change the host the app is running on
* --debug - to change the debug mode of the app
* --port - to change the running port of the app







