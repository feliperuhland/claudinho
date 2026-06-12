IMAGE := claudinho-code

build:
	docker build -t $(IMAGE) .

run:
	docker run -it --rm $(IMAGE)

.PHONY: build run
