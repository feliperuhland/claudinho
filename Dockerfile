FROM ubuntu:26.04

ARG USERNAME=ubuntu

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --no-install-recommends \
  curl \
  ca-certificates \
  git \
  build-essential \
  python3 \
  ripgrep \
  fd-find \
  && apt-get clean

USER $USERNAME

RUN curl -fsSL https://claude.ai/install.sh -o /tmp/claude-install.sh \
    && bash /tmp/claude-install.sh \
    && rm /tmp/claude-install.sh

RUN curl -LsSf https://astral.sh/uv/install.sh -o /tmp/uv-install.sh \
    && sh /tmp/uv-install.sh \
    && rm /tmp/uv-install.sh

ENV PATH="/home/${USERNAME}/.local/bin:${PATH}"

WORKDIR /home/${USERNAME}/workspace

ENTRYPOINT ["claude"]
