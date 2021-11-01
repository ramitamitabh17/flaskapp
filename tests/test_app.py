from app.app import app
import pytest




def test_hello():
    response = app.test_client().get('/')

    assert response.status_code == 200
    assert response.data == b'Hello Stranger V2!!!'

def test_hello1():
    response = app.test_client().get('/helloworld')
    assert response.status_code == 200
    assert response.data == b'Hello Stranger!'

def test_hello2():
    response = app.test_client().get('/versionz')
    assert response.status_code == 200
