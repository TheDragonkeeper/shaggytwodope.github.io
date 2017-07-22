.PHONY: build

all: build

build:
	mkdir ./output || true
	./poole.py --build

clean:
	rm -rf ./output/ || true
	rm *.pyc || true
