# Flaskapp

This is a Demo flask app, whose build and deployment has been automated with AWS CodeBuild and AWS CodeDeploy.
[flaskapp](http://flaskapp-lb-1873731349.us-east-2.elb.amazonaws.com/)

## Application Routes

The app has three main routes:

/ - This is the index route
/helloworld - This route serves a request for a Stranger, this also has a query string parameter ?name=
?name= - This query parameter serves request for Camel Case queries
/versionz - shows the current git hash of this app





