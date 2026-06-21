IMAGE := claudinho-code

build:
	docker build -t $(IMAGE) .

run:
	docker run -it --rm -v $(PWD):/home/ubuntu/workspace $(IMAGE)

install:
	install -m 755 claudinho /usr/local/bin/claudinho

.PHONY: build run install
