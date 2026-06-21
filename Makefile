IMAGE := claudinho-code

build:
	docker build -t $(IMAGE) .

run:
	docker run -it --rm --name "$CONTAINER_NAME" -v "${PWD}:/home/ubuntu/workspace" -v "${HOME}/.claude:/home/ubuntu/.claude" -v "${HOME}/.claude.json:/home/ubuntu/.claude.json" $(IMAGE) claude

install:
	install -m 755 claudinho /usr/local/bin/claudinho

.PHONY: build run install
