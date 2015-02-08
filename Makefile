all: coffeescript

run: all
	python server.py

coffeescript:
	./makeCoffeescript.sh
