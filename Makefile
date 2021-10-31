VENV = env
PYTHON = $(VENV)/bin/python
PIP = $(VENV)/bin/pip

run:
	. $(VENV)/Scripts/activate
	python run.py

test: testing
	pytest


setup: requirements.txt
	python -m venv $(VENV)
	. $(VENV)/Scripts/activate
	pip install -r requirements.txt


clean:
	rm -rf __pycache__
	rm -rf $(VENV)
