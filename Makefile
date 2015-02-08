all: coffeescript

run: all
	python server.py

coffeescript:
	cat html/*.coffee | coffee -scb > html/scripts.js
