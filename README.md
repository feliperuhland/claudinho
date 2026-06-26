# claudinho

A wrapper script that runs [Claude Code](https://claude.ai/code) inside a persistent Docker container, scoped per working directory. Your project files and Claude config are mounted in, so the experience is identical to running Claude Code locally — but isolated and reproducible.

## How it works

Each directory gets its own named container (`claudinho-<hash-of-path>`). On subsequent runs the container is reattached instead of recreated, preserving Claude's session state. If a newer image is available, the container is automatically replaced.

## Requirements

- Docker
- A valid Claude Code installation on the host (for `~/.claude` and `~/.claude.json`)

## Installation

### From source

```bash
git clone https://github.com/feliperuhland/claudinho
cd claudinho
make build
sudo make install   # copies claudinho to /usr/local/bin
```

### Pre-built image

```bash
docker pull ghcr.io/feliperuhland/claudinho-code:latest
```

Then copy the `claudinho` script to somewhere on your `PATH`.

## Usage

```bash
cd /your/project
claudinho
```

That's it. Claude Code starts inside a container with your project mounted at `/home/ubuntu/workspace`.

To pass arguments directly to `claude`:

```bash
claudinho --dangerously-skip-permissions
```

## What's in the image

| Tool | Purpose |
|------|---------|
| Ubuntu 26.04 | Base OS |
| Claude Code CLI | `claude` — the AI coding assistant |
| uv | Fast Python package manager |
| git, build-essential | Common dev tools |
| ripgrep, fd | Fast file search (used by Claude Code) |

## Mounts

| Host path | Container path | Purpose |
|-----------|---------------|---------|
| `$PWD` | `/home/ubuntu/workspace` | Your project files |
| `~/.claude` | `/home/ubuntu/.claude` | Claude config, memory, settings |
| `~/.claude.json` | `/home/ubuntu/.claude.json` | Claude auth token |

## Building locally

```bash
make build   # builds claudinho-code:latest
make run     # one-shot run (no persistent container)
```

## Image updates

When `claudinho` runs, it attempts `docker pull`. If a newer image was downloaded, the existing container is stopped, removed, and recreated on the next invocation.

## License

MIT
