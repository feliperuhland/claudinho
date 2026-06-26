IMAGE := ghcr.io/feliperuhland/claudinho-code
PWD_HASH := $(shell printf '%s' "$(CURDIR)" | sha256sum | cut -c1-12)
CONTAINER_NAME := claudinho-$(PWD_HASH)

build:
	docker build -t $(IMAGE) .

run:
	docker run -it --rm \
		--name "$(CONTAINER_NAME)" \
		--security-opt no-new-privileges \
		--memory=4g \
		--pids-limit=512 \
		-v "$(CURDIR):/home/ubuntu/workspace" \
		-v "$(HOME)/.claude:/home/ubuntu/.claude" \
		-v "$(HOME)/.claude.json:/home/ubuntu/.claude.json:ro" \
		$(IMAGE) claude

install:
	install -m 755 claudinho /usr/local/bin/claudinho

.PHONY: build run install
